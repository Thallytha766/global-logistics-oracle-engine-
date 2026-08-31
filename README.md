# 🚢 Global Logistics & Customs Oracle Engine

[![Oracle Database](https://img.shields.io/badge/Oracle_Database-19c%20%2F%2021c-F80000.svg?logo=oracle)](https://www.oracle.com/database/)
[![PL/SQL](https://img.shields.io/badge/Language-PL%2FSQL-blue.svg)](#)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

Mecanismo corporativo de banco de dados **Oracle 19c / 21c** desenvolvido para gestão e desembaraço aduaneiro em operações multinacionais de importação e exportação de cargas.

---

## 🏢 Arquitetura e Regras de Negócio

* **Rigor Fiscal:** Automação do cálculo tributário de importação com base nas alíquotas oficiais de cada país destino via stored functions encapsuladas.
* **Auditoria Contínua:** Implementação de `TRIGGER` de auditoria para rastrear o ciclo de vida e a transição de status dos contêineres (`tb_auditoria_cargas`), registrando usuário e timestamp de cada liberação fiscal.
* **Encapsulamento com Packages:** Agrupamento de rotinas operacionais no pacote `pkg_aduaneiro`, otimizando a compilação e a segurança dos dados aduaneiros.

---

## 📂 Estrutura do Repositório

* `01_schema_oracle.sql`: DDL completo das tabelas relacionais, integridade referencial, constraints de validação de modal e carga inicial de dados.
* `02_packages_e_triggers.sql`: Código PL/SQL contendo o pacote aduaneiro (`pkg_aduaneiro`) e a trigger de auditoria de eventos.
* `03_consultas_analiticas.sql`: Consultas analíticas com `DENSE_RANK()`, agregações de balança comercial e relatórios de conformidade.

