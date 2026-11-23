import { useMemo, useState } from "react";
import { Link } from "react-router-dom";
import type { Game } from "../../data/games";
import type { RegisteredPlatforms } from "../../data/platforms";
import { Button } from "../Button/Button";
import { BotaoAdicionar } from "../Carrinho/BotaoAdicionar";
import { idDoJogo } from "../Carrinho/catalogo";
import { Crumbs } from "../detalhe/Crumbs";
import {
    WHATSAPP_URL,
    bestOffer,
    finalPrice,
    formatPrice,
    getDirector,
    imagesOf,
    platformName,
    publisherName,
    studioName,
    offersOfGame,
} from "../detalhe/dados";
import shared from "../home/shared.module.css";
import base from "../detalhe/detalhe.module.css";
import { Stars } from "./Stars";
import { trailerOf, youtubeThumb } from "./youtube";
import type { summarize } from "./review";
import styles from "./Produto.module.css";

type GalleryItem = { kind: "trailer"; id: string; url: string } | { kind: "image"; src: string; n: number };

type Props = {
    game: Game;
    platform: RegisteredPlatforms | undefined;
    onPlatform: (p: RegisteredPlatforms) => void;
    summary: ReturnType<typeof summarize>;
};

export function Produto({ game, platform, onPlatform, summary }: Props) {
    const trailer = useMemo(() => trailerOf(game.media), [game.media]);
    const items = useMemo<GalleryItem[]>(
        () => [
            ...(trailer ? [{ kind: "trailer" as const, ...trailer }] : []),
            ...imagesOf(game).map((src, i) => ({ kind: "image" as const, src, n: i + 1 })),
        ],
        [game, trailer],
    );
    const [shot, setShot] = useState(0);
    const [playing, setPlaying] = useState(false);
    const current = items[Math.min(shot, items.length - 1)];
    // Clicar na miniatura do trailer já carrega o iframe tocando; ao abrir a página só aparece a capa.
    const select = (i: number) => {
        setPlaying(items[i]?.kind === "trailer");
        setShot(i);
    };
    const director = getDirector(game.director);
    const studio = director ? studioName(director) : undefined;
    const publisher = publisherName(game);

    const available = game.platforms.filter((p) => offersOfGame(game.slug).some((o) => o.platform === p));
    // Melhor oferta da plataforma escolhida: é o preço mostrado e o que vai para o carrinho.
    const offer = platform ? bestOffer(game.slug, platform) : undefined;

    const byline = [studio, publisher].filter(Boolean).join(" · ");

    return (
        <section className={styles.section}>
            <div className={`${shared.wrap} ${styles.inner}`}>
                <Crumbs
                    trail={[{ label: "Jogos", to: "/jogos" }]}
                    current={game.name}
                    backLabel="Jogos"
                    backTo="/jogos"
                />
                <div className={styles.grid}>
                    {items.length > 0 && (
                        <div className={styles.gallery}>
                            <div className={`${shared.box} ${styles.stage} ${trailer ? styles.stageWide : ""}`}>
                                {current.kind === "trailer" ? (
                                    playing ? (
                                        <iframe
                                            className={styles.stageFrame}
                                            src={`https://www.youtube-nocookie.com/embed/${current.id}?rel=0&modestbranding=1&playsinline=1&autoplay=1`}
                                            title={`Trailer de ${game.name}`}
                                            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
                                            allowFullScreen
                                            referrerPolicy="strict-origin-when-cross-origin"
                                        />
                                    ) : (
                                        <>
                                            <img className={styles.stageImg} src={youtubeThumb(current.id)} alt="" />
                                            <button
                                                type="button"
                                                className={styles.bigPlay}
                                                onClick={() => setPlaying(true)}
                                                aria-label={`Assistir ao trailer de ${game.name}`}
                                            >
                                                <span className={styles.bigIcon} aria-hidden="true">
                                                    <svg viewBox="0 0 16 16" shapeRendering="crispEdges">
                                                        <path d="M4 2h2v2h2v2h2v2h2v2h-2v2H8v2H6v2H4z" fill="currentColor" />
                                                    </svg>
                                                </span>
                                                <span className={styles.bigText}>Assistir ao trailer</span>
                                            </button>
                                        </>
                                    )
                                ) : (
                                    <>
                                        <img className={styles.stageImg} src={current.src} alt={`${game.name}, captura ${current.n}`} />
                                        <span className={styles.caption}>
                                            <span className={styles.captionLong}>[CAPTURA DE TELA]</span>
                                            <span className={styles.captionShort}>
                                                {shot + 1}/{items.length}
                                            </span>
                                        </span>
                                    </>
                                )}
                            </div>
                            {items.length > 1 && (
                                <div role="group" aria-label="Mídias do jogo" className={styles.thumbs}>
                                    {items.map((item, i) => (
                                        <button
                                            key={item.kind === "trailer" ? item.id : item.src}
                                            type="button"
                                            aria-label={item.kind === "trailer" ? "Trailer" : `Captura ${item.n}`}
                                            aria-pressed={i === shot}
                                            onClick={() => select(i)}
                                            className={`${styles.thumb} ${i === shot ? styles.thumbOn : ""}`}
                                        >
                                            <img
                                                src={item.kind === "trailer" ? youtubeThumb(item.id) : item.src}
                                                alt=""
                                                loading="lazy"
                                            />
                                            {item.kind === "trailer" && (
                                                <span className={styles.playBadge} aria-hidden="true">
                                                    <svg viewBox="0 0 16 16" shapeRendering="crispEdges">
                                                        <path d="M4 2h2v2h2v2h2v2h2v2h-2v2H8v2H6v2H4z" fill="currentColor" />
                                                    </svg>
                                                </span>
                                            )}
                                        </button>
                                    ))}
                                </div>
                            )}
                        </div>
                    )}

                    <div className={styles.buy}>
                        {offer && offer.discount > 0 && (
                            <div className={base.tags}>
                                <span className={`${base.tag} ${base.tagRed}`}>-{offer.discount}%</span>
                            </div>
                        )}
                        <h1 className={base.h1}>{game.name}</h1>
                        {(byline || director) && (
                            <p className={styles.byline}>
                                {byline}
                                {director && (
                                    <>
                                        {byline && " · "}dirigido por <Link to={`/diretores/${director.slug}`}>{director.name}</Link>
                                    </>
                                )}
                            </p>
                        )}
                        {summary.count > 0 && (
                            <a href="#avaliacoes" className={styles.rating}>
                                <span className={styles.stars}>
                                    <Stars filled={Math.round(summary.avg)} size={20} />
                                </span>
                                <strong>{summary.avgLabel}</strong>
                                <span className={base.muted}>({summary.countLabel})</span>
                            </a>
                        )}

                        {available.length > 0 && (
                            <fieldset className={base.fieldset}>
                                <legend className={base.legend}>PLATAFORMA</legend>
                                <div className={styles.platforms}>
                                    {available.map((p) => (
                                        <Button
                                            key={p}
                                            variant={p === platform ? "accent" : "secondary"}
                                            aria-pressed={p === platform}
                                            onClick={() => onPlatform(p)}
                                            className={`${base.option} ${styles.platBtn}`}
                                        >
                                            {platformName(p)}
                                        </Button>
                                    ))}
                                </div>
                            </fieldset>
                        )}

                        {offer && (
                            <div className={`${shared.box} ${base.priceBox}`}>
                                {offer.discount > 0 && <span className={base.old}>{formatPrice(offer.base_price / 100)}</span>}
                                <span className={base.priceNow}>{formatPrice(finalPrice(offer))}</span>
                                {/* Só a plataforma: a loja de origem não aparece, a compra é na Mayk Games */}
                                {platform && <span className={base.muted}>{platformName(platform)}</span>}
                            </div>
                        )}

                        {offer && (
                            <div className={styles.ctas}>
                                {/* Antes era "Comprar agora" (WhatsApp); agora a oferta mostrada vai para o carrinho */}
                                <BotaoAdicionar
                                    id={idDoJogo(offer)}
                                    nome={game.name}
                                    variante="destaque"
                                    className={base.cta}
                                />
                            </div>
                        )}
                        <Button
                            variant="secondary"
                            href={WHATSAPP_URL}
                            target="_blank"
                            rel="noreferrer"
                            className={styles.whats}
                        >
                            <span className={styles.whatsLong}>Tirar dúvida no WhatsApp</span>
                            <span className={styles.whatsShort}>Dúvida? Chame no WhatsApp</span>
                        </Button>
                    </div>
                </div>
            </div>
        </section>
    );
}
