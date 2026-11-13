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
