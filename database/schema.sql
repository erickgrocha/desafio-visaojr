

-- Mayk Games — schema.sql

DROP VIEW  IF EXISTS vw_pedido_total;
DROP TABLE IF EXISTS avaliacao       CASCADE;
DROP TABLE IF EXISTS item_pedido     CASCADE;
DROP TABLE IF EXISTS pedido          CASCADE;
DROP TABLE IF EXISTS midia           CASCADE;
DROP TABLE IF EXISTS jogo_plataforma CASCADE;
DROP TABLE IF EXISTS console         CASCADE;
DROP TABLE IF EXISTS jogo            CASCADE;
DROP TABLE IF EXISTS produto         CASCADE;
DROP TABLE IF EXISTS diretor         CASCADE;
DROP TABLE IF EXISTS estudio         CASCADE;
DROP TABLE IF EXISTS distribuidora   CASCADE;
DROP TABLE IF EXISTS plataforma      CASCADE;
DROP TABLE IF EXISTS cliente         CASCADE;
DROP TABLE IF EXISTS depoimento      CASCADE;
DROP TABLE IF EXISTS contato         CASCADE;




-- 1. Entidades independentes

CREATE TABLE estudio (
    id    INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome  VARCHAR(100) NOT NULL
);

CREATE TABLE distribuidora (
    id    INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome  VARCHAR(100) NOT NULL
);

CREATE TABLE plataforma (
    id    INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome  VARCHAR(50) NOT NULL UNIQUE
);



CREATE TABLE depoimento (
    id        INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome      VARCHAR(120) NOT NULL,
    compra    VARCHAR(150),
    nota      INTEGER CHECK (nota BETWEEN 1 AND 5),
    mensagem  TEXT NOT NULL,
    foto      TEXT
);


CREATE TABLE contato (
    id           INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome         VARCHAR(120) NOT NULL,
    comentario   TEXT NOT NULL,
    data_envio   TIMESTAMP NOT NULL DEFAULT NOW(),
    status       VARCHAR(12) NOT NULL DEFAULT 'pendente'
                 CHECK (status IN ('pendente','respondida'))
);



-- Cliente é quem se cadastrou no site (não precisa ter comprado).
-- Cpf é só os 11 dígitos, sem pontos nem traço (a máscara é da tela).
-- senha_hash: nunca a senha em texto; guarda "salt:hash" (scrypt, no backend).
CREATE TABLE cliente (
    id             INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome           VARCHAR(120) NOT NULL,
    email          VARCHAR(160) NOT NULL,
    cpf            CHAR(11)     NOT NULL UNIQUE
                   CHECK (cpf ~ '^[0-9]{11}$'),
    senha_hash     TEXT         NOT NULL,
    data_cadastro  DATE         NOT NULL DEFAULT CURRENT_DATE
);


CREATE UNIQUE INDEX ux_cliente_email ON cliente (LOWER(email));



CREATE TABLE diretor (
    id          INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome        VARCHAR(120) NOT NULL,
    slug        VARCHAR(120) NOT NULL UNIQUE,   -- nome na URL: /diretores/hideo-kojima
    foto        TEXT,
    estudio_id  INTEGER NOT NULL REFERENCES estudio (id)
);

-- ---------------------------------------------------------------------
-- 3. Especialização: Produto -> Jogo | Console
--    Pai guarda o que é comum; cada filho guarda só o que é dele.
--    O id do filho é, ao mesmo tempo, PK e FK para produto.
-- ---------------------------------------------------------------------
--    Preço e desconto NÃO ficam no pai: o console tem um preço só,
--    mas o jogo tem um preço por plataforma (fica em jogo_plataforma).
CREATE TABLE produto (
    id    INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nome  VARCHAR(150) NOT NULL,
    slug  VARCHAR(150) NOT NULL UNIQUE   -- nome na URL: /jogos/elden-ring
);

CREATE TABLE jogo (
    id                INTEGER PRIMARY KEY
                      REFERENCES produto (id) ON DELETE CASCADE,
    descricao         TEXT NOT NULL,
    diretor_id        INTEGER NOT NULL REFERENCES diretor (id),
    distribuidora_id  INTEGER NOT NULL REFERENCES distribuidora (id)
);

CREATE TABLE console (
    id             INTEGER PRIMARY KEY
                   REFERENCES produto (id) ON DELETE CASCADE,
    fabricante     VARCHAR(80) NOT NULL,
    tipo           VARCHAR(50) NOT NULL,
    geracao        VARCHAR(30) NOT NULL,
    imagem         TEXT NOT NULL,                 -- endereço da foto (não o arquivo)
    preco          NUMERIC(10,2) NOT NULL CHECK (preco >= 0),
    desconto       NUMERIC(5,2) CHECK (desconto BETWEEN 0 AND 100),
    plataforma_id  INTEGER NOT NULL REFERENCES plataforma (id)
);


-- Jogo Disponível em Plataforma (N:M). Preço e desconto são atributos
-- do RELACIONAMENTO: dependem do par (jogo, plataforma).
CREATE TABLE jogo_plataforma (
    jogo_id        INTEGER NOT NULL REFERENCES jogo (id) ON DELETE CASCADE,
    plataforma_id  INTEGER NOT NULL REFERENCES plataforma (id),
    preco          NUMERIC(10,2) NOT NULL CHECK (preco >= 0),
    desconto       NUMERIC(5,2) CHECK (desconto BETWEEN 0 AND 100),
    PRIMARY KEY (jogo_id, plataforma_id)
);

-- ---------------------------------------------------------------------
-- 5. Mídia (entidade fraca): identificada por (jogo, ordem)
-- ---------------------------------------------------------------------
CREATE TABLE midia (
    jogo_id  INTEGER NOT NULL REFERENCES jogo (id) ON DELETE CASCADE,
    ordem    INTEGER NOT NULL CHECK (ordem >= 1),
    tipo     VARCHAR(10) NOT NULL CHECK (tipo IN ('trailer', 'imagem')),
    url      TEXT NOT NULL,
    PRIMARY KEY (jogo_id, ordem)
);

-- ---------------------------------------------------------------------
-- 6. Compras: Cliente Realiza Pedido; Pedido Contém Itens; Item Referencia Produto
-- ---------------------------------------------------------------------
CREATE TABLE pedido (
    id           INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    data_pedido  TIMESTAMP NOT NULL DEFAULT NOW(),
    status       VARCHAR(12) NOT NULL DEFAULT 'pendente'
                 CHECK (status IN ('pendente', 'confirmado', 'entregue', 'cancelado')),
    cliente_id   INTEGER NOT NULL REFERENCES cliente (id)
);

CREATE TABLE item_pedido (
    id              INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    pedido_id       INTEGER NOT NULL REFERENCES pedido (id) ON DELETE CASCADE,
    produto_id      INTEGER NOT NULL REFERENCES produto (id),
    -- plataforma do jogo comprado; fica vazia quando o item é um console
    plataforma_id   INTEGER REFERENCES plataforma (id),
    quantidade      INTEGER NOT NULL CHECK (quantidade > 0),
    -- preço pago no momento da compra (o preço do produto pode mudar depois)
    valor_unitario  NUMERIC(10,2) NOT NULL CHECK (valor_unitario >= 0),
    -- o mesmo produto na mesma plataforma aparece uma vez por pedido
    -- (NULLS NOT DISTINCT: dois consoles iguais, com plataforma vazia, também contam como repetidos)
    UNIQUE NULLS NOT DISTINCT (pedido_id, produto_id, plataforma_id)
);

-- ---------------------------------------------------------------------
-- 7. Avaliações: Cliente Escreve, Jogo Recebe
--    UNIQUE: um cliente avalia o mesmo jogo uma única vez.
--    "Só quem comprou pode avaliar" é checado na API (EXISTS), não aqui.
-- ---------------------------------------------------------------------
CREATE TABLE avaliacao (
    id              INTEGER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nota            INTEGER NOT NULL CHECK (nota BETWEEN 1 AND 5),
    comentario      TEXT NOT NULL,
    data_avaliacao  TIMESTAMP NOT NULL DEFAULT NOW(),
    cliente_id      INTEGER NOT NULL REFERENCES cliente (id),
    jogo_id         INTEGER NOT NULL REFERENCES jogo (id) ON DELETE CASCADE,
    UNIQUE (cliente_id, jogo_id)
);


-- ---------------------------------------------------------------------
-- 9. Índices nas chaves estrangeiras mais consultadas
--    (o PostgreSQL cria índice sozinho para PK/UNIQUE, mas NÃO para FK)
-- ---------------------------------------------------------------------
CREATE INDEX ix_diretor_estudio     ON diretor     (estudio_id);
CREATE INDEX ix_jogo_diretor        ON jogo        (diretor_id);
CREATE INDEX ix_jogo_distribuidora  ON jogo        (distribuidora_id);
CREATE INDEX ix_pedido_cliente      ON pedido      (cliente_id);
CREATE INDEX ix_item_produto        ON item_pedido (produto_id);
CREATE INDEX ix_avaliacao_jogo      ON avaliacao   (jogo_id);

-- ---------------------------------------------------------------------
-- 10. Atributo derivado: valor total do pedido
--     Não é coluna (evita guardar a mesma informação duas vezes);
--     é calculado pela view a partir dos itens.
-- ---------------------------------------------------------------------
CREATE VIEW vw_pedido_total AS
SELECT  p.id            AS pedido_id,
        p.cliente_id,
        p.data_pedido,
        p.status,
        COALESCE(SUM(i.quantidade * i.valor_unitario), 0) AS valor_total
FROM    pedido p
LEFT JOIN item_pedido i ON i.pedido_id = p.id
GROUP BY p.id, p.cliente_id, p.data_pedido, p.status;














