# Padrao de Engenharia

## Principios

- Plataforma primeiro: todo modulo deve ser multi-tenant, auditavel e versionavel.
- Saude com limites: Phoenix Medical Intelligence e informativo, nao diagnostico, nao substitui profissional de saude e deve aplicar escalonamento quando houver risco.
- IA supervisionada: recomendacoes de IA precisam de fonte, justificativa, nivel de confianca, limite de uso e log de auditoria.
- Dados minimos: coletar somente o necessario para entregar valor, seguranca e conformidade.
- Contratos antes de codigo: dados, API, eventos e UX devem ser definidos antes da implementacao.
- Evolucao por ADR: decisoes arquiteturais relevantes exigem registro.

## Stack de referencia

- Web: Next.js, React, TypeScript, Tailwind, design tokens.
- Mobile: React Native/Expo ou nativo quando sensores, HealthKit/Google Fit ou notificacoes exigirem controle fino.
- Backend: NestJS/Fastify ou modular monolith TypeScript; separar em servicos quando carga e dominios justificarem.
- Banco: PostgreSQL, pgvector para RAG, Redis para cache/filas curtas, object storage para anexos.
- IA: camada Phoenix AI Engine com provedores substituiveis, RAG, guardrails, avaliacao e auditoria.
- Observabilidade: OpenTelemetry, logs estruturados, metricas por tenant, alertas SLO.
- Infra: containers, IaC, ambientes dev/staging/prod, CI/CD com gates de seguranca.

## Definition of Done

- Requisito rastreado ao PRD.
- Modelo de dados ou migracao revisada.
- OpenAPI/GraphQL atualizado quando houver contrato externo.
- Testes unitarios, integracao e e2e relevantes.
- Telemetria, logs e alertas definidos.
- LGPD/GDPR/HIPAA readiness avaliado quando houver dados pessoais, sensiveis ou de saude.
- Documentacao de usuario/admin atualizada quando o comportamento mudar.

## Ambientes

- `local`: dados ficticios, ferramentas de desenvolvimento, sem dados reais.
- `dev`: integracao tecnica, seeds anonimizados.
- `staging`: homologacao, paridade de infra, testes de seguranca.
- `prod`: dados reais, criptografia, backups, monitoramento e controle de mudancas.

## Controle de Qualidade de IA

Toda entrega gerada por IA deve ser tratada como rascunho tecnico ate passar por revisao humana. Geradores devem receber os documentos de `docs/` como fonte primaria e nao devem criar entidades, endpoints ou fluxos paralelos sem atualizar a documentacao.
