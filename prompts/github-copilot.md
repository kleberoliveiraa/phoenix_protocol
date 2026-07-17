# Prompt para GitHub Copilot

Instrucoes de repositorio para Copilot:

- Produto: Phoenix Protocol(R) Performance Operating System.
- Arquitetura: modular monolith TypeScript evolutivo, multi-tenant, PostgreSQL.
- Contratos: OpenAPI e GraphQL em `docs/05-api/`.
- Dados: catalogo em `docs/04-data/entity-catalog.csv`.
- Segurança: LGPD/GDPR/HIPAA readiness, consentimento e auditoria.
- IA: Phoenix AI Engine com guardrails; sem diagnostico, prescricao ou aconselhamento medico definitivo.
- UX: diario rapido, treino do dia, War Room, design system escuro e operacional.

Ao sugerir codigo, preserve:

- Tenant isolation.
- Object-level authorization.
- Structured logging sem dados sensiveis.
- Testes para regras de dominio.
- Idempotencia em webhooks, jobs e importacoes.
