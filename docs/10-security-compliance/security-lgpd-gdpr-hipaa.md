# Segurança, LGPD, GDPR e HIPAA Readiness

Este documento nao e aconselhamento juridico. Ele define requisitos tecnicos e operacionais para preparar a plataforma para revisao legal e auditoria.

## Classificacao de Dados

| Classe | Exemplos | Controles |
|---|---|---|
| Publico | Conteudo marketing, paginas publicas | Integridade e versionamento |
| Interno | Documentacao, operacao | RBAC, logs |
| Pessoal | Nome, email, telefone, perfil | Criptografia, minimizacao, DSR |
| Sensivel de saude | exames, biomarcadores, condicoes, medicacoes | Consentimento, auditoria reforcada, acesso minimo |
| Financeiro | assinaturas, invoices, pagamento tokenizado | PCI por provedor, segregacao |
| IA | prompts, respostas, embeddings | filtro de privacidade, retencao, auditoria |

## Controles Base

- OIDC/OAuth2, MFA para admin e contas de risco.
- RBAC + ABAC por tenant, finalidade e classificacao do dado.
- Criptografia TLS, KMS, rotacao de segredos e backup criptografado.
- Logs estruturados sem dados sensiveis em claro.
- Auditoria imutavel para dados medicos, consentimentos, exports e admin.
- Rate limiting, WAF, protecao contra abuso e bot.
- SAST, DAST, dependency scanning, secret scanning e IaC scanning.
- Plano de resposta a incidentes e exercicio trimestral.

## LGPD

Requisitos de produto:

- Registro de finalidade e base legal por tratamento.
- Consentimento granular para dados de saude, IA e compartilhamento com terceiros.
- Direitos do titular: acesso, correcao, exclusao, portabilidade, revogacao e informacao sobre compartilhamento.
- Relatorio de impacto quando houver alto risco.
- Encarregado/DPO e canal de privacidade.
- Registro de operadores/suboperadores.

## GDPR Readiness

- Privacy by design e by default.
- Data Protection Impact Assessment para PMI e IA.
- Transferencia internacional com mecanismo apropriado.
- Registro de atividades de tratamento.
- Direitos do titular e prazos operacionais.
- Categoria especial: dados de saude exigem protecao e base apropriada.

## HIPAA Readiness

HIPAA so se aplica quando a empresa for covered entity, business associate ou atuar em contexto regulado nos EUA. Preparacao tecnica:

- BAA quando aplicavel.
- Controles administrativos, fisicos e tecnicos para ePHI.
- Risk analysis e risk management documentados.
- Breach notification process.
- Minimum necessary access.
- Audit controls, integrity controls, transmission security e access control.

## OWASP ASVS

Baseline recomendado:

- MVP: ASVS nivel 2 para aplicacao principal.
- Medical/Admin: controles adicionais equivalentes a nivel 2+ e requisitos selecionados nivel 3.
- APIs: autenticacao, autorizacao por objeto, validacao, rate limit, logging e protecao de dados.

## Matriz de Acesso

| Papel | Dados de treino | Dados medicos | Billing | Admin |
|---|---:|---:|---:|---:|
| Usuario | proprio | proprio | proprio | nao |
| Coach | consentido | nao por padrao | nao | limitado |
| Profissional saude | relatorio consentido | relatorio consentido | nao | nao |
| Suporte | minimo necessario | mascarado | status | limitado |
| Admin seguranca | auditoria | auditoria | auditoria | sim |

## Incidentes

1. Detectar e classificar.
2. Conter acesso e preservar evidencias.
3. Avaliar dados afetados e titulares.
4. Acionar jurídico/DPO.
5. Notificar autoridades/titulares quando exigido.
6. Corrigir causa raiz.
7. Atualizar controles, testes e treinamento.
