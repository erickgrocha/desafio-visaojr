-- =====================================================================
-- Mayk Games — seed.sql
-- Dados de exemplo. Rode DEPOIS do schema.sql, no banco da loja.
-- Gerado a partir dos dados do front (src/data) por database/scripts/gerar-seed.mjs.
-- As ligações usam subconsultas por nome/slug, então não dependem dos ids.
-- =====================================================================
BEGIN;

-- ---------------------------------------------------------------------
-- Plataformas
-- ---------------------------------------------------------------------
INSERT INTO plataforma (nome) VALUES
    ('PlayStation 5'),
    ('PlayStation 4'),
    ('Xbox Series'),
    ('Xbox One'),
    ('Nintendo Switch'),
    ('Nintendo Switch 2'),
    ('PC');

-- ---------------------------------------------------------------------
-- Estúdios
-- ---------------------------------------------------------------------
INSERT INTO estudio (nome) VALUES
    ('FromSoftware'),
    ('Nintendo EPD'),
    ('Kojima Productions'),
    ('Sonic Team'),
    ('Naughty Dog'),
    ('Santa Monica Studio'),
    ('Bethesda Game Studios'),
    ('Rockstar Games'),
    ('CD Projekt Red'),
    ('Playground Games'),
    ('Sandfall Interactive'),
    ('Capcom'),
    ('Square Enix'),
    ('Ubisoft'),
    ('Team Cherry'),
    ('Larian Studios'),
    ('Atlus'),
    ('Insomniac Games'),
    ('Supergiant Games'),
    ('Sora Ltd.'),
    ('Mojang Studios'),
    ('Polyphony Digital'),
    ('Guerrilla Games'),
    ('Sucker Punch Productions'),
    ('Remedy Entertainment'),
    ('PlatinumGames'),
    ('Game Science'),
    ('Hello Games'),
    ('ConcernedApe'),
    ('Respawn Entertainment'),
    ('genDESIGN');

-- ---------------------------------------------------------------------
-- Distribuidoras
-- ---------------------------------------------------------------------
INSERT INTO distribuidora (nome) VALUES
    ('Bandai Namco'),
    ('Sony Interactive Entertainment'),
    ('Nintendo'),
    ('Sega'),
    ('Xbox Game Studios'),
    ('Bethesda Softworks'),
    ('Rockstar Games'),
    ('CD Projekt'),
    ('Kepler Interactive'),
    ('Capcom'),
    ('Square Enix'),
    ('Ubisoft'),
    ('Activision'),
    ('Electronic Arts'),
    ('Konami'),
    ('Epic Games Publishing'),
    ('Supergiant Games'),
    ('Team Cherry'),
    ('Larian Studios'),
    ('Hello Games'),
    ('ConcernedApe'),
    ('Game Science');

-- ---------------------------------------------------------------------
-- Diretores (Estúdio Emprega Diretor)
-- ---------------------------------------------------------------------
INSERT INTO diretor (nome, slug, foto, estudio_id)
SELECT v.nome, v.slug, v.foto, e.id
FROM (VALUES
    ('Hidetaka Miyazaki', 'hidetaka-miyazaki', 'https://commons.wikimedia.org/wiki/Special:FilePath/Hidetaka_Miyazaki,_The_Game_Awards_2022_(cropped).png?width=500', 'FromSoftware'),
    ('Shigeru Miyamoto', 'shigeru-miyamoto', 'https://commons.wikimedia.org/wiki/Special:FilePath/Miyamoto_Shigeru_2026.jpg?width=500', 'Nintendo EPD'),
    ('Hideo Kojima', 'hideo-kojima', 'https://commons.wikimedia.org/wiki/Special:FilePath/Hideo_Kojima_2025_SXSW_(cropped).jpg?width=500', 'Kojima Productions'),
    ('Yuji Naka', 'yuji-naka', 'https://commons.wikimedia.org/wiki/Special:FilePath/Yuji_Naka''_-_Magic_-_Monaco_-_2015-03-21-_P1030036_(cropped).jpg?width=500', 'Sonic Team'),
    ('Neil Druckmann', 'neil-druckmann', 'https://commons.wikimedia.org/wiki/Special:FilePath/Neil_Druckmann,_co-director,_at_SXSW_2025_01_(cropped).jpg?width=500', 'Naughty Dog'),
    ('Cory Barlog', 'cory-barlog', 'https://commons.wikimedia.org/wiki/Special:FilePath/Cory_Barlog,_Gamelab_2019_(cropped).jpg?width=500', 'Santa Monica Studio'),
    ('Todd Howard', 'todd-howard', 'https://commons.wikimedia.org/wiki/Special:FilePath/Todd_Howard,_SXSW_2024_(2).jpg?width=500', 'Bethesda Game Studios'),
    ('Dan Houser', 'dan-houser', 'https://commons.wikimedia.org/wiki/Special:FilePath/Dan_Houser_at_Rockstar_Games.png?width=500', 'Rockstar Games'),
    ('Hidemaro Fujibayashi', 'hidemaro-fujibayashi', 'https://commons.wikimedia.org/wiki/Special:FilePath/Hidemaro_Fujibayashi_-_GDC_2017_(cropped).jpg?width=500', 'Nintendo EPD'),
    ('Kosuke Yabuki', 'kosuke-yabuki', '/directors/kosuke-yabuki.jpg', 'Nintendo EPD'),
    ('Kazuya Takahashi', 'kazuya-takahashi', '/directors/kazuya-takahashi.jpg', 'Nintendo EPD'),
    ('Masahiro Sakurai', 'masahiro-sakurai', 'https://commons.wikimedia.org/wiki/Special:FilePath/Masahiro_Sakurai_2021.jpg?width=500', 'Sora Ltd.'),
    ('Takashi Iizuka', 'takashi-iizuka', 'https://commons.wikimedia.org/wiki/Special:FilePath/A_signing_with_Mr_Takashi_Iizuka_(Cropped).jpg?width=500', 'Sonic Team'),
    ('Guillaume Broche', 'guillaume-broche', '/directors/guillaume-broche.jpg', 'Sandfall Interactive'),
    ('Hideaki Itsuno', 'hideaki-itsuno', '/directors/hideaki-itsuno.jpg', 'Capcom'),
    ('Yuya Tokuda', 'yuya-tokuda', '/directors/yuya-tokuda.jpg', 'Capcom'),
    ('Kazunori Kadoi', 'kazunori-kadoi', '/directors/kazunori-kadoi.jpg', 'Capcom'),
    ('Koshi Nakanishi', 'koshi-nakanishi', '/directors/koshi-nakanishi.jpg', 'Capcom'),
    ('Takayuki Nakayama', 'takayuki-nakayama', '/directors/takayuki-nakayama.jpg', 'Capcom'),
    ('Yoko Taro', 'yoko-taro', 'https://commons.wikimedia.org/wiki/Special:FilePath/GDCA_-_Yoko_Taro_(cropped).jpg?width=500', 'PlatinumGames'),
    ('Swen Vincke', 'swen-vincke', 'https://commons.wikimedia.org/wiki/Special:FilePath/Game_Developers_Choice_Awards_2024_-_Baldur''s_Gate_3_-_Best_Narrative_-_5_-_Swen_Vincke_(cropped).jpg?width=500', 'Larian Studios'),
    ('Katsura Hashino', 'katsura-hashino', '/directors/katsura-hashino.jpg', 'Atlus'),
    ('Bryan Intihar', 'bryan-intihar', '/directors/bryan-intihar.jpg', 'Insomniac Games'),
    ('Greg Kasavin', 'greg-kasavin', 'https://commons.wikimedia.org/wiki/Special:FilePath/Greg_Kasavin_at_IndieCade_2013.png?width=500', 'Supergiant Games'),
    ('Kazunori Yamauchi', 'kazunori-yamauchi', 'https://commons.wikimedia.org/wiki/Special:FilePath/Festival_automobile_international_2015_-_Kazunori_Yamauchi_-_006.jpg?width=500', 'Polyphony Digital'),
    ('Mathijs de Jonge', 'mathijs-de-jonge', '/directors/mathijs-de-jonge.jpg', 'Guerrilla Games'),
    ('Nate Fox', 'nate-fox', 'https://commons.wikimedia.org/wiki/Special:FilePath/Nate_Fox,_Game_Developers_Conference_2010_-_Day_3_(4424681039)_(cropped).jpg?width=500', 'Sucker Punch Productions'),
    ('Sam Lake', 'sam-lake', 'https://commons.wikimedia.org/wiki/Special:FilePath/Sam_Lake-MichaelF%C3%B6rtsch.jpg?width=500', 'Remedy Entertainment'),
    ('Stig Asmussen', 'stig-asmussen', '/directors/stig-asmussen.jpg', 'Respawn Entertainment'),
    ('Jean Guesdon', 'jean-guesdon', '/directors/jean-guesdon.jpg', 'Ubisoft'),
    ('Mounir Radi', 'mounir-radi', '/directors/mounir-radi.jpg', 'Ubisoft'),
    ('Michel Ancel', 'michel-ancel', 'https://commons.wikimedia.org/wiki/Special:FilePath/Michel_Ancel.jpg?width=500', 'Ubisoft'),
    ('Jens Bergensten', 'jens-bergensten', 'https://commons.wikimedia.org/wiki/Special:FilePath/Jeb_at_PAX_Prime_2012_(cropped).jpg?width=500', 'Mojang Studios'),
    ('Feng Ji', 'feng-ji', '/directors/feng-ji.jpg', 'Game Science'),
    ('Sean Murray', 'sean-murray', 'https://commons.wikimedia.org/wiki/Special:FilePath/Sean_murray_gdc_2017_cropped.jpg?width=500', 'Hello Games'),
    ('Eric Barone', 'eric-barone', 'https://commons.wikimedia.org/wiki/Special:FilePath/Hackfort_2019_-_Conversations_with_Eric_Barone_09_(cropped).jpg?width=500', 'ConcernedApe'),
    ('Ari Gibson', 'ari-gibson', 'https://commons.wikimedia.org/wiki/Special:FilePath/Ari_Gibson_2024_3_(brightened).jpg?width=500', 'Team Cherry'),
    ('Adam Badowski', 'adam-badowski', 'https://commons.wikimedia.org/wiki/Special:FilePath/Adam_Badowski_(cropped_1).jpg?width=500', 'CD Projekt Red'),
    ('Konrad Tomaszkiewicz', 'konrad-tomaszkiewicz', '/directors/konrad-tomaszkiewicz.jpg', 'CD Projekt Red'),
    ('Naoki Hamaguchi', 'naoki-hamaguchi', 'https://commons.wikimedia.org/wiki/Special:FilePath/Naoki_Hamaguchi,_2024_(cropped).jpg?width=500', 'Square Enix'),
    ('Hiroshi Takai', 'hiroshi-takai', '/directors/hiroshi-takai.jpg', 'Square Enix'),
    ('Yuji Horii', 'yuji-horii', 'https://commons.wikimedia.org/wiki/Special:FilePath/Yuji_Horii_(2).jpg?width=500', 'Square Enix'),
    ('Fumito Ueda', 'fumito-ueda', 'https://commons.wikimedia.org/wiki/Special:FilePath/FumitoUedaE32016_(cropped).jpg?width=500', 'genDESIGN'),
    ('Mike Brown', 'mike-brown', '/directors/mike-brown.jpg', 'Playground Games')
) AS v(nome, slug, foto, estudio)
JOIN estudio e ON e.nome = v.estudio;

-- ---------------------------------------------------------------------
-- Jogos (Produto -> Jogo). Cada jogo cria a linha do pai e a do filho com o mesmo id.
-- ---------------------------------------------------------------------
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Elden Ring', 'elden-ring') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Explore as Terras Intermédias, um mundo aberto enorme cheio de castelos, cavernas e chefes inesquecíveis. Crie seu personagem, escolha seu estilo de luta e decida por onde começar a jornada.',
       (SELECT id FROM diretor WHERE slug = 'hidetaka-miyazaki'),
       (SELECT id FROM distribuidora WHERE nome = 'Bandai Namco')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Bloodborne', 'bloodborne') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Combate agressivo em uma cidade gótica assombrada. Cada caçada exige coragem e reflexo.',
       (SELECT id FROM diretor WHERE slug = 'hidetaka-miyazaki'),
       (SELECT id FROM distribuidora WHERE nome = 'Sony Interactive Entertainment')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Demon''s Souls', 'demons-souls') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'O ponto de partida da fórmula Souls, refeito do zero para o PlayStation 5.',
       (SELECT id FROM diretor WHERE slug = 'hidetaka-miyazaki'),
       (SELECT id FROM distribuidora WHERE nome = 'Sony Interactive Entertainment')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Dark Souls Remastered', 'dark-souls-remastered') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Volte a Lordran, com seus atalhos lendários e chefes que ensinam na base da paciência.',
       (SELECT id FROM diretor WHERE slug = 'hidetaka-miyazaki'),
       (SELECT id FROM distribuidora WHERE nome = 'Bandai Namco')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Dark Souls III', 'dark-souls-iii') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'O capítulo final da trilogia, com combate mais rápido e um reino em ruínas para atravessar.',
       (SELECT id FROM diretor WHERE slug = 'hidetaka-miyazaki'),
       (SELECT id FROM distribuidora WHERE nome = 'Bandai Namco')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Sekiro: Shadows Die Twice', 'sekiro') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Duelos de espada no Japão feudal, onde postura e tempo de reação decidem cada luta.',
       (SELECT id FROM diretor WHERE slug = 'hidetaka-miyazaki'),
       (SELECT id FROM distribuidora WHERE nome = 'Activision')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Super Mario Odyssey', 'super-mario-odyssey') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Viaje por reinos de todo o mundo com Mario e o chapéu Cappy, em busca de Bowser.',
       (SELECT id FROM diretor WHERE slug = 'shigeru-miyamoto'),
       (SELECT id FROM distribuidora WHERE nome = 'Nintendo')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Pikmin 4', 'pikmin-4') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Lidere os pequenos Pikmin em uma missão de resgate num planeta cheio de criaturas e tesouros.',
       (SELECT id FROM diretor WHERE slug = 'shigeru-miyamoto'),
       (SELECT id FROM distribuidora WHERE nome = 'Nintendo')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Super Mario Bros. Wonder', 'super-mario-bros-wonder') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Plataforma 2D cheia de surpresas, com Flores Maravilha que viram o cenário do avesso.',
       (SELECT id FROM diretor WHERE slug = 'shigeru-miyamoto'),
       (SELECT id FROM distribuidora WHERE nome = 'Nintendo')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('The Legend of Zelda: Breath of the Wild', 'zelda-breath-of-the-wild') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Acorde em um Hyrule aberto e livre para explorar do seu jeito, sem caminho certo.',
       (SELECT id FROM diretor WHERE slug = 'hidemaro-fujibayashi'),
       (SELECT id FROM distribuidora WHERE nome = 'Nintendo')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('The Legend of Zelda: Tears of the Kingdom', 'zelda-tears-of-the-kingdom') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Hyrule, o céu e as profundezas: construa engenhocas e explore camadas inteiras do mundo.',
       (SELECT id FROM diretor WHERE slug = 'hidemaro-fujibayashi'),
       (SELECT id FROM distribuidora WHERE nome = 'Nintendo')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Mario Kart 8 Deluxe', 'mario-kart-8-deluxe') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Corridas com gravidade zero, itens clássicos e pistas de todos os tipos para jogar com os amigos.',
       (SELECT id FROM diretor WHERE slug = 'kosuke-yabuki'),
       (SELECT id FROM distribuidora WHERE nome = 'Nintendo')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Mario Kart World', 'mario-kart-world') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Um mundo aberto conectado por pistas, feito para o Nintendo Switch 2.',
       (SELECT id FROM diretor WHERE slug = 'kosuke-yabuki'),
       (SELECT id FROM distribuidora WHERE nome = 'Nintendo')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Donkey Kong Bananza', 'donkey-kong-bananza') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Quebre o cenário inteiro com a força do Donkey Kong em uma aventura de plataforma destrutiva.',
       (SELECT id FROM diretor WHERE slug = 'kazuya-takahashi'),
       (SELECT id FROM distribuidora WHERE nome = 'Nintendo')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Super Smash Bros. Ultimate', 'super-smash-bros-ultimate') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Todos os lutadores de uma vez, com um elenco gigante de personagens de vários jogos.',
       (SELECT id FROM diretor WHERE slug = 'masahiro-sakurai'),
       (SELECT id FROM distribuidora WHERE nome = 'Nintendo')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Kirby Air Riders', 'kirby-air-riders') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Corridas aéreas rápidas e caóticas com Kirby e companhia.',
       (SELECT id FROM diretor WHERE slug = 'masahiro-sakurai'),
       (SELECT id FROM distribuidora WHERE nome = 'Nintendo')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Death Stranding', 'death-stranding') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Reconecte uma América devastada entregando cargas a pé em uma aventura sobre laços e isolamento.',
       (SELECT id FROM diretor WHERE slug = 'hideo-kojima'),
       (SELECT id FROM distribuidora WHERE nome = 'Sony Interactive Entertainment')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Death Stranding 2: On the Beach', 'death-stranding-2') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Sam volta a atravessar mundos para reconectar a humanidade, em uma sequência ainda mais ousada.',
       (SELECT id FROM diretor WHERE slug = 'hideo-kojima'),
       (SELECT id FROM distribuidora WHERE nome = 'Sony Interactive Entertainment')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Metal Gear Solid V: The Phantom Pain', 'metal-gear-solid-v') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Espionagem tática em mundo aberto, com infiltração livre e uma base para comandar.',
       (SELECT id FROM diretor WHERE slug = 'hideo-kojima'),
       (SELECT id FROM distribuidora WHERE nome = 'Konami')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Sonic Origins', 'sonic-origins') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Os clássicos Sonic 1, 2, 3 & Knuckles e CD reunidos e remasterizados.',
       (SELECT id FROM diretor WHERE slug = 'yuji-naka'),
       (SELECT id FROM distribuidora WHERE nome = 'Sega')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Sonic X Shadow Generations', 'sonic-x-shadow-generations') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Celebre os 30 anos do Sonic em um remaster de Generations, mais uma campanha inédita do Shadow.',
       (SELECT id FROM diretor WHERE slug = 'takashi-iizuka'),
       (SELECT id FROM distribuidora WHERE nome = 'Sega')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Sonic Frontiers', 'sonic-frontiers') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Sonic em ilhas abertas para explorar em alta velocidade.',
       (SELECT id FROM diretor WHERE slug = 'takashi-iizuka'),
       (SELECT id FROM distribuidora WHERE nome = 'Sega')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Sonic Colors: Ultimate', 'sonic-colors-ultimate') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Aventura colorida pelo parque de diversões do Dr. Eggman, com os Wisps e suas habilidades.',
       (SELECT id FROM diretor WHERE slug = 'takashi-iizuka'),
       (SELECT id FROM distribuidora WHERE nome = 'Sega')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('The Last of Us Part I', 'the-last-of-us-part-i') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'A jornada de Joel e Ellie pelos Estados Unidos pós-apocalípticos, reconstruída do zero.',
       (SELECT id FROM diretor WHERE slug = 'neil-druckmann'),
       (SELECT id FROM distribuidora WHERE nome = 'Sony Interactive Entertainment')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('The Last of Us Part II', 'the-last-of-us-part-ii') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Uma história intensa de vingança e consequências em um mundo pós-apocalíptico.',
       (SELECT id FROM diretor WHERE slug = 'neil-druckmann'),
       (SELECT id FROM distribuidora WHERE nome = 'Sony Interactive Entertainment')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Uncharted 4: A Thief''s End', 'uncharted-4') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'A última grande aventura de Nathan Drake, com ação, humor e cenários de tirar o fôlego.',
       (SELECT id FROM diretor WHERE slug = 'neil-druckmann'),
       (SELECT id FROM distribuidora WHERE nome = 'Sony Interactive Entertainment')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Uncharted: Coleção Legado dos Ladrões', 'uncharted-legacy-of-thieves') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Uncharted 4 e Lost Legacy juntos, com visual remasterizado.',
       (SELECT id FROM diretor WHERE slug = 'neil-druckmann'),
       (SELECT id FROM distribuidora WHERE nome = 'Sony Interactive Entertainment')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('God of War (2018)', 'god-of-war-2018') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Kratos e seu filho Atreus enfrentam deuses e criaturas da mitologia nórdica.',
       (SELECT id FROM diretor WHERE slug = 'cory-barlog'),
       (SELECT id FROM distribuidora WHERE nome = 'Sony Interactive Entertainment')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('God of War Ragnarök', 'god-of-war-ragnarok') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Kratos e Atreus encaram o Ragnarök e a fúria dos nove reinos.',
       (SELECT id FROM diretor WHERE slug = 'cory-barlog'),
       (SELECT id FROM distribuidora WHERE nome = 'Sony Interactive Entertainment')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Starfield', 'starfield') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'RPG espacial com centenas de planetas para explorar e uma nave para chamar de sua.',
       (SELECT id FROM diretor WHERE slug = 'todd-howard'),
       (SELECT id FROM distribuidora WHERE nome = 'Xbox Game Studios')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('The Elder Scrolls V: Skyrim', 'skyrim') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Torne-se o Dovahkiin e explore as montanhas geladas de Skyrim, enfrentando dragões.',
       (SELECT id FROM diretor WHERE slug = 'todd-howard'),
       (SELECT id FROM distribuidora WHERE nome = 'Bethesda Softworks')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Fallout 4', 'fallout-4') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Reconstrua a vida em um mundo pós-nuclear, com assentamentos e armaduras para customizar.',
       (SELECT id FROM diretor WHERE slug = 'todd-howard'),
       (SELECT id FROM distribuidora WHERE nome = 'Bethesda Softworks')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Fallout 76', 'fallout-76') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'A Virgínia Ocidental pós-apocalíptica, para explorar sozinho ou com amigos online.',
       (SELECT id FROM diretor WHERE slug = 'todd-howard'),
       (SELECT id FROM distribuidora WHERE nome = 'Bethesda Softworks')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('The Elder Scrolls IV: Oblivion Remastered', 'oblivion-remastered') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Cyrodiil de volta com visual atualizado e a mesma liberdade de sempre.',
       (SELECT id FROM diretor WHERE slug = 'todd-howard'),
       (SELECT id FROM distribuidora WHERE nome = 'Bethesda Softworks')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Red Dead Redemption 2', 'red-dead-redemption-2') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Acompanhe Arthur Morgan e a gangue Van der Linde no fim do Velho Oeste.',
       (SELECT id FROM diretor WHERE slug = 'dan-houser'),
       (SELECT id FROM distribuidora WHERE nome = 'Rockstar Games')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Grand Theft Auto V', 'grand-theft-auto-v') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Três criminosos, uma cidade enorme e assaltos que mudam o rumo de Los Santos.',
       (SELECT id FROM diretor WHERE slug = 'dan-houser'),
       (SELECT id FROM distribuidora WHERE nome = 'Rockstar Games')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Red Dead Redemption', 'red-dead-redemption') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'A história de John Marston no Velho Oeste, em busca de sua família e de acertar velhas contas.',
       (SELECT id FROM diretor WHERE slug = 'dan-houser'),
       (SELECT id FROM distribuidora WHERE nome = 'Rockstar Games')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Grand Theft Auto: The Trilogy – Definitive Edition', 'gta-trilogy-definitive') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'GTA III, Vice City e San Andreas remasterizados em um só pacote.',
       (SELECT id FROM diretor WHERE slug = 'dan-houser'),
       (SELECT id FROM distribuidora WHERE nome = 'Rockstar Games')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Clair Obscur: Expedition 33', 'clair-obscur-expedition-33') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'RPG de turnos inspirado na Belle Époque, em que uma expedição tenta destruir a Paintress antes que ela apague mais uma geração.',
       (SELECT id FROM diretor WHERE slug = 'guillaume-broche'),
       (SELECT id FROM distribuidora WHERE nome = 'Kepler Interactive')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Devil May Cry 5', 'devil-may-cry-5') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Combos estilosos e demônios gigantes com Nero, Dante e V.',
       (SELECT id FROM diretor WHERE slug = 'hideaki-itsuno'),
       (SELECT id FROM distribuidora WHERE nome = 'Capcom')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Dragon''s Dogma 2', 'dragons-dogma-2') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'RPG de ação em mundo aberto, com peões que lutam ao seu lado e monstros colossais.',
       (SELECT id FROM diretor WHERE slug = 'hideaki-itsuno'),
       (SELECT id FROM distribuidora WHERE nome = 'Capcom')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Dragon''s Dogma: Dark Arisen', 'dragons-dogma-dark-arisen') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'O clássico RPG de ação em que você caça monstros enormes com a ajuda de peões.',
       (SELECT id FROM diretor WHERE slug = 'hideaki-itsuno'),
       (SELECT id FROM distribuidora WHERE nome = 'Capcom')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Monster Hunter: World', 'monster-hunter-world') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Cace feras gigantes em ecossistemas vivos e forje equipamentos com o que conquistar.',
       (SELECT id FROM diretor WHERE slug = 'yuya-tokuda'),
       (SELECT id FROM distribuidora WHERE nome = 'Capcom')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Monster Hunter Wilds', 'monster-hunter-wilds') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Caçadas em terras extremas, onde o clima e o ecossistema mudam a todo momento.',
       (SELECT id FROM diretor WHERE slug = 'yuya-tokuda'),
       (SELECT id FROM distribuidora WHERE nome = 'Capcom')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Resident Evil 2', 'resident-evil-2-remake') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'O clássico de terror de Raccoon City, reconstruído com câmera sobre o ombro.',
       (SELECT id FROM diretor WHERE slug = 'kazunori-kadoi'),
       (SELECT id FROM distribuidora WHERE nome = 'Capcom')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Resident Evil 7: Biohazard', 'resident-evil-7') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Terror em primeira pessoa em uma fazenda isolada da Louisiana.',
       (SELECT id FROM diretor WHERE slug = 'koshi-nakanishi'),
       (SELECT id FROM distribuidora WHERE nome = 'Capcom')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Street Fighter 6', 'street-fighter-6') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Luta clássica reinventada, com Modo Mundo e o sistema Drive.',
       (SELECT id FROM diretor WHERE slug = 'takayuki-nakayama'),
       (SELECT id FROM distribuidora WHERE nome = 'Capcom')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('NieR: Automata', 'nier-automata') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Androides lutam por um futuro numa Terra deserta, em uma história que muda a cada final.',
       (SELECT id FROM diretor WHERE slug = 'yoko-taro'),
       (SELECT id FROM distribuidora WHERE nome = 'Square Enix')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('NieR Replicant ver.1.22474487139...', 'nier-replicant') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'A história original de NieR, com visual e combate renovados.',
       (SELECT id FROM diretor WHERE slug = 'yoko-taro'),
       (SELECT id FROM distribuidora WHERE nome = 'Square Enix')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Baldur''s Gate 3', 'baldurs-gate-3') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'RPG em turnos de Dungeons & Dragons, com escolhas que mudam o mundo e a campanha.',
       (SELECT id FROM diretor WHERE slug = 'swen-vincke'),
       (SELECT id FROM distribuidora WHERE nome = 'Larian Studios')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Divinity: Original Sin 2', 'divinity-original-sin-2') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'RPG tático em que cada herói tem sua própria história e suas habilidades.',
       (SELECT id FROM diretor WHERE slug = 'swen-vincke'),
       (SELECT id FROM distribuidora WHERE nome = 'Larian Studios')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Divinity: Original Sin', 'divinity-original-sin') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Dois Caçadores de Fontes investigam um assassinato num RPG cheio de liberdade.',
       (SELECT id FROM diretor WHERE slug = 'swen-vincke'),
       (SELECT id FROM distribuidora WHERE nome = 'Larian Studios')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Persona 5 Royal', 'persona-5-royal') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Ladrões Fantasma roubam corações por Tóquio, entre aulas, amizades e masmorras.',
       (SELECT id FROM diretor WHERE slug = 'katsura-hashino'),
       (SELECT id FROM distribuidora WHERE nome = 'Sega')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Persona 3 Reload', 'persona-3-reload') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Um remake do clássico, com a Hora Sombria e a Torre de Tártaro.',
       (SELECT id FROM diretor WHERE slug = 'katsura-hashino'),
       (SELECT id FROM distribuidora WHERE nome = 'Sega')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Persona 4 Golden', 'persona-4-golden') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Uma investigação numa cidadezinha do interior, entre amizades e o Mundo da TV.',
       (SELECT id FROM diretor WHERE slug = 'katsura-hashino'),
       (SELECT id FROM distribuidora WHERE nome = 'Sega')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Metaphor: ReFantazio', 'metaphor-refantazio') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Um RPG de fantasia sobre eleger um novo rei num reino em crise.',
       (SELECT id FROM diretor WHERE slug = 'katsura-hashino'),
       (SELECT id FROM distribuidora WHERE nome = 'Sega')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Marvel''s Spider-Man', 'marvels-spider-man') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Peter Parker balança por uma Nova York cheia de vilões clássicos.',
       (SELECT id FROM diretor WHERE slug = 'bryan-intihar'),
       (SELECT id FROM distribuidora WHERE nome = 'Sony Interactive Entertainment')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Marvel''s Spider-Man: Miles Morales', 'spider-man-miles-morales') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Miles Morales assume o manto de Spider-Man em uma Nova York no inverno.',
       (SELECT id FROM diretor WHERE slug = 'bryan-intihar'),
       (SELECT id FROM distribuidora WHERE nome = 'Sony Interactive Entertainment')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Marvel''s Spider-Man 2', 'marvels-spider-man-2') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Peter e Miles encaram Venom e Kraven numa cidade maior e mais rápida.',
       (SELECT id FROM diretor WHERE slug = 'bryan-intihar'),
       (SELECT id FROM distribuidora WHERE nome = 'Sony Interactive Entertainment')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Hades', 'hades') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Fuja do Submundo em um roguelike com combate fluido e uma história que avança a cada tentativa.',
       (SELECT id FROM diretor WHERE slug = 'greg-kasavin'),
       (SELECT id FROM distribuidora WHERE nome = 'Supergiant Games')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Hades II', 'hades-ii') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Melinoë, filha de Hades, enfrenta o Titã do Tempo em outro roguelike do Supergiant.',
       (SELECT id FROM diretor WHERE slug = 'greg-kasavin'),
       (SELECT id FROM distribuidora WHERE nome = 'Supergiant Games')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Transistor', 'transistor') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Ação com planejamento em tempo real numa cidade futurista, narrada por uma espada falante.',
       (SELECT id FROM diretor WHERE slug = 'greg-kasavin'),
       (SELECT id FROM distribuidora WHERE nome = 'Supergiant Games')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Bastion', 'bastion') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'RPG de ação com narração dinâmica num mundo que se constrói à medida que você avança.',
       (SELECT id FROM diretor WHERE slug = 'greg-kasavin'),
       (SELECT id FROM distribuidora WHERE nome = 'Supergiant Games')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Gran Turismo 7', 'gran-turismo-7') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'O simulador clássico, com centenas de carros e pistas de todo o mundo.',
       (SELECT id FROM diretor WHERE slug = 'kazunori-yamauchi'),
       (SELECT id FROM distribuidora WHERE nome = 'Sony Interactive Entertainment')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Gran Turismo Sport', 'gran-turismo-sport') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Competições online e carros de corrida em um simulador focado em eSports.',
       (SELECT id FROM diretor WHERE slug = 'kazunori-yamauchi'),
       (SELECT id FROM distribuidora WHERE nome = 'Sony Interactive Entertainment')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Horizon Zero Dawn', 'horizon-zero-dawn') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Aloy caça máquinas gigantes em um mundo pós-apocalíptico.',
       (SELECT id FROM diretor WHERE slug = 'mathijs-de-jonge'),
       (SELECT id FROM distribuidora WHERE nome = 'Sony Interactive Entertainment')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Horizon Forbidden West', 'horizon-forbidden-west') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Aloy atravessa o Oeste Proibido, onde novas ameaças e máquinas a esperam.',
       (SELECT id FROM diretor WHERE slug = 'mathijs-de-jonge'),
       (SELECT id FROM distribuidora WHERE nome = 'Sony Interactive Entertainment')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Ghost of Tsushima', 'ghost-of-tsushima') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Jin Sakai defende a ilha de Tsushima da invasão mongol, entre honra e furtividade.',
       (SELECT id FROM diretor WHERE slug = 'nate-fox'),
       (SELECT id FROM distribuidora WHERE nome = 'Sony Interactive Entertainment')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Ghost of Yōtei', 'ghost-of-yotei') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Uma nova lenda do Japão feudal, em busca de vingança.',
       (SELECT id FROM diretor WHERE slug = 'nate-fox'),
       (SELECT id FROM distribuidora WHERE nome = 'Sony Interactive Entertainment')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Alan Wake 2', 'alan-wake-2') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Terror psicológico em dois protagonistas e duas realidades.',
       (SELECT id FROM diretor WHERE slug = 'sam-lake'),
       (SELECT id FROM distribuidora WHERE nome = 'Epic Games Publishing')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Control', 'control') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Jesse Faden explora o Antigo Lar, um prédio que muda de forma, com poderes telecinéticos.',
       (SELECT id FROM diretor WHERE slug = 'sam-lake'),
       (SELECT id FROM distribuidora WHERE nome = 'Epic Games Publishing')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Alan Wake Remastered', 'alan-wake-remastered') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'O thriller que deu início à saga, com visual remasterizado.',
       (SELECT id FROM diretor WHERE slug = 'sam-lake'),
       (SELECT id FROM distribuidora WHERE nome = 'Epic Games Publishing')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Star Wars Jedi: Fallen Order', 'jedi-fallen-order') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Cal Kestis, um jovem Padawan sobrevivente, tenta reconstruir a Ordem Jedi.',
       (SELECT id FROM diretor WHERE slug = 'stig-asmussen'),
       (SELECT id FROM distribuidora WHERE nome = 'Electronic Arts')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Star Wars Jedi: Survivor', 'jedi-survivor') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Cal Kestis volta a enfrentar o Império em uma aventura maior e mais ousada.',
       (SELECT id FROM diretor WHERE slug = 'stig-asmussen'),
       (SELECT id FROM distribuidora WHERE nome = 'Electronic Arts')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Assassin''s Creed IV: Black Flag', 'assassins-creed-black-flag') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Piratas, batalhas navais e o Caribe no auge da Era de Ouro.',
       (SELECT id FROM diretor WHERE slug = 'jean-guesdon'),
       (SELECT id FROM distribuidora WHERE nome = 'Ubisoft')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Assassin''s Creed Origins', 'assassins-creed-origins') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'A origem da Irmandade, no Egito antigo.',
       (SELECT id FROM diretor WHERE slug = 'jean-guesdon'),
       (SELECT id FROM distribuidora WHERE nome = 'Ubisoft')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Assassin''s Creed Odyssey', 'assassins-creed-odyssey') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Uma jornada épica pela Grécia antiga, com escolhas que mudam o rumo da guerra.',
       (SELECT id FROM diretor WHERE slug = 'jean-guesdon'),
       (SELECT id FROM distribuidora WHERE nome = 'Ubisoft')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Prince of Persia: The Lost Crown', 'prince-of-persia-lost-crown') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Metroidvania de ação com Sargon, tempo em espiral e acrobacias.',
       (SELECT id FROM diretor WHERE slug = 'mounir-radi'),
       (SELECT id FROM distribuidora WHERE nome = 'Ubisoft')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Rayman Legends', 'rayman-legends') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Plataforma 2D colorida e musical, cheia de fases para jogar em dupla.',
       (SELECT id FROM diretor WHERE slug = 'michel-ancel'),
       (SELECT id FROM distribuidora WHERE nome = 'Ubisoft')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Beyond Good & Evil – Edição 20º Aniversário', 'beyond-good-and-evil-20th') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'A jornalista Jade investiga uma conspiração alienígena, 20 anos depois.',
       (SELECT id FROM diretor WHERE slug = 'michel-ancel'),
       (SELECT id FROM distribuidora WHERE nome = 'Ubisoft')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Minecraft', 'minecraft') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Explore, construa e sobreviva em mundos infinitos feitos de blocos.',
       (SELECT id FROM diretor WHERE slug = 'jens-bergensten'),
       (SELECT id FROM distribuidora WHERE nome = 'Xbox Game Studios')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Black Myth: Wukong', 'black-myth-wukong') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Aventura de ação baseada em Jornada ao Oeste, com a lenda do Rei Macaco.',
       (SELECT id FROM diretor WHERE slug = 'feng-ji'),
       (SELECT id FROM distribuidora WHERE nome = 'Game Science')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('No Man''s Sky', 'no-mans-sky') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Explore uma galáxia inteira gerada proceduralmente, a pé ou de nave.',
       (SELECT id FROM diretor WHERE slug = 'sean-murray'),
       (SELECT id FROM distribuidora WHERE nome = 'Hello Games')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Stardew Valley', 'stardew-valley') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Largue a vida na cidade e recupere a fazenda do seu avô, entre plantações, minas e amizades.',
       (SELECT id FROM diretor WHERE slug = 'eric-barone'),
       (SELECT id FROM distribuidora WHERE nome = 'ConcernedApe')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Hollow Knight', 'hollow-knight') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Metroidvania desenhada à mão, num reino de insetos subterrâneo.',
       (SELECT id FROM diretor WHERE slug = 'ari-gibson'),
       (SELECT id FROM distribuidora WHERE nome = 'Team Cherry')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Hollow Knight: Silksong', 'hollow-knight-silksong') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Hornet atravessa o reino de Pharloom em uma nova aventura de ação e plataforma.',
       (SELECT id FROM diretor WHERE slug = 'ari-gibson'),
       (SELECT id FROM distribuidora WHERE nome = 'Team Cherry')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Cyberpunk 2077', 'cyberpunk-2077') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'RPG em primeira pessoa na Night City do futuro, em que V busca um implante que vale a vida.',
       (SELECT id FROM diretor WHERE slug = 'adam-badowski'),
       (SELECT id FROM distribuidora WHERE nome = 'CD Projekt')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('The Witcher 3: Wild Hunt', 'the-witcher-3') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Geralt de Rivia atravessa um mundo aberto atrás de Ciri e da Caçada Selvagem.',
       (SELECT id FROM diretor WHERE slug = 'konrad-tomaszkiewicz'),
       (SELECT id FROM distribuidora WHERE nome = 'CD Projekt')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Final Fantasy VII Remake Intergrade', 'final-fantasy-vii-remake-intergrade') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'A Midgar de Cloud e do Avalanche, refeita com combate em tempo real e história expandida.',
       (SELECT id FROM diretor WHERE slug = 'naoki-hamaguchi'),
       (SELECT id FROM distribuidora WHERE nome = 'Square Enix')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Final Fantasy VII Rebirth', 'final-fantasy-vii-rebirth') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Cloud e companhia saem de Midgar e atravessam o mundo, em busca de Sephiroth.',
       (SELECT id FROM diretor WHERE slug = 'naoki-hamaguchi'),
       (SELECT id FROM distribuidora WHERE nome = 'Square Enix')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Final Fantasy XVI', 'final-fantasy-xvi') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Fantasia sombria de Valisthea, onde Eikons e guerras decidem o destino dos reinos.',
       (SELECT id FROM diretor WHERE slug = 'hiroshi-takai'),
       (SELECT id FROM distribuidora WHERE nome = 'Square Enix')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Dragon Quest XI S: Edição Definitiva', 'dragon-quest-xi-s') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Um RPG clássico, com mundo colorido e uma jornada de herói que vai das vilas ao fim do mundo.',
       (SELECT id FROM diretor WHERE slug = 'yuji-horii'),
       (SELECT id FROM distribuidora WHERE nome = 'Square Enix')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Dragon Quest Builders 2', 'dragon-quest-builders-2') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Construa, cultive e lute em um mundo de blocos ao estilo Dragon Quest.',
       (SELECT id FROM diretor WHERE slug = 'yuji-horii'),
       (SELECT id FROM distribuidora WHERE nome = 'Square Enix')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('The Last Guardian', 'the-last-guardian') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Um menino e uma criatura gigante precisam um do outro para escapar de ruínas misteriosas.',
       (SELECT id FROM diretor WHERE slug = 'fumito-ueda'),
       (SELECT id FROM distribuidora WHERE nome = 'Sony Interactive Entertainment')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Shadow of the Colossus', 'shadow-of-the-colossus') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Derrube colossos gigantes em uma terra solitária, para trazer alguém de volta.',
       (SELECT id FROM diretor WHERE slug = 'fumito-ueda'),
       (SELECT id FROM distribuidora WHERE nome = 'Sony Interactive Entertainment')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Forza Horizon 5', 'forza-horizon-5') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Corridas livres pelo México, em um mundo aberto cheio de festivais.',
       (SELECT id FROM diretor WHERE slug = 'mike-brown'),
       (SELECT id FROM distribuidora WHERE nome = 'Xbox Game Studios')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Forza Horizon 4', 'forza-horizon-4') RETURNING id)
INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)
SELECT p.id, 'Corridas pelas estações do ano no Reino Unido, em um mundo aberto compartilhado.',
       (SELECT id FROM diretor WHERE slug = 'mike-brown'),
       (SELECT id FROM distribuidora WHERE nome = 'Xbox Game Studios')
FROM p;

-- ---------------------------------------------------------------------
-- Jogo Disponível em Plataforma, com preço e desconto de cada par
-- ---------------------------------------------------------------------
INSERT INTO jogo_plataforma (jogo_id, plataforma_id, preco, desconto)
SELECT pr.id, pl.id, v.preco, v.desconto
FROM (VALUES
    ('elden-ring', 'PlayStation 5', 299.90, NULL),
    ('elden-ring', 'PlayStation 4', 299.90, NULL),
    ('elden-ring', 'Xbox Series', 289.90, NULL),
    ('elden-ring', 'Xbox One', 289.90, NULL),
    ('elden-ring', 'PC', 274.50, 30.00),
    ('bloodborne', 'PlayStation 4', 114.90, NULL),
    ('demons-souls', 'PlayStation 5', 349.90, 50.00),
    ('dark-souls-remastered', 'PlayStation 4', 229.90, 60.00),
    ('dark-souls-remastered', 'Xbox One', 219.90, NULL),
    ('dark-souls-remastered', 'Nintendo Switch', 169.90, NULL),
    ('dark-souls-remastered', 'PC', 154.90, NULL),
    ('dark-souls-iii', 'PlayStation 4', 339.90, 50.00),
    ('dark-souls-iii', 'Xbox One', 329.90, 50.00),
    ('dark-souls-iii', 'PC', 229.90, 75.00),
    ('sekiro', 'PlayStation 4', 249.50, NULL),
    ('sekiro', 'Xbox One', 239.90, 75.00),
    ('sekiro', 'PC', 274.00, NULL),
    ('super-mario-odyssey', 'Nintendo Switch', 349.00, NULL),
    ('super-mario-odyssey', 'Nintendo Switch 2', 349.00, NULL),
    ('pikmin-4', 'Nintendo Switch', 349.00, NULL),
    ('super-mario-bros-wonder', 'Nintendo Switch', 349.00, 25.00),
    ('zelda-breath-of-the-wild', 'Nintendo Switch', 349.00, NULL),
    ('zelda-breath-of-the-wild', 'Nintendo Switch 2', 349.00, NULL),
    ('zelda-tears-of-the-kingdom', 'Nintendo Switch', 399.00, NULL),
    ('zelda-tears-of-the-kingdom', 'Nintendo Switch 2', 399.00, NULL),
    ('mario-kart-8-deluxe', 'Nintendo Switch', 349.00, 75.00),
    ('mario-kart-world', 'Nintendo Switch 2', 499.00, NULL),
    ('donkey-kong-bananza', 'Nintendo Switch 2', 449.00, 20.00),
    ('super-smash-bros-ultimate', 'Nintendo Switch', 349.00, 75.00),
    ('kirby-air-riders', 'Nintendo Switch 2', 399.00, NULL),
    ('death-stranding', 'PlayStation 5', 229.90, NULL),
    ('death-stranding', 'PlayStation 4', 229.90, NULL),
    ('death-stranding', 'PC', 159.00, 40.00),
    ('death-stranding-2', 'PlayStation 5', 349.90, NULL),
    ('metal-gear-solid-v', 'PlayStation 4', 99.50, 60.00),
    ('metal-gear-solid-v', 'Xbox One', 99.90, NULL),
    ('metal-gear-solid-v', 'PC', 99.00, 40.00),
    ('sonic-origins', 'PlayStation 5', 159.90, NULL),
    ('sonic-origins', 'PlayStation 4', 159.90, NULL),
    ('sonic-origins', 'Xbox Series', 159.90, NULL),
    ('sonic-origins', 'Xbox One', 159.90, NULL),
    ('sonic-origins', 'Nintendo Switch', 169.90, NULL),
    ('sonic-origins', 'PC', 157.99, NULL),
    ('sonic-x-shadow-generations', 'PlayStation 5', 249.50, NULL),
    ('sonic-x-shadow-generations', 'PlayStation 4', 249.50, NULL),
    ('sonic-x-shadow-generations', 'Xbox Series', 239.90, NULL),
    ('sonic-x-shadow-generations', 'Xbox One', 239.90, NULL),
    ('sonic-x-shadow-generations', 'Nintendo Switch', 229.90, 15.00),
    ('sonic-x-shadow-generations', 'PC', 209.90, NULL),
    ('sonic-frontiers', 'PlayStation 5', 199.50, 30.00),
    ('sonic-frontiers', 'PlayStation 4', 199.50, 30.00),
    ('sonic-frontiers', 'Xbox Series', 189.90, 10.00),
    ('sonic-frontiers', 'Xbox One', 189.90, 10.00),
    ('sonic-frontiers', 'Nintendo Switch', 179.90, NULL),
    ('sonic-frontiers', 'PC', 164.90, NULL),
    ('sonic-colors-ultimate', 'PlayStation 4', 199.50, 40.00),
    ('sonic-colors-ultimate', 'Xbox One', 189.90, NULL),
    ('sonic-colors-ultimate', 'Nintendo Switch', 219.90, NULL),
    ('sonic-colors-ultimate', 'PC', 199.50, NULL),
    ('the-last-of-us-part-i', 'PlayStation 5', 299.90, 10.00),
    ('the-last-of-us-part-i', 'PC', 249.90, 50.00),
    ('the-last-of-us-part-ii', 'PlayStation 5', 229.90, NULL),
    ('the-last-of-us-part-ii', 'PlayStation 4', 229.90, NULL),
    ('the-last-of-us-part-ii', 'PC', 199.90, 10.00),
    ('uncharted-4', 'PlayStation 4', 149.50, 50.00),
    ('uncharted-legacy-of-thieves', 'PlayStation 5', 199.50, NULL),
    ('uncharted-legacy-of-thieves', 'PC', 199.90, NULL),
    ('god-of-war-2018', 'PlayStation 5', 229.90, NULL),
    ('god-of-war-2018', 'PlayStation 4', 229.90, NULL),
    ('god-of-war-2018', 'PC', 199.90, NULL),
    ('god-of-war-ragnarok', 'PlayStation 5', 299.90, NULL),
    ('god-of-war-ragnarok', 'PlayStation 4', 299.90, NULL),
    ('god-of-war-ragnarok', 'PC', 249.90, NULL),
    ('starfield', 'Xbox Series', 239.90, 40.00),
    ('starfield', 'PC', 239.90, 40.00),
    ('skyrim', 'PlayStation 5', 149.50, NULL),
    ('skyrim', 'PlayStation 4', 149.50, NULL),
    ('skyrim', 'Xbox Series', 149.90, NULL),
    ('skyrim', 'Xbox One', 149.90, NULL),
    ('skyrim', 'Nintendo Switch', 159.90, 30.00),
    ('skyrim', 'PC', 149.00, NULL),
    ('fallout-4', 'PlayStation 5', 99.50, NULL),
    ('fallout-4', 'PlayStation 4', 99.50, NULL),
    ('fallout-4', 'Xbox Series', 99.90, 30.00),
    ('fallout-4', 'Xbox One', 99.90, 30.00),
    ('fallout-4', 'PC', 59.99, 40.00),
    ('fallout-76', 'PlayStation 4', 199.50, NULL),
    ('fallout-76', 'Xbox One', 189.90, 75.00),
    ('fallout-76', 'PC', 189.90, 75.00),
    ('oblivion-remastered', 'PlayStation 5', 299.90, NULL),
    ('oblivion-remastered', 'Xbox Series', 289.90, NULL),
    ('oblivion-remastered', 'PC', 264.90, NULL),
    ('red-dead-redemption-2', 'PlayStation 4', 299.90, 50.00),
    ('red-dead-redemption-2', 'Xbox One', 289.90, NULL),
    ('red-dead-redemption-2', 'PC', 299.90, NULL),
    ('grand-theft-auto-v', 'PlayStation 5', 129.50, 75.00),
    ('grand-theft-auto-v', 'PlayStation 4', 129.50, 75.00),
    ('grand-theft-auto-v', 'Xbox Series', 129.90, NULL),
    ('grand-theft-auto-v', 'Xbox One', 129.90, NULL),
    ('grand-theft-auto-v', 'PC', 129.00, 30.00),
    ('red-dead-redemption', 'PlayStation 4', 203.90, NULL),
    ('red-dead-redemption', 'Nintendo Switch', 269.90, 20.00),
    ('gta-trilogy-definitive', 'PlayStation 5', 199.90, NULL),
    ('gta-trilogy-definitive', 'PlayStation 4', 199.90, NULL),
    ('gta-trilogy-definitive', 'Xbox Series', 189.90, 25.00),
    ('gta-trilogy-definitive', 'Xbox One', 189.90, 25.00),
    ('gta-trilogy-definitive', 'Nintendo Switch', 219.90, NULL),
    ('gta-trilogy-definitive', 'PC', 199.90, NULL),
    ('clair-obscur-expedition-33', 'PlayStation 5', 229.90, NULL),
    ('clair-obscur-expedition-33', 'Xbox Series', 219.90, NULL),
    ('clair-obscur-expedition-33', 'PC', 199.00, 25.00),
    ('devil-may-cry-5', 'PlayStation 5', 129.50, 30.00),
    ('devil-may-cry-5', 'PlayStation 4', 129.50, 30.00),
    ('devil-may-cry-5', 'Xbox Series', 129.90, NULL),
    ('devil-may-cry-5', 'Xbox One', 129.90, NULL),
    ('devil-may-cry-5', 'PC', 129.00, 40.00),
    ('dragons-dogma-2', 'PlayStation 5', 189.90, NULL),
    ('dragons-dogma-2', 'Xbox Series', 189.90, NULL),
    ('dragons-dogma-2', 'PC', 169.00, NULL),
    ('dragons-dogma-dark-arisen', 'PlayStation 4', 149.90, NULL),
    ('dragons-dogma-dark-arisen', 'Xbox One', 139.90, NULL),
    ('dragons-dogma-dark-arisen', 'Nintendo Switch', 139.90, 40.00),
    ('dragons-dogma-dark-arisen', 'PC', 129.00, 60.00),
    ('monster-hunter-world', 'PlayStation 4', 114.90, NULL),
    ('monster-hunter-world', 'Xbox One', 109.90, 30.00),
    ('monster-hunter-world', 'PC', 129.00, NULL),
    ('monster-hunter-wilds', 'PlayStation 5', 189.90, NULL),
    ('monster-hunter-wilds', 'Xbox Series', 189.90, NULL),
    ('monster-hunter-wilds', 'PC', 169.00, NULL),
    ('resident-evil-2-remake', 'PlayStation 5', 129.50, NULL),
    ('resident-evil-2-remake', 'PlayStation 4', 129.50, NULL),
    ('resident-evil-2-remake', 'Xbox Series', 129.90, 20.00),
    ('resident-evil-2-remake', 'Xbox One', 129.90, 20.00),
    ('resident-evil-2-remake', 'PC', 169.00, 40.00),
    ('resident-evil-7', 'PlayStation 5', 99.90, NULL),
    ('resident-evil-7', 'PlayStation 4', 99.90, NULL),
    ('resident-evil-7', 'Xbox Series', 99.90, NULL),
    ('resident-evil-7', 'Xbox One', 99.90, NULL),
    ('resident-evil-7', 'PC', 89.00, 75.00),
    ('street-fighter-6', 'PlayStation 5', 219.50, NULL),
    ('street-fighter-6', 'PlayStation 4', 219.50, NULL),
    ('street-fighter-6', 'Xbox Series', 209.90, NULL),
    ('street-fighter-6', 'Nintendo Switch 2', 199.90, NULL),
    ('street-fighter-6', 'PC', 179.00, NULL),
    ('nier-automata', 'PlayStation 4', 119.90, NULL),
    ('nier-automata', 'Xbox One', 119.90, NULL),
    ('nier-automata', 'Nintendo Switch', 119.90, NULL),
    ('nier-automata', 'PC', 107.00, 50.00),
    ('nier-replicant', 'PlayStation 4', 249.90, NULL),
    ('nier-replicant', 'Xbox One', 239.90, NULL),
    ('nier-replicant', 'PC', 249.90, 30.00),
    ('baldurs-gate-3', 'PlayStation 5', 229.90, NULL),
    ('baldurs-gate-3', 'Xbox Series', 219.90, 30.00),
    ('baldurs-gate-3', 'PC', 199.99, 25.00),
    ('divinity-original-sin-2', 'PlayStation 4', 99.90, NULL),
    ('divinity-original-sin-2', 'Xbox One', 99.90, 60.00),
    ('divinity-original-sin-2', 'Nintendo Switch', 99.90, NULL),
    ('divinity-original-sin-2', 'PC', 90.99, 75.00),
    ('divinity-original-sin', 'PlayStation 4', 79.90, 20.00),
    ('divinity-original-sin', 'Xbox One', 79.90, 75.00),
    ('divinity-original-sin', 'Nintendo Switch', 79.90, NULL),
    ('divinity-original-sin', 'PC', 114.79, 60.00),
    ('persona-5-royal', 'PlayStation 5', 299.90, NULL),
    ('persona-5-royal', 'PlayStation 4', 299.90, NULL),
    ('persona-5-royal', 'Xbox Series', 289.90, 20.00),
    ('persona-5-royal', 'Xbox One', 289.90, 20.00),
    ('persona-5-royal', 'Nintendo Switch', 269.90, NULL),
    ('persona-5-royal', 'PC', 249.90, 60.00),
    ('persona-3-reload', 'PlayStation 5', 299.90, NULL),
    ('persona-3-reload', 'PlayStation 4', 299.90, NULL),
    ('persona-3-reload', 'Xbox Series', 289.90, NULL),
    ('persona-3-reload', 'Xbox One', 289.90, NULL),
    ('persona-3-reload', 'PC', 249.90, NULL),
    ('persona-4-golden', 'PlayStation 4', 104.90, 60.00),
    ('persona-4-golden', 'Xbox One', 99.90, NULL),
    ('persona-4-golden', 'Nintendo Switch', 109.90, NULL),
    ('persona-4-golden', 'PC', 99.90, 60.00),
    ('metaphor-refantazio', 'PlayStation 5', 339.90, NULL),
    ('metaphor-refantazio', 'PlayStation 4', 339.90, NULL),
    ('metaphor-refantazio', 'Xbox Series', 329.90, NULL),
    ('metaphor-refantazio', 'Xbox One', 329.90, NULL),
    ('metaphor-refantazio', 'PC', 299.90, NULL),
    ('marvels-spider-man', 'PlayStation 5', 289.90, NULL),
    ('marvels-spider-man', 'PlayStation 4', 289.90, NULL),
    ('marvels-spider-man', 'PC', 249.90, NULL),
    ('spider-man-miles-morales', 'PlayStation 5', 229.90, 10.00),
    ('spider-man-miles-morales', 'PlayStation 4', 229.90, 10.00),
    ('spider-man-miles-morales', 'PC', 199.90, NULL),
    ('marvels-spider-man-2', 'PlayStation 5', 289.90, NULL),
    ('marvels-spider-man-2', 'PC', 249.90, NULL),
    ('hades', 'PlayStation 5', 124.50, NULL),
    ('hades', 'PlayStation 4', 124.50, NULL),
    ('hades', 'Xbox Series', 119.90, NULL),
    ('hades', 'Xbox One', 119.90, NULL),
    ('hades', 'Nintendo Switch', 79.90, NULL),
    ('hades', 'PC', 73.99, NULL),
    ('hades-ii', 'Nintendo Switch', 99.90, NULL),
    ('hades-ii', 'Nintendo Switch 2', 99.90, NULL),
    ('hades-ii', 'PC', 88.99, NULL),
    ('transistor', 'PlayStation 4', 114.90, 50.00),
    ('transistor', 'Xbox One', 109.90, 75.00),
    ('transistor', 'Nintendo Switch', 69.90, NULL),
    ('transistor', 'PC', 59.99, 40.00),
    ('bastion', 'PlayStation 4', 85.50, NULL),
    ('bastion', 'Xbox One', 79.90, NULL),
    ('bastion', 'Nintendo Switch', 49.90, 50.00),
    ('bastion', 'PC', 46.99, 50.00),
    ('gran-turismo-7', 'PlayStation 5', 299.90, NULL),
    ('gran-turismo-7', 'PlayStation 4', 299.90, NULL),
    ('gran-turismo-sport', 'PlayStation 4', 59.50, 40.00),
    ('horizon-zero-dawn', 'PlayStation 4', 284.90, 40.00),
    ('horizon-zero-dawn', 'PlayStation 5', 284.90, 40.00),
    ('horizon-zero-dawn', 'PC', 199.90, 50.00),
    ('horizon-forbidden-west', 'PlayStation 5', 199.50, NULL),
    ('horizon-forbidden-west', 'PlayStation 4', 199.50, NULL),
    ('horizon-forbidden-west', 'PC', 249.90, NULL),
    ('ghost-of-tsushima', 'PlayStation 4', 299.90, NULL),
    ('ghost-of-tsushima', 'PlayStation 5', 299.90, NULL),
    ('ghost-of-tsushima', 'PC', 249.90, 10.00),
    ('ghost-of-yotei', 'PlayStation 5', 349.90, NULL),
    ('alan-wake-2', 'PlayStation 5', 289.90, NULL),
    ('alan-wake-2', 'Xbox Series', 269.90, 10.00),
    ('alan-wake-2', 'PC', 249.90, NULL),
    ('control', 'PlayStation 5', 108.50, 75.00),
    ('control', 'PlayStation 4', 108.50, 75.00),
    ('control', 'Xbox Series', 109.90, NULL),
    ('control', 'Xbox One', 109.90, NULL),
    ('control', 'Nintendo Switch', 109.90, NULL),
    ('control', 'PC', 129.00, 75.00),
    ('alan-wake-remastered', 'PlayStation 5', 99.50, 20.00),
    ('alan-wake-remastered', 'PlayStation 4', 99.50, 20.00),
    ('alan-wake-remastered', 'Xbox Series', 99.90, 25.00),
    ('alan-wake-remastered', 'Xbox One', 99.90, 25.00),
    ('alan-wake-remastered', 'Nintendo Switch', 109.90, NULL),
    ('alan-wake-remastered', 'PC', 99.50, NULL),
    ('jedi-fallen-order', 'PlayStation 5', 238.90, 20.00),
    ('jedi-fallen-order', 'PlayStation 4', 238.90, 20.00),
    ('jedi-fallen-order', 'Xbox Series', 229.90, NULL),
    ('jedi-fallen-order', 'Xbox One', 229.90, NULL),
    ('jedi-fallen-order', 'PC', 199.00, 75.00),
    ('jedi-survivor', 'PlayStation 5', 338.90, 40.00),
    ('jedi-survivor', 'Xbox Series', 329.90, NULL),
    ('jedi-survivor', 'PC', 299.00, 40.00),
    ('assassins-creed-black-flag', 'PlayStation 4', 139.90, 20.00),
    ('assassins-creed-black-flag', 'Xbox One', 129.90, NULL),
    ('assassins-creed-black-flag', 'PC', 119.99, 75.00),
    ('assassins-creed-origins', 'PlayStation 4', 209.90, NULL),
    ('assassins-creed-origins', 'Xbox One', 199.90, 75.00),
    ('assassins-creed-origins', 'PC', 179.99, 60.00),
    ('assassins-creed-odyssey', 'PlayStation 4', 209.90, NULL),
    ('assassins-creed-odyssey', 'Xbox One', 199.90, NULL),
    ('assassins-creed-odyssey', 'Nintendo Switch', 199.90, NULL),
    ('assassins-creed-odyssey', 'PC', 179.99, 60.00),
    ('prince-of-persia-lost-crown', 'PlayStation 5', 169.90, NULL),
    ('prince-of-persia-lost-crown', 'PlayStation 4', 169.90, NULL),
    ('prince-of-persia-lost-crown', 'Xbox Series', 159.90, NULL),
    ('prince-of-persia-lost-crown', 'Xbox One', 159.90, NULL),
    ('prince-of-persia-lost-crown', 'Nintendo Switch', 159.90, NULL),
    ('prince-of-persia-lost-crown', 'PC', 149.99, NULL),
    ('rayman-legends', 'PlayStation 4', 89.50, 60.00),
    ('rayman-legends', 'Xbox One', 89.90, 20.00),
    ('rayman-legends', 'Nintendo Switch', 99.90, 50.00),
    ('rayman-legends', 'PC', 89.99, 30.00),
    ('beyond-good-and-evil-20th', 'PlayStation 4', 59.90, 75.00),
    ('beyond-good-and-evil-20th', 'Xbox One', 49.90, 60.00),
    ('beyond-good-and-evil-20th', 'PC', 49.90, 40.00),
    ('minecraft', 'PlayStation 5', 83.50, NULL),
    ('minecraft', 'PlayStation 4', 83.50, NULL),
    ('minecraft', 'Xbox Series', 79.90, NULL),
    ('minecraft', 'Xbox One', 79.90, NULL),
    ('minecraft', 'Nintendo Switch', 139.90, NULL),
    ('minecraft', 'Nintendo Switch 2', 139.90, NULL),
    ('minecraft', 'PC', 79.90, NULL),
    ('black-myth-wukong', 'PlayStation 5', 259.90, NULL),
    ('black-myth-wukong', 'Xbox Series', 249.90, 10.00),
    ('black-myth-wukong', 'PC', 229.99, 25.00),
    ('no-mans-sky', 'PlayStation 5', 189.90, 60.00),
    ('no-mans-sky', 'PlayStation 4', 189.90, 60.00),
    ('no-mans-sky', 'Xbox Series', 179.90, NULL),
    ('no-mans-sky', 'Xbox One', 179.90, NULL),
    ('no-mans-sky', 'Nintendo Switch', 179.90, 60.00),
    ('no-mans-sky', 'Nintendo Switch 2', 179.90, 60.00),
    ('no-mans-sky', 'PC', 129.99, 30.00),
    ('stardew-valley', 'PlayStation 4', 79.90, 50.00),
    ('stardew-valley', 'Xbox One', 79.90, NULL),
    ('stardew-valley', 'Nintendo Switch', 29.90, NULL),
    ('stardew-valley', 'PC', 24.99, 60.00),
    ('hollow-knight', 'PlayStation 5', 62.90, 60.00),
    ('hollow-knight', 'PlayStation 4', 62.90, 60.00),
    ('hollow-knight', 'Xbox Series', 59.90, 60.00),
    ('hollow-knight', 'Xbox One', 59.90, 60.00),
    ('hollow-knight', 'Nintendo Switch', 49.90, NULL),
    ('hollow-knight', 'PC', 46.99, 50.00),
    ('hollow-knight-silksong', 'PlayStation 5', 114.90, NULL),
    ('hollow-knight-silksong', 'PlayStation 4', 114.90, NULL),
    ('hollow-knight-silksong', 'Xbox Series', 109.90, 15.00),
    ('hollow-knight-silksong', 'Xbox One', 109.90, 15.00),
    ('hollow-knight-silksong', 'Nintendo Switch', 69.90, 10.00),
    ('hollow-knight-silksong', 'Nintendo Switch 2', 69.90, 10.00),
    ('hollow-knight-silksong', 'PC', 59.99, 25.00),
    ('cyberpunk-2077', 'PlayStation 5', 249.50, NULL),
    ('cyberpunk-2077', 'PlayStation 4', 249.50, NULL),
    ('cyberpunk-2077', 'Xbox Series', 239.90, 40.00),
    ('cyberpunk-2077', 'Xbox One', 239.90, 40.00),
    ('cyberpunk-2077', 'Nintendo Switch 2', 219.90, 15.00),
    ('cyberpunk-2077', 'PC', 199.90, NULL),
    ('the-witcher-3', 'PlayStation 5', 199.50, 75.00),
    ('the-witcher-3', 'PlayStation 4', 199.50, 75.00),
    ('the-witcher-3', 'Xbox Series', 189.90, NULL),
    ('the-witcher-3', 'Xbox One', 189.90, NULL),
    ('the-witcher-3', 'Nintendo Switch', 179.90, NULL),
    ('the-witcher-3', 'PC', 159.99, 75.00),
    ('final-fantasy-vii-remake-intergrade', 'PlayStation 5', 199.90, NULL),
    ('final-fantasy-vii-remake-intergrade', 'PlayStation 4', 199.90, NULL),
    ('final-fantasy-vii-remake-intergrade', 'PC', 174.90, NULL),
    ('final-fantasy-vii-rebirth', 'PlayStation 5', 249.90, 20.00),
    ('final-fantasy-vii-rebirth', 'PC', 219.90, 10.00),
    ('final-fantasy-xvi', 'PlayStation 5', 249.90, 10.00),
    ('final-fantasy-xvi', 'PC', 219.90, 40.00),
    ('dragon-quest-xi-s', 'PlayStation 4', 199.90, NULL),
    ('dragon-quest-xi-s', 'Xbox One', 189.90, NULL),
    ('dragon-quest-xi-s', 'Nintendo Switch', 189.90, 75.00),
    ('dragon-quest-xi-s', 'PC', 169.90, NULL),
    ('dragon-quest-builders-2', 'PlayStation 4', 199.50, NULL),
    ('dragon-quest-builders-2', 'Xbox One', 189.90, 50.00),
    ('dragon-quest-builders-2', 'Nintendo Switch', 219.90, NULL),
    ('dragon-quest-builders-2', 'PC', 199.90, NULL),
    ('the-last-guardian', 'PlayStation 4', 99.50, 75.00),
    ('shadow-of-the-colossus', 'PlayStation 4', 114.90, NULL),
    ('forza-horizon-5', 'Xbox Series', 269.90, NULL),
    ('forza-horizon-5', 'Xbox One', 269.90, NULL),
    ('forza-horizon-5', 'PC', 249.00, NULL),
    ('forza-horizon-5', 'PlayStation 5', 289.90, NULL),
    ('forza-horizon-4', 'Xbox One', 149.90, NULL),
    ('forza-horizon-4', 'PC', 149.90, NULL)
) AS v(slug, plataforma, preco, desconto)
JOIN produto pr    ON pr.slug = v.slug
JOIN plataforma pl ON pl.nome = v.plataforma;

-- ---------------------------------------------------------------------
-- Mídias (entidade fraca: jogo + ordem). Trailer do YouTube primeiro, depois imagens.
-- ---------------------------------------------------------------------
INSERT INTO midia (jogo_id, ordem, tipo, url)
SELECT pr.id, v.ordem, v.tipo, v.url
FROM (VALUES
    ('elden-ring', 1, 'trailer', 'https://www.youtube.com/watch?v=qqiC88f9ogU'),
    ('elden-ring', 2, 'imagem', '/games/elden-ring/banner.jpg'),
    ('elden-ring', 3, 'imagem', '/games/elden-ring/screenshot-1.jpg'),
    ('elden-ring', 4, 'imagem', '/games/elden-ring/screenshot-2.jpg'),
    ('elden-ring', 5, 'imagem', '/games/elden-ring/screenshot-3.jpg'),
    ('bloodborne', 1, 'trailer', 'https://www.youtube.com/watch?v=iTDvYvlyPaE'),
    ('bloodborne', 2, 'imagem', '/games/bloodborne/banner.jpg'),
    ('bloodborne', 3, 'imagem', '/games/bloodborne/screenshot-1.jpg'),
    ('bloodborne', 4, 'imagem', '/games/bloodborne/screenshot-2.jpg'),
    ('bloodborne', 5, 'imagem', '/games/bloodborne/screenshot-3.jpg'),
    ('demons-souls', 1, 'trailer', 'https://www.youtube.com/watch?v=2TMs2E6cms4'),
    ('demons-souls', 2, 'imagem', '/games/demons-souls/banner.jpg'),
    ('demons-souls', 3, 'imagem', '/games/demons-souls/screenshot-1.jpg'),
    ('demons-souls', 4, 'imagem', '/games/demons-souls/screenshot-2.jpg'),
    ('dark-souls-remastered', 1, 'trailer', 'https://www.youtube.com/watch?v=KfjG9ZLGBHE'),
    ('dark-souls-remastered', 2, 'imagem', '/games/dark-souls-remastered/banner.jpg'),
    ('dark-souls-remastered', 3, 'imagem', '/games/dark-souls-remastered/screenshot-1.jpg'),
    ('dark-souls-remastered', 4, 'imagem', '/games/dark-souls-remastered/screenshot-2.jpg'),
    ('dark-souls-remastered', 5, 'imagem', '/games/dark-souls-remastered/screenshot-3.jpg'),
    ('dark-souls-iii', 1, 'trailer', 'https://www.youtube.com/watch?v=cWBwFhUv1-8'),
    ('dark-souls-iii', 2, 'imagem', '/games/dark-souls-iii/banner.jpg'),
    ('dark-souls-iii', 3, 'imagem', '/games/dark-souls-iii/screenshot-1.jpg'),
    ('dark-souls-iii', 4, 'imagem', '/games/dark-souls-iii/screenshot-2.jpg'),
    ('dark-souls-iii', 5, 'imagem', '/games/dark-souls-iii/screenshot-3.jpg'),
    ('sekiro', 1, 'trailer', 'https://www.youtube.com/watch?v=rXMX4YJ7Lks'),
    ('sekiro', 2, 'imagem', '/games/sekiro/banner.jpg'),
    ('sekiro', 3, 'imagem', '/games/sekiro/screenshot-1.jpg'),
    ('sekiro', 4, 'imagem', '/games/sekiro/screenshot-2.jpg'),
    ('sekiro', 5, 'imagem', '/games/sekiro/screenshot-3.jpg'),
    ('super-mario-odyssey', 1, 'trailer', 'https://www.youtube.com/watch?v=wGQHQc_3ycE'),
    ('super-mario-odyssey', 2, 'imagem', '/games/super-mario-odyssey/banner.jpg'),
    ('super-mario-odyssey', 3, 'imagem', '/games/super-mario-odyssey/screenshot-1.jpg'),
    ('super-mario-odyssey', 4, 'imagem', '/games/super-mario-odyssey/screenshot-2.jpg'),
    ('super-mario-odyssey', 5, 'imagem', '/games/super-mario-odyssey/screenshot-3.jpg'),
    ('pikmin-4', 1, 'trailer', 'https://www.youtube.com/watch?v=RPiT-s4i0rw'),
    ('pikmin-4', 2, 'imagem', '/games/pikmin-4/banner.jpg'),
    ('pikmin-4', 3, 'imagem', '/games/pikmin-4/screenshot-1.jpg'),
    ('pikmin-4', 4, 'imagem', '/games/pikmin-4/screenshot-2.jpg'),
    ('pikmin-4', 5, 'imagem', '/games/pikmin-4/screenshot-3.jpg'),
    ('super-mario-bros-wonder', 1, 'trailer', 'https://www.youtube.com/watch?v=XvQNlGKNC6o'),
    ('super-mario-bros-wonder', 2, 'imagem', '/games/super-mario-bros-wonder/banner.jpg'),
    ('super-mario-bros-wonder', 3, 'imagem', '/games/super-mario-bros-wonder/screenshot-1.jpg'),
    ('super-mario-bros-wonder', 4, 'imagem', '/games/super-mario-bros-wonder/screenshot-2.jpg'),
    ('super-mario-bros-wonder', 5, 'imagem', '/games/super-mario-bros-wonder/screenshot-3.jpg'),
    ('zelda-breath-of-the-wild', 1, 'trailer', 'https://www.youtube.com/watch?v=RfEGOLOGYgw'),
    ('zelda-breath-of-the-wild', 2, 'imagem', '/games/zelda-breath-of-the-wild/banner.jpg'),
    ('zelda-breath-of-the-wild', 3, 'imagem', '/games/zelda-breath-of-the-wild/screenshot-1.jpg'),
    ('zelda-breath-of-the-wild', 4, 'imagem', '/games/zelda-breath-of-the-wild/screenshot-2.jpg'),
    ('zelda-breath-of-the-wild', 5, 'imagem', '/games/zelda-breath-of-the-wild/screenshot-3.jpg'),
    ('zelda-tears-of-the-kingdom', 1, 'trailer', 'https://www.youtube.com/watch?v=2SNF4M_v7wc'),
    ('zelda-tears-of-the-kingdom', 2, 'imagem', '/games/zelda-tears-of-the-kingdom/banner.jpg'),
    ('zelda-tears-of-the-kingdom', 3, 'imagem', '/games/zelda-tears-of-the-kingdom/screenshot-1.jpg'),
    ('zelda-tears-of-the-kingdom', 4, 'imagem', '/games/zelda-tears-of-the-kingdom/screenshot-2.jpg'),
    ('zelda-tears-of-the-kingdom', 5, 'imagem', '/games/zelda-tears-of-the-kingdom/screenshot-3.jpg'),
    ('mario-kart-8-deluxe', 1, 'trailer', 'https://www.youtube.com/watch?v=tKlRN2YpxRE'),
    ('mario-kart-8-deluxe', 2, 'imagem', '/games/mario-kart-8-deluxe/banner.jpg'),
    ('mario-kart-8-deluxe', 3, 'imagem', '/games/mario-kart-8-deluxe/screenshot-1.jpg'),
    ('mario-kart-8-deluxe', 4, 'imagem', '/games/mario-kart-8-deluxe/screenshot-2.jpg'),
    ('mario-kart-8-deluxe', 5, 'imagem', '/games/mario-kart-8-deluxe/screenshot-3.jpg'),
    ('mario-kart-world', 1, 'trailer', 'https://www.youtube.com/watch?v=3pE23YTYEZM'),
    ('mario-kart-world', 2, 'imagem', '/games/mario-kart-world/banner.jpg'),
    ('mario-kart-world', 3, 'imagem', '/games/mario-kart-world/screenshot-1.jpg'),
    ('mario-kart-world', 4, 'imagem', '/games/mario-kart-world/screenshot-2.jpg'),
    ('mario-kart-world', 5, 'imagem', '/games/mario-kart-world/screenshot-3.jpg'),
    ('donkey-kong-bananza', 1, 'trailer', 'https://www.youtube.com/watch?v=tdsRPs6rX4w'),
    ('donkey-kong-bananza', 2, 'imagem', '/games/donkey-kong-bananza/banner.jpg'),
    ('donkey-kong-bananza', 3, 'imagem', '/games/donkey-kong-bananza/screenshot-1.jpg'),
    ('donkey-kong-bananza', 4, 'imagem', '/games/donkey-kong-bananza/screenshot-2.jpg'),
    ('donkey-kong-bananza', 5, 'imagem', '/games/donkey-kong-bananza/screenshot-3.jpg'),
    ('super-smash-bros-ultimate', 1, 'trailer', 'https://www.youtube.com/watch?v=EXnbMp1yr1k'),
    ('super-smash-bros-ultimate', 2, 'imagem', '/games/super-smash-bros-ultimate/banner.jpg'),
    ('super-smash-bros-ultimate', 3, 'imagem', '/games/super-smash-bros-ultimate/screenshot-1.jpg'),
    ('super-smash-bros-ultimate', 4, 'imagem', '/games/super-smash-bros-ultimate/screenshot-2.jpg'),
    ('super-smash-bros-ultimate', 5, 'imagem', '/games/super-smash-bros-ultimate/screenshot-3.jpg'),
    ('kirby-air-riders', 1, 'trailer', 'https://www.youtube.com/watch?v=z3puFLFDfxE'),
    ('kirby-air-riders', 2, 'imagem', '/games/kirby-air-riders/banner.jpg'),
    ('kirby-air-riders', 3, 'imagem', '/games/kirby-air-riders/screenshot-1.jpg'),
    ('kirby-air-riders', 4, 'imagem', '/games/kirby-air-riders/screenshot-2.jpg'),
    ('kirby-air-riders', 5, 'imagem', '/games/kirby-air-riders/screenshot-3.jpg'),
    ('death-stranding', 1, 'trailer', 'https://www.youtube.com/watch?v=H2Hy96sOnq8'),
    ('death-stranding', 2, 'imagem', '/games/death-stranding/banner.jpg'),
    ('death-stranding', 3, 'imagem', '/games/death-stranding/screenshot-1.jpg'),
    ('death-stranding', 4, 'imagem', '/games/death-stranding/screenshot-2.jpg'),
    ('death-stranding', 5, 'imagem', '/games/death-stranding/screenshot-3.jpg'),
    ('death-stranding-2', 1, 'trailer', 'https://www.youtube.com/watch?v=EQdOSTt7YpY'),
    ('death-stranding-2', 2, 'imagem', '/games/death-stranding-2/banner.jpg'),
    ('death-stranding-2', 3, 'imagem', '/games/death-stranding-2/screenshot-1.jpg'),
    ('death-stranding-2', 4, 'imagem', '/games/death-stranding-2/screenshot-2.jpg'),
    ('death-stranding-2', 5, 'imagem', '/games/death-stranding-2/screenshot-3.jpg'),
    ('metal-gear-solid-v', 1, 'trailer', 'https://www.youtube.com/watch?v=C19ap2M7DDE'),
    ('metal-gear-solid-v', 2, 'imagem', '/games/metal-gear-solid-v/banner.jpg'),
    ('metal-gear-solid-v', 3, 'imagem', '/games/metal-gear-solid-v/screenshot-1.jpg'),
    ('metal-gear-solid-v', 4, 'imagem', '/games/metal-gear-solid-v/screenshot-2.jpg'),
    ('metal-gear-solid-v', 5, 'imagem', '/games/metal-gear-solid-v/screenshot-3.jpg'),
    ('sonic-origins', 1, 'trailer', 'https://www.youtube.com/watch?v=AtLWtVKrcDY'),
    ('sonic-origins', 2, 'imagem', '/games/sonic-origins/banner.jpg'),
    ('sonic-origins', 3, 'imagem', '/games/sonic-origins/screenshot-1.jpg'),
    ('sonic-origins', 4, 'imagem', '/games/sonic-origins/screenshot-2.jpg'),
    ('sonic-origins', 5, 'imagem', '/games/sonic-origins/screenshot-3.jpg'),
    ('sonic-x-shadow-generations', 1, 'trailer', 'https://www.youtube.com/watch?v=yzK7gQWDnRk'),
    ('sonic-x-shadow-generations', 2, 'imagem', '/games/sonic-x-shadow-generations/banner.jpg'),
    ('sonic-x-shadow-generations', 3, 'imagem', '/games/sonic-x-shadow-generations/screenshot-1.jpg'),
    ('sonic-x-shadow-generations', 4, 'imagem', '/games/sonic-x-shadow-generations/screenshot-2.jpg'),
    ('sonic-x-shadow-generations', 5, 'imagem', '/games/sonic-x-shadow-generations/screenshot-3.jpg'),
    ('sonic-frontiers', 1, 'trailer', 'https://www.youtube.com/watch?v=hv_zibBXjlg'),
    ('sonic-frontiers', 2, 'imagem', '/games/sonic-frontiers/banner.jpg'),
    ('sonic-frontiers', 3, 'imagem', '/games/sonic-frontiers/screenshot-1.jpg'),
    ('sonic-frontiers', 4, 'imagem', '/games/sonic-frontiers/screenshot-2.jpg'),
    ('sonic-frontiers', 5, 'imagem', '/games/sonic-frontiers/screenshot-3.jpg'),
    ('sonic-colors-ultimate', 1, 'trailer', 'https://www.youtube.com/watch?v=Z3MCqTdsVKc'),
    ('sonic-colors-ultimate', 2, 'imagem', '/games/sonic-colors-ultimate/banner.jpg'),
    ('sonic-colors-ultimate', 3, 'imagem', '/games/sonic-colors-ultimate/screenshot-1.jpg'),
    ('sonic-colors-ultimate', 4, 'imagem', '/games/sonic-colors-ultimate/screenshot-2.jpg'),
    ('sonic-colors-ultimate', 5, 'imagem', '/games/sonic-colors-ultimate/screenshot-3.jpg'),
    ('the-last-of-us-part-i', 1, 'trailer', 'https://www.youtube.com/watch?v=R2Ebc_OFeug'),
    ('the-last-of-us-part-i', 2, 'imagem', '/games/the-last-of-us-part-i/banner.jpg'),
    ('the-last-of-us-part-i', 3, 'imagem', '/games/the-last-of-us-part-i/screenshot-1.jpg'),
    ('the-last-of-us-part-i', 4, 'imagem', '/games/the-last-of-us-part-i/screenshot-2.jpg'),
    ('the-last-of-us-part-i', 5, 'imagem', '/games/the-last-of-us-part-i/screenshot-3.jpg'),
    ('the-last-of-us-part-ii', 1, 'trailer', 'https://www.youtube.com/watch?v=vhII1qlcZ4E'),
    ('the-last-of-us-part-ii', 2, 'imagem', '/games/the-last-of-us-part-ii/banner.jpg'),
    ('the-last-of-us-part-ii', 3, 'imagem', '/games/the-last-of-us-part-ii/screenshot-1.jpg'),
    ('the-last-of-us-part-ii', 4, 'imagem', '/games/the-last-of-us-part-ii/screenshot-2.jpg'),
    ('the-last-of-us-part-ii', 5, 'imagem', '/games/the-last-of-us-part-ii/screenshot-3.jpg'),
    ('uncharted-4', 1, 'trailer', 'https://www.youtube.com/watch?v=hh5HV4iic1Y'),
    ('uncharted-4', 2, 'imagem', '/games/uncharted-4/banner.jpg'),
    ('uncharted-4', 3, 'imagem', '/games/uncharted-4/screenshot-1.jpg'),
    ('uncharted-4', 4, 'imagem', '/games/uncharted-4/screenshot-2.jpg'),
    ('uncharted-4', 5, 'imagem', '/games/uncharted-4/screenshot-3.jpg'),
    ('uncharted-legacy-of-thieves', 1, 'trailer', 'https://www.youtube.com/watch?v=lFfVZ13ohKs'),
    ('uncharted-legacy-of-thieves', 2, 'imagem', '/games/uncharted-legacy-of-thieves/banner.jpg'),
    ('uncharted-legacy-of-thieves', 3, 'imagem', '/games/uncharted-legacy-of-thieves/screenshot-1.jpg'),
    ('uncharted-legacy-of-thieves', 4, 'imagem', '/games/uncharted-legacy-of-thieves/screenshot-2.jpg'),
    ('uncharted-legacy-of-thieves', 5, 'imagem', '/games/uncharted-legacy-of-thieves/screenshot-3.jpg'),
    ('god-of-war-2018', 1, 'trailer', 'https://www.youtube.com/watch?v=K0u_kAWLJOA'),
    ('god-of-war-2018', 2, 'imagem', '/games/god-of-war-2018/banner.jpg'),
    ('god-of-war-2018', 3, 'imagem', '/games/god-of-war-2018/screenshot-1.jpg'),
    ('god-of-war-2018', 4, 'imagem', '/games/god-of-war-2018/screenshot-2.jpg'),
    ('god-of-war-2018', 5, 'imagem', '/games/god-of-war-2018/screenshot-3.jpg'),
    ('god-of-war-ragnarok', 1, 'trailer', 'https://www.youtube.com/watch?v=hfJ4Km46A-0'),
    ('god-of-war-ragnarok', 2, 'imagem', '/games/god-of-war-ragnarok/banner.jpg'),
    ('god-of-war-ragnarok', 3, 'imagem', '/games/god-of-war-ragnarok/screenshot-1.jpg'),
    ('god-of-war-ragnarok', 4, 'imagem', '/games/god-of-war-ragnarok/screenshot-2.jpg'),
    ('god-of-war-ragnarok', 5, 'imagem', '/games/god-of-war-ragnarok/screenshot-3.jpg'),
    ('starfield', 1, 'trailer', 'https://www.youtube.com/watch?v=kfYEiTdsyas'),
    ('starfield', 2, 'imagem', '/games/starfield/banner.jpg'),
    ('starfield', 3, 'imagem', '/games/starfield/screenshot-1.jpg'),
    ('starfield', 4, 'imagem', '/games/starfield/screenshot-2.jpg'),
    ('starfield', 5, 'imagem', '/games/starfield/screenshot-3.jpg'),
    ('skyrim', 1, 'trailer', 'https://www.youtube.com/watch?v=JSRtYpNRoN0'),
    ('skyrim', 2, 'imagem', '/games/skyrim/banner.jpg'),
    ('skyrim', 3, 'imagem', '/games/skyrim/screenshot-1.jpg'),
    ('skyrim', 4, 'imagem', '/games/skyrim/screenshot-2.jpg'),
    ('skyrim', 5, 'imagem', '/games/skyrim/screenshot-3.jpg'),
    ('fallout-4', 1, 'trailer', 'https://www.youtube.com/watch?v=ivStn8l6_9w'),
    ('fallout-4', 2, 'imagem', '/games/fallout-4/banner.jpg'),
    ('fallout-4', 3, 'imagem', '/games/fallout-4/screenshot-1.jpg'),
    ('fallout-4', 4, 'imagem', '/games/fallout-4/screenshot-2.jpg'),
    ('fallout-4', 5, 'imagem', '/games/fallout-4/screenshot-3.jpg'),
    ('fallout-76', 1, 'trailer', 'https://www.youtube.com/watch?v=vQ3YhoY70pc'),
    ('fallout-76', 2, 'imagem', '/games/fallout-76/banner.jpg'),
    ('fallout-76', 3, 'imagem', '/games/fallout-76/screenshot-1.jpg'),
    ('fallout-76', 4, 'imagem', '/games/fallout-76/screenshot-2.jpg'),
    ('fallout-76', 5, 'imagem', '/games/fallout-76/screenshot-3.jpg'),
    ('oblivion-remastered', 1, 'trailer', 'https://www.youtube.com/watch?v=wFJ3PZuAjK4'),
    ('oblivion-remastered', 2, 'imagem', '/games/oblivion-remastered/banner.jpg'),
    ('oblivion-remastered', 3, 'imagem', '/games/oblivion-remastered/screenshot-1.jpg'),
    ('oblivion-remastered', 4, 'imagem', '/games/oblivion-remastered/screenshot-2.jpg'),
    ('oblivion-remastered', 5, 'imagem', '/games/oblivion-remastered/screenshot-3.jpg'),
    ('red-dead-redemption-2', 1, 'trailer', 'https://www.youtube.com/watch?v=eaW0tYpxyp0'),
    ('red-dead-redemption-2', 2, 'imagem', '/games/red-dead-redemption-2/banner.jpg'),
    ('red-dead-redemption-2', 3, 'imagem', '/games/red-dead-redemption-2/screenshot-1.jpg'),
    ('red-dead-redemption-2', 4, 'imagem', '/games/red-dead-redemption-2/screenshot-2.jpg'),
    ('red-dead-redemption-2', 5, 'imagem', '/games/red-dead-redemption-2/screenshot-3.jpg'),
    ('grand-theft-auto-v', 1, 'trailer', 'https://www.youtube.com/watch?v=hvoD7ehZPcM'),
    ('grand-theft-auto-v', 2, 'imagem', '/games/grand-theft-auto-v/banner.jpg'),
    ('grand-theft-auto-v', 3, 'imagem', '/games/grand-theft-auto-v/screenshot-1.jpg'),
    ('grand-theft-auto-v', 4, 'imagem', '/games/grand-theft-auto-v/screenshot-2.jpg'),
    ('grand-theft-auto-v', 5, 'imagem', '/games/grand-theft-auto-v/screenshot-3.jpg'),
    ('red-dead-redemption', 1, 'trailer', 'https://www.youtube.com/watch?v=PD24MkbHQrc'),
    ('red-dead-redemption', 2, 'imagem', '/games/red-dead-redemption/banner.jpg'),
    ('red-dead-redemption', 3, 'imagem', '/games/red-dead-redemption/screenshot-1.jpg'),
    ('red-dead-redemption', 4, 'imagem', '/games/red-dead-redemption/screenshot-2.jpg'),
    ('red-dead-redemption', 5, 'imagem', '/games/red-dead-redemption/screenshot-3.jpg'),
    ('gta-trilogy-definitive', 1, 'trailer', 'https://www.youtube.com/watch?v=7x7zr1onxfU'),
    ('gta-trilogy-definitive', 2, 'imagem', '/games/gta-trilogy-definitive/banner.jpg'),
    ('gta-trilogy-definitive', 3, 'imagem', '/games/gta-trilogy-definitive/screenshot-1.jpg'),
    ('gta-trilogy-definitive', 4, 'imagem', '/games/gta-trilogy-definitive/screenshot-2.jpg'),
    ('gta-trilogy-definitive', 5, 'imagem', '/games/gta-trilogy-definitive/screenshot-3.jpg'),
    ('clair-obscur-expedition-33', 1, 'trailer', 'https://www.youtube.com/watch?v=2VaLOc1FpSo'),
    ('clair-obscur-expedition-33', 2, 'imagem', '/games/clair-obscur-expedition-33/banner.jpg'),
    ('clair-obscur-expedition-33', 3, 'imagem', '/games/clair-obscur-expedition-33/screenshot-1.jpg'),
    ('clair-obscur-expedition-33', 4, 'imagem', '/games/clair-obscur-expedition-33/screenshot-2.jpg'),
    ('clair-obscur-expedition-33', 5, 'imagem', '/games/clair-obscur-expedition-33/screenshot-3.jpg'),
    ('devil-may-cry-5', 1, 'trailer', 'https://www.youtube.com/watch?v=dG6_CAdiLPM'),
    ('devil-may-cry-5', 2, 'imagem', '/games/devil-may-cry-5/banner.jpg'),
    ('devil-may-cry-5', 3, 'imagem', '/games/devil-may-cry-5/screenshot-1.jpg'),
    ('devil-may-cry-5', 4, 'imagem', '/games/devil-may-cry-5/screenshot-2.jpg'),
    ('devil-may-cry-5', 5, 'imagem', '/games/devil-may-cry-5/screenshot-3.jpg'),
    ('dragons-dogma-2', 1, 'trailer', 'https://www.youtube.com/watch?v=cT0rIgaiPWA'),
    ('dragons-dogma-2', 2, 'imagem', '/games/dragons-dogma-2/banner.jpg'),
    ('dragons-dogma-2', 3, 'imagem', '/games/dragons-dogma-2/screenshot-1.jpg'),
    ('dragons-dogma-2', 4, 'imagem', '/games/dragons-dogma-2/screenshot-2.jpg'),
    ('dragons-dogma-2', 5, 'imagem', '/games/dragons-dogma-2/screenshot-3.jpg'),
    ('dragons-dogma-dark-arisen', 1, 'trailer', 'https://www.youtube.com/watch?v=XmKyRay8hGc'),
    ('dragons-dogma-dark-arisen', 2, 'imagem', '/games/dragons-dogma-dark-arisen/banner.jpg'),
    ('dragons-dogma-dark-arisen', 3, 'imagem', '/games/dragons-dogma-dark-arisen/screenshot-1.jpg'),
    ('dragons-dogma-dark-arisen', 4, 'imagem', '/games/dragons-dogma-dark-arisen/screenshot-2.jpg'),
    ('dragons-dogma-dark-arisen', 5, 'imagem', '/games/dragons-dogma-dark-arisen/screenshot-3.jpg'),
    ('monster-hunter-world', 1, 'trailer', 'https://www.youtube.com/watch?v=OotQrKEqe94'),
    ('monster-hunter-world', 2, 'imagem', '/games/monster-hunter-world/banner.jpg'),
    ('monster-hunter-world', 3, 'imagem', '/games/monster-hunter-world/screenshot-1.jpg'),
    ('monster-hunter-world', 4, 'imagem', '/games/monster-hunter-world/screenshot-2.jpg'),
    ('monster-hunter-world', 5, 'imagem', '/games/monster-hunter-world/screenshot-3.jpg'),
    ('monster-hunter-wilds', 1, 'trailer', 'https://www.youtube.com/watch?v=a_wNFT4j6qI'),
    ('monster-hunter-wilds', 2, 'imagem', '/games/monster-hunter-wilds/banner.jpg'),
    ('monster-hunter-wilds', 3, 'imagem', '/games/monster-hunter-wilds/screenshot-1.jpg'),
    ('monster-hunter-wilds', 4, 'imagem', '/games/monster-hunter-wilds/screenshot-2.jpg'),
    ('monster-hunter-wilds', 5, 'imagem', '/games/monster-hunter-wilds/screenshot-3.jpg'),
    ('resident-evil-2-remake', 1, 'trailer', 'https://www.youtube.com/watch?v=u3wS-Q2KBpk'),
    ('resident-evil-2-remake', 2, 'imagem', '/games/resident-evil-2-remake/banner.jpg'),
    ('resident-evil-2-remake', 3, 'imagem', '/games/resident-evil-2-remake/screenshot-1.jpg'),
    ('resident-evil-2-remake', 4, 'imagem', '/games/resident-evil-2-remake/screenshot-2.jpg'),
    ('resident-evil-2-remake', 5, 'imagem', '/games/resident-evil-2-remake/screenshot-3.jpg'),
    ('resident-evil-7', 1, 'trailer', 'https://www.youtube.com/watch?v=RgYqQsbKn6w'),
    ('resident-evil-7', 2, 'imagem', '/games/resident-evil-7/banner.jpg'),
    ('resident-evil-7', 3, 'imagem', '/games/resident-evil-7/screenshot-1.jpg'),
    ('resident-evil-7', 4, 'imagem', '/games/resident-evil-7/screenshot-2.jpg'),
    ('resident-evil-7', 5, 'imagem', '/games/resident-evil-7/screenshot-3.jpg'),
    ('street-fighter-6', 1, 'trailer', 'https://www.youtube.com/watch?v=1INU3FOJsTw'),
    ('street-fighter-6', 2, 'imagem', '/games/street-fighter-6/banner.jpg'),
    ('street-fighter-6', 3, 'imagem', '/games/street-fighter-6/screenshot-1.jpg'),
    ('street-fighter-6', 4, 'imagem', '/games/street-fighter-6/screenshot-2.jpg'),
    ('street-fighter-6', 5, 'imagem', '/games/street-fighter-6/screenshot-3.jpg'),
    ('nier-automata', 1, 'trailer', 'https://www.youtube.com/watch?v=iRAHnXbPIQo'),
    ('nier-automata', 2, 'imagem', '/games/nier-automata/banner.jpg'),
    ('nier-automata', 3, 'imagem', '/games/nier-automata/screenshot-1.jpg'),
    ('nier-automata', 4, 'imagem', '/games/nier-automata/screenshot-2.jpg'),
    ('nier-automata', 5, 'imagem', '/games/nier-automata/screenshot-3.jpg'),
    ('nier-replicant', 1, 'trailer', 'https://www.youtube.com/watch?v=sPcf4pfTqfY'),
    ('nier-replicant', 2, 'imagem', '/games/nier-replicant/banner.jpg'),
    ('nier-replicant', 3, 'imagem', '/games/nier-replicant/screenshot-1.jpg'),
    ('nier-replicant', 4, 'imagem', '/games/nier-replicant/screenshot-2.jpg'),
    ('nier-replicant', 5, 'imagem', '/games/nier-replicant/screenshot-3.jpg'),
    ('baldurs-gate-3', 1, 'trailer', 'https://www.youtube.com/watch?v=1T22wNvoNiU'),
    ('baldurs-gate-3', 2, 'imagem', '/games/baldurs-gate-3/banner.jpg'),
    ('baldurs-gate-3', 3, 'imagem', '/games/baldurs-gate-3/screenshot-1.jpg'),
    ('baldurs-gate-3', 4, 'imagem', '/games/baldurs-gate-3/screenshot-2.jpg'),
    ('baldurs-gate-3', 5, 'imagem', '/games/baldurs-gate-3/screenshot-3.jpg'),
    ('divinity-original-sin-2', 1, 'trailer', 'https://www.youtube.com/watch?v=bTWTFX8qzPI'),
    ('divinity-original-sin-2', 2, 'imagem', '/games/divinity-original-sin-2/banner.jpg'),
    ('divinity-original-sin-2', 3, 'imagem', '/games/divinity-original-sin-2/screenshot-1.jpg'),
    ('divinity-original-sin-2', 4, 'imagem', '/games/divinity-original-sin-2/screenshot-2.jpg'),
    ('divinity-original-sin-2', 5, 'imagem', '/games/divinity-original-sin-2/screenshot-3.jpg'),
    ('divinity-original-sin', 1, 'trailer', 'https://www.youtube.com/watch?v=rxnApC7Uxik'),
    ('divinity-original-sin', 2, 'imagem', '/games/divinity-original-sin/banner.jpg'),
    ('divinity-original-sin', 3, 'imagem', '/games/divinity-original-sin/screenshot-1.jpg'),
    ('divinity-original-sin', 4, 'imagem', '/games/divinity-original-sin/screenshot-2.jpg'),
    ('divinity-original-sin', 5, 'imagem', '/games/divinity-original-sin/screenshot-3.jpg'),
    ('persona-5-royal', 1, 'trailer', 'https://www.youtube.com/watch?v=LFzh6T7bQ_M'),
    ('persona-5-royal', 2, 'imagem', '/games/persona-5-royal/banner.jpg'),
    ('persona-5-royal', 3, 'imagem', '/games/persona-5-royal/screenshot-1.jpg'),
    ('persona-5-royal', 4, 'imagem', '/games/persona-5-royal/screenshot-2.jpg'),
    ('persona-5-royal', 5, 'imagem', '/games/persona-5-royal/screenshot-3.jpg'),
    ('persona-3-reload', 1, 'trailer', 'https://www.youtube.com/watch?v=QIIPXA2A6cM'),
    ('persona-3-reload', 2, 'imagem', '/games/persona-3-reload/banner.jpg'),
    ('persona-3-reload', 3, 'imagem', '/games/persona-3-reload/screenshot-1.jpg'),
    ('persona-3-reload', 4, 'imagem', '/games/persona-3-reload/screenshot-2.jpg'),
    ('persona-3-reload', 5, 'imagem', '/games/persona-3-reload/screenshot-3.jpg'),
    ('persona-4-golden', 1, 'trailer', 'https://www.youtube.com/watch?v=jWO_Nlfgek0'),
    ('persona-4-golden', 2, 'imagem', '/games/persona-4-golden/banner.jpg'),
    ('persona-4-golden', 3, 'imagem', '/games/persona-4-golden/screenshot-1.jpg'),
    ('persona-4-golden', 4, 'imagem', '/games/persona-4-golden/screenshot-2.jpg'),
    ('persona-4-golden', 5, 'imagem', '/games/persona-4-golden/screenshot-3.jpg'),
    ('metaphor-refantazio', 1, 'trailer', 'https://www.youtube.com/watch?v=yQPk4cVrU_w'),
    ('metaphor-refantazio', 2, 'imagem', '/games/metaphor-refantazio/banner.jpg'),
    ('metaphor-refantazio', 3, 'imagem', '/games/metaphor-refantazio/screenshot-1.jpg'),
    ('metaphor-refantazio', 4, 'imagem', '/games/metaphor-refantazio/screenshot-2.jpg'),
    ('metaphor-refantazio', 5, 'imagem', '/games/metaphor-refantazio/screenshot-3.jpg'),
    ('marvels-spider-man', 1, 'trailer', 'https://www.youtube.com/watch?v=q4GdJVvdxss'),
    ('marvels-spider-man', 2, 'imagem', '/games/marvels-spider-man/banner.jpg'),
    ('marvels-spider-man', 3, 'imagem', '/games/marvels-spider-man/screenshot-1.jpg'),
    ('marvels-spider-man', 4, 'imagem', '/games/marvels-spider-man/screenshot-2.jpg'),
    ('marvels-spider-man', 5, 'imagem', '/games/marvels-spider-man/screenshot-3.jpg'),
    ('spider-man-miles-morales', 1, 'trailer', 'https://www.youtube.com/watch?v=3wHL2VIaFcs'),
    ('spider-man-miles-morales', 2, 'imagem', '/games/spider-man-miles-morales/banner.jpg'),
    ('spider-man-miles-morales', 3, 'imagem', '/games/spider-man-miles-morales/screenshot-1.jpg'),
    ('spider-man-miles-morales', 4, 'imagem', '/games/spider-man-miles-morales/screenshot-2.jpg'),
    ('spider-man-miles-morales', 5, 'imagem', '/games/spider-man-miles-morales/screenshot-3.jpg'),
    ('marvels-spider-man-2', 1, 'trailer', 'https://www.youtube.com/watch?v=9fVYKsEmuRo'),
    ('marvels-spider-man-2', 2, 'imagem', '/games/marvels-spider-man-2/banner.jpg'),
    ('marvels-spider-man-2', 3, 'imagem', '/games/marvels-spider-man-2/screenshot-1.jpg'),
    ('marvels-spider-man-2', 4, 'imagem', '/games/marvels-spider-man-2/screenshot-2.jpg'),
    ('marvels-spider-man-2', 5, 'imagem', '/games/marvels-spider-man-2/screenshot-3.jpg'),
    ('hades', 1, 'trailer', 'https://www.youtube.com/watch?v=91t0ha9x0AE'),
    ('hades', 2, 'imagem', '/games/hades/banner.jpg'),
    ('hades', 3, 'imagem', '/games/hades/screenshot-1.jpg'),
    ('hades', 4, 'imagem', '/games/hades/screenshot-2.jpg'),
    ('hades', 5, 'imagem', '/games/hades/screenshot-3.jpg'),
    ('hades-ii', 1, 'trailer', 'https://www.youtube.com/watch?v=U8lJRcUeEMs'),
    ('hades-ii', 2, 'imagem', '/games/hades-ii/banner.jpg'),
    ('hades-ii', 3, 'imagem', '/games/hades-ii/screenshot-1.jpg'),
    ('hades-ii', 4, 'imagem', '/games/hades-ii/screenshot-2.jpg'),
    ('hades-ii', 5, 'imagem', '/games/hades-ii/screenshot-3.jpg'),
    ('transistor', 1, 'trailer', 'https://www.youtube.com/watch?v=GTik6sYT_BE'),
    ('transistor', 2, 'imagem', '/games/transistor/banner.jpg'),
    ('transistor', 3, 'imagem', '/games/transistor/screenshot-1.jpg'),
    ('transistor', 4, 'imagem', '/games/transistor/screenshot-2.jpg'),
    ('transistor', 5, 'imagem', '/games/transistor/screenshot-3.jpg'),
    ('bastion', 1, 'trailer', 'https://www.youtube.com/watch?v=TptJHeWngJs'),
    ('bastion', 2, 'imagem', '/games/bastion/banner.jpg'),
    ('bastion', 3, 'imagem', '/games/bastion/screenshot-1.jpg'),
    ('bastion', 4, 'imagem', '/games/bastion/screenshot-2.jpg'),
    ('bastion', 5, 'imagem', '/games/bastion/screenshot-3.jpg'),
    ('gran-turismo-7', 1, 'trailer', 'https://www.youtube.com/watch?v=oz-O74SmTSQ'),
    ('gran-turismo-7', 2, 'imagem', '/games/gran-turismo-7/banner.jpg'),
    ('gran-turismo-7', 3, 'imagem', '/games/gran-turismo-7/screenshot-1.jpg'),
    ('gran-turismo-7', 4, 'imagem', '/games/gran-turismo-7/screenshot-2.jpg'),
    ('gran-turismo-7', 5, 'imagem', '/games/gran-turismo-7/screenshot-3.jpg'),
    ('gran-turismo-sport', 1, 'trailer', 'https://www.youtube.com/watch?v=moDdHXpxWrw'),
    ('gran-turismo-sport', 2, 'imagem', '/games/gran-turismo-sport/banner.jpg'),
    ('gran-turismo-sport', 3, 'imagem', '/games/gran-turismo-sport/screenshot-1.jpg'),
    ('gran-turismo-sport', 4, 'imagem', '/games/gran-turismo-sport/screenshot-2.jpg'),
    ('horizon-zero-dawn', 1, 'trailer', 'https://www.youtube.com/watch?v=wzx96gYA8ek'),
    ('horizon-zero-dawn', 2, 'imagem', '/games/horizon-zero-dawn/banner.jpg'),
    ('horizon-zero-dawn', 3, 'imagem', '/games/horizon-zero-dawn/screenshot-1.jpg'),
    ('horizon-zero-dawn', 4, 'imagem', '/games/horizon-zero-dawn/screenshot-2.jpg'),
    ('horizon-zero-dawn', 5, 'imagem', '/games/horizon-zero-dawn/screenshot-3.jpg'),
    ('horizon-forbidden-west', 1, 'trailer', 'https://www.youtube.com/watch?v=UxDWGW7Z67I'),
    ('horizon-forbidden-west', 2, 'imagem', '/games/horizon-forbidden-west/banner.jpg'),
    ('horizon-forbidden-west', 3, 'imagem', '/games/horizon-forbidden-west/screenshot-1.jpg'),
    ('horizon-forbidden-west', 4, 'imagem', '/games/horizon-forbidden-west/screenshot-2.jpg'),
    ('horizon-forbidden-west', 5, 'imagem', '/games/horizon-forbidden-west/screenshot-3.jpg'),
    ('ghost-of-tsushima', 1, 'trailer', 'https://www.youtube.com/watch?v=RcWk08PBe7k'),
    ('ghost-of-tsushima', 2, 'imagem', '/games/ghost-of-tsushima/banner.jpg'),
    ('ghost-of-tsushima', 3, 'imagem', '/games/ghost-of-tsushima/screenshot-1.jpg'),
    ('ghost-of-tsushima', 4, 'imagem', '/games/ghost-of-tsushima/screenshot-2.jpg'),
    ('ghost-of-tsushima', 5, 'imagem', '/games/ghost-of-tsushima/screenshot-3.jpg'),
    ('ghost-of-yotei', 1, 'trailer', 'https://www.youtube.com/watch?v=sLcksHR30UA'),
    ('ghost-of-yotei', 2, 'imagem', '/games/ghost-of-yotei/banner.jpg'),
    ('ghost-of-yotei', 3, 'imagem', '/games/ghost-of-yotei/screenshot-1.jpg'),
    ('ghost-of-yotei', 4, 'imagem', '/games/ghost-of-yotei/screenshot-2.jpg'),
    ('alan-wake-2', 1, 'trailer', 'https://www.youtube.com/watch?v=dlQ3FeNu5Yw'),
    ('alan-wake-2', 2, 'imagem', '/games/alan-wake-2/banner.jpg'),
    ('alan-wake-2', 3, 'imagem', '/games/alan-wake-2/screenshot-1.jpg'),
    ('alan-wake-2', 4, 'imagem', '/games/alan-wake-2/screenshot-2.jpg'),
    ('alan-wake-2', 5, 'imagem', '/games/alan-wake-2/screenshot-3.jpg'),
    ('control', 1, 'trailer', 'https://www.youtube.com/watch?v=PT5yMfC9LQM'),
    ('control', 2, 'imagem', '/games/control/banner.jpg'),
    ('control', 3, 'imagem', '/games/control/screenshot-1.jpg'),
    ('control', 4, 'imagem', '/games/control/screenshot-2.jpg'),
    ('control', 5, 'imagem', '/games/control/screenshot-3.jpg'),
    ('alan-wake-remastered', 1, 'trailer', 'https://www.youtube.com/watch?v=V7_LKrMheAU'),
    ('alan-wake-remastered', 2, 'imagem', '/games/alan-wake-remastered/banner.jpg'),
    ('alan-wake-remastered', 3, 'imagem', '/games/alan-wake-remastered/screenshot-1.jpg'),
    ('alan-wake-remastered', 4, 'imagem', '/games/alan-wake-remastered/screenshot-2.jpg'),
    ('alan-wake-remastered', 5, 'imagem', '/games/alan-wake-remastered/screenshot-3.jpg'),
    ('jedi-fallen-order', 1, 'trailer', 'https://www.youtube.com/watch?v=xIl2z5wwjdA'),
    ('jedi-fallen-order', 2, 'imagem', '/games/jedi-fallen-order/banner.jpg'),
    ('jedi-fallen-order', 3, 'imagem', '/games/jedi-fallen-order/screenshot-1.jpg'),
    ('jedi-fallen-order', 4, 'imagem', '/games/jedi-fallen-order/screenshot-2.jpg'),
    ('jedi-fallen-order', 5, 'imagem', '/games/jedi-fallen-order/screenshot-3.jpg'),
    ('jedi-survivor', 1, 'trailer', 'https://www.youtube.com/watch?v=bmj3ty-Wt48'),
    ('jedi-survivor', 2, 'imagem', '/games/jedi-survivor/banner.jpg'),
    ('jedi-survivor', 3, 'imagem', '/games/jedi-survivor/screenshot-1.jpg'),
    ('jedi-survivor', 4, 'imagem', '/games/jedi-survivor/screenshot-2.jpg'),
    ('jedi-survivor', 5, 'imagem', '/games/jedi-survivor/screenshot-3.jpg'),
    ('assassins-creed-black-flag', 1, 'trailer', 'https://www.youtube.com/watch?v=ZjkU1p18uIc'),
    ('assassins-creed-black-flag', 2, 'imagem', '/games/assassins-creed-black-flag/banner.jpg'),
    ('assassins-creed-black-flag', 3, 'imagem', '/games/assassins-creed-black-flag/screenshot-1.jpg'),
    ('assassins-creed-black-flag', 4, 'imagem', '/games/assassins-creed-black-flag/screenshot-2.jpg'),
    ('assassins-creed-black-flag', 5, 'imagem', '/games/assassins-creed-black-flag/screenshot-3.jpg'),
    ('assassins-creed-origins', 1, 'trailer', 'https://www.youtube.com/watch?v=-1gZLmI9e5w'),
    ('assassins-creed-origins', 2, 'imagem', '/games/assassins-creed-origins/banner.jpg'),
    ('assassins-creed-origins', 3, 'imagem', '/games/assassins-creed-origins/screenshot-1.jpg'),
    ('assassins-creed-origins', 4, 'imagem', '/games/assassins-creed-origins/screenshot-2.jpg'),
    ('assassins-creed-origins', 5, 'imagem', '/games/assassins-creed-origins/screenshot-3.jpg'),
    ('assassins-creed-odyssey', 1, 'trailer', 'https://www.youtube.com/watch?v=so2SeY_UaeM'),
    ('assassins-creed-odyssey', 2, 'imagem', '/games/assassins-creed-odyssey/banner.jpg'),
    ('assassins-creed-odyssey', 3, 'imagem', '/games/assassins-creed-odyssey/screenshot-1.jpg'),
    ('assassins-creed-odyssey', 4, 'imagem', '/games/assassins-creed-odyssey/screenshot-2.jpg'),
    ('assassins-creed-odyssey', 5, 'imagem', '/games/assassins-creed-odyssey/screenshot-3.jpg'),
    ('prince-of-persia-lost-crown', 1, 'trailer', 'https://www.youtube.com/watch?v=n4vaxKwZ5rQ'),
    ('prince-of-persia-lost-crown', 2, 'imagem', '/games/prince-of-persia-lost-crown/banner.jpg'),
    ('prince-of-persia-lost-crown', 3, 'imagem', '/games/prince-of-persia-lost-crown/screenshot-1.jpg'),
    ('prince-of-persia-lost-crown', 4, 'imagem', '/games/prince-of-persia-lost-crown/screenshot-2.jpg'),
    ('prince-of-persia-lost-crown', 5, 'imagem', '/games/prince-of-persia-lost-crown/screenshot-3.jpg'),
    ('rayman-legends', 1, 'trailer', 'https://www.youtube.com/watch?v=yMIKs1PKrEM'),
    ('rayman-legends', 2, 'imagem', '/games/rayman-legends/banner.jpg'),
    ('rayman-legends', 3, 'imagem', '/games/rayman-legends/screenshot-1.jpg'),
    ('rayman-legends', 4, 'imagem', '/games/rayman-legends/screenshot-2.jpg'),
    ('rayman-legends', 5, 'imagem', '/games/rayman-legends/screenshot-3.jpg'),
    ('beyond-good-and-evil-20th', 1, 'trailer', 'https://www.youtube.com/watch?v=CaU4tMuvvdc'),
    ('beyond-good-and-evil-20th', 2, 'imagem', '/games/beyond-good-and-evil-20th/banner.jpg'),
    ('beyond-good-and-evil-20th', 3, 'imagem', '/games/beyond-good-and-evil-20th/screenshot-1.jpg'),
    ('beyond-good-and-evil-20th', 4, 'imagem', '/games/beyond-good-and-evil-20th/screenshot-2.jpg'),
    ('beyond-good-and-evil-20th', 5, 'imagem', '/games/beyond-good-and-evil-20th/screenshot-3.jpg'),
    ('minecraft', 1, 'trailer', 'https://www.youtube.com/watch?v=MmB9b5njVbA'),
    ('minecraft', 2, 'imagem', '/games/minecraft/banner.jpg'),
    ('minecraft', 3, 'imagem', '/games/minecraft/screenshot-1.jpg'),
    ('minecraft', 4, 'imagem', '/games/minecraft/screenshot-2.jpg'),
    ('minecraft', 5, 'imagem', '/games/minecraft/screenshot-3.jpg'),
    ('black-myth-wukong', 1, 'trailer', 'https://www.youtube.com/watch?v=pnSsgRJmsCc'),
    ('black-myth-wukong', 2, 'imagem', '/games/black-myth-wukong/banner.jpg'),
    ('black-myth-wukong', 3, 'imagem', '/games/black-myth-wukong/screenshot-1.jpg'),
    ('black-myth-wukong', 4, 'imagem', '/games/black-myth-wukong/screenshot-2.jpg'),
    ('black-myth-wukong', 5, 'imagem', '/games/black-myth-wukong/screenshot-3.jpg'),
    ('no-mans-sky', 1, 'trailer', 'https://www.youtube.com/watch?v=aozqa_7PLhE'),
    ('no-mans-sky', 2, 'imagem', '/games/no-mans-sky/banner.jpg'),
    ('no-mans-sky', 3, 'imagem', '/games/no-mans-sky/screenshot-1.jpg'),
    ('no-mans-sky', 4, 'imagem', '/games/no-mans-sky/screenshot-2.jpg'),
    ('no-mans-sky', 5, 'imagem', '/games/no-mans-sky/screenshot-3.jpg'),
    ('stardew-valley', 1, 'trailer', 'https://www.youtube.com/watch?v=ot7uXNQskhs'),
    ('stardew-valley', 2, 'imagem', '/games/stardew-valley/banner.jpg'),
    ('stardew-valley', 3, 'imagem', '/games/stardew-valley/screenshot-1.jpg'),
    ('stardew-valley', 4, 'imagem', '/games/stardew-valley/screenshot-2.jpg'),
    ('stardew-valley', 5, 'imagem', '/games/stardew-valley/screenshot-3.jpg'),
    ('hollow-knight', 1, 'trailer', 'https://www.youtube.com/watch?v=UAO2urG23S4'),
    ('hollow-knight', 2, 'imagem', '/games/hollow-knight/banner.jpg'),
    ('hollow-knight', 3, 'imagem', '/games/hollow-knight/screenshot-1.jpg'),
    ('hollow-knight', 4, 'imagem', '/games/hollow-knight/screenshot-2.jpg'),
    ('hollow-knight', 5, 'imagem', '/games/hollow-knight/screenshot-3.jpg'),
    ('hollow-knight-silksong', 1, 'trailer', 'https://www.youtube.com/watch?v=6XGeJwsUP9c'),
    ('hollow-knight-silksong', 2, 'imagem', '/games/hollow-knight-silksong/banner.jpg'),
    ('hollow-knight-silksong', 3, 'imagem', '/games/hollow-knight-silksong/screenshot-1.jpg'),
    ('hollow-knight-silksong', 4, 'imagem', '/games/hollow-knight-silksong/screenshot-2.jpg'),
    ('hollow-knight-silksong', 5, 'imagem', '/games/hollow-knight-silksong/screenshot-3.jpg'),
    ('cyberpunk-2077', 1, 'trailer', 'https://www.youtube.com/watch?v=UnA7tepsc7s'),
    ('cyberpunk-2077', 2, 'imagem', '/games/cyberpunk-2077/banner.jpg'),
    ('cyberpunk-2077', 3, 'imagem', '/games/cyberpunk-2077/screenshot-1.jpg'),
    ('cyberpunk-2077', 4, 'imagem', '/games/cyberpunk-2077/screenshot-2.jpg'),
    ('cyberpunk-2077', 5, 'imagem', '/games/cyberpunk-2077/screenshot-3.jpg'),
    ('the-witcher-3', 1, 'trailer', 'https://www.youtube.com/watch?v=1-l29HlKkXU'),
    ('the-witcher-3', 2, 'imagem', '/games/the-witcher-3/banner.jpg'),
    ('the-witcher-3', 3, 'imagem', '/games/the-witcher-3/screenshot-1.jpg'),
    ('the-witcher-3', 4, 'imagem', '/games/the-witcher-3/screenshot-2.jpg'),
    ('the-witcher-3', 5, 'imagem', '/games/the-witcher-3/screenshot-3.jpg'),
    ('final-fantasy-vii-remake-intergrade', 1, 'trailer', 'https://www.youtube.com/watch?v=Ge73iBqc7o8'),
    ('final-fantasy-vii-remake-intergrade', 2, 'imagem', '/games/final-fantasy-vii-remake-intergrade/banner.jpg'),
    ('final-fantasy-vii-remake-intergrade', 3, 'imagem', '/games/final-fantasy-vii-remake-intergrade/screenshot-1.jpg'),
    ('final-fantasy-vii-remake-intergrade', 4, 'imagem', '/games/final-fantasy-vii-remake-intergrade/screenshot-2.jpg'),
    ('final-fantasy-vii-remake-intergrade', 5, 'imagem', '/games/final-fantasy-vii-remake-intergrade/screenshot-3.jpg'),
    ('final-fantasy-vii-rebirth', 1, 'trailer', 'https://www.youtube.com/watch?v=Q56cRDseTGQ'),
    ('final-fantasy-vii-rebirth', 2, 'imagem', '/games/final-fantasy-vii-rebirth/banner.jpg'),
    ('final-fantasy-vii-rebirth', 3, 'imagem', '/games/final-fantasy-vii-rebirth/screenshot-1.jpg'),
    ('final-fantasy-vii-rebirth', 4, 'imagem', '/games/final-fantasy-vii-rebirth/screenshot-2.jpg'),
    ('final-fantasy-vii-rebirth', 5, 'imagem', '/games/final-fantasy-vii-rebirth/screenshot-3.jpg'),
    ('final-fantasy-xvi', 1, 'trailer', 'https://www.youtube.com/watch?v=iaJ4VVFGIa8'),
    ('final-fantasy-xvi', 2, 'imagem', '/games/final-fantasy-xvi/banner.jpg'),
    ('final-fantasy-xvi', 3, 'imagem', '/games/final-fantasy-xvi/screenshot-1.jpg'),
    ('final-fantasy-xvi', 4, 'imagem', '/games/final-fantasy-xvi/screenshot-2.jpg'),
    ('final-fantasy-xvi', 5, 'imagem', '/games/final-fantasy-xvi/screenshot-3.jpg'),
    ('dragon-quest-xi-s', 1, 'trailer', 'https://www.youtube.com/watch?v=9OnuPM4XDLQ'),
    ('dragon-quest-xi-s', 2, 'imagem', '/games/dragon-quest-xi-s/banner.jpg'),
    ('dragon-quest-xi-s', 3, 'imagem', '/games/dragon-quest-xi-s/screenshot-1.jpg'),
    ('dragon-quest-xi-s', 4, 'imagem', '/games/dragon-quest-xi-s/screenshot-2.jpg'),
    ('dragon-quest-xi-s', 5, 'imagem', '/games/dragon-quest-xi-s/screenshot-3.jpg'),
    ('dragon-quest-builders-2', 1, 'trailer', 'https://www.youtube.com/watch?v=0q65qT-X8RA'),
    ('dragon-quest-builders-2', 2, 'imagem', '/games/dragon-quest-builders-2/banner.jpg'),
    ('dragon-quest-builders-2', 3, 'imagem', '/games/dragon-quest-builders-2/screenshot-1.jpg'),
    ('dragon-quest-builders-2', 4, 'imagem', '/games/dragon-quest-builders-2/screenshot-2.jpg'),
    ('dragon-quest-builders-2', 5, 'imagem', '/games/dragon-quest-builders-2/screenshot-3.jpg'),
    ('the-last-guardian', 1, 'trailer', 'https://www.youtube.com/watch?v=4cDuKShhQOA'),
    ('the-last-guardian', 2, 'imagem', '/games/the-last-guardian/banner.jpg'),
    ('the-last-guardian', 3, 'imagem', '/games/the-last-guardian/screenshot-1.jpg'),
    ('the-last-guardian', 4, 'imagem', '/games/the-last-guardian/screenshot-2.jpg'),
    ('the-last-guardian', 5, 'imagem', '/games/the-last-guardian/screenshot-3.jpg'),
    ('shadow-of-the-colossus', 1, 'trailer', 'https://www.youtube.com/watch?v=OYmUgbVLs4k'),
    ('shadow-of-the-colossus', 2, 'imagem', '/games/shadow-of-the-colossus/banner.jpg'),
    ('shadow-of-the-colossus', 3, 'imagem', '/games/shadow-of-the-colossus/screenshot-1.jpg'),
    ('shadow-of-the-colossus', 4, 'imagem', '/games/shadow-of-the-colossus/screenshot-2.jpg'),
    ('shadow-of-the-colossus', 5, 'imagem', '/games/shadow-of-the-colossus/screenshot-3.jpg'),
    ('forza-horizon-5', 1, 'trailer', 'https://www.youtube.com/watch?v=Rv7xLt5yNsM'),
    ('forza-horizon-5', 2, 'imagem', '/games/forza-horizon-5/banner.jpg'),
    ('forza-horizon-5', 3, 'imagem', '/games/forza-horizon-5/screenshot-1.jpg'),
    ('forza-horizon-5', 4, 'imagem', '/games/forza-horizon-5/screenshot-2.jpg'),
    ('forza-horizon-5', 5, 'imagem', '/games/forza-horizon-5/screenshot-3.jpg'),
    ('forza-horizon-4', 1, 'trailer', 'https://www.youtube.com/watch?v=ipbxICJ3RT4'),
    ('forza-horizon-4', 2, 'imagem', '/games/forza-horizon-4/banner.jpg'),
    ('forza-horizon-4', 3, 'imagem', '/games/forza-horizon-4/screenshot-1.jpg'),
    ('forza-horizon-4', 4, 'imagem', '/games/forza-horizon-4/screenshot-2.jpg'),
    ('forza-horizon-4', 5, 'imagem', '/games/forza-horizon-4/screenshot-3.jpg')
) AS v(slug, ordem, tipo, url)
JOIN produto pr ON pr.slug = v.slug;

-- ---------------------------------------------------------------------
-- Consoles (Produto -> Console)
-- ---------------------------------------------------------------------
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('PlayStation 5', 'playstation-5') RETURNING id)
INSERT INTO console (id, fabricante, tipo, geracao, imagem, preco, desconto, plataforma_id)
SELECT p.id, 'Sony', 'Mesa', '9ª geração', 'https://images.unsplash.com/photo-1606813907291-d86efa9b94db?w=600', 3499.90, NULL,
       (SELECT id FROM plataforma WHERE nome = 'PlayStation 5')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Xbox Series X', 'xbox-series-x') RETURNING id)
INSERT INTO console (id, fabricante, tipo, geracao, imagem, preco, desconto, plataforma_id)
SELECT p.id, 'Microsoft', 'Mesa', '9ª geração', 'https://images.unsplash.com/photo-1621259182978-fbf93132d53d?w=600', 3999.90, NULL,
       (SELECT id FROM plataforma WHERE nome = 'Xbox Series')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Nintendo Switch OLED', 'nintendo-switch-oled') RETURNING id)
INSERT INTO console (id, fabricante, tipo, geracao, imagem, preco, desconto, plataforma_id)
SELECT p.id, 'Nintendo', 'Híbrido', '9ª geração', 'https://images.unsplash.com/photo-1578303512597-81e6cc155b3e?w=600', 1999.90, NULL,
       (SELECT id FROM plataforma WHERE nome = 'Nintendo Switch')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('PlayStation 4', 'playstation-4') RETURNING id)
INSERT INTO console (id, fabricante, tipo, geracao, imagem, preco, desconto, plataforma_id)
SELECT p.id, 'Sony', 'Mesa', '8ª geração', 'https://images.unsplash.com/photo-1486401899868-0e435ed85128?w=600', 1799.90, NULL,
       (SELECT id FROM plataforma WHERE nome = 'PlayStation 4')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Xbox Series S', 'xbox-series-s') RETURNING id)
INSERT INTO console (id, fabricante, tipo, geracao, imagem, preco, desconto, plataforma_id)
SELECT p.id, 'Microsoft', 'Mesa', '9ª geração', 'https://images.unsplash.com/photo-1621259182978-fbf93132d53d?w=600', 2499.90, NULL,
       (SELECT id FROM plataforma WHERE nome = 'Xbox Series')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Nintendo Switch Lite', 'nintendo-switch-lite') RETURNING id)
INSERT INTO console (id, fabricante, tipo, geracao, imagem, preco, desconto, plataforma_id)
SELECT p.id, 'Nintendo', 'Portátil', '9ª geração', 'https://images.unsplash.com/photo-1578303512597-81e6cc155b3e?w=600', 1299.90, NULL,
       (SELECT id FROM plataforma WHERE nome = 'Nintendo Switch')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Xbox One', 'xbox-one') RETURNING id)
INSERT INTO console (id, fabricante, tipo, geracao, imagem, preco, desconto, plataforma_id)
SELECT p.id, 'Microsoft', 'Mesa', '8ª geração', 'https://images.unsplash.com/photo-1621259182978-fbf93132d53d?w=600', 1299.90, NULL,
       (SELECT id FROM plataforma WHERE nome = 'Xbox One')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('PlayStation 5 Digital Edition', 'playstation-5-digital-edition') RETURNING id)
INSERT INTO console (id, fabricante, tipo, geracao, imagem, preco, desconto, plataforma_id)
SELECT p.id, 'Sony', 'Mesa', '9ª geração', 'https://images.unsplash.com/photo-1606813907291-d86efa9b94db?w=600', 3299.90, NULL,
       (SELECT id FROM plataforma WHERE nome = 'PlayStation 5')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Nintendo Switch', 'nintendo-switch') RETURNING id)
INSERT INTO console (id, fabricante, tipo, geracao, imagem, preco, desconto, plataforma_id)
SELECT p.id, 'Nintendo', 'Híbrido', '9ª geração', 'https://images.unsplash.com/photo-1578303512597-81e6cc155b3e?w=600', 1799.90, NULL,
       (SELECT id FROM plataforma WHERE nome = 'Nintendo Switch')
FROM p;
WITH p AS (INSERT INTO produto (nome, slug) VALUES ('Steam Deck', 'steam-deck') RETURNING id)
INSERT INTO console (id, fabricante, tipo, geracao, imagem, preco, desconto, plataforma_id)
SELECT p.id, 'Valve', 'Portátil', 'PC portátil', 'https://images.unsplash.com/photo-1606144042614-b2417e99c4e3?w=600', 3499.90, NULL,
       (SELECT id FROM plataforma WHERE nome = 'PC')
FROM p;

-- ---------------------------------------------------------------------
-- Depoimentos (curados pela loja)
-- ---------------------------------------------------------------------
INSERT INTO depoimento (nome, compra, nota, mensagem, foto) VALUES
    ('Shadow', 'Comprou Computador', 5, 'Não costumo recomendar nada. Mas o desempenho desse setup é aceitável. Considere isso um elogio.', '/img/fotos/Shadow.jpg'),
    ('Mario', 'Comprou Monitor 4k', 5, 'Mamma mia! Comprei meu novo monitor e agora consigo salvar a Princesa Peach em 4K! Finalmente, um power-up que vale a pena!', '/img/fotos/Mario 1.jpg'),
    ('Sonic', 'Comprou SSD NVMe', 5, 'Sempre achei que eu era a coisa mais rápida, mas esse SSD NVMe quase me deixou pra trás. Entrega relâmpago!', '/img/fotos/Sonic.jpg'),
    ('Luigi', 'Comprou Fone Gamer Sem Fio', 5, 'Comprei pra ver se não ouço os fantasmas da mansão. Abafa o som que é uma beleza!', '/img/fotos/Luigi.jpg'),
    ('Michael', 'Comprou SSD Nvme', 5, 'Agora que os arquivos abrem instantaneamente, consigo terminar meu trabalho em 5 minutos e passar o resto do dia ignorando o Toby.', '/img/fotos/MichaelScott.png'),
    ('Creed', 'Comprou Xbox Series X', 5, 'Comprei um Xbox. Paguei? Não lembro. O importante é que funciona.', '/img/fotos/CreedBratton.jpg');

-- ---------------------------------------------------------------------
-- Contatos de exemplo (formulário do rodapé)
-- ---------------------------------------------------------------------
INSERT INTO contato (nome, comentario, data_envio, status) VALUES
    ('Paula Ribeiro', 'Vocês têm previsão de chegada do Switch 2?', '2026-11-10 14:32', 'respondida'),
    ('Rafael Costa', 'O Elden Ring de PS5 vem com a DLC?', '2026-11-18 09:05', 'pendente'),
    ('Juliana Alves', 'Fazem entrega para João Monlevade?', '2026-11-21 19:47', 'pendente');

-- ---------------------------------------------------------------------
-- Clientes de teste (CPFs fictícios; senha de todos: mayk1234)
-- ---------------------------------------------------------------------
INSERT INTO cliente (nome, email, cpf, senha_hash, data_cadastro) VALUES
    ('Ana Souza', 'ana.souza@exemplo.com', '13579246828', '89bd6bbea7172208bfd5273826d01c43:7637b5c11e7b234e46488d200ef3482fb34cde2862710a17561bcd216d8dfa5145bc4022b7e01c5edad66ef98881aa78b67b40027390003a18d9f8846dffc7c1', '2026-09-02'),
    ('Bruno Lima', 'bruno.lima@exemplo.com', '24681357928', '4efc8586284a67775b7797fd53684b49:a6df8060147e063ddbf489c1877a1b32e7bd35f0de2a3a2849381ca56922082ab6e7b2862ffe313847bb54022ac741d8b7cd16ff4c38181a694b757768fabf6d', '2026-09-15'),
    ('Carla Mendes', 'carla.mendes@exemplo.com', '31415926590', 'b3475f4d494f2cd072bbcabd53117573:96d80cca06cd02bbd2e581c39d60bd2ef4099fa6868935e7aa5b718aedaafb089fcda50d34dd33e7c7b6db217eab92bffca3f34882d355613b783aa6e30bb406', '2026-10-01'),
    ('Diego Rocha', 'diego.rocha@exemplo.com', '27182818205', '0007aa3c0809f49fa4e05959bbdb2780:a93f086e615181500db1b67398ea0200a6a65e0e55a679c86a310216674b7585be1398b4cf9a470b07f05fb20534fcb0575406f46a57af69d3dd214f5a4c764b', '2026-10-20'),
    ('Elisa Martins', 'elisa.martins@exemplo.com', '16180339805', '69bec3d7fded754bd78ef14dcb7e1ef9:41c382122f7dc5c468a9caadaca4c0718cafa6b050519efda07110d51e6cfe6b746f7eea99bba0f1e5bb38f0cde3bfd9cbff03967b699329034c8fb17247f82d', '2026-11-12');

-- ---------------------------------------------------------------------
-- Pedidos de exemplo (Cliente Realiza Pedido). O total vem da view vw_pedido_total.
-- ---------------------------------------------------------------------
-- pedido 1: ana.souza@exemplo.com (entregue)
WITH ped AS (
    INSERT INTO pedido (data_pedido, status, cliente_id)
    SELECT '2026-09-05 10:12', 'entregue', id FROM cliente WHERE email = 'ana.souza@exemplo.com'
    RETURNING id)
INSERT INTO item_pedido (pedido_id, produto_id, plataforma_id, quantidade, valor_unitario)
SELECT ped.id, pr.id, pl.id, v.qtd, v.valor
FROM ped, (VALUES
    ('elden-ring', 'PC', 1, 192.15),
    ('dark-souls-iii', 'PC', 1, 57.48)
) AS v(slug, plataforma, qtd, valor)
JOIN produto pr ON pr.slug = v.slug
LEFT JOIN plataforma pl ON pl.nome = v.plataforma;
-- pedido 2: ana.souza@exemplo.com (pendente)
WITH ped AS (
    INSERT INTO pedido (data_pedido, status, cliente_id)
    SELECT '2026-11-15 21:40', 'pendente', id FROM cliente WHERE email = 'ana.souza@exemplo.com'
    RETURNING id)
INSERT INTO item_pedido (pedido_id, produto_id, plataforma_id, quantidade, valor_unitario)
SELECT ped.id, pr.id, pl.id, v.qtd, v.valor
FROM ped, (VALUES
    ('playstation-5', NULL, 1, 3499.90)
) AS v(slug, plataforma, qtd, valor)
JOIN produto pr ON pr.slug = v.slug
LEFT JOIN plataforma pl ON pl.nome = v.plataforma;
-- pedido 3: bruno.lima@exemplo.com (entregue)
WITH ped AS (
    INSERT INTO pedido (data_pedido, status, cliente_id)
    SELECT '2026-09-20 16:03', 'entregue', id FROM cliente WHERE email = 'bruno.lima@exemplo.com'
    RETURNING id)
INSERT INTO item_pedido (pedido_id, produto_id, plataforma_id, quantidade, valor_unitario)
SELECT ped.id, pr.id, pl.id, v.qtd, v.valor
FROM ped, (VALUES
    ('nintendo-switch-oled', NULL, 1, 1999.90),
    ('zelda-tears-of-the-kingdom', 'Nintendo Switch', 1, 399.00),
    ('mario-kart-8-deluxe', 'Nintendo Switch', 2, 87.25)
) AS v(slug, plataforma, qtd, valor)
JOIN produto pr ON pr.slug = v.slug
LEFT JOIN plataforma pl ON pl.nome = v.plataforma;
-- pedido 4: carla.mendes@exemplo.com (confirmado)
WITH ped AS (
    INSERT INTO pedido (data_pedido, status, cliente_id)
    SELECT '2026-10-03 08:55', 'confirmado', id FROM cliente WHERE email = 'carla.mendes@exemplo.com'
    RETURNING id)
INSERT INTO item_pedido (pedido_id, produto_id, plataforma_id, quantidade, valor_unitario)
SELECT ped.id, pr.id, pl.id, v.qtd, v.valor
FROM ped, (VALUES
    ('elden-ring', 'PlayStation 5', 1, 299.90),
    ('bloodborne', 'PlayStation 4', 1, 114.90)
) AS v(slug, plataforma, qtd, valor)
JOIN produto pr ON pr.slug = v.slug
LEFT JOIN plataforma pl ON pl.nome = v.plataforma;
-- pedido 5: carla.mendes@exemplo.com (cancelado)
WITH ped AS (
    INSERT INTO pedido (data_pedido, status, cliente_id)
    SELECT '2026-10-28 13:20', 'cancelado', id FROM cliente WHERE email = 'carla.mendes@exemplo.com'
    RETURNING id)
INSERT INTO item_pedido (pedido_id, produto_id, plataforma_id, quantidade, valor_unitario)
SELECT ped.id, pr.id, pl.id, v.qtd, v.valor
FROM ped, (VALUES
    ('hades', 'PC', 1, 73.99)
) AS v(slug, plataforma, qtd, valor)
JOIN produto pr ON pr.slug = v.slug
LEFT JOIN plataforma pl ON pl.nome = v.plataforma;
-- pedido 6: diego.rocha@exemplo.com (entregue)
WITH ped AS (
    INSERT INTO pedido (data_pedido, status, cliente_id)
    SELECT '2026-10-22 19:30', 'entregue', id FROM cliente WHERE email = 'diego.rocha@exemplo.com'
    RETURNING id)
INSERT INTO item_pedido (pedido_id, produto_id, plataforma_id, quantidade, valor_unitario)
SELECT ped.id, pr.id, pl.id, v.qtd, v.valor
FROM ped, (VALUES
    ('hollow-knight', 'PC', 1, 23.50),
    ('stardew-valley', 'PC', 1, 10.00),
    ('hades', 'PC', 1, 73.99)
) AS v(slug, plataforma, qtd, valor)
JOIN produto pr ON pr.slug = v.slug
LEFT JOIN plataforma pl ON pl.nome = v.plataforma;

-- ---------------------------------------------------------------------
-- Avaliações (Cliente Escreve, Jogo Recebe)
-- ---------------------------------------------------------------------
INSERT INTO avaliacao (nota, comentario, data_avaliacao, cliente_id, jogo_id)
SELECT v.nota, v.comentario, v.data::timestamp, c.id, pr.id
FROM (VALUES
    ('ana.souza@exemplo.com', 'elden-ring', 5, 'Mundo enorme e cheio de segredos. Melhor jogo que joguei no ano.', '2026-09-20 22:10'),
    ('ana.souza@exemplo.com', 'dark-souls-iii', 4, 'Difícil na medida certa, chefes incríveis.', '2026-10-02 18:45'),
    ('bruno.lima@exemplo.com', 'zelda-tears-of-the-kingdom', 5, 'A liberdade de construir qualquer coisa é absurda.', '2026-10-05 11:30'),
    ('bruno.lima@exemplo.com', 'mario-kart-8-deluxe', 4, 'Ótimo para jogar com a família no fim de semana.', '2026-10-06 20:00'),
    ('carla.mendes@exemplo.com', 'elden-ring', 4, 'Lindo no PS5, mas apanhei muito no começo.', '2026-10-15 23:05'),
    ('carla.mendes@exemplo.com', 'bloodborne', 5, 'Atmosfera gótica perfeita. Clássico.', '2026-10-18 21:15'),
    ('diego.rocha@exemplo.com', 'hollow-knight', 5, 'Arte linda e exploração muito bem feita.', '2026-11-01 17:40'),
    ('diego.rocha@exemplo.com', 'hades', 5, 'Cada tentativa é diferente. Viciante.', '2026-11-03 09:25')
) AS v(email, slug, nota, comentario, data)
JOIN cliente c  ON c.email = v.email
JOIN produto pr ON pr.slug = v.slug;

COMMIT;
