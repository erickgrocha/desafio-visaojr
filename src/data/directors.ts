import type { RegisteredStudios } from "./studios"

export type Director = {
    slug: string
    name: string
    image: string
    studio: RegisteredStudios
}

export const directors = {
    "hidetaka-miyazaki": {
        slug: "hidetaka-miyazaki",
        name: "Hidetaka Miyazaki",
        // Wikimedia Commons, CC BY-SA 4.0
        image: "https://commons.wikimedia.org/wiki/Special:FilePath/Hidetaka_Miyazaki,_The_Game_Awards_2022_(cropped).png?width=600",
        studio: "fromsoftware"
    },
    "shigeru-miyamoto": {
        slug: "shigeru-miyamoto",
        name: "Shigeru Miyamoto",
        // Wikimedia Commons, CC BY 4.0
        image: "https://commons.wikimedia.org/wiki/Special:FilePath/Miyamoto_Shigeru_2026.jpg?width=600",
        studio: "nintendo-epd"
    },
    "hideo-kojima": {
        slug: "hideo-kojima",
        name: "Hideo Kojima",
        // Wikimedia Commons, CC BY-SA 4.0
        image: "https://commons.wikimedia.org/wiki/Special:FilePath/Hideo_Kojima_2025_SXSW_(cropped).jpg?width=600",
        studio: "kojima-productions"
    },
    "yuji-naka": {
        slug: "yuji-naka",
        name: "Yuji Naka",
        // Wikimedia Commons, CC BY-SA 3.0
        image: "https://commons.wikimedia.org/wiki/Special:FilePath/Yuji_Naka'_-_Magic_-_Monaco_-_2015-03-21-_P1030036_(cropped).jpg?width=600",
        studio: "sonic-team"
    },
    "neil-druckmann": {
        slug: "neil-druckmann",
        name: "Neil Druckmann",
        // Wikimedia Commons, CC BY-SA 4.0
        image: "https://commons.wikimedia.org/wiki/Special:FilePath/Neil_Druckmann,_co-director,_at_SXSW_2025_01_(cropped).jpg?width=600",
        studio: "naughty-dog"
    },
    "cory-barlog": {
        slug: "cory-barlog",
        name: "Cory Barlog",
        // Wikimedia Commons, Public domain
        image: "https://commons.wikimedia.org/wiki/Special:FilePath/Cory_Barlog,_Gamelab_2019_(cropped).jpg?width=600",
        studio: "santa-monica-studio"
    },
    "todd-howard": {
        slug: "todd-howard",
        name: "Todd Howard",
        // Wikimedia Commons, CC BY-SA 4.0
        image: "https://commons.wikimedia.org/wiki/Special:FilePath/Todd_Howard,_SXSW_2024_(2).jpg?width=600",
        studio: "bethesda-game-studios"
    },
    "dan-houser": {
        slug: "dan-houser",
        name: "Dan Houser",
        // Wikimedia Commons, CC BY-SA 4.0
        image: "https://commons.wikimedia.org/wiki/Special:FilePath/Dan_Houser_at_Rockstar_Games.png?width=600",
        studio: "rockstar-games"
    },
    "hidemaro-fujibayashi": {
        slug: "hidemaro-fujibayashi",
        name: "Hidemaro Fujibayashi",
        // Wikimedia Commons, CC BY 2.0
        image: "https://commons.wikimedia.org/wiki/Special:FilePath/Hidemaro_Fujibayashi_-_GDC_2017_(cropped).jpg?width=600",
        studio: "nintendo-epd"
    },
    "kosuke-yabuki": {
        slug: "kosuke-yabuki",
        name: "Kosuke Yabuki",
        image: "/directors/kosuke-yabuki.jpg",
        studio: "nintendo-epd"
    },
    "kazuya-takahashi": {
        slug: "kazuya-takahashi",
        name: "Kazuya Takahashi",
        image: "/directors/kazuya-takahashi.jpg",
        studio: "nintendo-epd"
    },
    "masahiro-sakurai": {
        slug: "masahiro-sakurai",
        name: "Masahiro Sakurai",
        // Wikimedia Commons, CC BY 3.0
        image: "https://commons.wikimedia.org/wiki/Special:FilePath/Masahiro_Sakurai_2021.jpg?width=600",
        studio: "sora-ltd"
    },
    "takashi-iizuka": {
        slug: "takashi-iizuka",
        name: "Takashi Iizuka",
        // Wikimedia Commons, CC BY 3.0
        image: "https://commons.wikimedia.org/wiki/Special:FilePath/A_signing_with_Mr_Takashi_Iizuka_(Cropped).jpg?width=600",
        studio: "sonic-team"
    },
    "guillaume-broche": {
        slug: "guillaume-broche",
        name: "Guillaume Broche",
        image: "/directors/guillaume-broche.jpg",
        studio: "sandfall-interactive"
    },
    "hideaki-itsuno": {
        slug: "hideaki-itsuno",
        name: "Hideaki Itsuno",
        image: "/directors/hideaki-itsuno.jpg",
        studio: "capcom"
    },
    "yuya-tokuda": {
        slug: "yuya-tokuda",
        name: "Yuya Tokuda",
        image: "/directors/yuya-tokuda.jpg",
        studio: "capcom"
    },
    "kazunori-kadoi": {
        slug: "kazunori-kadoi",
        name: "Kazunori Kadoi",
        image: "/directors/kazunori-kadoi.jpg",
        studio: "capcom"
    },
    "koshi-nakanishi": {
        slug: "koshi-nakanishi",
        name: "Koshi Nakanishi",
        image: "/directors/koshi-nakanishi.jpg",
        studio: "capcom"
    },
    "takayuki-nakayama": {
        slug: "takayuki-nakayama",
        name: "Takayuki Nakayama",
        image: "/directors/takayuki-nakayama.jpg",
        studio: "capcom"
    },
    "yoko-taro": {
        slug: "yoko-taro",
        name: "Yoko Taro",
        // Wikimedia Commons, CC BY 2.0
        image: "https://commons.wikimedia.org/wiki/Special:FilePath/GDCA_-_Yoko_Taro_(cropped).jpg?width=600",
        studio: "platinumgames"
    },
    "swen-vincke": {
        slug: "swen-vincke",
        name: "Swen Vincke",
        // Wikimedia Commons, CC BY 2.0
        image: "https://commons.wikimedia.org/wiki/Special:FilePath/Game_Developers_Choice_Awards_2024_-_Baldur's_Gate_3_-_Best_Narrative_-_5_-_Swen_Vincke_(cropped).jpg?width=600",
        studio: "larian-studios"
    },
    "katsura-hashino": {
        slug: "katsura-hashino",
        name: "Katsura Hashino",
        image: "/directors/katsura-hashino.jpg",
        studio: "atlus"
    },
    "bryan-intihar": {
        slug: "bryan-intihar",
        name: "Bryan Intihar",
        image: "/directors/bryan-intihar.jpg",
        studio: "insomniac-games"
    },
    "greg-kasavin": {
        slug: "greg-kasavin",
        name: "Greg Kasavin",
        // Wikimedia Commons, CC BY-SA 3.0
        image: "https://commons.wikimedia.org/wiki/Special:FilePath/Greg_Kasavin_at_IndieCade_2013.png?width=600",
        studio: "supergiant-games"
    },
    "kazunori-yamauchi": {
        slug: "kazunori-yamauchi",
        name: "Kazunori Yamauchi",
        // Wikimedia Commons, CC BY-SA 4.0
        image: "https://commons.wikimedia.org/wiki/Special:FilePath/Festival_automobile_international_2015_-_Kazunori_Yamauchi_-_006.jpg?width=600",
        studio: "polyphony-digital"
    },
    "mathijs-de-jonge": {
        slug: "mathijs-de-jonge",
        name: "Mathijs de Jonge",
        image: "/directors/mathijs-de-jonge.jpg",
        studio: "guerrilla-games"
    },
    "nate-fox": {
        slug: "nate-fox",
        name: "Nate Fox",
        // Wikimedia Commons, CC BY 2.0
        image: "https://commons.wikimedia.org/wiki/Special:FilePath/Nate_Fox,_Game_Developers_Conference_2010_-_Day_3_(4424681039)_(cropped).jpg?width=500",
        studio: "sucker-punch-productions"
    },
    "sam-lake": {
        slug: "sam-lake",
        name: "Sam Lake",
        // Wikimedia Commons, CC BY 4.0
        image: "https://commons.wikimedia.org/wiki/Special:FilePath/Sam_Lake-MichaelF%C3%B6rtsch.jpg?width=600",
        studio: "remedy-entertainment"
    },
    "stig-asmussen": {
        slug: "stig-asmussen",
        name: "Stig Asmussen",
        image: "/directors/stig-asmussen.jpg",
        studio: "respawn-entertainment"
    },
    "jean-guesdon": {
        slug: "jean-guesdon",
        name: "Jean Guesdon",
        image: "/directors/jean-guesdon.jpg",
        studio: "ubisoft"
    },
    "mounir-radi": {
        slug: "mounir-radi",
        name: "Mounir Radi",
        image: "/directors/mounir-radi.jpg",
        studio: "ubisoft"
    },
    "michel-ancel": {
        slug: "michel-ancel",
        name: "Michel Ancel",
        // Wikimedia Commons, CC BY-SA 4.0
        image: "https://commons.wikimedia.org/wiki/Special:FilePath/Michel_Ancel.jpg?width=600",
        studio: "ubisoft"
    },
    "jens-bergensten": {
        slug: "jens-bergensten",
        name: "Jens Bergensten",
        // Wikimedia Commons, CC BY-SA 2.0
        image: "https://commons.wikimedia.org/wiki/Special:FilePath/Jeb_at_PAX_Prime_2012_(cropped).jpg?width=600",
        studio: "mojang-studios"
    },
    "feng-ji": {
        slug: "feng-ji",
        name: "Feng Ji",
        image: "/directors/feng-ji.jpg",
        studio: "game-science"
    },
    "sean-murray": {
        slug: "sean-murray",
        name: "Sean Murray",
        // Wikimedia Commons, CC BY 2.0
        image: "https://commons.wikimedia.org/wiki/Special:FilePath/Sean_murray_gdc_2017_cropped.jpg?width=500",
        studio: "hello-games"
    },
    "eric-barone": {
        slug: "eric-barone",
        name: "Eric Barone",
        // Wikimedia Commons, CC BY 2.0
        image: "https://commons.wikimedia.org/wiki/Special:FilePath/Hackfort_2019_-_Conversations_with_Eric_Barone_09_(cropped).jpg?width=600",
        studio: "concernedape"
    },
    "ari-gibson": {
        slug: "ari-gibson",
        name: "Ari Gibson",
        // Wikimedia Commons, CC0
        image: "https://commons.wikimedia.org/wiki/Special:FilePath/Ari_Gibson_2024_3_(brightened).jpg?width=600",
        studio: "team-cherry"
    },
    "adam-badowski": {
        slug: "adam-badowski",
        name: "Adam Badowski",
        // Wikimedia Commons, CC BY-SA 4.0
        image: "https://commons.wikimedia.org/wiki/Special:FilePath/Adam_Badowski_(cropped_1).jpg?width=600",
        studio: "cd-projekt-red"
    },
    "konrad-tomaszkiewicz": {
        slug: "konrad-tomaszkiewicz",
        name: "Konrad Tomaszkiewicz",
        image: "/directors/konrad-tomaszkiewicz.jpg",
        studio: "cd-projekt-red"
    },
    "naoki-hamaguchi": {
        slug: "naoki-hamaguchi",
        name: "Naoki Hamaguchi",
        // Wikimedia Commons, CC BY 3.0
        image: "https://commons.wikimedia.org/wiki/Special:FilePath/Naoki_Hamaguchi,_2024_(cropped).jpg?width=600",
        studio: "square-enix"
    },
    "hiroshi-takai": {
        slug: "hiroshi-takai",
        name: "Hiroshi Takai",
        image: "/directors/hiroshi-takai.jpg",
        studio: "square-enix"
    },
    "yuji-horii": {
        slug: "yuji-horii",
        name: "Yuji Horii",
        // Wikimedia Commons, CC BY-SA 2.0
        image: "https://commons.wikimedia.org/wiki/Special:FilePath/Yuji_Horii_(2).jpg?width=600",
        studio: "square-enix"
    },
    "fumito-ueda": {
        slug: "fumito-ueda",
        name: "Fumito Ueda",
        // Wikimedia Commons, CC BY-SA 4.0
        image: "https://commons.wikimedia.org/wiki/Special:FilePath/FumitoUedaE32016_(cropped).jpg?width=600",
        studio: "gendesign"
    },
    "mike-brown": {
        slug: "mike-brown",
        name: "Mike Brown",
        image: "/directors/mike-brown.jpg",
        studio: "playground-games"
    }
} satisfies Record<string, Director>;

export type RegisteredDirectors = keyof typeof directors
