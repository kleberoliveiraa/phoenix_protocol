# ADR 0001 - Baseline de Plataforma

## Status

Aceita.

## Contexto

O Phoenix Protocol(R) precisa evoluir de materiais de programa de 90 dias para plataforma SaaS com web, mobile, IA, dados sensiveis, gamificacao, billing e operacao.

## Decisao

Adotar uma arquitetura modular, multi-tenant, TypeScript-first, com PostgreSQL como banco operacional, contratos OpenAPI/GraphQL e Phoenix AI Engine como camada isolada para uso de modelos.

## Consequencias

- O MVP pode ser entregue como modular monolith com fronteiras fortes.
- Dados medicos e IA terao controles reforcados desde o inicio.
- Servicos podem ser extraidos quando escala, compliance ou equipe justificarem.
- A documentacao em `docs/` passa a ser fonte de verdade para geracao por IA.
