from __future__ import annotations

import re
import textwrap
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
STORY_DIR = ROOT / "documentos" / "02_Especificacao_Funcional" / "Historias_Usuario"
INDEX_PATH = ROOT / "documentos" / "02_Especificacao_Funcional" / "PHOENIX_Historias_Usuario.md"


def clean(text: str) -> str:
    return textwrap.dedent(text).strip() + "\n"


def slug(value: str) -> str:
    replacements = {
        "á": "a",
        "à": "a",
        "ã": "a",
        "â": "a",
        "é": "e",
        "ê": "e",
        "í": "i",
        "ó": "o",
        "ô": "o",
        "õ": "o",
        "ú": "u",
        "ç": "c",
    }
    value = value.lower()
    for old, new in replacements.items():
        value = value.replace(old, new)
    value = re.sub(r"[^a-z0-9]+", "-", value).strip("-")
    return value


def table_row(values: list[str]) -> str:
    return "|" + "|".join(values) + "|"


STORIES = [
    {
        "id": "HU_001",
        "prd": "PRD-F001",
        "priority": "Must",
        "title": "Completar onboarding, prontidao, metas e consentimentos",
        "actor": "usuario Phoenix",
        "want": "completar meu onboarding, informar minha prontidao fisica, registrar metas e aceitar consentimentos aplicaveis",
        "benefit": "iniciar o protocolo com seguranca, personalizacao e base legal adequada para tratamento de dados",
        "description": "Fluxo inicial de cadastro funcional que coleta objetivos, linha de base, prontidao, restricoes, preferencias e consentimentos antes de ativar o plano Phoenix.",
        "screen": "Onboarding Phoenix",
        "components": [
            ("1", "Stepper de onboarding", "Organiza perfil, metas, prontidao, consentimentos e confirmacao final."),
            ("2", "Formulario de prontidao", "Coleta respostas de risco, lesoes, medicacoes e historico de treino."),
            ("3", "Consent Manager", "Exibe finalidades, politicas e aceite granular."),
        ],
        "fields": [
            ("1", "Objetivo principal", "Selecao unica", "Lista", "N/A", "Sim", "Opcoes: recomposicao, hipertrofia, definicao, condicionamento, saude."),
            ("2", "Respostas de prontidao", "Questionario", "Booleano/texto", "N/A", "Sim", "Respostas criticas podem exigir liberacao medica."),
            ("3", "Consentimentos", "Selecao multipla", "Checkbox", "N/A", "Sim", "Registrar data, finalidade, versao e origem do aceite."),
        ],
        "criteria": [
            ("1", "o usuario acessa a plataforma pela primeira vez", "conclui perfil, metas e consentimentos", "o sistema cria perfil, baseline e trilha de auditoria de consentimento."),
            ("2", "uma resposta de prontidao indica risco critico", "o usuario tenta finalizar o onboarding", "o sistema bloqueia ativacao automatica e orienta obter liberacao profissional."),
            ("3", "o usuario nao aceita um consentimento obrigatorio", "clica em finalizar", "o sistema informa a finalidade pendente e nao ativa recursos dependentes."),
            ("4", "o usuario conclui todos os passos validos", "confirma o onboarding", "o sistema ativa o programa inicial e redireciona para o War Room ou Dia 1."),
        ],
        "rules": [
            ("RN-HU001-01", "Consentimento granular", "LGPD", "N/A", "N/A", "Sim", "Dados sensiveis exigem finalidade e consentimento explicito quando aplicavel."),
            ("RN-HU001-02", "Bloqueio medico", "Seguranca", "N/A", "N/A", "Sim", "Dor no peito, tontura ou restricao medica bloqueiam ativacao automatica."),
        ],
        "data": "identity.user_account, identity.consent_record, identity.readiness_screening, identity.goal",
        "apis": "POST /v1/onboarding, GET /v1/me",
    },
    {
        "id": "HU_002",
        "prd": "PRD-F002",
        "priority": "Must",
        "title": "Gerar plano de 90 dias com fases, treinos, RPE e deloads",
        "actor": "usuario Phoenix",
        "want": "receber um plano de 90 dias dividido em fases, treinos, RPE alvo e semanas de deload",
        "benefit": "seguir uma progressao clara, segura e mensuravel ate a graduacao",
        "description": "Gera o plano operacional com fases Foundation, Strength, Performance e Graduation, incluindo treinos diarios, desafios, deloads nas semanas 4, 8 e 12 e retestes.",
        "screen": "Plano 90 Dias",
        "components": [
            ("1", "Calendario do programa", "Exibe dias, semanas, fase, deloads e graduacao."),
            ("2", "Workout planner", "Monta sessoes por foco, exercicios, series e RPE."),
            ("3", "Motor de progressao", "Aplica regras de nivel, regressao e criterios de graduacao."),
        ],
        "fields": [
            ("1", "Data de inicio", "Data", "yyyy-mm-dd", "10", "Sim", "Base para gerar os 90 dias."),
            ("2", "Fase", "Calculado", "Texto", "N/A", "Sim", "Foundation, Strength, Performance ou Graduation."),
            ("3", "RPE alvo", "Calculado", "Numero", "1-10", "Sim", "Varia por fase e deload."),
        ],
        "criteria": [
            ("1", "o onboarding esta completo", "o plano e gerado", "o sistema cria 90 dias com fases, treinos, deloads e desafios."),
            ("2", "a semana gerada e 4, 8 ou 12", "o usuario visualiza os treinos", "o volume aparece reduzido e identificado como deload."),
            ("3", "o usuario esta em uma fase especifica", "abre a sessao do dia", "o sistema exibe RPE alvo, exercicios, descansos e observacoes."),
            ("4", "o usuario conclui criterios de progressao", "a semana seguinte e recalculada", "o sistema sugere avancar nivel mantendo seguranca articular."),
        ],
        "rules": [
            ("RN-HU002-01", "Deload obrigatorio", "Treino", "N/A", "N/A", "Sim", "Semanas 4, 8 e 12 reduzem volume e nao devem ser compensadas."),
            ("RN-HU002-02", "Progressao segura", "Treino", "N/A", "N/A", "Sim", "Avanco exige criterio cumprido sem dor articular relevante."),
        ],
        "data": "body.program_plan, body.training_day, body.workout_session, body.deload_rule",
        "apis": "GET /v1/programs/current",
    },
    {
        "id": "HU_003",
        "prd": "PRD-F003",
        "priority": "Must",
        "title": "Registrar diario em menos de dois minutos",
        "actor": "usuario Phoenix",
        "want": "registrar rapidamente treino cumprido, agua, sono, humor, RPE, dor e observacoes",
        "benefit": "manter historico diario sem friccao e alimentar indicadores de progresso e seguranca",
        "description": "Check-in diario com campos essenciais para aderencia, recuperacao e risco, desenhado para uso mobile e preenchimento rapido.",
        "screen": "Check-in Diario",
        "components": [
            ("1", "Toggle de treino cumprido", "Registra conclusao da sessao."),
            ("2", "Steppers de metricas", "Permite informar agua, sono, humor e RPE rapidamente."),
            ("3", "Campo de dor/observacoes", "Captura sinais de risco e contexto livre."),
        ],
        "fields": [
            ("1", "Treino cumprido", "Booleano", "Sim/Nao", "N/A", "Sim", "Obrigatorio para calcular adesao."),
            ("2", "Agua", "Numero", "Litros", "0-12", "Sim", "Validar intervalo realista."),
            ("3", "Sono", "Numero", "Horas", "0-24", "Sim", "Impacta readiness."),
            ("4", "Humor", "Numero", "1-5", "1", "Sim", "Escala simples."),
            ("5", "RPE", "Numero", "1-10", "2", "Sim", "Comparar com RPE alvo."),
            ("6", "Dor", "Texto", "Livre", "500", "Nao", "Aciona regra da dor quando preenchido."),
        ],
        "criteria": [
            ("1", "o usuario possui programa ativo", "abre o check-in do dia", "o sistema exibe campos pre-configurados para o dia atual."),
            ("2", "todos os campos obrigatorios estao preenchidos", "o usuario salva o check-in", "o sistema registra o diario e atualiza indicadores."),
            ("3", "ha dor articular informada", "o check-in e salvo", "o sistema cria alerta de seguranca para avaliacao de regressao."),
            ("4", "o usuario tenta salvar sem campo obrigatorio", "clica em salvar", "o sistema destaca os campos pendentes e nao persiste o log."),
        ],
        "rules": [
            ("RN-HU003-01", "Check-in unico por dia", "Integridade", "N/A", "N/A", "Sim", "Evitar duplicidade por user_id e program_day."),
            ("RN-HU003-02", "Validacao de faixas", "Qualidade", "N/A", "N/A", "Sim", "Numeros fora de faixa devem ser rejeitados."),
        ],
        "data": "body.workout_session, recovery.sleep_record, recovery.pain_report, body.rpe_record",
        "apis": "POST /v1/daily-logs, POST /v1/workout-sessions/{sessionId}/complete",
    },
    {
        "id": "HU_004",
        "prd": "PRD-F004",
        "priority": "Must",
        "title": "Calcular adesao semanal, medias e tendencias",
        "actor": "usuario Phoenix",
        "want": "ver adesao semanal, medias de agua, sono, humor, RPE e tendencias do meu programa",
        "benefit": "entender se estou consistente e quais ajustes precisam de atencao",
        "description": "Agrega registros diarios e semanais para produzir indicadores operacionais no War Room, relatorios e alertas.",
        "screen": "Indicadores Semanais",
        "components": [
            ("1", "Agregador de metricas", "Calcula medias e percentuais."),
            ("2", "Cards de tendencia", "Mostra melhora, estabilidade ou queda."),
            ("3", "Motor de alertas", "Sinaliza desvios relevantes."),
        ],
        "fields": [
            ("1", "Semana", "Numero", "1-13", "2", "Sim", "Base de agrupamento."),
            ("2", "Adesao", "Calculado", "Percentual", "0-100", "Sim", "Treinos cumpridos / dias previstos."),
            ("3", "Media de sono", "Calculado", "Horas", "0-24", "Sim", "Base para readiness."),
        ],
        "criteria": [
            ("1", "existem logs diarios na semana", "o usuario abre indicadores", "o sistema calcula adesao, medias e tendencias."),
            ("2", "nao existem dados suficientes", "o usuario acessa o painel", "o sistema exibe estado parcial sem erro."),
            ("3", "adesao ou sono caem abaixo do limite", "o agregador processa a semana", "o sistema cria sinal de atencao."),
            ("4", "um log diario e alterado", "o painel e reaberto", "os indicadores refletem a alteracao."),
        ],
        "rules": [
            ("RN-HU004-01", "Calculo rastreavel", "Metricas", "N/A", "N/A", "Sim", "Todo indicador deve apontar origem dos dados."),
            ("RN-HU004-02", "Dados parciais", "UX", "N/A", "N/A", "Sim", "Nao exibir zero enganoso quando faltarem registros."),
        ],
        "data": "war_room.metric_snapshot, war_room.metric_trend, analytics.product_event",
        "apis": "GET /v1/programs/current, GraphQL dashboard",
    },
    {
        "id": "HU_005",
        "prd": "PRD-F005",
        "priority": "Must",
        "title": "Registrar testes fisicos e antropometria",
        "actor": "usuario Phoenix",
        "want": "registrar testes fisicos e medidas nos dias 0, 30, 60 e 90",
        "benefit": "comparar minha evolucao com criterios objetivos ao longo do protocolo",
        "description": "Registro estruturado da bateria de testes, peso, cintura e demais medidas corporais nos marcos oficiais do programa.",
        "screen": "Avaliacoes e Retestes",
        "components": [
            ("1", "Formulario de avaliacao", "Campos de testes e medidas."),
            ("2", "Comparativo por marco", "Mostra Dia 0, 30, 60 e 90."),
            ("3", "Validador de evolucao", "Calcula variacao e interpreta direcao esperada."),
        ],
        "fields": [
            ("1", "Dia da avaliacao", "Selecao unica", "0/30/60/90", "2", "Sim", "Apenas marcos oficiais."),
            ("2", "Flexoes 2 min", "Numero", "Inteiro", "N/A", "Nao", "Maior e melhor."),
            ("3", "Barra fixa max", "Numero", "Inteiro", "N/A", "Nao", "Maior e melhor."),
            ("4", "Corrida 3,2 km", "Numero", "Minutos", "N/A", "Nao", "Menor e melhor."),
            ("5", "Cintura", "Numero", "cm", "N/A", "Nao", "Usada em tendencias de recomposicao."),
        ],
        "criteria": [
            ("1", "o usuario seleciona um marco valido", "salva a avaliacao", "o sistema persiste os resultados e calcula variacoes."),
            ("2", "a corrida tem tempo menor que a base", "o comparativo e calculado", "o sistema interpreta como evolucao positiva."),
            ("3", "um valor numerico invalido e informado", "o usuario salva", "o sistema bloqueia e destaca o campo."),
            ("4", "existem avaliacoes anteriores", "o usuario abre comparativo", "o sistema mostra progresso absoluto e percentual."),
        ],
        "rules": [
            ("RN-HU005-01", "Marcos oficiais", "Programa", "N/A", "N/A", "Sim", "Avaliacoes principais ocorrem em 0, 30, 60 e 90 dias."),
            ("RN-HU005-02", "Direcao da corrida", "Calculo", "N/A", "N/A", "Sim", "Para corrida, reducao de tempo e melhoria."),
        ],
        "data": "body.physical_assessment, body.strength_test, body.endurance_test, body.anthropometry_record",
        "apis": "POST /v1/assessments",
    },
    {
        "id": "HU_006",
        "prd": "PRD-F006",
        "priority": "Must",
        "title": "Detectar dor articular e recomendar regressao ou pausa",
        "actor": "usuario Phoenix",
        "want": "informar dor articular e receber orientacao segura de regressao, pausa ou escalonamento",
        "benefit": "proteger articulacoes e reduzir risco de lesao durante o programa",
        "description": "Aplica regra da dor a partir de check-ins, RPE, observacoes e historico para ajustar treino sem linguagem clinica indevida.",
        "screen": "Alerta de Dor e Regressao",
        "components": [
            ("1", "Detector de dor", "Interpreta relato do usuario."),
            ("2", "Recomendador de regressao", "Sugere reduzir nivel, volume ou pausar."),
            ("3", "Escalonamento de seguranca", "Orienta buscar profissional em sinais criticos."),
        ],
        "fields": [
            ("1", "Local da dor", "Selecao/texto", "Lista/livre", "100", "Sim", "Ombro, cotovelo, punho, lombar, quadril, joelho, tornozelo ou outro."),
            ("2", "Intensidade", "Numero", "0-10", "2", "Sim", "Acima de limite aciona alerta."),
            ("3", "Sinal critico", "Booleano", "Sim/Nao", "N/A", "Sim", "Dor no peito, tontura ou falta de ar desproporcional escalona."),
        ],
        "criteria": [
            ("1", "o usuario relata dor articular moderada", "salva o check-in", "o sistema recomenda regressao e registra alerta."),
            ("2", "o usuario relata sinal critico", "salva ou tenta continuar", "o sistema orienta interromper e procurar atendimento profissional."),
            ("3", "ha dor recorrente no mesmo padrao", "o plano e recalculado", "o sistema reduz progressao do movimento afetado."),
            ("4", "o alerta e criado", "staff autorizado visualiza coorte", "o aluno aparece com prioridade de acompanhamento sem expor dados alem do necessario."),
        ],
        "rules": [
            ("RN-HU006-01", "Sem diagnostico", "Compliance", "N/A", "N/A", "Sim", "O sistema nao diagnostica lesao."),
            ("RN-HU006-02", "Escalonamento critico", "Seguranca", "N/A", "N/A", "Sim", "Sinais criticos exigem orientacao de atendimento profissional."),
        ],
        "data": "recovery.pain_report, recovery.pain_rule_decision, recovery.recovery_alert",
        "apis": "POST /v1/daily-logs",
    },
    {
        "id": "HU_007",
        "prd": "PRD-F007",
        "priority": "Must",
        "title": "Exibir War Room Dashboard para usuario e cohortes",
        "actor": "usuario, coach ou gestor autorizado",
        "want": "visualizar indicadores de progresso, aderencia, risco e proximos passos",
        "benefit": "tomar decisoes rapidas sobre treino, recuperacao, nutricao e acompanhamento",
        "description": "Dashboard operacional para usuario individual e visao agregada por coorte/unidade com controles de permissao.",
        "screen": "War Room Dashboard",
        "components": [
            ("1", "Cards de KPI", "Adesao, sono, humor, peso, cintura e score nutricional."),
            ("2", "Painel de alertas", "Mostra dor, baixa adesao, risco de churn e pendencias."),
            ("3", "Filtro de coorte", "Permite staff autorizado segmentar alunos."),
        ],
        "fields": [
            ("1", "Periodo", "Filtro", "Data", "N/A", "Sim", "Padrao: semana atual."),
            ("2", "Coorte", "Filtro", "UUID", "36", "Nao", "Disponivel somente para perfis autorizados."),
            ("3", "Indicador", "Calculado", "Numero/texto", "N/A", "Sim", "Origem rastreavel."),
        ],
        "criteria": [
            ("1", "o usuario individual acessa o dashboard", "a tela carrega", "o sistema exibe somente seus proprios indicadores."),
            ("2", "um coach autorizado filtra uma coorte", "a consulta e executada", "o sistema exibe dados agregados e alunos permitidos."),
            ("3", "ha alerta de seguranca", "o painel e carregado", "o alerta aparece com severidade e proxima acao."),
            ("4", "o usuario nao tem permissao de coorte", "tenta acessar filtro B2B", "o sistema nega acesso e registra auditoria."),
        ],
        "rules": [
            ("RN-HU007-01", "Isolamento por tenant", "Seguranca", "N/A", "N/A", "Sim", "Nao cruzar dados de academias ou tenants."),
            ("RN-HU007-02", "Minimizacao", "LGPD", "N/A", "N/A", "Sim", "Visoes agregadas devem reduzir exposicao de dados pessoais."),
        ],
        "data": "war_room.dashboard, war_room.metric_snapshot, gym.gym_dashboard, security.audit_log",
        "apis": "GraphQL dashboard, GET /v1/gyms/current",
    },
    {
        "id": "HU_008",
        "prd": "PRD-F008",
        "priority": "Should",
        "title": "Conversar com Phoenix AI com historico e fontes internas",
        "actor": "usuario Phoenix",
        "want": "conversar com a Phoenix AI usando meu contexto autorizado",
        "benefit": "receber explicacoes e proximas acoes coerentes com meu programa, sem violar limites de saude",
        "description": "Chat de IA com RAG, guardrails, citacoes internas, historico e registro de auditoria.",
        "screen": "Phoenix AI Command Center",
        "components": [
            ("1", "Chat Phoenix AI", "Entrada e saida de mensagens."),
            ("2", "Context Builder", "Seleciona dados permitidos para a pergunta."),
            ("3", "Safety Guardrail", "Bloqueia diagnostico, prescricao e sugestoes perigosas."),
        ],
        "fields": [
            ("1", "Mensagem", "Texto", "Livre", "8000", "Sim", "Entrada do usuario."),
            ("2", "Escopo de contexto", "Selecao multipla", "Lista", "N/A", "Nao", "Treino, nutricao, recovery, medical com consentimento."),
            ("3", "Feedback", "Selecao", "Positivo/negativo", "N/A", "Nao", "Usado para avaliacao."),
        ],
        "criteria": [
            ("1", "o usuario envia pergunta permitida", "a IA responde", "o sistema retorna resposta com linguagem informativa e citacoes quando houver contexto interno."),
            ("2", "a pergunta pede diagnostico ou medicacao", "a IA avalia a policy", "o sistema bloqueia prescricao e orienta procurar profissional."),
            ("3", "nao ha consentimento para dado medico", "o contexto e montado", "dados medicos nao sao enviados ao provedor de IA."),
            ("4", "a resposta e gerada", "o fluxo finaliza", "prompt, modelo, latencia, custo e decisao de seguranca sao auditados."),
        ],
        "rules": [
            ("RN-HU008-01", "IA mediada", "Arquitetura", "N/A", "N/A", "Sim", "UI nunca chama provedor de IA diretamente."),
            ("RN-HU008-02", "Limite medico", "Compliance", "N/A", "N/A", "Sim", "IA nao diagnostica nem prescreve."),
        ],
        "data": "ai.ai_conversation, ai.ai_message, ai.ai_recommendation, ai.ai_audit_trail",
        "apis": "POST /v1/ai/chat",
    },
    {
        "id": "HU_009",
        "prd": "PRD-F009",
        "priority": "Should",
        "title": "Registrar exames e biomarcadores com graficos longitudinais",
        "actor": "usuario Phoenix",
        "want": "registrar exames e biomarcadores ao longo do tempo",
        "benefit": "acompanhar tendencias informativas e preparar conversas com profissionais de saude",
        "description": "Modulo PMI para entrada de biomarcadores, documentos de exame, fonte, unidade, faixa de referencia e visualizacao longitudinal.",
        "screen": "Phoenix Medical Timeline",
        "components": [
            ("1", "Formulario de biomarcador", "Registra valor, unidade e data."),
            ("2", "Upload de exame", "Anexa documento ao historico."),
            ("3", "Grafico longitudinal", "Mostra tendencia por biomarcador."),
        ],
        "fields": [
            ("1", "Biomarcador", "Texto", "Codigo/nome", "100", "Sim", "Ex.: glicose, LDL, HDL."),
            ("2", "Valor", "Numero", "Decimal", "N/A", "Sim", "Validar unidade."),
            ("3", "Unidade", "Texto", "Livre/lista", "30", "Sim", "Obrigatoria para interpretacao."),
            ("4", "Data de coleta", "Data", "yyyy-mm-dd", "10", "Sim", "Base da serie historica."),
            ("5", "Consentimento", "UUID", "UUID", "36", "Sim", "Obrigatorio para dado sensivel."),
        ],
        "criteria": [
            ("1", "o usuario possui consentimento valido", "registra biomarcador", "o sistema salva resultado e atualiza grafico."),
            ("2", "o consentimento esta ausente ou revogado", "tenta salvar exame", "o sistema bloqueia e solicita consentimento apropriado."),
            ("3", "existem multiplos resultados", "o usuario abre biomarcador", "o sistema exibe grafico longitudinal e tendencia informativa."),
            ("4", "um valor sugere risco critico", "o resultado e processado", "o sistema orienta procurar profissional sem diagnosticar."),
        ],
        "rules": [
            ("RN-HU009-01", "Dado sensivel", "LGPD", "N/A", "N/A", "Sim", "Exames e biomarcadores exigem protecao reforcada."),
            ("RN-HU009-02", "Sem diagnostico", "Medical", "N/A", "N/A", "Sim", "Exibir informacao, fonte e limite educacional."),
        ],
        "data": "medical.biomarker_result, medical.lab_panel, medical.lab_result_document, medical.health_trend",
        "apis": "POST /v1/medical/lab-results",
    },
    {
        "id": "HU_010",
        "prd": "PRD-F010",
        "priority": "Should",
        "title": "Emitir relatorio para usuario ou profissional autorizado",
        "actor": "usuario Phoenix",
        "want": "gerar e compartilhar relatorio com dados de progresso, treino, nutricao e medical",
        "benefit": "acompanhar evolucao e discutir informacoes com profissional autorizado quando eu consentir",
        "description": "Relatorio executivo exportavel com escopo selecionavel, consentimento, expiracao e trilha de auditoria.",
        "screen": "Exportacao de Relatorio",
        "components": [
            ("1", "Seletor de escopo", "Define secoes do relatorio."),
            ("2", "Gerador PDF/HTML", "Monta relatorio legivel."),
            ("3", "Share link seguro", "Cria link expiravel e auditado."),
        ],
        "fields": [
            ("1", "Periodo", "Filtro", "Data", "N/A", "Sim", "Define janela do relatorio."),
            ("2", "Escopo", "Selecao multipla", "Lista", "N/A", "Sim", "Treino, nutricao, medical, gamificacao."),
            ("3", "Destinatario", "Email/texto", "Email", "120", "Nao", "Obrigatorio para compartilhamento direto."),
            ("4", "Expiracao", "Data/hora", "ISO 8601", "N/A", "Sim", "Links devem expirar."),
        ],
        "criteria": [
            ("1", "o usuario seleciona periodo e escopo", "gera relatorio", "o sistema cria PDF/HTML com dados permitidos."),
            ("2", "o escopo inclui dados medicos", "o usuario confirma compartilhamento", "o sistema exige consentimento explicito e registra auditoria."),
            ("3", "um link expirado e acessado", "o destinatario abre a URL", "o sistema nega acesso."),
            ("4", "um profissional autorizado acessa relatorio", "a pagina carrega", "o sistema registra acesso com finalidade."),
        ],
        "rules": [
            ("RN-HU010-01", "Link expiravel", "Seguranca", "N/A", "N/A", "Sim", "Todo link externo deve ter expiracao."),
            ("RN-HU010-02", "Escopo minimo", "Privacidade", "N/A", "N/A", "Sim", "Exportar somente secoes selecionadas."),
        ],
        "data": "war_room.report, war_room.report_export, medical.provider_share_link, security.audit_log",
        "apis": "POST /v1/medical/reports/{reportId}/share-links",
    },
    {
        "id": "HU_011",
        "prd": "PRD-F011",
        "priority": "Should",
        "title": "Gerenciar assinaturas, trial, planos e entitlements",
        "actor": "usuario, gestor de academia ou administrador",
        "want": "contratar, alterar ou cancelar planos e controlar funcionalidades liberadas",
        "benefit": "usar o Phoenix conforme meu plano comercial e manter a monetizacao SaaS consistente",
        "description": "Fluxo de checkout, planos, trial, webhooks de pagamento e entitlements por usuario, academia ou tenant.",
        "screen": "Billing e Planos",
        "components": [
            ("1", "Tabela de planos", "Exibe Free, Individual, Pro, Coach e Enterprise."),
            ("2", "Checkout", "Redireciona para provedor de pagamento."),
            ("3", "Entitlement resolver", "Controla acesso por feature."),
        ],
        "fields": [
            ("1", "Plano", "Selecao", "Lista", "N/A", "Sim", "Define entitlements."),
            ("2", "Tenant", "UUID", "UUID", "36", "Sim", "Necessario para B2B."),
            ("3", "Status de assinatura", "Calculado", "Texto", "N/A", "Sim", "trial, active, past_due, cancelled."),
        ],
        "criteria": [
            ("1", "o usuario escolhe um plano", "inicia checkout", "o sistema cria sessao de pagamento."),
            ("2", "o webhook confirma pagamento", "o billing processa evento", "o entitlement e ativado de forma idempotente."),
            ("3", "a assinatura vence ou falha", "o usuario acessa feature paga", "o sistema restringe acesso conforme politica."),
            ("4", "um gestor B2B contrata plano Coach", "a assinatura e ativada", "o sistema libera recursos de academia/coorte."),
        ],
        "rules": [
            ("RN-HU011-01", "Webhook idempotente", "Billing", "N/A", "N/A", "Sim", "Eventos repetidos nao podem duplicar cobrancas ou entitlements."),
            ("RN-HU011-02", "Acesso por entitlement", "Produto", "N/A", "N/A", "Sim", "Feature paga sempre consulta entitlement vigente."),
        ],
        "data": "billing.subscription, billing.entitlement, billing.invoice, billing.payment_intent",
        "apis": "POST /v1/billing/checkout",
    },
    {
        "id": "HU_012",
        "prd": "PRD-F012",
        "priority": "Must",
        "title": "Expor APIs REST e GraphQL para web, mobile e admin",
        "actor": "desenvolvedor ou integrador autorizado",
        "want": "consumir contratos REST e GraphQL documentados e versionados",
        "benefit": "integrar web, mobile, admin, academias e automacoes com seguranca e previsibilidade",
        "description": "Define contratos de API com OpenAPI 3.1.1 e GraphQL, cobrindo autenticação, erros, permissoes, rate limit e versionamento.",
        "screen": "Documentacao de WebServices",
        "components": [
            ("1", "OpenAPI", "Contrato REST versionado."),
            ("2", "GraphQL Schema", "Contrato para queries, mutations e subscriptions."),
            ("3", "API Gateway", "Autenticacao, rate limit e auditoria."),
        ],
        "fields": [
            ("1", "Authorization", "Header", "Bearer JWT", "N/A", "Sim", "Obrigatorio em endpoints protegidos."),
            ("2", "Request ID", "Header", "UUID", "36", "Sim", "Rastreabilidade."),
            ("3", "Version", "Path/header", "v1", "N/A", "Sim", "Contrato versionado."),
        ],
        "criteria": [
            ("1", "um cliente autenticado chama endpoint documentado", "a requisicao e valida", "o sistema retorna resposta conforme OpenAPI."),
            ("2", "a requisicao viola schema", "a API valida entrada", "o sistema retorna erro padronizado."),
            ("3", "um usuario tenta acessar objeto de outro tenant", "a autorizacao e avaliada", "o sistema nega acesso e audita."),
            ("4", "o contrato e alterado", "a mudanca entra em PR", "documentos OpenAPI/GraphQL e testes de contrato sao atualizados."),
        ],
        "rules": [
            ("RN-HU012-01", "Contrato antes de codigo", "Engenharia", "N/A", "N/A", "Sim", "Mudancas externas exigem contrato atualizado."),
            ("RN-HU012-02", "Autorizacao por objeto", "Seguranca", "N/A", "N/A", "Sim", "Nao basta validar papel; validar posse/finalidade."),
        ],
        "data": "integrations.api_client, security.access_log, security.rate_limit_bucket",
        "apis": "docs/05-api/openapi.yaml, docs/05-api/graphql-schema.graphql",
    },
    {
        "id": "HU_013",
        "prd": "PRD-F013",
        "priority": "Must",
        "title": "Cadastrar academias, unidades, planos B2B, equipe, alunos e cohortes",
        "actor": "gestor de academia",
        "want": "cadastrar minha academia, unidades, planos, equipe, alunos e cohortes",
        "benefit": "operar o Phoenix como plataforma digital B2B/B2B2C da academia",
        "description": "Provisionamento de tenant de academia com estrutura B2B, permissoes, unidades, staff, convites e cohortes.",
        "screen": "Gym Portal - Cadastro",
        "components": [
            ("1", "Cadastro de academia", "Registra organizacao, marca e contrato."),
            ("2", "Gestao de unidades", "Mantem locais e horarios."),
            ("3", "Convite de alunos e staff", "Cria vinculos e permissoes."),
        ],
        "fields": [
            ("1", "Nome da academia", "Texto", "Livre", "120", "Sim", "Obrigatorio."),
            ("2", "Unidade", "Texto", "Livre", "120", "Sim", "Ao menos uma unidade ativa."),
            ("3", "Papel do staff", "Selecao", "Lista", "N/A", "Sim", "coach, nutritionist, manager, admin."),
            ("4", "Email do aluno", "Texto", "Email", "120", "Sim", "Usado para convite."),
        ],
        "criteria": [
            ("1", "um gestor autorizado informa dados validos", "salva academia", "o sistema cria tenant B2B, unidade e contrato inicial."),
            ("2", "o gestor convida staff", "o convite e aceito", "o sistema atribui papel e permissoes por unidade."),
            ("3", "o gestor convida aluno", "o aluno aceita", "o sistema cria enrollment e solicita consentimentos."),
            ("4", "o gestor cria coorte", "seleciona alunos elegiveis", "o sistema vincula alunos ao grupo sem duplicidade."),
        ],
        "rules": [
            ("RN-HU013-01", "Tenant B2B", "Arquitetura", "N/A", "N/A", "Sim", "Toda academia opera como tenant ou subtenant isolado."),
            ("RN-HU013-02", "Consentimento do aluno", "LGPD", "N/A", "N/A", "Sim", "Aluno precisa aceitar compartilhamento com academia/staff."),
        ],
        "data": "gym.gym_organization, gym.gym_facility, gym.gym_member_enrollment, gym.gym_staff_permission",
        "apis": "GET /v1/gyms/current, POST /v1/gyms/{gymId}/members",
    },
    {
        "id": "HU_014",
        "prd": "PRD-F014",
        "priority": "Must",
        "title": "Acompanhar adesao, risco de churn, progresso e relatorios de alunos",
        "actor": "gestor, coach ou staff autorizado de academia",
        "want": "acompanhar alunos por adesao, risco de churn, progresso e relatorios permitidos",
        "benefit": "intervir no momento certo e aumentar retencao e resultado dos alunos",
        "description": "Painel B2B para acompanhamento de cohortes e alunos, com permissao por unidade, minimizacao e alertas operacionais.",
        "screen": "Gym Dashboard",
        "components": [
            ("1", "Lista de alunos", "Exibe status, fase, adesao e risco."),
            ("2", "Filtro de coorte/unidade", "Segmenta visualizacao autorizada."),
            ("3", "Painel de intervencao", "Prioriza alunos com risco ou alerta."),
        ],
        "fields": [
            ("1", "Coorte", "Filtro", "UUID", "36", "Nao", "Limita alunos exibidos."),
            ("2", "Risco de churn", "Calculado", "Baixo/medio/alto", "N/A", "Sim", "Derivado de adesao e engajamento."),
            ("3", "Relatorio", "Acao", "Link", "N/A", "Nao", "Disponivel por consentimento."),
        ],
        "criteria": [
            ("1", "staff autorizado acessa dashboard", "seleciona unidade/coorte", "o sistema lista apenas alunos permitidos."),
            ("2", "um aluno apresenta baixa adesao", "o motor processa metricas", "o aluno aparece como prioridade de acompanhamento."),
            ("3", "o staff tenta abrir relatorio sem consentimento", "solicita acesso", "o sistema bloqueia e orienta solicitar consentimento."),
            ("4", "o gestor exporta visao agregada", "a exportacao e gerada", "o sistema minimiza dados pessoais e registra auditoria."),
        ],
        "rules": [
            ("RN-HU014-01", "Finalidade B2B", "Privacidade", "N/A", "N/A", "Sim", "Staff so acessa dados necessarios ao acompanhamento contratado."),
            ("RN-HU014-02", "Risco explicavel", "Analytics", "N/A", "N/A", "Sim", "Churn risk deve exibir sinais usados no calculo."),
        ],
        "data": "gym.gym_dashboard, gym.gym_churn_risk, gym.gym_member_retention_signal, war_room.report",
        "apis": "GET /v1/gyms/{gymId}/members, GraphQL gymMembers",
    },
    {
        "id": "HU_015",
        "prd": "PRD-F015",
        "priority": "Must",
        "title": "Oferecer Phoenix Nutrition System",
        "actor": "usuario ou aluno de academia",
        "want": "selecionar e seguir protocolos Nutrition Foundation, Recomp, Hypertrophy, Cut e Peak",
        "benefit": "alinhar alimentacao ao objetivo, treino, recuperacao e seguranca",
        "description": "Modulo de nutricao progressiva com protocolos oficiais, meal prep, matriz de substituicao, supplement intelligence, medical integration e relatorios.",
        "screen": "Phoenix Nutrition System",
        "components": [
            ("1", "Seletor de protocolo", "Escolhe Foundation, Recomp, Hypertrophy, Cut ou Peak."),
            ("2", "Plano alimentar", "Exibe macros, refeicoes e substituicoes."),
            ("3", "Safety boundary", "Impede estrategias perigosas."),
        ],
        "fields": [
            ("1", "Protocolo", "Selecao", "Lista", "N/A", "Sim", "Foundation, Recomp, Hypertrophy, Cut, Peak."),
            ("2", "Objetivo", "Selecao", "Lista", "N/A", "Sim", "Recomposicao, hipertrofia, definicao etc."),
            ("3", "Restricoes", "Texto/lista", "Livre", "500", "Nao", "Pode exigir revisao profissional."),
        ],
        "criteria": [
            ("1", "o usuario informa objetivo e medidas", "solicita plano nutricional", "o sistema sugere protocolo compativel."),
            ("2", "o usuario seleciona Hypertrophy", "o plano e gerado", "o sistema usa superavit leve e revisao a cada 14 dias."),
            ("3", "o usuario seleciona Peak", "o sistema avalia safety boundary", "o sistema nao permite desidratacao extrema, diureticos ou manipulacao severa de sodio."),
            ("4", "ha condicao clinica ou medicamento", "o plano e solicitado", "o sistema marca revisao profissional como necessaria."),
        ],
        "rules": [
            ("RN-HU015-01", "Sistema educacional", "Compliance", "N/A", "N/A", "Sim", "Plano nao substitui nutricionista ou medico."),
            ("RN-HU015-02", "Protocolos oficiais", "Produto", "N/A", "N/A", "Sim", "Usar somente protocolos definidos pelo Phoenix Nutrition System."),
        ],
        "data": "nutrition.nutrition_protocol, nutrition.nutrition_phase, nutrition.meal_plan, nutrition.food_replacement_matrix",
        "apis": "GET /v1/nutrition/protocols, POST /v1/nutrition/plans/current",
    },
    {
        "id": "HU_016",
        "prd": "PRD-F016",
        "priority": "Must",
        "title": "Calcular Phoenix Nutrition Score",
        "actor": "usuario ou aluno de academia",
        "want": "calcular meu Nutrition Score por proteina, hidratacao, vegetais, refeicoes, treino, sono, digestao e controle alimentar",
        "benefit": "entender a qualidade da aderencia nutricional e receber operacao de correcao quando necessario",
        "description": "Pontuacao de 0 a 100 com faixas Ouro, Prata, Bronze e Operacao de Correcao, baseada nos componentes oficiais do Phoenix Nutrition System.",
        "screen": "Nutrition Score",
        "components": [
            ("1", "Score calculator", "Soma componentes oficiais."),
            ("2", "Faixa de score", "Classifica em ouro, prata, bronze ou correcao."),
            ("3", "Plano de correcao", "Sugere foco da semana."),
        ],
        "fields": [
            ("1", "Proteina", "Numero", "0-20", "2", "Sim", "Peso 20."),
            ("2", "Hidratacao", "Numero", "0-15", "2", "Sim", "Peso 15."),
            ("3", "Frutas e vegetais", "Numero", "0-15", "2", "Sim", "Peso 15."),
            ("4", "Refeicoes planejadas", "Numero", "0-15", "2", "Sim", "Peso 15."),
            ("5", "Alinhamento com treino", "Numero", "0-15", "2", "Sim", "Peso 15."),
            ("6", "Sono", "Numero", "0-10", "2", "Sim", "Peso 10."),
            ("7", "Digestao", "Numero", "0-5", "1", "Sim", "Peso 5."),
            ("8", "Alcool e ultraprocessados", "Numero", "0-5", "1", "Sim", "Peso 5."),
        ],
        "criteria": [
            ("1", "todos os componentes sao informados", "o check-in e salvo", "o sistema calcula score de 0 a 100."),
            ("2", "o score fica entre 85 e 100", "a faixa e calculada", "o sistema classifica como Ouro."),
            ("3", "o score fica abaixo de 55", "a faixa e calculada", "o sistema cria operacao de correcao."),
            ("4", "um componente tem valor fora do peso permitido", "o usuario salva", "o sistema rejeita o valor e orienta correcao."),
        ],
        "rules": [
            ("RN-HU016-01", "Pesos oficiais", "Nutricao", "N/A", "N/A", "Sim", "Soma dos componentes deve totalizar 100."),
            ("RN-HU016-02", "Faixas oficiais", "Produto", "N/A", "N/A", "Sim", "85-100 Ouro, 70-84 Prata, 55-69 Bronze, abaixo de 55 correcao."),
        ],
        "data": "nutrition.nutrition_score, nutrition.nutrition_score_component, nutrition.nutrition_check_in",
        "apis": "POST /v1/nutrition/check-ins",
    },
    {
        "id": "HU_017",
        "prd": "PRD-F017",
        "priority": "Must",
        "title": "Realizar revisoes nutricionais de 14, 30, 60 e 90 dias",
        "actor": "usuario, aluno de academia ou nutricionista parceiro",
        "want": "revisar meu plano nutricional por peso, cintura, forca, sono, humor e score",
        "benefit": "ajustar carboidratos, deficit ou superavit de forma gradual e segura",
        "description": "Motor de revisao nutricional com decisao de manter, adicionar carboidratos, reduzir carboidratos/gordura ou fazer semana de manutencao.",
        "screen": "Revisao Nutricional",
        "components": [
            ("1", "Formulario de revisao", "Coleta tendencias do periodo."),
            ("2", "Motor de ajuste", "Aplica regras de 14 dias."),
            ("3", "Resumo de decisao", "Explica ajuste e limites."),
        ],
        "fields": [
            ("1", "Periodo", "Selecao", "14/30/60/90", "2", "Sim", "Marcos oficiais."),
            ("2", "Tendencia de peso", "Selecao", "Lista", "N/A", "Sim", "down, stable, slow_up, fast_up."),
            ("3", "Tendencia de cintura", "Selecao", "Lista", "N/A", "Sim", "Indicador critico em hipertrofia."),
            ("4", "Tendencia de forca", "Selecao", "Lista", "N/A", "Sim", "down, stable, up."),
            ("5", "Sono e humor", "Selecao", "Lista", "N/A", "Sim", "Ajusta deficit e recuperacao."),
        ],
        "criteria": [
            ("1", "peso sobe lentamente, forca melhora e cintura esta estavel", "a revisao e processada", "o sistema recomenda manter o plano."),
            ("2", "peso e desempenho estagnam por 2 semanas sem cintura subir", "a revisao e processada", "o sistema recomenda adicionar 25-40 g de carboidrato por dia."),
            ("3", "cintura sobe rapido sem ganho proporcional de forca", "a revisao e processada", "o sistema recomenda retirar 20-30 g de carboidrato ou pequena porcao de gordura."),
            ("4", "sono, humor e forca pioram durante definicao", "a revisao e processada", "o sistema recomenda reduzir deficit ou semana de manutencao."),
        ],
        "rules": [
            ("RN-HU017-01", "Ajuste gradual", "Nutricao", "N/A", "N/A", "Sim", "Nao permitir mudancas agressivas sem revisao profissional."),
            ("RN-HU017-02", "Cintura como freio", "Hypertrophy", "N/A", "N/A", "Sim", "Cintura nao deve subir na mesma velocidade do peso."),
        ],
        "data": "nutrition.fourteen_day_nutrition_review, nutrition.nutrition_adjustment_rule, nutrition.waist_velocity_signal",
        "apis": "POST /v1/nutrition/reviews",
    },
    {
        "id": "HU_018",
        "prd": "PRD-F018",
        "priority": "Must",
        "title": "Bloquear estrategias perigosas de fisiculturismo",
        "actor": "usuario, aluno de academia ou administrador",
        "want": "que o sistema bloqueie ou alerte estrategias perigosas de definicao e competicao",
        "benefit": "preservar saude, compliance e responsabilidade da plataforma",
        "description": "Policy transversal para bloquear desidratacao extrema, diureticos, manipulacao severa de sodio e outras condutas de alto risco.",
        "screen": "Safety Policy de Nutricao",
        "components": [
            ("1", "Policy engine", "Avalia solicitacoes e conteudos."),
            ("2", "Moderador de IA", "Bloqueia respostas perigosas."),
            ("3", "Registro de incidente", "Audita tentativa e decisao."),
        ],
        "fields": [
            ("1", "Tipo de estrategia", "Texto/lista", "Livre", "200", "Sim", "Desidratacao, diuretico, sodio, restricao extrema."),
            ("2", "Origem", "Selecao", "IA/conteudo/admin/usuario", "N/A", "Sim", "Canal da tentativa."),
            ("3", "Severidade", "Selecao", "Lista", "N/A", "Sim", "normal, caution, escalate."),
        ],
        "criteria": [
            ("1", "o usuario pede orientacao de diuretico", "a IA avalia a pergunta", "o sistema bloqueia a resposta e orienta profissional habilitado."),
            ("2", "um conteudo admin menciona desidratacao extrema como estrategia", "o editor tenta publicar", "o sistema bloqueia publicacao e exige revisao."),
            ("3", "a estrategia e classificada como perigosa", "o evento e processado", "o sistema registra auditoria e safety alert."),
            ("4", "o usuario pede alternativa segura", "a policy permite resposta", "o sistema sugere condutas educacionais e conservadoras."),
        ],
        "rules": [
            ("RN-HU018-01", "Proibicao de condutas perigosas", "Safety", "N/A", "N/A", "Sim", "Diureticos, desidratacao extrema e sodio severo nao fazem parte do sistema."),
            ("RN-HU018-02", "Auditoria de bloqueio", "Compliance", "N/A", "N/A", "Sim", "Todo bloqueio relevante deve ser registrado."),
        ],
        "data": "ai.ai_safety_guardrail, ai.ai_content_policy, security.security_event, content.safety_notice",
        "apis": "POST /v1/ai/chat, Admin content workflows",
    },
    {
        "id": "HU_019",
        "prd": "PRD-F019",
        "priority": "Should",
        "title": "Permitir revisao humana por nutricionista parceiro",
        "actor": "nutricionista parceiro",
        "want": "revisar planos e casos com condicao clinica, exame alterado, intolerancia, medicamento ou objetivo competitivo",
        "benefit": "garantir seguranca e personalizacao profissional quando o caso excede automacao informativa",
        "description": "Fila de revisao profissional com consentimento, contexto minimo, historico, parecer e separacao clara entre recomendacao informativa e prescricao profissional.",
        "screen": "Fila de Revisao Nutricional",
        "components": [
            ("1", "Fila de casos", "Lista alunos que exigem revisao."),
            ("2", "Painel de contexto", "Mostra dados consentidos e necessarios."),
            ("3", "Registro de parecer", "Armazena revisao profissional."),
        ],
        "fields": [
            ("1", "Motivo da revisao", "Selecao", "Lista", "N/A", "Sim", "Exame, medicamento, intolerancia, condicao clinica, competicao."),
            ("2", "Consentimento", "UUID", "UUID", "36", "Sim", "Necessario para acesso profissional."),
            ("3", "Parecer", "Texto", "Livre", "5000", "Sim", "Registrado com autor e data."),
        ],
        "criteria": [
            ("1", "o plano indica condicao clinica ou medicamento", "a triagem e executada", "o sistema encaminha para fila de revisao."),
            ("2", "o nutricionista abre um caso sem consentimento valido", "tenta visualizar detalhes", "o sistema bloqueia acesso."),
            ("3", "o nutricionista registra parecer", "salva revisao", "o sistema atualiza status, auditoria e notifica usuario."),
            ("4", "o caso exige medico", "o nutricionista marca escalonamento", "o sistema orienta atendimento medico e limita automacoes."),
        ],
        "rules": [
            ("RN-HU019-01", "Acesso por finalidade", "LGPD", "N/A", "N/A", "Sim", "Profissional acessa apenas dados consentidos e necessarios."),
            ("RN-HU019-02", "Responsabilidade profissional", "Operacao", "N/A", "N/A", "Sim", "Parecer deve registrar autor, registro profissional quando aplicavel e data."),
        ],
        "data": "nutrition.nutritionist_review, medical.medical_consent, gym.gym_nutritionist_assignment, security.audit_log",
        "apis": "Nutrition review workflows, GET /v1/gyms/current",
    },
    {
        "id": "HU_020",
        "prd": "PRD-F020",
        "priority": "Should",
        "title": "Sincronizar treino de academia com carb cycling e refeicoes",
        "actor": "aluno de academia",
        "want": "sincronizar meu treino de musculacao, hipertrofia e condicionamento com carb cycling e refeicoes pre e pos-treino",
        "benefit": "alimentar o treino certo no dia certo, construir massa magra e controlar gordura",
        "description": "Integra agenda de treino, foco do dia e protocolo nutricional para ajustar carboidratos, refeicoes e timing alimentar.",
        "screen": "Treino e Nutricao do Dia",
        "components": [
            ("1", "Calendario de treino", "Identifica foco do dia."),
            ("2", "Carb cycling engine", "Define nivel de carboidrato por tipo de treino."),
            ("3", "Meal timing", "Sugere pre e pos-treino alinhados ao sono e digestao."),
        ],
        "fields": [
            ("1", "Tipo de treino", "Selecao", "Lista", "N/A", "Sim", "Pernas, full body, Muay Thai, empurrar, puxar, descanso."),
            ("2", "Nivel de carboidrato", "Calculado", "Baixo/moderado/alto", "N/A", "Sim", "Derivado do treino."),
            ("3", "Refeicao pre-treino", "Texto/lista", "Livre", "500", "Nao", "Ex.: banana com aveia e proteina leve."),
            ("4", "Refeicao pos-treino", "Texto/lista", "Livre", "500", "Nao", "Ex.: proteina + arroz/macarrao sem gluten + legumes."),
        ],
        "criteria": [
            ("1", "o treino do dia e pernas ou full body forca", "o plano nutricional e exibido", "o sistema marca prioridade alta de carboidratos."),
            ("2", "o dia e descanso ativo", "o plano e exibido", "o sistema reduz carboidrato e prioriza feijao, vegetais e pequena porcao de arroz."),
            ("3", "o usuario relata cafe prejudicando sono", "o pre-treino e montado", "o sistema evita cafe como recomendacao padrao."),
            ("4", "o treino muda na agenda", "o plano do dia e recalculado", "carb cycling e refeicoes refletem o novo foco."),
        ],
        "rules": [
            ("RN-HU020-01", "Carb cycling por treino", "Nutricao", "N/A", "N/A", "Sim", "Pernas, full body e desafio militar recebem prioridade alta de carboidratos."),
            ("RN-HU020-02", "Sono como restricao", "Recovery", "N/A", "N/A", "Sim", "Cafeina deve considerar impacto no sono."),
        ],
        "data": "nutrition.carb_cycling_rule, nutrition.pre_workout_meal, nutrition.post_workout_meal, gym.gym_bodybuilding_program",
        "apis": "GET /v1/nutrition/plans/current, GET /v1/programs/current",
    },
]


def render_story(story: dict[str, object]) -> str:
    criteria_rows = [
        "|_{background:#eeeeee; }.#|_{background:#eeeeee; }. DADO QUE|_{background:#eeeeee; }. QUANDO|_{background:#eeeeee; }. ENTÃO|"
    ]
    for number, dado, quando, entao in story["criteria"]:  # type: ignore[index]
        criteria_rows.append(table_row([f"=. {story['id']}.{number}", dado, quando, entao]))

    component_rows = [
        "|_{background:#eeeeee; }.ID|_{background:#eeeeee; }.Nome|_{background:#eeeeee; }.Descrição|"
    ]
    for row in story["components"]:  # type: ignore[index]
        component_rows.append(table_row(list(row)))

    field_rows = [
        "|_{background:#eeeeee; }.ID|_{background:#eeeeee; }.Nome|_{background:#eeeeee; }.Tipo|_{background:#eeeeee; }.Formato|_{background:#eeeeee; }.Tamanho|_{background:#eeeeee; }.Obrigatório|_{background:#eeeeee; }.Regra|"
    ]
    for row in story["fields"]:  # type: ignore[index]
        field_rows.append(table_row(list(row)))

    rule_rows = [
        "|_{background:#eeeeee; }.ID|_{background:#eeeeee; }.Nome|_{background:#eeeeee; }.Tipo|_{background:#eeeeee; }.Formato|_{background:#eeeeee; }.Tamanho|_{background:#eeeeee; }.Obrigatório|_{background:#eeeeee; }.Regra|"
    ]
    for row in story["rules"]:  # type: ignore[index]
        rule_rows.append(table_row(list(row)))

    lines = [
        f"h1. [{story['id']}] - {story['title']}",
        "",
        f"p. *SENDO* {story['actor']}.",
        f"*EU QUERO* {story['want']}.",
        f"*PARA* {story['benefit']}.",
        "",
        "h2. Descrição",
        "",
        str(story["description"]),
        "",
        "h2. Critérios de Aceitação",
        "",
        *criteria_rows,
        "",
        "h2. Protótipo de Tela",
        "",
        f"|_{{background:#eeeeee; }}. {story['screen']} |",
        "|Protótipo visual a ser produzido no Design System Phoenix. A implementação deve seguir os componentes e campos descritos nesta história, mantendo acessibilidade, responsividade, auditoria e limites de segurança aplicáveis.|",
        "",
        "h3. Componentes",
        "",
        *component_rows,
        "",
        "h3. Campos",
        "",
        *field_rows,
        "",
        "h3. Regra de negócios/Evidências de Banco de Dados",
        "",
        *rule_rows,
        "",
        "h2. Rastreabilidade",
        "",
        "|_{background:#eeeeee; }.Item|_{background:#eeeeee; }.Referência|",
        f"|Requisito funcional|{story['prd']}|",
        f"|Prioridade|{story['priority']}|",
        f"|Entidades principais|{story['data']}|",
        f"|APIs/Contratos|{story['apis']}|",
        "|Fonte funcional|docs/01-product/prd.md|",
    ]
    return "\n".join(lines).strip() + "\n"


def generate() -> None:
    STORY_DIR.mkdir(parents=True, exist_ok=True)
    for old_file in STORY_DIR.glob("HU_*.textile"):
        old_file.unlink()

    index_rows = [
        "# Histórias de Usuário - Phoenix Protocol",
        "",
        "Histórias geradas a partir de todos os requisitos funcionais `PRD-F001` a `PRD-F020`, seguindo a estrutura documental da Wiki do projeto.",
        "",
        "| ID | Requisito | Prioridade | História | Arquivo |",
        "|---|---|---|---|---|",
    ]

    for story in STORIES:
        filename = f"{story['id']}-{slug(story['title'])}.textile"
        (STORY_DIR / filename).write_text(render_story(story), encoding="utf-8")
        index_rows.append(
            f"| {story['id']} | {story['prd']} | {story['priority']} | {story['title']} | [Textile](Historias_Usuario/{filename}) |"
        )

    INDEX_PATH.write_text("\n".join(index_rows) + "\n", encoding="utf-8")


if __name__ == "__main__":
    generate()
    print(f"Generated {len(STORIES)} user stories in {STORY_DIR}")
