import { useEffect, useRef, useState } from "react";
import { Button } from "../Button/Button";
import { IconeCarrinho } from "./IconeCarrinho";
import { useCarrinho } from "./useCarrinho";
import styles from "./BotaoAdicionar.module.css";

type Props = {
    id: string; // id do catálogo (idDoJogo / idDoConsole)
    nome: string; // usado no aria-label e no aviso para leitor de tela
    // "card": compacto, nos cards de listagem (padrão).
    // "destaque": grande, nas páginas de detalhe; recebe a classe do CTA da página.
    variante?: "card" | "destaque";
    className?: string; // classe extra do botão (só usada no destaque)
};

const TEMPO_CONFIRMACAO = 1500;

/**
 * Botão "Adicionar ao carrinho" dos cards. É um <button> comum, então funciona
 * com Tab + Enter/Espaço. Fica por cima do link que cobre o card (z-index).
 */
export function BotaoAdicionar({ id, nome, variante = "card", className }: Props) {
    const destaque = variante === "destaque";
    const { adicionar } = useCarrinho();
    const [adicionado, setAdicionado] = useState(false);
    const timerRef = useRef<number | undefined>(undefined);

    // Limpa o timer se o card sair da tela antes de a confirmação sumir.
    useEffect(() => () => window.clearTimeout(timerRef.current), []);

    function handleClick() {
        adicionar(id);
        setAdicionado(true);
        window.clearTimeout(timerRef.current);
        timerRef.current = window.setTimeout(() => setAdicionado(false), TEMPO_CONFIRMACAO);
    }

    return (
        <div className={destaque ? styles.destaque : styles.acao}>
            <Button
                variant="primary"
                size={destaque ? "md" : "sm"}
                fullWidth
                className={destaque ? className : undefined}
                aria-label={`Adicionar ${nome} ao carrinho`}
                onClick={handleClick}
            >
                <IconeCarrinho tamanho={destaque ? 20 : 16} />
                <span aria-hidden="true">
                    {adicionado ? "Adicionado!" : destaque ? "Adicionar ao carrinho" : "Adicionar"}
                </span>
            </Button>
            {/* Confirmação para leitor de tela (o texto visível fica de fora do aria-label) */}
            <span className="sr-only" aria-live="polite">
                {adicionado ? `${nome} adicionado ao carrinho.` : ""}
            </span>
        </div>
    );
}
