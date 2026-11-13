import { Link } from "react-router-dom";
import { Button } from "../Button/Button";
import { Carousel } from "../Carousel/Carousel";
import { ArrowLeft, ArrowRight, ConsoleArt, type ConsoleKind } from "./icons";
import { bestOfferOf, consoleByName, formatPrice } from "./homeData";
import shared from "./shared.module.css";
import styles from "./Hero.module.css";

const WHATSAPP_URL = "https://api.whatsapp.com/send?phone=553193327631";
const AUTOPLAY_MS = 7000;

type Slide = {
    eyebrow: string;
    title: string;
    sub: string;
    cta1: string;
    cta1href: string;
    tag: string;
    art: ConsoleKind | "game";
    coverClass: string;
    artLabel?: string;
    name: string;
    desc?: string;
    cover?: string;
    old?: string;
    price?: string;
    /** página de detalhe do produto; sem valor, o card não é link */
    href?: string;
};

function buildSlides(): Slide[] {
    const xbox = consoleByName("Xbox Series X");
    const ps5 = consoleByName("PlayStation 5");
    const elden = bestOfferOf("elden-ring");

    return [
        {
            eyebrow: "PRESS START",
            title: "Sua próxima fase começa aqui",
            sub: "Consoles, PCs gamer e jogos novos e clássicos, escolhidos a dedo por quem joga desde a era 8-bit.",
            cta1: "Ver ofertas",
            cta1href: "#ofertas",
            tag: "DESTAQUE DA SEMANA",
            art: "tower",
            coverClass: styles.coverBlue,
            artLabel: "Ilustração pixel do Xbox Series X",
            name: xbox?.nome ?? "Xbox Series X",
            desc: xbox ? `${xbox.tipo} · ${xbox.geracao}` : undefined,
            price: xbox ? formatPrice(xbox.valor) : undefined,
            href: xbox?.slug ? `/consoles/${xbox.slug}` : undefined,
        },
        {
            eyebrow: "NOVA GERAÇÃO",
            title: "Jogue os maiores lançamentos",
            sub: "PlayStation 5 com leitor de disco e 1 TB de SSD, pronto para as maiores aventuras do ano.",
            cta1: "Ver consoles",
            cta1href: "#consoles",
            tag: "MAIS VENDIDO",
            art: "slim",
            coverClass: styles.coverRed,
            artLabel: "Ilustração pixel do PlayStation 5",
            name: ps5?.nome ?? "PlayStation 5",
            desc: ps5 ? `${ps5.tipo} · ${ps5.geracao}` : undefined,
            price: ps5 ? formatPrice(ps5.valor) : undefined,
            href: ps5?.slug ? `/consoles/${ps5.slug}` : undefined,
        },
        {
            eyebrow: "MODO TURBO",
            title: "Monte o setup dos sonhos",
            sub: "PCs gamer montados e testados na loja, com peças escolhidas para rodar seus jogos no máximo.",
            cta1: "Ver PCs",
            cta1href: "#consoles",
            tag: "MONTADO NA LOJA",
            art: "pc",
            coverClass: styles.coverGreen,
            artLabel: "Ilustração pixel do PC Gamer",
            name: "PC Gamer Pixel",
            desc: "RTX · 32 GB RAM · 1 TB NVMe",
            // sem equivalente em src/data: sem preço
            // sem equivalente em src/data: sem link
        },
        {
            eyebrow: "FASE BÔNUS",
            title: "Jogos com até 50% off",
            sub: "Promoções da semana em jogos para Xbox, PlayStation, Switch e PC. Corra antes que o tempo acabe!",
            cta1: "Ver promoções",
            cta1href: "#ofertas",
            tag: elden && elden.discount > 0 ? `-${elden.discount}% HOJE` : "EM DESTAQUE",
            art: "game",
            coverClass: styles.coverGold,
            name: elden?.game.name ?? "Elden Ring",
            desc: elden?.platformLabel,
            cover: elden?.cover,
            old: elden?.oldPrice ? formatPrice(elden.oldPrice) : undefined,
            price: elden ? formatPrice(elden.price) : undefined,
            href: elden ? `/jogos/${elden.game.slug}` : undefined,
        },
    ];
}

const slides = buildSlides();

function Coin() {
    return (
        <svg width="20" height="24" viewBox="0 0 10 12" shapeRendering="crispEdges" aria-hidden="true">
            <path d="M3 0h4v1h2v2h1v6h-1v2h-2v1h-4v-1h-2v-2h-1v-6h1v-2h2z" fill="#12123A" />
            <path d="M3 1h4v1h1v2h1v4h-1v2h-1v1h-4v-1h-1v-2h-1v-4h1v-2h1z" fill="#FFC800" />
            <path d="M4 3h2v6h-2z" fill="#F7871E" />
        </svg>
    );
}

function Cloud({ className }: { className: string }) {
    return (
        <svg viewBox="0 0 16 8" shapeRendering="crispEdges" aria-hidden="true" className={className}>
            <rect x="4" y="1" width="5" height="2" fill="#FFFFFF" />
            <rect x="9" y="2" width="4" height="2" fill="#FFFFFF" />
            <rect x="2" y="3" width="12" height="2" fill="#FFFFFF" />
            <rect x="1" y="5" width="14" height="2" fill="#FFFFFF" />
        </svg>
    );
}

function CardContent({ s }: { s: Slide }) {
    return (
        <>
            <div className={`${styles.cardCover} ${s.coverClass}`}>
                {s.art === "game" ? (
                    s.cover ? (
                        <img className={shared.coverImg} src={s.cover} alt="" />
                    ) : null
                ) : (
                    <ConsoleArt kind={s.art} size={220} label={s.artLabel} />
                )}
            </div>
            <div className={styles.cardBody}>
                <div className={styles.cardTop}>
                    <div>
                        <h3 className={styles.cardName}>{s.name}</h3>
                        {s.desc && <p className={styles.cardDesc}>{s.desc}</p>}
                    </div>
                    {s.price && (
                        <div className={styles.cardPrice}>
                            {s.old && <div className={shared.old}>{s.old}</div>}
                            <div className={styles.priceNow}>{s.price}</div>
                        </div>
                    )}
                </div>
            </div>
            <span className={styles.tag}>{s.tag}</span>
        </>
    );
}

export function Hero() {
    return (
        <section className={styles.hero}>
            <Cloud className={styles.cloudA} />
            <Cloud className={styles.cloudB} />

            <Carousel
                ariaLabel="Destaques da loja"
                itemsVisible={1}
                autoPlay={AUTOPLAY_MS}
                controls="none"
                renderAfter={({ index, prev, next, goTo }) => (
                    <div className={`${shared.wrap} ${styles.controls}`}>
                        <Button variant="secondary" aria-label="Destaque anterior" onClick={prev} className={shared.arrowBtn}>
                            <ArrowLeft />
                        </Button>
                        <div className={styles.dots}>
                            {slides.map((s, i) => (
                                <button
                                    key={s.title}
                                    type="button"
                                    aria-label={`Ver destaque ${i + 1}: ${s.name}`}
                                    aria-current={i === index}
                                    onClick={() => goTo(i)}
                                    className={`${styles.dot} ${i === index ? styles.dotOn : ""}`}
                                />
                            ))}
                        </div>
                        <span className={styles.count} aria-live="off">
                            {index + 1}/{slides.length}
                        </span>
                        <Button variant="accent" aria-label="Próximo destaque" onClick={next} className={shared.arrowBtn}>
                            <ArrowRight />
                        </Button>
                    </div>
                )}
            >
                {slides.map((s, i) => {
                    const Heading = i === 0 ? "h1" : "h2";
                    return (
                        <div key={s.title}>
                                <div className={`${shared.wrap} ${styles.grid}`}>
                                    <div className={styles.copy}>
                                        <span className={styles.eyebrow}>
                                            <svg width="15" height="18" viewBox="0 0 10 12" shapeRendering="crispEdges" aria-hidden="true">
                                                <path d="M3 0h4v1h2v2h1v6h-1v2h-2v1h-4v-1h-2v-2h-1v-6h1v-2h2z" fill="#FFC800" />
                                                <path d="M4 3h2v6h-2z" fill="#F7871E" />
                                            </svg>
                                            {s.eyebrow}
                                        </span>
                                        <Heading className={styles.heading}>{s.title}</Heading>
                                        <p className={styles.sub}>{s.sub}</p>
                                        <div className={styles.ctas}>
                                            <Button variant="primary" href={s.cta1href} className={styles.cta}>
                                                {s.cta1}
                                            </Button>
                                            <Button
                                                variant="secondary"
                                                href={WHATSAPP_URL}
                                                target="_blank"
                                                rel="noreferrer"
                                                className={styles.cta}
                                               
                                            >
                                                Falar no WhatsApp
                                            </Button>
                                        </div>
                                        <div className={styles.coins}>
                                            <Coin />
                                            <Coin />
                                            <Coin />
                                            <span className={styles.coinsText}>Ganhe moedas a cada compra e troque por descontos</span>
                                        </div>
                                    </div>

                                    {s.href ? (
                                        <Link to={s.href} aria-label={s.name} className={`${shared.box} ${shared.lift} ${styles.card} ${styles.cardLink}`}>
                                            <CardContent s={s} />
                                        </Link>
                                    ) : (
                                        <article className={`${shared.box} ${styles.card}`}>
                                            <CardContent s={s} />
                                        </article>
                                    )}
                                </div>
                            </div>
                        );
                    })}
            </Carousel>

            <div className={styles.grass} />
            <div className={styles.bricks} />
        </section>
    );
}

