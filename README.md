# Phoenix Protocol(R) - Performance Operating System

Este workspace contem a documentacao oficial de engenharia para evoluir o Phoenix Protocol(R) como plataforma SaaS de performance humana, com base nos materiais fonte fornecidos e nas referencias tecnicas oficiais.

## Pacote Entregue

- Produto: PRD, usuarios, jornadas, MVP e requisitos.
- Arquitetura: C4 Model, decisoes tecnicas, componentes, fluxos e deployment.
- Processos: UML e BPMN em formato versionavel.
- Dados: catalogo com 536 entidades, modelo PostgreSQL logico e governanca de dados.
- APIs: OpenAPI 3.1.1 e schema GraphQL inicial.
- IA: Phoenix AI Engine e Phoenix Medical Intelligence com limites de seguranca.
- Experiencia: design system, UX/UI e especificacao mobile Android/iOS.
- Academias: requisitos B2B/B2B2C para unidades, alunos, coaches, nutricionistas, cohortes e dashboards.
- Nutricao: Phoenix Nutrition System para Foundation, Recomp, Hypertrophy, Cut, Peak, meal prep, score e ajustes a cada 14 dias.
- Negocio: gamificacao, SaaS, monetizacao e roadmap de 5 anos.
- Operacao: manuais de usuario/admin, QA, DevOps, CI/CD e compliance.
- Prompts: Lovable, Claude Code, Cursor e GitHub Copilot.

## Como Usar

1. Leia `docs/00-overview/source-context.md` para entender as fontes e premissas.
2. Use `docs/01-product/prd.md` como contrato de produto.
3. Use `docs/02-architecture/c4-model.md` e `docs/04-data/database-model.md` antes de gerar codigo.
4. Use `docs/05-api/openapi.yaml` e `docs/05-api/graphql-schema.graphql` como contratos de integracao.
5. Use `prompts/` para orientar ferramentas de IA sem perder consistencia.

## Regra de Ouro

Nenhuma implementacao deve contrariar estes documentos sem uma ADR em `adr/`. Quando o produto evoluir, atualize primeiro PRD, arquitetura, dados e API; depois gere ou modifique codigo.
