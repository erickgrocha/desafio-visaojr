import { Link } from "react-router-dom";
import type { Console } from "../../data/consoles";
import { BotaoAdicionar } from "../Carrinho/BotaoAdicionar";
import { idDoConsole } from "../Carrinho/catalogo";
import { formatPrice } from "../home/homeData";
import shared from "../home/shared.module.css";
import styles from "./CardConsole.module.css";

export function CardConsole({ item }: { item: Console }) {
    // O card não é mais um <Link> inteiro (um botão dentro de um link é HTML inválido).
    // Só o nome é link, e o ::after dele cobre o card: o card todo continua clicável.
    return (
        <article className={`${shared.box} ${shared.lift} ${styles.card}`}>
            <div className={styles.cover}>
                <img className={shared.coverImg} src={item.imagem} alt={item.nome} loading="lazy" />
            </div>
            <div className={styles.body}>
                <Link to={`/consoles/${item.slug}`} className={`${styles.name} ${styles.link}`}>
                    {item.nome}
                </Link>
                <span className={styles.desc}>
                    {item.fabricante} · {item.tipo} · {item.geracao}
                </span>
                <div className={styles.foot}>
                    <span className={styles.price}>{formatPrice(item.valor)}</span>
                    <span className={styles.go}>VER CONSOLE ▸</span>
                </div>
                <BotaoAdicionar id={idDoConsole(item)} nome={item.nome} />
            </div>
        </article>
    );
}
