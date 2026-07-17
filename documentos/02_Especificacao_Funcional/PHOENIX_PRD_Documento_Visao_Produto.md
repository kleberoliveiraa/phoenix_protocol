# PRD - Phoenix Protocol(R) Performance Operating System

        ## Visao

        Construir uma plataforma SaaS de alta performance humana que transforme o programa Phoenix Protocol(R) de 90 dias em um sistema digital integrado para treino, recuperacao, nutricao, mentalidade, espiritualidade opcional, IA, acompanhamento medico informativo, gamificacao e dashboards executivos.

        ## Problema

        Programas de transformacao fisica falham por falta de continuidade, medicao, adaptacao, seguranca articular e feedback contextual. O Phoenix Protocol(R) resolve isso combinando plano estruturado, registro diario, indicadores, inteligencia de IA e governanca de dados.

        ## Publico

        - Usuario principal: adulto 35-45 anos que busca recomposicao corporal, forca relativa, disciplina e condicionamento com preservacao articular.
        - Usuario avancado: praticante que quer evoluir por fases, desafios e metricas.
        - Aluno de academia: praticante que treina musculacao, hipertrofia ou definicao e precisa alinhar treino, dieta, medidas e recuperacao.
        - Gestor de academia: operador B2B que quer aumentar retencao, acompanhamento, upsell e experiencia digital dos alunos.
        - Personal trainer/coach de academia: profissional que prescreve, acompanha cohortes, revisa execucao e ajusta volume/intensidade.
        - Nutricionista parceiro: profissional que revisa planos, restricoes, exames e ajustes nutricionais quando houver atendimento individual.
        - Administrador/coach: profissional ou operador que acompanha cohortes, conteudo e seguranca.
        - Parceiro de saude: profissional externo que pode receber relatorios quando o usuario consentir.

        ## Modulos do produto

        - Foundation Intelligence
- Body Performance
- Combat Conditioning
- Recovery System
- Nutrition Intelligence
- Mental Performance
- Spiritual Development
- AI Command Center
- War Room Dashboard
- Phoenix Legacy
- Phoenix Medical Intelligence

        ## MVP

        - Onboarding, anamnese e termo de responsabilidade.
        - Diario de 90 dias com treino, agua, sono, humor, RPE e observacoes.
        - Plano de treino por fases, deloads e desafios.
        - Avaliacoes Dia 0, 30, 60 e 90.
        - Dashboard War Room com adesao, peso, cintura, sono, humor e risco.
        - AI Command Center com coach informativo e limites de seguranca.
        - Phoenix Medical Intelligence v1: exames, lembretes, graficos e relatorios informativos.
        - Phoenix Nutrition System v1: protocolos Foundation, Recomp, Hypertrophy, Cut e Peak; score nutricional; meal prep; matriz de substituicao; ajustes a cada 14 dias.
        - Gym Performance Network v1: academias como tenants, unidades, alunos, coaches, nutricionistas, cohortes e dashboard de retencao.
        - Gamificacao com XP, patentes, badges e certificados.
        - Admin para usuarios, conteudo, planos, auditoria e suporte.

        ## Requisitos funcionais

        | ID | Requisito | Prioridade |
        |---|---|---|
        | PRD-F001 | Registrar onboarding, prontidao, metas e consentimentos. | Must |
        | PRD-F002 | Gerar plano de 90 dias com fases, treinos, RPE e deloads. | Must |
        | PRD-F003 | Permitir registro diario em menos de 2 minutos. | Must |
        | PRD-F004 | Calcular adesao semanal, medias e tendencias automaticamente. | Must |
        | PRD-F005 | Registrar testes fisicos e antropometria nos marcos do programa. | Must |
        | PRD-F006 | Detectar sinais de dor articular e recomendar regressao ou pausa. | Must |
        | PRD-F007 | Exibir dashboard por usuario e por cohortes. | Must |
        | PRD-F008 | Disponibilizar IA conversacional com historico e fontes internas. | Should |
        | PRD-F009 | Registrar exames e biomarcadores com graficos longitudinais. | Should |
        | PRD-F010 | Emitir relatorio PDF/HTML para usuario ou profissional autorizado. | Should |
        | PRD-F011 | Gerenciar assinaturas SaaS, trial, planos e entitlements. | Should |
        | PRD-F012 | Expor API REST e GraphQL para web/mobile/admin. | Must |
        | PRD-F013 | Cadastrar academias, unidades, planos B2B, equipe, alunos e cohortes. | Must |
        | PRD-F014 | Permitir que academias acompanhem adesao, risco de churn, progresso e relatorios de alunos com permissoes adequadas. | Must |
        | PRD-F015 | Oferecer Phoenix Nutrition System com protocolos Foundation, Recomp, Hypertrophy, Cut e Peak. | Must |
        | PRD-F016 | Calcular Phoenix Nutrition Score por proteina, hidratacao, frutas/vegetais, refeicoes planejadas, alinhamento ao treino, sono, digestao e controle de alcool/ultraprocessados. | Must |
        | PRD-F017 | Realizar revisoes nutricionais de 14, 30, 60 e 90 dias com ajustes graduais de carboidratos, deficit/superavit e alertas de cintura/forca/sono. | Must |
        | PRD-F018 | Bloquear ou alertar estrategias perigosas de fisiculturismo como desidratacao extrema, diureticos e manipulacao severa de sodio. | Must |
        | PRD-F019 | Permitir revisao humana por nutricionista parceiro quando houver condicao clinica, exame alterado, intolerancia, medicamento ou objetivo competitivo. | Should |
        | PRD-F020 | Sincronizar treino de academia, musculacao, hipertrofia e condicionamento com carb cycling, refeicoes pre/pós-treino e recuperacao. | Should |

        ## Historias de usuario

        | ID | Historia | Criterios de aceite |
        |---|---|---|
        | US-GYM-001 | Como gestor de academia, quero cadastrar minha unidade, equipe e alunos para operar o Phoenix como programa digital da academia. | Tenant B2B criado, unidade ativa, papeis configurados, convites enviados e auditoria registrada. |
        | US-GYM-002 | Como personal trainer, quero ver alunos por coorte, fase, adesao e risco para priorizar intervencoes. | Dashboard filtra por unidade/coorte e mostra adesao, RPE, dor, sono, peso, cintura, score nutricional e alertas. |
        | US-GYM-003 | Como aluno de academia, quero receber um plano de hipertrofia ou definicao alinhado ao meu treino para evoluir sem ganhar gordura de forma descontrolada. | Plano seleciona protocolo nutricional, macros, refeicoes e revisao de 14 dias com base em objetivo, medidas, treino e sono. |
        | US-GYM-004 | Como nutricionista parceiro, quero revisar casos com exames, intolerancias ou medicamentos antes de ajustes avancados. | Casos sensiveis entram em fila de revisao, com consentimento, historico e recomendacoes informativas separadas de prescricao. |
        | US-GYM-005 | Como aluno em fase Hypertrophy, quero saber quando aumentar ou reduzir carboidratos para ganhar massa com cintura controlada. | Sistema aplica regras de 14 dias: manter, adicionar 25-40 g carbo/dia, retirar 20-30 g ou reduzir deficit conforme sinais. |
        | US-GYM-006 | Como administrador, quero impedir conteudos de desidratacao extrema, diureticos ou manipulacao severa de sodio. | Policy de conteudo e IA bloqueia sugestoes perigosas, registra evento e mostra alternativa segura. |

        ## Requisitos nao funcionais

        - Disponibilidade alvo MVP: 99,5%; versao enterprise: 99,9%.
        - Tempo de resposta p95 API: ate 500 ms para operacoes comuns.
        - Criptografia em transito e repouso para dados pessoais e sensiveis.
        - Auditoria obrigatoria para acesso a dados de saude, consentimento, exports e acoes admin.
        - Multi-tenant desde o primeiro release.
        - Acessibilidade WCAG 2.2 AA como meta de design.
        - Observabilidade por tenant, modulo, endpoint e fluxo critico.
        - Isolamento B2B por academia/unidade/coorte, com permissoes por papel e finalidade.
        - Recomendacoes nutricionais sempre rastreaveis a objetivo, medidas, treino, sono, restricoes e consentimento.

        ## Metricas de sucesso

        - Ativacao: usuario completa onboarding e Dia 1.
        - Adesao: percentual de dias registrados por semana.
        - Retencao: D7, D30, D60, D90 e continuidade pos-programa.
        - Performance: evolucao de testes, medidas e consistencia de sono/agua.
        - Seguranca: incidentes, falsos positivos de risco, escalonamentos e revisoes.
        - Receita: conversao trial, churn, ARPA, LTV/CAC e expansao.
        - Academias: ativacao por unidade, alunos ativos, retencao, churn evitado, cohortes com progresso e upsell Pro/Coach.
        - Nutricao: Nutrition Score medio, revisoes de 14 dias completas, aderencia a proteina/hidratacao, cintura controlada em hipertrofia e alertas evitados.

        ## Fora de escopo inicial

        - Diagnostico medico automatizado.
        - Prescricao clinica ou terapeutica sem profissional habilitado.
        - Sparring, combate com contato ou recomendacoes de luta competitiva.
        - Marketplace aberto de coaches antes de governanca, contratos e compliance.
        - Preparacao competitiva agressiva com desidratacao, diureticos, manipulacao severa de sodio ou condutas clinicas sem profissional habilitado.
