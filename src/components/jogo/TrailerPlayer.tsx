import { useCallback, useEffect, useRef, useState } from "react";
import type { KeyboardEvent, PointerEvent } from "react";
import { PlayerState, loadYouTubeApi, youtubeThumb, youtubeWatchUrl, type YTPlayer } from "./youtube";
import styles from "./TrailerPlayer.module.css";

type Props = {
    videoId: string;
    /** URL original do trailer (usada no link de fallback). */
    url?: string;
    title: string;
    /** Começa a tocar assim que o player ficar pronto (usado após o clique numa miniatura). */
    autoPlay?: boolean;
};

type Phase = "poster" | "loading" | "ready" | "error";

const SEEK_STEP = 5;
const HIDE_AFTER_MS = 3000;
const LOAD_TIMEOUT_MS = 15000;
const BLOCKED_TIMEOUT_MS = 2500;

function fmt(s: number): string {
    if (!Number.isFinite(s) || s < 0) s = 0;
    const m = Math.floor(s / 60);
    const sec = Math.floor(s % 60);
    return `${m}:${sec.toString().padStart(2, "0")}`;
}

type FsElement = HTMLElement & { webkitRequestFullscreen?: () => Promise<void> | void };
type FsDocument = Document & { webkitFullscreenElement?: Element | null; webkitExitFullscreen?: () => Promise<void> | void };

export function TrailerPlayer({ videoId, url, title, autoPlay = false }: Props) {
    const rootRef = useRef<HTMLDivElement>(null);
    const mountRef = useRef<HTMLDivElement>(null);
    const barRef = useRef<HTMLDivElement>(null);
    const playerRef = useRef<YTPlayer | null>(null);
    const hideTimer = useRef<number | undefined>(undefined);
    const draggingRef = useRef(false);

    const [requested, setRequested] = useState(autoPlay);
    const [phase, setPhase] = useState<Phase>(autoPlay ? "loading" : "poster");
    const [ready, setReady] = useState(false);
    const [playing, setPlaying] = useState(false);
    const [buffering, setBuffering] = useState(false);
    const [time, setTime] = useState(0);
    const [duration, setDuration] = useState(0);
    const [muted, setMuted] = useState(false);
    const [volume, setVolume] = useState(100);
    const [visible, setVisible] = useState(true);
    const [fullscreen, setFullscreen] = useState(false);
    const [pseudoFull, setPseudoFull] = useState(false);
    const [dragging, setDragging] = useState(false);

    const watchUrl = url ?? youtubeWatchUrl(videoId);

    // Cria e destrói o player. O cleanup cancela, pausa e remove tudo (seguro em StrictMode).
    useEffect(() => {
        if (!requested) return;
        const host = document.createElement("div");
        host.className = styles.iframeHost;
        mountRef.current?.appendChild(host);
        let cancelled = false;
        let player: YTPlayer | null = null;
        let poll: number | undefined;
        let blockedTimer: number | undefined;

        const loadTimer = window.setTimeout(() => {
            if (!cancelled && !player) setPhase("error");
        }, LOAD_TIMEOUT_MS);

        const stopPoll = () => {
            if (poll !== undefined) window.clearInterval(poll);
            poll = undefined;
        };
        const sync = () => {
            if (!player || draggingRef.current) return;
            setTime(player.getCurrentTime() || 0);
            setDuration(player.getDuration() || 0);
        };

        loadYouTubeApi()
            .then((YT) => {
                if (cancelled) return;
                player = new YT.Player(host, {
                    videoId,
                    host: "https://www.youtube-nocookie.com",
                    width: "100%",
                    height: "100%",
                    playerVars: { controls: 0, modestbranding: 1, rel: 0, playsinline: 1, iv_load_policy: 3, disablekb: 1, fs: 0 },
                    events: {
                        onReady: (e) => {
                            if (cancelled) return;
                            window.clearTimeout(loadTimer);
                            playerRef.current = e.target;
                            setReady(true);
                            setDuration(e.target.getDuration() || 0);
                            setMuted(e.target.isMuted());
                            setVolume(e.target.getVolume());
                            e.target.playVideo();
                            // Se o navegador bloquear a reprodução, volta para a capa para um novo clique.
                            blockedTimer = window.setTimeout(() => {
                                if (cancelled || !player) return;
                                const st = player.getPlayerState();
                                if (st !== PlayerState.PLAYING && st !== PlayerState.BUFFERING) setPhase("poster");
                            }, BLOCKED_TIMEOUT_MS);
                        },
                        onStateChange: (e) => {
                            if (cancelled) return;
                            const st = e.data;
                            const isPlaying = st === PlayerState.PLAYING;
                            setPlaying(isPlaying);
                            setBuffering(st === PlayerState.BUFFERING);
                            if (st === PlayerState.PLAYING || st === PlayerState.BUFFERING || st === PlayerState.PAUSED || st === PlayerState.ENDED) {
                                setPhase((p) => (p === "error" ? p : "ready"));
                            }
                            stopPoll();
                            if (isPlaying) poll = window.setInterval(sync, 250);
                            sync();
                        },
                        onError: () => {
                            if (!cancelled) setPhase("error");
                        },
                    },
                });
            })
            .catch(() => {
                if (!cancelled) setPhase("error");
            });

        return () => {
            cancelled = true;
            window.clearTimeout(loadTimer);
            window.clearTimeout(blockedTimer);
            stopPoll();
            playerRef.current = null;
            try {
                player?.pauseVideo();
                player?.destroy();
            } catch {
                /* player já destruído */
            }
            host.remove();
        };
    }, [requested, videoId]);

    // Limpa o timer de auto-ocultar ao desmontar.
    useEffect(() => () => window.clearTimeout(hideTimer.current), []);

    // Fullscreen: acompanha mudanças feitas pelo navegador (ex.: Esc).
    useEffect(() => {
        const onChange = () => {
            const d = document as FsDocument;
            setFullscreen((d.fullscreenElement ?? d.webkitFullscreenElement) === rootRef.current);
        };
        document.addEventListener("fullscreenchange", onChange);
        document.addEventListener("webkitfullscreenchange", onChange);
        return () => {
            document.removeEventListener("fullscreenchange", onChange);
            document.removeEventListener("webkitfullscreenchange", onChange);
        };
    }, []);

    // Esc sai da tela cheia simulada.
    useEffect(() => {
        if (!pseudoFull) return;
        const onKey = (e: globalThis.KeyboardEvent) => {
            if (e.key === "Escape") setPseudoFull(false);
        };
        document.addEventListener("keydown", onKey);
        return () => document.removeEventListener("keydown", onKey);
    }, [pseudoFull]);

    const reveal = useCallback(() => {
        setVisible(true);
        window.clearTimeout(hideTimer.current);
        hideTimer.current = window.setTimeout(() => setVisible(false), HIDE_AFTER_MS);
    }, []);

    const start = () => {
        setPhase("loading");
        const p = playerRef.current;
        if (p) {
            p.playVideo();
        } else {
            setRequested(true);
        }
    };

    const togglePlay = () => {
        const p = playerRef.current;
        if (!p) {
            if (phase === "poster") start();
            return;
        }
        if (p.getPlayerState() === PlayerState.PLAYING || p.getPlayerState() === PlayerState.BUFFERING) p.pauseVideo();
        else p.playVideo();
    };

    const seekBy = (delta: number) => {
        const p = playerRef.current;
        if (!p) return;
        const max = p.getDuration() || 0;
        const next = Math.min(Math.max(0, p.getCurrentTime() + delta), max);
        p.seekTo(next, true);
        setTime(next);
    };

    const toggleMute = () => {
        const p = playerRef.current;
        if (!p) return;
        if (p.isMuted() || p.getVolume() === 0) {
            p.unMute();
            if (p.getVolume() === 0) {
                p.setVolume(50);
                setVolume(50);
            }
            setMuted(false);
        } else {
            p.mute();
            setMuted(true);
        }
    };

    const changeVolume = (v: number) => {
        const p = playerRef.current;
        setVolume(v);
        if (!p) return;
        p.setVolume(v);
        if (v === 0) {
            p.mute();
            setMuted(true);
        } else if (p.isMuted()) {
            p.unMute();
            setMuted(false);
        }
    };

    const toggleFullscreen = () => {
        const el = rootRef.current as FsElement | null;
        const d = document as FsDocument;
        if (!el) return;
        if (fullscreen) {
            void (d.exitFullscreen?.() ?? d.webkitExitFullscreen?.());
            return;
        }
        if (pseudoFull) {
            setPseudoFull(false);
            return;
        }
        const req = el.requestFullscreen?.bind(el) ?? el.webkitRequestFullscreen?.bind(el);
        if (!req) {
            setPseudoFull(true);
            return;
        }
        try {
            Promise.resolve(req()).catch(() => setPseudoFull(true));
        } catch {
            setPseudoFull(true);
        }
    };

    const ratio = duration > 0 ? Math.min(1, Math.max(0, time / duration)) : 0;

    const seekFromPointer = (e: PointerEvent<HTMLDivElement>): number => {
        const rect = barRef.current?.getBoundingClientRect();
        if (!rect || rect.width === 0 || duration <= 0) return time;
        return Math.min(1, Math.max(0, (e.clientX - rect.left) / rect.width)) * duration;
    };
    const onBarDown = (e: PointerEvent<HTMLDivElement>) => {
        if (!playerRef.current) return;
        e.currentTarget.setPointerCapture(e.pointerId);
        draggingRef.current = true;
        setDragging(true);
        setTime(seekFromPointer(e));
    };
    const onBarMove = (e: PointerEvent<HTMLDivElement>) => {
        if (draggingRef.current) setTime(seekFromPointer(e));
    };
    const endDrag = (e: PointerEvent<HTMLDivElement>, commit: boolean) => {
        if (!draggingRef.current) return;
        draggingRef.current = false;
        setDragging(false);
        if (commit) {
            const t = seekFromPointer(e);
            playerRef.current?.seekTo(t, true);
            setTime(t);
        }
    };
    const onBarKey = (e: KeyboardEvent<HTMLDivElement>) => {
        const p = playerRef.current;
        if (!p) return;
        let handled = true;
        if (e.key === "ArrowRight" || e.key === "ArrowUp") seekBy(SEEK_STEP);
        else if (e.key === "ArrowLeft" || e.key === "ArrowDown") seekBy(-SEEK_STEP);
        else if (e.key === "Home") p.seekTo(0, true);
        else if (e.key === "End") p.seekTo(Math.max(0, (p.getDuration() || 0) - 1), true);
        else handled = false;
        if (handled) {
            e.preventDefault();
            e.stopPropagation();
        }
    };

    const onKeyDown = (e: KeyboardEvent<HTMLDivElement>) => {
        reveal();
        const target = e.target as HTMLElement;
        if (e.altKey || e.ctrlKey || e.metaKey) return;
        const onButton = target.tagName === "BUTTON" || target.tagName === "A";
        const key = e.key.toLowerCase();
        if ((e.key === " " || e.key === "Enter") && onButton) return; // deixa o botão focado agir
        if (target.tagName === "INPUT" && (key === "arrowleft" || key === "arrowright" || key === "arrowup" || key === "arrowdown")) return;
        if (phase === "error") return;
        if (e.key === " " || key === "k") togglePlay();
        else if (key === "m") toggleMute();
        else if (key === "f") toggleFullscreen();
        else if (e.key === "ArrowRight") seekBy(SEEK_STEP);
        else if (e.key === "ArrowLeft") seekBy(-SEEK_STEP);
        else if (key === "escape" && !pseudoFull) return;
        else return;
        e.preventDefault();
    };

    const showControls = phase === "ready" && (visible || !playing || dragging);
    const showPoster = phase === "poster" || phase === "loading";

    return (
        <div
            ref={rootRef}
            className={`${styles.root} ${pseudoFull ? styles.pseudoFull : ""} ${showControls ? "" : styles.idle}`}
            role="group"
            aria-label={`Player do trailer de ${title}`}
            aria-roledescription="player de vídeo"
            tabIndex={0}
            onKeyDown={onKeyDown}
            onPointerMove={reveal}
            onPointerDown={reveal}
            onFocus={reveal}
        >
            <div ref={mountRef} className={styles.video} aria-hidden="true" />

            {phase === "error" ? (
                <div className={styles.error} role="alert">
                    <p className={styles.errorTitle}>Trailer indisponível</p>
                    <a className={styles.errorLink} href={watchUrl} target="_blank" rel="noopener noreferrer">
                        Assistir no YouTube
                    </a>
                </div>
            ) : (
                <>
                    {phase === "ready" && (
                        <button
                            type="button"
                            className={styles.surface}
                            onClick={togglePlay}
                            aria-label={playing ? "Pausar trailer" : "Reproduzir trailer"}
                            tabIndex={-1}
                        />
                    )}

                    {showPoster && (
                        <div className={styles.poster}>
                            <img className={styles.posterImg} src={youtubeThumb(videoId)} alt="" />
                            <button
                                type="button"
                                className={styles.bigPlay}
                                onClick={start}
                                disabled={phase === "loading" && !ready}
                                aria-label={`Assistir ao trailer de ${title}`}
                            >
                                <span className={styles.bigIcon} aria-hidden="true">
                                    <svg viewBox="0 0 16 16" shapeRendering="crispEdges">
                                        <path d="M4 2h2v2h2v2h2v2h2v2h-2v2H8v2H6v2H4z" fill="currentColor" />
                                    </svg>
                                </span>
                                <span className={styles.bigText}>{phase === "loading" ? "Carregando..." : "Assistir ao trailer"}</span>
                            </button>
                        </div>
                    )}

                    {phase === "ready" && buffering && (
                        <div className={styles.buffering} role="status">
                            <span className={styles.spinner} aria-hidden="true" />
                            <span className={styles.srOnly}>Carregando vídeo</span>
                        </div>
                    )}

                    {phase === "ready" && (
                        <div className={styles.controls}>
                            <div
                                ref={barRef}
                                className={styles.bar}
                                role="slider"
                                tabIndex={0}
                                aria-label="Progresso do trailer"
                                aria-valuemin={0}
                                aria-valuemax={Math.floor(duration)}
                                aria-valuenow={Math.floor(time)}
                                aria-valuetext={`${fmt(time)} de ${fmt(duration)}`}
                                onPointerDown={onBarDown}
                                onPointerMove={onBarMove}
                                onPointerUp={(e) => endDrag(e, true)}
                                onPointerCancel={(e) => endDrag(e, false)}
                                onKeyDown={onBarKey}
                            >
                                <span className={styles.track}>
                                    <span className={styles.fill} style={{ width: `${ratio * 100}%` }} />
                                    <span className={styles.knob} style={{ left: `${ratio * 100}%` }} />
                                </span>
                            </div>
                            <div className={styles.row}>
                                <button
                                    type="button"
                                    className={styles.btn}
                                    onClick={togglePlay}
                                    aria-label={playing ? "Pausar trailer" : "Reproduzir trailer"}
                                >
                                    <svg viewBox="0 0 16 16" aria-hidden="true" shapeRendering="crispEdges">
                                        {playing ? (
                                            <path d="M3 2h4v12H3zM9 2h4v12H9z" fill="currentColor" />
                                        ) : (
                                            <path d="M4 2h2v2h2v2h2v2h2v2h-2v2H8v2H6v2H4z" fill="currentColor" />
                                        )}
                                    </svg>
                                </button>
                                <span className={styles.time}>
                                    {fmt(time)} / {fmt(duration)}
                                </span>
                                <span className={styles.spacer} />
                                <button
                                    type="button"
                                    className={styles.btn}
                                    onClick={toggleMute}
                                    aria-label={muted || volume === 0 ? "Ativar som" : "Silenciar"}
                                    aria-pressed={muted || volume === 0}
                                >
                                    <svg viewBox="0 0 16 16" aria-hidden="true" shapeRendering="crispEdges">
                                        <path d="M2 6h3l3-3v10l-3-3H2z" fill="currentColor" />
                                        {muted || volume === 0 ? (
                                            <path d="M10 6l1 1 1-1 1 1-1 1 1 1-1 1-1-1-1 1-1-1 1-1-1-1z" fill="currentColor" />
                                        ) : (
                                            <path d="M10 6h1v4h-1zM12 4h1v8h-1z" fill="currentColor" />
                                        )}
                                    </svg>
                                </button>
                                <input
                                    className={styles.volume}
                                    type="range"
                                    min={0}
                                    max={100}
                                    step={5}
                                    value={muted ? 0 : volume}
                                    onChange={(e) => changeVolume(Number(e.target.value))}
                                    aria-label="Volume do trailer"
                                />
                                <button
                                    type="button"
                                    className={styles.btn}
                                    onClick={toggleFullscreen}
                                    aria-label={fullscreen || pseudoFull ? "Sair da tela cheia" : "Tela cheia"}
                                    aria-pressed={fullscreen || pseudoFull}
                                >
                                    <svg viewBox="0 0 16 16" aria-hidden="true" shapeRendering="crispEdges">
                                        <path d="M2 2h5v2H4v3H2zM9 2h5v5h-2V4H9zM2 9h2v3h3v2H2zM12 9h2v5H9v-2h3z" fill="currentColor" />
                                    </svg>
                                </button>
                            </div>
                        </div>
                    )}
                </>
            )}
        </div>
    );
}
