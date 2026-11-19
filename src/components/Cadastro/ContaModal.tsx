import { useEffect, useId, useRef, useState } from "react";
import type { ChangeEvent, FormEvent, MouseEvent } from "react";
import { Button } from "../Button/Button";
import {
    CADASTRO_VAZIO,
    SENHA_MINIMA,
    enviarCadastro,
    mascararCpf,
    validarCadastro,
} from "./cadastro";
import type { CampoCadastro, DadosCadastro, ErrosCadastro } from "./cadastro";
import styles from "./ContaModal.module.css";

type Props = {
    open: boolean;
    onClose: () => void;
};

type Status = "editando" | "enviando" | "sucesso";

type ConfigCampo = {
    campo: CampoCadastro;
    label: string;
    type: "text" | "email" | "password";
    autoComplete: string;
    inputMode?: "numeric";
    placeholder?: string;
    maxLength?: number;
    dica?: string;
};

// Ordem dos campos = ordem de foco quando há erro.
const CAMPOS: ConfigCampo[] = [
    { campo: "nome", label: "Nome", type: "text", autoComplete: "name" },
    { campo: "email", label: "E-mail", type: "email", autoComplete: "email" },
    {
        campo: "cpf",
        label: "CPF",
        type: "text",
        autoComplete: "off",
        inputMode: "numeric",
        placeholder: "000.000.000-00",
        maxLength: 14,
    },
    {
        campo: "senha",
        label: "Senha",
        type: "password",
        autoComplete: "new-password",
        dica: `Mínimo de ${SENHA_MINIMA} caracteres.`,
    },
    { campo: "confirmacao", label: "Confirmar senha", type: "password", autoComplete: "new-password" },
];

function CloseIcon() {
    return (
        <svg width="18" height="18" viewBox="0 0 10 10" shapeRendering="crispEdges" aria-hidden="true">
            <path
                d="M0 0h2v1h1v1h1v1h2v-1h1v-1h1v-1h2v2h-1v1h-1v1h-1v2h1v1h1v1h1v2h-2v-1h-1v-1h-1v-1h-2v1h-1v1h-1v1h-2v-2h1v-1h1v-1h1v-2h-1v-1h-1v-1h-1z"
                fill="currentColor"
            />
        </svg>
    );
}

/**
 * Modal "Criar conta" sobre o <dialog> nativo: o navegador cuida da camada
 * por cima da página, do foco preso dentro dele, do Esc e de devolver o foco
 * ao botão que abriu.
 */
export function ContaModal({ open, onClose }: Props) {
    const dialogRef = useRef<HTMLDialogElement>(null);
    const idBase = useId();
    const [dados, setDados] = useState<DadosCadastro>(CADASTRO_VAZIO);
    const [erros, setErros] = useState<ErrosCadastro>({});
    const [erroGeral, setErroGeral] = useState("");
    const [status, setStatus] = useState<Status>("editando");
    const [mostrarSenha, setMostrarSenha] = useState(false);

    // Cada envio ganha um número; se o modal fechar no meio, a resposta antiga é ignorada.
    const tentativaRef = useRef(0);
    // Campo que deve receber foco depois que os erros aparecerem na tela.
    const focarRef = useRef<CampoCadastro | null>(null);
    // Onde o clique começou (evita fechar ao arrastar uma seleção de texto para fora).
    const inicioCliqueRef = useRef<EventTarget | null>(null);

    const idDe = (campo: CampoCadastro) => `${idBase}-${campo}`;

    // Sincroniza a prop "open" com o <dialog>.
    useEffect(() => {
        const dialog = dialogRef.current;
        if (!dialog) return;
        if (open && !dialog.open) {
            dialog.showModal();
            document.getElementById(`${idBase}-nome`)?.focus();
        } else if (!open && dialog.open) {
            dialog.close();
        }
    }, [open, idBase]);

    // Depois de renderizar os erros, leva o foco ao primeiro campo inválido
    // (assim o leitor de tela já anuncia a mensagem ligada ao campo).
    useEffect(() => {
        if (focarRef.current) {
            document.getElementById(`${idBase}-${focarRef.current}`)?.focus();
            focarRef.current = null;
        }
    }, [erros, idBase]);

    // Evento "close" nativo: dispara no Esc, no clique fora e no botão Fechar.
    function handleClose() {
        tentativaRef.current++;
        setDados(CADASTRO_VAZIO);
        setErros({});
        setErroGeral("");
        setStatus("editando");
        setMostrarSenha(false);
        onClose();
    }

    function fechar() {
        dialogRef.current?.close();
    }

    // Só fecha se o clique (início e fim) foi no próprio <dialog>, ou seja, no fundo escuro.
    function handleMouseDown(e: MouseEvent<HTMLDialogElement>) {
        inicioCliqueRef.current = e.target;
    }

    function handleClick(e: MouseEvent<HTMLDialogElement>) {
        const dialog = e.currentTarget;
        if (e.target === dialog && inicioCliqueRef.current === dialog) {
            fechar();
        }
    }

    function handleChange(campo: CampoCadastro) {
        return (e: ChangeEvent<HTMLInputElement>) => {
            const valor = campo === "cpf" ? mascararCpf(e.target.value) : e.target.value;
            setDados((atual) => ({ ...atual, [campo]: valor }));
            // Some com o erro do campo assim que a pessoa começa a corrigir.
            if (erros[campo]) {
                setErros((atual) => ({ ...atual, [campo]: undefined }));
            }
        };
    }

    async function handleSubmit(e: FormEvent<HTMLFormElement>) {
        e.preventDefault();
        if (status === "enviando") return;

        const novosErros = validarCadastro(dados);
        const primeiroInvalido = CAMPOS.find(({ campo }) => novosErros[campo])?.campo;
        setErroGeral("");
        if (primeiroInvalido) {
            focarRef.current = primeiroInvalido;
            setErros(novosErros);
            return;
        }
        setErros({});

        const tentativa = ++tentativaRef.current;
        setStatus("enviando");
        try {
            await enviarCadastro({ ...dados, nome: dados.nome.trim(), email: dados.email.trim() });
            if (tentativa !== tentativaRef.current) return;
            setStatus("sucesso");
        } catch {
            if (tentativa !== tentativaRef.current) return;
            setStatus("editando");
            setErroGeral("Não foi possível criar a conta. Tente novamente.");
        }
    }

    const tituloId = `${idBase}-titulo`;
    const enviando = status === "enviando";

    return (
        <dialog
            ref={dialogRef}
            className={styles.dialog}
            aria-labelledby={tituloId}
            onClose={handleClose}
            onMouseDown={handleMouseDown}
            onClick={handleClick}
        >
            <div className={styles.conteudo}>
                <div className={styles.topo}>
                    <h2 id={tituloId} className={styles.titulo}>
                        Criar conta
                    </h2>
                    <Button variant="secondary" size="sm" className={styles.fechar} aria-label="Fechar" onClick={fechar}>
                        <CloseIcon />
                    </Button>
                </div>

                {status === "sucesso" ? (
                    <div className={styles.sucesso} role="status">
                        <p>Conta criada com sucesso! Bem-vindo(a), {dados.nome.trim()}.</p>
                        <Button variant="accent" autoFocus onClick={fechar}>
                            Fechar
                        </Button>
                    </div>
                ) : (
                    <form className={styles.form} noValidate onSubmit={handleSubmit}>
                        {CAMPOS.map(({ campo, label, type, dica, ...attrs }) => {
                            const id = idDe(campo);
                            const erro = erros[campo];
                            const descricao = [dica && `${id}-dica`, erro && `${id}-erro`].filter(Boolean).join(" ");
                            const tipo = type === "password" && mostrarSenha ? "text" : type;
                            return (
                                <div key={campo} className={styles.campo}>
                                    <label htmlFor={id} className={styles.label}>
                                        {label}
                                    </label>
                                    <input
                                        id={id}
                                        name={campo}
                                        className={styles.field}
                                        type={tipo}
                                        value={dados[campo]}
                                        onChange={handleChange(campo)}
                                        required
                                        aria-invalid={erro ? true : undefined}
                                        aria-describedby={descricao || undefined}
                                        disabled={enviando}
                                        {...attrs}
                                    />
                                    {dica && (
                                        <span id={`${id}-dica`} className={styles.dica}>
                                            {dica}
                                        </span>
                                    )}
                                    {erro && (
                                        <span id={`${id}-erro`} className={styles.erro}>
                                            {erro}
                                        </span>
                                    )}
                                </div>
                            );
                        })}

                        <label className={styles.mostrar}>
                            <input
                                type="checkbox"
                                checked={mostrarSenha}
                                onChange={(e) => setMostrarSenha(e.target.checked)}
                                disabled={enviando}
                            />
                            Mostrar senhas
                        </label>

                        {erroGeral && (
                            <p className={styles.erro} role="alert">
                                {erroGeral}
                            </p>
                        )}

                        <Button type="submit" variant="primary" fullWidth disabled={enviando}>
                            {enviando ? "Enviando..." : "Criar conta"}
                        </Button>
                    </form>
                )}
            </div>
        </dialog>
    );
}
