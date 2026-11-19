/** Carrinho em pixel art no mesmo grid 10x10 dos ícones do header. Usa a cor do texto. */
export function IconeCarrinho({ tamanho = 20 }: { tamanho?: number }) {
    return (
        <svg width={tamanho} height={tamanho} viewBox="0 0 10 10" shapeRendering="crispEdges" aria-hidden="true">
            {/* alça */}
            <rect x="0" y="1" width="2" height="1" fill="currentColor" />
            {/* cesto */}
            <rect x="1" y="2" width="9" height="1" fill="currentColor" />
            <rect x="2" y="3" width="7" height="3" fill="currentColor" />
            <rect x="2" y="6" width="6" height="1" fill="currentColor" />
            {/* rodas */}
            <rect x="2" y="8" width="2" height="2" fill="currentColor" />
            <rect x="6" y="8" width="2" height="2" fill="currentColor" />
        </svg>
    );
}
