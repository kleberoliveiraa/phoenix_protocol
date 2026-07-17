# Phoenix Design System - Figma Specification

## Objetivo

Transformar o design system textual do Phoenix Protocol(R) em uma biblioteca Figma editavel para equipe de produto, engenharia e geracao assistida por IA.

Arquivo Figma: https://www.figma.com/design/dcBV6KoNXNBZ0ZDOLI9y40

## Status da Implementacao Figma

Criado em 2026-07-17:

- 5 colecoes de variaveis: primitives, color, spacing, radius e type.
- 48 variaveis Figma com code syntax para handoff.
- 6 estilos de texto e 2 estilos de efeito.
- Plano Figma Professional confirmado e usado para expandir a biblioteca.
- 7 paginas profissionais criadas: capa, foundations, componentes, mobile, web, admin e logo.
- Paginas compactadas originais preservadas como `_Archive / Compact ...`.
- Reparo automatizado de texto e containers executado nas 7 paginas profissionais.
- QA visual executado por capturas dos frames `Mobile / Today`, `Components / Button`, `Web / War Room Dashboard`, `Admin / Gym Performance Network` e `Logo / Specification`.
- Auditoria estrutural final: 7 paginas auditadas, 0 textos colapsados e 0 overflow de sidebar.

## Fonte de Verdade

- Produto: `docs/01-product/prd.md`
- Design base: `docs/07-ux-ui/design-system.md`
- Mobile: `docs/08-mobile/mobile-app-spec.md`
- Tokens JSON: `docs/07-ux-ui/phoenix-design-tokens.json`

## Estrutura de Paginas no Figma

| Pagina | Conteudo |
|---|---|
| `00 Cover` | Capa, posicionamento da marca e principios de experiencia. |
| `01 Foundations` | Tokens de cor, tipografia, espacamento, radius e elevacao. |
| `02 Components` | Biblioteca inicial de componentes Phoenix. |
| `03 Mobile Core` | Telas mobile Today, War Room, Nutrition, AI Command e Medical. |
| `04 Web War Room` | Dashboard desktop para usuario/coach. |
| `05 Admin Gym` | Dashboard administrativo para academias e redes. |
| `06 Logo Specification` | Simbolo, lockups, regras de uso e area de protecao. |
| `_Archive / Compact ...` | Paginas compactadas preservadas apenas como historico. |

## Tokens Figma

### Colecoes

- `Phoenix Primitives`: valores brutos de cor.
- `Phoenix Color`: tokens semanticos de fundo, texto, borda e status.
- `Phoenix Spacing`: espacamentos e gaps.
- `Phoenix Radius`: raio de controles, cards, paineis e pills.
- `Phoenix Type`: familia, tamanhos e pesos.

### Modo

O MVP usa modo unico `Dark` porque o produto foi especificado como ambiente operacional escuro. Futuro modo `Light` deve ser criado por ADR quando houver telas claras em producao.

### Convencao de nomes

- Variaveis: `color/bg/base`, `color/text/primary`, `spacing/4`, `radius/card`.
- Estilos de texto: `Phoenix/Display`, `Phoenix/H1`, `Phoenix/H2`, `Phoenix/Body`, `Phoenix/Caption`.
- Componentes: `Phoenix/Button`, `Phoenix/Metric Card`, `Phoenix/Daily Check-in Row`.

## Componentes V1

| Componente | Variantes/estados | Uso |
|---|---|---|
| `Phoenix/Button` | Primary, Secondary, Danger; Default, Disabled | Acoes de treino, check-in, relatorio e admin. |
| `Phoenix/Metric Card` | Neutral, Success, Warning, Danger | Indicadores do War Room. |
| `Phoenix/Daily Check-in Row` | Empty, Filled, Alert | Registro rapido de agua, sono, humor, RPE e dor. |
| `Phoenix/Workout Card` | Ready, In Progress, Deload, Blocked | Treino do dia e workout player. |
| `Phoenix/Nutrition Score Card` | Foundation, Recomp, Hypertrophy, Cut, Peak | Nutricao e revisao de 14 dias. |
| `Phoenix/Alert Banner` | Info, Warning, Danger, Medical | Dor articular, seguranca e limites de IA. |
| `Phoenix/Text Field` | Default, Focused, Error, Disabled | Formularios e filtros. |
| `Phoenix/Tab Bar` | Today, War Room, Plan, AI, Medical | Navegacao mobile. |
| `Phoenix/Sidebar Item` | Default, Active, Alert | Navegacao desktop/admin. |

## Telas Principais

### Mobile

- `Today`: treino do dia, check-in de 2 minutos, proxima acao.
- `War Room`: adesao, peso, cintura, sono, humor, risco e tendencia.
- `Nutrition`: score, protocolo, refeicoes, pre/pos-treino e revisao.
- `AI Command Center`: chat com contexto, fontes internas e limites de seguranca.
- `Medical Timeline`: exames, biomarcadores, consentimento e relatorios.

### Web/Desktop

- `War Room Dashboard`: visao executiva para usuario/coach.
- `Gym Admin`: unidades, alunos, cohortes, risco de churn, relatorios e auditoria.

## Logo

### Conceito

O simbolo combina chama, escudo e seta ascendente:

- Chama: transformacao e energia do Phoenix.
- Escudo: seguranca, governanca e protecao articular/medica.
- Seta: evolucao objetiva em ciclos de 90 dias.

### Lockups

- Horizontal: simbolo a esquerda + `Phoenix Protocol(R)`.
- Compacto: simbolo isolado para app icon, favicon e avatar.
- Monocromatico: `color/text/primary` em fundos escuros ou `color/bg/base` em fundos claros.

### Cores

- Chama primaria: `#E25822`.
- Nucleo/realce: `#F97316`.
- Saude/IA: `#2DD4BF`.
- Fundo: `#0B0F14`.
- Texto: `#F8FAFC`.

### Regras

- Area de protecao: minimo 1x a altura da chama ao redor do simbolo.
- Tamanho minimo digital: 24 px para simbolo, 120 px para lockup horizontal.
- Nao usar fades ou efeitos decorativos como identidade principal.
- Nao aplicar em fundos de baixo contraste.

## Criterios de Aceite

- Tokens existem no Figma com nomes equivalentes ao JSON.
- Componentes usam auto-layout e dimensoes estaveis.
- Telas principais representam fluxos reais, nao landing page.
- Logo tem especificacao visual e exemplos de uso.
- Handoff inclui URL do Figma e arquivos versionados no Git.
- QA visual final executado nas paginas profissionais em 2026-07-17.
