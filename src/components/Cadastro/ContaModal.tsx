import { useEffect, useId, useRef, useState } from "react";
import type { ChangeEvent, FormEvent, MouseEvent } from "react";
import { Button } from "../Button/Button";
import {
    CADASTRO_VAZIO,
    SENHA_MINIMA,
    enviarCadastro,
    enviarLogin,
    mascararCpf,
    validarCadastro,
    validarLogin,
} from "./cadastro";
import type { CampoCadastro, DadosCadastro, ErrosCadastro } from "./cadastro";
import styles from "./ContaModal.module.css";

type Props = {
    open: boolean;
    onClose: () => void;
};

type Status = "editando" | "enviando" | "sucesso";
type Modo = "entrar" | "cadastro";

// Modo em que o modal sempre abre: quem já tem conta é o caso mais comum.
const MODO_INICIAL: Modo = "entrar";

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
const CAMPOS_LOGIN: ConfigCampo[] = [
    { campo: "email", label: "E-mail", type: "email", autoComplete: "email" },
    { campo: "senha", label: "Senha", type: "password", autoComplete: "current-password" },
];

const CAMPOS_CADASTRO: ConfigCampo[] = [
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

// Textos que mudam conforme o modo.
const TEXTOS = {
    entrar: {
        titulo: "Entrar",
        enviar: "Entrar",
        pergunta: "Não tem conta?",
        alternar: "Criar conta",
    },
    cadastro: {
        titulo: "Criar conta",
        enviar: "Criar conta",
        pergunta: "Já tem conta?",
        alternar: "Entrar",
    },
} as const;

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
 * Modal de conta ("Entrar" / "Criar conta") sobre o <dialog> nativo: o navegador
 * cuida da camada por cima da página, do foco preso dentro dele, do Esc e de
 * devolver o foco ao botão que abriu.
 */
export function ContaModal({ open, onClose }: Props) {
    const dialogRef = useRef<HTMLDialogElement>(null);
    const idBase = useId();
    const [modo, setModo] = useState<Modo>(MODO_INICIAL);
    // Um único objeto de dados; o login usa só e-mail e senha.
    const [dados, setDados] = useState<DadosCadastro>(CADASTRO_VAZIO);
    const [erros, setErros] = useState<ErrosCadastro>({});
    const [erroGeral, setErroGeral] = useState("");
    const [status, setStatus] = useState<Status>("editando");
    const [mostrarSenha, setMostrarSenha] = useState(false);

    // Cada envio ganha um número; se o modal fechar ou trocar de modo no meio, a resposta antiga é ignorada.
    const tentativaRef = useRef(0);
    // Campo que deve receber foco depois da próxima renderização (erro ou troca de modo).
    const focarRef = useRef<CampoCadastro | null>(null);
    // Onde o clique começou (evita fechar ao arrastar uma seleção de texto para fora).
    const inicioCliqueRef = useRef<EventTarget | null>(null);

    const campos = modo === "entrar" ? CAMPOS_LOGIN : CAMPOS_CADASTRO;
    const textos = TEXTOS[modo];
    const idDe = (campo: CampoCadastro) => `${idBase}-${campo}`;
    const primeiroCampo = campos[0].campo;

    // Sincroniza a prop "open" com o <dialog>.
    useEffect(() => {
        const dialog = dialogRef.current;
        if (!dialog) return;
        if (open && !dialog.open) {
            dialog.showModal();
            document.getElementById(`${idBase}-${primeiroCampo}`)?.focus();
        } else if (!open && dialog.open) {
            dialog.close();
        }
    }, [open, idBase, primeiroCampo]);

    // Depois de renderizar, leva o foco ao campo pedido: o primeiro inválido
    // (o leitor de tela já anuncia a mensagem ligada a ele) ou o primeiro do novo modo.
    useEffect(() => {
        if (focarRef.current) {
            document.getElementById(`${idBase}-${focarRef.current}`)?.focus();
            focarRef.current = null;
        }
    }, [erros, modo, idBase]);

    // Volta o formulário ao estado inicial (sem mudar o modo).
    function limpar() {
        tentativaRef.current++;
        setDados(CADASTRO_VAZIO);
        setErros({});
        setErroGeral("");
        setStatus("editando");
        setMostrarSenha(false);
    }

    // Evento "close" nativo: dispara no Esc, no clique fora e no botão Fechar.
    function handleClose() {
        limpar();
        setModo(MODO_INICIAL);
        onClose();
    }

    function fechar() {
        dialogRef.current?.close();
    }

    // Alterna entre "Entrar" e "Criar conta" sem fechar o modal.
    function alternarModo() {
        const novoModo: Modo = modo === "entrar" ? "cadastro" : "entrar";
        limpar();
        setModo(novoModo);
        focarRef.current = (novoModo === "entrar" ? CAMPOS_LOGIN : CAMPOS_CADASTRO)[0].campo;
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

        const email = dados.email.trim();
        const novosErros: ErrosCadastro =
            modo === "entrar" ? validarLogin({ email, senha: dados.senha }) : validarCadastro(dados);
        const primeiroInvalido = campos.find(({ campo }) => novosErros[campo])?.campo;
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
            if (modo === "entrar") {
                await enviarLogin({ email, senha: dados.senha });
            } else {
                await enviarCadastro({ ...dados, nome: dados.nome.trim(), email });
            }
            if (tentativa !== tentativaRef.current) return;
            setStatus("sucesso");
        } catch {
            if (tentativa !== tentativaRef.current) return;
            setStatus("editando");
            setErroGeral(
                modo === "entrar"
                    ? "Não foi possível entrar. Tente novamente."
                    : "Não foi possível criar a conta. Tente novamente."
            );
        }
    }

    const tituloId = `${idBase}-titulo`;
    const enviando = status === "enviando";
    const mensagemSucesso =
        modo === "entrar"
            ? "Login realizado com sucesso!"
            : `Conta criada com sucesso! Bem-vindo(a), ${dados.nome.trim()}.`;

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
                        {textos.titulo}
                    </h2>
                    <Button variant="secondary" size="sm" className={styles.fechar} aria-label="Fechar" onClick={fechar}>
                        <CloseIcon />
                    </Button>
                </div>

                {status === "sucesso" ? (
                    <div className={styles.sucesso} role="status">
                        <p>{mensagemSucesso}</p>
                        <Button variant="accent" autoFocus onClick={fechar}>
                            Fechar
                        </Button>
                    </div>
                ) : (
                    <>
                        <form className={styles.form} noValidate onSubmit={handleSubmit}>
                            {campos.map(({ campo, label, type, dica, ...attrs }) => {
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
                                {modo === "entrar" ? "Mostrar senha" : "Mostrar senhas"}
                            </label>

                            {erroGeral && (
                                <p className={styles.erro} role="alert">
                                    {erroGeral}
                                </p>
                            )}

                            <Button type="submit" variant="primary" fullWidth disabled={enviando}>
                                {enviando ? "Enviando..." : textos.enviar}
                            </Button>
                        </form>

                        <p className={styles.alternar}>
                            {textos.pergunta}{" "}
                            <button type="button" className={styles.linkBtn} onClick={alternarModo} disabled={enviando}>
                                {textos.alternar}
                            </button>
                        </p>
                    </>
                )}
            </div>
        </dialog>
    );
}
