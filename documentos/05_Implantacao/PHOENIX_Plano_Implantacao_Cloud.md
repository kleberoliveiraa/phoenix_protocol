# Plano de Implantacao em Nuvem

## Estrategia

A arquitetura deve ser cloud-portable, mas escolher um provedor primario por fase. Evitar multi-cloud ativo no MVP salvo exigencia comercial.

## Mapeamento

| Capacidade | AWS | Azure | GCP |
|---|---|---|---|
| Containers | ECS/EKS | AKS/Container Apps | Cloud Run/GKE |
| PostgreSQL | RDS/Aurora | Azure Database for PostgreSQL | Cloud SQL/AlloyDB |
| Redis | ElastiCache | Azure Cache for Redis | Memorystore |
| Object storage | S3 | Blob Storage | Cloud Storage |
| Secrets/KMS | Secrets Manager/KMS | Key Vault | Secret Manager/Cloud KMS |
| CDN/WAF | CloudFront/WAF | Front Door/WAF | Cloud CDN/Cloud Armor |
| Observability | CloudWatch/X-Ray | Azure Monitor | Cloud Monitoring/Trace |
| Warehouse | Redshift/Athena | Fabric/Synapse | BigQuery |

## Ambientes

- Dev: baixo custo, dados ficticios, deploy frequente.
- Staging: paridade de configuracao, testes e homologacao.
- Prod: alta disponibilidade, backups, WAF, auditoria e SLO.

## SLO Inicial

- API availability: 99,5% MVP; 99,9% Pro/Enterprise.
- API latency p95: 500 ms sem IA; IA p95 por tarefa definido separadamente.
- RPO: 15 minutos para banco principal.
- RTO: 4 horas MVP; 1 hora enterprise.

## Rede e Segurança

- Subnets privadas para banco e workers.
- Gateway/API na borda com WAF.
- Egress controlado para provedores de IA, pagamentos e email.
- Backups criptografados e restore testado.
- Segregacao logica por tenant; segregacao fisica para enterprise quando contratual.

## Evolucao

- Fase 1: modular monolith em containers + managed PostgreSQL.
- Fase 2: workers, filas, cache e analytics.
- Fase 3: extrair Medical e AI Engine como servicos independentes.
- Fase 4: regioes, DR e opcoes enterprise dedicadas.
