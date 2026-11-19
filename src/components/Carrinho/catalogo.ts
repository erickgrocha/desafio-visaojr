import { consoles, type Console } from "../../data/consoles";
import { offers, type Offer } from "../../data/offers";
import { coverOf, getGame, platformName } from "../detalhe/dados";

/*
 * Catálogo do carrinho: transforma o id salvo no carrinho em um produto pronto para exibir.
 *
 * Por enquanto tudo vem dos dados locais (src/data). Depois, o id e o preço do
 * produto virão do servidor (cadastro de produtos da Mayk Games); a ideia é que
 * só este arquivo precise mudar quando isso acontecer.
 *
 * Valores sempre em centavos inteiros, para a soma do total não ter erro de arredondamento.
 */

export type ProdutoCarrinho = {
    id: string;
    nome: string;
    detalhe: string; // jogo: plataforma | console: fabricante
    imagem: string;
    precoOriginalCentavos: number;
    desconto: number; // percentual inteiro, 0 = sem desconto
    precoCentavos: number; // preço final, já com o desconto aplicado
};

export function aplicarDesconto(centavos: number, desconto: number): number {
    return Math.round((centavos * (100 - desconto)) / 100);
}

/**
 * Id de um jogo: jogo:<slug>:<plataforma>:<loja>.
 * A loja entra no id só para achar a oferta certa nos dados locais; ela nunca
 * é exibida, porque a compra é feita na Mayk Games.
 */
export function idDoJogo(offer: Offer): string {
    return `jogo:${offer.game}:${offer.platform}:${offer.store}`;
}

/** Id de um console: console:<slug>. */
export function idDoConsole(c: Console): string {
    return `console:${c.slug ?? c.id}`;
}

/** Devolve o produto do id, ou undefined se ele não existir mais no catálogo. */
export function buscarProduto(id: string): ProdutoCarrinho | undefined {
    const [tipo, ...partes] = id.split(":");

    if (tipo === "jogo" && partes.length === 3) {
        const [slug, plataforma, loja] = partes;
        const offer = offers.find((o) => o.game === slug && o.platform === plataforma && o.store === loja);
        const game = getGame(slug);
        if (!offer || !game) return undefined;
        return {
            id,
            nome: game.name,
            detalhe: platformName(offer.platform),
            imagem: coverOf(game),
            precoOriginalCentavos: offer.base_price,
            desconto: offer.discount,
            precoCentavos: aplicarDesconto(offer.base_price, offer.discount),
        };
    }

    if (tipo === "console" && partes.length === 1) {
        const c = consoles.find((item) => (item.slug ?? String(item.id)) === partes[0]);
        if (!c) return undefined;
        const centavos = Math.round(c.valor * 100);
        return {
            id,
            nome: c.nome,
            detalhe: c.fabricante,
            imagem: c.imagem,
            precoOriginalCentavos: centavos,
            desconto: 0, // consoles ainda não têm desconto nos dados
            precoCentavos: centavos,
        };
    }

    return undefined;
}
