import {
    Children,
    useCallback,
    useEffect,
    useRef,
    useState,
    useSyncExternalStore,
    type CSSProperties,
    type KeyboardEvent,
    type ReactNode,
} from "react";
import { Button } from "../Button/Button";
import { ArrowLeft, ArrowRight } from "../home/icons";
import styles from "./Carousel.module.css";

export type CarouselApi = {
    /** posição atual (0 a positions - 1) */
    index: number;
    /** quantidade de posições de navegação */
    positions: number;
    prev: () => void;
    next: () => void;
    goTo: (i: number) => void;
};

export type CarouselProps = {
    children: ReactNode;
    /** itens visíveis por vez (aceita fração) */
    itemsVisible?: number;
    /** itens visíveis por vez abaixo de 768px (padrão: itemsVisible) */
    itemsVisibleMobile?: number;
    /** intervalo do autoplay em ms; sem valor, não avança sozinho */
    autoPlay?: number;
    controls?: "inside" | "outside" | "none";
    /** esconde setas e pontos padrão abaixo de 768px */
    hideControlsOnMobile?: boolean;
    ariaLabel: string;
    className?: string;
    /** classe do container que rola (ajuste de gap via --carousel-gap, padding etc.) */
    scrollerClassName?: string;
    /** conteúdo renderizado antes/depois da área que rola, com acesso à navegação */
    renderBefore?: (api: CarouselApi) => ReactNode;
    renderAfter?: (api: CarouselApi) => ReactNode;
};

const MOBILE_QUERY = "(max-width: 767px)";

function subscribeMobile(cb: () => void) {
    const mq = window.matchMedia(MOBILE_QUERY);
    mq.addEventListener("change", cb);
    return () => mq.removeEventListener("change", cb);
}
const isMobileNow = () => window.matchMedia(MOBILE_QUERY).matches;

const reducedMotion = () => window.matchMedia("(prefers-reduced-motion: reduce)").matches;

function Slot({ render, api }: { render: (api: CarouselApi) => ReactNode; api: CarouselApi }) {
    return <>{render(api)}</>;
}

export function Carousel({
    children,
    itemsVisible = 1,
    itemsVisibleMobile,
    autoPlay,
    controls = "inside",
    hideControlsOnMobile = false,
    ariaLabel,
    className,
    scrollerClassName,
    renderBefore,
    renderAfter,
}: CarouselProps) {
    const scroller = useRef<HTMLDivElement>(null);
    const target = useRef<number | null>(null); // destino de uma navegação em curso
    const targetTimer = useRef<number | undefined>(undefined);
    const touching = useRef(false);
    const [positions, setPositions] = useState(1);
    const [index, setIndex] = useState(0);
    const indexRef = useRef(0);
    const positionsRef = useRef(1);

    const mobile = useSyncExternalStore(subscribeMobile, isMobileNow, () => false);
    const slides = Children.toArray(children);
    const count = slides.length;
    const visible = mobile && itemsVisibleMobile !== undefined ? itemsVisibleMobile : itemsVisible;

    const step = useCallback(() => {
        const el = scroller.current;
        const first = el?.firstElementChild as HTMLElement | null;
        if (!el || !first) return 1;
        const gap = parseFloat(getComputedStyle(el).columnGap) || 0;
        return first.offsetWidth + gap;
    }, []);

    const maxScroll = () => {
        const el = scroller.current;
        return el ? Math.max(0, el.scrollWidth - el.clientWidth) : 0;
    };

    // posições a partir da geometria real, refeitas quando o tamanho ou os itens mudam
    useEffect(() => {
        const el = scroller.current;
        if (!el) return;
        const measure = () => {
            const n = Math.max(1, Math.ceil(maxScroll() / step() - 0.05) + 1);
            positionsRef.current = n;
            setPositions(n);
            const clamped = Math.min(indexRef.current, n - 1);
            indexRef.current = clamped;
            setIndex(clamped);
        };
        const ro = new ResizeObserver(measure);
        ro.observe(el);
        return () => ro.disconnect();
    }, [step, count, visible]);

    useEffect(() => () => window.clearTimeout(targetTimer.current), []);

    const settle = () => {
        target.current = null;
        window.clearTimeout(targetTimer.current);
    };

    const goTo = useCallback(
        (i: number) => {
            const el = scroller.current;
            if (!el) return;
            const n = positionsRef.current;
            const next = ((i % n) + n) % n;
            target.current = next;
            indexRef.current = next;
            setIndex(next);
            window.clearTimeout(targetTimer.current);
            targetTimer.current = window.setTimeout(settle, 1000);
            el.scrollTo({ left: next * step(), behavior: reducedMotion() ? "auto" : "smooth" });
        },
        [step],
    );

    const base = () => target.current ?? indexRef.current;
    const prev = useCallback(() => goTo(base() - 1), [goTo]);
    const next = useCallback(() => goTo(base() + 1), [goTo]);

    const onScroll = () => {
        const el = scroller.current;
        if (!el) return;
        const n = positionsRef.current;
        if (target.current !== null) {
            const dest = Math.min(target.current * step(), maxScroll());
            if (Math.abs(el.scrollLeft - dest) < 2) settle();
            return;
        }
        const atEnd = el.scrollLeft >= maxScroll() - 2 && maxScroll() > 0;
        const i = atEnd ? n - 1 : Math.min(n - 1, Math.round(el.scrollLeft / step()));
        if (i !== indexRef.current) {
            indexRef.current = i;
            setIndex(i);
        }
    };

    // autoplay contínuo: único intervalo, nunca pausa por hover ou foco
    const nextRef = useRef(next);
    useEffect(() => {
        nextRef.current = next;
    }, [next]);
    useEffect(() => {
        if (!autoPlay || count < 2 || reducedMotion()) return;
        const timer = window.setInterval(() => {
            if (touching.current || document.hidden) return;
            nextRef.current();
        }, autoPlay);
        return () => window.clearInterval(timer);
    }, [autoPlay, count]);

    const onKeyDown = (e: KeyboardEvent<HTMLDivElement>) => {
        const t = e.target as HTMLElement;
        if (t.tagName === "INPUT" || t.tagName === "TEXTAREA" || t.isContentEditable) return;
        if (e.key === "ArrowLeft") {
            e.preventDefault();
            prev();
        } else if (e.key === "ArrowRight") {
            e.preventDefault();
            next();
        }
    };

    if (count === 0) return null;

    const api: CarouselApi = { index, positions, prev, next, goTo };
    const showControls = controls !== "none" && positions > 1;
    const scrollerStyle = { "--cv": itemsVisible, "--cvm": itemsVisibleMobile ?? itemsVisible } as CSSProperties;

    return (
        <div
            className={`${styles.root} ${className ?? ""}`}
            role="group"
            aria-roledescription="carrossel"
            aria-label={ariaLabel}
            onKeyDown={onKeyDown}
        >
            {renderBefore && <Slot render={renderBefore} api={api} />}
            <div className={`${styles.stage} ${styles[controls]}`}>
                <div
                    ref={scroller}
                    className={`${styles.scroller} ${scrollerClassName ?? ""}`}
                    style={scrollerStyle}
                    tabIndex={0}
                    onScroll={onScroll}
                    onWheel={settle}
                    onTouchStart={() => {
                        touching.current = true;
                        settle();
                    }}
                    onTouchEnd={() => (touching.current = false)}
                    onTouchCancel={() => (touching.current = false)}
                >
                    {slides.map((slide, i) => (
                        <div
                            key={i}
                            className={styles.slide}
                            role="group"
                            aria-roledescription="slide"
                            aria-label={`${i + 1} de ${count}`}
                        >
                            {slide}
                        </div>
                    ))}
                </div>
                {showControls && (
                    <div className={`${styles.controls} ${hideControlsOnMobile ? styles.hideMobile : ""}`}>
                        <Button variant="secondary" aria-label="Anterior" onClick={prev} className={`${styles.arrow} ${styles.arrowPrev}`}>
                            <ArrowLeft />
                        </Button>
                        <div className={styles.dots}>
                            {Array.from({ length: positions }, (_, i) => (
                                <button
                                    key={i}
                                    type="button"
                                    aria-label={`Ir para o item ${i + 1}`}
                                    aria-current={i === index}
                                    onClick={() => goTo(i)}
                                    className={`${styles.dot} ${i === index ? styles.dotOn : ""}`}
                                />
                            ))}
                        </div>
                        <Button variant="accent" aria-label="Próximo" onClick={next} className={`${styles.arrow} ${styles.arrowNext}`}>
                            <ArrowRight />
                        </Button>
                    </div>
                )}
            </div>
            {renderAfter && <Slot render={renderAfter} api={api} />}
        </div>
    );
}
