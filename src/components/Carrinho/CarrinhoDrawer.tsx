import { useEffect, useId, useRef } from "react";
import type { MouseEvent } from "react";
import { Button } from "../Button/Button";
import { formatPrice } from "../detalhe/dados";
import { QUANTIDADE_MAXIMA, useCarrinho } from "./useCarrinho";
import styles from "./CarrinhoDrawer.module.css";

type Props = {
    open: boolean;
    onClose: () => void;
};

function reais(centavos: number): string {
    return formatPrice(centavos / 100);
}

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
 * Drawer lateral do carrinho sobre o <dialog> nativo, no mesmo padrão do modal
 * de conta: foco preso dentro, Esc fecha e o foco volta ao botão que abriu.
 */
export function CarrinhoDrawer({ open, onClose }: Props) {
    const dialogRef = useRef<HTMLDialogElement>(null);
    const tituloRef = useRef<HTMLHeadingElement>(null);
    const inicioCliqueRef = useRef<EventTarget | null>(null);
    const idBase = useId();
    const { linhas, totalItens, totalCentavos, remover, alterarQuantidade, limpar } = useCarrinho();

    // Sincroniza a prop "open" com o <dialog>.
    useEffect(() => {
        const dialog = dialogRef.current;
        if (!dialog) return;
        if (open && !dialog.open) {
            dialog.showModal();
            tituloRef.current?.focus();
        } else if (!open && dialog.open) {
            dialog.close();
        }
    }, [open]);

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

    // O botão clicado some da tela; o foco vai para o título para não se perder.
    function handleRemover(id: string) {
        remover(id);
        tituloRef.current?.focus();
    }

    function handleLimpar() {
        limpar();
        tituloRef.current?.focus();
    }

    const tituloId = `${idBase}-titulo`;
    const avisoId = `${idBase}-aviso`;

    return (
        <dialog
            ref={dialogRef}
            className={styles.drawer}
            aria-labelledby={tituloId}
            onClose={onClose}
            onMouseDown={handleMouseDown}
            onClick={handleClick}
        >
            <div className={styles.conteudo}>
                <div className={styles.topo}>
                    <h2 id={tituloId} ref={tituloRef} tabIndex={-1} className={styles.titulo}>
                        Carrinho
                        {totalItens > 0 && (
                            <span className={styles.qtdTitulo}>
                                {" "}({totalItens} {totalItens === 1 ? "item" : "itens"})
                            </span>
                        )}
                    </h2>
                    <Button variant="secondary" size="sm" className={styles.fechar} aria-label="Fechar carrinho" onClick={fechar}>
                        <CloseIcon />
                    </Button>
                </div>

                {linhas.length === 0 ? (
                    <p className={styles.vazio}>Seu carrinho está vazio. Que tal escolher um jogo?</p>
                ) : (
                    <ul className={styles.lista}>
                        {linhas.map((l) => (
                            <li key={l.id} className={styles.item}>
                                <img className={styles.capa} src={l.imagem} alt="" loading="lazy" />
                                <div className={styles.info}>
                                    {/* Só "Nome · Plataforma": a loja de origem não aparece, a compra é na Mayk Games */}
                                    <span className={styles.nome}>{l.nome}</span>
                                    <span className={styles.detalhe}>{l.detalhe}</span>
                                    <span className={styles.preco}>
                                        {l.desconto > 0 && (
                                            <>
                                                <span className={styles.antigo}>
                                                    <span className="sr-only">De </span>
                                                    {reais(l.precoOriginalCentavos)}
                                                </span>{" "}
                                                <span className="sr-only">por </span>
                                            </>
                                        )}
                                        {reais(l.precoCentavos)}
                                        {l.desconto > 0 && <span className={styles.off}> -{l.desconto}%</span>}
                                    </span>

                                    <div className={styles.acoes}>
                                        <div className={styles.quantidade} role="group" aria-label={`Quantidade de ${l.nome}`}>
                                            <Button
                                                variant="secondary"
                                                size="sm"
                                                className={styles.qtdBtn}
                                                aria-label={`Diminuir quantidade de ${l.nome}`}
                                                disabled={l.quantidade <= 1}
                                                onClick={() => alterarQuantidade(l.id, l.quantidade - 1)}
                                            >
                                                -
                                            </Button>
                                            <span className={styles.qtdValor} aria-live="polite">
                                                {l.quantidade}
                                            </span>
                                            <Button
                                                variant="secondary"
                                                size="sm"
                                                className={styles.qtdBtn}
                                                aria-label={`Aumentar quantidade de ${l.nome}`}
                                                disabled={l.quantidade >= QUANTIDADE_MAXIMA}
                                                onClick={() => alterarQuantidade(l.id, l.quantidade + 1)}
                                            >
                                                +
                                            </Button>
                                        </div>
                                        <button
                                            type="button"
                                            className={styles.remover}
                                            aria-label={`Remover ${l.nome} do carrinho`}
                                            onClick={() => handleRemover(l.id)}
                                        >
                                            Remover
                                        </button>
                                    </div>
                                </div>
                                <span className={styles.subtotal}>
                                    <span className="sr-only">Subtotal: </span>
                                    {reais(l.subtotalCentavos)}
                                </span>
                            </li>
                        ))}
                    </ul>
                )}

                <div className={styles.rodape}>
                    <div className={styles.total}>
                        <span>Total</span>
                        <strong className={styles.totalValor}>{reais(totalCentavos)}</strong>
                    </div>
                    {/* Desativado de propósito: a finalização entra quando houver servidor. */}
                    <Button variant="primary" fullWidth disabled aria-describedby={avisoId}>
                        Finalizar compra
                    </Button>
                    <p id={avisoId} className={styles.aviso}>
                        A finalização da compra será ligada ao servidor em breve.
                    </p>
                    {linhas.length > 0 && (
                        <button type="button" className={styles.remover} onClick={handleLimpar}>
                            Esvaziar carrinho
                        </button>
                    )}
                </div>
            </div>
        </dialog>
    );
}
