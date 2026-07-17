-- Phoenix Protocol(R) - logical PostgreSQL schema baseline

-- Generated from docs/04-data/entity-catalog.csv.

-- This file is intended as a complete logical inventory for platform generation.

-- Production migrations should harden high-volume tables with domain-specific columns before launch.



CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE EXTENSION IF NOT EXISTS citext;



CREATE SCHEMA IF NOT EXISTS ai;

CREATE SCHEMA IF NOT EXISTS analytics;

CREATE SCHEMA IF NOT EXISTS billing;

CREATE SCHEMA IF NOT EXISTS body;

CREATE SCHEMA IF NOT EXISTS combat;

CREATE SCHEMA IF NOT EXISTS communications;

CREATE SCHEMA IF NOT EXISTS content;

CREATE SCHEMA IF NOT EXISTS gamification;

CREATE SCHEMA IF NOT EXISTS gym;

CREATE SCHEMA IF NOT EXISTS identity;

CREATE SCHEMA IF NOT EXISTS integrations;

CREATE SCHEMA IF NOT EXISTS legacy;

CREATE SCHEMA IF NOT EXISTS medical;

CREATE SCHEMA IF NOT EXISTS mental;

CREATE SCHEMA IF NOT EXISTS nutrition;

CREATE SCHEMA IF NOT EXISTS recovery;

CREATE SCHEMA IF NOT EXISTS security;

CREATE SCHEMA IF NOT EXISTS spiritual;

CREATE SCHEMA IF NOT EXISTS war_room;



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

CREATE TABLE IF NOT EXISTS identity.organization (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE identity.organization IS 'Entidade de Foundation Intelligence para Organization.';
CREATE INDEX IF NOT EXISTS ix_identity_organization_tenant ON identity.organization(tenant_id);
CREATE INDEX IF NOT EXISTS ix_identity_organization_user ON identity.organization(user_id);
CREATE INDEX IF NOT EXISTS ix_identity_organization_attrs ON identity.organization USING gin(attributes);

CREATE TABLE IF NOT EXISTS identity.tenant_domain (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE identity.tenant_domain IS 'Entidade de Foundation Intelligence para TenantDomain.';
CREATE INDEX IF NOT EXISTS ix_identity_tenant_domain_tenant ON identity.tenant_domain(tenant_id);
CREATE INDEX IF NOT EXISTS ix_identity_tenant_domain_user ON identity.tenant_domain(user_id);
CREATE INDEX IF NOT EXISTS ix_identity_tenant_domain_attrs ON identity.tenant_domain USING gin(attributes);

CREATE TABLE IF NOT EXISTS identity.user_profile (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE identity.user_profile IS 'Entidade de Foundation Intelligence para UserProfile.';
CREATE INDEX IF NOT EXISTS ix_identity_user_profile_tenant ON identity.user_profile(tenant_id);
CREATE INDEX IF NOT EXISTS ix_identity_user_profile_user ON identity.user_profile(user_id);
CREATE INDEX IF NOT EXISTS ix_identity_user_profile_attrs ON identity.user_profile USING gin(attributes);

CREATE TABLE IF NOT EXISTS identity.user_preference (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE identity.user_preference IS 'Entidade de Foundation Intelligence para UserPreference.';
CREATE INDEX IF NOT EXISTS ix_identity_user_preference_tenant ON identity.user_preference(tenant_id);
CREATE INDEX IF NOT EXISTS ix_identity_user_preference_user ON identity.user_preference(user_id);
CREATE INDEX IF NOT EXISTS ix_identity_user_preference_attrs ON identity.user_preference USING gin(attributes);

CREATE TABLE IF NOT EXISTS identity.user_device (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE identity.user_device IS 'Entidade de Foundation Intelligence para UserDevice.';
CREATE INDEX IF NOT EXISTS ix_identity_user_device_tenant ON identity.user_device(tenant_id);
CREATE INDEX IF NOT EXISTS ix_identity_user_device_user ON identity.user_device(user_id);
CREATE INDEX IF NOT EXISTS ix_identity_user_device_attrs ON identity.user_device USING gin(attributes);

CREATE TABLE IF NOT EXISTS identity.role (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE identity.role IS 'Entidade de Foundation Intelligence para Role.';
CREATE INDEX IF NOT EXISTS ix_identity_role_tenant ON identity.role(tenant_id);
CREATE INDEX IF NOT EXISTS ix_identity_role_user ON identity.role(user_id);
CREATE INDEX IF NOT EXISTS ix_identity_role_attrs ON identity.role USING gin(attributes);

CREATE TABLE IF NOT EXISTS identity.permission (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE identity.permission IS 'Entidade de Foundation Intelligence para Permission.';
CREATE INDEX IF NOT EXISTS ix_identity_permission_tenant ON identity.permission(tenant_id);
CREATE INDEX IF NOT EXISTS ix_identity_permission_user ON identity.permission(user_id);
CREATE INDEX IF NOT EXISTS ix_identity_permission_attrs ON identity.permission USING gin(attributes);

CREATE TABLE IF NOT EXISTS identity.role_permission (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE identity.role_permission IS 'Entidade de Foundation Intelligence para RolePermission.';
CREATE INDEX IF NOT EXISTS ix_identity_role_permission_tenant ON identity.role_permission(tenant_id);
CREATE INDEX IF NOT EXISTS ix_identity_role_permission_user ON identity.role_permission(user_id);
CREATE INDEX IF NOT EXISTS ix_identity_role_permission_attrs ON identity.role_permission USING gin(attributes);

CREATE TABLE IF NOT EXISTS identity.membership (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE identity.membership IS 'Entidade de Foundation Intelligence para Membership.';
CREATE INDEX IF NOT EXISTS ix_identity_membership_tenant ON identity.membership(tenant_id);
CREATE INDEX IF NOT EXISTS ix_identity_membership_user ON identity.membership(user_id);
CREATE INDEX IF NOT EXISTS ix_identity_membership_attrs ON identity.membership USING gin(attributes);

CREATE TABLE IF NOT EXISTS identity.invitation (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE identity.invitation IS 'Entidade de Foundation Intelligence para Invitation.';
CREATE INDEX IF NOT EXISTS ix_identity_invitation_tenant ON identity.invitation(tenant_id);
CREATE INDEX IF NOT EXISTS ix_identity_invitation_user ON identity.invitation(user_id);
CREATE INDEX IF NOT EXISTS ix_identity_invitation_attrs ON identity.invitation USING gin(attributes);

CREATE TABLE IF NOT EXISTS identity.session (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE identity.session IS 'Entidade de Foundation Intelligence para Session.';
CREATE INDEX IF NOT EXISTS ix_identity_session_tenant ON identity.session(tenant_id);
CREATE INDEX IF NOT EXISTS ix_identity_session_user ON identity.session(user_id);
CREATE INDEX IF NOT EXISTS ix_identity_session_attrs ON identity.session USING gin(attributes);

CREATE TABLE IF NOT EXISTS identity.refresh_token (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE identity.refresh_token IS 'Entidade de Foundation Intelligence para RefreshToken.';
CREATE INDEX IF NOT EXISTS ix_identity_refresh_token_tenant ON identity.refresh_token(tenant_id);
CREATE INDEX IF NOT EXISTS ix_identity_refresh_token_user ON identity.refresh_token(user_id);
CREATE INDEX IF NOT EXISTS ix_identity_refresh_token_attrs ON identity.refresh_token USING gin(attributes);

CREATE TABLE IF NOT EXISTS identity.identity_provider (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE identity.identity_provider IS 'Entidade de Foundation Intelligence para IdentityProvider.';
CREATE INDEX IF NOT EXISTS ix_identity_identity_provider_tenant ON identity.identity_provider(tenant_id);
CREATE INDEX IF NOT EXISTS ix_identity_identity_provider_user ON identity.identity_provider(user_id);
CREATE INDEX IF NOT EXISTS ix_identity_identity_provider_attrs ON identity.identity_provider USING gin(attributes);

CREATE TABLE IF NOT EXISTS identity.mfa_factor (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE identity.mfa_factor IS 'Entidade de Foundation Intelligence para MfaFactor.';
CREATE INDEX IF NOT EXISTS ix_identity_mfa_factor_tenant ON identity.mfa_factor(tenant_id);
CREATE INDEX IF NOT EXISTS ix_identity_mfa_factor_user ON identity.mfa_factor(user_id);
CREATE INDEX IF NOT EXISTS ix_identity_mfa_factor_attrs ON identity.mfa_factor USING gin(attributes);

CREATE TABLE IF NOT EXISTS identity.consent_record (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE identity.consent_record IS 'Entidade de Foundation Intelligence para ConsentRecord.';
CREATE INDEX IF NOT EXISTS ix_identity_consent_record_tenant ON identity.consent_record(tenant_id);
CREATE INDEX IF NOT EXISTS ix_identity_consent_record_user ON identity.consent_record(user_id);
CREATE INDEX IF NOT EXISTS ix_identity_consent_record_attrs ON identity.consent_record USING gin(attributes);

CREATE TABLE IF NOT EXISTS identity.privacy_preference (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE identity.privacy_preference IS 'Entidade de Foundation Intelligence para PrivacyPreference.';
CREATE INDEX IF NOT EXISTS ix_identity_privacy_preference_tenant ON identity.privacy_preference(tenant_id);
CREATE INDEX IF NOT EXISTS ix_identity_privacy_preference_user ON identity.privacy_preference(user_id);
CREATE INDEX IF NOT EXISTS ix_identity_privacy_preference_attrs ON identity.privacy_preference USING gin(attributes);

CREATE TABLE IF NOT EXISTS identity.data_subject_request (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE identity.data_subject_request IS 'Entidade de Foundation Intelligence para DataSubjectRequest.';
CREATE INDEX IF NOT EXISTS ix_identity_data_subject_request_tenant ON identity.data_subject_request(tenant_id);
CREATE INDEX IF NOT EXISTS ix_identity_data_subject_request_user ON identity.data_subject_request(user_id);
CREATE INDEX IF NOT EXISTS ix_identity_data_subject_request_attrs ON identity.data_subject_request USING gin(attributes);

CREATE TABLE IF NOT EXISTS identity.onboarding_journey (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE identity.onboarding_journey IS 'Entidade de Foundation Intelligence para OnboardingJourney.';
CREATE INDEX IF NOT EXISTS ix_identity_onboarding_journey_tenant ON identity.onboarding_journey(tenant_id);
CREATE INDEX IF NOT EXISTS ix_identity_onboarding_journey_user ON identity.onboarding_journey(user_id);
CREATE INDEX IF NOT EXISTS ix_identity_onboarding_journey_attrs ON identity.onboarding_journey USING gin(attributes);

CREATE TABLE IF NOT EXISTS identity.onboarding_answer (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE identity.onboarding_answer IS 'Entidade de Foundation Intelligence para OnboardingAnswer.';
CREATE INDEX IF NOT EXISTS ix_identity_onboarding_answer_tenant ON identity.onboarding_answer(tenant_id);
CREATE INDEX IF NOT EXISTS ix_identity_onboarding_answer_user ON identity.onboarding_answer(user_id);
CREATE INDEX IF NOT EXISTS ix_identity_onboarding_answer_attrs ON identity.onboarding_answer USING gin(attributes);

CREATE TABLE IF NOT EXISTS identity.readiness_screening (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE identity.readiness_screening IS 'Entidade de Foundation Intelligence para ReadinessScreening.';
CREATE INDEX IF NOT EXISTS ix_identity_readiness_screening_tenant ON identity.readiness_screening(tenant_id);
CREATE INDEX IF NOT EXISTS ix_identity_readiness_screening_user ON identity.readiness_screening(user_id);
CREATE INDEX IF NOT EXISTS ix_identity_readiness_screening_attrs ON identity.readiness_screening USING gin(attributes);

CREATE TABLE IF NOT EXISTS identity.goal (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE identity.goal IS 'Entidade de Foundation Intelligence para Goal.';
CREATE INDEX IF NOT EXISTS ix_identity_goal_tenant ON identity.goal(tenant_id);
CREATE INDEX IF NOT EXISTS ix_identity_goal_user ON identity.goal(user_id);
CREATE INDEX IF NOT EXISTS ix_identity_goal_attrs ON identity.goal USING gin(attributes);

CREATE TABLE IF NOT EXISTS identity.goal_milestone (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE identity.goal_milestone IS 'Entidade de Foundation Intelligence para GoalMilestone.';
CREATE INDEX IF NOT EXISTS ix_identity_goal_milestone_tenant ON identity.goal_milestone(tenant_id);
CREATE INDEX IF NOT EXISTS ix_identity_goal_milestone_user ON identity.goal_milestone(user_id);
CREATE INDEX IF NOT EXISTS ix_identity_goal_milestone_attrs ON identity.goal_milestone USING gin(attributes);

CREATE TABLE IF NOT EXISTS identity.baseline_profile (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE identity.baseline_profile IS 'Entidade de Foundation Intelligence para BaselineProfile.';
CREATE INDEX IF NOT EXISTS ix_identity_baseline_profile_tenant ON identity.baseline_profile(tenant_id);
CREATE INDEX IF NOT EXISTS ix_identity_baseline_profile_user ON identity.baseline_profile(user_id);
CREATE INDEX IF NOT EXISTS ix_identity_baseline_profile_attrs ON identity.baseline_profile USING gin(attributes);

CREATE TABLE IF NOT EXISTS identity.risk_flag (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE identity.risk_flag IS 'Entidade de Foundation Intelligence para RiskFlag.';
CREATE INDEX IF NOT EXISTS ix_identity_risk_flag_tenant ON identity.risk_flag(tenant_id);
CREATE INDEX IF NOT EXISTS ix_identity_risk_flag_user ON identity.risk_flag(user_id);
CREATE INDEX IF NOT EXISTS ix_identity_risk_flag_attrs ON identity.risk_flag USING gin(attributes);

CREATE TABLE IF NOT EXISTS identity.coach_assignment (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE identity.coach_assignment IS 'Entidade de Foundation Intelligence para CoachAssignment.';
CREATE INDEX IF NOT EXISTS ix_identity_coach_assignment_tenant ON identity.coach_assignment(tenant_id);
CREATE INDEX IF NOT EXISTS ix_identity_coach_assignment_user ON identity.coach_assignment(user_id);
CREATE INDEX IF NOT EXISTS ix_identity_coach_assignment_attrs ON identity.coach_assignment USING gin(attributes);

CREATE TABLE IF NOT EXISTS identity.household_link (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE identity.household_link IS 'Entidade de Foundation Intelligence para HouseholdLink.';
CREATE INDEX IF NOT EXISTS ix_identity_household_link_tenant ON identity.household_link(tenant_id);
CREATE INDEX IF NOT EXISTS ix_identity_household_link_user ON identity.household_link(user_id);
CREATE INDEX IF NOT EXISTS ix_identity_household_link_attrs ON identity.household_link USING gin(attributes);

CREATE TABLE IF NOT EXISTS identity.locale_preference (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE identity.locale_preference IS 'Entidade de Foundation Intelligence para LocalePreference.';
CREATE INDEX IF NOT EXISTS ix_identity_locale_preference_tenant ON identity.locale_preference(tenant_id);
CREATE INDEX IF NOT EXISTS ix_identity_locale_preference_user ON identity.locale_preference(user_id);
CREATE INDEX IF NOT EXISTS ix_identity_locale_preference_attrs ON identity.locale_preference USING gin(attributes);

CREATE TABLE IF NOT EXISTS identity.accessibility_preference (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE identity.accessibility_preference IS 'Entidade de Foundation Intelligence para AccessibilityPreference.';
CREATE INDEX IF NOT EXISTS ix_identity_accessibility_preference_tenant ON identity.accessibility_preference(tenant_id);
CREATE INDEX IF NOT EXISTS ix_identity_accessibility_preference_user ON identity.accessibility_preference(user_id);
CREATE INDEX IF NOT EXISTS ix_identity_accessibility_preference_attrs ON identity.accessibility_preference USING gin(attributes);

CREATE TABLE IF NOT EXISTS body.movement_pattern (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE body.movement_pattern IS 'Entidade de Body Performance para MovementPattern.';
CREATE INDEX IF NOT EXISTS ix_body_movement_pattern_tenant ON body.movement_pattern(tenant_id);
CREATE INDEX IF NOT EXISTS ix_body_movement_pattern_user ON body.movement_pattern(user_id);
CREATE INDEX IF NOT EXISTS ix_body_movement_pattern_attrs ON body.movement_pattern USING gin(attributes);

CREATE TABLE IF NOT EXISTS body.exercise (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE body.exercise IS 'Entidade de Body Performance para Exercise.';
CREATE INDEX IF NOT EXISTS ix_body_exercise_tenant ON body.exercise(tenant_id);
CREATE INDEX IF NOT EXISTS ix_body_exercise_user ON body.exercise(user_id);
CREATE INDEX IF NOT EXISTS ix_body_exercise_attrs ON body.exercise USING gin(attributes);

CREATE TABLE IF NOT EXISTS body.exercise_level (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE body.exercise_level IS 'Entidade de Body Performance para ExerciseLevel.';
CREATE INDEX IF NOT EXISTS ix_body_exercise_level_tenant ON body.exercise_level(tenant_id);
CREATE INDEX IF NOT EXISTS ix_body_exercise_level_user ON body.exercise_level(user_id);
CREATE INDEX IF NOT EXISTS ix_body_exercise_level_attrs ON body.exercise_level USING gin(attributes);

CREATE TABLE IF NOT EXISTS body.exercise_regression (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE body.exercise_regression IS 'Entidade de Body Performance para ExerciseRegression.';
CREATE INDEX IF NOT EXISTS ix_body_exercise_regression_tenant ON body.exercise_regression(tenant_id);
CREATE INDEX IF NOT EXISTS ix_body_exercise_regression_user ON body.exercise_regression(user_id);
CREATE INDEX IF NOT EXISTS ix_body_exercise_regression_attrs ON body.exercise_regression USING gin(attributes);

CREATE TABLE IF NOT EXISTS body.exercise_progression (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE body.exercise_progression IS 'Entidade de Body Performance para ExerciseProgression.';
CREATE INDEX IF NOT EXISTS ix_body_exercise_progression_tenant ON body.exercise_progression(tenant_id);
CREATE INDEX IF NOT EXISTS ix_body_exercise_progression_user ON body.exercise_progression(user_id);
CREATE INDEX IF NOT EXISTS ix_body_exercise_progression_attrs ON body.exercise_progression USING gin(attributes);

CREATE TABLE IF NOT EXISTS body.exercise_cue (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE body.exercise_cue IS 'Entidade de Body Performance para ExerciseCue.';
CREATE INDEX IF NOT EXISTS ix_body_exercise_cue_tenant ON body.exercise_cue(tenant_id);
CREATE INDEX IF NOT EXISTS ix_body_exercise_cue_user ON body.exercise_cue(user_id);
CREATE INDEX IF NOT EXISTS ix_body_exercise_cue_attrs ON body.exercise_cue USING gin(attributes);

CREATE TABLE IF NOT EXISTS body.exercise_contraindication (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE body.exercise_contraindication IS 'Entidade de Body Performance para ExerciseContraindication.';
CREATE INDEX IF NOT EXISTS ix_body_exercise_contraindication_tenant ON body.exercise_contraindication(tenant_id);
CREATE INDEX IF NOT EXISTS ix_body_exercise_contraindication_user ON body.exercise_contraindication(user_id);
CREATE INDEX IF NOT EXISTS ix_body_exercise_contraindication_attrs ON body.exercise_contraindication USING gin(attributes);

CREATE TABLE IF NOT EXISTS body.workout_template (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE body.workout_template IS 'Entidade de Body Performance para WorkoutTemplate.';
CREATE INDEX IF NOT EXISTS ix_body_workout_template_tenant ON body.workout_template(tenant_id);
CREATE INDEX IF NOT EXISTS ix_body_workout_template_user ON body.workout_template(user_id);
CREATE INDEX IF NOT EXISTS ix_body_workout_template_attrs ON body.workout_template USING gin(attributes);

CREATE TABLE IF NOT EXISTS body.workout_block (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE body.workout_block IS 'Entidade de Body Performance para WorkoutBlock.';
CREATE INDEX IF NOT EXISTS ix_body_workout_block_tenant ON body.workout_block(tenant_id);
CREATE INDEX IF NOT EXISTS ix_body_workout_block_user ON body.workout_block(user_id);
CREATE INDEX IF NOT EXISTS ix_body_workout_block_attrs ON body.workout_block USING gin(attributes);

CREATE TABLE IF NOT EXISTS body.workout_exercise (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE body.workout_exercise IS 'Entidade de Body Performance para WorkoutExercise.';
CREATE INDEX IF NOT EXISTS ix_body_workout_exercise_tenant ON body.workout_exercise(tenant_id);
CREATE INDEX IF NOT EXISTS ix_body_workout_exercise_user ON body.workout_exercise(user_id);
CREATE INDEX IF NOT EXISTS ix_body_workout_exercise_attrs ON body.workout_exercise USING gin(attributes);

CREATE TABLE IF NOT EXISTS body.workout_session (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE body.workout_session IS 'Entidade de Body Performance para WorkoutSession.';
CREATE INDEX IF NOT EXISTS ix_body_workout_session_tenant ON body.workout_session(tenant_id);
CREATE INDEX IF NOT EXISTS ix_body_workout_session_user ON body.workout_session(user_id);
CREATE INDEX IF NOT EXISTS ix_body_workout_session_attrs ON body.workout_session USING gin(attributes);

CREATE TABLE IF NOT EXISTS body.workout_set (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE body.workout_set IS 'Entidade de Body Performance para WorkoutSet.';
CREATE INDEX IF NOT EXISTS ix_body_workout_set_tenant ON body.workout_set(tenant_id);
CREATE INDEX IF NOT EXISTS ix_body_workout_set_user ON body.workout_set(user_id);
CREATE INDEX IF NOT EXISTS ix_body_workout_set_attrs ON body.workout_set USING gin(attributes);

CREATE TABLE IF NOT EXISTS body.rep_record (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE body.rep_record IS 'Entidade de Body Performance para RepRecord.';
CREATE INDEX IF NOT EXISTS ix_body_rep_record_tenant ON body.rep_record(tenant_id);
CREATE INDEX IF NOT EXISTS ix_body_rep_record_user ON body.rep_record(user_id);
CREATE INDEX IF NOT EXISTS ix_body_rep_record_attrs ON body.rep_record USING gin(attributes);

CREATE TABLE IF NOT EXISTS body.time_record (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE body.time_record IS 'Entidade de Body Performance para TimeRecord.';
CREATE INDEX IF NOT EXISTS ix_body_time_record_tenant ON body.time_record(tenant_id);
CREATE INDEX IF NOT EXISTS ix_body_time_record_user ON body.time_record(user_id);
CREATE INDEX IF NOT EXISTS ix_body_time_record_attrs ON body.time_record USING gin(attributes);

CREATE TABLE IF NOT EXISTS body.rpe_record (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE body.rpe_record IS 'Entidade de Body Performance para RpeRecord.';
CREATE INDEX IF NOT EXISTS ix_body_rpe_record_tenant ON body.rpe_record(tenant_id);
CREATE INDEX IF NOT EXISTS ix_body_rpe_record_user ON body.rpe_record(user_id);
CREATE INDEX IF NOT EXISTS ix_body_rpe_record_attrs ON body.rpe_record USING gin(attributes);

CREATE TABLE IF NOT EXISTS body.training_day (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE body.training_day IS 'Entidade de Body Performance para TrainingDay.';
CREATE INDEX IF NOT EXISTS ix_body_training_day_tenant ON body.training_day(tenant_id);
CREATE INDEX IF NOT EXISTS ix_body_training_day_user ON body.training_day(user_id);
CREATE INDEX IF NOT EXISTS ix_body_training_day_attrs ON body.training_day USING gin(attributes);

CREATE TABLE IF NOT EXISTS body.training_week (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE body.training_week IS 'Entidade de Body Performance para TrainingWeek.';
CREATE INDEX IF NOT EXISTS ix_body_training_week_tenant ON body.training_week(tenant_id);
CREATE INDEX IF NOT EXISTS ix_body_training_week_user ON body.training_week(user_id);
CREATE INDEX IF NOT EXISTS ix_body_training_week_attrs ON body.training_week USING gin(attributes);

CREATE TABLE IF NOT EXISTS body.training_phase (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE body.training_phase IS 'Entidade de Body Performance para TrainingPhase.';
CREATE INDEX IF NOT EXISTS ix_body_training_phase_tenant ON body.training_phase(tenant_id);
CREATE INDEX IF NOT EXISTS ix_body_training_phase_user ON body.training_phase(user_id);
CREATE INDEX IF NOT EXISTS ix_body_training_phase_attrs ON body.training_phase USING gin(attributes);

CREATE TABLE IF NOT EXISTS body.deload_rule (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE body.deload_rule IS 'Entidade de Body Performance para DeloadRule.';
CREATE INDEX IF NOT EXISTS ix_body_deload_rule_tenant ON body.deload_rule(tenant_id);
CREATE INDEX IF NOT EXISTS ix_body_deload_rule_user ON body.deload_rule(user_id);
CREATE INDEX IF NOT EXISTS ix_body_deload_rule_attrs ON body.deload_rule USING gin(attributes);

CREATE TABLE IF NOT EXISTS body.graduation_criterion (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE body.graduation_criterion IS 'Entidade de Body Performance para GraduationCriterion.';
CREATE INDEX IF NOT EXISTS ix_body_graduation_criterion_tenant ON body.graduation_criterion(tenant_id);
CREATE INDEX IF NOT EXISTS ix_body_graduation_criterion_user ON body.graduation_criterion(user_id);
CREATE INDEX IF NOT EXISTS ix_body_graduation_criterion_attrs ON body.graduation_criterion USING gin(attributes);

CREATE TABLE IF NOT EXISTS body.physical_assessment (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE body.physical_assessment IS 'Entidade de Body Performance para PhysicalAssessment.';
CREATE INDEX IF NOT EXISTS ix_body_physical_assessment_tenant ON body.physical_assessment(tenant_id);
CREATE INDEX IF NOT EXISTS ix_body_physical_assessment_user ON body.physical_assessment(user_id);
CREATE INDEX IF NOT EXISTS ix_body_physical_assessment_attrs ON body.physical_assessment USING gin(attributes);

CREATE TABLE IF NOT EXISTS body.strength_test (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE body.strength_test IS 'Entidade de Body Performance para StrengthTest.';
CREATE INDEX IF NOT EXISTS ix_body_strength_test_tenant ON body.strength_test(tenant_id);
CREATE INDEX IF NOT EXISTS ix_body_strength_test_user ON body.strength_test(user_id);
CREATE INDEX IF NOT EXISTS ix_body_strength_test_attrs ON body.strength_test USING gin(attributes);

CREATE TABLE IF NOT EXISTS body.endurance_test (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE body.endurance_test IS 'Entidade de Body Performance para EnduranceTest.';
CREATE INDEX IF NOT EXISTS ix_body_endurance_test_tenant ON body.endurance_test(tenant_id);
CREATE INDEX IF NOT EXISTS ix_body_endurance_test_user ON body.endurance_test(user_id);
CREATE INDEX IF NOT EXISTS ix_body_endurance_test_attrs ON body.endurance_test USING gin(attributes);

CREATE TABLE IF NOT EXISTS body.mobility_test (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE body.mobility_test IS 'Entidade de Body Performance para MobilityTest.';
CREATE INDEX IF NOT EXISTS ix_body_mobility_test_tenant ON body.mobility_test(tenant_id);
CREATE INDEX IF NOT EXISTS ix_body_mobility_test_user ON body.mobility_test(user_id);
CREATE INDEX IF NOT EXISTS ix_body_mobility_test_attrs ON body.mobility_test USING gin(attributes);

CREATE TABLE IF NOT EXISTS body.anthropometry_record (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE body.anthropometry_record IS 'Entidade de Body Performance para AnthropometryRecord.';
CREATE INDEX IF NOT EXISTS ix_body_anthropometry_record_tenant ON body.anthropometry_record(tenant_id);
CREATE INDEX IF NOT EXISTS ix_body_anthropometry_record_user ON body.anthropometry_record(user_id);
CREATE INDEX IF NOT EXISTS ix_body_anthropometry_record_attrs ON body.anthropometry_record USING gin(attributes);

CREATE TABLE IF NOT EXISTS body.body_measurement (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE body.body_measurement IS 'Entidade de Body Performance para BodyMeasurement.';
CREATE INDEX IF NOT EXISTS ix_body_body_measurement_tenant ON body.body_measurement(tenant_id);
CREATE INDEX IF NOT EXISTS ix_body_body_measurement_user ON body.body_measurement(user_id);
CREATE INDEX IF NOT EXISTS ix_body_body_measurement_attrs ON body.body_measurement USING gin(attributes);

CREATE TABLE IF NOT EXISTS body.progress_photo (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE body.progress_photo IS 'Entidade de Body Performance para ProgressPhoto.';
CREATE INDEX IF NOT EXISTS ix_body_progress_photo_tenant ON body.progress_photo(tenant_id);
CREATE INDEX IF NOT EXISTS ix_body_progress_photo_user ON body.progress_photo(user_id);
CREATE INDEX IF NOT EXISTS ix_body_progress_photo_attrs ON body.progress_photo USING gin(attributes);

CREATE TABLE IF NOT EXISTS body.body_composition_estimate (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE body.body_composition_estimate IS 'Entidade de Body Performance para BodyCompositionEstimate.';
CREATE INDEX IF NOT EXISTS ix_body_body_composition_estimate_tenant ON body.body_composition_estimate(tenant_id);
CREATE INDEX IF NOT EXISTS ix_body_body_composition_estimate_user ON body.body_composition_estimate(user_id);
CREATE INDEX IF NOT EXISTS ix_body_body_composition_estimate_attrs ON body.body_composition_estimate USING gin(attributes);

CREATE TABLE IF NOT EXISTS body.personal_record (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE body.personal_record IS 'Entidade de Body Performance para PersonalRecord.';
CREATE INDEX IF NOT EXISTS ix_body_personal_record_tenant ON body.personal_record(tenant_id);
CREATE INDEX IF NOT EXISTS ix_body_personal_record_user ON body.personal_record(user_id);
CREATE INDEX IF NOT EXISTS ix_body_personal_record_attrs ON body.personal_record USING gin(attributes);

CREATE TABLE IF NOT EXISTS body.adaptation_rule (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE body.adaptation_rule IS 'Entidade de Body Performance para AdaptationRule.';
CREATE INDEX IF NOT EXISTS ix_body_adaptation_rule_tenant ON body.adaptation_rule(tenant_id);
CREATE INDEX IF NOT EXISTS ix_body_adaptation_rule_user ON body.adaptation_rule(user_id);
CREATE INDEX IF NOT EXISTS ix_body_adaptation_rule_attrs ON body.adaptation_rule USING gin(attributes);

CREATE TABLE IF NOT EXISTS body.joint_load_profile (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE body.joint_load_profile IS 'Entidade de Body Performance para JointLoadProfile.';
CREATE INDEX IF NOT EXISTS ix_body_joint_load_profile_tenant ON body.joint_load_profile(tenant_id);
CREATE INDEX IF NOT EXISTS ix_body_joint_load_profile_user ON body.joint_load_profile(user_id);
CREATE INDEX IF NOT EXISTS ix_body_joint_load_profile_attrs ON body.joint_load_profile USING gin(attributes);

CREATE TABLE IF NOT EXISTS body.equipment_requirement (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE body.equipment_requirement IS 'Entidade de Body Performance para EquipmentRequirement.';
CREATE INDEX IF NOT EXISTS ix_body_equipment_requirement_tenant ON body.equipment_requirement(tenant_id);
CREATE INDEX IF NOT EXISTS ix_body_equipment_requirement_user ON body.equipment_requirement(user_id);
CREATE INDEX IF NOT EXISTS ix_body_equipment_requirement_attrs ON body.equipment_requirement USING gin(attributes);

CREATE TABLE IF NOT EXISTS body.warmup_protocol (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE body.warmup_protocol IS 'Entidade de Body Performance para WarmupProtocol.';
CREATE INDEX IF NOT EXISTS ix_body_warmup_protocol_tenant ON body.warmup_protocol(tenant_id);
CREATE INDEX IF NOT EXISTS ix_body_warmup_protocol_user ON body.warmup_protocol(user_id);
CREATE INDEX IF NOT EXISTS ix_body_warmup_protocol_attrs ON body.warmup_protocol USING gin(attributes);

CREATE TABLE IF NOT EXISTS body.cooldown_protocol (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE body.cooldown_protocol IS 'Entidade de Body Performance para CooldownProtocol.';
CREATE INDEX IF NOT EXISTS ix_body_cooldown_protocol_tenant ON body.cooldown_protocol(tenant_id);
CREATE INDEX IF NOT EXISTS ix_body_cooldown_protocol_user ON body.cooldown_protocol(user_id);
CREATE INDEX IF NOT EXISTS ix_body_cooldown_protocol_attrs ON body.cooldown_protocol USING gin(attributes);

CREATE TABLE IF NOT EXISTS body.military_challenge_result (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE body.military_challenge_result IS 'Entidade de Body Performance para MilitaryChallengeResult.';
CREATE INDEX IF NOT EXISTS ix_body_military_challenge_result_tenant ON body.military_challenge_result(tenant_id);
CREATE INDEX IF NOT EXISTS ix_body_military_challenge_result_user ON body.military_challenge_result(user_id);
CREATE INDEX IF NOT EXISTS ix_body_military_challenge_result_attrs ON body.military_challenge_result USING gin(attributes);

CREATE TABLE IF NOT EXISTS combat.combat_skill (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE combat.combat_skill IS 'Entidade de Combat Conditioning para CombatSkill.';
CREATE INDEX IF NOT EXISTS ix_combat_combat_skill_tenant ON combat.combat_skill(tenant_id);
CREATE INDEX IF NOT EXISTS ix_combat_combat_skill_user ON combat.combat_skill(user_id);
CREATE INDEX IF NOT EXISTS ix_combat_combat_skill_attrs ON combat.combat_skill USING gin(attributes);

CREATE TABLE IF NOT EXISTS combat.technique (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE combat.technique IS 'Entidade de Combat Conditioning para Technique.';
CREATE INDEX IF NOT EXISTS ix_combat_technique_tenant ON combat.technique(tenant_id);
CREATE INDEX IF NOT EXISTS ix_combat_technique_user ON combat.technique(user_id);
CREATE INDEX IF NOT EXISTS ix_combat_technique_attrs ON combat.technique USING gin(attributes);

CREATE TABLE IF NOT EXISTS combat.strike (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE combat.strike IS 'Entidade de Combat Conditioning para Strike.';
CREATE INDEX IF NOT EXISTS ix_combat_strike_tenant ON combat.strike(tenant_id);
CREATE INDEX IF NOT EXISTS ix_combat_strike_user ON combat.strike(user_id);
CREATE INDEX IF NOT EXISTS ix_combat_strike_attrs ON combat.strike USING gin(attributes);

CREATE TABLE IF NOT EXISTS combat.combination (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE combat.combination IS 'Entidade de Combat Conditioning para Combination.';
CREATE INDEX IF NOT EXISTS ix_combat_combination_tenant ON combat.combination(tenant_id);
CREATE INDEX IF NOT EXISTS ix_combat_combination_user ON combat.combination(user_id);
CREATE INDEX IF NOT EXISTS ix_combat_combination_attrs ON combat.combination USING gin(attributes);

CREATE TABLE IF NOT EXISTS combat.footwork_pattern (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE combat.footwork_pattern IS 'Entidade de Combat Conditioning para FootworkPattern.';
CREATE INDEX IF NOT EXISTS ix_combat_footwork_pattern_tenant ON combat.footwork_pattern(tenant_id);
CREATE INDEX IF NOT EXISTS ix_combat_footwork_pattern_user ON combat.footwork_pattern(user_id);
CREATE INDEX IF NOT EXISTS ix_combat_footwork_pattern_attrs ON combat.footwork_pattern USING gin(attributes);

CREATE TABLE IF NOT EXISTS combat.shadowboxing_session (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE combat.shadowboxing_session IS 'Entidade de Combat Conditioning para ShadowboxingSession.';
CREATE INDEX IF NOT EXISTS ix_combat_shadowboxing_session_tenant ON combat.shadowboxing_session(tenant_id);
CREATE INDEX IF NOT EXISTS ix_combat_shadowboxing_session_user ON combat.shadowboxing_session(user_id);
CREATE INDEX IF NOT EXISTS ix_combat_shadowboxing_session_attrs ON combat.shadowboxing_session USING gin(attributes);

CREATE TABLE IF NOT EXISTS combat.round (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE combat.round IS 'Entidade de Combat Conditioning para Round.';
CREATE INDEX IF NOT EXISTS ix_combat_round_tenant ON combat.round(tenant_id);
CREATE INDEX IF NOT EXISTS ix_combat_round_user ON combat.round(user_id);
CREATE INDEX IF NOT EXISTS ix_combat_round_attrs ON combat.round USING gin(attributes);

CREATE TABLE IF NOT EXISTS combat.round_interval (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE combat.round_interval IS 'Entidade de Combat Conditioning para RoundInterval.';
CREATE INDEX IF NOT EXISTS ix_combat_round_interval_tenant ON combat.round_interval(tenant_id);
CREATE INDEX IF NOT EXISTS ix_combat_round_interval_user ON combat.round_interval(user_id);
CREATE INDEX IF NOT EXISTS ix_combat_round_interval_attrs ON combat.round_interval USING gin(attributes);

CREATE TABLE IF NOT EXISTS combat.jump_rope_session (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE combat.jump_rope_session IS 'Entidade de Combat Conditioning para JumpRopeSession.';
CREATE INDEX IF NOT EXISTS ix_combat_jump_rope_session_tenant ON combat.jump_rope_session(tenant_id);
CREATE INDEX IF NOT EXISTS ix_combat_jump_rope_session_user ON combat.jump_rope_session(user_id);
CREATE INDEX IF NOT EXISTS ix_combat_jump_rope_session_attrs ON combat.jump_rope_session USING gin(attributes);

CREATE TABLE IF NOT EXISTS combat.jump_rope_metric (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE combat.jump_rope_metric IS 'Entidade de Combat Conditioning para JumpRopeMetric.';
CREATE INDEX IF NOT EXISTS ix_combat_jump_rope_metric_tenant ON combat.jump_rope_metric(tenant_id);
CREATE INDEX IF NOT EXISTS ix_combat_jump_rope_metric_user ON combat.jump_rope_metric(user_id);
CREATE INDEX IF NOT EXISTS ix_combat_jump_rope_metric_attrs ON combat.jump_rope_metric USING gin(attributes);

CREATE TABLE IF NOT EXISTS combat.conditioning_circuit (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE combat.conditioning_circuit IS 'Entidade de Combat Conditioning para ConditioningCircuit.';
CREATE INDEX IF NOT EXISTS ix_combat_conditioning_circuit_tenant ON combat.conditioning_circuit(tenant_id);
CREATE INDEX IF NOT EXISTS ix_combat_conditioning_circuit_user ON combat.conditioning_circuit(user_id);
CREATE INDEX IF NOT EXISTS ix_combat_conditioning_circuit_attrs ON combat.conditioning_circuit USING gin(attributes);

CREATE TABLE IF NOT EXISTS combat.circuit_station (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE combat.circuit_station IS 'Entidade de Combat Conditioning para CircuitStation.';
CREATE INDEX IF NOT EXISTS ix_combat_circuit_station_tenant ON combat.circuit_station(tenant_id);
CREATE INDEX IF NOT EXISTS ix_combat_circuit_station_user ON combat.circuit_station(user_id);
CREATE INDEX IF NOT EXISTS ix_combat_circuit_station_attrs ON combat.circuit_station USING gin(attributes);

CREATE TABLE IF NOT EXISTS combat.circuit_result (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE combat.circuit_result IS 'Entidade de Combat Conditioning para CircuitResult.';
CREATE INDEX IF NOT EXISTS ix_combat_circuit_result_tenant ON combat.circuit_result(tenant_id);
CREATE INDEX IF NOT EXISTS ix_combat_circuit_result_user ON combat.circuit_result(user_id);
CREATE INDEX IF NOT EXISTS ix_combat_circuit_result_attrs ON combat.circuit_result USING gin(attributes);

CREATE TABLE IF NOT EXISTS combat.march_session (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE combat.march_session IS 'Entidade de Combat Conditioning para MarchSession.';
CREATE INDEX IF NOT EXISTS ix_combat_march_session_tenant ON combat.march_session(tenant_id);
CREATE INDEX IF NOT EXISTS ix_combat_march_session_user ON combat.march_session(user_id);
CREATE INDEX IF NOT EXISTS ix_combat_march_session_attrs ON combat.march_session USING gin(attributes);

CREATE TABLE IF NOT EXISTS combat.load_carry_record (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE combat.load_carry_record IS 'Entidade de Combat Conditioning para LoadCarryRecord.';
CREATE INDEX IF NOT EXISTS ix_combat_load_carry_record_tenant ON combat.load_carry_record(tenant_id);
CREATE INDEX IF NOT EXISTS ix_combat_load_carry_record_user ON combat.load_carry_record(user_id);
CREATE INDEX IF NOT EXISTS ix_combat_load_carry_record_attrs ON combat.load_carry_record USING gin(attributes);

CREATE TABLE IF NOT EXISTS combat.zone2_session (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE combat.zone2_session IS 'Entidade de Combat Conditioning para Zone2Session.';
CREATE INDEX IF NOT EXISTS ix_combat_zone2_session_tenant ON combat.zone2_session(tenant_id);
CREATE INDEX IF NOT EXISTS ix_combat_zone2_session_user ON combat.zone2_session(user_id);
CREATE INDEX IF NOT EXISTS ix_combat_zone2_session_attrs ON combat.zone2_session USING gin(attributes);

CREATE TABLE IF NOT EXISTS combat.hiit_session (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE combat.hiit_session IS 'Entidade de Combat Conditioning para HiitSession.';
CREATE INDEX IF NOT EXISTS ix_combat_hiit_session_tenant ON combat.hiit_session(tenant_id);
CREATE INDEX IF NOT EXISTS ix_combat_hiit_session_user ON combat.hiit_session(user_id);
CREATE INDEX IF NOT EXISTS ix_combat_hiit_session_attrs ON combat.hiit_session USING gin(attributes);

CREATE TABLE IF NOT EXISTS combat.muay_thai_lesson (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE combat.muay_thai_lesson IS 'Entidade de Combat Conditioning para MuayThaiLesson.';
CREATE INDEX IF NOT EXISTS ix_combat_muay_thai_lesson_tenant ON combat.muay_thai_lesson(tenant_id);
CREATE INDEX IF NOT EXISTS ix_combat_muay_thai_lesson_user ON combat.muay_thai_lesson(user_id);
CREATE INDEX IF NOT EXISTS ix_combat_muay_thai_lesson_attrs ON combat.muay_thai_lesson USING gin(attributes);

CREATE TABLE IF NOT EXISTS combat.technique_assessment (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE combat.technique_assessment IS 'Entidade de Combat Conditioning para TechniqueAssessment.';
CREATE INDEX IF NOT EXISTS ix_combat_technique_assessment_tenant ON combat.technique_assessment(tenant_id);
CREATE INDEX IF NOT EXISTS ix_combat_technique_assessment_user ON combat.technique_assessment(user_id);
CREATE INDEX IF NOT EXISTS ix_combat_technique_assessment_attrs ON combat.technique_assessment USING gin(attributes);

CREATE TABLE IF NOT EXISTS combat.safety_restriction (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE combat.safety_restriction IS 'Entidade de Combat Conditioning para SafetyRestriction.';
CREATE INDEX IF NOT EXISTS ix_combat_safety_restriction_tenant ON combat.safety_restriction(tenant_id);
CREATE INDEX IF NOT EXISTS ix_combat_safety_restriction_user ON combat.safety_restriction(user_id);
CREATE INDEX IF NOT EXISTS ix_combat_safety_restriction_attrs ON combat.safety_restriction USING gin(attributes);

CREATE TABLE IF NOT EXISTS combat.no_contact_policy (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE combat.no_contact_policy IS 'Entidade de Combat Conditioning para NoContactPolicy.';
CREATE INDEX IF NOT EXISTS ix_combat_no_contact_policy_tenant ON combat.no_contact_policy(tenant_id);
CREATE INDEX IF NOT EXISTS ix_combat_no_contact_policy_user ON combat.no_contact_policy(user_id);
CREATE INDEX IF NOT EXISTS ix_combat_no_contact_policy_attrs ON combat.no_contact_policy USING gin(attributes);

CREATE TABLE IF NOT EXISTS combat.combat_progression_rule (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE combat.combat_progression_rule IS 'Entidade de Combat Conditioning para CombatProgressionRule.';
CREATE INDEX IF NOT EXISTS ix_combat_combat_progression_rule_tenant ON combat.combat_progression_rule(tenant_id);
CREATE INDEX IF NOT EXISTS ix_combat_combat_progression_rule_user ON combat.combat_progression_rule(user_id);
CREATE INDEX IF NOT EXISTS ix_combat_combat_progression_rule_attrs ON combat.combat_progression_rule USING gin(attributes);

CREATE TABLE IF NOT EXISTS combat.technical_drill (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE combat.technical_drill IS 'Entidade de Combat Conditioning para TechnicalDrill.';
CREATE INDEX IF NOT EXISTS ix_combat_technical_drill_tenant ON combat.technical_drill(tenant_id);
CREATE INDEX IF NOT EXISTS ix_combat_technical_drill_user ON combat.technical_drill(user_id);
CREATE INDEX IF NOT EXISTS ix_combat_technical_drill_attrs ON combat.technical_drill USING gin(attributes);

CREATE TABLE IF NOT EXISTS combat.breathing_cadence (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE combat.breathing_cadence IS 'Entidade de Combat Conditioning para BreathingCadence.';
CREATE INDEX IF NOT EXISTS ix_combat_breathing_cadence_tenant ON combat.breathing_cadence(tenant_id);
CREATE INDEX IF NOT EXISTS ix_combat_breathing_cadence_user ON combat.breathing_cadence(user_id);
CREATE INDEX IF NOT EXISTS ix_combat_breathing_cadence_attrs ON combat.breathing_cadence USING gin(attributes);

CREATE TABLE IF NOT EXISTS recovery.recovery_plan (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE recovery.recovery_plan IS 'Entidade de Recovery System para RecoveryPlan.';
CREATE INDEX IF NOT EXISTS ix_recovery_recovery_plan_tenant ON recovery.recovery_plan(tenant_id);
CREATE INDEX IF NOT EXISTS ix_recovery_recovery_plan_user ON recovery.recovery_plan(user_id);
CREATE INDEX IF NOT EXISTS ix_recovery_recovery_plan_attrs ON recovery.recovery_plan USING gin(attributes);

CREATE TABLE IF NOT EXISTS recovery.sleep_record (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE recovery.sleep_record IS 'Entidade de Recovery System para SleepRecord.';
CREATE INDEX IF NOT EXISTS ix_recovery_sleep_record_tenant ON recovery.sleep_record(tenant_id);
CREATE INDEX IF NOT EXISTS ix_recovery_sleep_record_user ON recovery.sleep_record(user_id);
CREATE INDEX IF NOT EXISTS ix_recovery_sleep_record_attrs ON recovery.sleep_record USING gin(attributes);

CREATE TABLE IF NOT EXISTS recovery.sleep_stage_summary (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE recovery.sleep_stage_summary IS 'Entidade de Recovery System para SleepStageSummary.';
CREATE INDEX IF NOT EXISTS ix_recovery_sleep_stage_summary_tenant ON recovery.sleep_stage_summary(tenant_id);
CREATE INDEX IF NOT EXISTS ix_recovery_sleep_stage_summary_user ON recovery.sleep_stage_summary(user_id);
CREATE INDEX IF NOT EXISTS ix_recovery_sleep_stage_summary_attrs ON recovery.sleep_stage_summary USING gin(attributes);

CREATE TABLE IF NOT EXISTS recovery.readiness_score (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE recovery.readiness_score IS 'Entidade de Recovery System para ReadinessScore.';
CREATE INDEX IF NOT EXISTS ix_recovery_readiness_score_tenant ON recovery.readiness_score(tenant_id);
CREATE INDEX IF NOT EXISTS ix_recovery_readiness_score_user ON recovery.readiness_score(user_id);
CREATE INDEX IF NOT EXISTS ix_recovery_readiness_score_attrs ON recovery.readiness_score USING gin(attributes);

CREATE TABLE IF NOT EXISTS recovery.soreness_report (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE recovery.soreness_report IS 'Entidade de Recovery System para SorenessReport.';
CREATE INDEX IF NOT EXISTS ix_recovery_soreness_report_tenant ON recovery.soreness_report(tenant_id);
CREATE INDEX IF NOT EXISTS ix_recovery_soreness_report_user ON recovery.soreness_report(user_id);
CREATE INDEX IF NOT EXISTS ix_recovery_soreness_report_attrs ON recovery.soreness_report USING gin(attributes);

CREATE TABLE IF NOT EXISTS recovery.pain_report (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE recovery.pain_report IS 'Entidade de Recovery System para PainReport.';
CREATE INDEX IF NOT EXISTS ix_recovery_pain_report_tenant ON recovery.pain_report(tenant_id);
CREATE INDEX IF NOT EXISTS ix_recovery_pain_report_user ON recovery.pain_report(user_id);
CREATE INDEX IF NOT EXISTS ix_recovery_pain_report_attrs ON recovery.pain_report USING gin(attributes);

CREATE TABLE IF NOT EXISTS recovery.pain_rule_decision (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE recovery.pain_rule_decision IS 'Entidade de Recovery System para PainRuleDecision.';
CREATE INDEX IF NOT EXISTS ix_recovery_pain_rule_decision_tenant ON recovery.pain_rule_decision(tenant_id);
CREATE INDEX IF NOT EXISTS ix_recovery_pain_rule_decision_user ON recovery.pain_rule_decision(user_id);
CREATE INDEX IF NOT EXISTS ix_recovery_pain_rule_decision_attrs ON recovery.pain_rule_decision USING gin(attributes);

CREATE TABLE IF NOT EXISTS recovery.mobility_routine (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE recovery.mobility_routine IS 'Entidade de Recovery System para MobilityRoutine.';
CREATE INDEX IF NOT EXISTS ix_recovery_mobility_routine_tenant ON recovery.mobility_routine(tenant_id);
CREATE INDEX IF NOT EXISTS ix_recovery_mobility_routine_user ON recovery.mobility_routine(user_id);
CREATE INDEX IF NOT EXISTS ix_recovery_mobility_routine_attrs ON recovery.mobility_routine USING gin(attributes);

CREATE TABLE IF NOT EXISTS recovery.mobility_exercise (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE recovery.mobility_exercise IS 'Entidade de Recovery System para MobilityExercise.';
CREATE INDEX IF NOT EXISTS ix_recovery_mobility_exercise_tenant ON recovery.mobility_exercise(tenant_id);
CREATE INDEX IF NOT EXISTS ix_recovery_mobility_exercise_user ON recovery.mobility_exercise(user_id);
CREATE INDEX IF NOT EXISTS ix_recovery_mobility_exercise_attrs ON recovery.mobility_exercise USING gin(attributes);

CREATE TABLE IF NOT EXISTS recovery.stretching_session (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE recovery.stretching_session IS 'Entidade de Recovery System para StretchingSession.';
CREATE INDEX IF NOT EXISTS ix_recovery_stretching_session_tenant ON recovery.stretching_session(tenant_id);
CREATE INDEX IF NOT EXISTS ix_recovery_stretching_session_user ON recovery.stretching_session(user_id);
CREATE INDEX IF NOT EXISTS ix_recovery_stretching_session_attrs ON recovery.stretching_session USING gin(attributes);

CREATE TABLE IF NOT EXISTS recovery.joint_care_protocol (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE recovery.joint_care_protocol IS 'Entidade de Recovery System para JointCareProtocol.';
CREATE INDEX IF NOT EXISTS ix_recovery_joint_care_protocol_tenant ON recovery.joint_care_protocol(tenant_id);
CREATE INDEX IF NOT EXISTS ix_recovery_joint_care_protocol_user ON recovery.joint_care_protocol(user_id);
CREATE INDEX IF NOT EXISTS ix_recovery_joint_care_protocol_attrs ON recovery.joint_care_protocol USING gin(attributes);

CREATE TABLE IF NOT EXISTS recovery.injury_history (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE recovery.injury_history IS 'Entidade de Recovery System para InjuryHistory.';
CREATE INDEX IF NOT EXISTS ix_recovery_injury_history_tenant ON recovery.injury_history(tenant_id);
CREATE INDEX IF NOT EXISTS ix_recovery_injury_history_user ON recovery.injury_history(user_id);
CREATE INDEX IF NOT EXISTS ix_recovery_injury_history_attrs ON recovery.injury_history USING gin(attributes);

CREATE TABLE IF NOT EXISTS recovery.injury_restriction (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE recovery.injury_restriction IS 'Entidade de Recovery System para InjuryRestriction.';
CREATE INDEX IF NOT EXISTS ix_recovery_injury_restriction_tenant ON recovery.injury_restriction(tenant_id);
CREATE INDEX IF NOT EXISTS ix_recovery_injury_restriction_user ON recovery.injury_restriction(user_id);
CREATE INDEX IF NOT EXISTS ix_recovery_injury_restriction_attrs ON recovery.injury_restriction USING gin(attributes);

CREATE TABLE IF NOT EXISTS recovery.stress_record (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE recovery.stress_record IS 'Entidade de Recovery System para StressRecord.';
CREATE INDEX IF NOT EXISTS ix_recovery_stress_record_tenant ON recovery.stress_record(tenant_id);
CREATE INDEX IF NOT EXISTS ix_recovery_stress_record_user ON recovery.stress_record(user_id);
CREATE INDEX IF NOT EXISTS ix_recovery_stress_record_attrs ON recovery.stress_record USING gin(attributes);

CREATE TABLE IF NOT EXISTS recovery.resting_heart_rate_record (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE recovery.resting_heart_rate_record IS 'Entidade de Recovery System para RestingHeartRateRecord.';
CREATE INDEX IF NOT EXISTS ix_recovery_resting_heart_rate_record_tenant ON recovery.resting_heart_rate_record(tenant_id);
CREATE INDEX IF NOT EXISTS ix_recovery_resting_heart_rate_record_user ON recovery.resting_heart_rate_record(user_id);
CREATE INDEX IF NOT EXISTS ix_recovery_resting_heart_rate_record_attrs ON recovery.resting_heart_rate_record USING gin(attributes);

CREATE TABLE IF NOT EXISTS recovery.hrv_record (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE recovery.hrv_record IS 'Entidade de Recovery System para HrvRecord.';
CREATE INDEX IF NOT EXISTS ix_recovery_hrv_record_tenant ON recovery.hrv_record(tenant_id);
CREATE INDEX IF NOT EXISTS ix_recovery_hrv_record_user ON recovery.hrv_record(user_id);
CREATE INDEX IF NOT EXISTS ix_recovery_hrv_record_attrs ON recovery.hrv_record USING gin(attributes);

CREATE TABLE IF NOT EXISTS recovery.respiratory_rate_record (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE recovery.respiratory_rate_record IS 'Entidade de Recovery System para RespiratoryRateRecord.';
CREATE INDEX IF NOT EXISTS ix_recovery_respiratory_rate_record_tenant ON recovery.respiratory_rate_record(tenant_id);
CREATE INDEX IF NOT EXISTS ix_recovery_respiratory_rate_record_user ON recovery.respiratory_rate_record(user_id);
CREATE INDEX IF NOT EXISTS ix_recovery_respiratory_rate_record_attrs ON recovery.respiratory_rate_record USING gin(attributes);

CREATE TABLE IF NOT EXISTS recovery.recovery_recommendation (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE recovery.recovery_recommendation IS 'Entidade de Recovery System para RecoveryRecommendation.';
CREATE INDEX IF NOT EXISTS ix_recovery_recovery_recommendation_tenant ON recovery.recovery_recommendation(tenant_id);
CREATE INDEX IF NOT EXISTS ix_recovery_recovery_recommendation_user ON recovery.recovery_recommendation(user_id);
CREATE INDEX IF NOT EXISTS ix_recovery_recovery_recommendation_attrs ON recovery.recovery_recommendation USING gin(attributes);

CREATE TABLE IF NOT EXISTS recovery.deload_execution (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE recovery.deload_execution IS 'Entidade de Recovery System para DeloadExecution.';
CREATE INDEX IF NOT EXISTS ix_recovery_deload_execution_tenant ON recovery.deload_execution(tenant_id);
CREATE INDEX IF NOT EXISTS ix_recovery_deload_execution_user ON recovery.deload_execution(user_id);
CREATE INDEX IF NOT EXISTS ix_recovery_deload_execution_attrs ON recovery.deload_execution USING gin(attributes);

CREATE TABLE IF NOT EXISTS recovery.active_recovery_session (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE recovery.active_recovery_session IS 'Entidade de Recovery System para ActiveRecoverySession.';
CREATE INDEX IF NOT EXISTS ix_recovery_active_recovery_session_tenant ON recovery.active_recovery_session(tenant_id);
CREATE INDEX IF NOT EXISTS ix_recovery_active_recovery_session_user ON recovery.active_recovery_session(user_id);
CREATE INDEX IF NOT EXISTS ix_recovery_active_recovery_session_attrs ON recovery.active_recovery_session USING gin(attributes);

CREATE TABLE IF NOT EXISTS recovery.massage_session (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE recovery.massage_session IS 'Entidade de Recovery System para MassageSession.';
CREATE INDEX IF NOT EXISTS ix_recovery_massage_session_tenant ON recovery.massage_session(tenant_id);
CREATE INDEX IF NOT EXISTS ix_recovery_massage_session_user ON recovery.massage_session(user_id);
CREATE INDEX IF NOT EXISTS ix_recovery_massage_session_attrs ON recovery.massage_session USING gin(attributes);

CREATE TABLE IF NOT EXISTS recovery.hydrotherapy_session (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE recovery.hydrotherapy_session IS 'Entidade de Recovery System para HydrotherapySession.';
CREATE INDEX IF NOT EXISTS ix_recovery_hydrotherapy_session_tenant ON recovery.hydrotherapy_session(tenant_id);
CREATE INDEX IF NOT EXISTS ix_recovery_hydrotherapy_session_user ON recovery.hydrotherapy_session(user_id);
CREATE INDEX IF NOT EXISTS ix_recovery_hydrotherapy_session_attrs ON recovery.hydrotherapy_session USING gin(attributes);

CREATE TABLE IF NOT EXISTS recovery.recovery_alert (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE recovery.recovery_alert IS 'Entidade de Recovery System para RecoveryAlert.';
CREATE INDEX IF NOT EXISTS ix_recovery_recovery_alert_tenant ON recovery.recovery_alert(tenant_id);
CREATE INDEX IF NOT EXISTS ix_recovery_recovery_alert_user ON recovery.recovery_alert(user_id);
CREATE INDEX IF NOT EXISTS ix_recovery_recovery_alert_attrs ON recovery.recovery_alert USING gin(attributes);

CREATE TABLE IF NOT EXISTS recovery.return_to_training_decision (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE recovery.return_to_training_decision IS 'Entidade de Recovery System para ReturnToTrainingDecision.';
CREATE INDEX IF NOT EXISTS ix_recovery_return_to_training_decision_tenant ON recovery.return_to_training_decision(tenant_id);
CREATE INDEX IF NOT EXISTS ix_recovery_return_to_training_decision_user ON recovery.return_to_training_decision(user_id);
CREATE INDEX IF NOT EXISTS ix_recovery_return_to_training_decision_attrs ON recovery.return_to_training_decision USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.nutrition_profile (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.nutrition_profile IS 'Entidade de Nutrition Intelligence para NutritionProfile.';
CREATE INDEX IF NOT EXISTS ix_nutrition_nutrition_profile_tenant ON nutrition.nutrition_profile(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_nutrition_profile_user ON nutrition.nutrition_profile(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_nutrition_profile_attrs ON nutrition.nutrition_profile USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.nutrition_goal (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.nutrition_goal IS 'Entidade de Nutrition Intelligence para NutritionGoal.';
CREATE INDEX IF NOT EXISTS ix_nutrition_nutrition_goal_tenant ON nutrition.nutrition_goal(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_nutrition_goal_user ON nutrition.nutrition_goal(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_nutrition_goal_attrs ON nutrition.nutrition_goal USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.meal_plan (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.meal_plan IS 'Entidade de Nutrition Intelligence para MealPlan.';
CREATE INDEX IF NOT EXISTS ix_nutrition_meal_plan_tenant ON nutrition.meal_plan(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_meal_plan_user ON nutrition.meal_plan(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_meal_plan_attrs ON nutrition.meal_plan USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.meal (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.meal IS 'Entidade de Nutrition Intelligence para Meal.';
CREATE INDEX IF NOT EXISTS ix_nutrition_meal_tenant ON nutrition.meal(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_meal_user ON nutrition.meal(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_meal_attrs ON nutrition.meal USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.meal_item (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.meal_item IS 'Entidade de Nutrition Intelligence para MealItem.';
CREATE INDEX IF NOT EXISTS ix_nutrition_meal_item_tenant ON nutrition.meal_item(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_meal_item_user ON nutrition.meal_item(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_meal_item_attrs ON nutrition.meal_item USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.food (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.food IS 'Entidade de Nutrition Intelligence para Food.';
CREATE INDEX IF NOT EXISTS ix_nutrition_food_tenant ON nutrition.food(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_food_user ON nutrition.food(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_food_attrs ON nutrition.food USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.food_brand (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.food_brand IS 'Entidade de Nutrition Intelligence para FoodBrand.';
CREATE INDEX IF NOT EXISTS ix_nutrition_food_brand_tenant ON nutrition.food_brand(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_food_brand_user ON nutrition.food_brand(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_food_brand_attrs ON nutrition.food_brand USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.food_portion (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.food_portion IS 'Entidade de Nutrition Intelligence para FoodPortion.';
CREATE INDEX IF NOT EXISTS ix_nutrition_food_portion_tenant ON nutrition.food_portion(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_food_portion_user ON nutrition.food_portion(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_food_portion_attrs ON nutrition.food_portion USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.macro_target (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.macro_target IS 'Entidade de Nutrition Intelligence para MacroTarget.';
CREATE INDEX IF NOT EXISTS ix_nutrition_macro_target_tenant ON nutrition.macro_target(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_macro_target_user ON nutrition.macro_target(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_macro_target_attrs ON nutrition.macro_target USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.micronutrient_target (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.micronutrient_target IS 'Entidade de Nutrition Intelligence para MicronutrientTarget.';
CREATE INDEX IF NOT EXISTS ix_nutrition_micronutrient_target_tenant ON nutrition.micronutrient_target(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_micronutrient_target_user ON nutrition.micronutrient_target(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_micronutrient_target_attrs ON nutrition.micronutrient_target USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.calorie_budget (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.calorie_budget IS 'Entidade de Nutrition Intelligence para CalorieBudget.';
CREATE INDEX IF NOT EXISTS ix_nutrition_calorie_budget_tenant ON nutrition.calorie_budget(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_calorie_budget_user ON nutrition.calorie_budget(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_calorie_budget_attrs ON nutrition.calorie_budget USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.protein_target (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.protein_target IS 'Entidade de Nutrition Intelligence para ProteinTarget.';
CREATE INDEX IF NOT EXISTS ix_nutrition_protein_target_tenant ON nutrition.protein_target(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_protein_target_user ON nutrition.protein_target(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_protein_target_attrs ON nutrition.protein_target USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.hydration_target (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.hydration_target IS 'Entidade de Nutrition Intelligence para HydrationTarget.';
CREATE INDEX IF NOT EXISTS ix_nutrition_hydration_target_tenant ON nutrition.hydration_target(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_hydration_target_user ON nutrition.hydration_target(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_hydration_target_attrs ON nutrition.hydration_target USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.hydration_record (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.hydration_record IS 'Entidade de Nutrition Intelligence para HydrationRecord.';
CREATE INDEX IF NOT EXISTS ix_nutrition_hydration_record_tenant ON nutrition.hydration_record(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_hydration_record_user ON nutrition.hydration_record(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_hydration_record_attrs ON nutrition.hydration_record USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.supplement (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.supplement IS 'Entidade de Nutrition Intelligence para Supplement.';
CREATE INDEX IF NOT EXISTS ix_nutrition_supplement_tenant ON nutrition.supplement(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_supplement_user ON nutrition.supplement(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_supplement_attrs ON nutrition.supplement USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.supplement_protocol (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.supplement_protocol IS 'Entidade de Nutrition Intelligence para SupplementProtocol.';
CREATE INDEX IF NOT EXISTS ix_nutrition_supplement_protocol_tenant ON nutrition.supplement_protocol(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_supplement_protocol_user ON nutrition.supplement_protocol(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_supplement_protocol_attrs ON nutrition.supplement_protocol USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.supplement_intake (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.supplement_intake IS 'Entidade de Nutrition Intelligence para SupplementIntake.';
CREATE INDEX IF NOT EXISTS ix_nutrition_supplement_intake_tenant ON nutrition.supplement_intake(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_supplement_intake_user ON nutrition.supplement_intake(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_supplement_intake_attrs ON nutrition.supplement_intake USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.grocery_list (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.grocery_list IS 'Entidade de Nutrition Intelligence para GroceryList.';
CREATE INDEX IF NOT EXISTS ix_nutrition_grocery_list_tenant ON nutrition.grocery_list(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_grocery_list_user ON nutrition.grocery_list(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_grocery_list_attrs ON nutrition.grocery_list USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.recipe (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.recipe IS 'Entidade de Nutrition Intelligence para Recipe.';
CREATE INDEX IF NOT EXISTS ix_nutrition_recipe_tenant ON nutrition.recipe(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_recipe_user ON nutrition.recipe(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_recipe_attrs ON nutrition.recipe USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.recipe_ingredient (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.recipe_ingredient IS 'Entidade de Nutrition Intelligence para RecipeIngredient.';
CREATE INDEX IF NOT EXISTS ix_nutrition_recipe_ingredient_tenant ON nutrition.recipe_ingredient(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_recipe_ingredient_user ON nutrition.recipe_ingredient(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_recipe_ingredient_attrs ON nutrition.recipe_ingredient USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.eating_window (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.eating_window IS 'Entidade de Nutrition Intelligence para EatingWindow.';
CREATE INDEX IF NOT EXISTS ix_nutrition_eating_window_tenant ON nutrition.eating_window(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_eating_window_user ON nutrition.eating_window(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_eating_window_attrs ON nutrition.eating_window USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.dietary_restriction (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.dietary_restriction IS 'Entidade de Nutrition Intelligence para DietaryRestriction.';
CREATE INDEX IF NOT EXISTS ix_nutrition_dietary_restriction_tenant ON nutrition.dietary_restriction(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_dietary_restriction_user ON nutrition.dietary_restriction(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_dietary_restriction_attrs ON nutrition.dietary_restriction USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.allergy (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.allergy IS 'Entidade de Nutrition Intelligence para Allergy.';
CREATE INDEX IF NOT EXISTS ix_nutrition_allergy_tenant ON nutrition.allergy(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_allergy_user ON nutrition.allergy(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_allergy_attrs ON nutrition.allergy USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.nutrition_check_in (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.nutrition_check_in IS 'Entidade de Nutrition Intelligence para NutritionCheckIn.';
CREATE INDEX IF NOT EXISTS ix_nutrition_nutrition_check_in_tenant ON nutrition.nutrition_check_in(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_nutrition_check_in_user ON nutrition.nutrition_check_in(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_nutrition_check_in_attrs ON nutrition.nutrition_check_in USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.body_recomposition_plan (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.body_recomposition_plan IS 'Entidade de Nutrition Intelligence para BodyRecompositionPlan.';
CREATE INDEX IF NOT EXISTS ix_nutrition_body_recomposition_plan_tenant ON nutrition.body_recomposition_plan(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_body_recomposition_plan_user ON nutrition.body_recomposition_plan(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_body_recomposition_plan_attrs ON nutrition.body_recomposition_plan USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.meal_prep_task (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.meal_prep_task IS 'Entidade de Nutrition Intelligence para MealPrepTask.';
CREATE INDEX IF NOT EXISTS ix_nutrition_meal_prep_task_tenant ON nutrition.meal_prep_task(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_meal_prep_task_user ON nutrition.meal_prep_task(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_meal_prep_task_attrs ON nutrition.meal_prep_task USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.nutrition_adherence_score (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.nutrition_adherence_score IS 'Entidade de Nutrition Intelligence para NutritionAdherenceScore.';
CREATE INDEX IF NOT EXISTS ix_nutrition_nutrition_adherence_score_tenant ON nutrition.nutrition_adherence_score(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_nutrition_adherence_score_user ON nutrition.nutrition_adherence_score(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_nutrition_adherence_score_attrs ON nutrition.nutrition_adherence_score USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.nutrition_education_card (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.nutrition_education_card IS 'Entidade de Nutrition Intelligence para NutritionEducationCard.';
CREATE INDEX IF NOT EXISTS ix_nutrition_nutrition_education_card_tenant ON nutrition.nutrition_education_card(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_nutrition_education_card_user ON nutrition.nutrition_education_card(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_nutrition_education_card_attrs ON nutrition.nutrition_education_card USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.nutrition_protocol (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.nutrition_protocol IS 'Entidade de Nutrition Intelligence para NutritionProtocol.';
CREATE INDEX IF NOT EXISTS ix_nutrition_nutrition_protocol_tenant ON nutrition.nutrition_protocol(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_nutrition_protocol_user ON nutrition.nutrition_protocol(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_nutrition_protocol_attrs ON nutrition.nutrition_protocol USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.nutrition_phase (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.nutrition_phase IS 'Entidade de Nutrition Intelligence para NutritionPhase.';
CREATE INDEX IF NOT EXISTS ix_nutrition_nutrition_phase_tenant ON nutrition.nutrition_phase(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_nutrition_phase_user ON nutrition.nutrition_phase(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_nutrition_phase_attrs ON nutrition.nutrition_phase USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.phoenix_foundation_protocol (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.phoenix_foundation_protocol IS 'Entidade de Nutrition Intelligence para PhoenixFoundationProtocol.';
CREATE INDEX IF NOT EXISTS ix_nutrition_phoenix_foundation_protocol_tenant ON nutrition.phoenix_foundation_protocol(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_phoenix_foundation_protocol_user ON nutrition.phoenix_foundation_protocol(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_phoenix_foundation_protocol_attrs ON nutrition.phoenix_foundation_protocol USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.phoenix_recomp_protocol (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.phoenix_recomp_protocol IS 'Entidade de Nutrition Intelligence para PhoenixRecompProtocol.';
CREATE INDEX IF NOT EXISTS ix_nutrition_phoenix_recomp_protocol_tenant ON nutrition.phoenix_recomp_protocol(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_phoenix_recomp_protocol_user ON nutrition.phoenix_recomp_protocol(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_phoenix_recomp_protocol_attrs ON nutrition.phoenix_recomp_protocol USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.phoenix_hypertrophy_protocol (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.phoenix_hypertrophy_protocol IS 'Entidade de Nutrition Intelligence para PhoenixHypertrophyProtocol.';
CREATE INDEX IF NOT EXISTS ix_nutrition_phoenix_hypertrophy_protocol_tenant ON nutrition.phoenix_hypertrophy_protocol(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_phoenix_hypertrophy_protocol_user ON nutrition.phoenix_hypertrophy_protocol(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_phoenix_hypertrophy_protocol_attrs ON nutrition.phoenix_hypertrophy_protocol USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.phoenix_cut_protocol (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.phoenix_cut_protocol IS 'Entidade de Nutrition Intelligence para PhoenixCutProtocol.';
CREATE INDEX IF NOT EXISTS ix_nutrition_phoenix_cut_protocol_tenant ON nutrition.phoenix_cut_protocol(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_phoenix_cut_protocol_user ON nutrition.phoenix_cut_protocol(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_phoenix_cut_protocol_attrs ON nutrition.phoenix_cut_protocol USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.phoenix_peak_protocol (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.phoenix_peak_protocol IS 'Entidade de Nutrition Intelligence para PhoenixPeakProtocol.';
CREATE INDEX IF NOT EXISTS ix_nutrition_phoenix_peak_protocol_tenant ON nutrition.phoenix_peak_protocol(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_phoenix_peak_protocol_user ON nutrition.phoenix_peak_protocol(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_phoenix_peak_protocol_attrs ON nutrition.phoenix_peak_protocol USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.bodybuilding_nutrition_plan (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.bodybuilding_nutrition_plan IS 'Entidade de Nutrition Intelligence para BodybuildingNutritionPlan.';
CREATE INDEX IF NOT EXISTS ix_nutrition_bodybuilding_nutrition_plan_tenant ON nutrition.bodybuilding_nutrition_plan(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_bodybuilding_nutrition_plan_user ON nutrition.bodybuilding_nutrition_plan(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_bodybuilding_nutrition_plan_attrs ON nutrition.bodybuilding_nutrition_plan USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.macro_cycle_plan (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.macro_cycle_plan IS 'Entidade de Nutrition Intelligence para MacroCyclePlan.';
CREATE INDEX IF NOT EXISTS ix_nutrition_macro_cycle_plan_tenant ON nutrition.macro_cycle_plan(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_macro_cycle_plan_user ON nutrition.macro_cycle_plan(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_macro_cycle_plan_attrs ON nutrition.macro_cycle_plan USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.carb_cycling_rule (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.carb_cycling_rule IS 'Entidade de Nutrition Intelligence para CarbCyclingRule.';
CREATE INDEX IF NOT EXISTS ix_nutrition_carb_cycling_rule_tenant ON nutrition.carb_cycling_rule(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_carb_cycling_rule_user ON nutrition.carb_cycling_rule(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_carb_cycling_rule_attrs ON nutrition.carb_cycling_rule USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.carb_source (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.carb_source IS 'Entidade de Nutrition Intelligence para CarbSource.';
CREATE INDEX IF NOT EXISTS ix_nutrition_carb_source_tenant ON nutrition.carb_source(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_carb_source_user ON nutrition.carb_source(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_carb_source_attrs ON nutrition.carb_source USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.protein_source (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.protein_source IS 'Entidade de Nutrition Intelligence para ProteinSource.';
CREATE INDEX IF NOT EXISTS ix_nutrition_protein_source_tenant ON nutrition.protein_source(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_protein_source_user ON nutrition.protein_source(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_protein_source_attrs ON nutrition.protein_source USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.food_replacement_matrix (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.food_replacement_matrix IS 'Entidade de Nutrition Intelligence para FoodReplacementMatrix.';
CREATE INDEX IF NOT EXISTS ix_nutrition_food_replacement_matrix_tenant ON nutrition.food_replacement_matrix(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_food_replacement_matrix_user ON nutrition.food_replacement_matrix(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_food_replacement_matrix_attrs ON nutrition.food_replacement_matrix USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.meal_timing_window (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.meal_timing_window IS 'Entidade de Nutrition Intelligence para MealTimingWindow.';
CREATE INDEX IF NOT EXISTS ix_nutrition_meal_timing_window_tenant ON nutrition.meal_timing_window(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_meal_timing_window_user ON nutrition.meal_timing_window(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_meal_timing_window_attrs ON nutrition.meal_timing_window USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.pre_workout_meal (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.pre_workout_meal IS 'Entidade de Nutrition Intelligence para PreWorkoutMeal.';
CREATE INDEX IF NOT EXISTS ix_nutrition_pre_workout_meal_tenant ON nutrition.pre_workout_meal(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_pre_workout_meal_user ON nutrition.pre_workout_meal(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_pre_workout_meal_attrs ON nutrition.pre_workout_meal USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.post_workout_meal (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.post_workout_meal IS 'Entidade de Nutrition Intelligence para PostWorkoutMeal.';
CREATE INDEX IF NOT EXISTS ix_nutrition_post_workout_meal_tenant ON nutrition.post_workout_meal(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_post_workout_meal_user ON nutrition.post_workout_meal(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_post_workout_meal_attrs ON nutrition.post_workout_meal USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.night_shift_nutrition_plan (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.night_shift_nutrition_plan IS 'Entidade de Nutrition Intelligence para NightShiftNutritionPlan.';
CREATE INDEX IF NOT EXISTS ix_nutrition_night_shift_nutrition_plan_tenant ON nutrition.night_shift_nutrition_plan(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_night_shift_nutrition_plan_user ON nutrition.night_shift_nutrition_plan(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_night_shift_nutrition_plan_attrs ON nutrition.night_shift_nutrition_plan USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.nutrition_score (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.nutrition_score IS 'Entidade de Nutrition Intelligence para NutritionScore.';
CREATE INDEX IF NOT EXISTS ix_nutrition_nutrition_score_tenant ON nutrition.nutrition_score(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_nutrition_score_user ON nutrition.nutrition_score(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_nutrition_score_attrs ON nutrition.nutrition_score USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.nutrition_score_component (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.nutrition_score_component IS 'Entidade de Nutrition Intelligence para NutritionScoreComponent.';
CREATE INDEX IF NOT EXISTS ix_nutrition_nutrition_score_component_tenant ON nutrition.nutrition_score_component(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_nutrition_score_component_user ON nutrition.nutrition_score_component(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_nutrition_score_component_attrs ON nutrition.nutrition_score_component USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.fourteen_day_nutrition_review (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.fourteen_day_nutrition_review IS 'Entidade de Nutrition Intelligence para FourteenDayNutritionReview.';
CREATE INDEX IF NOT EXISTS ix_nutrition_fourteen_day_nutrition_review_tenant ON nutrition.fourteen_day_nutrition_review(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_fourteen_day_nutrition_review_user ON nutrition.fourteen_day_nutrition_review(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_fourteen_day_nutrition_review_attrs ON nutrition.fourteen_day_nutrition_review USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.nutrition_adjustment_rule (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.nutrition_adjustment_rule IS 'Entidade de Nutrition Intelligence para NutritionAdjustmentRule.';
CREATE INDEX IF NOT EXISTS ix_nutrition_nutrition_adjustment_rule_tenant ON nutrition.nutrition_adjustment_rule(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_nutrition_adjustment_rule_user ON nutrition.nutrition_adjustment_rule(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_nutrition_adjustment_rule_attrs ON nutrition.nutrition_adjustment_rule USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.waist_velocity_signal (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.waist_velocity_signal IS 'Entidade de Nutrition Intelligence para WaistVelocitySignal.';
CREATE INDEX IF NOT EXISTS ix_nutrition_waist_velocity_signal_tenant ON nutrition.waist_velocity_signal(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_waist_velocity_signal_user ON nutrition.waist_velocity_signal(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_waist_velocity_signal_attrs ON nutrition.waist_velocity_signal USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.strength_nutrition_signal (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.strength_nutrition_signal IS 'Entidade de Nutrition Intelligence para StrengthNutritionSignal.';
CREATE INDEX IF NOT EXISTS ix_nutrition_strength_nutrition_signal_tenant ON nutrition.strength_nutrition_signal(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_strength_nutrition_signal_user ON nutrition.strength_nutrition_signal(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_strength_nutrition_signal_attrs ON nutrition.strength_nutrition_signal USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.digestion_record (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.digestion_record IS 'Entidade de Nutrition Intelligence para DigestionRecord.';
CREATE INDEX IF NOT EXISTS ix_nutrition_digestion_record_tenant ON nutrition.digestion_record(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_digestion_record_user ON nutrition.digestion_record(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_digestion_record_attrs ON nutrition.digestion_record USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.alcohol_ultra_processed_control (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.alcohol_ultra_processed_control IS 'Entidade de Nutrition Intelligence para AlcoholUltraProcessedControl.';
CREATE INDEX IF NOT EXISTS ix_nutrition_alcohol_ultra_processed_control_tenant ON nutrition.alcohol_ultra_processed_control(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_alcohol_ultra_processed_control_user ON nutrition.alcohol_ultra_processed_control(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_alcohol_ultra_processed_control_attrs ON nutrition.alcohol_ultra_processed_control USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.gym_meal_template (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.gym_meal_template IS 'Entidade de Nutrition Intelligence para GymMealTemplate.';
CREATE INDEX IF NOT EXISTS ix_nutrition_gym_meal_template_tenant ON nutrition.gym_meal_template(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_gym_meal_template_user ON nutrition.gym_meal_template(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_gym_meal_template_attrs ON nutrition.gym_meal_template USING gin(attributes);

CREATE TABLE IF NOT EXISTS nutrition.nutritionist_review (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE nutrition.nutritionist_review IS 'Entidade de Nutrition Intelligence para NutritionistReview.';
CREATE INDEX IF NOT EXISTS ix_nutrition_nutritionist_review_tenant ON nutrition.nutritionist_review(tenant_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_nutritionist_review_user ON nutrition.nutritionist_review(user_id);
CREATE INDEX IF NOT EXISTS ix_nutrition_nutritionist_review_attrs ON nutrition.nutritionist_review USING gin(attributes);

CREATE TABLE IF NOT EXISTS mental.mental_profile (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE mental.mental_profile IS 'Entidade de Mental Performance para MentalProfile.';
CREATE INDEX IF NOT EXISTS ix_mental_mental_profile_tenant ON mental.mental_profile(tenant_id);
CREATE INDEX IF NOT EXISTS ix_mental_mental_profile_user ON mental.mental_profile(user_id);
CREATE INDEX IF NOT EXISTS ix_mental_mental_profile_attrs ON mental.mental_profile USING gin(attributes);

CREATE TABLE IF NOT EXISTS mental.habit (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE mental.habit IS 'Entidade de Mental Performance para Habit.';
CREATE INDEX IF NOT EXISTS ix_mental_habit_tenant ON mental.habit(tenant_id);
CREATE INDEX IF NOT EXISTS ix_mental_habit_user ON mental.habit(user_id);
CREATE INDEX IF NOT EXISTS ix_mental_habit_attrs ON mental.habit USING gin(attributes);

CREATE TABLE IF NOT EXISTS mental.habit_log (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE mental.habit_log IS 'Entidade de Mental Performance para HabitLog.';
CREATE INDEX IF NOT EXISTS ix_mental_habit_log_tenant ON mental.habit_log(tenant_id);
CREATE INDEX IF NOT EXISTS ix_mental_habit_log_user ON mental.habit_log(user_id);
CREATE INDEX IF NOT EXISTS ix_mental_habit_log_attrs ON mental.habit_log USING gin(attributes);

CREATE TABLE IF NOT EXISTS mental.discipline_protocol (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE mental.discipline_protocol IS 'Entidade de Mental Performance para DisciplineProtocol.';
CREATE INDEX IF NOT EXISTS ix_mental_discipline_protocol_tenant ON mental.discipline_protocol(tenant_id);
CREATE INDEX IF NOT EXISTS ix_mental_discipline_protocol_user ON mental.discipline_protocol(user_id);
CREATE INDEX IF NOT EXISTS ix_mental_discipline_protocol_attrs ON mental.discipline_protocol USING gin(attributes);

CREATE TABLE IF NOT EXISTS mental.focus_session (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE mental.focus_session IS 'Entidade de Mental Performance para FocusSession.';
CREATE INDEX IF NOT EXISTS ix_mental_focus_session_tenant ON mental.focus_session(tenant_id);
CREATE INDEX IF NOT EXISTS ix_mental_focus_session_user ON mental.focus_session(user_id);
CREATE INDEX IF NOT EXISTS ix_mental_focus_session_attrs ON mental.focus_session USING gin(attributes);

CREATE TABLE IF NOT EXISTS mental.mood_record (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE mental.mood_record IS 'Entidade de Mental Performance para MoodRecord.';
CREATE INDEX IF NOT EXISTS ix_mental_mood_record_tenant ON mental.mood_record(tenant_id);
CREATE INDEX IF NOT EXISTS ix_mental_mood_record_user ON mental.mood_record(user_id);
CREATE INDEX IF NOT EXISTS ix_mental_mood_record_attrs ON mental.mood_record USING gin(attributes);

CREATE TABLE IF NOT EXISTS mental.journal_entry (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE mental.journal_entry IS 'Entidade de Mental Performance para JournalEntry.';
CREATE INDEX IF NOT EXISTS ix_mental_journal_entry_tenant ON mental.journal_entry(tenant_id);
CREATE INDEX IF NOT EXISTS ix_mental_journal_entry_user ON mental.journal_entry(user_id);
CREATE INDEX IF NOT EXISTS ix_mental_journal_entry_attrs ON mental.journal_entry USING gin(attributes);

CREATE TABLE IF NOT EXISTS mental.reflection_prompt (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE mental.reflection_prompt IS 'Entidade de Mental Performance para ReflectionPrompt.';
CREATE INDEX IF NOT EXISTS ix_mental_reflection_prompt_tenant ON mental.reflection_prompt(tenant_id);
CREATE INDEX IF NOT EXISTS ix_mental_reflection_prompt_user ON mental.reflection_prompt(user_id);
CREATE INDEX IF NOT EXISTS ix_mental_reflection_prompt_attrs ON mental.reflection_prompt USING gin(attributes);

CREATE TABLE IF NOT EXISTS mental.breathwork_protocol (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE mental.breathwork_protocol IS 'Entidade de Mental Performance para BreathworkProtocol.';
CREATE INDEX IF NOT EXISTS ix_mental_breathwork_protocol_tenant ON mental.breathwork_protocol(tenant_id);
CREATE INDEX IF NOT EXISTS ix_mental_breathwork_protocol_user ON mental.breathwork_protocol(user_id);
CREATE INDEX IF NOT EXISTS ix_mental_breathwork_protocol_attrs ON mental.breathwork_protocol USING gin(attributes);

CREATE TABLE IF NOT EXISTS mental.breathwork_session (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE mental.breathwork_session IS 'Entidade de Mental Performance para BreathworkSession.';
CREATE INDEX IF NOT EXISTS ix_mental_breathwork_session_tenant ON mental.breathwork_session(tenant_id);
CREATE INDEX IF NOT EXISTS ix_mental_breathwork_session_user ON mental.breathwork_session(user_id);
CREATE INDEX IF NOT EXISTS ix_mental_breathwork_session_attrs ON mental.breathwork_session USING gin(attributes);

CREATE TABLE IF NOT EXISTS mental.visualization_session (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE mental.visualization_session IS 'Entidade de Mental Performance para VisualizationSession.';
CREATE INDEX IF NOT EXISTS ix_mental_visualization_session_tenant ON mental.visualization_session(tenant_id);
CREATE INDEX IF NOT EXISTS ix_mental_visualization_session_user ON mental.visualization_session(user_id);
CREATE INDEX IF NOT EXISTS ix_mental_visualization_session_attrs ON mental.visualization_session USING gin(attributes);

CREATE TABLE IF NOT EXISTS mental.stress_trigger (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE mental.stress_trigger IS 'Entidade de Mental Performance para StressTrigger.';
CREATE INDEX IF NOT EXISTS ix_mental_stress_trigger_tenant ON mental.stress_trigger(tenant_id);
CREATE INDEX IF NOT EXISTS ix_mental_stress_trigger_user ON mental.stress_trigger(user_id);
CREATE INDEX IF NOT EXISTS ix_mental_stress_trigger_attrs ON mental.stress_trigger USING gin(attributes);

CREATE TABLE IF NOT EXISTS mental.coping_strategy (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE mental.coping_strategy IS 'Entidade de Mental Performance para CopingStrategy.';
CREATE INDEX IF NOT EXISTS ix_mental_coping_strategy_tenant ON mental.coping_strategy(tenant_id);
CREATE INDEX IF NOT EXISTS ix_mental_coping_strategy_user ON mental.coping_strategy(user_id);
CREATE INDEX IF NOT EXISTS ix_mental_coping_strategy_attrs ON mental.coping_strategy USING gin(attributes);

CREATE TABLE IF NOT EXISTS mental.motivation_script (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE mental.motivation_script IS 'Entidade de Mental Performance para MotivationScript.';
CREATE INDEX IF NOT EXISTS ix_mental_motivation_script_tenant ON mental.motivation_script(tenant_id);
CREATE INDEX IF NOT EXISTS ix_mental_motivation_script_user ON mental.motivation_script(user_id);
CREATE INDEX IF NOT EXISTS ix_mental_motivation_script_attrs ON mental.motivation_script USING gin(attributes);

CREATE TABLE IF NOT EXISTS mental.identity_statement (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE mental.identity_statement IS 'Entidade de Mental Performance para IdentityStatement.';
CREATE INDEX IF NOT EXISTS ix_mental_identity_statement_tenant ON mental.identity_statement(tenant_id);
CREATE INDEX IF NOT EXISTS ix_mental_identity_statement_user ON mental.identity_statement(user_id);
CREATE INDEX IF NOT EXISTS ix_mental_identity_statement_attrs ON mental.identity_statement USING gin(attributes);

CREATE TABLE IF NOT EXISTS mental.commitment_contract (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE mental.commitment_contract IS 'Entidade de Mental Performance para CommitmentContract.';
CREATE INDEX IF NOT EXISTS ix_mental_commitment_contract_tenant ON mental.commitment_contract(tenant_id);
CREATE INDEX IF NOT EXISTS ix_mental_commitment_contract_user ON mental.commitment_contract(user_id);
CREATE INDEX IF NOT EXISTS ix_mental_commitment_contract_attrs ON mental.commitment_contract USING gin(attributes);

CREATE TABLE IF NOT EXISTS mental.self_efficacy_score (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE mental.self_efficacy_score IS 'Entidade de Mental Performance para SelfEfficacyScore.';
CREATE INDEX IF NOT EXISTS ix_mental_self_efficacy_score_tenant ON mental.self_efficacy_score(tenant_id);
CREATE INDEX IF NOT EXISTS ix_mental_self_efficacy_score_user ON mental.self_efficacy_score(user_id);
CREATE INDEX IF NOT EXISTS ix_mental_self_efficacy_score_attrs ON mental.self_efficacy_score USING gin(attributes);

CREATE TABLE IF NOT EXISTS mental.dropout_risk_signal (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE mental.dropout_risk_signal IS 'Entidade de Mental Performance para DropoutRiskSignal.';
CREATE INDEX IF NOT EXISTS ix_mental_dropout_risk_signal_tenant ON mental.dropout_risk_signal(tenant_id);
CREATE INDEX IF NOT EXISTS ix_mental_dropout_risk_signal_user ON mental.dropout_risk_signal(user_id);
CREATE INDEX IF NOT EXISTS ix_mental_dropout_risk_signal_attrs ON mental.dropout_risk_signal USING gin(attributes);

CREATE TABLE IF NOT EXISTS mental.intervention_message (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE mental.intervention_message IS 'Entidade de Mental Performance para InterventionMessage.';
CREATE INDEX IF NOT EXISTS ix_mental_intervention_message_tenant ON mental.intervention_message(tenant_id);
CREATE INDEX IF NOT EXISTS ix_mental_intervention_message_user ON mental.intervention_message(user_id);
CREATE INDEX IF NOT EXISTS ix_mental_intervention_message_attrs ON mental.intervention_message USING gin(attributes);

CREATE TABLE IF NOT EXISTS mental.mindset_lesson (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE mental.mindset_lesson IS 'Entidade de Mental Performance para MindsetLesson.';
CREATE INDEX IF NOT EXISTS ix_mental_mindset_lesson_tenant ON mental.mindset_lesson(tenant_id);
CREATE INDEX IF NOT EXISTS ix_mental_mindset_lesson_user ON mental.mindset_lesson(user_id);
CREATE INDEX IF NOT EXISTS ix_mental_mindset_lesson_attrs ON mental.mindset_lesson USING gin(attributes);

CREATE TABLE IF NOT EXISTS mental.mental_challenge (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE mental.mental_challenge IS 'Entidade de Mental Performance para MentalChallenge.';
CREATE INDEX IF NOT EXISTS ix_mental_mental_challenge_tenant ON mental.mental_challenge(tenant_id);
CREATE INDEX IF NOT EXISTS ix_mental_mental_challenge_user ON mental.mental_challenge(user_id);
CREATE INDEX IF NOT EXISTS ix_mental_mental_challenge_attrs ON mental.mental_challenge USING gin(attributes);

CREATE TABLE IF NOT EXISTS mental.accountability_check_in (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE mental.accountability_check_in IS 'Entidade de Mental Performance para AccountabilityCheckIn.';
CREATE INDEX IF NOT EXISTS ix_mental_accountability_check_in_tenant ON mental.accountability_check_in(tenant_id);
CREATE INDEX IF NOT EXISTS ix_mental_accountability_check_in_user ON mental.accountability_check_in(user_id);
CREATE INDEX IF NOT EXISTS ix_mental_accountability_check_in_attrs ON mental.accountability_check_in USING gin(attributes);

CREATE TABLE IF NOT EXISTS spiritual.spiritual_profile (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE spiritual.spiritual_profile IS 'Entidade de Spiritual Development para SpiritualProfile.';
CREATE INDEX IF NOT EXISTS ix_spiritual_spiritual_profile_tenant ON spiritual.spiritual_profile(tenant_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_spiritual_profile_user ON spiritual.spiritual_profile(user_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_spiritual_profile_attrs ON spiritual.spiritual_profile USING gin(attributes);

CREATE TABLE IF NOT EXISTS spiritual.devotional_week (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE spiritual.devotional_week IS 'Entidade de Spiritual Development para DevotionalWeek.';
CREATE INDEX IF NOT EXISTS ix_spiritual_devotional_week_tenant ON spiritual.devotional_week(tenant_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_devotional_week_user ON spiritual.devotional_week(user_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_devotional_week_attrs ON spiritual.devotional_week USING gin(attributes);

CREATE TABLE IF NOT EXISTS spiritual.devotional_entry (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE spiritual.devotional_entry IS 'Entidade de Spiritual Development para DevotionalEntry.';
CREATE INDEX IF NOT EXISTS ix_spiritual_devotional_entry_tenant ON spiritual.devotional_entry(tenant_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_devotional_entry_user ON spiritual.devotional_entry(user_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_devotional_entry_attrs ON spiritual.devotional_entry USING gin(attributes);

CREATE TABLE IF NOT EXISTS spiritual.scripture_reference (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE spiritual.scripture_reference IS 'Entidade de Spiritual Development para ScriptureReference.';
CREATE INDEX IF NOT EXISTS ix_spiritual_scripture_reference_tenant ON spiritual.scripture_reference(tenant_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_scripture_reference_user ON spiritual.scripture_reference(user_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_scripture_reference_attrs ON spiritual.scripture_reference USING gin(attributes);

CREATE TABLE IF NOT EXISTS spiritual.prayer_entry (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE spiritual.prayer_entry IS 'Entidade de Spiritual Development para PrayerEntry.';
CREATE INDEX IF NOT EXISTS ix_spiritual_prayer_entry_tenant ON spiritual.prayer_entry(tenant_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_prayer_entry_user ON spiritual.prayer_entry(user_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_prayer_entry_attrs ON spiritual.prayer_entry USING gin(attributes);

CREATE TABLE IF NOT EXISTS spiritual.meditation_session (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE spiritual.meditation_session IS 'Entidade de Spiritual Development para MeditationSession.';
CREATE INDEX IF NOT EXISTS ix_spiritual_meditation_session_tenant ON spiritual.meditation_session(tenant_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_meditation_session_user ON spiritual.meditation_session(user_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_meditation_session_attrs ON spiritual.meditation_session USING gin(attributes);

CREATE TABLE IF NOT EXISTS spiritual.gratitude_entry (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE spiritual.gratitude_entry IS 'Entidade de Spiritual Development para GratitudeEntry.';
CREATE INDEX IF NOT EXISTS ix_spiritual_gratitude_entry_tenant ON spiritual.gratitude_entry(tenant_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_gratitude_entry_user ON spiritual.gratitude_entry(user_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_gratitude_entry_attrs ON spiritual.gratitude_entry USING gin(attributes);

CREATE TABLE IF NOT EXISTS spiritual.value_statement (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE spiritual.value_statement IS 'Entidade de Spiritual Development para ValueStatement.';
CREATE INDEX IF NOT EXISTS ix_spiritual_value_statement_tenant ON spiritual.value_statement(tenant_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_value_statement_user ON spiritual.value_statement(user_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_value_statement_attrs ON spiritual.value_statement USING gin(attributes);

CREATE TABLE IF NOT EXISTS spiritual.purpose_statement (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE spiritual.purpose_statement IS 'Entidade de Spiritual Development para PurposeStatement.';
CREATE INDEX IF NOT EXISTS ix_spiritual_purpose_statement_tenant ON spiritual.purpose_statement(tenant_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_purpose_statement_user ON spiritual.purpose_statement(user_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_purpose_statement_attrs ON spiritual.purpose_statement USING gin(attributes);

CREATE TABLE IF NOT EXISTS spiritual.service_action (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE spiritual.service_action IS 'Entidade de Spiritual Development para ServiceAction.';
CREATE INDEX IF NOT EXISTS ix_spiritual_service_action_tenant ON spiritual.service_action(tenant_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_service_action_user ON spiritual.service_action(user_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_service_action_attrs ON spiritual.service_action USING gin(attributes);

CREATE TABLE IF NOT EXISTS spiritual.faith_preference (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE spiritual.faith_preference IS 'Entidade de Spiritual Development para FaithPreference.';
CREATE INDEX IF NOT EXISTS ix_spiritual_faith_preference_tenant ON spiritual.faith_preference(tenant_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_faith_preference_user ON spiritual.faith_preference(user_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_faith_preference_attrs ON spiritual.faith_preference USING gin(attributes);

CREATE TABLE IF NOT EXISTS spiritual.optionality_consent (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE spiritual.optionality_consent IS 'Entidade de Spiritual Development para OptionalityConsent.';
CREATE INDEX IF NOT EXISTS ix_spiritual_optionality_consent_tenant ON spiritual.optionality_consent(tenant_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_optionality_consent_user ON spiritual.optionality_consent(user_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_optionality_consent_attrs ON spiritual.optionality_consent USING gin(attributes);

CREATE TABLE IF NOT EXISTS spiritual.reflection_response (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE spiritual.reflection_response IS 'Entidade de Spiritual Development para ReflectionResponse.';
CREATE INDEX IF NOT EXISTS ix_spiritual_reflection_response_tenant ON spiritual.reflection_response(tenant_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_reflection_response_user ON spiritual.reflection_response(user_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_reflection_response_attrs ON spiritual.reflection_response USING gin(attributes);

CREATE TABLE IF NOT EXISTS spiritual.spiritual_milestone (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE spiritual.spiritual_milestone IS 'Entidade de Spiritual Development para SpiritualMilestone.';
CREATE INDEX IF NOT EXISTS ix_spiritual_spiritual_milestone_tenant ON spiritual.spiritual_milestone(tenant_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_spiritual_milestone_user ON spiritual.spiritual_milestone(user_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_spiritual_milestone_attrs ON spiritual.spiritual_milestone USING gin(attributes);

CREATE TABLE IF NOT EXISTS spiritual.community_group (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE spiritual.community_group IS 'Entidade de Spiritual Development para CommunityGroup.';
CREATE INDEX IF NOT EXISTS ix_spiritual_community_group_tenant ON spiritual.community_group(tenant_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_community_group_user ON spiritual.community_group(user_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_community_group_attrs ON spiritual.community_group USING gin(attributes);

CREATE TABLE IF NOT EXISTS spiritual.pastoral_resource (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE spiritual.pastoral_resource IS 'Entidade de Spiritual Development para PastoralResource.';
CREATE INDEX IF NOT EXISTS ix_spiritual_pastoral_resource_tenant ON spiritual.pastoral_resource(tenant_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_pastoral_resource_user ON spiritual.pastoral_resource(user_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_pastoral_resource_attrs ON spiritual.pastoral_resource USING gin(attributes);

CREATE TABLE IF NOT EXISTS spiritual.spiritual_content_card (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE spiritual.spiritual_content_card IS 'Entidade de Spiritual Development para SpiritualContentCard.';
CREATE INDEX IF NOT EXISTS ix_spiritual_spiritual_content_card_tenant ON spiritual.spiritual_content_card(tenant_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_spiritual_content_card_user ON spiritual.spiritual_content_card(user_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_spiritual_content_card_attrs ON spiritual.spiritual_content_card USING gin(attributes);

CREATE TABLE IF NOT EXISTS spiritual.belief_boundary (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE spiritual.belief_boundary IS 'Entidade de Spiritual Development para BeliefBoundary.';
CREATE INDEX IF NOT EXISTS ix_spiritual_belief_boundary_tenant ON spiritual.belief_boundary(tenant_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_belief_boundary_user ON spiritual.belief_boundary(user_id);
CREATE INDEX IF NOT EXISTS ix_spiritual_belief_boundary_attrs ON spiritual.belief_boundary USING gin(attributes);

CREATE TABLE IF NOT EXISTS ai.ai_conversation (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE ai.ai_conversation IS 'Entidade de AI Command Center para AiConversation.';
CREATE INDEX IF NOT EXISTS ix_ai_ai_conversation_tenant ON ai.ai_conversation(tenant_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_conversation_user ON ai.ai_conversation(user_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_conversation_attrs ON ai.ai_conversation USING gin(attributes);

CREATE TABLE IF NOT EXISTS ai.ai_message (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE ai.ai_message IS 'Entidade de AI Command Center para AiMessage.';
CREATE INDEX IF NOT EXISTS ix_ai_ai_message_tenant ON ai.ai_message(tenant_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_message_user ON ai.ai_message(user_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_message_attrs ON ai.ai_message USING gin(attributes);

CREATE TABLE IF NOT EXISTS ai.ai_prompt_template (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE ai.ai_prompt_template IS 'Entidade de AI Command Center para AiPromptTemplate.';
CREATE INDEX IF NOT EXISTS ix_ai_ai_prompt_template_tenant ON ai.ai_prompt_template(tenant_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_prompt_template_user ON ai.ai_prompt_template(user_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_prompt_template_attrs ON ai.ai_prompt_template USING gin(attributes);

CREATE TABLE IF NOT EXISTS ai.ai_system_instruction (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE ai.ai_system_instruction IS 'Entidade de AI Command Center para AiSystemInstruction.';
CREATE INDEX IF NOT EXISTS ix_ai_ai_system_instruction_tenant ON ai.ai_system_instruction(tenant_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_system_instruction_user ON ai.ai_system_instruction(user_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_system_instruction_attrs ON ai.ai_system_instruction USING gin(attributes);

CREATE TABLE IF NOT EXISTS ai.ai_tool_call (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE ai.ai_tool_call IS 'Entidade de AI Command Center para AiToolCall.';
CREATE INDEX IF NOT EXISTS ix_ai_ai_tool_call_tenant ON ai.ai_tool_call(tenant_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_tool_call_user ON ai.ai_tool_call(user_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_tool_call_attrs ON ai.ai_tool_call USING gin(attributes);

CREATE TABLE IF NOT EXISTS ai.ai_tool_result (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE ai.ai_tool_result IS 'Entidade de AI Command Center para AiToolResult.';
CREATE INDEX IF NOT EXISTS ix_ai_ai_tool_result_tenant ON ai.ai_tool_result(tenant_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_tool_result_user ON ai.ai_tool_result(user_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_tool_result_attrs ON ai.ai_tool_result USING gin(attributes);

CREATE TABLE IF NOT EXISTS ai.ai_memory (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE ai.ai_memory IS 'Entidade de AI Command Center para AiMemory.';
CREATE INDEX IF NOT EXISTS ix_ai_ai_memory_tenant ON ai.ai_memory(tenant_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_memory_user ON ai.ai_memory(user_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_memory_attrs ON ai.ai_memory USING gin(attributes);

CREATE TABLE IF NOT EXISTS ai.ai_user_context (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE ai.ai_user_context IS 'Entidade de AI Command Center para AiUserContext.';
CREATE INDEX IF NOT EXISTS ix_ai_ai_user_context_tenant ON ai.ai_user_context(tenant_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_user_context_user ON ai.ai_user_context(user_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_user_context_attrs ON ai.ai_user_context USING gin(attributes);

CREATE TABLE IF NOT EXISTS ai.ai_recommendation (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE ai.ai_recommendation IS 'Entidade de AI Command Center para AiRecommendation.';
CREATE INDEX IF NOT EXISTS ix_ai_ai_recommendation_tenant ON ai.ai_recommendation(tenant_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_recommendation_user ON ai.ai_recommendation(user_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_recommendation_attrs ON ai.ai_recommendation USING gin(attributes);

CREATE TABLE IF NOT EXISTS ai.ai_recommendation_feedback (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE ai.ai_recommendation_feedback IS 'Entidade de AI Command Center para AiRecommendationFeedback.';
CREATE INDEX IF NOT EXISTS ix_ai_ai_recommendation_feedback_tenant ON ai.ai_recommendation_feedback(tenant_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_recommendation_feedback_user ON ai.ai_recommendation_feedback(user_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_recommendation_feedback_attrs ON ai.ai_recommendation_feedback USING gin(attributes);

CREATE TABLE IF NOT EXISTS ai.ai_safety_guardrail (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE ai.ai_safety_guardrail IS 'Entidade de AI Command Center para AiSafetyGuardrail.';
CREATE INDEX IF NOT EXISTS ix_ai_ai_safety_guardrail_tenant ON ai.ai_safety_guardrail(tenant_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_safety_guardrail_user ON ai.ai_safety_guardrail(user_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_safety_guardrail_attrs ON ai.ai_safety_guardrail USING gin(attributes);

CREATE TABLE IF NOT EXISTS ai.ai_risk_decision (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE ai.ai_risk_decision IS 'Entidade de AI Command Center para AiRiskDecision.';
CREATE INDEX IF NOT EXISTS ix_ai_ai_risk_decision_tenant ON ai.ai_risk_decision(tenant_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_risk_decision_user ON ai.ai_risk_decision(user_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_risk_decision_attrs ON ai.ai_risk_decision USING gin(attributes);

CREATE TABLE IF NOT EXISTS ai.ai_model_provider (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE ai.ai_model_provider IS 'Entidade de AI Command Center para AiModelProvider.';
CREATE INDEX IF NOT EXISTS ix_ai_ai_model_provider_tenant ON ai.ai_model_provider(tenant_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_model_provider_user ON ai.ai_model_provider(user_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_model_provider_attrs ON ai.ai_model_provider USING gin(attributes);

CREATE TABLE IF NOT EXISTS ai.ai_model_version (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE ai.ai_model_version IS 'Entidade de AI Command Center para AiModelVersion.';
CREATE INDEX IF NOT EXISTS ix_ai_ai_model_version_tenant ON ai.ai_model_version(tenant_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_model_version_user ON ai.ai_model_version(user_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_model_version_attrs ON ai.ai_model_version USING gin(attributes);

CREATE TABLE IF NOT EXISTS ai.ai_embedding (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE ai.ai_embedding IS 'Entidade de AI Command Center para AiEmbedding.';
CREATE INDEX IF NOT EXISTS ix_ai_ai_embedding_tenant ON ai.ai_embedding(tenant_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_embedding_user ON ai.ai_embedding(user_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_embedding_attrs ON ai.ai_embedding USING gin(attributes);

CREATE TABLE IF NOT EXISTS ai.ai_vector_document (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE ai.ai_vector_document IS 'Entidade de AI Command Center para AiVectorDocument.';
CREATE INDEX IF NOT EXISTS ix_ai_ai_vector_document_tenant ON ai.ai_vector_document(tenant_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_vector_document_user ON ai.ai_vector_document(user_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_vector_document_attrs ON ai.ai_vector_document USING gin(attributes);

CREATE TABLE IF NOT EXISTS ai.ai_retrieval_chunk (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE ai.ai_retrieval_chunk IS 'Entidade de AI Command Center para AiRetrievalChunk.';
CREATE INDEX IF NOT EXISTS ix_ai_ai_retrieval_chunk_tenant ON ai.ai_retrieval_chunk(tenant_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_retrieval_chunk_user ON ai.ai_retrieval_chunk(user_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_retrieval_chunk_attrs ON ai.ai_retrieval_chunk USING gin(attributes);

CREATE TABLE IF NOT EXISTS ai.ai_evaluation_case (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE ai.ai_evaluation_case IS 'Entidade de AI Command Center para AiEvaluationCase.';
CREATE INDEX IF NOT EXISTS ix_ai_ai_evaluation_case_tenant ON ai.ai_evaluation_case(tenant_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_evaluation_case_user ON ai.ai_evaluation_case(user_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_evaluation_case_attrs ON ai.ai_evaluation_case USING gin(attributes);

CREATE TABLE IF NOT EXISTS ai.ai_evaluation_run (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE ai.ai_evaluation_run IS 'Entidade de AI Command Center para AiEvaluationRun.';
CREATE INDEX IF NOT EXISTS ix_ai_ai_evaluation_run_tenant ON ai.ai_evaluation_run(tenant_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_evaluation_run_user ON ai.ai_evaluation_run(user_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_evaluation_run_attrs ON ai.ai_evaluation_run USING gin(attributes);

CREATE TABLE IF NOT EXISTS ai.ai_hallucination_report (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE ai.ai_hallucination_report IS 'Entidade de AI Command Center para AiHallucinationReport.';
CREATE INDEX IF NOT EXISTS ix_ai_ai_hallucination_report_tenant ON ai.ai_hallucination_report(tenant_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_hallucination_report_user ON ai.ai_hallucination_report(user_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_hallucination_report_attrs ON ai.ai_hallucination_report USING gin(attributes);

CREATE TABLE IF NOT EXISTS ai.ai_escalation_event (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE ai.ai_escalation_event IS 'Entidade de AI Command Center para AiEscalationEvent.';
CREATE INDEX IF NOT EXISTS ix_ai_ai_escalation_event_tenant ON ai.ai_escalation_event(tenant_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_escalation_event_user ON ai.ai_escalation_event(user_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_escalation_event_attrs ON ai.ai_escalation_event USING gin(attributes);

CREATE TABLE IF NOT EXISTS ai.ai_coach_persona (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE ai.ai_coach_persona IS 'Entidade de AI Command Center para AiCoachPersona.';
CREATE INDEX IF NOT EXISTS ix_ai_ai_coach_persona_tenant ON ai.ai_coach_persona(tenant_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_coach_persona_user ON ai.ai_coach_persona(user_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_coach_persona_attrs ON ai.ai_coach_persona USING gin(attributes);

CREATE TABLE IF NOT EXISTS ai.ai_tone_profile (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE ai.ai_tone_profile IS 'Entidade de AI Command Center para AiToneProfile.';
CREATE INDEX IF NOT EXISTS ix_ai_ai_tone_profile_tenant ON ai.ai_tone_profile(tenant_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_tone_profile_user ON ai.ai_tone_profile(user_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_tone_profile_attrs ON ai.ai_tone_profile USING gin(attributes);

CREATE TABLE IF NOT EXISTS ai.ai_content_policy (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE ai.ai_content_policy IS 'Entidade de AI Command Center para AiContentPolicy.';
CREATE INDEX IF NOT EXISTS ix_ai_ai_content_policy_tenant ON ai.ai_content_policy(tenant_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_content_policy_user ON ai.ai_content_policy(user_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_content_policy_attrs ON ai.ai_content_policy USING gin(attributes);

CREATE TABLE IF NOT EXISTS ai.ai_usage_quota (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE ai.ai_usage_quota IS 'Entidade de AI Command Center para AiUsageQuota.';
CREATE INDEX IF NOT EXISTS ix_ai_ai_usage_quota_tenant ON ai.ai_usage_quota(tenant_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_usage_quota_user ON ai.ai_usage_quota(user_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_usage_quota_attrs ON ai.ai_usage_quota USING gin(attributes);

CREATE TABLE IF NOT EXISTS ai.ai_cost_ledger (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE ai.ai_cost_ledger IS 'Entidade de AI Command Center para AiCostLedger.';
CREATE INDEX IF NOT EXISTS ix_ai_ai_cost_ledger_tenant ON ai.ai_cost_ledger(tenant_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_cost_ledger_user ON ai.ai_cost_ledger(user_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_cost_ledger_attrs ON ai.ai_cost_ledger USING gin(attributes);

CREATE TABLE IF NOT EXISTS ai.ai_latency_metric (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE ai.ai_latency_metric IS 'Entidade de AI Command Center para AiLatencyMetric.';
CREATE INDEX IF NOT EXISTS ix_ai_ai_latency_metric_tenant ON ai.ai_latency_metric(tenant_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_latency_metric_user ON ai.ai_latency_metric(user_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_latency_metric_attrs ON ai.ai_latency_metric USING gin(attributes);

CREATE TABLE IF NOT EXISTS ai.ai_privacy_filter (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE ai.ai_privacy_filter IS 'Entidade de AI Command Center para AiPrivacyFilter.';
CREATE INDEX IF NOT EXISTS ix_ai_ai_privacy_filter_tenant ON ai.ai_privacy_filter(tenant_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_privacy_filter_user ON ai.ai_privacy_filter(user_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_privacy_filter_attrs ON ai.ai_privacy_filter USING gin(attributes);

CREATE TABLE IF NOT EXISTS ai.ai_medical_boundary (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE ai.ai_medical_boundary IS 'Entidade de AI Command Center para AiMedicalBoundary.';
CREATE INDEX IF NOT EXISTS ix_ai_ai_medical_boundary_tenant ON ai.ai_medical_boundary(tenant_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_medical_boundary_user ON ai.ai_medical_boundary(user_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_medical_boundary_attrs ON ai.ai_medical_boundary USING gin(attributes);

CREATE TABLE IF NOT EXISTS ai.ai_audit_trail (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE ai.ai_audit_trail IS 'Entidade de AI Command Center para AiAuditTrail.';
CREATE INDEX IF NOT EXISTS ix_ai_ai_audit_trail_tenant ON ai.ai_audit_trail(tenant_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_audit_trail_user ON ai.ai_audit_trail(user_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_audit_trail_attrs ON ai.ai_audit_trail USING gin(attributes);

CREATE TABLE IF NOT EXISTS ai.ai_experiment (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE ai.ai_experiment IS 'Entidade de AI Command Center para AiExperiment.';
CREATE INDEX IF NOT EXISTS ix_ai_ai_experiment_tenant ON ai.ai_experiment(tenant_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_experiment_user ON ai.ai_experiment(user_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_experiment_attrs ON ai.ai_experiment USING gin(attributes);

CREATE TABLE IF NOT EXISTS ai.ai_release_note (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE ai.ai_release_note IS 'Entidade de AI Command Center para AiReleaseNote.';
CREATE INDEX IF NOT EXISTS ix_ai_ai_release_note_tenant ON ai.ai_release_note(tenant_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_release_note_user ON ai.ai_release_note(user_id);
CREATE INDEX IF NOT EXISTS ix_ai_ai_release_note_attrs ON ai.ai_release_note USING gin(attributes);

CREATE TABLE IF NOT EXISTS war_room.dashboard (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE war_room.dashboard IS 'Entidade de War Room Dashboard para Dashboard.';
CREATE INDEX IF NOT EXISTS ix_war_room_dashboard_tenant ON war_room.dashboard(tenant_id);
CREATE INDEX IF NOT EXISTS ix_war_room_dashboard_user ON war_room.dashboard(user_id);
CREATE INDEX IF NOT EXISTS ix_war_room_dashboard_attrs ON war_room.dashboard USING gin(attributes);

CREATE TABLE IF NOT EXISTS war_room.dashboard_widget (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE war_room.dashboard_widget IS 'Entidade de War Room Dashboard para DashboardWidget.';
CREATE INDEX IF NOT EXISTS ix_war_room_dashboard_widget_tenant ON war_room.dashboard_widget(tenant_id);
CREATE INDEX IF NOT EXISTS ix_war_room_dashboard_widget_user ON war_room.dashboard_widget(user_id);
CREATE INDEX IF NOT EXISTS ix_war_room_dashboard_widget_attrs ON war_room.dashboard_widget USING gin(attributes);

CREATE TABLE IF NOT EXISTS war_room.metric_definition (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE war_room.metric_definition IS 'Entidade de War Room Dashboard para MetricDefinition.';
CREATE INDEX IF NOT EXISTS ix_war_room_metric_definition_tenant ON war_room.metric_definition(tenant_id);
CREATE INDEX IF NOT EXISTS ix_war_room_metric_definition_user ON war_room.metric_definition(user_id);
CREATE INDEX IF NOT EXISTS ix_war_room_metric_definition_attrs ON war_room.metric_definition USING gin(attributes);

CREATE TABLE IF NOT EXISTS war_room.metric_snapshot (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE war_room.metric_snapshot IS 'Entidade de War Room Dashboard para MetricSnapshot.';
CREATE INDEX IF NOT EXISTS ix_war_room_metric_snapshot_tenant ON war_room.metric_snapshot(tenant_id);
CREATE INDEX IF NOT EXISTS ix_war_room_metric_snapshot_user ON war_room.metric_snapshot(user_id);
CREATE INDEX IF NOT EXISTS ix_war_room_metric_snapshot_attrs ON war_room.metric_snapshot USING gin(attributes);

CREATE TABLE IF NOT EXISTS war_room.metric_trend (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE war_room.metric_trend IS 'Entidade de War Room Dashboard para MetricTrend.';
CREATE INDEX IF NOT EXISTS ix_war_room_metric_trend_tenant ON war_room.metric_trend(tenant_id);
CREATE INDEX IF NOT EXISTS ix_war_room_metric_trend_user ON war_room.metric_trend(user_id);
CREATE INDEX IF NOT EXISTS ix_war_room_metric_trend_attrs ON war_room.metric_trend USING gin(attributes);

CREATE TABLE IF NOT EXISTS war_room.indicator_card (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE war_room.indicator_card IS 'Entidade de War Room Dashboard para IndicatorCard.';
CREATE INDEX IF NOT EXISTS ix_war_room_indicator_card_tenant ON war_room.indicator_card(tenant_id);
CREATE INDEX IF NOT EXISTS ix_war_room_indicator_card_user ON war_room.indicator_card(user_id);
CREATE INDEX IF NOT EXISTS ix_war_room_indicator_card_attrs ON war_room.indicator_card USING gin(attributes);

CREATE TABLE IF NOT EXISTS war_room.goal_progress_view (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE war_room.goal_progress_view IS 'Entidade de War Room Dashboard para GoalProgressView.';
CREATE INDEX IF NOT EXISTS ix_war_room_goal_progress_view_tenant ON war_room.goal_progress_view(tenant_id);
CREATE INDEX IF NOT EXISTS ix_war_room_goal_progress_view_user ON war_room.goal_progress_view(user_id);
CREATE INDEX IF NOT EXISTS ix_war_room_goal_progress_view_attrs ON war_room.goal_progress_view USING gin(attributes);

CREATE TABLE IF NOT EXISTS war_room.training_calendar_view (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE war_room.training_calendar_view IS 'Entidade de War Room Dashboard para TrainingCalendarView.';
CREATE INDEX IF NOT EXISTS ix_war_room_training_calendar_view_tenant ON war_room.training_calendar_view(tenant_id);
CREATE INDEX IF NOT EXISTS ix_war_room_training_calendar_view_user ON war_room.training_calendar_view(user_id);
CREATE INDEX IF NOT EXISTS ix_war_room_training_calendar_view_attrs ON war_room.training_calendar_view USING gin(attributes);

CREATE TABLE IF NOT EXISTS war_room.phase_progress_view (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE war_room.phase_progress_view IS 'Entidade de War Room Dashboard para PhaseProgressView.';
CREATE INDEX IF NOT EXISTS ix_war_room_phase_progress_view_tenant ON war_room.phase_progress_view(tenant_id);
CREATE INDEX IF NOT EXISTS ix_war_room_phase_progress_view_user ON war_room.phase_progress_view(user_id);
CREATE INDEX IF NOT EXISTS ix_war_room_phase_progress_view_attrs ON war_room.phase_progress_view USING gin(attributes);

CREATE TABLE IF NOT EXISTS war_room.risk_panel (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE war_room.risk_panel IS 'Entidade de War Room Dashboard para RiskPanel.';
CREATE INDEX IF NOT EXISTS ix_war_room_risk_panel_tenant ON war_room.risk_panel(tenant_id);
CREATE INDEX IF NOT EXISTS ix_war_room_risk_panel_user ON war_room.risk_panel(user_id);
CREATE INDEX IF NOT EXISTS ix_war_room_risk_panel_attrs ON war_room.risk_panel USING gin(attributes);

CREATE TABLE IF NOT EXISTS war_room.adherence_panel (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE war_room.adherence_panel IS 'Entidade de War Room Dashboard para AdherencePanel.';
CREATE INDEX IF NOT EXISTS ix_war_room_adherence_panel_tenant ON war_room.adherence_panel(tenant_id);
CREATE INDEX IF NOT EXISTS ix_war_room_adherence_panel_user ON war_room.adherence_panel(user_id);
CREATE INDEX IF NOT EXISTS ix_war_room_adherence_panel_attrs ON war_room.adherence_panel USING gin(attributes);

CREATE TABLE IF NOT EXISTS war_room.recovery_panel (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE war_room.recovery_panel IS 'Entidade de War Room Dashboard para RecoveryPanel.';
CREATE INDEX IF NOT EXISTS ix_war_room_recovery_panel_tenant ON war_room.recovery_panel(tenant_id);
CREATE INDEX IF NOT EXISTS ix_war_room_recovery_panel_user ON war_room.recovery_panel(user_id);
CREATE INDEX IF NOT EXISTS ix_war_room_recovery_panel_attrs ON war_room.recovery_panel USING gin(attributes);

CREATE TABLE IF NOT EXISTS war_room.nutrition_panel (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE war_room.nutrition_panel IS 'Entidade de War Room Dashboard para NutritionPanel.';
CREATE INDEX IF NOT EXISTS ix_war_room_nutrition_panel_tenant ON war_room.nutrition_panel(tenant_id);
CREATE INDEX IF NOT EXISTS ix_war_room_nutrition_panel_user ON war_room.nutrition_panel(user_id);
CREATE INDEX IF NOT EXISTS ix_war_room_nutrition_panel_attrs ON war_room.nutrition_panel USING gin(attributes);

CREATE TABLE IF NOT EXISTS war_room.medical_panel (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE war_room.medical_panel IS 'Entidade de War Room Dashboard para MedicalPanel.';
CREATE INDEX IF NOT EXISTS ix_war_room_medical_panel_tenant ON war_room.medical_panel(tenant_id);
CREATE INDEX IF NOT EXISTS ix_war_room_medical_panel_user ON war_room.medical_panel(user_id);
CREATE INDEX IF NOT EXISTS ix_war_room_medical_panel_attrs ON war_room.medical_panel USING gin(attributes);

CREATE TABLE IF NOT EXISTS war_room.ai_insight_panel (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE war_room.ai_insight_panel IS 'Entidade de War Room Dashboard para AiInsightPanel.';
CREATE INDEX IF NOT EXISTS ix_war_room_ai_insight_panel_tenant ON war_room.ai_insight_panel(tenant_id);
CREATE INDEX IF NOT EXISTS ix_war_room_ai_insight_panel_user ON war_room.ai_insight_panel(user_id);
CREATE INDEX IF NOT EXISTS ix_war_room_ai_insight_panel_attrs ON war_room.ai_insight_panel USING gin(attributes);

CREATE TABLE IF NOT EXISTS war_room.alert (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE war_room.alert IS 'Entidade de War Room Dashboard para Alert.';
CREATE INDEX IF NOT EXISTS ix_war_room_alert_tenant ON war_room.alert(tenant_id);
CREATE INDEX IF NOT EXISTS ix_war_room_alert_user ON war_room.alert(user_id);
CREATE INDEX IF NOT EXISTS ix_war_room_alert_attrs ON war_room.alert USING gin(attributes);

CREATE TABLE IF NOT EXISTS war_room.alert_rule (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE war_room.alert_rule IS 'Entidade de War Room Dashboard para AlertRule.';
CREATE INDEX IF NOT EXISTS ix_war_room_alert_rule_tenant ON war_room.alert_rule(tenant_id);
CREATE INDEX IF NOT EXISTS ix_war_room_alert_rule_user ON war_room.alert_rule(user_id);
CREATE INDEX IF NOT EXISTS ix_war_room_alert_rule_attrs ON war_room.alert_rule USING gin(attributes);

CREATE TABLE IF NOT EXISTS war_room.notification (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE war_room.notification IS 'Entidade de War Room Dashboard para Notification.';
CREATE INDEX IF NOT EXISTS ix_war_room_notification_tenant ON war_room.notification(tenant_id);
CREATE INDEX IF NOT EXISTS ix_war_room_notification_user ON war_room.notification(user_id);
CREATE INDEX IF NOT EXISTS ix_war_room_notification_attrs ON war_room.notification USING gin(attributes);

CREATE TABLE IF NOT EXISTS war_room.notification_preference (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE war_room.notification_preference IS 'Entidade de War Room Dashboard para NotificationPreference.';
CREATE INDEX IF NOT EXISTS ix_war_room_notification_preference_tenant ON war_room.notification_preference(tenant_id);
CREATE INDEX IF NOT EXISTS ix_war_room_notification_preference_user ON war_room.notification_preference(user_id);
CREATE INDEX IF NOT EXISTS ix_war_room_notification_preference_attrs ON war_room.notification_preference USING gin(attributes);

CREATE TABLE IF NOT EXISTS war_room.report (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE war_room.report IS 'Entidade de War Room Dashboard para Report.';
CREATE INDEX IF NOT EXISTS ix_war_room_report_tenant ON war_room.report(tenant_id);
CREATE INDEX IF NOT EXISTS ix_war_room_report_user ON war_room.report(user_id);
CREATE INDEX IF NOT EXISTS ix_war_room_report_attrs ON war_room.report USING gin(attributes);

CREATE TABLE IF NOT EXISTS war_room.report_export (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE war_room.report_export IS 'Entidade de War Room Dashboard para ReportExport.';
CREATE INDEX IF NOT EXISTS ix_war_room_report_export_tenant ON war_room.report_export(tenant_id);
CREATE INDEX IF NOT EXISTS ix_war_room_report_export_user ON war_room.report_export(user_id);
CREATE INDEX IF NOT EXISTS ix_war_room_report_export_attrs ON war_room.report_export USING gin(attributes);

CREATE TABLE IF NOT EXISTS war_room.executive_summary (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE war_room.executive_summary IS 'Entidade de War Room Dashboard para ExecutiveSummary.';
CREATE INDEX IF NOT EXISTS ix_war_room_executive_summary_tenant ON war_room.executive_summary(tenant_id);
CREATE INDEX IF NOT EXISTS ix_war_room_executive_summary_user ON war_room.executive_summary(user_id);
CREATE INDEX IF NOT EXISTS ix_war_room_executive_summary_attrs ON war_room.executive_summary USING gin(attributes);

CREATE TABLE IF NOT EXISTS legacy.achievement (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE legacy.achievement IS 'Entidade de Phoenix Legacy para Achievement.';
CREATE INDEX IF NOT EXISTS ix_legacy_achievement_tenant ON legacy.achievement(tenant_id);
CREATE INDEX IF NOT EXISTS ix_legacy_achievement_user ON legacy.achievement(user_id);
CREATE INDEX IF NOT EXISTS ix_legacy_achievement_attrs ON legacy.achievement USING gin(attributes);

CREATE TABLE IF NOT EXISTS legacy.achievement_unlock (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE legacy.achievement_unlock IS 'Entidade de Phoenix Legacy para AchievementUnlock.';
CREATE INDEX IF NOT EXISTS ix_legacy_achievement_unlock_tenant ON legacy.achievement_unlock(tenant_id);
CREATE INDEX IF NOT EXISTS ix_legacy_achievement_unlock_user ON legacy.achievement_unlock(user_id);
CREATE INDEX IF NOT EXISTS ix_legacy_achievement_unlock_attrs ON legacy.achievement_unlock USING gin(attributes);

CREATE TABLE IF NOT EXISTS legacy.badge (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE legacy.badge IS 'Entidade de Phoenix Legacy para Badge.';
CREATE INDEX IF NOT EXISTS ix_legacy_badge_tenant ON legacy.badge(tenant_id);
CREATE INDEX IF NOT EXISTS ix_legacy_badge_user ON legacy.badge(user_id);
CREATE INDEX IF NOT EXISTS ix_legacy_badge_attrs ON legacy.badge USING gin(attributes);

CREATE TABLE IF NOT EXISTS legacy.certificate (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE legacy.certificate IS 'Entidade de Phoenix Legacy para Certificate.';
CREATE INDEX IF NOT EXISTS ix_legacy_certificate_tenant ON legacy.certificate(tenant_id);
CREATE INDEX IF NOT EXISTS ix_legacy_certificate_user ON legacy.certificate(user_id);
CREATE INDEX IF NOT EXISTS ix_legacy_certificate_attrs ON legacy.certificate USING gin(attributes);

CREATE TABLE IF NOT EXISTS legacy.graduation_record (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE legacy.graduation_record IS 'Entidade de Phoenix Legacy para GraduationRecord.';
CREATE INDEX IF NOT EXISTS ix_legacy_graduation_record_tenant ON legacy.graduation_record(tenant_id);
CREATE INDEX IF NOT EXISTS ix_legacy_graduation_record_user ON legacy.graduation_record(user_id);
CREATE INDEX IF NOT EXISTS ix_legacy_graduation_record_attrs ON legacy.graduation_record USING gin(attributes);

CREATE TABLE IF NOT EXISTS legacy.before_after_story (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE legacy.before_after_story IS 'Entidade de Phoenix Legacy para BeforeAfterStory.';
CREATE INDEX IF NOT EXISTS ix_legacy_before_after_story_tenant ON legacy.before_after_story(tenant_id);
CREATE INDEX IF NOT EXISTS ix_legacy_before_after_story_user ON legacy.before_after_story(user_id);
CREATE INDEX IF NOT EXISTS ix_legacy_before_after_story_attrs ON legacy.before_after_story USING gin(attributes);

CREATE TABLE IF NOT EXISTS legacy.legacy_timeline (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE legacy.legacy_timeline IS 'Entidade de Phoenix Legacy para LegacyTimeline.';
CREATE INDEX IF NOT EXISTS ix_legacy_legacy_timeline_tenant ON legacy.legacy_timeline(tenant_id);
CREATE INDEX IF NOT EXISTS ix_legacy_legacy_timeline_user ON legacy.legacy_timeline(user_id);
CREATE INDEX IF NOT EXISTS ix_legacy_legacy_timeline_attrs ON legacy.legacy_timeline USING gin(attributes);

CREATE TABLE IF NOT EXISTS legacy.milestone_story (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE legacy.milestone_story IS 'Entidade de Phoenix Legacy para MilestoneStory.';
CREATE INDEX IF NOT EXISTS ix_legacy_milestone_story_tenant ON legacy.milestone_story(tenant_id);
CREATE INDEX IF NOT EXISTS ix_legacy_milestone_story_user ON legacy.milestone_story(user_id);
CREATE INDEX IF NOT EXISTS ix_legacy_milestone_story_attrs ON legacy.milestone_story USING gin(attributes);

CREATE TABLE IF NOT EXISTS legacy.social_share (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE legacy.social_share IS 'Entidade de Phoenix Legacy para SocialShare.';
CREATE INDEX IF NOT EXISTS ix_legacy_social_share_tenant ON legacy.social_share(tenant_id);
CREATE INDEX IF NOT EXISTS ix_legacy_social_share_user ON legacy.social_share(user_id);
CREATE INDEX IF NOT EXISTS ix_legacy_social_share_attrs ON legacy.social_share USING gin(attributes);

CREATE TABLE IF NOT EXISTS legacy.testimonial (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE legacy.testimonial IS 'Entidade de Phoenix Legacy para Testimonial.';
CREATE INDEX IF NOT EXISTS ix_legacy_testimonial_tenant ON legacy.testimonial(tenant_id);
CREATE INDEX IF NOT EXISTS ix_legacy_testimonial_user ON legacy.testimonial(user_id);
CREATE INDEX IF NOT EXISTS ix_legacy_testimonial_attrs ON legacy.testimonial USING gin(attributes);

CREATE TABLE IF NOT EXISTS legacy.transformation_narrative (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE legacy.transformation_narrative IS 'Entidade de Phoenix Legacy para TransformationNarrative.';
CREATE INDEX IF NOT EXISTS ix_legacy_transformation_narrative_tenant ON legacy.transformation_narrative(tenant_id);
CREATE INDEX IF NOT EXISTS ix_legacy_transformation_narrative_user ON legacy.transformation_narrative(user_id);
CREATE INDEX IF NOT EXISTS ix_legacy_transformation_narrative_attrs ON legacy.transformation_narrative USING gin(attributes);

CREATE TABLE IF NOT EXISTS legacy.personal_manifesto (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE legacy.personal_manifesto IS 'Entidade de Phoenix Legacy para PersonalManifesto.';
CREATE INDEX IF NOT EXISTS ix_legacy_personal_manifesto_tenant ON legacy.personal_manifesto(tenant_id);
CREATE INDEX IF NOT EXISTS ix_legacy_personal_manifesto_user ON legacy.personal_manifesto(user_id);
CREATE INDEX IF NOT EXISTS ix_legacy_personal_manifesto_attrs ON legacy.personal_manifesto USING gin(attributes);

CREATE TABLE IF NOT EXISTS legacy.legacy_vault_item (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE legacy.legacy_vault_item IS 'Entidade de Phoenix Legacy para LegacyVaultItem.';
CREATE INDEX IF NOT EXISTS ix_legacy_legacy_vault_item_tenant ON legacy.legacy_vault_item(tenant_id);
CREATE INDEX IF NOT EXISTS ix_legacy_legacy_vault_item_user ON legacy.legacy_vault_item(user_id);
CREATE INDEX IF NOT EXISTS ix_legacy_legacy_vault_item_attrs ON legacy.legacy_vault_item USING gin(attributes);

CREATE TABLE IF NOT EXISTS legacy.family_invite (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE legacy.family_invite IS 'Entidade de Phoenix Legacy para FamilyInvite.';
CREATE INDEX IF NOT EXISTS ix_legacy_family_invite_tenant ON legacy.family_invite(tenant_id);
CREATE INDEX IF NOT EXISTS ix_legacy_family_invite_user ON legacy.family_invite(user_id);
CREATE INDEX IF NOT EXISTS ix_legacy_family_invite_attrs ON legacy.family_invite USING gin(attributes);

CREATE TABLE IF NOT EXISTS legacy.mentor_note (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE legacy.mentor_note IS 'Entidade de Phoenix Legacy para MentorNote.';
CREATE INDEX IF NOT EXISTS ix_legacy_mentor_note_tenant ON legacy.mentor_note(tenant_id);
CREATE INDEX IF NOT EXISTS ix_legacy_mentor_note_user ON legacy.mentor_note(user_id);
CREATE INDEX IF NOT EXISTS ix_legacy_mentor_note_attrs ON legacy.mentor_note USING gin(attributes);

CREATE TABLE IF NOT EXISTS legacy.community_post (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE legacy.community_post IS 'Entidade de Phoenix Legacy para CommunityPost.';
CREATE INDEX IF NOT EXISTS ix_legacy_community_post_tenant ON legacy.community_post(tenant_id);
CREATE INDEX IF NOT EXISTS ix_legacy_community_post_user ON legacy.community_post(user_id);
CREATE INDEX IF NOT EXISTS ix_legacy_community_post_attrs ON legacy.community_post USING gin(attributes);

CREATE TABLE IF NOT EXISTS legacy.community_reaction (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE legacy.community_reaction IS 'Entidade de Phoenix Legacy para CommunityReaction.';
CREATE INDEX IF NOT EXISTS ix_legacy_community_reaction_tenant ON legacy.community_reaction(tenant_id);
CREATE INDEX IF NOT EXISTS ix_legacy_community_reaction_user ON legacy.community_reaction(user_id);
CREATE INDEX IF NOT EXISTS ix_legacy_community_reaction_attrs ON legacy.community_reaction USING gin(attributes);

CREATE TABLE IF NOT EXISTS legacy.community_moderation_case (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE legacy.community_moderation_case IS 'Entidade de Phoenix Legacy para CommunityModerationCase.';
CREATE INDEX IF NOT EXISTS ix_legacy_community_moderation_case_tenant ON legacy.community_moderation_case(tenant_id);
CREATE INDEX IF NOT EXISTS ix_legacy_community_moderation_case_user ON legacy.community_moderation_case(user_id);
CREATE INDEX IF NOT EXISTS ix_legacy_community_moderation_case_attrs ON legacy.community_moderation_case USING gin(attributes);

CREATE TABLE IF NOT EXISTS legacy.challenge_leaderboard_entry (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE legacy.challenge_leaderboard_entry IS 'Entidade de Phoenix Legacy para ChallengeLeaderboardEntry.';
CREATE INDEX IF NOT EXISTS ix_legacy_challenge_leaderboard_entry_tenant ON legacy.challenge_leaderboard_entry(tenant_id);
CREATE INDEX IF NOT EXISTS ix_legacy_challenge_leaderboard_entry_user ON legacy.challenge_leaderboard_entry(user_id);
CREATE INDEX IF NOT EXISTS ix_legacy_challenge_leaderboard_entry_attrs ON legacy.challenge_leaderboard_entry USING gin(attributes);

CREATE TABLE IF NOT EXISTS legacy.alumni_status (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE legacy.alumni_status IS 'Entidade de Phoenix Legacy para AlumniStatus.';
CREATE INDEX IF NOT EXISTS ix_legacy_alumni_status_tenant ON legacy.alumni_status(tenant_id);
CREATE INDEX IF NOT EXISTS ix_legacy_alumni_status_user ON legacy.alumni_status(user_id);
CREATE INDEX IF NOT EXISTS ix_legacy_alumni_status_attrs ON legacy.alumni_status USING gin(attributes);

CREATE TABLE IF NOT EXISTS legacy.continuation_plan (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE legacy.continuation_plan IS 'Entidade de Phoenix Legacy para ContinuationPlan.';
CREATE INDEX IF NOT EXISTS ix_legacy_continuation_plan_tenant ON legacy.continuation_plan(tenant_id);
CREATE INDEX IF NOT EXISTS ix_legacy_continuation_plan_user ON legacy.continuation_plan(user_id);
CREATE INDEX IF NOT EXISTS ix_legacy_continuation_plan_attrs ON legacy.continuation_plan USING gin(attributes);

CREATE TABLE IF NOT EXISTS legacy.next_mission (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE legacy.next_mission IS 'Entidade de Phoenix Legacy para NextMission.';
CREATE INDEX IF NOT EXISTS ix_legacy_next_mission_tenant ON legacy.next_mission(tenant_id);
CREATE INDEX IF NOT EXISTS ix_legacy_next_mission_user ON legacy.next_mission(user_id);
CREATE INDEX IF NOT EXISTS ix_legacy_next_mission_attrs ON legacy.next_mission USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.medical_profile (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.medical_profile IS 'Entidade de Phoenix Medical Intelligence para MedicalProfile.';
CREATE INDEX IF NOT EXISTS ix_medical_medical_profile_tenant ON medical.medical_profile(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_medical_profile_user ON medical.medical_profile(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_medical_profile_attrs ON medical.medical_profile USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.medical_consent (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.medical_consent IS 'Entidade de Phoenix Medical Intelligence para MedicalConsent.';
CREATE INDEX IF NOT EXISTS ix_medical_medical_consent_tenant ON medical.medical_consent(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_medical_consent_user ON medical.medical_consent(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_medical_consent_attrs ON medical.medical_consent USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.medical_disclaimer_acceptance (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.medical_disclaimer_acceptance IS 'Entidade de Phoenix Medical Intelligence para MedicalDisclaimerAcceptance.';
CREATE INDEX IF NOT EXISTS ix_medical_medical_disclaimer_acceptance_tenant ON medical.medical_disclaimer_acceptance(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_medical_disclaimer_acceptance_user ON medical.medical_disclaimer_acceptance(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_medical_disclaimer_acceptance_attrs ON medical.medical_disclaimer_acceptance USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.clinician_contact (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.clinician_contact IS 'Entidade de Phoenix Medical Intelligence para ClinicianContact.';
CREATE INDEX IF NOT EXISTS ix_medical_clinician_contact_tenant ON medical.clinician_contact(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_clinician_contact_user ON medical.clinician_contact(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_clinician_contact_attrs ON medical.clinician_contact USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.emergency_contact (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.emergency_contact IS 'Entidade de Phoenix Medical Intelligence para EmergencyContact.';
CREATE INDEX IF NOT EXISTS ix_medical_emergency_contact_tenant ON medical.emergency_contact(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_emergency_contact_user ON medical.emergency_contact(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_emergency_contact_attrs ON medical.emergency_contact USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.health_condition (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.health_condition IS 'Entidade de Phoenix Medical Intelligence para HealthCondition.';
CREATE INDEX IF NOT EXISTS ix_medical_health_condition_tenant ON medical.health_condition(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_health_condition_user ON medical.health_condition(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_health_condition_attrs ON medical.health_condition USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.medication (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.medication IS 'Entidade de Phoenix Medical Intelligence para Medication.';
CREATE INDEX IF NOT EXISTS ix_medical_medication_tenant ON medical.medication(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_medication_user ON medical.medication(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_medication_attrs ON medical.medication USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.medication_schedule (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.medication_schedule IS 'Entidade de Phoenix Medical Intelligence para MedicationSchedule.';
CREATE INDEX IF NOT EXISTS ix_medical_medication_schedule_tenant ON medical.medication_schedule(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_medication_schedule_user ON medical.medication_schedule(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_medication_schedule_attrs ON medical.medication_schedule USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.allergy_medical (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.allergy_medical IS 'Entidade de Phoenix Medical Intelligence para AllergyMedical.';
CREATE INDEX IF NOT EXISTS ix_medical_allergy_medical_tenant ON medical.allergy_medical(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_allergy_medical_user ON medical.allergy_medical(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_allergy_medical_attrs ON medical.allergy_medical USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.lab_order (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.lab_order IS 'Entidade de Phoenix Medical Intelligence para LabOrder.';
CREATE INDEX IF NOT EXISTS ix_medical_lab_order_tenant ON medical.lab_order(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_lab_order_user ON medical.lab_order(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_lab_order_attrs ON medical.lab_order USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.lab_result_document (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.lab_result_document IS 'Entidade de Phoenix Medical Intelligence para LabResultDocument.';
CREATE INDEX IF NOT EXISTS ix_medical_lab_result_document_tenant ON medical.lab_result_document(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_lab_result_document_user ON medical.lab_result_document(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_lab_result_document_attrs ON medical.lab_result_document USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.lab_panel (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.lab_panel IS 'Entidade de Phoenix Medical Intelligence para LabPanel.';
CREATE INDEX IF NOT EXISTS ix_medical_lab_panel_tenant ON medical.lab_panel(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_lab_panel_user ON medical.lab_panel(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_lab_panel_attrs ON medical.lab_panel USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.lab_biomarker (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.lab_biomarker IS 'Entidade de Phoenix Medical Intelligence para LabBiomarker.';
CREATE INDEX IF NOT EXISTS ix_medical_lab_biomarker_tenant ON medical.lab_biomarker(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_lab_biomarker_user ON medical.lab_biomarker(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_lab_biomarker_attrs ON medical.lab_biomarker USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.biomarker_result (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.biomarker_result IS 'Entidade de Phoenix Medical Intelligence para BiomarkerResult.';
CREATE INDEX IF NOT EXISTS ix_medical_biomarker_result_tenant ON medical.biomarker_result(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_biomarker_result_user ON medical.biomarker_result(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_biomarker_result_attrs ON medical.biomarker_result USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.biomarker_reference_range (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.biomarker_reference_range IS 'Entidade de Phoenix Medical Intelligence para BiomarkerReferenceRange.';
CREATE INDEX IF NOT EXISTS ix_medical_biomarker_reference_range_tenant ON medical.biomarker_reference_range(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_biomarker_reference_range_user ON medical.biomarker_reference_range(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_biomarker_reference_range_attrs ON medical.biomarker_reference_range USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.vital_sign_record (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.vital_sign_record IS 'Entidade de Phoenix Medical Intelligence para VitalSignRecord.';
CREATE INDEX IF NOT EXISTS ix_medical_vital_sign_record_tenant ON medical.vital_sign_record(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_vital_sign_record_user ON medical.vital_sign_record(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_vital_sign_record_attrs ON medical.vital_sign_record USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.blood_pressure_record (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.blood_pressure_record IS 'Entidade de Phoenix Medical Intelligence para BloodPressureRecord.';
CREATE INDEX IF NOT EXISTS ix_medical_blood_pressure_record_tenant ON medical.blood_pressure_record(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_blood_pressure_record_user ON medical.blood_pressure_record(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_blood_pressure_record_attrs ON medical.blood_pressure_record USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.glucose_record (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.glucose_record IS 'Entidade de Phoenix Medical Intelligence para GlucoseRecord.';
CREATE INDEX IF NOT EXISTS ix_medical_glucose_record_tenant ON medical.glucose_record(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_glucose_record_user ON medical.glucose_record(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_glucose_record_attrs ON medical.glucose_record USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.lipid_panel_record (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.lipid_panel_record IS 'Entidade de Phoenix Medical Intelligence para LipidPanelRecord.';
CREATE INDEX IF NOT EXISTS ix_medical_lipid_panel_record_tenant ON medical.lipid_panel_record(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_lipid_panel_record_user ON medical.lipid_panel_record(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_lipid_panel_record_attrs ON medical.lipid_panel_record USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.hormonal_panel_record (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.hormonal_panel_record IS 'Entidade de Phoenix Medical Intelligence para HormonalPanelRecord.';
CREATE INDEX IF NOT EXISTS ix_medical_hormonal_panel_record_tenant ON medical.hormonal_panel_record(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_hormonal_panel_record_user ON medical.hormonal_panel_record(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_hormonal_panel_record_attrs ON medical.hormonal_panel_record USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.inflammation_marker_record (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.inflammation_marker_record IS 'Entidade de Phoenix Medical Intelligence para InflammationMarkerRecord.';
CREATE INDEX IF NOT EXISTS ix_medical_inflammation_marker_record_tenant ON medical.inflammation_marker_record(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_inflammation_marker_record_user ON medical.inflammation_marker_record(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_inflammation_marker_record_attrs ON medical.inflammation_marker_record USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.renal_marker_record (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.renal_marker_record IS 'Entidade de Phoenix Medical Intelligence para RenalMarkerRecord.';
CREATE INDEX IF NOT EXISTS ix_medical_renal_marker_record_tenant ON medical.renal_marker_record(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_renal_marker_record_user ON medical.renal_marker_record(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_renal_marker_record_attrs ON medical.renal_marker_record USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.liver_marker_record (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.liver_marker_record IS 'Entidade de Phoenix Medical Intelligence para LiverMarkerRecord.';
CREATE INDEX IF NOT EXISTS ix_medical_liver_marker_record_tenant ON medical.liver_marker_record(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_liver_marker_record_user ON medical.liver_marker_record(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_liver_marker_record_attrs ON medical.liver_marker_record USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.checkup_reminder (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.checkup_reminder IS 'Entidade de Phoenix Medical Intelligence para CheckupReminder.';
CREATE INDEX IF NOT EXISTS ix_medical_checkup_reminder_tenant ON medical.checkup_reminder(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_checkup_reminder_user ON medical.checkup_reminder(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_checkup_reminder_attrs ON medical.checkup_reminder USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.checkup_completion (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.checkup_completion IS 'Entidade de Phoenix Medical Intelligence para CheckupCompletion.';
CREATE INDEX IF NOT EXISTS ix_medical_checkup_completion_tenant ON medical.checkup_completion(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_checkup_completion_user ON medical.checkup_completion(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_checkup_completion_attrs ON medical.checkup_completion USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.health_trend (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.health_trend IS 'Entidade de Phoenix Medical Intelligence para HealthTrend.';
CREATE INDEX IF NOT EXISTS ix_medical_health_trend_tenant ON medical.health_trend(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_health_trend_user ON medical.health_trend(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_health_trend_attrs ON medical.health_trend USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.health_risk_flag (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.health_risk_flag IS 'Entidade de Phoenix Medical Intelligence para HealthRiskFlag.';
CREATE INDEX IF NOT EXISTS ix_medical_health_risk_flag_tenant ON medical.health_risk_flag(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_health_risk_flag_user ON medical.health_risk_flag(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_health_risk_flag_attrs ON medical.health_risk_flag USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.medical_recommendation (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.medical_recommendation IS 'Entidade de Phoenix Medical Intelligence para MedicalRecommendation.';
CREATE INDEX IF NOT EXISTS ix_medical_medical_recommendation_tenant ON medical.medical_recommendation(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_medical_recommendation_user ON medical.medical_recommendation(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_medical_recommendation_attrs ON medical.medical_recommendation USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.medical_escalation (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.medical_escalation IS 'Entidade de Phoenix Medical Intelligence para MedicalEscalation.';
CREATE INDEX IF NOT EXISTS ix_medical_medical_escalation_tenant ON medical.medical_escalation(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_medical_escalation_user ON medical.medical_escalation(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_medical_escalation_attrs ON medical.medical_escalation USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.provider_share_link (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.provider_share_link IS 'Entidade de Phoenix Medical Intelligence para ProviderShareLink.';
CREATE INDEX IF NOT EXISTS ix_medical_provider_share_link_tenant ON medical.provider_share_link(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_provider_share_link_user ON medical.provider_share_link(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_provider_share_link_attrs ON medical.provider_share_link USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.health_data_import (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.health_data_import IS 'Entidade de Phoenix Medical Intelligence para HealthDataImport.';
CREATE INDEX IF NOT EXISTS ix_medical_health_data_import_tenant ON medical.health_data_import(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_health_data_import_user ON medical.health_data_import(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_health_data_import_attrs ON medical.health_data_import USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.health_device_connection (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.health_device_connection IS 'Entidade de Phoenix Medical Intelligence para HealthDeviceConnection.';
CREATE INDEX IF NOT EXISTS ix_medical_health_device_connection_tenant ON medical.health_device_connection(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_health_device_connection_user ON medical.health_device_connection(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_health_device_connection_attrs ON medical.health_device_connection USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.medical_attachment (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.medical_attachment IS 'Entidade de Phoenix Medical Intelligence para MedicalAttachment.';
CREATE INDEX IF NOT EXISTS ix_medical_medical_attachment_tenant ON medical.medical_attachment(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_medical_attachment_user ON medical.medical_attachment(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_medical_attachment_attrs ON medical.medical_attachment USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.clinical_note (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.clinical_note IS 'Entidade de Phoenix Medical Intelligence para ClinicalNote.';
CREATE INDEX IF NOT EXISTS ix_medical_clinical_note_tenant ON medical.clinical_note(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_clinical_note_user ON medical.clinical_note(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_clinical_note_attrs ON medical.clinical_note USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.medical_audit_event (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.medical_audit_event IS 'Entidade de Phoenix Medical Intelligence para MedicalAuditEvent.';
CREATE INDEX IF NOT EXISTS ix_medical_medical_audit_event_tenant ON medical.medical_audit_event(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_medical_audit_event_user ON medical.medical_audit_event(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_medical_audit_event_attrs ON medical.medical_audit_event USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.deidentification_job (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.deidentification_job IS 'Entidade de Phoenix Medical Intelligence para DeidentificationJob.';
CREATE INDEX IF NOT EXISTS ix_medical_deidentification_job_tenant ON medical.deidentification_job(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_deidentification_job_user ON medical.deidentification_job(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_deidentification_job_attrs ON medical.deidentification_job USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.pseudonymization_key (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.pseudonymization_key IS 'Entidade de Phoenix Medical Intelligence para PseudonymizationKey.';
CREATE INDEX IF NOT EXISTS ix_medical_pseudonymization_key_tenant ON medical.pseudonymization_key(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_pseudonymization_key_user ON medical.pseudonymization_key(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_pseudonymization_key_attrs ON medical.pseudonymization_key USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.data_retention_rule (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.data_retention_rule IS 'Entidade de Phoenix Medical Intelligence para DataRetentionRule.';
CREATE INDEX IF NOT EXISTS ix_medical_data_retention_rule_tenant ON medical.data_retention_rule(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_data_retention_rule_user ON medical.data_retention_rule(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_data_retention_rule_attrs ON medical.data_retention_rule USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.medical_review_queue (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.medical_review_queue IS 'Entidade de Phoenix Medical Intelligence para MedicalReviewQueue.';
CREATE INDEX IF NOT EXISTS ix_medical_medical_review_queue_tenant ON medical.medical_review_queue(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_medical_review_queue_user ON medical.medical_review_queue(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_medical_review_queue_attrs ON medical.medical_review_queue USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.contraindication_rule (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.contraindication_rule IS 'Entidade de Phoenix Medical Intelligence para ContraindicationRule.';
CREATE INDEX IF NOT EXISTS ix_medical_contraindication_rule_tenant ON medical.contraindication_rule(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_contraindication_rule_user ON medical.contraindication_rule(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_contraindication_rule_attrs ON medical.contraindication_rule USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.clearance_requirement (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.clearance_requirement IS 'Entidade de Phoenix Medical Intelligence para ClearanceRequirement.';
CREATE INDEX IF NOT EXISTS ix_medical_clearance_requirement_tenant ON medical.clearance_requirement(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_clearance_requirement_user ON medical.clearance_requirement(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_clearance_requirement_attrs ON medical.clearance_requirement USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.exam_schedule (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.exam_schedule IS 'Entidade de Phoenix Medical Intelligence para ExamSchedule.';
CREATE INDEX IF NOT EXISTS ix_medical_exam_schedule_tenant ON medical.exam_schedule(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_exam_schedule_user ON medical.exam_schedule(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_exam_schedule_attrs ON medical.exam_schedule USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.exam_reminder (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.exam_reminder IS 'Entidade de Phoenix Medical Intelligence para ExamReminder.';
CREATE INDEX IF NOT EXISTS ix_medical_exam_reminder_tenant ON medical.exam_reminder(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_exam_reminder_user ON medical.exam_reminder(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_exam_reminder_attrs ON medical.exam_reminder USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.health_questionnaire (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.health_questionnaire IS 'Entidade de Phoenix Medical Intelligence para HealthQuestionnaire.';
CREATE INDEX IF NOT EXISTS ix_medical_health_questionnaire_tenant ON medical.health_questionnaire(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_health_questionnaire_user ON medical.health_questionnaire(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_health_questionnaire_attrs ON medical.health_questionnaire USING gin(attributes);

CREATE TABLE IF NOT EXISTS medical.questionnaire_answer (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'sensitive_health_data',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE medical.questionnaire_answer IS 'Entidade de Phoenix Medical Intelligence para QuestionnaireAnswer.';
CREATE INDEX IF NOT EXISTS ix_medical_questionnaire_answer_tenant ON medical.questionnaire_answer(tenant_id);
CREATE INDEX IF NOT EXISTS ix_medical_questionnaire_answer_user ON medical.questionnaire_answer(user_id);
CREATE INDEX IF NOT EXISTS ix_medical_questionnaire_answer_attrs ON medical.questionnaire_answer USING gin(attributes);

CREATE TABLE IF NOT EXISTS gamification.xp_account (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gamification.xp_account IS 'Entidade de Sistema de Gamificacao para XpAccount.';
CREATE INDEX IF NOT EXISTS ix_gamification_xp_account_tenant ON gamification.xp_account(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gamification_xp_account_user ON gamification.xp_account(user_id);
CREATE INDEX IF NOT EXISTS ix_gamification_xp_account_attrs ON gamification.xp_account USING gin(attributes);

CREATE TABLE IF NOT EXISTS gamification.xp_event (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gamification.xp_event IS 'Entidade de Sistema de Gamificacao para XpEvent.';
CREATE INDEX IF NOT EXISTS ix_gamification_xp_event_tenant ON gamification.xp_event(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gamification_xp_event_user ON gamification.xp_event(user_id);
CREATE INDEX IF NOT EXISTS ix_gamification_xp_event_attrs ON gamification.xp_event USING gin(attributes);

CREATE TABLE IF NOT EXISTS gamification.xp_rule (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gamification.xp_rule IS 'Entidade de Sistema de Gamificacao para XpRule.';
CREATE INDEX IF NOT EXISTS ix_gamification_xp_rule_tenant ON gamification.xp_rule(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gamification_xp_rule_user ON gamification.xp_rule(user_id);
CREATE INDEX IF NOT EXISTS ix_gamification_xp_rule_attrs ON gamification.xp_rule USING gin(attributes);

CREATE TABLE IF NOT EXISTS gamification.rank (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gamification.rank IS 'Entidade de Sistema de Gamificacao para Rank.';
CREATE INDEX IF NOT EXISTS ix_gamification_rank_tenant ON gamification.rank(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gamification_rank_user ON gamification.rank(user_id);
CREATE INDEX IF NOT EXISTS ix_gamification_rank_attrs ON gamification.rank USING gin(attributes);

CREATE TABLE IF NOT EXISTS gamification.rank_progress (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gamification.rank_progress IS 'Entidade de Sistema de Gamificacao para RankProgress.';
CREATE INDEX IF NOT EXISTS ix_gamification_rank_progress_tenant ON gamification.rank_progress(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gamification_rank_progress_user ON gamification.rank_progress(user_id);
CREATE INDEX IF NOT EXISTS ix_gamification_rank_progress_attrs ON gamification.rank_progress USING gin(attributes);

CREATE TABLE IF NOT EXISTS gamification.streak (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gamification.streak IS 'Entidade de Sistema de Gamificacao para Streak.';
CREATE INDEX IF NOT EXISTS ix_gamification_streak_tenant ON gamification.streak(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gamification_streak_user ON gamification.streak(user_id);
CREATE INDEX IF NOT EXISTS ix_gamification_streak_attrs ON gamification.streak USING gin(attributes);

CREATE TABLE IF NOT EXISTS gamification.streak_freeze (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gamification.streak_freeze IS 'Entidade de Sistema de Gamificacao para StreakFreeze.';
CREATE INDEX IF NOT EXISTS ix_gamification_streak_freeze_tenant ON gamification.streak_freeze(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gamification_streak_freeze_user ON gamification.streak_freeze(user_id);
CREATE INDEX IF NOT EXISTS ix_gamification_streak_freeze_attrs ON gamification.streak_freeze USING gin(attributes);

CREATE TABLE IF NOT EXISTS gamification.challenge (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gamification.challenge IS 'Entidade de Sistema de Gamificacao para Challenge.';
CREATE INDEX IF NOT EXISTS ix_gamification_challenge_tenant ON gamification.challenge(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gamification_challenge_user ON gamification.challenge(user_id);
CREATE INDEX IF NOT EXISTS ix_gamification_challenge_attrs ON gamification.challenge USING gin(attributes);

CREATE TABLE IF NOT EXISTS gamification.challenge_enrollment (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gamification.challenge_enrollment IS 'Entidade de Sistema de Gamificacao para ChallengeEnrollment.';
CREATE INDEX IF NOT EXISTS ix_gamification_challenge_enrollment_tenant ON gamification.challenge_enrollment(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gamification_challenge_enrollment_user ON gamification.challenge_enrollment(user_id);
CREATE INDEX IF NOT EXISTS ix_gamification_challenge_enrollment_attrs ON gamification.challenge_enrollment USING gin(attributes);

CREATE TABLE IF NOT EXISTS gamification.challenge_submission (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gamification.challenge_submission IS 'Entidade de Sistema de Gamificacao para ChallengeSubmission.';
CREATE INDEX IF NOT EXISTS ix_gamification_challenge_submission_tenant ON gamification.challenge_submission(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gamification_challenge_submission_user ON gamification.challenge_submission(user_id);
CREATE INDEX IF NOT EXISTS ix_gamification_challenge_submission_attrs ON gamification.challenge_submission USING gin(attributes);

CREATE TABLE IF NOT EXISTS gamification.challenge_review (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gamification.challenge_review IS 'Entidade de Sistema de Gamificacao para ChallengeReview.';
CREATE INDEX IF NOT EXISTS ix_gamification_challenge_review_tenant ON gamification.challenge_review(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gamification_challenge_review_user ON gamification.challenge_review(user_id);
CREATE INDEX IF NOT EXISTS ix_gamification_challenge_review_attrs ON gamification.challenge_review USING gin(attributes);

CREATE TABLE IF NOT EXISTS gamification.mission (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gamification.mission IS 'Entidade de Sistema de Gamificacao para Mission.';
CREATE INDEX IF NOT EXISTS ix_gamification_mission_tenant ON gamification.mission(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gamification_mission_user ON gamification.mission(user_id);
CREATE INDEX IF NOT EXISTS ix_gamification_mission_attrs ON gamification.mission USING gin(attributes);

CREATE TABLE IF NOT EXISTS gamification.mission_step (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gamification.mission_step IS 'Entidade de Sistema de Gamificacao para MissionStep.';
CREATE INDEX IF NOT EXISTS ix_gamification_mission_step_tenant ON gamification.mission_step(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gamification_mission_step_user ON gamification.mission_step(user_id);
CREATE INDEX IF NOT EXISTS ix_gamification_mission_step_attrs ON gamification.mission_step USING gin(attributes);

CREATE TABLE IF NOT EXISTS gamification.reward (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gamification.reward IS 'Entidade de Sistema de Gamificacao para Reward.';
CREATE INDEX IF NOT EXISTS ix_gamification_reward_tenant ON gamification.reward(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gamification_reward_user ON gamification.reward(user_id);
CREATE INDEX IF NOT EXISTS ix_gamification_reward_attrs ON gamification.reward USING gin(attributes);

CREATE TABLE IF NOT EXISTS gamification.reward_redemption (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gamification.reward_redemption IS 'Entidade de Sistema de Gamificacao para RewardRedemption.';
CREATE INDEX IF NOT EXISTS ix_gamification_reward_redemption_tenant ON gamification.reward_redemption(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gamification_reward_redemption_user ON gamification.reward_redemption(user_id);
CREATE INDEX IF NOT EXISTS ix_gamification_reward_redemption_attrs ON gamification.reward_redemption USING gin(attributes);

CREATE TABLE IF NOT EXISTS gamification.badge_rule (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gamification.badge_rule IS 'Entidade de Sistema de Gamificacao para BadgeRule.';
CREATE INDEX IF NOT EXISTS ix_gamification_badge_rule_tenant ON gamification.badge_rule(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gamification_badge_rule_user ON gamification.badge_rule(user_id);
CREATE INDEX IF NOT EXISTS ix_gamification_badge_rule_attrs ON gamification.badge_rule USING gin(attributes);

CREATE TABLE IF NOT EXISTS gamification.leaderboard (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gamification.leaderboard IS 'Entidade de Sistema de Gamificacao para Leaderboard.';
CREATE INDEX IF NOT EXISTS ix_gamification_leaderboard_tenant ON gamification.leaderboard(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gamification_leaderboard_user ON gamification.leaderboard(user_id);
CREATE INDEX IF NOT EXISTS ix_gamification_leaderboard_attrs ON gamification.leaderboard USING gin(attributes);

CREATE TABLE IF NOT EXISTS gamification.leaderboard_entry (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gamification.leaderboard_entry IS 'Entidade de Sistema de Gamificacao para LeaderboardEntry.';
CREATE INDEX IF NOT EXISTS ix_gamification_leaderboard_entry_tenant ON gamification.leaderboard_entry(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gamification_leaderboard_entry_user ON gamification.leaderboard_entry(user_id);
CREATE INDEX IF NOT EXISTS ix_gamification_leaderboard_entry_attrs ON gamification.leaderboard_entry USING gin(attributes);

CREATE TABLE IF NOT EXISTS gamification.fair_play_signal (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gamification.fair_play_signal IS 'Entidade de Sistema de Gamificacao para FairPlaySignal.';
CREATE INDEX IF NOT EXISTS ix_gamification_fair_play_signal_tenant ON gamification.fair_play_signal(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gamification_fair_play_signal_user ON gamification.fair_play_signal(user_id);
CREATE INDEX IF NOT EXISTS ix_gamification_fair_play_signal_attrs ON gamification.fair_play_signal USING gin(attributes);

CREATE TABLE IF NOT EXISTS gamification.anti_gaming_rule (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gamification.anti_gaming_rule IS 'Entidade de Sistema de Gamificacao para AntiGamingRule.';
CREATE INDEX IF NOT EXISTS ix_gamification_anti_gaming_rule_tenant ON gamification.anti_gaming_rule(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gamification_anti_gaming_rule_user ON gamification.anti_gaming_rule(user_id);
CREATE INDEX IF NOT EXISTS ix_gamification_anti_gaming_rule_attrs ON gamification.anti_gaming_rule USING gin(attributes);

CREATE TABLE IF NOT EXISTS gamification.season (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gamification.season IS 'Entidade de Sistema de Gamificacao para Season.';
CREATE INDEX IF NOT EXISTS ix_gamification_season_tenant ON gamification.season(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gamification_season_user ON gamification.season(user_id);
CREATE INDEX IF NOT EXISTS ix_gamification_season_attrs ON gamification.season USING gin(attributes);

CREATE TABLE IF NOT EXISTS gamification.season_pass (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gamification.season_pass IS 'Entidade de Sistema de Gamificacao para SeasonPass.';
CREATE INDEX IF NOT EXISTS ix_gamification_season_pass_tenant ON gamification.season_pass(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gamification_season_pass_user ON gamification.season_pass(user_id);
CREATE INDEX IF NOT EXISTS ix_gamification_season_pass_attrs ON gamification.season_pass USING gin(attributes);

CREATE TABLE IF NOT EXISTS gamification.quest (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gamification.quest IS 'Entidade de Sistema de Gamificacao para Quest.';
CREATE INDEX IF NOT EXISTS ix_gamification_quest_tenant ON gamification.quest(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gamification_quest_user ON gamification.quest(user_id);
CREATE INDEX IF NOT EXISTS ix_gamification_quest_attrs ON gamification.quest USING gin(attributes);

CREATE TABLE IF NOT EXISTS gamification.quest_objective (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gamification.quest_objective IS 'Entidade de Sistema de Gamificacao para QuestObjective.';
CREATE INDEX IF NOT EXISTS ix_gamification_quest_objective_tenant ON gamification.quest_objective(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gamification_quest_objective_user ON gamification.quest_objective(user_id);
CREATE INDEX IF NOT EXISTS ix_gamification_quest_objective_attrs ON gamification.quest_objective USING gin(attributes);

CREATE TABLE IF NOT EXISTS gamification.loot_grant (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gamification.loot_grant IS 'Entidade de Sistema de Gamificacao para LootGrant.';
CREATE INDEX IF NOT EXISTS ix_gamification_loot_grant_tenant ON gamification.loot_grant(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gamification_loot_grant_user ON gamification.loot_grant(user_id);
CREATE INDEX IF NOT EXISTS ix_gamification_loot_grant_attrs ON gamification.loot_grant USING gin(attributes);

CREATE TABLE IF NOT EXISTS gamification.motivation_trigger (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gamification.motivation_trigger IS 'Entidade de Sistema de Gamificacao para MotivationTrigger.';
CREATE INDEX IF NOT EXISTS ix_gamification_motivation_trigger_tenant ON gamification.motivation_trigger(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gamification_motivation_trigger_user ON gamification.motivation_trigger(user_id);
CREATE INDEX IF NOT EXISTS ix_gamification_motivation_trigger_attrs ON gamification.motivation_trigger USING gin(attributes);

CREATE TABLE IF NOT EXISTS gamification.gamification_experiment (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gamification.gamification_experiment IS 'Entidade de Sistema de Gamificacao para GamificationExperiment.';
CREATE INDEX IF NOT EXISTS ix_gamification_gamification_experiment_tenant ON gamification.gamification_experiment(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gamification_gamification_experiment_user ON gamification.gamification_experiment(user_id);
CREATE INDEX IF NOT EXISTS ix_gamification_gamification_experiment_attrs ON gamification.gamification_experiment USING gin(attributes);

CREATE TABLE IF NOT EXISTS gamification.progress_celebration (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gamification.progress_celebration IS 'Entidade de Sistema de Gamificacao para ProgressCelebration.';
CREATE INDEX IF NOT EXISTS ix_gamification_progress_celebration_tenant ON gamification.progress_celebration(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gamification_progress_celebration_user ON gamification.progress_celebration(user_id);
CREATE INDEX IF NOT EXISTS ix_gamification_progress_celebration_attrs ON gamification.progress_celebration USING gin(attributes);

CREATE TABLE IF NOT EXISTS billing.product_plan (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE billing.product_plan IS 'Entidade de Monetizacao SaaS para ProductPlan.';
CREATE INDEX IF NOT EXISTS ix_billing_product_plan_tenant ON billing.product_plan(tenant_id);
CREATE INDEX IF NOT EXISTS ix_billing_product_plan_user ON billing.product_plan(user_id);
CREATE INDEX IF NOT EXISTS ix_billing_product_plan_attrs ON billing.product_plan USING gin(attributes);

CREATE TABLE IF NOT EXISTS billing.plan_feature (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE billing.plan_feature IS 'Entidade de Monetizacao SaaS para PlanFeature.';
CREATE INDEX IF NOT EXISTS ix_billing_plan_feature_tenant ON billing.plan_feature(tenant_id);
CREATE INDEX IF NOT EXISTS ix_billing_plan_feature_user ON billing.plan_feature(user_id);
CREATE INDEX IF NOT EXISTS ix_billing_plan_feature_attrs ON billing.plan_feature USING gin(attributes);

CREATE TABLE IF NOT EXISTS billing.price (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE billing.price IS 'Entidade de Monetizacao SaaS para Price.';
CREATE INDEX IF NOT EXISTS ix_billing_price_tenant ON billing.price(tenant_id);
CREATE INDEX IF NOT EXISTS ix_billing_price_user ON billing.price(user_id);
CREATE INDEX IF NOT EXISTS ix_billing_price_attrs ON billing.price USING gin(attributes);

CREATE TABLE IF NOT EXISTS billing.subscription (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE billing.subscription IS 'Entidade de Monetizacao SaaS para Subscription.';
CREATE INDEX IF NOT EXISTS ix_billing_subscription_tenant ON billing.subscription(tenant_id);
CREATE INDEX IF NOT EXISTS ix_billing_subscription_user ON billing.subscription(user_id);
CREATE INDEX IF NOT EXISTS ix_billing_subscription_attrs ON billing.subscription USING gin(attributes);

CREATE TABLE IF NOT EXISTS billing.subscription_item (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE billing.subscription_item IS 'Entidade de Monetizacao SaaS para SubscriptionItem.';
CREATE INDEX IF NOT EXISTS ix_billing_subscription_item_tenant ON billing.subscription_item(tenant_id);
CREATE INDEX IF NOT EXISTS ix_billing_subscription_item_user ON billing.subscription_item(user_id);
CREATE INDEX IF NOT EXISTS ix_billing_subscription_item_attrs ON billing.subscription_item USING gin(attributes);

CREATE TABLE IF NOT EXISTS billing.trial (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE billing.trial IS 'Entidade de Monetizacao SaaS para Trial.';
CREATE INDEX IF NOT EXISTS ix_billing_trial_tenant ON billing.trial(tenant_id);
CREATE INDEX IF NOT EXISTS ix_billing_trial_user ON billing.trial(user_id);
CREATE INDEX IF NOT EXISTS ix_billing_trial_attrs ON billing.trial USING gin(attributes);

CREATE TABLE IF NOT EXISTS billing.invoice (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE billing.invoice IS 'Entidade de Monetizacao SaaS para Invoice.';
CREATE INDEX IF NOT EXISTS ix_billing_invoice_tenant ON billing.invoice(tenant_id);
CREATE INDEX IF NOT EXISTS ix_billing_invoice_user ON billing.invoice(user_id);
CREATE INDEX IF NOT EXISTS ix_billing_invoice_attrs ON billing.invoice USING gin(attributes);

CREATE TABLE IF NOT EXISTS billing.invoice_line (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE billing.invoice_line IS 'Entidade de Monetizacao SaaS para InvoiceLine.';
CREATE INDEX IF NOT EXISTS ix_billing_invoice_line_tenant ON billing.invoice_line(tenant_id);
CREATE INDEX IF NOT EXISTS ix_billing_invoice_line_user ON billing.invoice_line(user_id);
CREATE INDEX IF NOT EXISTS ix_billing_invoice_line_attrs ON billing.invoice_line USING gin(attributes);

CREATE TABLE IF NOT EXISTS billing.payment_method (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE billing.payment_method IS 'Entidade de Monetizacao SaaS para PaymentMethod.';
CREATE INDEX IF NOT EXISTS ix_billing_payment_method_tenant ON billing.payment_method(tenant_id);
CREATE INDEX IF NOT EXISTS ix_billing_payment_method_user ON billing.payment_method(user_id);
CREATE INDEX IF NOT EXISTS ix_billing_payment_method_attrs ON billing.payment_method USING gin(attributes);

CREATE TABLE IF NOT EXISTS billing.payment_intent (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE billing.payment_intent IS 'Entidade de Monetizacao SaaS para PaymentIntent.';
CREATE INDEX IF NOT EXISTS ix_billing_payment_intent_tenant ON billing.payment_intent(tenant_id);
CREATE INDEX IF NOT EXISTS ix_billing_payment_intent_user ON billing.payment_intent(user_id);
CREATE INDEX IF NOT EXISTS ix_billing_payment_intent_attrs ON billing.payment_intent USING gin(attributes);

CREATE TABLE IF NOT EXISTS billing.refund (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE billing.refund IS 'Entidade de Monetizacao SaaS para Refund.';
CREATE INDEX IF NOT EXISTS ix_billing_refund_tenant ON billing.refund(tenant_id);
CREATE INDEX IF NOT EXISTS ix_billing_refund_user ON billing.refund(user_id);
CREATE INDEX IF NOT EXISTS ix_billing_refund_attrs ON billing.refund USING gin(attributes);

CREATE TABLE IF NOT EXISTS billing.coupon (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE billing.coupon IS 'Entidade de Monetizacao SaaS para Coupon.';
CREATE INDEX IF NOT EXISTS ix_billing_coupon_tenant ON billing.coupon(tenant_id);
CREATE INDEX IF NOT EXISTS ix_billing_coupon_user ON billing.coupon(user_id);
CREATE INDEX IF NOT EXISTS ix_billing_coupon_attrs ON billing.coupon USING gin(attributes);

CREATE TABLE IF NOT EXISTS billing.promotion_code (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE billing.promotion_code IS 'Entidade de Monetizacao SaaS para PromotionCode.';
CREATE INDEX IF NOT EXISTS ix_billing_promotion_code_tenant ON billing.promotion_code(tenant_id);
CREATE INDEX IF NOT EXISTS ix_billing_promotion_code_user ON billing.promotion_code(user_id);
CREATE INDEX IF NOT EXISTS ix_billing_promotion_code_attrs ON billing.promotion_code USING gin(attributes);

CREATE TABLE IF NOT EXISTS billing.entitlement (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE billing.entitlement IS 'Entidade de Monetizacao SaaS para Entitlement.';
CREATE INDEX IF NOT EXISTS ix_billing_entitlement_tenant ON billing.entitlement(tenant_id);
CREATE INDEX IF NOT EXISTS ix_billing_entitlement_user ON billing.entitlement(user_id);
CREATE INDEX IF NOT EXISTS ix_billing_entitlement_attrs ON billing.entitlement USING gin(attributes);

CREATE TABLE IF NOT EXISTS billing.feature_flag (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE billing.feature_flag IS 'Entidade de Monetizacao SaaS para FeatureFlag.';
CREATE INDEX IF NOT EXISTS ix_billing_feature_flag_tenant ON billing.feature_flag(tenant_id);
CREATE INDEX IF NOT EXISTS ix_billing_feature_flag_user ON billing.feature_flag(user_id);
CREATE INDEX IF NOT EXISTS ix_billing_feature_flag_attrs ON billing.feature_flag USING gin(attributes);

CREATE TABLE IF NOT EXISTS billing.usage_meter (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE billing.usage_meter IS 'Entidade de Monetizacao SaaS para UsageMeter.';
CREATE INDEX IF NOT EXISTS ix_billing_usage_meter_tenant ON billing.usage_meter(tenant_id);
CREATE INDEX IF NOT EXISTS ix_billing_usage_meter_user ON billing.usage_meter(user_id);
CREATE INDEX IF NOT EXISTS ix_billing_usage_meter_attrs ON billing.usage_meter USING gin(attributes);

CREATE TABLE IF NOT EXISTS billing.usage_event (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE billing.usage_event IS 'Entidade de Monetizacao SaaS para UsageEvent.';
CREATE INDEX IF NOT EXISTS ix_billing_usage_event_tenant ON billing.usage_event(tenant_id);
CREATE INDEX IF NOT EXISTS ix_billing_usage_event_user ON billing.usage_event(user_id);
CREATE INDEX IF NOT EXISTS ix_billing_usage_event_attrs ON billing.usage_event USING gin(attributes);

CREATE TABLE IF NOT EXISTS billing.seat_allocation (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE billing.seat_allocation IS 'Entidade de Monetizacao SaaS para SeatAllocation.';
CREATE INDEX IF NOT EXISTS ix_billing_seat_allocation_tenant ON billing.seat_allocation(tenant_id);
CREATE INDEX IF NOT EXISTS ix_billing_seat_allocation_user ON billing.seat_allocation(user_id);
CREATE INDEX IF NOT EXISTS ix_billing_seat_allocation_attrs ON billing.seat_allocation USING gin(attributes);

CREATE TABLE IF NOT EXISTS billing.tax_rate (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE billing.tax_rate IS 'Entidade de Monetizacao SaaS para TaxRate.';
CREATE INDEX IF NOT EXISTS ix_billing_tax_rate_tenant ON billing.tax_rate(tenant_id);
CREATE INDEX IF NOT EXISTS ix_billing_tax_rate_user ON billing.tax_rate(user_id);
CREATE INDEX IF NOT EXISTS ix_billing_tax_rate_attrs ON billing.tax_rate USING gin(attributes);

CREATE TABLE IF NOT EXISTS billing.billing_address (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE billing.billing_address IS 'Entidade de Monetizacao SaaS para BillingAddress.';
CREATE INDEX IF NOT EXISTS ix_billing_billing_address_tenant ON billing.billing_address(tenant_id);
CREATE INDEX IF NOT EXISTS ix_billing_billing_address_user ON billing.billing_address(user_id);
CREATE INDEX IF NOT EXISTS ix_billing_billing_address_attrs ON billing.billing_address USING gin(attributes);

CREATE TABLE IF NOT EXISTS billing.customer_account (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE billing.customer_account IS 'Entidade de Monetizacao SaaS para CustomerAccount.';
CREATE INDEX IF NOT EXISTS ix_billing_customer_account_tenant ON billing.customer_account(tenant_id);
CREATE INDEX IF NOT EXISTS ix_billing_customer_account_user ON billing.customer_account(user_id);
CREATE INDEX IF NOT EXISTS ix_billing_customer_account_attrs ON billing.customer_account USING gin(attributes);

CREATE TABLE IF NOT EXISTS billing.dunning_event (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE billing.dunning_event IS 'Entidade de Monetizacao SaaS para DunningEvent.';
CREATE INDEX IF NOT EXISTS ix_billing_dunning_event_tenant ON billing.dunning_event(tenant_id);
CREATE INDEX IF NOT EXISTS ix_billing_dunning_event_user ON billing.dunning_event(user_id);
CREATE INDEX IF NOT EXISTS ix_billing_dunning_event_attrs ON billing.dunning_event USING gin(attributes);

CREATE TABLE IF NOT EXISTS billing.revenue_recognition_event (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE billing.revenue_recognition_event IS 'Entidade de Monetizacao SaaS para RevenueRecognitionEvent.';
CREATE INDEX IF NOT EXISTS ix_billing_revenue_recognition_event_tenant ON billing.revenue_recognition_event(tenant_id);
CREATE INDEX IF NOT EXISTS ix_billing_revenue_recognition_event_user ON billing.revenue_recognition_event(user_id);
CREATE INDEX IF NOT EXISTS ix_billing_revenue_recognition_event_attrs ON billing.revenue_recognition_event USING gin(attributes);

CREATE TABLE IF NOT EXISTS billing.affiliate_partner (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE billing.affiliate_partner IS 'Entidade de Monetizacao SaaS para AffiliatePartner.';
CREATE INDEX IF NOT EXISTS ix_billing_affiliate_partner_tenant ON billing.affiliate_partner(tenant_id);
CREATE INDEX IF NOT EXISTS ix_billing_affiliate_partner_user ON billing.affiliate_partner(user_id);
CREATE INDEX IF NOT EXISTS ix_billing_affiliate_partner_attrs ON billing.affiliate_partner USING gin(attributes);

CREATE TABLE IF NOT EXISTS billing.referral (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE billing.referral IS 'Entidade de Monetizacao SaaS para Referral.';
CREATE INDEX IF NOT EXISTS ix_billing_referral_tenant ON billing.referral(tenant_id);
CREATE INDEX IF NOT EXISTS ix_billing_referral_user ON billing.referral(user_id);
CREATE INDEX IF NOT EXISTS ix_billing_referral_attrs ON billing.referral USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_organization (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_organization IS 'Entidade de Gym Performance Network para GymOrganization.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_organization_tenant ON gym.gym_organization(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_organization_user ON gym.gym_organization(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_organization_attrs ON gym.gym_organization USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_facility (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_facility IS 'Entidade de Gym Performance Network para GymFacility.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_facility_tenant ON gym.gym_facility(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_facility_user ON gym.gym_facility(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_facility_attrs ON gym.gym_facility USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_brand (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_brand IS 'Entidade de Gym Performance Network para GymBrand.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_brand_tenant ON gym.gym_brand(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_brand_user ON gym.gym_brand(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_brand_attrs ON gym.gym_brand USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_location (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_location IS 'Entidade de Gym Performance Network para GymLocation.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_location_tenant ON gym.gym_location(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_location_user ON gym.gym_location(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_location_attrs ON gym.gym_location USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_membership_plan (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_membership_plan IS 'Entidade de Gym Performance Network para GymMembershipPlan.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_membership_plan_tenant ON gym.gym_membership_plan(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_membership_plan_user ON gym.gym_membership_plan(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_membership_plan_attrs ON gym.gym_membership_plan USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_member_profile (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_member_profile IS 'Entidade de Gym Performance Network para GymMemberProfile.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_member_profile_tenant ON gym.gym_member_profile(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_member_profile_user ON gym.gym_member_profile(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_member_profile_attrs ON gym.gym_member_profile USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_member_enrollment (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_member_enrollment IS 'Entidade de Gym Performance Network para GymMemberEnrollment.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_member_enrollment_tenant ON gym.gym_member_enrollment(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_member_enrollment_user ON gym.gym_member_enrollment(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_member_enrollment_attrs ON gym.gym_member_enrollment USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_staff_profile (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_staff_profile IS 'Entidade de Gym Performance Network para GymStaffProfile.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_staff_profile_tenant ON gym.gym_staff_profile(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_staff_profile_user ON gym.gym_staff_profile(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_staff_profile_attrs ON gym.gym_staff_profile USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_coach_assignment (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_coach_assignment IS 'Entidade de Gym Performance Network para GymCoachAssignment.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_coach_assignment_tenant ON gym.gym_coach_assignment(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_coach_assignment_user ON gym.gym_coach_assignment(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_coach_assignment_attrs ON gym.gym_coach_assignment USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_nutritionist_assignment (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_nutritionist_assignment IS 'Entidade de Gym Performance Network para GymNutritionistAssignment.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_nutritionist_assignment_tenant ON gym.gym_nutritionist_assignment(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_nutritionist_assignment_user ON gym.gym_nutritionist_assignment(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_nutritionist_assignment_attrs ON gym.gym_nutritionist_assignment USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_cohort (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_cohort IS 'Entidade de Gym Performance Network para GymCohort.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_cohort_tenant ON gym.gym_cohort(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_cohort_user ON gym.gym_cohort(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_cohort_attrs ON gym.gym_cohort USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_cohort_enrollment (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_cohort_enrollment IS 'Entidade de Gym Performance Network para GymCohortEnrollment.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_cohort_enrollment_tenant ON gym.gym_cohort_enrollment(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_cohort_enrollment_user ON gym.gym_cohort_enrollment(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_cohort_enrollment_attrs ON gym.gym_cohort_enrollment USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_class (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_class IS 'Entidade de Gym Performance Network para GymClass.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_class_tenant ON gym.gym_class(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_class_user ON gym.gym_class(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_class_attrs ON gym.gym_class USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_class_schedule (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_class_schedule IS 'Entidade de Gym Performance Network para GymClassSchedule.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_class_schedule_tenant ON gym.gym_class_schedule(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_class_schedule_user ON gym.gym_class_schedule(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_class_schedule_attrs ON gym.gym_class_schedule USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_class_attendance (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_class_attendance IS 'Entidade de Gym Performance Network para GymClassAttendance.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_class_attendance_tenant ON gym.gym_class_attendance(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_class_attendance_user ON gym.gym_class_attendance(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_class_attendance_attrs ON gym.gym_class_attendance USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_equipment (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_equipment IS 'Entidade de Gym Performance Network para GymEquipment.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_equipment_tenant ON gym.gym_equipment(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_equipment_user ON gym.gym_equipment(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_equipment_attrs ON gym.gym_equipment USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_equipment_category (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_equipment_category IS 'Entidade de Gym Performance Network para GymEquipmentCategory.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_equipment_category_tenant ON gym.gym_equipment_category(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_equipment_category_user ON gym.gym_equipment_category(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_equipment_category_attrs ON gym.gym_equipment_category USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_machine_setting (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_machine_setting IS 'Entidade de Gym Performance Network para GymMachineSetting.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_machine_setting_tenant ON gym.gym_machine_setting(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_machine_setting_user ON gym.gym_machine_setting(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_machine_setting_attrs ON gym.gym_machine_setting USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_workout_template (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_workout_template IS 'Entidade de Gym Performance Network para GymWorkoutTemplate.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_workout_template_tenant ON gym.gym_workout_template(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_workout_template_user ON gym.gym_workout_template(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_workout_template_attrs ON gym.gym_workout_template USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_bodybuilding_program (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_bodybuilding_program IS 'Entidade de Gym Performance Network para GymBodybuildingProgram.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_bodybuilding_program_tenant ON gym.gym_bodybuilding_program(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_bodybuilding_program_user ON gym.gym_bodybuilding_program(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_bodybuilding_program_attrs ON gym.gym_bodybuilding_program USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_bodybuilding_phase (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_bodybuilding_phase IS 'Entidade de Gym Performance Network para GymBodybuildingPhase.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_bodybuilding_phase_tenant ON gym.gym_bodybuilding_phase(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_bodybuilding_phase_user ON gym.gym_bodybuilding_phase(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_bodybuilding_phase_attrs ON gym.gym_bodybuilding_phase USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_check_in (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_check_in IS 'Entidade de Gym Performance Network para GymCheckIn.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_check_in_tenant ON gym.gym_check_in(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_check_in_user ON gym.gym_check_in(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_check_in_attrs ON gym.gym_check_in USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_lead (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_lead IS 'Entidade de Gym Performance Network para GymLead.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_lead_tenant ON gym.gym_lead(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_lead_user ON gym.gym_lead(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_lead_attrs ON gym.gym_lead USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_sales_funnel (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_sales_funnel IS 'Entidade de Gym Performance Network para GymSalesFunnel.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_sales_funnel_tenant ON gym.gym_sales_funnel(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_sales_funnel_user ON gym.gym_sales_funnel(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_sales_funnel_attrs ON gym.gym_sales_funnel USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_member_retention_signal (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_member_retention_signal IS 'Entidade de Gym Performance Network para GymMemberRetentionSignal.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_member_retention_signal_tenant ON gym.gym_member_retention_signal(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_member_retention_signal_user ON gym.gym_member_retention_signal(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_member_retention_signal_attrs ON gym.gym_member_retention_signal USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_churn_risk (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_churn_risk IS 'Entidade de Gym Performance Network para GymChurnRisk.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_churn_risk_tenant ON gym.gym_churn_risk(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_churn_risk_user ON gym.gym_churn_risk(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_churn_risk_attrs ON gym.gym_churn_risk USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_challenge (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_challenge IS 'Entidade de Gym Performance Network para GymChallenge.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_challenge_tenant ON gym.gym_challenge(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_challenge_user ON gym.gym_challenge(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_challenge_attrs ON gym.gym_challenge USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_leaderboard (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_leaderboard IS 'Entidade de Gym Performance Network para GymLeaderboard.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_leaderboard_tenant ON gym.gym_leaderboard(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_leaderboard_user ON gym.gym_leaderboard(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_leaderboard_attrs ON gym.gym_leaderboard USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_dashboard (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_dashboard IS 'Entidade de Gym Performance Network para GymDashboard.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_dashboard_tenant ON gym.gym_dashboard(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_dashboard_user ON gym.gym_dashboard(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_dashboard_attrs ON gym.gym_dashboard USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_staff_permission (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_staff_permission IS 'Entidade de Gym Performance Network para GymStaffPermission.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_staff_permission_tenant ON gym.gym_staff_permission(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_staff_permission_user ON gym.gym_staff_permission(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_staff_permission_attrs ON gym.gym_staff_permission USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_content_assignment (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_content_assignment IS 'Entidade de Gym Performance Network para GymContentAssignment.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_content_assignment_tenant ON gym.gym_content_assignment(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_content_assignment_user ON gym.gym_content_assignment(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_content_assignment_attrs ON gym.gym_content_assignment USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_nutrition_program_enrollment (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_nutrition_program_enrollment IS 'Entidade de Gym Performance Network para GymNutritionProgramEnrollment.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_nutrition_program_enrollment_tenant ON gym.gym_nutrition_program_enrollment(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_nutrition_program_enrollment_user ON gym.gym_nutrition_program_enrollment(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_nutrition_program_enrollment_attrs ON gym.gym_nutrition_program_enrollment USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_medical_clearance_policy (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_medical_clearance_policy IS 'Entidade de Gym Performance Network para GymMedicalClearancePolicy.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_medical_clearance_policy_tenant ON gym.gym_medical_clearance_policy(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_medical_clearance_policy_user ON gym.gym_medical_clearance_policy(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_medical_clearance_policy_attrs ON gym.gym_medical_clearance_policy USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_privacy_boundary (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_privacy_boundary IS 'Entidade de Gym Performance Network para GymPrivacyBoundary.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_privacy_boundary_tenant ON gym.gym_privacy_boundary(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_privacy_boundary_user ON gym.gym_privacy_boundary(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_privacy_boundary_attrs ON gym.gym_privacy_boundary USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_b2_b_contract (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_b2_b_contract IS 'Entidade de Gym Performance Network para GymB2BContract.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_b2_b_contract_tenant ON gym.gym_b2_b_contract(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_b2_b_contract_user ON gym.gym_b2_b_contract(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_b2_b_contract_attrs ON gym.gym_b2_b_contract USING gin(attributes);

CREATE TABLE IF NOT EXISTS gym.gym_invoice_allocation (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE gym.gym_invoice_allocation IS 'Entidade de Gym Performance Network para GymInvoiceAllocation.';
CREATE INDEX IF NOT EXISTS ix_gym_gym_invoice_allocation_tenant ON gym.gym_invoice_allocation(tenant_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_invoice_allocation_user ON gym.gym_invoice_allocation(user_id);
CREATE INDEX IF NOT EXISTS ix_gym_gym_invoice_allocation_attrs ON gym.gym_invoice_allocation USING gin(attributes);

CREATE TABLE IF NOT EXISTS security.audit_log (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE security.audit_log IS 'Entidade de Seguranca e Compliance para AuditLog.';
CREATE INDEX IF NOT EXISTS ix_security_audit_log_tenant ON security.audit_log(tenant_id);
CREATE INDEX IF NOT EXISTS ix_security_audit_log_user ON security.audit_log(user_id);
CREATE INDEX IF NOT EXISTS ix_security_audit_log_attrs ON security.audit_log USING gin(attributes);

CREATE TABLE IF NOT EXISTS security.access_log (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE security.access_log IS 'Entidade de Seguranca e Compliance para AccessLog.';
CREATE INDEX IF NOT EXISTS ix_security_access_log_tenant ON security.access_log(tenant_id);
CREATE INDEX IF NOT EXISTS ix_security_access_log_user ON security.access_log(user_id);
CREATE INDEX IF NOT EXISTS ix_security_access_log_attrs ON security.access_log USING gin(attributes);

CREATE TABLE IF NOT EXISTS security.security_event (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE security.security_event IS 'Entidade de Seguranca e Compliance para SecurityEvent.';
CREATE INDEX IF NOT EXISTS ix_security_security_event_tenant ON security.security_event(tenant_id);
CREATE INDEX IF NOT EXISTS ix_security_security_event_user ON security.security_event(user_id);
CREATE INDEX IF NOT EXISTS ix_security_security_event_attrs ON security.security_event USING gin(attributes);

CREATE TABLE IF NOT EXISTS security.security_incident (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE security.security_incident IS 'Entidade de Seguranca e Compliance para SecurityIncident.';
CREATE INDEX IF NOT EXISTS ix_security_security_incident_tenant ON security.security_incident(tenant_id);
CREATE INDEX IF NOT EXISTS ix_security_security_incident_user ON security.security_incident(user_id);
CREATE INDEX IF NOT EXISTS ix_security_security_incident_attrs ON security.security_incident USING gin(attributes);

CREATE TABLE IF NOT EXISTS security.incident_timeline (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE security.incident_timeline IS 'Entidade de Seguranca e Compliance para IncidentTimeline.';
CREATE INDEX IF NOT EXISTS ix_security_incident_timeline_tenant ON security.incident_timeline(tenant_id);
CREATE INDEX IF NOT EXISTS ix_security_incident_timeline_user ON security.incident_timeline(user_id);
CREATE INDEX IF NOT EXISTS ix_security_incident_timeline_attrs ON security.incident_timeline USING gin(attributes);

CREATE TABLE IF NOT EXISTS security.risk_register (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE security.risk_register IS 'Entidade de Seguranca e Compliance para RiskRegister.';
CREATE INDEX IF NOT EXISTS ix_security_risk_register_tenant ON security.risk_register(tenant_id);
CREATE INDEX IF NOT EXISTS ix_security_risk_register_user ON security.risk_register(user_id);
CREATE INDEX IF NOT EXISTS ix_security_risk_register_attrs ON security.risk_register USING gin(attributes);

CREATE TABLE IF NOT EXISTS security.control (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE security.control IS 'Entidade de Seguranca e Compliance para Control.';
CREATE INDEX IF NOT EXISTS ix_security_control_tenant ON security.control(tenant_id);
CREATE INDEX IF NOT EXISTS ix_security_control_user ON security.control(user_id);
CREATE INDEX IF NOT EXISTS ix_security_control_attrs ON security.control USING gin(attributes);

CREATE TABLE IF NOT EXISTS security.control_evidence (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE security.control_evidence IS 'Entidade de Seguranca e Compliance para ControlEvidence.';
CREATE INDEX IF NOT EXISTS ix_security_control_evidence_tenant ON security.control_evidence(tenant_id);
CREATE INDEX IF NOT EXISTS ix_security_control_evidence_user ON security.control_evidence(user_id);
CREATE INDEX IF NOT EXISTS ix_security_control_evidence_attrs ON security.control_evidence USING gin(attributes);

CREATE TABLE IF NOT EXISTS security.policy (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE security.policy IS 'Entidade de Seguranca e Compliance para Policy.';
CREATE INDEX IF NOT EXISTS ix_security_policy_tenant ON security.policy(tenant_id);
CREATE INDEX IF NOT EXISTS ix_security_policy_user ON security.policy(user_id);
CREATE INDEX IF NOT EXISTS ix_security_policy_attrs ON security.policy USING gin(attributes);

CREATE TABLE IF NOT EXISTS security.policy_acceptance (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE security.policy_acceptance IS 'Entidade de Seguranca e Compliance para PolicyAcceptance.';
CREATE INDEX IF NOT EXISTS ix_security_policy_acceptance_tenant ON security.policy_acceptance(tenant_id);
CREATE INDEX IF NOT EXISTS ix_security_policy_acceptance_user ON security.policy_acceptance(user_id);
CREATE INDEX IF NOT EXISTS ix_security_policy_acceptance_attrs ON security.policy_acceptance USING gin(attributes);

CREATE TABLE IF NOT EXISTS security.secret_rotation (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE security.secret_rotation IS 'Entidade de Seguranca e Compliance para SecretRotation.';
CREATE INDEX IF NOT EXISTS ix_security_secret_rotation_tenant ON security.secret_rotation(tenant_id);
CREATE INDEX IF NOT EXISTS ix_security_secret_rotation_user ON security.secret_rotation(user_id);
CREATE INDEX IF NOT EXISTS ix_security_secret_rotation_attrs ON security.secret_rotation USING gin(attributes);

CREATE TABLE IF NOT EXISTS security.encryption_key (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE security.encryption_key IS 'Entidade de Seguranca e Compliance para EncryptionKey.';
CREATE INDEX IF NOT EXISTS ix_security_encryption_key_tenant ON security.encryption_key(tenant_id);
CREATE INDEX IF NOT EXISTS ix_security_encryption_key_user ON security.encryption_key(user_id);
CREATE INDEX IF NOT EXISTS ix_security_encryption_key_attrs ON security.encryption_key USING gin(attributes);

CREATE TABLE IF NOT EXISTS security.key_access_grant (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE security.key_access_grant IS 'Entidade de Seguranca e Compliance para KeyAccessGrant.';
CREATE INDEX IF NOT EXISTS ix_security_key_access_grant_tenant ON security.key_access_grant(tenant_id);
CREATE INDEX IF NOT EXISTS ix_security_key_access_grant_user ON security.key_access_grant(user_id);
CREATE INDEX IF NOT EXISTS ix_security_key_access_grant_attrs ON security.key_access_grant USING gin(attributes);

CREATE TABLE IF NOT EXISTS security.data_classification_rule (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE security.data_classification_rule IS 'Entidade de Seguranca e Compliance para DataClassificationRule.';
CREATE INDEX IF NOT EXISTS ix_security_data_classification_rule_tenant ON security.data_classification_rule(tenant_id);
CREATE INDEX IF NOT EXISTS ix_security_data_classification_rule_user ON security.data_classification_rule(user_id);
CREATE INDEX IF NOT EXISTS ix_security_data_classification_rule_attrs ON security.data_classification_rule USING gin(attributes);

CREATE TABLE IF NOT EXISTS security.retention_schedule (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE security.retention_schedule IS 'Entidade de Seguranca e Compliance para RetentionSchedule.';
CREATE INDEX IF NOT EXISTS ix_security_retention_schedule_tenant ON security.retention_schedule(tenant_id);
CREATE INDEX IF NOT EXISTS ix_security_retention_schedule_user ON security.retention_schedule(user_id);
CREATE INDEX IF NOT EXISTS ix_security_retention_schedule_attrs ON security.retention_schedule USING gin(attributes);

CREATE TABLE IF NOT EXISTS security.backup_job (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE security.backup_job IS 'Entidade de Seguranca e Compliance para BackupJob.';
CREATE INDEX IF NOT EXISTS ix_security_backup_job_tenant ON security.backup_job(tenant_id);
CREATE INDEX IF NOT EXISTS ix_security_backup_job_user ON security.backup_job(user_id);
CREATE INDEX IF NOT EXISTS ix_security_backup_job_attrs ON security.backup_job USING gin(attributes);

CREATE TABLE IF NOT EXISTS security.restore_test (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE security.restore_test IS 'Entidade de Seguranca e Compliance para RestoreTest.';
CREATE INDEX IF NOT EXISTS ix_security_restore_test_tenant ON security.restore_test(tenant_id);
CREATE INDEX IF NOT EXISTS ix_security_restore_test_user ON security.restore_test(user_id);
CREATE INDEX IF NOT EXISTS ix_security_restore_test_attrs ON security.restore_test USING gin(attributes);

CREATE TABLE IF NOT EXISTS security.vulnerability_finding (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE security.vulnerability_finding IS 'Entidade de Seguranca e Compliance para VulnerabilityFinding.';
CREATE INDEX IF NOT EXISTS ix_security_vulnerability_finding_tenant ON security.vulnerability_finding(tenant_id);
CREATE INDEX IF NOT EXISTS ix_security_vulnerability_finding_user ON security.vulnerability_finding(user_id);
CREATE INDEX IF NOT EXISTS ix_security_vulnerability_finding_attrs ON security.vulnerability_finding USING gin(attributes);

CREATE TABLE IF NOT EXISTS security.pen_test_finding (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE security.pen_test_finding IS 'Entidade de Seguranca e Compliance para PenTestFinding.';
CREATE INDEX IF NOT EXISTS ix_security_pen_test_finding_tenant ON security.pen_test_finding(tenant_id);
CREATE INDEX IF NOT EXISTS ix_security_pen_test_finding_user ON security.pen_test_finding(user_id);
CREATE INDEX IF NOT EXISTS ix_security_pen_test_finding_attrs ON security.pen_test_finding USING gin(attributes);

CREATE TABLE IF NOT EXISTS security.threat_model (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE security.threat_model IS 'Entidade de Seguranca e Compliance para ThreatModel.';
CREATE INDEX IF NOT EXISTS ix_security_threat_model_tenant ON security.threat_model(tenant_id);
CREATE INDEX IF NOT EXISTS ix_security_threat_model_user ON security.threat_model(user_id);
CREATE INDEX IF NOT EXISTS ix_security_threat_model_attrs ON security.threat_model USING gin(attributes);

CREATE TABLE IF NOT EXISTS security.abuse_report (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE security.abuse_report IS 'Entidade de Seguranca e Compliance para AbuseReport.';
CREATE INDEX IF NOT EXISTS ix_security_abuse_report_tenant ON security.abuse_report(tenant_id);
CREATE INDEX IF NOT EXISTS ix_security_abuse_report_user ON security.abuse_report(user_id);
CREATE INDEX IF NOT EXISTS ix_security_abuse_report_attrs ON security.abuse_report USING gin(attributes);

CREATE TABLE IF NOT EXISTS security.rate_limit_bucket (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE security.rate_limit_bucket IS 'Entidade de Seguranca e Compliance para RateLimitBucket.';
CREATE INDEX IF NOT EXISTS ix_security_rate_limit_bucket_tenant ON security.rate_limit_bucket(tenant_id);
CREATE INDEX IF NOT EXISTS ix_security_rate_limit_bucket_user ON security.rate_limit_bucket(user_id);
CREATE INDEX IF NOT EXISTS ix_security_rate_limit_bucket_attrs ON security.rate_limit_bucket USING gin(attributes);

CREATE TABLE IF NOT EXISTS security.ip_allowlist (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE security.ip_allowlist IS 'Entidade de Seguranca e Compliance para IpAllowlist.';
CREATE INDEX IF NOT EXISTS ix_security_ip_allowlist_tenant ON security.ip_allowlist(tenant_id);
CREATE INDEX IF NOT EXISTS ix_security_ip_allowlist_user ON security.ip_allowlist(user_id);
CREATE INDEX IF NOT EXISTS ix_security_ip_allowlist_attrs ON security.ip_allowlist USING gin(attributes);

CREATE TABLE IF NOT EXISTS security.data_export_job (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE security.data_export_job IS 'Entidade de Seguranca e Compliance para DataExportJob.';
CREATE INDEX IF NOT EXISTS ix_security_data_export_job_tenant ON security.data_export_job(tenant_id);
CREATE INDEX IF NOT EXISTS ix_security_data_export_job_user ON security.data_export_job(user_id);
CREATE INDEX IF NOT EXISTS ix_security_data_export_job_attrs ON security.data_export_job USING gin(attributes);

CREATE TABLE IF NOT EXISTS security.data_deletion_job (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE security.data_deletion_job IS 'Entidade de Seguranca e Compliance para DataDeletionJob.';
CREATE INDEX IF NOT EXISTS ix_security_data_deletion_job_tenant ON security.data_deletion_job(tenant_id);
CREATE INDEX IF NOT EXISTS ix_security_data_deletion_job_user ON security.data_deletion_job(user_id);
CREATE INDEX IF NOT EXISTS ix_security_data_deletion_job_attrs ON security.data_deletion_job USING gin(attributes);

CREATE TABLE IF NOT EXISTS security.legal_hold (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE security.legal_hold IS 'Entidade de Seguranca e Compliance para LegalHold.';
CREATE INDEX IF NOT EXISTS ix_security_legal_hold_tenant ON security.legal_hold(tenant_id);
CREATE INDEX IF NOT EXISTS ix_security_legal_hold_user ON security.legal_hold(user_id);
CREATE INDEX IF NOT EXISTS ix_security_legal_hold_attrs ON security.legal_hold USING gin(attributes);

CREATE TABLE IF NOT EXISTS security.dpa_agreement (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE security.dpa_agreement IS 'Entidade de Seguranca e Compliance para DpaAgreement.';
CREATE INDEX IF NOT EXISTS ix_security_dpa_agreement_tenant ON security.dpa_agreement(tenant_id);
CREATE INDEX IF NOT EXISTS ix_security_dpa_agreement_user ON security.dpa_agreement(user_id);
CREATE INDEX IF NOT EXISTS ix_security_dpa_agreement_attrs ON security.dpa_agreement USING gin(attributes);

CREATE TABLE IF NOT EXISTS security.baa_agreement (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE security.baa_agreement IS 'Entidade de Seguranca e Compliance para BaaAgreement.';
CREATE INDEX IF NOT EXISTS ix_security_baa_agreement_tenant ON security.baa_agreement(tenant_id);
CREATE INDEX IF NOT EXISTS ix_security_baa_agreement_user ON security.baa_agreement(user_id);
CREATE INDEX IF NOT EXISTS ix_security_baa_agreement_attrs ON security.baa_agreement USING gin(attributes);

CREATE TABLE IF NOT EXISTS security.subprocessor (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE security.subprocessor IS 'Entidade de Seguranca e Compliance para Subprocessor.';
CREATE INDEX IF NOT EXISTS ix_security_subprocessor_tenant ON security.subprocessor(tenant_id);
CREATE INDEX IF NOT EXISTS ix_security_subprocessor_user ON security.subprocessor(user_id);
CREATE INDEX IF NOT EXISTS ix_security_subprocessor_attrs ON security.subprocessor USING gin(attributes);

CREATE TABLE IF NOT EXISTS security.compliance_assessment (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE security.compliance_assessment IS 'Entidade de Seguranca e Compliance para ComplianceAssessment.';
CREATE INDEX IF NOT EXISTS ix_security_compliance_assessment_tenant ON security.compliance_assessment(tenant_id);
CREATE INDEX IF NOT EXISTS ix_security_compliance_assessment_user ON security.compliance_assessment(user_id);
CREATE INDEX IF NOT EXISTS ix_security_compliance_assessment_attrs ON security.compliance_assessment USING gin(attributes);

CREATE TABLE IF NOT EXISTS security.dpia_record (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE security.dpia_record IS 'Entidade de Seguranca e Compliance para DpiaRecord.';
CREATE INDEX IF NOT EXISTS ix_security_dpia_record_tenant ON security.dpia_record(tenant_id);
CREATE INDEX IF NOT EXISTS ix_security_dpia_record_user ON security.dpia_record(user_id);
CREATE INDEX IF NOT EXISTS ix_security_dpia_record_attrs ON security.dpia_record USING gin(attributes);

CREATE TABLE IF NOT EXISTS security.ro_pa_record (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE security.ro_pa_record IS 'Entidade de Seguranca e Compliance para RoPARecord.';
CREATE INDEX IF NOT EXISTS ix_security_ro_pa_record_tenant ON security.ro_pa_record(tenant_id);
CREATE INDEX IF NOT EXISTS ix_security_ro_pa_record_user ON security.ro_pa_record(user_id);
CREATE INDEX IF NOT EXISTS ix_security_ro_pa_record_attrs ON security.ro_pa_record USING gin(attributes);

CREATE TABLE IF NOT EXISTS security.consent_proof (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE security.consent_proof IS 'Entidade de Seguranca e Compliance para ConsentProof.';
CREATE INDEX IF NOT EXISTS ix_security_consent_proof_tenant ON security.consent_proof(tenant_id);
CREATE INDEX IF NOT EXISTS ix_security_consent_proof_user ON security.consent_proof(user_id);
CREATE INDEX IF NOT EXISTS ix_security_consent_proof_attrs ON security.consent_proof USING gin(attributes);

CREATE TABLE IF NOT EXISTS security.breach_notification (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE security.breach_notification IS 'Entidade de Seguranca e Compliance para BreachNotification.';
CREATE INDEX IF NOT EXISTS ix_security_breach_notification_tenant ON security.breach_notification(tenant_id);
CREATE INDEX IF NOT EXISTS ix_security_breach_notification_user ON security.breach_notification(user_id);
CREATE INDEX IF NOT EXISTS ix_security_breach_notification_attrs ON security.breach_notification USING gin(attributes);

CREATE TABLE IF NOT EXISTS security.data_transfer_assessment (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE security.data_transfer_assessment IS 'Entidade de Seguranca e Compliance para DataTransferAssessment.';
CREATE INDEX IF NOT EXISTS ix_security_data_transfer_assessment_tenant ON security.data_transfer_assessment(tenant_id);
CREATE INDEX IF NOT EXISTS ix_security_data_transfer_assessment_user ON security.data_transfer_assessment(user_id);
CREATE INDEX IF NOT EXISTS ix_security_data_transfer_assessment_attrs ON security.data_transfer_assessment USING gin(attributes);

CREATE TABLE IF NOT EXISTS communications.email_template (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE communications.email_template IS 'Entidade de Comunicacoes e Suporte para EmailTemplate.';
CREATE INDEX IF NOT EXISTS ix_communications_email_template_tenant ON communications.email_template(tenant_id);
CREATE INDEX IF NOT EXISTS ix_communications_email_template_user ON communications.email_template(user_id);
CREATE INDEX IF NOT EXISTS ix_communications_email_template_attrs ON communications.email_template USING gin(attributes);

CREATE TABLE IF NOT EXISTS communications.sms_template (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE communications.sms_template IS 'Entidade de Comunicacoes e Suporte para SmsTemplate.';
CREATE INDEX IF NOT EXISTS ix_communications_sms_template_tenant ON communications.sms_template(tenant_id);
CREATE INDEX IF NOT EXISTS ix_communications_sms_template_user ON communications.sms_template(user_id);
CREATE INDEX IF NOT EXISTS ix_communications_sms_template_attrs ON communications.sms_template USING gin(attributes);

CREATE TABLE IF NOT EXISTS communications.push_template (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE communications.push_template IS 'Entidade de Comunicacoes e Suporte para PushTemplate.';
CREATE INDEX IF NOT EXISTS ix_communications_push_template_tenant ON communications.push_template(tenant_id);
CREATE INDEX IF NOT EXISTS ix_communications_push_template_user ON communications.push_template(user_id);
CREATE INDEX IF NOT EXISTS ix_communications_push_template_attrs ON communications.push_template USING gin(attributes);

CREATE TABLE IF NOT EXISTS communications.message_campaign (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE communications.message_campaign IS 'Entidade de Comunicacoes e Suporte para MessageCampaign.';
CREATE INDEX IF NOT EXISTS ix_communications_message_campaign_tenant ON communications.message_campaign(tenant_id);
CREATE INDEX IF NOT EXISTS ix_communications_message_campaign_user ON communications.message_campaign(user_id);
CREATE INDEX IF NOT EXISTS ix_communications_message_campaign_attrs ON communications.message_campaign USING gin(attributes);

CREATE TABLE IF NOT EXISTS communications.campaign_audience (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE communications.campaign_audience IS 'Entidade de Comunicacoes e Suporte para CampaignAudience.';
CREATE INDEX IF NOT EXISTS ix_communications_campaign_audience_tenant ON communications.campaign_audience(tenant_id);
CREATE INDEX IF NOT EXISTS ix_communications_campaign_audience_user ON communications.campaign_audience(user_id);
CREATE INDEX IF NOT EXISTS ix_communications_campaign_audience_attrs ON communications.campaign_audience USING gin(attributes);

CREATE TABLE IF NOT EXISTS communications.delivery_attempt (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE communications.delivery_attempt IS 'Entidade de Comunicacoes e Suporte para DeliveryAttempt.';
CREATE INDEX IF NOT EXISTS ix_communications_delivery_attempt_tenant ON communications.delivery_attempt(tenant_id);
CREATE INDEX IF NOT EXISTS ix_communications_delivery_attempt_user ON communications.delivery_attempt(user_id);
CREATE INDEX IF NOT EXISTS ix_communications_delivery_attempt_attrs ON communications.delivery_attempt USING gin(attributes);

CREATE TABLE IF NOT EXISTS communications.inbox_message (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE communications.inbox_message IS 'Entidade de Comunicacoes e Suporte para InboxMessage.';
CREATE INDEX IF NOT EXISTS ix_communications_inbox_message_tenant ON communications.inbox_message(tenant_id);
CREATE INDEX IF NOT EXISTS ix_communications_inbox_message_user ON communications.inbox_message(user_id);
CREATE INDEX IF NOT EXISTS ix_communications_inbox_message_attrs ON communications.inbox_message USING gin(attributes);

CREATE TABLE IF NOT EXISTS communications.support_ticket (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE communications.support_ticket IS 'Entidade de Comunicacoes e Suporte para SupportTicket.';
CREATE INDEX IF NOT EXISTS ix_communications_support_ticket_tenant ON communications.support_ticket(tenant_id);
CREATE INDEX IF NOT EXISTS ix_communications_support_ticket_user ON communications.support_ticket(user_id);
CREATE INDEX IF NOT EXISTS ix_communications_support_ticket_attrs ON communications.support_ticket USING gin(attributes);

CREATE TABLE IF NOT EXISTS communications.support_comment (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE communications.support_comment IS 'Entidade de Comunicacoes e Suporte para SupportComment.';
CREATE INDEX IF NOT EXISTS ix_communications_support_comment_tenant ON communications.support_comment(tenant_id);
CREATE INDEX IF NOT EXISTS ix_communications_support_comment_user ON communications.support_comment(user_id);
CREATE INDEX IF NOT EXISTS ix_communications_support_comment_attrs ON communications.support_comment USING gin(attributes);

CREATE TABLE IF NOT EXISTS communications.knowledge_base_article (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE communications.knowledge_base_article IS 'Entidade de Comunicacoes e Suporte para KnowledgeBaseArticle.';
CREATE INDEX IF NOT EXISTS ix_communications_knowledge_base_article_tenant ON communications.knowledge_base_article(tenant_id);
CREATE INDEX IF NOT EXISTS ix_communications_knowledge_base_article_user ON communications.knowledge_base_article(user_id);
CREATE INDEX IF NOT EXISTS ix_communications_knowledge_base_article_attrs ON communications.knowledge_base_article USING gin(attributes);

CREATE TABLE IF NOT EXISTS communications.faq_item (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE communications.faq_item IS 'Entidade de Comunicacoes e Suporte para FaqItem.';
CREATE INDEX IF NOT EXISTS ix_communications_faq_item_tenant ON communications.faq_item(tenant_id);
CREATE INDEX IF NOT EXISTS ix_communications_faq_item_user ON communications.faq_item(user_id);
CREATE INDEX IF NOT EXISTS ix_communications_faq_item_attrs ON communications.faq_item USING gin(attributes);

CREATE TABLE IF NOT EXISTS communications.nps_survey (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE communications.nps_survey IS 'Entidade de Comunicacoes e Suporte para NpsSurvey.';
CREATE INDEX IF NOT EXISTS ix_communications_nps_survey_tenant ON communications.nps_survey(tenant_id);
CREATE INDEX IF NOT EXISTS ix_communications_nps_survey_user ON communications.nps_survey(user_id);
CREATE INDEX IF NOT EXISTS ix_communications_nps_survey_attrs ON communications.nps_survey USING gin(attributes);

CREATE TABLE IF NOT EXISTS communications.survey_response (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE communications.survey_response IS 'Entidade de Comunicacoes e Suporte para SurveyResponse.';
CREATE INDEX IF NOT EXISTS ix_communications_survey_response_tenant ON communications.survey_response(tenant_id);
CREATE INDEX IF NOT EXISTS ix_communications_survey_response_user ON communications.survey_response(user_id);
CREATE INDEX IF NOT EXISTS ix_communications_survey_response_attrs ON communications.survey_response USING gin(attributes);

CREATE TABLE IF NOT EXISTS communications.announcement (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE communications.announcement IS 'Entidade de Comunicacoes e Suporte para Announcement.';
CREATE INDEX IF NOT EXISTS ix_communications_announcement_tenant ON communications.announcement(tenant_id);
CREATE INDEX IF NOT EXISTS ix_communications_announcement_user ON communications.announcement(user_id);
CREATE INDEX IF NOT EXISTS ix_communications_announcement_attrs ON communications.announcement USING gin(attributes);

CREATE TABLE IF NOT EXISTS communications.release_communication (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE communications.release_communication IS 'Entidade de Comunicacoes e Suporte para ReleaseCommunication.';
CREATE INDEX IF NOT EXISTS ix_communications_release_communication_tenant ON communications.release_communication(tenant_id);
CREATE INDEX IF NOT EXISTS ix_communications_release_communication_user ON communications.release_communication(user_id);
CREATE INDEX IF NOT EXISTS ix_communications_release_communication_attrs ON communications.release_communication USING gin(attributes);

CREATE TABLE IF NOT EXISTS communications.moderation_message (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE communications.moderation_message IS 'Entidade de Comunicacoes e Suporte para ModerationMessage.';
CREATE INDEX IF NOT EXISTS ix_communications_moderation_message_tenant ON communications.moderation_message(tenant_id);
CREATE INDEX IF NOT EXISTS ix_communications_moderation_message_user ON communications.moderation_message(user_id);
CREATE INDEX IF NOT EXISTS ix_communications_moderation_message_attrs ON communications.moderation_message USING gin(attributes);

CREATE TABLE IF NOT EXISTS communications.user_feedback (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE communications.user_feedback IS 'Entidade de Comunicacoes e Suporte para UserFeedback.';
CREATE INDEX IF NOT EXISTS ix_communications_user_feedback_tenant ON communications.user_feedback(tenant_id);
CREATE INDEX IF NOT EXISTS ix_communications_user_feedback_user ON communications.user_feedback(user_id);
CREATE INDEX IF NOT EXISTS ix_communications_user_feedback_attrs ON communications.user_feedback USING gin(attributes);

CREATE TABLE IF NOT EXISTS communications.bug_report (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE communications.bug_report IS 'Entidade de Comunicacoes e Suporte para BugReport.';
CREATE INDEX IF NOT EXISTS ix_communications_bug_report_tenant ON communications.bug_report(tenant_id);
CREATE INDEX IF NOT EXISTS ix_communications_bug_report_user ON communications.bug_report(user_id);
CREATE INDEX IF NOT EXISTS ix_communications_bug_report_attrs ON communications.bug_report USING gin(attributes);

CREATE TABLE IF NOT EXISTS communications.feature_request (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE communications.feature_request IS 'Entidade de Comunicacoes e Suporte para FeatureRequest.';
CREATE INDEX IF NOT EXISTS ix_communications_feature_request_tenant ON communications.feature_request(tenant_id);
CREATE INDEX IF NOT EXISTS ix_communications_feature_request_user ON communications.feature_request(user_id);
CREATE INDEX IF NOT EXISTS ix_communications_feature_request_attrs ON communications.feature_request USING gin(attributes);

CREATE TABLE IF NOT EXISTS communications.contact_preference (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE communications.contact_preference IS 'Entidade de Comunicacoes e Suporte para ContactPreference.';
CREATE INDEX IF NOT EXISTS ix_communications_contact_preference_tenant ON communications.contact_preference(tenant_id);
CREATE INDEX IF NOT EXISTS ix_communications_contact_preference_user ON communications.contact_preference(user_id);
CREATE INDEX IF NOT EXISTS ix_communications_contact_preference_attrs ON communications.contact_preference USING gin(attributes);

CREATE TABLE IF NOT EXISTS content.content_item (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE content.content_item IS 'Entidade de Content Platform para ContentItem.';
CREATE INDEX IF NOT EXISTS ix_content_content_item_tenant ON content.content_item(tenant_id);
CREATE INDEX IF NOT EXISTS ix_content_content_item_user ON content.content_item(user_id);
CREATE INDEX IF NOT EXISTS ix_content_content_item_attrs ON content.content_item USING gin(attributes);

CREATE TABLE IF NOT EXISTS content.content_collection (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE content.content_collection IS 'Entidade de Content Platform para ContentCollection.';
CREATE INDEX IF NOT EXISTS ix_content_content_collection_tenant ON content.content_collection(tenant_id);
CREATE INDEX IF NOT EXISTS ix_content_content_collection_user ON content.content_collection(user_id);
CREATE INDEX IF NOT EXISTS ix_content_content_collection_attrs ON content.content_collection USING gin(attributes);

CREATE TABLE IF NOT EXISTS content.lesson (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE content.lesson IS 'Entidade de Content Platform para Lesson.';
CREATE INDEX IF NOT EXISTS ix_content_lesson_tenant ON content.lesson(tenant_id);
CREATE INDEX IF NOT EXISTS ix_content_lesson_user ON content.lesson(user_id);
CREATE INDEX IF NOT EXISTS ix_content_lesson_attrs ON content.lesson USING gin(attributes);

CREATE TABLE IF NOT EXISTS content.lesson_block (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE content.lesson_block IS 'Entidade de Content Platform para LessonBlock.';
CREATE INDEX IF NOT EXISTS ix_content_lesson_block_tenant ON content.lesson_block(tenant_id);
CREATE INDEX IF NOT EXISTS ix_content_lesson_block_user ON content.lesson_block(user_id);
CREATE INDEX IF NOT EXISTS ix_content_lesson_block_attrs ON content.lesson_block USING gin(attributes);

CREATE TABLE IF NOT EXISTS content.media_asset (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE content.media_asset IS 'Entidade de Content Platform para MediaAsset.';
CREATE INDEX IF NOT EXISTS ix_content_media_asset_tenant ON content.media_asset(tenant_id);
CREATE INDEX IF NOT EXISTS ix_content_media_asset_user ON content.media_asset(user_id);
CREATE INDEX IF NOT EXISTS ix_content_media_asset_attrs ON content.media_asset USING gin(attributes);

CREATE TABLE IF NOT EXISTS content.audio_track (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE content.audio_track IS 'Entidade de Content Platform para AudioTrack.';
CREATE INDEX IF NOT EXISTS ix_content_audio_track_tenant ON content.audio_track(tenant_id);
CREATE INDEX IF NOT EXISTS ix_content_audio_track_user ON content.audio_track(user_id);
CREATE INDEX IF NOT EXISTS ix_content_audio_track_attrs ON content.audio_track USING gin(attributes);

CREATE TABLE IF NOT EXISTS content.video_asset (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE content.video_asset IS 'Entidade de Content Platform para VideoAsset.';
CREATE INDEX IF NOT EXISTS ix_content_video_asset_tenant ON content.video_asset(tenant_id);
CREATE INDEX IF NOT EXISTS ix_content_video_asset_user ON content.video_asset(user_id);
CREATE INDEX IF NOT EXISTS ix_content_video_asset_attrs ON content.video_asset USING gin(attributes);

CREATE TABLE IF NOT EXISTS content.image_asset (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE content.image_asset IS 'Entidade de Content Platform para ImageAsset.';
CREATE INDEX IF NOT EXISTS ix_content_image_asset_tenant ON content.image_asset(tenant_id);
CREATE INDEX IF NOT EXISTS ix_content_image_asset_user ON content.image_asset(user_id);
CREATE INDEX IF NOT EXISTS ix_content_image_asset_attrs ON content.image_asset USING gin(attributes);

CREATE TABLE IF NOT EXISTS content.document_asset (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE content.document_asset IS 'Entidade de Content Platform para DocumentAsset.';
CREATE INDEX IF NOT EXISTS ix_content_document_asset_tenant ON content.document_asset(tenant_id);
CREATE INDEX IF NOT EXISTS ix_content_document_asset_user ON content.document_asset(user_id);
CREATE INDEX IF NOT EXISTS ix_content_document_asset_attrs ON content.document_asset USING gin(attributes);

CREATE TABLE IF NOT EXISTS content.content_tag (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE content.content_tag IS 'Entidade de Content Platform para ContentTag.';
CREATE INDEX IF NOT EXISTS ix_content_content_tag_tenant ON content.content_tag(tenant_id);
CREATE INDEX IF NOT EXISTS ix_content_content_tag_user ON content.content_tag(user_id);
CREATE INDEX IF NOT EXISTS ix_content_content_tag_attrs ON content.content_tag USING gin(attributes);

CREATE TABLE IF NOT EXISTS content.content_version (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE content.content_version IS 'Entidade de Content Platform para ContentVersion.';
CREATE INDEX IF NOT EXISTS ix_content_content_version_tenant ON content.content_version(tenant_id);
CREATE INDEX IF NOT EXISTS ix_content_content_version_user ON content.content_version(user_id);
CREATE INDEX IF NOT EXISTS ix_content_content_version_attrs ON content.content_version USING gin(attributes);

CREATE TABLE IF NOT EXISTS content.content_approval (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE content.content_approval IS 'Entidade de Content Platform para ContentApproval.';
CREATE INDEX IF NOT EXISTS ix_content_content_approval_tenant ON content.content_approval(tenant_id);
CREATE INDEX IF NOT EXISTS ix_content_content_approval_user ON content.content_approval(user_id);
CREATE INDEX IF NOT EXISTS ix_content_content_approval_attrs ON content.content_approval USING gin(attributes);

CREATE TABLE IF NOT EXISTS content.localization_string (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE content.localization_string IS 'Entidade de Content Platform para LocalizationString.';
CREATE INDEX IF NOT EXISTS ix_content_localization_string_tenant ON content.localization_string(tenant_id);
CREATE INDEX IF NOT EXISTS ix_content_localization_string_user ON content.localization_string(user_id);
CREATE INDEX IF NOT EXISTS ix_content_localization_string_attrs ON content.localization_string USING gin(attributes);

CREATE TABLE IF NOT EXISTS content.translation_job (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE content.translation_job IS 'Entidade de Content Platform para TranslationJob.';
CREATE INDEX IF NOT EXISTS ix_content_translation_job_tenant ON content.translation_job(tenant_id);
CREATE INDEX IF NOT EXISTS ix_content_translation_job_user ON content.translation_job(user_id);
CREATE INDEX IF NOT EXISTS ix_content_translation_job_attrs ON content.translation_job USING gin(attributes);

CREATE TABLE IF NOT EXISTS content.editorial_calendar (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE content.editorial_calendar IS 'Entidade de Content Platform para EditorialCalendar.';
CREATE INDEX IF NOT EXISTS ix_content_editorial_calendar_tenant ON content.editorial_calendar(tenant_id);
CREATE INDEX IF NOT EXISTS ix_content_editorial_calendar_user ON content.editorial_calendar(user_id);
CREATE INDEX IF NOT EXISTS ix_content_editorial_calendar_attrs ON content.editorial_calendar USING gin(attributes);

CREATE TABLE IF NOT EXISTS content.content_license (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE content.content_license IS 'Entidade de Content Platform para ContentLicense.';
CREATE INDEX IF NOT EXISTS ix_content_content_license_tenant ON content.content_license(tenant_id);
CREATE INDEX IF NOT EXISTS ix_content_content_license_user ON content.content_license(user_id);
CREATE INDEX IF NOT EXISTS ix_content_content_license_attrs ON content.content_license USING gin(attributes);

CREATE TABLE IF NOT EXISTS content.exercise_video (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE content.exercise_video IS 'Entidade de Content Platform para ExerciseVideo.';
CREATE INDEX IF NOT EXISTS ix_content_exercise_video_tenant ON content.exercise_video(tenant_id);
CREATE INDEX IF NOT EXISTS ix_content_exercise_video_user ON content.exercise_video(user_id);
CREATE INDEX IF NOT EXISTS ix_content_exercise_video_attrs ON content.exercise_video USING gin(attributes);

CREATE TABLE IF NOT EXISTS content.nutrition_article (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE content.nutrition_article IS 'Entidade de Content Platform para NutritionArticle.';
CREATE INDEX IF NOT EXISTS ix_content_nutrition_article_tenant ON content.nutrition_article(tenant_id);
CREATE INDEX IF NOT EXISTS ix_content_nutrition_article_user ON content.nutrition_article(user_id);
CREATE INDEX IF NOT EXISTS ix_content_nutrition_article_attrs ON content.nutrition_article USING gin(attributes);

CREATE TABLE IF NOT EXISTS content.medical_education_card (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE content.medical_education_card IS 'Entidade de Content Platform para MedicalEducationCard.';
CREATE INDEX IF NOT EXISTS ix_content_medical_education_card_tenant ON content.medical_education_card(tenant_id);
CREATE INDEX IF NOT EXISTS ix_content_medical_education_card_user ON content.medical_education_card(user_id);
CREATE INDEX IF NOT EXISTS ix_content_medical_education_card_attrs ON content.medical_education_card USING gin(attributes);

CREATE TABLE IF NOT EXISTS content.safety_notice (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE content.safety_notice IS 'Entidade de Content Platform para SafetyNotice.';
CREATE INDEX IF NOT EXISTS ix_content_safety_notice_tenant ON content.safety_notice(tenant_id);
CREATE INDEX IF NOT EXISTS ix_content_safety_notice_user ON content.safety_notice(user_id);
CREATE INDEX IF NOT EXISTS ix_content_safety_notice_attrs ON content.safety_notice USING gin(attributes);

CREATE TABLE IF NOT EXISTS analytics.event_stream (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE analytics.event_stream IS 'Entidade de Analytics Platform para EventStream.';
CREATE INDEX IF NOT EXISTS ix_analytics_event_stream_tenant ON analytics.event_stream(tenant_id);
CREATE INDEX IF NOT EXISTS ix_analytics_event_stream_user ON analytics.event_stream(user_id);
CREATE INDEX IF NOT EXISTS ix_analytics_event_stream_attrs ON analytics.event_stream USING gin(attributes);

CREATE TABLE IF NOT EXISTS analytics.product_event (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE analytics.product_event IS 'Entidade de Analytics Platform para ProductEvent.';
CREATE INDEX IF NOT EXISTS ix_analytics_product_event_tenant ON analytics.product_event(tenant_id);
CREATE INDEX IF NOT EXISTS ix_analytics_product_event_user ON analytics.product_event(user_id);
CREATE INDEX IF NOT EXISTS ix_analytics_product_event_attrs ON analytics.product_event USING gin(attributes);

CREATE TABLE IF NOT EXISTS analytics.feature_usage_daily (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE analytics.feature_usage_daily IS 'Entidade de Analytics Platform para FeatureUsageDaily.';
CREATE INDEX IF NOT EXISTS ix_analytics_feature_usage_daily_tenant ON analytics.feature_usage_daily(tenant_id);
CREATE INDEX IF NOT EXISTS ix_analytics_feature_usage_daily_user ON analytics.feature_usage_daily(user_id);
CREATE INDEX IF NOT EXISTS ix_analytics_feature_usage_daily_attrs ON analytics.feature_usage_daily USING gin(attributes);

CREATE TABLE IF NOT EXISTS analytics.user_cohort (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE analytics.user_cohort IS 'Entidade de Analytics Platform para UserCohort.';
CREATE INDEX IF NOT EXISTS ix_analytics_user_cohort_tenant ON analytics.user_cohort(tenant_id);
CREATE INDEX IF NOT EXISTS ix_analytics_user_cohort_user ON analytics.user_cohort(user_id);
CREATE INDEX IF NOT EXISTS ix_analytics_user_cohort_attrs ON analytics.user_cohort USING gin(attributes);

CREATE TABLE IF NOT EXISTS analytics.retention_metric (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE analytics.retention_metric IS 'Entidade de Analytics Platform para RetentionMetric.';
CREATE INDEX IF NOT EXISTS ix_analytics_retention_metric_tenant ON analytics.retention_metric(tenant_id);
CREATE INDEX IF NOT EXISTS ix_analytics_retention_metric_user ON analytics.retention_metric(user_id);
CREATE INDEX IF NOT EXISTS ix_analytics_retention_metric_attrs ON analytics.retention_metric USING gin(attributes);

CREATE TABLE IF NOT EXISTS analytics.activation_metric (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE analytics.activation_metric IS 'Entidade de Analytics Platform para ActivationMetric.';
CREATE INDEX IF NOT EXISTS ix_analytics_activation_metric_tenant ON analytics.activation_metric(tenant_id);
CREATE INDEX IF NOT EXISTS ix_analytics_activation_metric_user ON analytics.activation_metric(user_id);
CREATE INDEX IF NOT EXISTS ix_analytics_activation_metric_attrs ON analytics.activation_metric USING gin(attributes);

CREATE TABLE IF NOT EXISTS analytics.conversion_funnel (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE analytics.conversion_funnel IS 'Entidade de Analytics Platform para ConversionFunnel.';
CREATE INDEX IF NOT EXISTS ix_analytics_conversion_funnel_tenant ON analytics.conversion_funnel(tenant_id);
CREATE INDEX IF NOT EXISTS ix_analytics_conversion_funnel_user ON analytics.conversion_funnel(user_id);
CREATE INDEX IF NOT EXISTS ix_analytics_conversion_funnel_attrs ON analytics.conversion_funnel USING gin(attributes);

CREATE TABLE IF NOT EXISTS analytics.experiment (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE analytics.experiment IS 'Entidade de Analytics Platform para Experiment.';
CREATE INDEX IF NOT EXISTS ix_analytics_experiment_tenant ON analytics.experiment(tenant_id);
CREATE INDEX IF NOT EXISTS ix_analytics_experiment_user ON analytics.experiment(user_id);
CREATE INDEX IF NOT EXISTS ix_analytics_experiment_attrs ON analytics.experiment USING gin(attributes);

CREATE TABLE IF NOT EXISTS analytics.experiment_variant (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE analytics.experiment_variant IS 'Entidade de Analytics Platform para ExperimentVariant.';
CREATE INDEX IF NOT EXISTS ix_analytics_experiment_variant_tenant ON analytics.experiment_variant(tenant_id);
CREATE INDEX IF NOT EXISTS ix_analytics_experiment_variant_user ON analytics.experiment_variant(user_id);
CREATE INDEX IF NOT EXISTS ix_analytics_experiment_variant_attrs ON analytics.experiment_variant USING gin(attributes);

CREATE TABLE IF NOT EXISTS analytics.experiment_assignment (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE analytics.experiment_assignment IS 'Entidade de Analytics Platform para ExperimentAssignment.';
CREATE INDEX IF NOT EXISTS ix_analytics_experiment_assignment_tenant ON analytics.experiment_assignment(tenant_id);
CREATE INDEX IF NOT EXISTS ix_analytics_experiment_assignment_user ON analytics.experiment_assignment(user_id);
CREATE INDEX IF NOT EXISTS ix_analytics_experiment_assignment_attrs ON analytics.experiment_assignment USING gin(attributes);

CREATE TABLE IF NOT EXISTS analytics.experiment_result (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE analytics.experiment_result IS 'Entidade de Analytics Platform para ExperimentResult.';
CREATE INDEX IF NOT EXISTS ix_analytics_experiment_result_tenant ON analytics.experiment_result(tenant_id);
CREATE INDEX IF NOT EXISTS ix_analytics_experiment_result_user ON analytics.experiment_result(user_id);
CREATE INDEX IF NOT EXISTS ix_analytics_experiment_result_attrs ON analytics.experiment_result USING gin(attributes);

CREATE TABLE IF NOT EXISTS analytics.model_feature (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE analytics.model_feature IS 'Entidade de Analytics Platform para ModelFeature.';
CREATE INDEX IF NOT EXISTS ix_analytics_model_feature_tenant ON analytics.model_feature(tenant_id);
CREATE INDEX IF NOT EXISTS ix_analytics_model_feature_user ON analytics.model_feature(user_id);
CREATE INDEX IF NOT EXISTS ix_analytics_model_feature_attrs ON analytics.model_feature USING gin(attributes);

CREATE TABLE IF NOT EXISTS analytics.training_dataset (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE analytics.training_dataset IS 'Entidade de Analytics Platform para TrainingDataset.';
CREATE INDEX IF NOT EXISTS ix_analytics_training_dataset_tenant ON analytics.training_dataset(tenant_id);
CREATE INDEX IF NOT EXISTS ix_analytics_training_dataset_user ON analytics.training_dataset(user_id);
CREATE INDEX IF NOT EXISTS ix_analytics_training_dataset_attrs ON analytics.training_dataset USING gin(attributes);

CREATE TABLE IF NOT EXISTS analytics.prediction_record (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE analytics.prediction_record IS 'Entidade de Analytics Platform para PredictionRecord.';
CREATE INDEX IF NOT EXISTS ix_analytics_prediction_record_tenant ON analytics.prediction_record(tenant_id);
CREATE INDEX IF NOT EXISTS ix_analytics_prediction_record_user ON analytics.prediction_record(user_id);
CREATE INDEX IF NOT EXISTS ix_analytics_prediction_record_attrs ON analytics.prediction_record USING gin(attributes);

CREATE TABLE IF NOT EXISTS analytics.churn_score (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE analytics.churn_score IS 'Entidade de Analytics Platform para ChurnScore.';
CREATE INDEX IF NOT EXISTS ix_analytics_churn_score_tenant ON analytics.churn_score(tenant_id);
CREATE INDEX IF NOT EXISTS ix_analytics_churn_score_user ON analytics.churn_score(user_id);
CREATE INDEX IF NOT EXISTS ix_analytics_churn_score_attrs ON analytics.churn_score USING gin(attributes);

CREATE TABLE IF NOT EXISTS analytics.adherence_prediction (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE analytics.adherence_prediction IS 'Entidade de Analytics Platform para AdherencePrediction.';
CREATE INDEX IF NOT EXISTS ix_analytics_adherence_prediction_tenant ON analytics.adherence_prediction(tenant_id);
CREATE INDEX IF NOT EXISTS ix_analytics_adherence_prediction_user ON analytics.adherence_prediction(user_id);
CREATE INDEX IF NOT EXISTS ix_analytics_adherence_prediction_attrs ON analytics.adherence_prediction USING gin(attributes);

CREATE TABLE IF NOT EXISTS analytics.revenue_metric (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE analytics.revenue_metric IS 'Entidade de Analytics Platform para RevenueMetric.';
CREATE INDEX IF NOT EXISTS ix_analytics_revenue_metric_tenant ON analytics.revenue_metric(tenant_id);
CREATE INDEX IF NOT EXISTS ix_analytics_revenue_metric_user ON analytics.revenue_metric(user_id);
CREATE INDEX IF NOT EXISTS ix_analytics_revenue_metric_attrs ON analytics.revenue_metric USING gin(attributes);

CREATE TABLE IF NOT EXISTS analytics.clinical_safety_metric (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE analytics.clinical_safety_metric IS 'Entidade de Analytics Platform para ClinicalSafetyMetric.';
CREATE INDEX IF NOT EXISTS ix_analytics_clinical_safety_metric_tenant ON analytics.clinical_safety_metric(tenant_id);
CREATE INDEX IF NOT EXISTS ix_analytics_clinical_safety_metric_user ON analytics.clinical_safety_metric(user_id);
CREATE INDEX IF NOT EXISTS ix_analytics_clinical_safety_metric_attrs ON analytics.clinical_safety_metric USING gin(attributes);

CREATE TABLE IF NOT EXISTS analytics.data_quality_check (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE analytics.data_quality_check IS 'Entidade de Analytics Platform para DataQualityCheck.';
CREATE INDEX IF NOT EXISTS ix_analytics_data_quality_check_tenant ON analytics.data_quality_check(tenant_id);
CREATE INDEX IF NOT EXISTS ix_analytics_data_quality_check_user ON analytics.data_quality_check(user_id);
CREATE INDEX IF NOT EXISTS ix_analytics_data_quality_check_attrs ON analytics.data_quality_check USING gin(attributes);

CREATE TABLE IF NOT EXISTS analytics.data_quality_issue (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE analytics.data_quality_issue IS 'Entidade de Analytics Platform para DataQualityIssue.';
CREATE INDEX IF NOT EXISTS ix_analytics_data_quality_issue_tenant ON analytics.data_quality_issue(tenant_id);
CREATE INDEX IF NOT EXISTS ix_analytics_data_quality_issue_user ON analytics.data_quality_issue(user_id);
CREATE INDEX IF NOT EXISTS ix_analytics_data_quality_issue_attrs ON analytics.data_quality_issue USING gin(attributes);

CREATE TABLE IF NOT EXISTS analytics.warehouse_snapshot (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE analytics.warehouse_snapshot IS 'Entidade de Analytics Platform para WarehouseSnapshot.';
CREATE INDEX IF NOT EXISTS ix_analytics_warehouse_snapshot_tenant ON analytics.warehouse_snapshot(tenant_id);
CREATE INDEX IF NOT EXISTS ix_analytics_warehouse_snapshot_user ON analytics.warehouse_snapshot(user_id);
CREATE INDEX IF NOT EXISTS ix_analytics_warehouse_snapshot_attrs ON analytics.warehouse_snapshot USING gin(attributes);

CREATE TABLE IF NOT EXISTS analytics.anonymized_dataset (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE analytics.anonymized_dataset IS 'Entidade de Analytics Platform para AnonymizedDataset.';
CREATE INDEX IF NOT EXISTS ix_analytics_anonymized_dataset_tenant ON analytics.anonymized_dataset(tenant_id);
CREATE INDEX IF NOT EXISTS ix_analytics_anonymized_dataset_user ON analytics.anonymized_dataset(user_id);
CREATE INDEX IF NOT EXISTS ix_analytics_anonymized_dataset_attrs ON analytics.anonymized_dataset USING gin(attributes);

CREATE TABLE IF NOT EXISTS analytics.cohort_report (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE analytics.cohort_report IS 'Entidade de Analytics Platform para CohortReport.';
CREATE INDEX IF NOT EXISTS ix_analytics_cohort_report_tenant ON analytics.cohort_report(tenant_id);
CREATE INDEX IF NOT EXISTS ix_analytics_cohort_report_user ON analytics.cohort_report(user_id);
CREATE INDEX IF NOT EXISTS ix_analytics_cohort_report_attrs ON analytics.cohort_report USING gin(attributes);

CREATE TABLE IF NOT EXISTS analytics.business_kpi (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE analytics.business_kpi IS 'Entidade de Analytics Platform para BusinessKpi.';
CREATE INDEX IF NOT EXISTS ix_analytics_business_kpi_tenant ON analytics.business_kpi(tenant_id);
CREATE INDEX IF NOT EXISTS ix_analytics_business_kpi_user ON analytics.business_kpi(user_id);
CREATE INDEX IF NOT EXISTS ix_analytics_business_kpi_attrs ON analytics.business_kpi USING gin(attributes);

CREATE TABLE IF NOT EXISTS analytics.north_star_metric (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'derived_confidential',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE analytics.north_star_metric IS 'Entidade de Analytics Platform para NorthStarMetric.';
CREATE INDEX IF NOT EXISTS ix_analytics_north_star_metric_tenant ON analytics.north_star_metric(tenant_id);
CREATE INDEX IF NOT EXISTS ix_analytics_north_star_metric_user ON analytics.north_star_metric(user_id);
CREATE INDEX IF NOT EXISTS ix_analytics_north_star_metric_attrs ON analytics.north_star_metric USING gin(attributes);

CREATE TABLE IF NOT EXISTS integrations.integration_provider (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE integrations.integration_provider IS 'Entidade de Integration Platform para IntegrationProvider.';
CREATE INDEX IF NOT EXISTS ix_integrations_integration_provider_tenant ON integrations.integration_provider(tenant_id);
CREATE INDEX IF NOT EXISTS ix_integrations_integration_provider_user ON integrations.integration_provider(user_id);
CREATE INDEX IF NOT EXISTS ix_integrations_integration_provider_attrs ON integrations.integration_provider USING gin(attributes);

CREATE TABLE IF NOT EXISTS integrations.integration_connection (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE integrations.integration_connection IS 'Entidade de Integration Platform para IntegrationConnection.';
CREATE INDEX IF NOT EXISTS ix_integrations_integration_connection_tenant ON integrations.integration_connection(tenant_id);
CREATE INDEX IF NOT EXISTS ix_integrations_integration_connection_user ON integrations.integration_connection(user_id);
CREATE INDEX IF NOT EXISTS ix_integrations_integration_connection_attrs ON integrations.integration_connection USING gin(attributes);

CREATE TABLE IF NOT EXISTS integrations.oauth_credential (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE integrations.oauth_credential IS 'Entidade de Integration Platform para OauthCredential.';
CREATE INDEX IF NOT EXISTS ix_integrations_oauth_credential_tenant ON integrations.oauth_credential(tenant_id);
CREATE INDEX IF NOT EXISTS ix_integrations_oauth_credential_user ON integrations.oauth_credential(user_id);
CREATE INDEX IF NOT EXISTS ix_integrations_oauth_credential_attrs ON integrations.oauth_credential USING gin(attributes);

CREATE TABLE IF NOT EXISTS integrations.webhook_endpoint (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE integrations.webhook_endpoint IS 'Entidade de Integration Platform para WebhookEndpoint.';
CREATE INDEX IF NOT EXISTS ix_integrations_webhook_endpoint_tenant ON integrations.webhook_endpoint(tenant_id);
CREATE INDEX IF NOT EXISTS ix_integrations_webhook_endpoint_user ON integrations.webhook_endpoint(user_id);
CREATE INDEX IF NOT EXISTS ix_integrations_webhook_endpoint_attrs ON integrations.webhook_endpoint USING gin(attributes);

CREATE TABLE IF NOT EXISTS integrations.webhook_delivery (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE integrations.webhook_delivery IS 'Entidade de Integration Platform para WebhookDelivery.';
CREATE INDEX IF NOT EXISTS ix_integrations_webhook_delivery_tenant ON integrations.webhook_delivery(tenant_id);
CREATE INDEX IF NOT EXISTS ix_integrations_webhook_delivery_user ON integrations.webhook_delivery(user_id);
CREATE INDEX IF NOT EXISTS ix_integrations_webhook_delivery_attrs ON integrations.webhook_delivery USING gin(attributes);

CREATE TABLE IF NOT EXISTS integrations.import_job (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE integrations.import_job IS 'Entidade de Integration Platform para ImportJob.';
CREATE INDEX IF NOT EXISTS ix_integrations_import_job_tenant ON integrations.import_job(tenant_id);
CREATE INDEX IF NOT EXISTS ix_integrations_import_job_user ON integrations.import_job(user_id);
CREATE INDEX IF NOT EXISTS ix_integrations_import_job_attrs ON integrations.import_job USING gin(attributes);

CREATE TABLE IF NOT EXISTS integrations.export_job (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE integrations.export_job IS 'Entidade de Integration Platform para ExportJob.';
CREATE INDEX IF NOT EXISTS ix_integrations_export_job_tenant ON integrations.export_job(tenant_id);
CREATE INDEX IF NOT EXISTS ix_integrations_export_job_user ON integrations.export_job(user_id);
CREATE INDEX IF NOT EXISTS ix_integrations_export_job_attrs ON integrations.export_job USING gin(attributes);

CREATE TABLE IF NOT EXISTS integrations.sync_cursor (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE integrations.sync_cursor IS 'Entidade de Integration Platform para SyncCursor.';
CREATE INDEX IF NOT EXISTS ix_integrations_sync_cursor_tenant ON integrations.sync_cursor(tenant_id);
CREATE INDEX IF NOT EXISTS ix_integrations_sync_cursor_user ON integrations.sync_cursor(user_id);
CREATE INDEX IF NOT EXISTS ix_integrations_sync_cursor_attrs ON integrations.sync_cursor USING gin(attributes);

CREATE TABLE IF NOT EXISTS integrations.sync_error (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE integrations.sync_error IS 'Entidade de Integration Platform para SyncError.';
CREATE INDEX IF NOT EXISTS ix_integrations_sync_error_tenant ON integrations.sync_error(tenant_id);
CREATE INDEX IF NOT EXISTS ix_integrations_sync_error_user ON integrations.sync_error(user_id);
CREATE INDEX IF NOT EXISTS ix_integrations_sync_error_attrs ON integrations.sync_error USING gin(attributes);

CREATE TABLE IF NOT EXISTS integrations.wearable_device (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE integrations.wearable_device IS 'Entidade de Integration Platform para WearableDevice.';
CREATE INDEX IF NOT EXISTS ix_integrations_wearable_device_tenant ON integrations.wearable_device(tenant_id);
CREATE INDEX IF NOT EXISTS ix_integrations_wearable_device_user ON integrations.wearable_device(user_id);
CREATE INDEX IF NOT EXISTS ix_integrations_wearable_device_attrs ON integrations.wearable_device USING gin(attributes);

CREATE TABLE IF NOT EXISTS integrations.health_kit_sample (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE integrations.health_kit_sample IS 'Entidade de Integration Platform para HealthKitSample.';
CREATE INDEX IF NOT EXISTS ix_integrations_health_kit_sample_tenant ON integrations.health_kit_sample(tenant_id);
CREATE INDEX IF NOT EXISTS ix_integrations_health_kit_sample_user ON integrations.health_kit_sample(user_id);
CREATE INDEX IF NOT EXISTS ix_integrations_health_kit_sample_attrs ON integrations.health_kit_sample USING gin(attributes);

CREATE TABLE IF NOT EXISTS integrations.google_fit_sample (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE integrations.google_fit_sample IS 'Entidade de Integration Platform para GoogleFitSample.';
CREATE INDEX IF NOT EXISTS ix_integrations_google_fit_sample_tenant ON integrations.google_fit_sample(tenant_id);
CREATE INDEX IF NOT EXISTS ix_integrations_google_fit_sample_user ON integrations.google_fit_sample(user_id);
CREATE INDEX IF NOT EXISTS ix_integrations_google_fit_sample_attrs ON integrations.google_fit_sample USING gin(attributes);

CREATE TABLE IF NOT EXISTS integrations.strava_activity (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE integrations.strava_activity IS 'Entidade de Integration Platform para StravaActivity.';
CREATE INDEX IF NOT EXISTS ix_integrations_strava_activity_tenant ON integrations.strava_activity(tenant_id);
CREATE INDEX IF NOT EXISTS ix_integrations_strava_activity_user ON integrations.strava_activity(user_id);
CREATE INDEX IF NOT EXISTS ix_integrations_strava_activity_attrs ON integrations.strava_activity USING gin(attributes);

CREATE TABLE IF NOT EXISTS integrations.calendar_event (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE integrations.calendar_event IS 'Entidade de Integration Platform para CalendarEvent.';
CREATE INDEX IF NOT EXISTS ix_integrations_calendar_event_tenant ON integrations.calendar_event(tenant_id);
CREATE INDEX IF NOT EXISTS ix_integrations_calendar_event_user ON integrations.calendar_event(user_id);
CREATE INDEX IF NOT EXISTS ix_integrations_calendar_event_attrs ON integrations.calendar_event USING gin(attributes);

CREATE TABLE IF NOT EXISTS integrations.storage_object (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE integrations.storage_object IS 'Entidade de Integration Platform para StorageObject.';
CREATE INDEX IF NOT EXISTS ix_integrations_storage_object_tenant ON integrations.storage_object(tenant_id);
CREATE INDEX IF NOT EXISTS ix_integrations_storage_object_user ON integrations.storage_object(user_id);
CREATE INDEX IF NOT EXISTS ix_integrations_storage_object_attrs ON integrations.storage_object USING gin(attributes);

CREATE TABLE IF NOT EXISTS integrations.third_party_consent (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE integrations.third_party_consent IS 'Entidade de Integration Platform para ThirdPartyConsent.';
CREATE INDEX IF NOT EXISTS ix_integrations_third_party_consent_tenant ON integrations.third_party_consent(tenant_id);
CREATE INDEX IF NOT EXISTS ix_integrations_third_party_consent_user ON integrations.third_party_consent(user_id);
CREATE INDEX IF NOT EXISTS ix_integrations_third_party_consent_attrs ON integrations.third_party_consent USING gin(attributes);

CREATE TABLE IF NOT EXISTS integrations.api_client (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE integrations.api_client IS 'Entidade de Integration Platform para ApiClient.';
CREATE INDEX IF NOT EXISTS ix_integrations_api_client_tenant ON integrations.api_client(tenant_id);
CREATE INDEX IF NOT EXISTS ix_integrations_api_client_user ON integrations.api_client(user_id);
CREATE INDEX IF NOT EXISTS ix_integrations_api_client_attrs ON integrations.api_client USING gin(attributes);

CREATE TABLE IF NOT EXISTS integrations.api_client_secret (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  tenant_id uuid REFERENCES identity.tenant(id),
  user_id uuid REFERENCES identity.user_account(id),
  status text NOT NULL DEFAULT 'active',
  data_classification text NOT NULL DEFAULT 'personal_operational',
  source_system text,
  attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now(),
  deleted_at timestamptz
);
COMMENT ON TABLE integrations.api_client_secret IS 'Entidade de Integration Platform para ApiClientSecret.';
CREATE INDEX IF NOT EXISTS ix_integrations_api_client_secret_tenant ON integrations.api_client_secret(tenant_id);
CREATE INDEX IF NOT EXISTS ix_integrations_api_client_secret_user ON integrations.api_client_secret(user_id);
CREATE INDEX IF NOT EXISTS ix_integrations_api_client_secret_attrs ON integrations.api_client_secret USING gin(attributes);
