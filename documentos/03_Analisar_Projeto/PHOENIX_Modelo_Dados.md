# Banco de Dados

## Escopo

Este modelo define o banco logico corporativo do Phoenix Protocol(R), com 536 entidades em `entity-catalog.csv` e uma base PostgreSQL em `postgresql-logical-ddl.sql`.

## Decisoes

- Banco operacional principal: PostgreSQL.
- Vetores/RAG: pgvector no mesmo cluster no MVP; separar quando volume ou isolamento exigirem.
- Anexos: object storage com metadados no PostgreSQL.
- Analytics: replicacao para warehouse; nunca consultar dashboards historicos pesados direto no OLTP.
- Multi-tenancy: `tenant_id` obrigatorio para entidades de negocio.
- Auditoria: eventos sensiveis em schema `security`, append-only e monitorados.
- Dados medicos: schema `medical`, criptografia, consentimento explicito, auditoria reforcada e acesso minimo.

## Bounded Contexts

| Contexto | Papel |
|---|---|
| identity | Tenants, usuarios, sessoes, consentimentos e direitos do titular. |
| body | Exercicios, treinos, avaliacoes, fases, progressao e antropometria. |
| combat | Muay Thai tecnico sem contato, corda, rounds, circuitos e marcha. |
| recovery | Sono, dor, mobilidade, readiness e retorno ao treino. |
| nutrition | Protocolos Foundation/Recomp/Hypertrophy/Cut/Peak, macros, carb cycling, score, meal prep, substituicoes, suplementos e revisoes de 14 dias. |
| mental | Habitos, humor, disciplina, journaling e intervencoes. |
| spiritual | Devocional opcional, reflexoes e preferencias de fe. |
| ai | Conversas, contexto, recomendacoes, guardrails, avaliacao e custos. |
| war_room | Dashboards, indicadores, alertas e relatorios. |
| legacy | Graduacao, certificados, conquistas e comunidade. |
| medical | Exames, biomarcadores, sinais vitais, consentimentos e relatorios. |
| gamification | XP, patentes, streaks, badges, missoes e leaderboard. |
| billing | Planos, assinaturas, invoices, pagamentos e entitlements. |
| gym | Academias, unidades, alunos, staff, cohortes, programas de musculacao/fisiculturismo, contratos B2B e dashboards. |
| security | Auditoria, incidentes, controles, politicas e compliance. |
| communications | Email, push, suporte, feedback e campanhas. |
| content | Conteudo, midia, licoes, localizacao e aprovacao editorial. |
| analytics | Eventos, cohorts, funis, experimentos, metricas e datasets. |
| integrations | Webhooks, OAuth, wearables, importacoes e API clients. |

## Entidades Criticas

- `identity.consent_record`: fonte de verdade para tratamento de dados.
- `body.workout_session`: unidade operacional de treino.
- `body.physical_assessment`: bateria Dia 0, 30, 60 e 90.
- `recovery.pain_report`: gatilho para regra da dor e regressao.
- `nutrition.nutrition_protocol`: protocolo Foundation, Recomp, Hypertrophy, Cut ou Peak.
- `nutrition.fourteen_day_nutrition_review`: motor de ajustes nutricionais por peso, cintura, forca, sono e score.
- `nutrition.nutrition_score`: pontuacao operacional de aderencia nutricional e qualidade do plano.
- `gym.gym_facility`: unidade B2B da academia.
- `gym.gym_member_enrollment`: vinculo consentido entre aluno, unidade, coorte e programa.
- `gym.gym_cohort`: agrupamento operacional para desafios, acompanhamento e retencao.
- `medical.biomarker_result`: dado sensivel de saude com trilha de auditoria.
- `ai.ai_recommendation`: recomendacao rastreavel com limite, confianca e feedback.
- `security.audit_log`: evidencia para compliance e investigacao.
- `billing.entitlement`: decisor de acesso por plano.

## Politicas de Dados

- PII: criptografia em repouso, mascaramento em logs, exportacao controlada.
- Dados de saude: acesso por finalidade, consentimento, auditoria, retention e revogacao.
- Dados de IA: prompts e respostas devem ser tratados como dados potencialmente pessoais.
- Dados de academia: alunos so podem ser vistos por staff autorizado da unidade/coorte e dentro da finalidade contratada.
- Dados nutricionais: objetivos, refeicoes, macros, medidas, digestao e suplementos sao dados pessoais de saude/bem-estar e exigem minimizacao, consentimento quando sensiveis e auditoria em revisoes profissionais.
- Dados anonimizados: usar somente quando irreversibilidade for tecnicamente demonstravel.
- Soft delete: padrao para entidades operacionais; hard delete via job governado quando direito do titular permitir.

## Arquivos

- `entity-catalog.csv`: catalogo logico completo com contexto, entidade, tabela, classificacao e owner.
- `postgresql-logical-ddl.sql`: DDL logico gerado para bootstrap e orientacao de IA.

## Regras para Migrations Reais

1. Especializar colunas de entidades de alto uso antes de producao.
2. Evitar `attributes jsonb` como substituto permanente de campos criticos.
3. Adicionar constraints, enums, foreign keys e indices por fluxo.
4. Criar views de leitura para dashboard e relatorios.
5. Validar toda migracao com rollback, seed e teste de performance.
