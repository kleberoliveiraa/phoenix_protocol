# Especificacao Android/iOS

## Objetivo

Entregar o Phoenix Protocol(R) como aplicativo de acompanhamento diario, treino guiado, check-ins, notificacoes, IA, medical timeline e dashboard.

## Stack Recomendada

- React Native + Expo para velocidade de produto.
- Modulos nativos quando necessario: HealthKit, Google Fit/Health Connect, notificacoes, armazenamento seguro.
- Estado local: TanStack Query + storage criptografado para dados sensiveis minimos.
- Offline-first parcial: treino do dia, diario pendente e conteudo essencial.

## Navegacao

- Hoje: treino, check-in, proximo passo.
- War Room: indicadores, tendencia, fase, riscos.
- Plano: calendario 90 dias, fases, deloads e desafios.
- IA: Phoenix AI Command Center.
- Medical: exames, lembretes, graficos e relatorios.
- Perfil: metas, consentimentos, assinatura e privacidade.

## Notificacoes

- Treino do dia.
- Check-in diario.
- Retestes Dia 30, 60 e 90.
- Deload.
- Lembrete de check-up.
- Alerta de seguranca ou pausa recomendada.

## Segurança Mobile

- Tokens em secure storage.
- Bloqueio biometrico opcional para Medical.
- Redacao de logs locais.
- Pinning apenas se operacao e rotacao estiverem maduras.
- Deep links assinados para relatorios e convites.

## Permissoes

- Notificacoes: opt-in granular.
- Health data: opt-in por tipo de dado.
- Camera/arquivos: apenas upload de exames e fotos de progresso.
- Localizacao: fora do escopo MVP, salvo justificativa futura.

## Criterios de Aceite

- Check-in diario em ate 2 minutos.
- Workout player funciona sem internet apos preload do dia.
- Medical exige consentimento antes de upload/importacao.
- Revogacao de consentimento afeta sincronizacao e processamento.
- Notificacoes respeitam horario local e preferencias.
