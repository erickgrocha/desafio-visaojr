import { createContext, useContext } from "react";
import type { ProdutoCarrinho } from "./catalogo";

// Fica separado do CarrinhoContext.tsx porque o lint (react-refresh) pede que
// arquivos de componente exportem só componentes.

export const QUANTIDADE_MAXIMA = 99;

/** O que vai para o localStorage: só o id e a quantidade. */
export type ItemCarrinho = {
    id: string;
    quantidade: number;
};

/** Item pronto para exibir: dados do catálogo + quantidade + subtotal. */
export type LinhaCarrinho = ProdutoCarrinho & {
    quantidade: number;
    subtotalCentavos: number;
};

export type CarrinhoValor = {
    linhas: LinhaCarrinho[];
    totalItens: number;
    totalCentavos: number;
    adicionar: (id: string) => void;
    remover: (id: string) => void;
    alterarQuantidade: (id: string, quantidade: number) => void;
    limpar: () => void;
};

export const CarrinhoContext = createContext<CarrinhoValor | null>(null);

export function useCarrinho(): CarrinhoValor {
    const valor = useContext(CarrinhoContext);
    if (!valor) {
        throw new Error("useCarrinho precisa estar dentro de <CarrinhoProvider>.");
    }
    return valor;
}
