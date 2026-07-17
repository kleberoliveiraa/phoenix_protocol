# Arquitetura Corporativa - C4 Model

## C1 - Contexto do Sistema

```mermaid
flowchart LR
  user[Usuario Phoenix]
  gymMember[Aluno de academia]
  gymManager[Gestor de academia]
  trainer[Personal trainer / Coach]
  nutritionist[Nutricionista parceiro]
  admin[Administrador / Coach]
  clinician[Profissional de saude autorizado]
  payment[Gateway de pagamento]
  ai[Provedores de IA]
  wearable[Wearables / Health APIs]
  platform[Phoenix Protocol Platform]

  user -->|web/mobile| platform
  gymMember -->|mobile / gym app| platform
  gymManager -->|gym portal| platform
  trainer -->|coach console| platform
  nutritionist -->|revisao consentida| platform
  admin -->|admin console| platform
  clinician -->|relatorios consentidos| platform
  platform -->|cobrancas/webhooks| payment
  platform -->|LLM, embeddings, moderation| ai
  platform -->|importacao consentida| wearable
```

## C2 - Containers

```mermaid
flowchart TB
  subgraph clients[Clientes]
    web[Next.js Web App]
    mobile[Android/iOS App]
    gymPortal[Gym Portal]
    admin[Admin Console]
  end
  subgraph edge[Edge]
    cdn[CDN/WAF]
    api[API Gateway]
  end
  subgraph backend[Backend]
    core[Core App API]
    training[Training Service]
    nutrition[Nutrition Intelligence Service]
    gym[Gym Network Service]
    medical[Medical Intelligence Service]
    ai[Phoenix AI Engine]
    billing[Billing Service]
    comms[Communications Service]
    jobs[Worker/Jobs]
  end
  subgraph data[Dados]
    pg[(PostgreSQL + pgvector)]
    redis[(Redis)]
    object[(Object Storage)]
    warehouse[(Analytics Warehouse)]
  end

  web --> cdn --> api
  mobile --> api
  gymPortal --> api
  admin --> api
  api --> core
  core --> training
  core --> nutrition
  core --> gym
  core --> medical
  core --> ai
  core --> billing
  core --> comms
  core --> pg
  ai --> pg
  jobs --> pg
  jobs --> redis
  medical --> object
  pg --> warehouse
```

## C3 - Componentes Principais

| Container | Componentes |
|---|---|
| Core App API | Tenant resolver, auth, RBAC/ABAC, user profile, consent manager, feature entitlement, audit publisher |
| Training Service | Program planner, workout engine, RPE/readiness adapter, assessment engine, challenge engine |
| Nutrition Intelligence | Protocol selector, macro target engine, carb cycling rules, meal templates, nutrition score, 14-day adjustment engine |
| Gym Network | Facility registry, member enrollment, staff permissions, cohort dashboards, gym retention signals, B2B contracts |
| Medical Intelligence | Health record vault, biomarker parser, trend analyzer, checkup reminder, consented report exporter, escalation gate |
| Phoenix AI Engine | Prompt router, context builder, RAG retriever, safety guardrail, recommendation composer, evaluation logger |
| Billing | Plans, subscriptions, invoices, entitlements, webhooks, dunning |
| Dashboard | Metric aggregator, dashboard composer, alert rule evaluator, report builder |

## C4 - Codigo e Modulos

Estrutura recomendada para um monorepo:

```text
apps/
  web/
  mobile/
  gym-portal/
  admin/
services/
  api/
  ai-engine/
  nutrition/
  gym-network/
  workers/
packages/
  domain/
  contracts/
  design-system/
  telemetry/
  security/
infra/
  terraform/
  helm/
docs/
```

## Fronteiras de Dominio

- `identity`: usuarios, tenants, consentimentos, direitos do titular.
- `training`: treinos, sessoes, progressao, desafios e avaliacoes.
- `nutrition`: protocolos Foundation/Recomp/Hypertrophy/Cut/Peak, macros, score, carb cycling, refeicoes e revisoes de 14 dias.
- `gym`: academias, unidades, alunos, equipe, cohortes, contratos B2B, dashboards e risco de churn.
- `medical`: dados de saude, exames, biomarcadores, lembretes, relatorios e regras de seguranca.
- `ai`: conversas, contexto, recomendacoes, guardrails, avaliacao e custos.
- `billing`: planos, assinaturas, entitlement e monetizacao.
- `analytics`: eventos de produto, cohorts, funis, retencao e modelos.

## Padroes Arquiteturais

- Comecar como modular monolith com fronteiras fortes; extrair servicos quando escala, seguranca ou equipe justificarem.
- Publicar eventos de dominio para acoes relevantes: treino concluido, dor reportada, ajuste nutricional aprovado, aluno matriculado em academia, exame importado, recomendacao criada, consentimento revogado.
- Isolar dados medicos com schema, politicas, auditoria e permissoes separadas.
- Aplicar idempotencia em importacoes, pagamentos, webhooks e jobs.
- Usar outbox/inbox para eventos criticos.
