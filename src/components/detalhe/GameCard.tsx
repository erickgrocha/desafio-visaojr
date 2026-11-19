import { Link } from "react-router-dom";
import { BotaoAdicionar } from "../Carrinho/BotaoAdicionar";
import { idDoJogo } from "../Carrinho/catalogo";
import shared from "../home/shared.module.css";
import { formatPrice, type GameListItem } from "./dados";
import styles from "./GameCard.module.css";

type Props = {
    item: GameListItem;
    showBlurb?: boolean; // descrição curta (tela do diretor)
    showPlatforms?: boolean;
    compact?: boolean; // sem o selo "VER JOGO" (lista de relacionados)
    className?: string;
};

export function GameCard({ item, showBlurb = false, showPlatforms = false, compact = false, className }: Props) {
    const { game } = item;
    // O card não é mais um <Link> inteiro (um botão dentro de um link é HTML inválido).
    // Só o nome é link, e o ::after dele cobre o card: o card todo continua clicável.
    return (
        <article
            className={[shared.box, shared.lift, styles.card, showBlurb && styles.row, className].filter(Boolean).join(" ")}
        >
            {item.discount > 0 && <span className={styles.off}>-{item.discount}%</span>}
            <div className={`${shared.cover} ${styles.cover}`}>
                <img className={shared.coverImg} src={item.cover} alt="" loading="lazy" />
            </div>
            <div className={styles.body}>
                <Link to={`/jogos/${game.slug}`} className={`${styles.name} ${styles.link}`}>
                    {game.name}
                </Link>
                {showPlatforms && <span className={styles.plat}>{item.platformLabel}</span>}
                {showBlurb && <p className={styles.blurb}>{game.description}</p>}
                <div className={styles.foot}>
                    <span className={styles.price}>
                        {item.oldPrice !== null && <span className={styles.old}>{formatPrice(item.oldPrice)}</span>}
                        {formatPrice(item.price)}
                    </span>
                    {!compact && <span className={styles.go}>VER JOGO ▸</span>}
                </div>
                <BotaoAdicionar id={idDoJogo(item.offer)} nome={game.name} />
            </div>
        </article>
    );
}
