// Gera database/seed.sql a partir dos dados fixos do front (src/data/*.ts).
// Uso: node --experimental-strip-types gerar-seed.mjs <pasta src/data> <saida.sql>
import { scryptSync, createHash } from 'node:crypto';
import { writeFileSync } from 'node:fs';
import { resolve } from 'node:path';
import { pathToFileURL } from 'node:url';

const [, , dataDir, saida] = process.argv;
// file:// URL porque no Windows o import() não aceita caminho absoluto (C:\...)
const imp = (f) => import(pathToFileURL(resolve(dataDir, f)).href);
const { platforms } = await imp('platforms.ts');
const { studios } = await imp('studios.ts');
const { publishers } = await imp('publishers.ts');
const { directors } = await imp('directors.ts');
const { games } = await imp('games.ts');
const { offers } = await imp('offers.ts');
const { consoles } = await imp('consoles.ts');

// ---------- utilidades ----------
const q = (v) => (v === null || v === undefined ? 'NULL' : `'${String(v).replace(/'/g, "''")}'`);
const num = (v) => (v === null || v === undefined ? 'NULL' : Number(v).toFixed(2));
const desc = (d) => (d ? num(d) : 'NULL'); // 0% de desconto vira NULL (sem promoção)
const precoFinal = (preco, d) => Math.round(preco * (1 - (d || 0) / 100) * 100) / 100;
const out = [];
const w = (s = '') => out.push(s);
const titulo = (t) => { w(); w('-- ' + '-'.repeat(69)); w('-- ' + t); w('-- ' + '-'.repeat(69)); };
const plat = (slug) => platforms[slug].name;

// Melhor oferta (menor preço final) de cada par jogo + plataforma
const melhor = new Map();
for (const o of offers) {
  const k = `${o.game}|${o.platform}`;
  const atual = melhor.get(k);
  const fim = (x) => x.base_price * (1 - x.discount / 100);
  if (!atual || fim(o) < fim(atual)) melhor.set(k, o);
}

// ---------- cabeçalho ----------
w('-- =====================================================================');
w('-- Mayk Games — seed.sql');
w('-- Dados de exemplo. Rode DEPOIS do schema.sql, no banco da loja.');
w('-- Gerado a partir dos dados do front (src/data) por database/scripts/gerar-seed.mjs.');
w('-- As ligações usam subconsultas por nome/slug, então não dependem dos ids.');
w('-- =====================================================================');
w('BEGIN;');

// ---------- plataformas, estúdios, distribuidoras ----------
titulo('Plataformas');
w('INSERT INTO plataforma (nome) VALUES');
w(Object.values(platforms).map((p) => `    (${q(p.name)})`).join(',\n') + ';');

titulo('Estúdios');
w('INSERT INTO estudio (nome) VALUES');
w(Object.values(studios).map((s) => `    (${q(s.name)})`).join(',\n') + ';');

titulo('Distribuidoras');
w('INSERT INTO distribuidora (nome) VALUES');
w(Object.values(publishers).map((s) => `    (${q(s.name)})`).join(',\n') + ';');

// ---------- diretores ----------
titulo('Diretores (Estúdio Emprega Diretor)');
w('INSERT INTO diretor (nome, slug, foto, estudio_id)');
w('SELECT v.nome, v.slug, v.foto, e.id');
w('FROM (VALUES');
w(Object.values(directors).map((d) => `    (${q(d.name)}, ${q(d.slug)}, ${q(d.image)}, ${q(studios[d.studio].name)})`).join(',\n'));
w(') AS v(nome, slug, foto, estudio)');
w('JOIN estudio e ON e.nome = v.estudio;');

// ---------- jogos ----------
titulo('Jogos (Produto -> Jogo). Cada jogo cria a linha do pai e a do filho com o mesmo id.');
for (const g of Object.values(games)) {
  w(`WITH p AS (INSERT INTO produto (nome, slug) VALUES (${q(g.name)}, ${q(g.slug)}) RETURNING id)`);
  w('INSERT INTO jogo (id, descricao, diretor_id, distribuidora_id)');
  w(`SELECT p.id, ${q(g.description)},`);
  w(`       (SELECT id FROM diretor WHERE slug = ${q(g.director)}),`);
  w(`       (SELECT id FROM distribuidora WHERE nome = ${q(publishers[g.publisher].name)})`);
  w('FROM p;');
}

titulo('Jogo Disponível em Plataforma, com preço e desconto de cada par');
const jp = [];
for (const g of Object.values(games)) {
  for (const p of g.platforms) {
    const o = melhor.get(`${g.slug}|${p}`);
    jp.push(`    (${q(g.slug)}, ${q(plat(p))}, ${num(o.base_price / 100)}, ${desc(o.discount)})`);
  }
}
w('INSERT INTO jogo_plataforma (jogo_id, plataforma_id, preco, desconto)');
w('SELECT pr.id, pl.id, v.preco, v.desconto');
w('FROM (VALUES');
w(jp.join(',\n'));
w(') AS v(slug, plataforma, preco, desconto)');
w('JOIN produto pr    ON pr.slug = v.slug');
w('JOIN plataforma pl ON pl.nome = v.plataforma;');

titulo('Mídias (entidade fraca: jogo + ordem). Trailer do YouTube primeiro, depois imagens.');
const md = [];
for (const g of Object.values(games)) {
  g.media.forEach((url, i) => {
    const tipo = url.includes('youtube.com') ? 'trailer' : 'imagem';
    md.push(`    (${q(g.slug)}, ${i + 1}, ${q(tipo)}, ${q(url)})`);
  });
}
w('INSERT INTO midia (jogo_id, ordem, tipo, url)');
w('SELECT pr.id, v.ordem, v.tipo, v.url');
w('FROM (VALUES');
w(md.join(',\n'));
w(') AS v(slug, ordem, tipo, url)');
w('JOIN produto pr ON pr.slug = v.slug;');

// ---------- consoles ----------
titulo('Consoles (Produto -> Console)');
for (const c of consoles) {
  w(`WITH p AS (INSERT INTO produto (nome, slug) VALUES (${q(c.nome)}, ${q(c.slug)}) RETURNING id)`);
  w('INSERT INTO console (id, fabricante, tipo, geracao, imagem, preco, desconto, plataforma_id)');
  w(`SELECT p.id, ${q(c.fabricante)}, ${q(c.tipo)}, ${q(c.geracao)}, ${q(c.imagem)}, ${num(c.valor)}, NULL,`);
  w(`       (SELECT id FROM plataforma WHERE nome = ${q(plat(c.plataforma))})`);
  w('FROM p;');
}

// ---------- depoimentos (copiados de src/components/home/Depoimentos.tsx) ----------
titulo('Depoimentos (curados pela loja)');
const depoimentos = [
  ['Shadow', 'Comprou Computador', 'Não costumo recomendar nada. Mas o desempenho desse setup é aceitável. Considere isso um elogio.', '/img/fotos/Shadow.jpg'],
  ['Mario', 'Comprou Monitor 4k', 'Mamma mia! Comprei meu novo monitor e agora consigo salvar a Princesa Peach em 4K! Finalmente, um power-up que vale a pena!', '/img/fotos/Mario 1.jpg'],
  ['Sonic', 'Comprou SSD NVMe', 'Sempre achei que eu era a coisa mais rápida, mas esse SSD NVMe quase me deixou pra trás. Entrega relâmpago!', '/img/fotos/Sonic.jpg'],
  ['Luigi', 'Comprou Fone Gamer Sem Fio', 'Comprei pra ver se não ouço os fantasmas da mansão. Abafa o som que é uma beleza!', '/img/fotos/Luigi.jpg'],
  ['Michael', 'Comprou SSD Nvme', 'Agora que os arquivos abrem instantaneamente, consigo terminar meu trabalho em 5 minutos e passar o resto do dia ignorando o Toby.', '/img/fotos/MichaelScott.png'],
  ['Creed', 'Comprou Xbox Series X', 'Comprei um Xbox. Paguei? Não lembro. O importante é que funciona.', '/img/fotos/CreedBratton.jpg'],
];
w('INSERT INTO depoimento (nome, compra, nota, mensagem, foto) VALUES');
w(depoimentos.map(([n, c, m, f]) => `    (${q(n)}, ${q(c)}, 5, ${q(m)}, ${q(f)})`).join(',\n') + ';');

// ---------- contatos de exemplo ----------
titulo('Contatos de exemplo (formulário do rodapé)');
w('INSERT INTO contato (nome, comentario, data_envio, status) VALUES');
w([
  `    ('Paula Ribeiro', 'Vocês têm previsão de chegada do Switch 2?', '2026-11-10 14:32', 'respondida')`,
  `    ('Rafael Costa', 'O Elden Ring de PS5 vem com a DLC?', '2026-11-18 09:05', 'pendente')`,
  `    ('Juliana Alves', 'Fazem entrega para João Monlevade?', '2026-11-21 19:47', 'pendente')`,
].join(',\n') + ';');

// ---------- clientes de teste ----------
// CPFs fictícios com dígitos verificadores válidos. Senha de teste de todos: mayk1234
function cpf(base9) {
  const d = base9.split('').map(Number);
  const dv = (arr, peso) => { const r = (arr.reduce((s, n, i) => s + n * (peso - i), 0) * 10) % 11; return r === 10 ? 0 : r; };
  const d1 = dv(d, 10); const d2 = dv([...d, d1], 11);
  return base9 + d1 + d2;
}
function hash(senha, email) {
  const salt = createHash('md5').update(email).digest('hex'); // salt fixo só para o seed ser reproduzível
  return `${salt}:${scryptSync(senha, salt, 64).toString('hex')}`;
}
const clientes = [
  ['Ana Souza', 'ana.souza@exemplo.com', '135792468', '2026-09-02'],
  ['Bruno Lima', 'bruno.lima@exemplo.com', '246813579', '2026-09-15'],
  ['Carla Mendes', 'carla.mendes@exemplo.com', '314159265', '2026-10-01'],
  ['Diego Rocha', 'diego.rocha@exemplo.com', '271828182', '2026-10-20'],
  ['Elisa Martins', 'elisa.martins@exemplo.com', '161803398', '2026-11-12'],
];
titulo('Clientes de teste (CPFs fictícios; senha de todos: mayk1234)');
w('INSERT INTO cliente (nome, email, cpf, senha_hash, data_cadastro) VALUES');
w(clientes.map(([n, e, b, d]) => `    (${q(n)}, ${q(e)}, ${q(cpf(b))}, ${q(hash('mayk1234', e))}, ${q(d)})`).join(',\n') + ';');

// ---------- pedidos, itens e avaliações ----------
// item: [slug, slugPlataforma ou null (console), quantidade]
const precoJogo = (slug, p) => { const o = melhor.get(`${slug}|${p}`); if (!o) throw new Error(`sem oferta ${slug} ${p}`); return precoFinal(o.base_price / 100, o.discount); };
const precoConsole = (slug) => { const c = consoles.find((x) => x.slug === slug); if (!c) throw new Error('console ' + slug); return c.valor; };
const pedidos = [
  { cliente: 'ana.souza@exemplo.com', data: '2026-09-05 10:12', status: 'entregue', itens: [['elden-ring', 'pc', 1], ['dark-souls-iii', 'pc', 1]] },
  { cliente: 'ana.souza@exemplo.com', data: '2026-11-15 21:40', status: 'pendente', itens: [['playstation-5', null, 1]] },
  { cliente: 'bruno.lima@exemplo.com', data: '2026-09-20 16:03', status: 'entregue', itens: [['nintendo-switch-oled', null, 1], ['zelda-tears-of-the-kingdom', 'switch', 1], ['mario-kart-8-deluxe', 'switch', 2]] },
  { cliente: 'carla.mendes@exemplo.com', data: '2026-10-03 08:55', status: 'confirmado', itens: [['elden-ring', 'ps5', 1], ['bloodborne', 'ps4', 1]] },
  { cliente: 'carla.mendes@exemplo.com', data: '2026-10-28 13:20', status: 'cancelado', itens: [['hades', 'pc', 1]] },
  { cliente: 'diego.rocha@exemplo.com', data: '2026-10-22 19:30', status: 'entregue', itens: [['hollow-knight', 'pc', 1], ['stardew-valley', 'pc', 1], ['hades', 'pc', 1]] },
];
// Só avalia quem comprou (pedido confirmado/entregue); uma avaliação por cliente e jogo.
const avaliacoes = [
  ['ana.souza@exemplo.com', 'elden-ring', 5, 'Mundo enorme e cheio de segredos. Melhor jogo que joguei no ano.', '2026-09-20 22:10'],
  ['ana.souza@exemplo.com', 'dark-souls-iii', 4, 'Difícil na medida certa, chefes incríveis.', '2026-10-02 18:45'],
  ['bruno.lima@exemplo.com', 'zelda-tears-of-the-kingdom', 5, 'A liberdade de construir qualquer coisa é absurda.', '2026-10-05 11:30'],
  ['bruno.lima@exemplo.com', 'mario-kart-8-deluxe', 4, 'Ótimo para jogar com a família no fim de semana.', '2026-10-06 20:00'],
  ['carla.mendes@exemplo.com', 'elden-ring', 4, 'Lindo no PS5, mas apanhei muito no começo.', '2026-10-15 23:05'],
  ['carla.mendes@exemplo.com', 'bloodborne', 5, 'Atmosfera gótica perfeita. Clássico.', '2026-10-18 21:15'],
  ['diego.rocha@exemplo.com', 'hollow-knight', 5, 'Arte linda e exploração muito bem feita.', '2026-11-01 17:40'],
  ['diego.rocha@exemplo.com', 'hades', 5, 'Cada tentativa é diferente. Viciante.', '2026-11-03 09:25'],
];
// conferência da regra antes de gerar
for (const [email, jogo] of avaliacoes) {
  const ok = pedidos.some((p) => p.cliente === email && ['confirmado', 'entregue'].includes(p.status) && p.itens.some(([s]) => s === jogo));
  if (!ok) throw new Error(`avaliação sem compra: ${email} ${jogo}`);
}

titulo('Pedidos de exemplo (Cliente Realiza Pedido). O total vem da view vw_pedido_total.');
pedidos.forEach((p, i) => {
  w(`-- pedido ${i + 1}: ${p.cliente} (${p.status})`);
  w(`WITH ped AS (`);
  w(`    INSERT INTO pedido (data_pedido, status, cliente_id)`);
  w(`    SELECT ${q(p.data)}, ${q(p.status)}, id FROM cliente WHERE email = ${q(p.cliente)}`);
  w(`    RETURNING id)`);
  w('INSERT INTO item_pedido (pedido_id, produto_id, plataforma_id, quantidade, valor_unitario)');
  w('SELECT ped.id, pr.id, pl.id, v.qtd, v.valor');
  w('FROM ped, (VALUES');
  w(p.itens.map(([s, pf, qtd]) => {
    const valor = pf ? precoJogo(s, pf) : precoConsole(s);
    return `    (${q(s)}, ${pf ? q(plat(pf)) : 'NULL'}, ${qtd}, ${num(valor)})`;
  }).join(',\n'));
  w(') AS v(slug, plataforma, qtd, valor)');
  w('JOIN produto pr ON pr.slug = v.slug');
  w('LEFT JOIN plataforma pl ON pl.nome = v.plataforma;');
});

titulo('Avaliações (Cliente Escreve, Jogo Recebe)');
w('INSERT INTO avaliacao (nota, comentario, data_avaliacao, cliente_id, jogo_id)');
w('SELECT v.nota, v.comentario, v.data::timestamp, c.id, pr.id');
w('FROM (VALUES');
w(avaliacoes.map(([e, s, n, t, d]) => `    (${q(e)}, ${q(s)}, ${n}, ${q(t)}, ${q(d)})`).join(',\n'));
w(') AS v(email, slug, nota, comentario, data)');
w('JOIN cliente c  ON c.email = v.email');
w('JOIN produto pr ON pr.slug = v.slug;');

w();
w('COMMIT;');
writeFileSync(saida, out.join('\n') + '\n');
console.log('ok', saida, out.length, 'linhas');
