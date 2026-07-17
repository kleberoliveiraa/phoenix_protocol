from __future__ import annotations

import csv
import re
import shutil
import textwrap
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


def clean(text: str) -> str:
    return textwrap.dedent(text).strip() + "\n"


def write(path: str, content: str) -> None:
    target = ROOT / path
    target.parent.mkdir(parents=True, exist_ok=True)
    target.write_text(clean(content), encoding="utf-8")


def slug(value: str) -> str:
    value = re.sub(r"(.)([A-Z][a-z]+)", r"\1_\2", value)
    value = re.sub(r"([a-z0-9])([A-Z])", r"\1_\2", value)
    value = value.lower()
    value = (
        value.replace("ã", "a")
        .replace("á", "a")
        .replace("à", "a")
        .replace("â", "a")
        .replace("é", "e")
        .replace("ê", "e")
        .replace("í", "i")
        .replace("ó", "o")
        .replace("ô", "o")
        .replace("õ", "o")
        .replace("ú", "u")
        .replace("ç", "c")
    )
    value = re.sub(r"[^a-z0-9]+", "_", value).strip("_")
    return value


MODULES = [
    "Foundation Intelligence",
    "Body Performance",
    "Combat Conditioning",
    "Recovery System",
    "Nutrition Intelligence",
    "Mental Performance",
    "Spiritual Development",
    "AI Command Center",
    "War Room Dashboard",
    "Phoenix Legacy",
    "Phoenix Medical Intelligence",
]


DOMAINS: dict[str, list[str]] = {
    "identity": [
        "Organization",
        "Tenant",
        "TenantDomain",
        "UserAccount",
        "UserProfile",
        "UserPreference",
        "UserDevice",
        "Role",
        "Permission",
        "RolePermission",
        "Membership",
        "Invitation",
        "Session",
        "RefreshToken",
        "IdentityProvider",
        "MfaFactor",
        "ConsentRecord",
        "PrivacyPreference",
        "DataSubjectRequest",
        "OnboardingJourney",
        "OnboardingAnswer",
        "ReadinessScreening",
        "Goal",
        "GoalMilestone",
        "BaselineProfile",
        "RiskFlag",
        "CoachAssignment",
        "HouseholdLink",
        "LocalePreference",
        "AccessibilityPreference",
    ],
    "body": [
        "MovementPattern",
        "Exercise",
        "ExerciseLevel",
        "ExerciseRegression",
        "ExerciseProgression",
        "ExerciseCue",
        "ExerciseContraindication",
        "WorkoutTemplate",
        "WorkoutBlock",
        "WorkoutExercise",
        "WorkoutSession",
        "WorkoutSet",
        "RepRecord",
        "TimeRecord",
        "RpeRecord",
        "TrainingDay",
        "TrainingWeek",
        "TrainingPhase",
        "DeloadRule",
        "GraduationCriterion",
        "PhysicalAssessment",
        "StrengthTest",
        "EnduranceTest",
        "MobilityTest",
        "AnthropometryRecord",
        "BodyMeasurement",
        "ProgressPhoto",
        "BodyCompositionEstimate",
        "PersonalRecord",
        "AdaptationRule",
        "JointLoadProfile",
        "EquipmentRequirement",
        "WarmupProtocol",
        "CooldownProtocol",
        "MilitaryChallengeResult",
    ],
    "combat": [
        "CombatSkill",
        "Technique",
        "Strike",
        "Combination",
        "FootworkPattern",
        "ShadowboxingSession",
        "Round",
        "RoundInterval",
        "JumpRopeSession",
        "JumpRopeMetric",
        "ConditioningCircuit",
        "CircuitStation",
        "CircuitResult",
        "MarchSession",
        "LoadCarryRecord",
        "Zone2Session",
        "HiitSession",
        "MuayThaiLesson",
        "TechniqueAssessment",
        "SafetyRestriction",
        "NoContactPolicy",
        "CombatProgressionRule",
        "TechnicalDrill",
        "BreathingCadence",
    ],
    "recovery": [
        "RecoveryPlan",
        "SleepRecord",
        "SleepStageSummary",
        "ReadinessScore",
        "SorenessReport",
        "PainReport",
        "PainRuleDecision",
        "MobilityRoutine",
        "MobilityExercise",
        "StretchingSession",
        "JointCareProtocol",
        "InjuryHistory",
        "InjuryRestriction",
        "StressRecord",
        "RestingHeartRateRecord",
        "HrvRecord",
        "RespiratoryRateRecord",
        "RecoveryRecommendation",
        "DeloadExecution",
        "ActiveRecoverySession",
        "MassageSession",
        "HydrotherapySession",
        "RecoveryAlert",
        "ReturnToTrainingDecision",
    ],
    "nutrition": [
        "NutritionProfile",
        "NutritionGoal",
        "MealPlan",
        "Meal",
        "MealItem",
        "Food",
        "FoodBrand",
        "FoodPortion",
        "MacroTarget",
        "MicronutrientTarget",
        "CalorieBudget",
        "ProteinTarget",
        "HydrationTarget",
        "HydrationRecord",
        "Supplement",
        "SupplementProtocol",
        "SupplementIntake",
        "GroceryList",
        "Recipe",
        "RecipeIngredient",
        "EatingWindow",
        "DietaryRestriction",
        "Allergy",
        "NutritionCheckIn",
        "BodyRecompositionPlan",
        "MealPrepTask",
        "NutritionAdherenceScore",
        "NutritionEducationCard",
        "NutritionProtocol",
        "NutritionPhase",
        "PhoenixFoundationProtocol",
        "PhoenixRecompProtocol",
        "PhoenixHypertrophyProtocol",
        "PhoenixCutProtocol",
        "PhoenixPeakProtocol",
        "BodybuildingNutritionPlan",
        "MacroCyclePlan",
        "CarbCyclingRule",
        "CarbSource",
        "ProteinSource",
        "FoodReplacementMatrix",
        "MealTimingWindow",
        "PreWorkoutMeal",
        "PostWorkoutMeal",
        "NightShiftNutritionPlan",
        "NutritionScore",
        "NutritionScoreComponent",
        "FourteenDayNutritionReview",
        "NutritionAdjustmentRule",
        "WaistVelocitySignal",
        "StrengthNutritionSignal",
        "DigestionRecord",
        "AlcoholUltraProcessedControl",
        "GymMealTemplate",
        "NutritionistReview",
    ],
    "mental": [
        "MentalProfile",
        "Habit",
        "HabitLog",
        "DisciplineProtocol",
        "FocusSession",
        "MoodRecord",
        "JournalEntry",
        "ReflectionPrompt",
        "BreathworkProtocol",
        "BreathworkSession",
        "VisualizationSession",
        "StressTrigger",
        "CopingStrategy",
        "MotivationScript",
        "IdentityStatement",
        "CommitmentContract",
        "SelfEfficacyScore",
        "DropoutRiskSignal",
        "InterventionMessage",
        "MindsetLesson",
        "MentalChallenge",
        "AccountabilityCheckIn",
    ],
    "spiritual": [
        "SpiritualProfile",
        "DevotionalWeek",
        "DevotionalEntry",
        "ScriptureReference",
        "PrayerEntry",
        "MeditationSession",
        "GratitudeEntry",
        "ValueStatement",
        "PurposeStatement",
        "ServiceAction",
        "FaithPreference",
        "OptionalityConsent",
        "ReflectionResponse",
        "SpiritualMilestone",
        "CommunityGroup",
        "PastoralResource",
        "SpiritualContentCard",
        "BeliefBoundary",
    ],
    "ai": [
        "AiConversation",
        "AiMessage",
        "AiPromptTemplate",
        "AiSystemInstruction",
        "AiToolCall",
        "AiToolResult",
        "AiMemory",
        "AiUserContext",
        "AiRecommendation",
        "AiRecommendationFeedback",
        "AiSafetyGuardrail",
        "AiRiskDecision",
        "AiModelProvider",
        "AiModelVersion",
        "AiEmbedding",
        "AiVectorDocument",
        "AiRetrievalChunk",
        "AiEvaluationCase",
        "AiEvaluationRun",
        "AiHallucinationReport",
        "AiEscalationEvent",
        "AiCoachPersona",
        "AiToneProfile",
        "AiContentPolicy",
        "AiUsageQuota",
        "AiCostLedger",
        "AiLatencyMetric",
        "AiPrivacyFilter",
        "AiMedicalBoundary",
        "AiAuditTrail",
        "AiExperiment",
        "AiReleaseNote",
    ],
    "war_room": [
        "Dashboard",
        "DashboardWidget",
        "MetricDefinition",
        "MetricSnapshot",
        "MetricTrend",
        "IndicatorCard",
        "GoalProgressView",
        "TrainingCalendarView",
        "PhaseProgressView",
        "RiskPanel",
        "AdherencePanel",
        "RecoveryPanel",
        "NutritionPanel",
        "MedicalPanel",
        "AiInsightPanel",
        "Alert",
        "AlertRule",
        "Notification",
        "NotificationPreference",
        "Report",
        "ReportExport",
        "ExecutiveSummary",
    ],
    "legacy": [
        "Achievement",
        "AchievementUnlock",
        "Badge",
        "Certificate",
        "GraduationRecord",
        "BeforeAfterStory",
        "LegacyTimeline",
        "MilestoneStory",
        "SocialShare",
        "Testimonial",
        "TransformationNarrative",
        "PersonalManifesto",
        "LegacyVaultItem",
        "FamilyInvite",
        "MentorNote",
        "CommunityPost",
        "CommunityReaction",
        "CommunityModerationCase",
        "ChallengeLeaderboardEntry",
        "AlumniStatus",
        "ContinuationPlan",
        "NextMission",
    ],
    "medical": [
        "MedicalProfile",
        "MedicalConsent",
        "MedicalDisclaimerAcceptance",
        "ClinicianContact",
        "EmergencyContact",
        "HealthCondition",
        "Medication",
        "MedicationSchedule",
        "AllergyMedical",
        "LabOrder",
        "LabResultDocument",
        "LabPanel",
        "LabBiomarker",
        "BiomarkerResult",
        "BiomarkerReferenceRange",
        "VitalSignRecord",
        "BloodPressureRecord",
        "GlucoseRecord",
        "LipidPanelRecord",
        "HormonalPanelRecord",
        "InflammationMarkerRecord",
        "RenalMarkerRecord",
        "LiverMarkerRecord",
        "CheckupReminder",
        "CheckupCompletion",
        "HealthTrend",
        "HealthRiskFlag",
        "MedicalRecommendation",
        "MedicalEscalation",
        "ProviderShareLink",
        "HealthDataImport",
        "HealthDeviceConnection",
        "MedicalAttachment",
        "ClinicalNote",
        "MedicalAuditEvent",
        "DeidentificationJob",
        "PseudonymizationKey",
        "DataRetentionRule",
        "MedicalReviewQueue",
        "ContraindicationRule",
        "ClearanceRequirement",
        "ExamSchedule",
        "ExamReminder",
        "HealthQuestionnaire",
        "QuestionnaireAnswer",
    ],
    "gamification": [
        "XpAccount",
        "XpEvent",
        "XpRule",
        "Rank",
        "RankProgress",
        "Streak",
        "StreakFreeze",
        "Challenge",
        "ChallengeEnrollment",
        "ChallengeSubmission",
        "ChallengeReview",
        "Mission",
        "MissionStep",
        "Reward",
        "RewardRedemption",
        "BadgeRule",
        "Leaderboard",
        "LeaderboardEntry",
        "FairPlaySignal",
        "AntiGamingRule",
        "Season",
        "SeasonPass",
        "Quest",
        "QuestObjective",
        "LootGrant",
        "MotivationTrigger",
        "GamificationExperiment",
        "ProgressCelebration",
    ],
    "billing": [
        "ProductPlan",
        "PlanFeature",
        "Price",
        "Subscription",
        "SubscriptionItem",
        "Trial",
        "Invoice",
        "InvoiceLine",
        "PaymentMethod",
        "PaymentIntent",
        "Refund",
        "Coupon",
        "PromotionCode",
        "Entitlement",
        "FeatureFlag",
        "UsageMeter",
        "UsageEvent",
        "SeatAllocation",
        "TaxRate",
        "BillingAddress",
        "CustomerAccount",
        "DunningEvent",
        "RevenueRecognitionEvent",
        "AffiliatePartner",
        "Referral",
    ],
    "gym": [
        "GymOrganization",
        "GymFacility",
        "GymBrand",
        "GymLocation",
        "GymMembershipPlan",
        "GymMemberProfile",
        "GymMemberEnrollment",
        "GymStaffProfile",
        "GymCoachAssignment",
        "GymNutritionistAssignment",
        "GymCohort",
        "GymCohortEnrollment",
        "GymClass",
        "GymClassSchedule",
        "GymClassAttendance",
        "GymEquipment",
        "GymEquipmentCategory",
        "GymMachineSetting",
        "GymWorkoutTemplate",
        "GymBodybuildingProgram",
        "GymBodybuildingPhase",
        "GymCheckIn",
        "GymLead",
        "GymSalesFunnel",
        "GymMemberRetentionSignal",
        "GymChurnRisk",
        "GymChallenge",
        "GymLeaderboard",
        "GymDashboard",
        "GymStaffPermission",
        "GymContentAssignment",
        "GymNutritionProgramEnrollment",
        "GymMedicalClearancePolicy",
        "GymPrivacyBoundary",
        "GymB2BContract",
        "GymInvoiceAllocation",
    ],
    "security": [
        "AuditLog",
        "AccessLog",
        "SecurityEvent",
        "SecurityIncident",
        "IncidentTimeline",
        "RiskRegister",
        "Control",
        "ControlEvidence",
        "Policy",
        "PolicyAcceptance",
        "SecretRotation",
        "EncryptionKey",
        "KeyAccessGrant",
        "DataClassificationRule",
        "RetentionSchedule",
        "BackupJob",
        "RestoreTest",
        "VulnerabilityFinding",
        "PenTestFinding",
        "ThreatModel",
        "AbuseReport",
        "RateLimitBucket",
        "IpAllowlist",
        "DataExportJob",
        "DataDeletionJob",
        "LegalHold",
        "DpaAgreement",
        "BaaAgreement",
        "Subprocessor",
        "ComplianceAssessment",
        "DpiaRecord",
        "RoPARecord",
        "ConsentProof",
        "BreachNotification",
        "DataTransferAssessment",
    ],
    "communications": [
        "EmailTemplate",
        "SmsTemplate",
        "PushTemplate",
        "MessageCampaign",
        "CampaignAudience",
        "DeliveryAttempt",
        "InboxMessage",
        "SupportTicket",
        "SupportComment",
        "KnowledgeBaseArticle",
        "FaqItem",
        "NpsSurvey",
        "SurveyResponse",
        "Announcement",
        "ReleaseCommunication",
        "ModerationMessage",
        "UserFeedback",
        "BugReport",
        "FeatureRequest",
        "ContactPreference",
    ],
    "content": [
        "ContentItem",
        "ContentCollection",
        "Lesson",
        "LessonBlock",
        "MediaAsset",
        "AudioTrack",
        "VideoAsset",
        "ImageAsset",
        "DocumentAsset",
        "ContentTag",
        "ContentVersion",
        "ContentApproval",
        "LocalizationString",
        "TranslationJob",
        "EditorialCalendar",
        "ContentLicense",
        "ExerciseVideo",
        "NutritionArticle",
        "MedicalEducationCard",
        "SafetyNotice",
    ],
    "analytics": [
        "EventStream",
        "ProductEvent",
        "FeatureUsageDaily",
        "UserCohort",
        "RetentionMetric",
        "ActivationMetric",
        "ConversionFunnel",
        "Experiment",
        "ExperimentVariant",
        "ExperimentAssignment",
        "ExperimentResult",
        "ModelFeature",
        "TrainingDataset",
        "PredictionRecord",
        "ChurnScore",
        "AdherencePrediction",
        "RevenueMetric",
        "ClinicalSafetyMetric",
        "DataQualityCheck",
        "DataQualityIssue",
        "WarehouseSnapshot",
        "AnonymizedDataset",
        "CohortReport",
        "BusinessKpi",
        "NorthStarMetric",
    ],
    "integrations": [
        "IntegrationProvider",
        "IntegrationConnection",
        "OauthCredential",
        "WebhookEndpoint",
        "WebhookDelivery",
        "ImportJob",
        "ExportJob",
        "SyncCursor",
        "SyncError",
        "WearableDevice",
        "HealthKitSample",
        "GoogleFitSample",
        "StravaActivity",
        "CalendarEvent",
        "StorageObject",
        "ThirdPartyConsent",
        "ApiClient",
        "ApiClientSecret",
    ],
}


def entity_rows() -> list[dict[str, str]]:
    rows: list[dict[str, str]] = []
    for domain, names in DOMAINS.items():
        for name in names:
            entity = slug(name)
            rows.append(
                {
                    "bounded_context": domain,
                    "entity": entity,
                    "logical_name": name,
                    "table_name": f"{domain}.{entity}",
                    "module": module_for_domain(domain),
                    "data_classification": classification_for_domain(domain),
                    "owner_service": owner_service_for_domain(domain),
                    "retention_policy": retention_for_domain(domain),
                    "api_surface": api_surface_for_domain(domain),
                    "description": f"Entidade de {module_for_domain(domain)} para {name}.",
                }
            )
    return rows


def module_for_domain(domain: str) -> str:
    mapping = {
        "identity": "Foundation Intelligence",
        "body": "Body Performance",
        "combat": "Combat Conditioning",
        "recovery": "Recovery System",
        "nutrition": "Nutrition Intelligence",
        "mental": "Mental Performance",
        "spiritual": "Spiritual Development",
        "ai": "AI Command Center",
        "war_room": "War Room Dashboard",
        "legacy": "Phoenix Legacy",
        "medical": "Phoenix Medical Intelligence",
        "gamification": "Sistema de Gamificacao",
        "billing": "Monetizacao SaaS",
        "gym": "Gym Performance Network",
        "security": "Seguranca e Compliance",
        "communications": "Comunicacoes e Suporte",
        "content": "Content Platform",
        "analytics": "Analytics Platform",
        "integrations": "Integration Platform",
    }
    return mapping[domain]


def classification_for_domain(domain: str) -> str:
    if domain == "medical":
        return "sensitive_health_data"
    if domain in {"identity", "security", "billing"}:
        return "personal_confidential"
    if domain in {"ai", "analytics"}:
        return "derived_confidential"
    return "personal_operational"


def retention_for_domain(domain: str) -> str:
    if domain == "medical":
        return "medical_retention_policy_and_user_deletion_rules"
    if domain == "security":
        return "security_audit_minimum_6_years_or_legal_requirement"
    if domain == "billing":
        return "tax_and_finance_retention_policy"
    return "active_account_plus_contractual_retention"


def owner_service_for_domain(domain: str) -> str:
    return {
        "identity": "identity-service",
        "body": "training-service",
        "combat": "training-service",
        "recovery": "recovery-service",
        "nutrition": "nutrition-service",
        "mental": "mental-service",
        "spiritual": "spiritual-service",
        "ai": "ai-engine-service",
        "war_room": "dashboard-service",
        "legacy": "legacy-service",
        "medical": "medical-intelligence-service",
        "gamification": "gamification-service",
        "billing": "billing-service",
        "gym": "gym-network-service",
        "security": "security-compliance-service",
        "communications": "communications-service",
        "content": "content-service",
        "analytics": "analytics-service",
        "integrations": "integration-service",
    }[domain]


def api_surface_for_domain(domain: str) -> str:
    if domain in {"security"}:
        return "internal_admin_api"
    if domain in {"analytics"}:
        return "internal_analytics_api"
    if domain in {"billing"}:
        return "rest_webhook_admin"
    return "rest_graphql_mobile_web"


def generate_entity_catalog() -> None:
    rows = entity_rows()
    target = ROOT / "docs/04-data/entity-catalog.csv"
    target.parent.mkdir(parents=True, exist_ok=True)
    with target.open("w", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=list(rows[0].keys()))
        writer.writeheader()
        writer.writerows(rows)

    schemas = sorted(DOMAINS.keys())
    sql_parts = [
        "-- Phoenix Protocol(R) - logical PostgreSQL schema baseline",
        "-- Generated from docs/04-data/entity-catalog.csv.",
        "-- This file is intended as a complete logical inventory for platform generation.",
        "-- Production migrations should harden high-volume tables with domain-specific columns before launch.",
        "",
        "CREATE EXTENSION IF NOT EXISTS pgcrypto;",
        "CREATE EXTENSION IF NOT EXISTS citext;",
        "",
    ]
    for schema in schemas:
        sql_parts.append(f"CREATE SCHEMA IF NOT EXISTS {schema};")
    sql_parts.append("")
    sql_parts.append(
        clean(
            """
            CREATE TABLE IF NOT EXISTS identity.tenant (
              id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
              name text NOT NULL,
              slug text NOT NULL UNIQUE,
              status text NOT NULL DEFAULT 'active',
              created_at timestamptz NOT NULL DEFAULT now(),
              updated_at timestamptz NOT NULL DEFAULT now()
            );

            CREATE TABLE IF NOT EXISTS identity.user_account (
              id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
              tenant_id uuid NOT NULL REFERENCES identity.tenant(id),
              email citext,
              phone text,
              status text NOT NULL DEFAULT 'active',
              created_at timestamptz NOT NULL DEFAULT now(),
              updated_at timestamptz NOT NULL DEFAULT now(),
              deleted_at timestamptz,
              UNIQUE (tenant_id, email)
            );
            """
        ).strip()
    )
    for row in rows:
        schema, table = row["table_name"].split(".")
        if row["table_name"] in {"identity.tenant", "identity.user_account"}:
            continue
        sql_parts.append(
            f"""
CREATE TABLE IF NOT EXISTS {schema}.{table} (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT '{row["data_classification"]}',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{{}}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE {schema}.{table} IS '{row["description"].replace("'", "''")}';
CREATE INDEX IF NOT EXISTS ix_{schema}_{table}_tenant ON {schema}.{table}(tenant_id);
CREATE INDEX IF NOT EXISTS ix_{schema}_{table}_user ON {schema}.{table}(user_id);
CREATE INDEX IF NOT EXISTS ix_{schema}_{table}_attrs ON {schema}.{table} USING gin(attributes);
""".strip()
        )
    (ROOT / "docs/04-data/postgresql-logical-ddl.sql").write_text(
        "\n\n".join(sql_parts) + "\n", encoding="utf-8"
    )


def generate_docs() -> None:
    entity_count = len(entity_rows())

    write(
        "README.md",
        f"""
        # Phoenix Protocol(R) - Performance Operating System

        Este workspace contem a documentacao oficial de engenharia para evoluir o Phoenix Protocol(R) como plataforma SaaS de performance humana, com base nos materiais fonte fornecidos e nas referencias tecnicas oficiais.

        ## Pacote Entregue

        - Produto: PRD, usuarios, jornadas, MVP e requisitos.
        - Arquitetura: C4 Model, decisoes tecnicas, componentes, fluxos e deployment.
        - Processos: UML e BPMN em formato versionavel.
        - Dados: catalogo com {entity_count} entidades, modelo PostgreSQL logico e governanca de dados.
        - APIs: OpenAPI 3.1.1 e schema GraphQL inicial.
        - IA: Phoenix AI Engine e Phoenix Medical Intelligence com limites de seguranca.
        - Experiencia: design system, UX/UI e especificacao mobile Android/iOS.
        - Academias: requisitos B2B/B2B2C para unidades, alunos, coaches, nutricionistas, cohortes e dashboards.
        - Nutricao: Phoenix Nutrition System para Foundation, Recomp, Hypertrophy, Cut, Peak, meal prep, score e ajustes a cada 14 dias.
        - Negocio: gamificacao, SaaS, monetizacao e roadmap de 5 anos.
        - Operacao: manuais de usuario/admin, QA, DevOps, CI/CD e compliance.
        - Prompts: Lovable, Claude Code, Cursor e GitHub Copilot.

        ## Como Usar

        1. Leia `docs/00-overview/source-context.md` para entender as fontes e premissas.
        2. Use `docs/01-product/prd.md` como contrato de produto.
        3. Use `docs/02-architecture/c4-model.md` e `docs/04-data/database-model.md` antes de gerar codigo.
        4. Use `docs/05-api/openapi.yaml` e `docs/05-api/graphql-schema.graphql` como contratos de integracao.
        5. Use `prompts/` para orientar ferramentas de IA sem perder consistencia.

        ## Regra de Ouro

        Nenhuma implementacao deve contrariar estes documentos sem uma ADR em `adr/`. Quando o produto evoluir, atualize primeiro PRD, arquitetura, dados e API; depois gere ou modifique codigo.
        """,
    )

    write(
        "docs/00-overview/source-context.md",
        """
        # Contexto e Rastreabilidade

        ## Fontes fornecidas

        - `Phoenix_Protocol_Performance_Operating_System_Arquitetura_v1.pdf`: visao de plataforma SaaS com 11 modulos, Phoenix Medical Intelligence e prompt mestre para Lovable.dev.
        - `VOLUME_1_Manual_Completo_Calistenia_Militar_90_Dias.pdf`: manual completo do programa de 90 dias, publico 35-45 anos, avaliacao inicial, fases, exercicios, recuperacao, nutricao, mentalidade e devocional opcional.
        - `VOLUME_2_Caderno_de_Treinos_90_Dias.pdf`: sessoes diarias, RPE, deloads, desafios semanais, Muay Thai tecnico sem contato, corda, corrida/caminhada e registro operacional.
        - `VOLUME_3_Planilha_de_Evolucao_90_Dias.xlsx`: abas Inicio, Painel, Diario, Semanal e Avaliacoes com campos de adesao, sono, agua, humor, RPE, medidas e testes.
        - `Phoenix_Nutrition_System_Fisiculturismo.pdf`: sistema nutricional integrado para performance, hipertrofia, definicao, academias e fase adicional de fisiculturismo, com protocolos Foundation, Recomp, Hypertrophy, Cut e Peak.

        ## Link externo do contexto

        O link compartilhado `https://chatgpt.com/share/6a583e23-6bac-83e9-a271-3392bb01fa6c` nao retornou conteudo pelo navegador de pesquisa disponivel durante a geracao em 2026-07-16. Esta versao foi construida a partir dos arquivos locais e de fontes oficiais de padroes, seguranca e compliance.

        ## Sinais de produto extraidos

        - Proposta: sistema integrado de transformacao fisica, mental e espiritual em 90 dias.
        - Publico inicial: homens e mulheres de 35 a 45 anos, com enfase em preservacao articular.
        - Fases: Dias 1-30 Fundacao/RPE 6-7, Dias 31-60 Forca/RPE 7-8, Dias 61-90 Performance/RPE 8-9.
        - Deloads: semanas 4, 8 e 12.
        - Retestes: Dia 30 parcial, Dia 60 completo, Dia 90 graduacao.
        - Limite medico: conteudo informativo e educacional, sem diagnostico ou prescricao.
        - Campos de acompanhamento: treino cumprido, agua, sono, humor, RPE, observacoes, peso, medidas, gordura estimada e resultados de testes.
        - Nutrição/fisiculturismo: sistema de decisao por objetivo, resposta corporal, desempenho, sono, recuperacao, medidas e exames.
        - Academias: modelo B2B/B2B2C com unidades, alunos, coaches, nutricionistas parceiros, cohortes, dashboards e programas de hipertrofia/definicao.
        - Phoenix Nutrition Score: pontuacao por proteina, hidratacao, frutas/vegetais, refeicoes planejadas, alinhamento com treino, sono, digestao e controle de alcool/ultraprocessados.
        - Regras de seguranca nutricional: sem desidratacao extrema, diureticos, manipulacao severa de sodio ou dietas clinicas sem nutricionista/medico.

        ## Fontes oficiais usadas

        - C4 Model: https://c4model.com/
        - UML 2.5.1: https://www.omg.org/spec/UML/2.5.1/
        - BPMN 2.0.2: https://www.omg.org/spec/BPMN/2.0.2/
        - OpenAPI 3.1.1 (versao usada no contrato por compatibilidade): https://spec.openapis.org/oas/v3.1.1.html
        - OpenAPI latest 3.2.0 (referencia oficial atual verificada): https://spec.openapis.org/oas/latest.html
        - GraphQL Specification: https://spec.graphql.org/October2021/
        - OWASP ASVS: https://owasp.org/www-project-application-security-verification-standard/
        - LGPD: https://www.planalto.gov.br/ccivil_03/_ato2015-2018/2018/lei/l13709.htm
        - GDPR: https://eur-lex.europa.eu/eli/reg/2016/679/oj
        - HIPAA Privacy Rule: https://www.hhs.gov/hipaa/for-professionals/privacy/laws-regulations/index.html
        - HIPAA Security Rule: https://www.hhs.gov/hipaa/for-professionals/security/laws-regulations/index.html
        - AWS Well-Architected: https://docs.aws.amazon.com/wellarchitected/latest/framework/welcome.html
        - Azure Well-Architected: https://learn.microsoft.com/en-us/azure/well-architected/
        - Google Cloud Architecture Framework: https://cloud.google.com/architecture/framework
        """,
    )

    write(
        "docs/00-overview/engineering-standard.md",
        """
        # Padrao de Engenharia

        ## Principios

        - Plataforma primeiro: todo modulo deve ser multi-tenant, auditavel e versionavel.
        - Saude com limites: Phoenix Medical Intelligence e informativo, nao diagnostico, nao substitui profissional de saude e deve aplicar escalonamento quando houver risco.
        - IA supervisionada: recomendacoes de IA precisam de fonte, justificativa, nivel de confianca, limite de uso e log de auditoria.
        - Dados minimos: coletar somente o necessario para entregar valor, seguranca e conformidade.
        - Contratos antes de codigo: dados, API, eventos e UX devem ser definidos antes da implementacao.
        - Evolucao por ADR: decisoes arquiteturais relevantes exigem registro.

        ## Stack de referencia

        - Web: Next.js, React, TypeScript, Tailwind, design tokens.
        - Mobile: React Native/Expo ou nativo quando sensores, HealthKit/Google Fit ou notificacoes exigirem controle fino.
        - Backend: NestJS/Fastify ou modular monolith TypeScript; separar em servicos quando carga e dominios justificarem.
        - Banco: PostgreSQL, pgvector para RAG, Redis para cache/filas curtas, object storage para anexos.
        - IA: camada Phoenix AI Engine com provedores substituiveis, RAG, guardrails, avaliacao e auditoria.
        - Observabilidade: OpenTelemetry, logs estruturados, metricas por tenant, alertas SLO.
        - Infra: containers, IaC, ambientes dev/staging/prod, CI/CD com gates de seguranca.

        ## Definition of Done

        - Requisito rastreado ao PRD.
        - Modelo de dados ou migracao revisada.
        - OpenAPI/GraphQL atualizado quando houver contrato externo.
        - Testes unitarios, integracao e e2e relevantes.
        - Telemetria, logs e alertas definidos.
        - LGPD/GDPR/HIPAA readiness avaliado quando houver dados pessoais, sensiveis ou de saude.
        - Documentacao de usuario/admin atualizada quando o comportamento mudar.

        ## Ambientes

        - `local`: dados ficticios, ferramentas de desenvolvimento, sem dados reais.
        - `dev`: integracao tecnica, seeds anonimizados.
        - `staging`: homologacao, paridade de infra, testes de seguranca.
        - `prod`: dados reais, criptografia, backups, monitoramento e controle de mudancas.

        ## Controle de Qualidade de IA

        Toda entrega gerada por IA deve ser tratada como rascunho tecnico ate passar por revisao humana. Geradores devem receber os documentos de `docs/` como fonte primaria e nao devem criar entidades, endpoints ou fluxos paralelos sem atualizar a documentacao.
        """,
    )

    write(
        "docs/01-product/prd.md",
        f"""
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

        {chr(10).join(f"- {m}" for m in MODULES)}

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
        """,
    )

    write(
        "docs/02-architecture/c4-model.md",
        """
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
        """,
    )

    write(
        "docs/03-process/uml-diagrams.md",
        """
        # Diagramas UML

        ## Diagrama de Classes - Core

        ```plantuml
        @startuml
        class Tenant { +id +name +status }
        class UserAccount { +id +email +status }
        class UserProfile { +birthDate +sex +timezone }
        class ConsentRecord { +purpose +status +grantedAt +revokedAt }
        class ProgramPlan { +phase +startDate +endDate }
        class WorkoutSession { +dayNumber +rpe +completedAt }
        class DailyLog { +waterLiters +sleepHours +mood +notes }
        class GymFacility { +id +name +status }
        class GymMemberEnrollment { +id +startDate +status }
        class NutritionProtocol { +code +objective +safetyBoundary }
        class MealPlan { +calorieTarget +proteinTarget +reviewCadence }
        class NutritionScore { +score +tier +calculatedAt }
        class FourteenDayNutritionReview { +weightTrend +waistTrend +strengthTrend +decision }
        class PhysicalAssessment { +assessmentDay +performedAt }
        class MedicalProfile { +riskLevel +lastReviewAt }
        class AiRecommendation { +type +confidence +safetyLevel }

        Tenant "1" -- "*" UserAccount
        UserAccount "1" -- "1" UserProfile
        UserAccount "1" -- "*" ConsentRecord
        UserAccount "1" -- "*" ProgramPlan
        ProgramPlan "1" -- "*" WorkoutSession
        WorkoutSession "1" -- "0..1" DailyLog
        GymFacility "1" -- "*" GymMemberEnrollment
        UserAccount "1" -- "*" GymMemberEnrollment
        UserAccount "1" -- "*" MealPlan
        NutritionProtocol "1" -- "*" MealPlan
        MealPlan "1" -- "*" NutritionScore
        MealPlan "1" -- "*" FourteenDayNutritionReview
        UserAccount "1" -- "*" PhysicalAssessment
        UserAccount "1" -- "0..1" MedicalProfile
        UserAccount "1" -- "*" AiRecommendation
        @enduml
        ```

        ## Sequencia - Revisao Nutricional de 14 Dias

        ```plantuml
        @startuml
        actor "Aluno de academia" as Member
        participant MobileApp
        participant API
        participant NutritionService
        participant GymService
        participant AiEngine
        database PostgreSQL

        Member -> MobileApp: envia peso, cintura, forca, sono, digestao e aderencia
        MobileApp -> API: POST /v1/nutrition/reviews
        API -> NutritionService: avaliar protocolo e sinais
        NutritionService -> GymService: carregar treino/coorte/unidade
        NutritionService -> PostgreSQL: salvar review e score
        NutritionService -> AiEngine: solicitar explicacao segura
        AiEngine --> NutritionService: recomendacao informativa
        NutritionService --> API: manter, adicionar carbo, reduzir carbo/gordura ou semana de manutencao
        API --> MobileApp: plano ajustado e justificativa
        @enduml
        ```

        ## Sequencia - Registro Diario

        ```plantuml
        @startuml
        actor User
        participant MobileApp
        participant API
        participant TrainingService
        participant RecoveryService
        participant AiEngine
        database PostgreSQL

        User -> MobileApp: envia log diario
        MobileApp -> API: POST /v1/daily-logs
        API -> TrainingService: validar dia, fase e sessao
        API -> RecoveryService: avaliar dor, sono, RPE
        RecoveryService --> API: readiness e alertas
        API -> PostgreSQL: salvar log + eventos
        API -> AiEngine: gerar insight se elegivel
        AiEngine --> API: recomendacao segura
        API --> MobileApp: resumo, XP, alerta e proximo passo
        @enduml
        ```

        ## Estado - Ciclo de Programa

        ```plantuml
        @startuml
        [*] --> Draft
        Draft --> Active: onboarding completo
        Active --> Deload: semana 4/8/12
        Deload --> Active: deload concluido
        Active --> Paused: dor aguda ou pausa voluntaria
        Paused --> Active: liberacao/regressao
        Active --> GraduationReady: dia 90 elegivel
        GraduationReady --> Graduated: prova final concluida
        Graduated --> Continuation: proxima missao
        @enduml
        ```

        ## Casos de Uso

        ```plantuml
        @startuml
        left to right direction
        actor Usuario
        actor Admin
        actor Profissional

        rectangle "Phoenix Platform" {
          usecase "Completar onboarding" as UC1
          usecase "Registrar treino diario" as UC2
          usecase "Acompanhar dashboard" as UC3
          usecase "Conversar com Phoenix AI" as UC4
          usecase "Registrar exames" as UC5
          usecase "Exportar relatorio consentido" as UC6
          usecase "Gerenciar conteudo" as UC7
          usecase "Auditar acesso" as UC8
        }
        Usuario --> UC1
        Usuario --> UC2
        Usuario --> UC3
        Usuario --> UC4
        Usuario --> UC5
        Usuario --> UC6
        Profissional --> UC6
        Admin --> UC7
        Admin --> UC8
        @enduml
        ```
        """,
    )

    write(
        "docs/03-process/bpmn-processes.md",
        """
        # Processos BPMN

        Os fluxos abaixo seguem semantica BPMN: eventos de inicio/fim, tarefas, gateways, lanes e mensagens. Para execucao em motor BPMN, converter cada fluxo para BPMN 2.0 XML mantendo os IDs de tarefas.

        ## Processo 1 - Onboarding e Prontidao

        ```mermaid
        flowchart LR
          start((Inicio)) --> A[Coletar perfil e objetivos]
          A --> B[Exibir termo e consentimentos]
          B --> C{Aceitou termos?}
          C -->|Nao| end1((Encerrar sem ativar))
          C -->|Sim| D[Executar anamnese e prontidao]
          D --> E{Bloqueio medico?}
          E -->|Sim| F[Solicitar liberacao medica]
          F --> hold((Aguardar))
          E -->|Nao| G[Criar baseline e plano 90 dias]
          G --> H[Agendar Dia 0 e lembretes]
          H --> end2((Usuario ativado))
        ```

        ## Processo 2 - Registro Diario

        ```mermaid
        flowchart LR
          start((Dia de treino)) --> A[Usuario registra sessao]
          A --> B[Validar campos minimos]
          B --> C{Dor articular ou alerta?}
          C -->|Sim| D[Aplicar regra da dor e recomendar regressao/pausa]
          C -->|Nao| E[Calcular adesao, XP e metricas]
          D --> E
          E --> F[Atualizar dashboard]
          F --> G{Insight de IA elegivel?}
          G -->|Sim| H[Gerar recomendacao informativa com guardrails]
          G -->|Nao| I[Finalizar log]
          H --> I
          I --> end((Fim))
        ```

        ## Processo 3 - Phoenix Medical Intelligence

        ```mermaid
        flowchart LR
          start((Novo dado de saude)) --> A[Confirmar consentimento valido]
          A --> B{Consentimento existe?}
          B -->|Nao| stop((Bloquear processamento))
          B -->|Sim| C[Importar documento ou biomarcador]
          C --> D[Classificar e extrair dados]
          D --> E[Comparar com historico e faixas de referencia]
          E --> F{Risco ou valor critico?}
          F -->|Sim| G[Gerar alerta informativo e sugerir profissional]
          F -->|Nao| H[Atualizar tendencia longitudinal]
          G --> I[Registrar auditoria e limitar linguagem]
          H --> I
          I --> end((Relatorio disponivel))
        ```

        ## Processo 4 - Assinatura SaaS

        ```mermaid
        flowchart LR
          start((Trial iniciado)) --> A[Provisionar tenant e entitlement]
          A --> B[Monitorar ativacao]
          B --> C{Fim do trial}
          C --> D[Solicitar pagamento]
          D --> E{Pagamento aprovado?}
          E -->|Sim| F[Ativar assinatura]
          E -->|Nao| G[Iniciar dunning]
          G --> H{Regularizou?}
          H -->|Sim| F
          H -->|Nao| I[Reduzir acesso conforme politica]
          F --> end1((Cliente ativo))
          I --> end2((Conta restrita))
        ```

        ## Processo 5 - Academia e Nutrition Hypertrophy

        ```mermaid
        flowchart LR
          start((Aluno entra pela academia)) --> A[Validar tenant, unidade e contrato B2B]
          A --> B[Convidar aluno e coletar consentimentos]
          B --> C[Registrar objetivo: recomposicao, hipertrofia, definicao ou peak]
          C --> D[Coletar medidas, treino, sono, digestao, restricoes e exames opcionais]
          D --> E{Criterio clinico sensivel?}
          E -->|Sim| F[Enviar para revisao de nutricionista/medico autorizado]
          E -->|Nao| G[Selecionar protocolo nutricional]
          F --> G
          G --> H[Gerar macros, refeicoes, carb cycling e score]
          H --> I[Executar por 14 dias]
          I --> J[Revisar peso, cintura, forca, sono e score]
          J --> K{Decisao}
          K -->|Tudo alinhado| L[Manter plano]
          K -->|Estagnado sem cintura subir| M[Adicionar 25-40 g carbo/dia]
          K -->|Cintura sobe rapido| N[Retirar 20-30 g carbo ou pequena porcao de gordura]
          K -->|Sono/humor/forca pioram| O[Reduzir deficit ou semana de manutencao]
          L --> end((Continuar ciclo))
          M --> end
          N --> end
          O --> end
        ```
        """,
    )

    write(
        "docs/04-data/database-model.md",
        f"""
        # Banco de Dados

        ## Escopo

        Este modelo define o banco logico corporativo do Phoenix Protocol(R), com {entity_count} entidades em `entity-catalog.csv` e uma base PostgreSQL em `postgresql-logical-ddl.sql`.

        ## Decisoes

        - Banco operacional principal: PostgreSQL.
        - Vetores/RAG: pgvector no mesmo cluster no MVP; separar quando volume ou isolamento exigirem.
        - Anexos: object storage com metadados no PostgreSQL.
        - Analytics: replicacao para warehouse; nunca consultar dashboards historicos pesados direto no OLTP.
        - Multi-tenancy: `tenant_id` obrigatorio para entidades de negocio.
        - Auditoria: eventos sensiveis em schema `security`, append-only e monitorados.
        - Dados medicos: schema `medical`, criptografia, consentimento explicito, auditoria reforcada e acesso minimo.

        ## Bounded Contexts

        | Contexto | Papel |
        |---|---|
        | identity | Tenants, usuarios, sessoes, consentimentos e direitos do titular. |
        | body | Exercicios, treinos, avaliacoes, fases, progressao e antropometria. |
        | combat | Muay Thai tecnico sem contato, corda, rounds, circuitos e marcha. |
        | recovery | Sono, dor, mobilidade, readiness e retorno ao treino. |
        | nutrition | Protocolos Foundation/Recomp/Hypertrophy/Cut/Peak, macros, carb cycling, score, meal prep, substituicoes, suplementos e revisoes de 14 dias. |
        | mental | Habitos, humor, disciplina, journaling e intervencoes. |
        | spiritual | Devocional opcional, reflexoes e preferencias de fe. |
        | ai | Conversas, contexto, recomendacoes, guardrails, avaliacao e custos. |
        | war_room | Dashboards, indicadores, alertas e relatorios. |
        | legacy | Graduacao, certificados, conquistas e comunidade. |
        | medical | Exames, biomarcadores, sinais vitais, consentimentos e relatorios. |
        | gamification | XP, patentes, streaks, badges, missoes e leaderboard. |
        | billing | Planos, assinaturas, invoices, pagamentos e entitlements. |
        | gym | Academias, unidades, alunos, staff, cohortes, programas de musculacao/fisiculturismo, contratos B2B e dashboards. |
        | security | Auditoria, incidentes, controles, politicas e compliance. |
        | communications | Email, push, suporte, feedback e campanhas. |
        | content | Conteudo, midia, licoes, localizacao e aprovacao editorial. |
        | analytics | Eventos, cohorts, funis, experimentos, metricas e datasets. |
        | integrations | Webhooks, OAuth, wearables, importacoes e API clients. |

        ## Entidades Criticas

        - `identity.consent_record`: fonte de verdade para tratamento de dados.
        - `body.workout_session`: unidade operacional de treino.
        - `body.physical_assessment`: bateria Dia 0, 30, 60 e 90.
        - `recovery.pain_report`: gatilho para regra da dor e regressao.
        - `nutrition.nutrition_protocol`: protocolo Foundation, Recomp, Hypertrophy, Cut ou Peak.
        - `nutrition.fourteen_day_nutrition_review`: motor de ajustes nutricionais por peso, cintura, forca, sono e score.
        - `nutrition.nutrition_score`: pontuacao operacional de aderencia nutricional e qualidade do plano.
        - `gym.gym_facility`: unidade B2B da academia.
        - `gym.gym_member_enrollment`: vinculo consentido entre aluno, unidade, coorte e programa.
        - `gym.gym_cohort`: agrupamento operacional para desafios, acompanhamento e retencao.
        - `medical.biomarker_result`: dado sensivel de saude com trilha de auditoria.
        - `ai.ai_recommendation`: recomendacao rastreavel com limite, confianca e feedback.
        - `security.audit_log`: evidencia para compliance e investigacao.
        - `billing.entitlement`: decisor de acesso por plano.

        ## Politicas de Dados

        - PII: criptografia em repouso, mascaramento em logs, exportacao controlada.
        - Dados de saude: acesso por finalidade, consentimento, auditoria, retention e revogacao.
        - Dados de IA: prompts e respostas devem ser tratados como dados potencialmente pessoais.
        - Dados de academia: alunos so podem ser vistos por staff autorizado da unidade/coorte e dentro da finalidade contratada.
        - Dados nutricionais: objetivos, refeicoes, macros, medidas, digestao e suplementos sao dados pessoais de saude/bem-estar e exigem minimizacao, consentimento quando sensiveis e auditoria em revisoes profissionais.
        - Dados anonimizados: usar somente quando irreversibilidade for tecnicamente demonstravel.
        - Soft delete: padrao para entidades operacionais; hard delete via job governado quando direito do titular permitir.

        ## Arquivos

        - `entity-catalog.csv`: catalogo logico completo com contexto, entidade, tabela, classificacao e owner.
        - `postgresql-logical-ddl.sql`: DDL logico gerado para bootstrap e orientacao de IA.

        ## Regras para Migrations Reais

        1. Especializar colunas de entidades de alto uso antes de producao.
        2. Evitar `attributes jsonb` como substituto permanente de campos criticos.
        3. Adicionar constraints, enums, foreign keys e indices por fluxo.
        4. Criar views de leitura para dashboard e relatorios.
        5. Validar toda migracao com rollback, seed e teste de performance.
        """,
    )

    write(
        "docs/05-api/openapi.yaml",
        """
        # Contrato fixado em 3.1.1 por compatibilidade ampla de tooling.
        # A referencia oficial latest verificada durante a criacao era 3.2.0.
        openapi: 3.1.1
        info:
          title: Phoenix Protocol API
          version: 0.1.0
          summary: REST API para web, mobile, admin e integracoes do Phoenix Protocol.
        servers:
          - url: https://api.phoenixprotocol.example.com
            description: Production
          - url: https://staging-api.phoenixprotocol.example.com
            description: Staging
        security:
          - bearerAuth: []
        tags:
          - name: Identity
          - name: Programs
          - name: Daily Logs
          - name: Nutrition
          - name: Gyms
          - name: Assessments
          - name: Medical
          - name: AI
          - name: Gamification
          - name: Billing
          - name: Admin
        paths:
          /v1/me:
            get:
              tags: [Identity]
              operationId: getCurrentUser
              summary: Retorna usuario autenticado, perfil, tenant e entitlements.
              responses:
                "200":
                  description: Usuario atual
                  content:
                    application/json:
                      schema:
                        $ref: "#/components/schemas/UserContext"
          /v1/onboarding:
            post:
              tags: [Identity]
              operationId: completeOnboarding
              summary: Completa onboarding, consentimentos e prontidao.
              requestBody:
                required: true
                content:
                  application/json:
                    schema:
                      $ref: "#/components/schemas/OnboardingRequest"
              responses:
                "201":
                  description: Onboarding concluido
                  content:
                    application/json:
                      schema:
                        $ref: "#/components/schemas/ProgramPlan"
          /v1/programs/current:
            get:
              tags: [Programs]
              operationId: getCurrentProgram
              summary: Retorna plano ativo de 90 dias.
              responses:
                "200":
                  description: Plano ativo
                  content:
                    application/json:
                      schema:
                        $ref: "#/components/schemas/ProgramPlan"
          /v1/workout-sessions/{sessionId}/complete:
            post:
              tags: [Daily Logs]
              operationId: completeWorkoutSession
              summary: Conclui uma sessao de treino e publica eventos de progresso.
              parameters:
                - $ref: "#/components/parameters/SessionId"
              requestBody:
                required: true
                content:
                  application/json:
                    schema:
                      $ref: "#/components/schemas/CompleteWorkoutRequest"
              responses:
                "200":
                  description: Sessao concluida
                  content:
                    application/json:
                      schema:
                        $ref: "#/components/schemas/DailyLogResult"
          /v1/daily-logs:
            post:
              tags: [Daily Logs]
              operationId: createDailyLog
              summary: Registra agua, sono, humor, RPE, dor e observacoes.
              requestBody:
                required: true
                content:
                  application/json:
                    schema:
                      $ref: "#/components/schemas/DailyLogInput"
              responses:
                "201":
                  description: Log criado
                  content:
                    application/json:
                      schema:
                        $ref: "#/components/schemas/DailyLogResult"
          /v1/assessments:
            post:
              tags: [Assessments]
              operationId: createAssessment
              summary: Registra avaliacao Dia 0, 30, 60 ou 90.
              requestBody:
                required: true
                content:
                  application/json:
                    schema:
                      $ref: "#/components/schemas/AssessmentInput"
              responses:
                "201":
                  description: Avaliacao registrada
                  content:
                    application/json:
                      schema:
                        $ref: "#/components/schemas/Assessment"
          /v1/nutrition/protocols:
            get:
              tags: [Nutrition]
              operationId: listNutritionProtocols
              summary: Lista protocolos Phoenix Nutrition System.
              responses:
                "200":
                  description: Protocolos nutricionais
                  content:
                    application/json:
                      schema:
                        type: array
                        items:
                          $ref: "#/components/schemas/NutritionProtocol"
          /v1/nutrition/plans/current:
            get:
              tags: [Nutrition]
              operationId: getCurrentNutritionPlan
              summary: Retorna plano nutricional ativo, macros, refeicoes e carb cycling.
              responses:
                "200":
                  description: Plano nutricional atual
                  content:
                    application/json:
                      schema:
                        $ref: "#/components/schemas/NutritionPlan"
            post:
              tags: [Nutrition]
              operationId: createNutritionPlan
              summary: Cria plano nutricional baseado em objetivo, medidas, treino, sono e restricoes.
              requestBody:
                required: true
                content:
                  application/json:
                    schema:
                      $ref: "#/components/schemas/NutritionPlanInput"
              responses:
                "201":
                  description: Plano criado
                  content:
                    application/json:
                      schema:
                        $ref: "#/components/schemas/NutritionPlan"
          /v1/nutrition/check-ins:
            post:
              tags: [Nutrition]
              operationId: createNutritionCheckIn
              summary: Registra score nutricional, digestao, refeicoes, proteina, hidratacao e alinhamento ao treino.
              requestBody:
                required: true
                content:
                  application/json:
                    schema:
                      $ref: "#/components/schemas/NutritionCheckInInput"
              responses:
                "201":
                  description: Check-in nutricional registrado
                  content:
                    application/json:
                      schema:
                        $ref: "#/components/schemas/NutritionScore"
          /v1/nutrition/reviews:
            post:
              tags: [Nutrition]
              operationId: createNutritionReview
              summary: Executa revisao de 14 dias e recomenda manter ou ajustar macros com limites seguros.
              requestBody:
                required: true
                content:
                  application/json:
                    schema:
                      $ref: "#/components/schemas/NutritionReviewInput"
              responses:
                "201":
                  description: Revisao criada
                  content:
                    application/json:
                      schema:
                        $ref: "#/components/schemas/NutritionReviewResult"
          /v1/gyms/current:
            get:
              tags: [Gyms]
              operationId: getCurrentGymContext
              summary: Retorna academia, unidade, coorte e permissoes do usuario autenticado.
              responses:
                "200":
                  description: Contexto de academia
                  content:
                    application/json:
                      schema:
                        $ref: "#/components/schemas/GymContext"
          /v1/gyms/{gymId}/members:
            get:
              tags: [Gyms]
              operationId: listGymMembers
              summary: Lista alunos da academia para staff autorizado.
              parameters:
                - $ref: "#/components/parameters/GymId"
                - name: cohortId
                  in: query
                  schema: { type: string, format: uuid }
              responses:
                "200":
                  description: Alunos da academia
                  content:
                    application/json:
                      schema:
                        type: array
                        items:
                          $ref: "#/components/schemas/GymMemberEnrollment"
            post:
              tags: [Gyms]
              operationId: inviteGymMember
              summary: Convida aluno para programa Phoenix da academia.
              parameters:
                - $ref: "#/components/parameters/GymId"
              requestBody:
                required: true
                content:
                  application/json:
                    schema:
                      $ref: "#/components/schemas/GymMemberInput"
              responses:
                "201":
                  description: Aluno convidado
                  content:
                    application/json:
                      schema:
                        $ref: "#/components/schemas/GymMemberEnrollment"
          /v1/medical/lab-results:
            post:
              tags: [Medical]
              operationId: createLabResult
              summary: Registra biomarcador ou resultado de exame com consentimento.
              requestBody:
                required: true
                content:
                  application/json:
                    schema:
                      $ref: "#/components/schemas/LabResultInput"
              responses:
                "201":
                  description: Resultado criado
                  content:
                    application/json:
                      schema:
                        $ref: "#/components/schemas/LabResult"
          /v1/medical/reports/{reportId}/share-links:
            post:
              tags: [Medical]
              operationId: createMedicalReportShareLink
              summary: Cria link consentido e expiravel para relatorio de saude.
              parameters:
                - $ref: "#/components/parameters/ReportId"
              responses:
                "201":
                  description: Link criado
                  content:
                    application/json:
                      schema:
                        $ref: "#/components/schemas/ShareLink"
          /v1/ai/chat:
            post:
              tags: [AI]
              operationId: createAiChatResponse
              summary: Envia mensagem ao Phoenix AI Engine com guardrails.
              requestBody:
                required: true
                content:
                  application/json:
                    schema:
                      $ref: "#/components/schemas/AiChatRequest"
              responses:
                "200":
                  description: Resposta de IA
                  content:
                    application/json:
                      schema:
                        $ref: "#/components/schemas/AiChatResponse"
          /v1/gamification/me:
            get:
              tags: [Gamification]
              operationId: getGamificationProfile
              summary: Retorna XP, patente, streaks, badges e desafios.
              responses:
                "200":
                  description: Perfil de gamificacao
                  content:
                    application/json:
                      schema:
                        $ref: "#/components/schemas/GamificationProfile"
          /v1/billing/checkout:
            post:
              tags: [Billing]
              operationId: createCheckout
              summary: Cria sessao de checkout para assinatura SaaS.
              responses:
                "201":
                  description: Checkout criado
                  content:
                    application/json:
                      schema:
                        type: object
                        required: [url]
                        properties:
                          url: { type: string, format: uri }
          /v1/admin/users:
            get:
              tags: [Admin]
              operationId: listAdminUsers
              summary: Lista usuarios para administradores autorizados.
              parameters:
                - name: search
                  in: query
                  schema: { type: string }
                - name: status
                  in: query
                  schema: { type: string }
              responses:
                "200":
                  description: Lista paginada
                  content:
                    application/json:
                      schema:
                        $ref: "#/components/schemas/UserList"
        components:
          securitySchemes:
            bearerAuth:
              type: http
              scheme: bearer
              bearerFormat: JWT
          parameters:
            SessionId:
              name: sessionId
              in: path
              required: true
              schema: { type: string, format: uuid }
            ReportId:
              name: reportId
              in: path
              required: true
              schema: { type: string, format: uuid }
            GymId:
              name: gymId
              in: path
              required: true
              schema: { type: string, format: uuid }
          schemas:
            UserContext:
              type: object
              required: [id, tenantId, email, entitlements]
              properties:
                id: { type: string, format: uuid }
                tenantId: { type: string, format: uuid }
                email: { type: string, format: email }
                entitlements:
                  type: array
                  items: { type: string }
            OnboardingRequest:
              type: object
              required: [goals, readinessAnswers, consentIds]
              properties:
                goals:
                  type: array
                  items: { type: string }
                readinessAnswers:
                  type: object
                  additionalProperties: true
                consentIds:
                  type: array
                  items: { type: string, format: uuid }
            ProgramPlan:
              type: object
              required: [id, phase, dayNumber, startDate]
              properties:
                id: { type: string, format: uuid }
                phase: { type: string, enum: [foundation, strength, performance, graduation] }
                dayNumber: { type: integer, minimum: 0, maximum: 90 }
                startDate: { type: string, format: date }
            CompleteWorkoutRequest:
              type: object
              required: [rpe, completed]
              properties:
                completed: { type: boolean }
                rpe: { type: integer, minimum: 1, maximum: 10 }
                notes: { type: string, maxLength: 2000 }
            DailyLogInput:
              type: object
              required: [programDay, workoutCompleted, waterLiters, sleepHours, mood, rpe]
              properties:
                programDay: { type: integer, minimum: 1, maximum: 90 }
                workoutCompleted: { type: boolean }
                waterLiters: { type: number, minimum: 0, maximum: 12 }
                sleepHours: { type: number, minimum: 0, maximum: 24 }
                mood: { type: integer, minimum: 1, maximum: 5 }
                rpe: { type: integer, minimum: 1, maximum: 10 }
                painReport: { type: string }
                notes: { type: string }
            DailyLogResult:
              type: object
              properties:
                id: { type: string, format: uuid }
                adherenceScore: { type: number }
                readinessScore: { type: number }
                xpGranted: { type: integer }
                safetyAlerts:
                  type: array
                  items: { type: string }
            AssessmentInput:
              type: object
              required: [assessmentDay]
              properties:
                assessmentDay: { type: integer, enum: [0, 30, 60, 90] }
                pushups2Min: { type: integer, minimum: 0 }
                squats2Min: { type: integer, minimum: 0 }
                situps2Min: { type: integer, minimum: 0 }
                pullupsMax: { type: integer, minimum: 0 }
                plankSeconds: { type: integer, minimum: 0 }
                run32KmMinutes: { type: number, minimum: 0 }
                waistCm: { type: number, minimum: 0 }
                weightKg: { type: number, minimum: 0 }
            Assessment:
              allOf:
                - $ref: "#/components/schemas/AssessmentInput"
                - type: object
                  properties:
                    id: { type: string, format: uuid }
            NutritionProtocol:
              type: object
              required: [code, name, objective]
              properties:
                code:
                  type: string
                  enum: [foundation, recomp, hypertrophy, cut, peak]
                name: { type: string }
                objective: { type: string }
                safetyBoundary: { type: string }
            NutritionPlanInput:
              type: object
              required: [goal, weightKg, waistCm, trainingFocus]
              properties:
                goal:
                  type: string
                  enum: [foundation, recomposition, hypertrophy, cut, peak]
                weightKg: { type: number, minimum: 20, maximum: 300 }
                waistCm: { type: number, minimum: 30, maximum: 250 }
                trainingFocus: { type: string }
                restrictions:
                  type: array
                  items: { type: string }
                hasClinicalCondition: { type: boolean, default: false }
            NutritionPlan:
              type: object
              required: [id, protocol, reviewCadenceDays]
              properties:
                id: { type: string, format: uuid }
                protocol:
                  $ref: "#/components/schemas/NutritionProtocol"
                calorieStrategy: { type: string }
                proteinGramsPerDay: { type: number }
                fatGramsPerDay: { type: number }
                carbStrategy: { type: string }
                reviewCadenceDays: { type: integer, enum: [14] }
                requiresProfessionalReview: { type: boolean }
            NutritionCheckInInput:
              type: object
              required: [protein, hydration, fruitsVegetables, plannedMeals, trainingAlignment, sleep, digestion, alcoholUltraProcessedControl]
              properties:
                protein: { type: integer, minimum: 0, maximum: 20 }
                hydration: { type: integer, minimum: 0, maximum: 15 }
                fruitsVegetables: { type: integer, minimum: 0, maximum: 15 }
                plannedMeals: { type: integer, minimum: 0, maximum: 15 }
                trainingAlignment: { type: integer, minimum: 0, maximum: 15 }
                sleep: { type: integer, minimum: 0, maximum: 10 }
                digestion: { type: integer, minimum: 0, maximum: 5 }
                alcoholUltraProcessedControl: { type: integer, minimum: 0, maximum: 5 }
            NutritionScore:
              type: object
              required: [score, tier]
              properties:
                score: { type: integer, minimum: 0, maximum: 100 }
                tier: { type: string, enum: [correction, bronze, silver, gold] }
                components:
                  $ref: "#/components/schemas/NutritionCheckInInput"
            NutritionReviewInput:
              type: object
              required: [periodDays, weightTrend, waistTrend, strengthTrend, sleepTrend, moodTrend]
              properties:
                periodDays: { type: integer, enum: [14, 30, 60, 90] }
                weightTrend: { type: string, enum: [down, stable, slow_up, fast_up] }
                waistTrend: { type: string, enum: [down, stable, slow_up, fast_up] }
                strengthTrend: { type: string, enum: [down, stable, up] }
                sleepTrend: { type: string, enum: [worse, stable, better] }
                moodTrend: { type: string, enum: [worse, stable, better] }
            NutritionReviewResult:
              type: object
              required: [decision, explanation]
              properties:
                decision:
                  type: string
                  enum: [maintain, add_carbs_25_40g, reduce_carbs_20_30g_or_fat, maintenance_week, professional_review_required]
                explanation: { type: string }
                safetyAlerts:
                  type: array
                  items: { type: string }
            GymContext:
              type: object
              properties:
                gymId: { type: string, format: uuid }
                facilityId: { type: string, format: uuid }
                cohortId: { type: string, format: uuid }
                role: { type: string, enum: [member, coach, nutritionist, manager, admin] }
                permissions:
                  type: array
                  items: { type: string }
            GymMemberInput:
              type: object
              required: [email, facilityId]
              properties:
                email: { type: string, format: email }
                facilityId: { type: string, format: uuid }
                cohortId: { type: string, format: uuid }
                goal: { type: string }
            GymMemberEnrollment:
              type: object
              required: [id, gymId, status]
              properties:
                id: { type: string, format: uuid }
                gymId: { type: string, format: uuid }
                facilityId: { type: string, format: uuid }
                userId: { type: string, format: uuid }
                cohortId: { type: string, format: uuid }
                status: { type: string, enum: [invited, active, paused, cancelled] }
            LabResultInput:
              type: object
              required: [biomarkerCode, value, unit, collectedAt, consentId]
              properties:
                biomarkerCode: { type: string }
                value: { type: number }
                unit: { type: string }
                collectedAt: { type: string, format: date-time }
                referenceRange: { type: string }
                consentId: { type: string, format: uuid }
            LabResult:
              allOf:
                - $ref: "#/components/schemas/LabResultInput"
                - type: object
                  properties:
                    id: { type: string, format: uuid }
                    trend: { type: string, enum: [unknown, improving, stable, worsening] }
            ShareLink:
              type: object
              required: [url, expiresAt]
              properties:
                url: { type: string, format: uri }
                expiresAt: { type: string, format: date-time }
            AiChatRequest:
              type: object
              required: [message]
              properties:
                message: { type: string, maxLength: 8000 }
                contextScope:
                  type: array
                  items: { type: string }
            AiChatResponse:
              type: object
              required: [message, safetyLevel]
              properties:
                message: { type: string }
                safetyLevel: { type: string, enum: [normal, caution, escalate] }
                citations:
                  type: array
                  items: { type: string }
                recommendedActions:
                  type: array
                  items: { type: string }
            GamificationProfile:
              type: object
              properties:
                xp: { type: integer }
                rank: { type: string }
                streakDays: { type: integer }
                badges:
                  type: array
                  items: { type: string }
            UserList:
              type: object
              properties:
                items:
                  type: array
                  items:
                    $ref: "#/components/schemas/UserContext"
                nextCursor: { type: string }
        """,
    )

    write(
        "docs/05-api/graphql-schema.graphql",
        """
        scalar Date
        scalar DateTime
        scalar JSON

        type Query {
          me: UserContext!
          currentProgram: ProgramPlan
          dailyLogs(range: DateRangeInput): [DailyLog!]!
          currentNutritionPlan: NutritionPlan
          nutritionProtocols: [NutritionProtocol!]!
          gymContext: GymContext
          gymMembers(gymId: ID!, cohortId: ID): [GymMemberEnrollment!]!
          assessments: [Assessment!]!
          dashboard: WarRoomDashboard!
          medicalTimeline: [MedicalTimelineItem!]!
          gamification: GamificationProfile!
        }

        type Mutation {
          completeOnboarding(input: OnboardingInput!): ProgramPlan!
          createDailyLog(input: DailyLogInput!): DailyLog!
          completeWorkoutSession(sessionId: ID!, input: CompleteWorkoutInput!): DailyLogResult!
          createNutritionPlan(input: NutritionPlanInput!): NutritionPlan!
          createNutritionCheckIn(input: NutritionCheckInInput!): NutritionScore!
          createNutritionReview(input: NutritionReviewInput!): NutritionReviewResult!
          inviteGymMember(gymId: ID!, input: GymMemberInput!): GymMemberEnrollment!
          createAssessment(input: AssessmentInput!): Assessment!
          createLabResult(input: LabResultInput!): LabResult!
          createAiChatResponse(input: AiChatInput!): AiChatResponse!
          revokeConsent(consentId: ID!): ConsentRecord!
        }

        type Subscription {
          dashboardUpdated: WarRoomDashboard!
          safetyAlertCreated: SafetyAlert!
          aiRecommendationCreated: AiRecommendation!
        }

        type UserContext {
          id: ID!
          tenantId: ID!
          email: String
          profile: UserProfile!
          entitlements: [String!]!
        }

        type UserProfile {
          displayName: String
          timezone: String!
          ageRange: String
          primaryGoal: String
        }

        type ConsentRecord {
          id: ID!
          purpose: String!
          status: ConsentStatus!
          grantedAt: DateTime
          revokedAt: DateTime
        }

        enum ConsentStatus { GRANTED REVOKED EXPIRED }

        type ProgramPlan {
          id: ID!
          phase: ProgramPhase!
          dayNumber: Int!
          startDate: Date!
          currentWeek: TrainingWeek
        }

        enum ProgramPhase { FOUNDATION STRENGTH PERFORMANCE GRADUATION }

        type TrainingWeek {
          weekNumber: Int!
          isDeload: Boolean!
          targetRpeMin: Int!
          targetRpeMax: Int!
          sessions: [WorkoutSession!]!
        }

        type WorkoutSession {
          id: ID!
          dayNumber: Int!
          title: String!
          focus: String!
          targetRpe: String!
          completedAt: DateTime
        }

        type DailyLog {
          id: ID!
          programDay: Int!
          workoutCompleted: Boolean!
          waterLiters: Float!
          sleepHours: Float!
          mood: Int!
          rpe: Int!
          notes: String
          safetyAlerts: [SafetyAlert!]!
        }

        type DailyLogResult {
          log: DailyLog!
          adherenceScore: Float!
          readinessScore: Float!
          xpGranted: Int!
          recommendation: AiRecommendation
        }

        type Assessment {
          id: ID!
          assessmentDay: Int!
          pushups2Min: Int
          squats2Min: Int
          situps2Min: Int
          pullupsMax: Int
          plankSeconds: Int
          run32KmMinutes: Float
          waistCm: Float
          weightKg: Float
        }

        type NutritionProtocol {
          code: NutritionProtocolCode!
          name: String!
          objective: String!
          safetyBoundary: String
        }

        enum NutritionProtocolCode { FOUNDATION RECOMP HYPERTROPHY CUT PEAK }

        type NutritionPlan {
          id: ID!
          protocol: NutritionProtocol!
          calorieStrategy: String
          proteinGramsPerDay: Float
          fatGramsPerDay: Float
          carbStrategy: String
          reviewCadenceDays: Int!
          requiresProfessionalReview: Boolean!
        }

        type NutritionScore {
          score: Int!
          tier: NutritionScoreTier!
          components: JSON!
        }

        enum NutritionScoreTier { CORRECTION BRONZE SILVER GOLD }

        type NutritionReviewResult {
          decision: NutritionReviewDecision!
          explanation: String!
          safetyAlerts: [String!]!
        }

        enum NutritionReviewDecision { MAINTAIN ADD_CARBS_25_40G REDUCE_CARBS_20_30G_OR_FAT MAINTENANCE_WEEK PROFESSIONAL_REVIEW_REQUIRED }

        type GymContext {
          gymId: ID
          facilityId: ID
          cohortId: ID
          role: GymRole
          permissions: [String!]!
        }

        enum GymRole { MEMBER COACH NUTRITIONIST MANAGER ADMIN }

        type GymMemberEnrollment {
          id: ID!
          gymId: ID!
          facilityId: ID
          userId: ID
          cohortId: ID
          status: GymEnrollmentStatus!
        }

        enum GymEnrollmentStatus { INVITED ACTIVE PAUSED CANCELLED }

        type WarRoomDashboard {
          adherence: Float!
          latestWeightKg: Float
          latestWaistCm: Float
          sleepAverage: Float
          moodAverage: Float
          riskLevel: RiskLevel!
          trends: JSON!
        }

        enum RiskLevel { LOW MODERATE HIGH ESCALATE }

        type LabResult {
          id: ID!
          biomarkerCode: String!
          value: Float!
          unit: String!
          collectedAt: DateTime!
          trend: String
        }

        type MedicalTimelineItem {
          id: ID!
          itemType: String!
          title: String!
          occurredAt: DateTime!
          summary: String
        }

        type AiChatResponse {
          message: String!
          safetyLevel: RiskLevel!
          citations: [String!]!
          recommendedActions: [String!]!
        }

        type AiRecommendation {
          id: ID!
          category: String!
          message: String!
          confidence: Float!
          safetyLevel: RiskLevel!
          createdAt: DateTime!
        }

        type SafetyAlert {
          id: ID!
          severity: RiskLevel!
          message: String!
          createdAt: DateTime!
        }

        type GamificationProfile {
          xp: Int!
          rank: String!
          streakDays: Int!
          badges: [String!]!
        }

        input DateRangeInput { from: Date, to: Date }
        input OnboardingInput { goals: [String!]!, readinessAnswers: JSON!, consentIds: [ID!]! }
        input DailyLogInput { programDay: Int!, workoutCompleted: Boolean!, waterLiters: Float!, sleepHours: Float!, mood: Int!, rpe: Int!, painReport: String, notes: String }
        input CompleteWorkoutInput { completed: Boolean!, rpe: Int!, notes: String }
        input NutritionPlanInput { goal: String!, weightKg: Float!, waistCm: Float!, trainingFocus: String!, restrictions: [String!], hasClinicalCondition: Boolean }
        input NutritionCheckInInput { protein: Int!, hydration: Int!, fruitsVegetables: Int!, plannedMeals: Int!, trainingAlignment: Int!, sleep: Int!, digestion: Int!, alcoholUltraProcessedControl: Int! }
        input NutritionReviewInput { periodDays: Int!, weightTrend: String!, waistTrend: String!, strengthTrend: String!, sleepTrend: String!, moodTrend: String! }
        input GymMemberInput { email: String!, facilityId: ID!, cohortId: ID, goal: String }
        input AssessmentInput { assessmentDay: Int!, pushups2Min: Int, squats2Min: Int, situps2Min: Int, pullupsMax: Int, plankSeconds: Int, run32KmMinutes: Float, waistCm: Float, weightKg: Float }
        input LabResultInput { biomarkerCode: String!, value: Float!, unit: String!, collectedAt: DateTime!, referenceRange: String, consentId: ID! }
        input AiChatInput { message: String!, contextScope: [String!] }
        """,
    )

    write(
        "docs/06-ai/phoenix-ai-engine.md",
        """
        # Phoenix AI Engine

        ## Objetivo

        Fornecer inteligencia contextual para orientar treinamento, recuperacao, nutricao, disciplina e leitura informativa de dados, sem substituir profissionais de saude.

        ## Arquitetura

        ```mermaid
        flowchart LR
          app[Web/Mobile/Admin] --> gateway[AI Gateway]
          gateway --> policy[Policy and Safety Guardrails]
          policy --> context[Context Builder]
          context --> rag[RAG Retriever]
          rag --> vector[(pgvector)]
          context --> prompt[Prompt Composer]
          prompt --> llm[Model Provider]
          llm --> verify[Response Verifier]
          verify --> audit[AI Audit Log]
          verify --> app
        ```

        ## Capacidades

        - Coach de treino: explica sessao, cadencia, progressao e regressao.
        - Coach de recuperacao: interpreta sono, RPE, humor e dor como sinais de ajuste.
        - Coach nutricional: sugere estrutura alimentar conforme metas e restricoes.
        - War Room insights: resume tendencias e pontos de atencao.
        - PMI informativo: organiza exames, graficos e perguntas para profissional.
        - Admin assistant: ajuda equipe a criar conteudo e revisar cohortes.

        ## Guardrails

        - Nunca diagnosticar, prescrever medicamento ou substituir avaliacao medica.
        - Diante de dor no peito, tontura, falta de ar desproporcional, perda de consciencia ou sinais criticos, orientar parada e busca de atendimento.
        - Usar linguagem de probabilidade e educacao, nao certeza clinica.
        - Citar origem interna quando usar plano, manual, diario ou exames.
        - Registrar prompt, contexto minimo, resposta, modelo, custo, latencia e decisao de seguranca.
        - Aplicar filtro de privacidade antes de enviar contexto para qualquer provedor.

        ## Contexto Permitido

        | Tipo | Permitido? | Observacao |
        |---|---:|---|
        | Plano de treino | Sim | Necessario para coaching operacional. |
        | Diario de sono/RPE/humor | Sim | Usar dados recentes e agregados. |
        | Exames e biomarcadores | Sim, com consentimento explicito | Usar linguagem informativa e limites medicos. |
        | Dados de pagamento | Nao | Apenas entitlement abstrato. |
        | Dados de terceiros | Nao | Bloquear sem consentimento e finalidade. |

        ## Avaliacao

        - Testes de regressao por prompt.
        - Golden set para perguntas de seguranca, dor, exames e progressao.
        - Revisao humana de respostas de alto risco.
        - Metricas: taxa de escalonamento, violacoes de policy, feedback negativo, latencia, custo por usuario ativo.
        - Red team trimestral para jailbreak, aconselhamento medico indevido e vazamento de dados.
        """,
    )

    write(
        "docs/06-ai/phoenix-medical-intelligence.md",
        """
        # Phoenix Medical Intelligence

        ## Posicionamento

        Phoenix Medical Intelligence (PMI) e um modulo de inteligencia informativa para organizar dados de saude, exames, lembretes, graficos e relatorios. Nao e dispositivo medico, nao realiza diagnostico e nao substitui profissional habilitado.

        ## Funcionalidades

        - Historico longitudinal de exames e biomarcadores.
        - Avaliacoes periodicas e lembretes de check-up.
        - Graficos de evolucao e comparacao com faixas de referencia cadastradas.
        - Relatorios executivos para usuario e profissional autorizado.
        - Recomendacoes informativas e perguntas sugeridas para consulta.
        - Alertas de seguranca para procurar avaliacao profissional quando houver sinais de risco.

        ## Dados

        - Dados coletados diretamente pelo usuario.
        - PDFs/imagens de exames enviados pelo usuario.
        - Integrações consentidas com HealthKit, Google Fit, wearables e laboratorios quando disponivel.
        - Metadados de fonte, data de coleta, unidade, faixa de referencia e confianca de extracao.

        ## Fluxo de Segurança

        ```mermaid
        flowchart LR
          upload[Upload/importacao] --> consent[Validar consentimento]
          consent --> classify[Classificar dado sensivel]
          classify --> extract[Extrair e normalizar]
          extract --> trend[Calcular tendencia]
          trend --> risk{Sinal critico?}
          risk -->|Sim| escalate[Escalonar: recomendar avaliacao profissional]
          risk -->|Nao| report[Atualizar dashboard e relatorio]
          escalate --> audit[Auditoria]
          report --> audit
        ```

        ## Requisitos Regulatorios

        - LGPD: dados de saude sao dados pessoais sensiveis e exigem base legal, finalidade, seguranca, transparencia e direitos do titular.
        - GDPR readiness: dados de saude tem categoria especial e exigem protecoes reforcadas quando houver residentes da UE.
        - HIPAA readiness: se a plataforma atuar como business associate de covered entities nos EUA, exigir BAA, controles de ePHI, breach notification e safeguards.

        ## Linguagem Permitida

        - Permitido: "seu resultado esta acima da faixa de referencia informada pelo laboratorio; considere conversar com um profissional de saude."
        - Proibido: "voce tem X doenca", "pare medicamento", "inicie tratamento", "nao precisa procurar medico".
        - Obrigatorio: contexto, fonte, data do exame, limite informativo e recomendacao de acompanhamento profissional quando aplicavel.
        """,
    )

    write(
        "docs/07-ux-ui/design-system.md",
        """
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
        """,
    )

    write(
        "docs/08-mobile/mobile-app-spec.md",
        """
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
        """,
    )

    write(
        "docs/09-gamification/gamification-system.md",
        """
        # Sistema de Gamificacao

        ## Objetivo

        Aumentar adesao sem incentivar excesso de treino, risco articular ou comportamento compulsivo.

        ## Elementos

        - XP por consistencia, nao por sofrimento.
        - Patentes por fase: Recruta, Operador, Veterano, Graduado.
        - Badges por marcos: Dia 7, Dia 30, Dia 60, Dia 90, deload concluido, check-in perfeito.
        - Streaks com congelamento limitado para preservar retorno sem culpa.
        - Desafios semanais com faixas bronze, prata e ouro.
        - Certificado de graduacao com resumo de evolucao.

        ## Regras de XP

        | Evento | XP |
        |---|---:|
        | Check-in diario completo | 10 |
        | Treino concluido dentro da faixa RPE | 20 |
        | Deload respeitado | 30 |
        | Reteste registrado | 50 |
        | Dor articular reportada e regressao aplicada | 25 |
        | Dia 90 concluido | 200 |

        ## Anti-Gaming

        - Nao premiar RPE extremo.
        - Limitar XP por dia.
        - Detectar registros repetitivos ou impossiveis.
        - Valorizar recuperacao, sono e tecnica.
        - Bloquear leaderboard publico para metricas sensiveis sem opt-in.

        ## Sinais de Risco

        - RPE alto por varios dias.
        - Sono baixo e aumento de volume.
        - Dor articular recorrente.
        - Treinos duplicados para ganhar XP.
        - Perda de peso agressiva.

        Quando houver risco, o sistema deve reduzir incentivos de volume e priorizar recuperacao.
        """,
    )

    write(
        "docs/10-security-compliance/security-lgpd-gdpr-hipaa.md",
        """
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
        """,
    )

    write(
        "docs/11-monetization/saas-strategy.md",
        """
        # Estrategia de Monetizacao SaaS

        ## Posicionamento

        Phoenix Protocol(R) deve combinar programa guiado de 90 dias, inteligencia personalizada, acompanhamento longitudinal e comunidade/continuidade pos-graduacao.

        ## Planos

        | Plano | Publico | Inclui |
        |---|---|---|
        | Free/Preview | leads | conteudo limitado, checklist inicial, amostra do War Room |
        | Individual | usuario final | programa 90 dias, diario, dashboard, IA limitada, gamificacao |
        | Pro | usuario avancado | IA ampliada, relatorios, PMI completo, integracoes, exports |
        | Coach | profissionais | cohortes, admin de alunos, templates, relatorios e comunicacao |
        | Enterprise | empresas/equipes | multi-tenant avancado, SSO, SLA, compliance, suporte dedicado |

        ## Alavancas

        - Trial de 7 a 14 dias com ativacao no Dia 1.
        - Annual plan com desconto.
        - Upsell para Pro em PMI, relatorios e IA.
        - Add-on de coach/cohorte.
        - Conteudos premium e proximas missoes apos Dia 90.

        ## Metricas

        - Visitante para cadastro.
        - Cadastro para Dia 1.
        - Dia 1 para D7.
        - Trial para pago.
        - Retencao D30/D60/D90.
        - Churn mensal.
        - ARPA, LTV, CAC, payback.
        - Uso de IA por usuario e custo por insight.

        ## Riscos Comerciais

        - Claims de saude excessivos: mitigar com linguagem e revisao juridica.
        - Custo de IA maior que margem: quotas, cache, modelos por tarefa.
        - Retencao apos 90 dias: criar Continuation Plan e Phoenix Legacy.
        - Complexidade enterprise cedo demais: validar primeiro Individual/Pro.
        """,
    )

    write(
        "docs/12-cloud-devops/cloud-deployment.md",
        """
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
        """,
    )

    write(
        "docs/12-cloud-devops/devops-cicd.md",
        """
        # DevOps e CI/CD

        ## Branching

        - `main`: sempre deployable.
        - `feature/*`: desenvolvimento.
        - `release/*`: estabilizacao quando necessario.
        - Tags semanticas para releases.

        ## Pipeline

        ```mermaid
        flowchart LR
          commit[Commit/PR] --> lint[Lint + format]
          lint --> test[Unit tests]
          test --> contract[API contract tests]
          contract --> security[SAST/Deps/Secrets/IaC]
          security --> build[Build containers]
          build --> deployStaging[Deploy staging]
          deployStaging --> e2e[E2E + smoke]
          e2e --> approval[Approval prod]
          approval --> deployProd[Blue/green or canary]
          deployProd --> monitor[Monitor SLO]
        ```

        ## Gates

        - Cobertura minima por pacote critico.
        - Sem vulnerabilidades criticas conhecidas.
        - Sem segredo em commit.
        - Migrations testadas com rollback.
        - OpenAPI/GraphQL validos quando contratos mudarem.
        - Smoke tests de login, diario, treino, dashboard, IA e billing.

        ## Observabilidade

        - Trace ID em toda requisicao.
        - Logs JSON com tenant, user hash, request id, modulo e severidade.
        - Metricas: latencia, erro, throughput, custo IA, filas, webhooks.
        - Alertas: erro 5xx, login failure spike, billing webhook failure, medical access anomaly.

        ## Release

        - Canary para backend.
        - Feature flags para modulos novos.
        - Rollback automatico quando SLO de erro/latencia rompe.
        - Post-release check em ate 30 minutos.
        """,
    )

    write(
        "docs/13-operations/admin-manual.md",
        """
        # Manual do Administrador

        ## Perfis

        - Super Admin: configuracao global, tenants, compliance e billing.
        - Tenant Admin: usuarios, cohortes, conteudo e suporte do tenant.
        - Coach: acompanhamento de progresso, comentarios e relatorios permitidos.
        - Security Admin: auditoria, incidentes, acessos e controles.
        - Content Editor: conteudo, licoes, exercicios e traducoes.

        ## Rotinas

        - Revisar novos usuarios e ativacao.
        - Monitorar alertas de seguranca, dor e desistência.
        - Publicar conteudo apos aprovacao.
        - Acompanhar falhas de pagamento e entitlements.
        - Revisar logs de acesso a dados sensiveis.
        - Exportar relatorios somente com finalidade e permissao.

        ## Acoes Sensíveis

        - Acessar dados medicos.
        - Exportar dados.
        - Revogar ou alterar consentimento.
        - Alterar plano/entitlement manualmente.
        - Impersonar usuario para suporte.
        - Excluir dados.

        Toda acao sensivel exige justificativa, MFA e auditoria.

        ## Conteudo

        - Exercicios devem ter nivel, regressao, progressao, cues e contraindicações.
        - Conteudo medico deve ser informativo e revisado.
        - Devocional deve respeitar opt-in.
        - Alteracoes de plano devem preservar historico.

        ## Incidentes

        Admin deve classificar, conter, registrar evidencias e acionar Security Admin/DPO. Nunca apagar logs ou evidencias durante investigacao.
        """,
    )

    write(
        "docs/13-operations/user-manual.md",
        """
        # Manual do Usuario

        ## Comeco

        1. Crie sua conta.
        2. Complete o onboarding.
        3. Leia e aceite os termos aplicaveis.
        4. Responda a prontidao.
        5. Registre sua linha de base no Dia 0.
        6. Inicie o Dia 1.

        ## Diario

        Todos os dias registre:

        - Treino cumprido.
        - Agua.
        - Sono.
        - Humor.
        - RPE.
        - Dor ou observacoes.

        ## Treino

        Siga o treino do dia e respeite o RPE alvo. Se houver dor articular, reduza nivel, pause ou procure orientacao profissional conforme alerta do app.

        ## Retestes

        - Dia 30: reteste parcial e medidas.
        - Dia 60: bateria completa.
        - Dia 90: prova final e relatorio.

        ## Medical

        O modulo Medical organiza dados e exames para acompanhamento informativo. Ele nao diagnostica, nao prescreve e nao substitui atendimento medico.

        ## Privacidade

        Voce pode revisar consentimentos, baixar dados, solicitar exclusao ou revogar compartilhamentos conforme disponibilidade legal e contratual.
        """,
    )

    write(
        "docs/14-quality/qa-test-plan.md",
        """
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
        """,
    )

    write(
        "docs/15-roadmap/roadmap-5-years.md",
        """
        # Roadmap de 5 Anos

        ## Ano 1 - Fundacao e MVP

        - Plataforma web/mobile.
        - Programa 90 dias completo.
        - War Room Dashboard.
        - AI Command Center v1.
        - PMI informativo v1.
        - Assinaturas Individual/Pro.
        - LGPD baseline.

        ## Ano 2 - Retencao e Coach

        - Coach console e cohortes.
        - Conteudo avancado e proximas missoes.
        - Gamificacao sazonal.
        - Integracoes com wearables.
        - Analytics de retencao e risco de abandono.

        ## Ano 3 - Enterprise e Medical Readiness

        - SSO/SAML, tenant dedicado e SLA.
        - Compliance reforcado, DPIA e processos de auditoria.
        - PMI com relatorios profissionais e revisão humana opcional.
        - Marketplace controlado de coaches/profissionais.

        ## Ano 4 - Inteligencia Adaptativa

        - Modelos preditivos de adesao, risco e progressao.
        - Personalizacao automatizada com explicabilidade.
        - Ensaios controlados de programas e protocolos.
        - Expansao internacional com localizacao.

        ## Ano 5 - Ecossistema Phoenix

        - Plataforma de parceiros.
        - APIs publicas governadas.
        - Protocolos especializados por objetivo.
        - Health ecosystem com conformidade por regiao.
        - Phoenix Legacy como comunidade e continuidade de longo prazo.
        """,
    )

    write(
        "prompts/lovable.md",
        """
        # Prompt para Lovable

        Voce e um arquiteto full-stack senior. Construa a plataforma SaaS Phoenix Protocol(R) Performance Operating System usando os documentos deste workspace como fonte obrigatoria.

        ## Stack

        - Next.js + React + TypeScript.
        - Tailwind com tokens de `docs/07-ux-ui/design-system.md`.
        - PostgreSQL/Supabase com modelo de `docs/04-data/`.
        - API baseada em `docs/05-api/openapi.yaml`.
        - IA mediada pelo Phoenix AI Engine, nunca chamada diretamente pela UI.

        ## Regras

        - Nao criar modulo fora dos 11 modulos oficiais sem atualizar PRD.
        - Implementar multi-tenancy e RBAC desde o inicio.
        - Dados medicos exigem consentimento e auditoria.
        - IA nao diagnostica e nao prescreve.
        - UI deve priorizar diario, treino do dia e War Room.
        - Criar telas reais, nao landing page.

        ## Primeiro Incremento

        1. Auth e onboarding.
        2. Programa atual de 90 dias.
        3. Diario e workout session.
        4. Dashboard War Room.
        5. Estrutura admin minima.
        """,
    )

    write(
        "prompts/claude-code.md",
        """
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
        """,
    )

    write(
        "prompts/cursor.md",
        """
        # Prompt para Cursor

        Use este workspace como fonte de verdade. Ao gerar codigo:

        - Siga os contratos em `docs/05-api/`.
        - Use entidades do catalogo em `docs/04-data/entity-catalog.csv`.
        - Aplique tokens e componentes do design system.
        - Nunca crie recomendacao medica diagnostica.
        - Sempre considere multi-tenant, auditoria e consentimento.
        - Prefira alteracoes pequenas, testaveis e alinhadas ao PRD.

        Para cada feature, gere:

        1. Modelo/migracao.
        2. Endpoint ou resolver.
        3. UI.
        4. Testes.
        5. Telemetria.
        6. Atualizacao de documentacao se contrato mudar.
        """,
    )

    write(
        "prompts/github-copilot.md",
        """
        # Prompt para GitHub Copilot

        Instrucoes de repositorio para Copilot:

        - Produto: Phoenix Protocol(R) Performance Operating System.
        - Arquitetura: modular monolith TypeScript evolutivo, multi-tenant, PostgreSQL.
        - Contratos: OpenAPI e GraphQL em `docs/05-api/`.
        - Dados: catalogo em `docs/04-data/entity-catalog.csv`.
        - Segurança: LGPD/GDPR/HIPAA readiness, consentimento e auditoria.
        - IA: Phoenix AI Engine com guardrails; sem diagnostico, prescricao ou aconselhamento medico definitivo.
        - UX: diario rapido, treino do dia, War Room, design system escuro e operacional.

        Ao sugerir codigo, preserve:

        - Tenant isolation.
        - Object-level authorization.
        - Structured logging sem dados sensiveis.
        - Testes para regras de dominio.
        - Idempotencia em webhooks, jobs e importacoes.
        """,
    )

    write(
        "docs/99-references/official-standards-and-sources.md",
        """
        # Referencias Oficiais

        - C4 Model: https://c4model.com/
        - UML 2.5.1: https://www.omg.org/spec/UML/2.5.1/
        - BPMN 2.0.2: https://www.omg.org/spec/BPMN/2.0.2/
        - OpenAPI 3.1.1 (versao usada no contrato por compatibilidade): https://spec.openapis.org/oas/v3.1.1.html
        - OpenAPI latest 3.2.0: https://spec.openapis.org/oas/latest.html
        - GraphQL Specification: https://spec.graphql.org/October2021/
        - OWASP ASVS: https://owasp.org/www-project-application-security-verification-standard/
        - LGPD Lei 13.709/2018: https://www.planalto.gov.br/ccivil_03/_ato2015-2018/2018/lei/l13709.htm
        - GDPR Regulation (EU) 2016/679: https://eur-lex.europa.eu/eli/reg/2016/679/oj
        - HIPAA Privacy Rule: https://www.hhs.gov/hipaa/for-professionals/privacy/laws-regulations/index.html
        - HIPAA Security Rule: https://www.hhs.gov/hipaa/for-professionals/security/laws-regulations/index.html
        - HIPAA Breach Notification: https://www.hhs.gov/hipaa/for-professionals/breach-notification/index.html
        - AWS Well-Architected Framework: https://docs.aws.amazon.com/wellarchitected/latest/framework/welcome.html
        - Azure Well-Architected Framework: https://learn.microsoft.com/en-us/azure/well-architected/
        - Google Cloud Architecture Framework: https://cloud.google.com/architecture/framework
        """,
    )

    write(
        "adr/0001-platform-baseline.md",
        """
        # ADR 0001 - Baseline de Plataforma

        ## Status

        Aceita.

        ## Contexto

        O Phoenix Protocol(R) precisa evoluir de materiais de programa de 90 dias para plataforma SaaS com web, mobile, IA, dados sensiveis, gamificacao, billing e operacao.

        ## Decisao

        Adotar uma arquitetura modular, multi-tenant, TypeScript-first, com PostgreSQL como banco operacional, contratos OpenAPI/GraphQL e Phoenix AI Engine como camada isolada para uso de modelos.

        ## Consequencias

        - O MVP pode ser entregue como modular monolith com fronteiras fortes.
        - Dados medicos e IA terao controles reforcados desde o inicio.
        - Servicos podem ser extraidos quando escala, compliance ou equipe justificarem.
        - A documentacao em `docs/` passa a ser fonte de verdade para geracao por IA.
        """,
    )


def copy_artifact(source: str, destination: str) -> None:
    target = ROOT / destination
    target.parent.mkdir(parents=True, exist_ok=True)
    shutil.copyfile(ROOT / source, target)


def generate_project_document_structure() -> None:
    folders = [
        "documentos/01_Gerencia_Projeto",
        "documentos/02_Especificacao_Funcional",
        "documentos/03_Analisar_Projeto",
        "documentos/04_Testes",
        "documentos/05_Implantacao",
        "documentos/06_Gerencia_Configuracao",
        "documentos/07_Homologacao",
        "documentos/08_Manuais/00_WebServices",
    ]
    for folder in folders:
        path = ROOT / folder
        path.mkdir(parents=True, exist_ok=True)
        (path / ".gitkeep").write_text("", encoding="utf-8")

    write(
        "documentos/README.md",
        """
        # Phoenix Protocol - Estrutura Documental de Engenharia

        Estrutura de diretorios para entrega profissional de projeto, documentacao oficial, geracao assistida por IA e evolucao controlada do Phoenix Protocol(R).

        ## Diretorios

        | Massa | Conteudo |
        |---|---|
        | `01_Gerencia_Projeto` | Plano de projeto, cronograma, governanca, atas, status e riscos |
        | `02_Especificacao_Funcional` | Documento de visao, PRD, historias de usuario, requisitos e especificacoes funcionais |
        | `03_Analisar_Projeto` | Arquitetura C4, UML, BPMN, modelo de dados, catalogo de entidades e DDL |
        | `04_Testes` | Plano de testes, casos de teste, evidencias e criterios de aceite |
        | `05_Implantacao` | Plano de nuvem, DevOps, CI/CD, scripts e checklist de implantacao |
        | `06_Gerencia_Configuracao` | ADRs, padroes de engenharia, controle de versoes e linhas de base |
        | `07_Homologacao` | Evidencias de homologacao, termo de aceite e checklist de release |
        | `08_Manuais` | Manual do usuario, manual do administrador, UX/UI, mobile e documentacao tecnica |
        | `08_Manuais/00_WebServices` | OpenAPI/Swagger, GraphQL e contratos de API |

        ## Repositorio GitHub

        Remote esperado: `https://github.com/kleberoliveiraa/phoenix_protocol.git`
        """,
    )

    write(
        "documentos/01_Gerencia_Projeto/PHOENIX_Plano_Projeto.md",
        """
        # Plano de Projeto - Phoenix Protocol

        ## Objetivo

        Organizar o Phoenix Protocol(R) como plataforma SaaS B2C/B2B/B2B2C para usuarios individuais, academias, coaches, nutricionistas parceiros e administradores.

        ## Marcos

        | Marco | Entrega |
        |---|---|
        | M1 | Documentacao oficial, contratos API, dados, prompts e repositorio GitHub |
        | M2 | MVP web/mobile com onboarding, diario, treino, War Room e IA |
        | M3 | Phoenix Nutrition System, academias, cohortes e dashboards B2B |
        | M4 | Phoenix Medical Intelligence, relatorios, compliance e auditoria reforcada |
        | M5 | Escala SaaS, billing, analytics, homologacao e operacao |

        ## Governanca

        - PRD, C4, dados e API devem ser atualizados antes de codigo.
        - Mudancas arquiteturais exigem ADR.
        - Dados de saude, nutricao e academia exigem consentimento, finalidade e auditoria.
        """,
    )

    write(
        "documentos/02_Especificacao_Funcional/PHOENIX_Especificacao_Funcional.md",
        """
        # Especificacao Funcional - Phoenix Protocol

        Este documento consolida os principais fluxos funcionais. A fonte detalhada fica no PRD desta pasta.

        ## Fluxos

        - Onboarding, prontidao, consentimentos e baseline.
        - Plano de 90 dias, treino diario, RPE, dor, deloads e desafios.
        - Phoenix Nutrition System: Foundation, Recomp, Hypertrophy, Cut, Peak, score e revisoes de 14 dias.
        - Academias: tenant B2B, unidades, alunos, staff, cohortes, dashboards e retencao.
        - Phoenix AI Engine: coach informativo com guardrails.
        - Phoenix Medical Intelligence: exames, biomarcadores, lembretes e relatorios informativos.
        - Admin, billing, gamificacao, suporte e auditoria.
        """,
    )

    write(
        "documentos/02_Especificacao_Funcional/PHOENIX_Historias_Usuario.md",
        """
        # Historias de Usuario

        | ID | Historia | Prioridade |
        |---|---|---|
        | US-CORE-001 | Como usuario, quero completar onboarding e prontidao para iniciar com seguranca. | Must |
        | US-CORE-002 | Como usuario, quero registrar meu treino diario em ate 2 minutos. | Must |
        | US-CORE-003 | Como usuario, quero visualizar minha evolucao no War Room. | Must |
        | US-AI-001 | Como usuario, quero receber orientacoes informativas da IA com limites de seguranca. | Should |
        | US-MED-001 | Como usuario, quero registrar exames e acompanhar tendencias sem receber diagnostico automatico. | Should |
        | US-GYM-001 | Como gestor de academia, quero cadastrar unidade, equipe e alunos. | Must |
        | US-GYM-002 | Como coach, quero acompanhar cohortes por adesao, risco e progresso. | Must |
        | US-NUT-001 | Como aluno, quero um protocolo nutricional alinhado ao meu treino e objetivo. | Must |
        | US-NUT-002 | Como aluno em hipertrofia, quero revisar peso, cintura, forca e sono a cada 14 dias. | Must |
        | US-NUT-003 | Como nutricionista parceiro, quero revisar casos com exames, intolerancias, medicamentos ou condicoes clinicas. | Should |
        """,
    )

    write(
        "documentos/07_Homologacao/PHOENIX_Checklist_Homologacao.md",
        """
        # Checklist de Homologacao

        - PRD aprovado.
        - C4, UML e BPMN revisados.
        - Catalogo de dados e DDL revisados.
        - OpenAPI e GraphQL validados.
        - Fluxos de onboarding, diario, treino, nutricao, academia, IA, medical e billing testados.
        - LGPD/GDPR/HIPAA readiness revisado para dados sensiveis.
        - Evidencias de QA anexadas.
        - Termo de aceite assinado pelo responsavel do produto.
        """,
    )

    write(
        ".gitignore",
        """
        # OS/editor
        .DS_Store
        Thumbs.db
        .vscode/
        .idea/

        # Dependencies/build
        node_modules/
        dist/
        build/
        .next/
        coverage/

        # Runtime/temp
        .env
        .env.*
        !.env.example
        __pycache__/
        *.pyc
        tmp/
        .tmp/
        .codex_tmp/

        # Logs
        *.log
        npm-debug.log*
        yarn-debug.log*
        pnpm-debug.log*
        """,
    )

    copy_artifact("docs/01-product/prd.md", "documentos/02_Especificacao_Funcional/PHOENIX_PRD_Documento_Visao_Produto.md")
    copy_artifact("docs/02-architecture/c4-model.md", "documentos/03_Analisar_Projeto/PHOENIX_Arquitetura_C4.md")
    copy_artifact("docs/03-process/uml-diagrams.md", "documentos/03_Analisar_Projeto/PHOENIX_Diagramas_UML.md")
    copy_artifact("docs/03-process/bpmn-processes.md", "documentos/03_Analisar_Projeto/PHOENIX_Processos_BPMN.md")
    copy_artifact("docs/04-data/database-model.md", "documentos/03_Analisar_Projeto/PHOENIX_Modelo_Dados.md")
    copy_artifact("docs/04-data/entity-catalog.csv", "documentos/03_Analisar_Projeto/PHOENIX_Catalogo_Entidades.csv")
    copy_artifact("docs/04-data/postgresql-logical-ddl.sql", "documentos/03_Analisar_Projeto/PHOENIX_DDL_PostgreSQL.sql")
    copy_artifact("docs/14-quality/qa-test-plan.md", "documentos/04_Testes/PHOENIX_Plano_Testes_QA.md")
    copy_artifact("docs/12-cloud-devops/cloud-deployment.md", "documentos/05_Implantacao/PHOENIX_Plano_Implantacao_Cloud.md")
    copy_artifact("docs/12-cloud-devops/devops-cicd.md", "documentos/05_Implantacao/PHOENIX_DevOps_CICD.md")
    copy_artifact("docs/00-overview/engineering-standard.md", "documentos/06_Gerencia_Configuracao/PHOENIX_Padrao_Engenharia.md")
    copy_artifact("adr/0001-platform-baseline.md", "documentos/06_Gerencia_Configuracao/ADR_0001_Platform_Baseline.md")
    copy_artifact("docs/13-operations/user-manual.md", "documentos/08_Manuais/PHOENIX_Manual_Usuario.md")
    copy_artifact("docs/13-operations/admin-manual.md", "documentos/08_Manuais/PHOENIX_Manual_Administrador.md")
    copy_artifact("docs/07-ux-ui/design-system.md", "documentos/08_Manuais/PHOENIX_Design_System_UX_UI.md")
    copy_artifact("docs/08-mobile/mobile-app-spec.md", "documentos/08_Manuais/PHOENIX_Especificacao_Mobile.md")
    copy_artifact("docs/05-api/openapi.yaml", "documentos/08_Manuais/00_WebServices/PHOENIX_OpenAPI.yaml")
    copy_artifact("docs/05-api/graphql-schema.graphql", "documentos/08_Manuais/00_WebServices/PHOENIX_GraphQL_Schema.graphql")


if __name__ == "__main__":
    generate_docs()
    generate_entity_catalog()
    generate_project_document_structure()
    print(f"Generated Phoenix documentation with {len(entity_rows())} entities.")
