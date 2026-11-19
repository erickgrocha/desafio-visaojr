import { useEffect } from "react";
import { Outlet, useLocation } from "react-router-dom";
import { Header } from "../components/Header/Header";
import { Footer } from "../components/footer";
import { CarrinhoProvider } from "../components/Carrinho/CarrinhoContext";

export function HeaderLayout() {
    const { pathname, hash } = useLocation();

    // Rola até a âncora (#jogos, #contato...) ou volta ao topo ao trocar de página.
    useEffect(() => {
        if (hash) {
            document.getElementById(hash.slice(1))?.scrollIntoView();
        } else {
            window.scrollTo(0, 0);
        }
    }, [pathname, hash]);

    // O carrinho envolve header e páginas: o contador e os botões dos cards leem o mesmo estado.
    return (
        <CarrinhoProvider>
            <Header />
            <main>
                <Outlet />
            </main>
            <Footer />
        </CarrinhoProvider>
    );
}
