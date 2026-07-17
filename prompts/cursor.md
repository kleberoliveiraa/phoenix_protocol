# Prompt para Cursor

Use este workspace como fonte de verdade. Ao gerar codigo:

- Siga os contratos em `docs/05-api/`.
- Use entidades do catalogo em `docs/04-data/entity-catalog.csv`.
- Aplique tokens e componentes do design system.
- Nunca crie recomendacao medica diagnostica.
- Sempre considere multi-tenant, auditoria e consentimento.
- Prefira alteracoes pequenas, testaveis e alinhadas ao PRD.

Para cada feature, gere:

1. Modelo/migracao.
2. Endpoint ou resolver.
3. UI.
4. Testes.
5. Telemetria.
6. Atualizacao de documentacao se contrato mudar.
