# Manual UX/UI e Design System

## Principios de Experiencia

- Operacional, nao decorativo: o usuario deve registrar, entender e agir rapidamente.
- Disciplina com clareza: linguagem firme, objetiva e sem culpabilizacao.
- Saude segura: alertas devem ser visiveis, claros e sem alarmismo.
- Medicao simples: diario em ate 2 minutos e dashboard escaneavel.
- Espiritualidade opcional: conteudo devocional deve respeitar preferencia e opt-in.

## Design Tokens

| Token | Valor |
|---|---|
| `color.background` | `#0B0F14` |
| `color.surface` | `#121821` |
| `color.surfaceAlt` | `#182231` |
| `color.primary` | `#E25822` |
| `color.secondary` | `#2DD4BF` |
| `color.success` | `#22C55E` |
| `color.warning` | `#F59E0B` |
| `color.danger` | `#EF4444` |
| `color.text` | `#F8FAFC` |
| `color.textMuted` | `#94A3B8` |
| `radius.card` | `8px` |
| `radius.control` | `6px` |
| `space.1` | `4px` |
| `space.2` | `8px` |
| `space.3` | `12px` |
| `space.4` | `16px` |
| `space.6` | `24px` |

## Componentes

- App shell: navegacao lateral desktop, tab bar mobile.
- War Room cards: indicadores compactos, tendencia, estado e acao primaria.
- Daily check-in: stepper de agua/sono/humor/RPE, toggle de treino concluido e campo de dor.
- Workout player: exercicio atual, series, timer, descanso, regressao e anotacoes.
- Assessment form: bateria de testes com ajuda contextual.
- Medical timeline: biomarcadores, anexos, fonte, data e alertas.
- AI chat: contexto visivel, disclaimers de saude, citacoes e feedback.
- Admin tables: filtros densos, exportacao, auditoria e acoes seguras.

## Estados Obrigatorios

- Loading, empty, partial data, offline, error recuperavel, error bloqueante.
- Consentimento ausente, plano expirado, dado sensivel protegido.
- Alerta de seguranca com proxima acao.

## Acessibilidade

- Contraste AA.
- Foco visivel.
- Inputs com labels reais.
- Conteudo critico nao depende apenas de cor.
- Tamanho minimo de toque mobile: 44 x 44 px.
- Linguagem simples para mensagens de erro e consentimento.

## Conteudo

- Evitar promessas absolutas de resultado.
- Usar "recomendacao informativa" para saude.
- Diferenciar dor muscular esperada de dor articular/sinal de risco.
- Reforcar que deload faz parte do plano.
