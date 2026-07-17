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
