import { useCallback, useEffect, useMemo, useState } from "react";
import type { ReactNode } from "react";
import { buscarProduto } from "./catalogo";
import { CarrinhoContext, QUANTIDADE_MAXIMA } from "./useCarrinho";
import type { CarrinhoValor, ItemCarrinho, LinhaCarrinho } from "./useCarrinho";

const STORAGE_KEY = "carrinho";

function limitarQuantidade(quantidade: number): number {
    return Math.min(Math.max(Math.trunc(quantidade), 1), QUANTIDADE_MAXIMA);
}

/**
 * Lê o carrinho salvo. Qualquer problema (localStorage bloqueado, JSON quebrado,
 * item que saiu do catálogo) resulta em carrinho vazio ou sem aquele item.
 */
function lerCarrinho(): ItemCarrinho[] {
    try {
        const bruto = localStorage.getItem(STORAGE_KEY);
        if (!bruto) return [];
        const salvo: unknown = JSON.parse(bruto);
        if (!Array.isArray(salvo)) return [];

        // Map junta ids repetidos, caso o dado salvo tenha sido editado à mão.
        const porId = new Map<string, number>();
        for (const item of salvo) {
            if (
                item &&
                typeof item.id === "string" &&
                typeof item.quantidade === "number" &&
                item.quantidade >= 1 &&
                buscarProduto(item.id)
            ) {
                porId.set(item.id, limitarQuantidade((porId.get(item.id) ?? 0) + item.quantidade));
            }
        }
        return [...porId].map(([id, quantidade]) => ({ id, quantidade }));
    } catch {
        return [];
    }
}

function salvarCarrinho(itens: ItemCarrinho[]) {
    try {
        localStorage.setItem(STORAGE_KEY, JSON.stringify(itens));
    } catch {
        // localStorage indisponível (modo privado, cota cheia): o carrinho vale só para esta visita.
    }
}

export function CarrinhoProvider({ children }: { children: ReactNode }) {
    const [itens, setItens] = useState<ItemCarrinho[]>(lerCarrinho);

    // Toda mudança no carrinho é salva.
    useEffect(() => {
        salvarCarrinho(itens);
    }, [itens]);

    const adicionar = useCallback((id: string) => {
        setItens((atual) => {
            const existente = atual.find((item) => item.id === id);
            if (existente) {
                return atual.map((item) =>
                    item.id === id ? { ...item, quantidade: limitarQuantidade(item.quantidade + 1) } : item
                );
            }
            return [...atual, { id, quantidade: 1 }];
        });
    }, []);

    const remover = useCallback((id: string) => {
        setItens((atual) => atual.filter((item) => item.id !== id));
    }, []);

    // Quantidade fica entre 1 e o máximo; para tirar o item, usa-se remover().
    const alterarQuantidade = useCallback((id: string, quantidade: number) => {
        setItens((atual) =>
            atual.map((item) => (item.id === id ? { ...item, quantidade: limitarQuantidade(quantidade) } : item))
        );
    }, []);

    const limpar = useCallback(() => setItens([]), []);

    const valor = useMemo<CarrinhoValor>(() => {
        // Nome, preço e desconto vêm sempre do catálogo, nunca do que foi salvo.
        const linhas: LinhaCarrinho[] = [];
        for (const item of itens) {
            const produto = buscarProduto(item.id);
            if (produto) {
                linhas.push({
                    ...produto,
                    quantidade: item.quantidade,
                    subtotalCentavos: produto.precoCentavos * item.quantidade,
                });
            }
        }
        return {
            linhas,
            totalItens: linhas.reduce((soma, l) => soma + l.quantidade, 0),
            totalCentavos: linhas.reduce((soma, l) => soma + l.subtotalCentavos, 0),
            adicionar,
            remover,
            alterarQuantidade,
            limpar,
        };
    }, [itens, adicionar, remover, alterarQuantidade, limpar]);

    return <CarrinhoContext.Provider value={valor}>{children}</CarrinhoContext.Provider>;
}
