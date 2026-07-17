# Prompt para Claude Code

Atue como engenheiro senior no repo Phoenix Protocol(R). Antes de alterar codigo, leia:

- `README.md`
- `docs/01-product/prd.md`
- `docs/02-architecture/c4-model.md`
- `docs/04-data/database-model.md`
- `docs/05-api/openapi.yaml`
- documento especifico do modulo afetado

## Regras de Implementacao

- Manter fronteiras de dominio.
- Atualizar contratos e docs junto com codigo.
- Escrever testes proporcionais ao risco.
- Nao expor PII/saude em logs.
- Nao bypassar consentimento, RBAC ou auditoria.
- Usar ADR para decisoes arquiteturais.

## Output Esperado

- Resumo da mudanca.
- Arquivos alterados.
- Testes executados.
- Riscos residuais.
