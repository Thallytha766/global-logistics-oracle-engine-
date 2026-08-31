-- ==========================================================
-- CONSULTAS DE INTELIGÊNCIA DE MERCADO EXTERIOR (ORACLE SQL)
-- ==========================================================

-- 1. Balança Comercial: Total movimentado em USD por tipo de operação
SELECT 
    tipo_operacao,
    COUNT(id_carga) AS total_containers,
    SUM(valor_mercadoria_usd) AS volume_financeiro_usd,
    AVG(valor_mercadoria_usd) AS ticket_medio_usd
FROM tb_cargas
GROUP BY tipo_operacao;

-- 2. Ranking de Países com Maior Fluxo de Importação/Exportação
SELECT 
    p.nm_pais,
    c.tipo_operacao,
    SUM(c.valor_mercadoria_usd) AS total_movimentado_usd,
    DENSE_RANK() OVER (ORDER BY SUM(c.valor_mercadoria_usd) DESC) AS ranking_volume
FROM tb_cargas c
JOIN tb_paises p ON c.cd_destino_pais = p.cd_pais
GROUP BY p.nm_pais, c.tipo_operacao;

-- 3. Rastreamento e Histórico de Auditoria por Contêiner
SELECT 
    c.codigo_container,
    a.status_anterior,
    a.status_novo,
    TO_CHAR(a.data_evento, 'DD/MM/YYYY HH24:MI:SS') AS data_hora_mudanca,
    a.usuario_responsavel
FROM tb_auditoria_cargas a
JOIN tb_cargas c ON a.id_carga = c.id_carga
ORDER BY a.data_evento DESC;
