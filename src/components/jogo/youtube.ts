const ID = /^[\w-]{11}$/;
const HOSTS = ["youtube.com", "www.youtube.com", "m.youtube.com", "music.youtube.com", "youtube-nocookie.com", "www.youtube-nocookie.com"];

/** Extrai o id de um link do YouTube (watch?v=, youtu.be/, embed/, shorts/). Devolve undefined se não for válido. */
export function youtubeId(url: string | undefined): string | undefined {
    if (!url) return undefined;
    let u: URL;
    try {
        u = new URL(url.trim());
    } catch {
        return undefined;
    }
    if (u.protocol !== "https:" && u.protocol !== "http:") return undefined;
    const host = u.hostname.toLowerCase();
    let id: string | null | undefined;
    if (host === "youtu.be" || host === "www.youtu.be") {
        id = u.pathname.split("/")[1];
    } else if (HOSTS.includes(host)) {
        const parts = u.pathname.split("/").filter(Boolean);
        if (parts[0] === "embed" || parts[0] === "shorts" || parts[0] === "v") id = parts[1];
        else id = u.searchParams.get("v");
    }
    return id && ID.test(id) ? id : undefined;
}

export function youtubeThumb(id: string): string {
    return `https://i.ytimg.com/vi/${id}/hqdefault.jpg`;
}

export function youtubeWatchUrl(id: string): string {
    return `https://www.youtube.com/watch?v=${id}`;
}

/** Trailer do jogo: primeiro item de media que seja um link válido do YouTube. */
export function trailerOf(media: string[]): { id: string; url: string } | undefined {
    const first = media.find((m) => !m.startsWith("/"));
    const id = youtubeId(first);
    return id && first ? { id, url: first } : undefined;
}

/* ---- YouTube IFrame Player API (tipos mínimos) ---- */

export const PlayerState = { UNSTARTED: -1, ENDED: 0, PLAYING: 1, PAUSED: 2, BUFFERING: 3, CUED: 5 } as const;

export interface YTPlayer {
    playVideo(): void;
    pauseVideo(): void;
    seekTo(seconds: number, allowSeekAhead: boolean): void;
    getCurrentTime(): number;
    getDuration(): number;
    getPlayerState(): number;
    mute(): void;
    unMute(): void;
    isMuted(): boolean;
    setVolume(volume: number): void;
    getVolume(): number;
    destroy(): void;
}

type YTEvent = { data: number; target: YTPlayer };

interface YTNamespace {
    Player: new (
        el: HTMLElement,
        opts: {
            videoId: string;
            host?: string;
            width?: string | number;
            height?: string | number;
            playerVars?: Record<string, string | number>;
            events?: {
                onReady?: (e: YTEvent) => void;
                onStateChange?: (e: YTEvent) => void;
                onError?: (e: YTEvent) => void;
            };
        },
    ) => YTPlayer;
}

declare global {
    interface Window {
        YT?: YTNamespace;
        onYouTubeIframeAPIReady?: () => void;
    }
}

let apiPromise: Promise<YTNamespace> | undefined;

/** Carrega o script da IFrame API uma única vez e reaproveita a promessa. */
export function loadYouTubeApi(): Promise<YTNamespace> {
    if (window.YT?.Player) return Promise.resolve(window.YT);
    if (apiPromise) return apiPromise;
    apiPromise = new Promise<YTNamespace>((resolve, reject) => {
        const previous = window.onYouTubeIframeAPIReady;
        window.onYouTubeIframeAPIReady = () => {
            previous?.();
            if (window.YT?.Player) resolve(window.YT);
            else reject(new Error("YT indisponível"));
        };
        const s = document.createElement("script");
        s.src = "https://www.youtube.com/iframe_api";
        s.async = true;
        s.onerror = () => {
            apiPromise = undefined;
            s.remove();
            reject(new Error("Falha ao carregar a API do YouTube"));
        };
        document.head.appendChild(s);
    });
    return apiPromise;
}
