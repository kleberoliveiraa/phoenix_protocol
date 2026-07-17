# Plano de Testes QA

## Estrategia

- Unitarios para regras de dominio.
- Integracao para API, banco, auth, billing e IA.
- Contrato para OpenAPI/GraphQL.
- E2E para jornadas criticas.
- Segurança para auth, autorizacao por objeto, dados sensiveis e abuso.
- Performance para dashboard, diario e IA.
- Acessibilidade para web/mobile.

## Jornadas Criticas

| ID | Jornada | Testes |
|---|---|---|
| QA-001 | Cadastro e onboarding | consentimento, prontidao, criacao de plano |
| QA-002 | Dia 1 | abrir treino, concluir sessao, registrar diario |
| QA-003 | Dor articular | reportar dor, regressao, alerta, auditoria |
| QA-004 | Reteste | registrar Dia 30/60/90 e ver evolucao |
| QA-005 | AI chat | resposta com guardrails, citacoes e bloqueios |
| QA-006 | Medical | consentimento, upload, biomarcador, relatorio |
| QA-007 | Billing | checkout, webhook, entitlement, cancelamento |
| QA-008 | Admin | RBAC, auditoria, exportacao, logs |

## Dados de Teste

- Usuarios ficticios por nivel: iniciante, intermediario, alto risco, sem consentimento, plano expirado.
- Programas nos dias 1, 30, 60 e 90.
- Exames ficticios com valores normais, fora da faixa e unidade invalida.
- Pagamentos aprovados, recusados e webhook repetido.

## Criterios de Release

- Zero bugs criticos abertos.
- Sem falha de autorizacao por tenant.
- E2E criticos passando.
- Contratos API validos.
- Logs e metricas visiveis em staging.
- Checklist LGPD/saude aprovado para mudancas sensiveis.
