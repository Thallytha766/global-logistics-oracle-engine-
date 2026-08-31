-- ==========================================================
-- ORACLE DATABASE DDL - LOGÍSTICA & IMPORTAÇÃO/EXPORTAÇÃO
-- ==========================================================

-- 1. Tabela de Países e Tributação Padrão
CREATE TABLE tb_paises (
    cd_pais VARCHAR2(3) PRIMARY KEY,
    nm_pais VARCHAR2(100) NOT NULL,
    cd_moeda VARCHAR2(3) NOT NULL,
    aliquota_imposto_padrao NUMBER(5,2) DEFAULT 0.00
);

-- 2. Tabela de Hubs Logísticos (Portos e Aeroportos)
CREATE TABLE tb_portos (
    id_porto NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    nm_porto VARCHAR2(100) NOT NULL,
    cd_pais VARCHAR2(3) NOT NULL,
    tipo_porto VARCHAR2(10) CHECK (tipo_porto IN ('MARITIMO', 'AEREO', 'TERRESTRE')),
    CONSTRAINT fk_portos_paises FOREIGN KEY (cd_pais) REFERENCES tb_paises(cd_pais)
);

-- 3. Tabela de Cargas e Contêineres de Comércio Exterior
CREATE TABLE tb_cargas (
    id_carga NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    codigo_container VARCHAR2(15) UNIQUE NOT NULL,
    tipo_operacao VARCHAR2(15) CHECK (tipo_operacao IN ('IMPORTACAO', 'EXPORTACAO')),
    cd_origem_pais VARCHAR2(3) NOT NULL,
    cd_destino_pais VARCHAR2(3) NOT NULL,
    valor_mercadoria_usd NUMBER(15,2) NOT NULL,
    taxa_imposto_calculada NUMBER(15,2) DEFAULT 0.00,
    status_despacho VARCHAR2(30) DEFAULT 'AGUARDANDO_DESEMBARACO',
    data_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_carga_origem FOREIGN KEY (cd_origem_pais) REFERENCES tb_paises(cd_pais),
    CONSTRAINT fk_carga_destino FOREIGN KEY (cd_destino_pais) REFERENCES tb_paises(cd_pais)
);

-- 4. Tabela de Auditoria Logística e Fiscal
CREATE TABLE tb_auditoria_cargas (
    id_auditoria NUMBER GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    id_carga NUMBER NOT NULL,
    status_anterior VARCHAR2(30),
    status_novo VARCHAR2(30),
    data_evento TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario_responsavel VARCHAR2(50) DEFAULT USER
);

-- 5. Inserção de Dados Iniciais de Comércio Exterior
INSERT INTO tb_paises (cd_pais, nm_pais, cd_moeda, aliquota_imposto_padrao) VALUES ('BRA', 'Brasil', 'BRL', 14.50);
INSERT INTO tb_paises (cd_pais, nm_pais, cd_moeda, aliquota_imposto_padrao) VALUES ('USA', 'Estados Unidos', 'USD', 3.00);
INSERT INTO tb_paises (cd_pais, nm_pais, cd_moeda, aliquota_imposto_padrao) VALUES ('CHN', 'China', 'CNY', 6.50);
INSERT INTO tb_paises (cd_pais, nm_pais, cd_moeda, aliquota_imposto_padrao) VALUES ('DEU', 'Alemanha', 'EUR', 4.20);

INSERT INTO tb_portos (nm_porto, cd_pais, tipo_porto) VALUES ('Porto de Santos', 'BRA', 'MARITIMO');
INSERT INTO tb_portos (nm_porto, cd_pais, tipo_porto) VALUES ('Porto de Xangai', 'CHN', 'MARITIMO');
INSERT INTO tb_portos (nm_porto, cd_pais, tipo_porto) VALUES ('Aeroporto JFK', 'USA', 'AEREO');
INSERT INTO tb_portos (nm_porto, cd_pais, tipo_porto) VALUES ('Porto de Hamburgo', 'DEU', 'MARITIMO');

INSERT INTO tb_cargas (codigo_container, tipo_operacao, cd_origem_pais, cd_destino_pais, valor_mercadoria_usd) 
VALUES ('MSCU9812401', 'IMPORTACAO', 'CHN', 'BRA', 85000.00);
INSERT INTO tb_cargas (codigo_container, tipo_operacao, cd_origem_pais, cd_destino_pais, valor_mercadoria_usd) 
VALUES ('CMAU1123990', 'EXPORTACAO', 'BRA', 'USA', 142000.00);
INSERT INTO tb_cargas (codigo_container, tipo_operacao, cd_origem_pais, cd_destino_pais, valor_mercadoria_usd) 
VALUES ('HLCU5562140', 'IMPORTACAO', 'DEU', 'BRA', 230000.00);

COMMIT;
