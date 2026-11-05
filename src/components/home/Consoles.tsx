import { Link } from "react-router-dom";
import { formatPrice, homeConsoles } from "./homeData";
import shared from "./shared.module.css";
import styles from "./Consoles.module.css";

export function Consoles() {
    if (homeConsoles.length === 0) return null;

    return (
        <section id="consoles" className={styles.section}>
            <div className={`${shared.wrap} ${styles.inner}`}>
                <div>
                    <p className={shared.eyebrow}>ESCOLHA SEU PLAYER 1</p>
                    <h2 className={shared.title}>Consoles à venda</h2>
                </div>
                <div className={styles.grid}>
                    {homeConsoles.map((c) => (
                        <Link key={c.id} to={`/consoles/${c.slug}`} className={`${shared.box} ${shared.lift} ${styles.card}`}>
                            <div className={styles.cover}>
                                <img className={shared.coverImg} src={c.imagem} alt={c.nome} loading="lazy" />
                            </div>
                            <div className={styles.body}>
                                <h3 className={styles.name}>{c.nome}</h3>
                                <span className={styles.desc}>
                                    {c.tipo} · {c.geracao}
                                </span>
                                <span className={styles.price}>{formatPrice(c.valor)}</span>
                            </div>
                        </Link>
                    ))}
                </div>
            </div>
        </section>
    );
}
