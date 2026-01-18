--
-- PostgreSQL database dump
--

-- Dumped from database version 17.4 (Debian 17.4-1.pgdg120+2)
-- Dumped by pg_dump version 17.4 (Debian 17.4-1.pgdg120+2)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64),
    details_json text
);


ALTER TABLE public.admin_event_entity OWNER TO keycloak;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO keycloak;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO keycloak;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO keycloak;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO keycloak;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO keycloak;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO keycloak;

--
-- Name: client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO keycloak;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.client_attributes OWNER TO keycloak;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO keycloak;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO keycloak;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO keycloak;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO keycloak;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO keycloak;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO keycloak;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO keycloak;

--
-- Name: component; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO keycloak;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.component_config OWNER TO keycloak;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO keycloak;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO keycloak;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO keycloak;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO keycloak;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO keycloak;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255),
    details_json_long_value text
);


ALTER TABLE public.event_entity OWNER TO keycloak;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024),
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.fed_user_attribute OWNER TO keycloak;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO keycloak;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO keycloak;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO keycloak;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO keycloak;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO keycloak;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO keycloak;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO keycloak;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO keycloak;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO keycloak;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO keycloak;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL,
    organization_id character varying(255),
    hide_on_login boolean DEFAULT false
);


ALTER TABLE public.identity_provider OWNER TO keycloak;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO keycloak;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO keycloak;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO keycloak;

--
-- Name: jgroups_ping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.jgroups_ping (
    address character varying(200) NOT NULL,
    name character varying(200),
    cluster_name character varying(200) NOT NULL,
    ip character varying(200) NOT NULL,
    coord boolean
);


ALTER TABLE public.jgroups_ping OWNER TO keycloak;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36),
    type integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.keycloak_group OWNER TO keycloak;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO keycloak;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO keycloak;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL,
    version integer DEFAULT 0
);


ALTER TABLE public.offline_client_session OWNER TO keycloak;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL,
    broker_session_id character varying(1024),
    version integer DEFAULT 0
);


ALTER TABLE public.offline_user_session OWNER TO keycloak;

--
-- Name: org; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.org (
    id character varying(255) NOT NULL,
    enabled boolean NOT NULL,
    realm_id character varying(255) NOT NULL,
    group_id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(4000),
    alias character varying(255) NOT NULL,
    redirect_url character varying(2048)
);


ALTER TABLE public.org OWNER TO keycloak;

--
-- Name: org_domain; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.org_domain (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    verified boolean NOT NULL,
    org_id character varying(255) NOT NULL
);


ALTER TABLE public.org_domain OWNER TO keycloak;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO keycloak;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO keycloak;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO keycloak;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO keycloak;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO keycloak;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO keycloak;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO keycloak;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO keycloak;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO keycloak;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO keycloak;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO keycloak;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO keycloak;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO keycloak;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO keycloak;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO keycloak;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO keycloak;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO keycloak;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO keycloak;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode smallint NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO keycloak;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO keycloak;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy smallint,
    logic smallint,
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO keycloak;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO keycloak;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO keycloak;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO keycloak;

--
-- Name: revoked_token; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.revoked_token (
    id character varying(255) NOT NULL,
    expire bigint NOT NULL
);


ALTER TABLE public.revoked_token OWNER TO keycloak;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO keycloak;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO keycloak;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO keycloak;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    long_value_hash bytea,
    long_value_hash_lower_case bytea,
    long_value text
);


ALTER TABLE public.user_attribute OWNER TO keycloak;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO keycloak;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO keycloak;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO keycloak;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO keycloak;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO keycloak;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO keycloak;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO keycloak;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL,
    membership_type character varying(255) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO keycloak;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO keycloak;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO keycloak;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO keycloak;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type, details_json) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
c808d30a-57a0-49ab-a638-ceedbcb1217e	\N	auth-cookie	d1e198d9-8425-49d2-bc78-93f0a86674d0	3e53cabd-a63f-4a78-889f-11557b24c745	2	10	f	\N	\N
ff07c44d-c692-41e5-98bf-fec64e15de82	\N	auth-spnego	d1e198d9-8425-49d2-bc78-93f0a86674d0	3e53cabd-a63f-4a78-889f-11557b24c745	3	20	f	\N	\N
42141c9d-453d-4382-b84d-9ee635b582ef	\N	identity-provider-redirector	d1e198d9-8425-49d2-bc78-93f0a86674d0	3e53cabd-a63f-4a78-889f-11557b24c745	2	25	f	\N	\N
d7c1ad8c-0745-469b-8494-f31cb6c27c10	\N	\N	d1e198d9-8425-49d2-bc78-93f0a86674d0	3e53cabd-a63f-4a78-889f-11557b24c745	2	30	t	372682ae-249f-4449-8d56-bb5ed69238dc	\N
3e664f73-7adb-4617-aa32-fce43c2e8952	\N	auth-username-password-form	d1e198d9-8425-49d2-bc78-93f0a86674d0	372682ae-249f-4449-8d56-bb5ed69238dc	0	10	f	\N	\N
9df563c3-d0d5-44d4-8eba-2744bd6aaa59	\N	\N	d1e198d9-8425-49d2-bc78-93f0a86674d0	372682ae-249f-4449-8d56-bb5ed69238dc	1	20	t	e271a1ac-7499-488f-8cc4-3f1162cfb535	\N
3e2bed6b-5179-4aad-8712-25fced01da72	\N	conditional-user-configured	d1e198d9-8425-49d2-bc78-93f0a86674d0	e271a1ac-7499-488f-8cc4-3f1162cfb535	0	10	f	\N	\N
09165d1b-ad5d-4119-9ea7-b01a0cd7f751	\N	auth-otp-form	d1e198d9-8425-49d2-bc78-93f0a86674d0	e271a1ac-7499-488f-8cc4-3f1162cfb535	0	20	f	\N	\N
8f88ff6f-c814-4fde-86bb-6c914efb265f	\N	direct-grant-validate-username	d1e198d9-8425-49d2-bc78-93f0a86674d0	f5ddc59c-8c13-4836-883d-faeb17096890	0	10	f	\N	\N
da9f73f0-95eb-4690-87b3-aabbd6b0bc8c	\N	direct-grant-validate-password	d1e198d9-8425-49d2-bc78-93f0a86674d0	f5ddc59c-8c13-4836-883d-faeb17096890	0	20	f	\N	\N
b1be3ae2-6c51-4ba1-b8c5-6b7b820b6f94	\N	\N	d1e198d9-8425-49d2-bc78-93f0a86674d0	f5ddc59c-8c13-4836-883d-faeb17096890	1	30	t	e3e44c1c-0f1a-4a1e-99b7-9d0d49eddfea	\N
2efcd453-3de0-4fc6-8d63-d8f0d0195a93	\N	conditional-user-configured	d1e198d9-8425-49d2-bc78-93f0a86674d0	e3e44c1c-0f1a-4a1e-99b7-9d0d49eddfea	0	10	f	\N	\N
acf5a1a1-53f6-4ae5-90e3-94b0fcb05126	\N	direct-grant-validate-otp	d1e198d9-8425-49d2-bc78-93f0a86674d0	e3e44c1c-0f1a-4a1e-99b7-9d0d49eddfea	0	20	f	\N	\N
4b694f33-49d1-41c1-b544-04659441b163	\N	registration-page-form	d1e198d9-8425-49d2-bc78-93f0a86674d0	648cc273-03cc-45d5-ae49-d0cc6c8a0bc3	0	10	t	ab6a8111-04f4-4793-b566-d39d01b0bda4	\N
4e5fcecb-f470-4443-9752-8b9eb5415987	\N	registration-user-creation	d1e198d9-8425-49d2-bc78-93f0a86674d0	ab6a8111-04f4-4793-b566-d39d01b0bda4	0	20	f	\N	\N
0bc7e42f-d90e-4319-9f99-c0c7eff48b6b	\N	registration-password-action	d1e198d9-8425-49d2-bc78-93f0a86674d0	ab6a8111-04f4-4793-b566-d39d01b0bda4	0	50	f	\N	\N
352ea773-7978-4d14-9968-a7f3f1d33105	\N	registration-recaptcha-action	d1e198d9-8425-49d2-bc78-93f0a86674d0	ab6a8111-04f4-4793-b566-d39d01b0bda4	3	60	f	\N	\N
2709fe65-e022-4a08-a202-572ebc82afee	\N	registration-terms-and-conditions	d1e198d9-8425-49d2-bc78-93f0a86674d0	ab6a8111-04f4-4793-b566-d39d01b0bda4	3	70	f	\N	\N
def2bce5-335f-408b-b21e-8c62a558a959	\N	reset-credentials-choose-user	d1e198d9-8425-49d2-bc78-93f0a86674d0	d9c363c8-680b-4ca5-9283-c91fc5c215c3	0	10	f	\N	\N
fb13a04b-5362-4857-bf6c-aa8e67b3e64e	\N	reset-credential-email	d1e198d9-8425-49d2-bc78-93f0a86674d0	d9c363c8-680b-4ca5-9283-c91fc5c215c3	0	20	f	\N	\N
f9b69e54-3e8c-4dfd-9137-53352aa3d336	\N	reset-password	d1e198d9-8425-49d2-bc78-93f0a86674d0	d9c363c8-680b-4ca5-9283-c91fc5c215c3	0	30	f	\N	\N
b9e122c5-3c57-4eba-ac26-9d6b7819bd5b	\N	\N	d1e198d9-8425-49d2-bc78-93f0a86674d0	d9c363c8-680b-4ca5-9283-c91fc5c215c3	1	40	t	0c430466-3ac5-4ee7-8fb9-d18835072cd8	\N
afb2a1ca-a41a-4f8f-a032-15abad91edaa	\N	conditional-user-configured	d1e198d9-8425-49d2-bc78-93f0a86674d0	0c430466-3ac5-4ee7-8fb9-d18835072cd8	0	10	f	\N	\N
c22f1d20-14d7-4fe8-b44b-e4921f13943a	\N	reset-otp	d1e198d9-8425-49d2-bc78-93f0a86674d0	0c430466-3ac5-4ee7-8fb9-d18835072cd8	0	20	f	\N	\N
08d11df1-c2a6-4294-ac1a-0140004b8598	\N	client-secret	d1e198d9-8425-49d2-bc78-93f0a86674d0	15e346f4-755a-4c9b-9715-eab3939ae6c9	2	10	f	\N	\N
ab439801-574b-4758-9e48-6d9b3940f5b3	\N	client-jwt	d1e198d9-8425-49d2-bc78-93f0a86674d0	15e346f4-755a-4c9b-9715-eab3939ae6c9	2	20	f	\N	\N
998339dc-85fb-4204-bebd-f97b06ab3297	\N	client-secret-jwt	d1e198d9-8425-49d2-bc78-93f0a86674d0	15e346f4-755a-4c9b-9715-eab3939ae6c9	2	30	f	\N	\N
a3c594e4-8080-4d3c-9f7b-fcd47896d194	\N	client-x509	d1e198d9-8425-49d2-bc78-93f0a86674d0	15e346f4-755a-4c9b-9715-eab3939ae6c9	2	40	f	\N	\N
01debef7-8824-4f98-9d9a-c3ebe6cca97e	\N	idp-review-profile	d1e198d9-8425-49d2-bc78-93f0a86674d0	71a6753d-06e8-456c-840b-ce8b3bf770ba	0	10	f	\N	60ffa714-f0f8-47b6-8a3f-63afd28659e3
44ce68f1-918d-4853-a0e9-90dbdf85e14b	\N	\N	d1e198d9-8425-49d2-bc78-93f0a86674d0	71a6753d-06e8-456c-840b-ce8b3bf770ba	0	20	t	71e67721-3f54-4dc9-bcd5-6a48737c9bb5	\N
8ec8794d-0368-41c3-9bd3-7ba608cd9817	\N	idp-create-user-if-unique	d1e198d9-8425-49d2-bc78-93f0a86674d0	71e67721-3f54-4dc9-bcd5-6a48737c9bb5	2	10	f	\N	f9985402-ae25-4abb-b523-b9de888fddcf
7d572b4a-1105-477d-af9e-c7b889e7d1b3	\N	\N	d1e198d9-8425-49d2-bc78-93f0a86674d0	71e67721-3f54-4dc9-bcd5-6a48737c9bb5	2	20	t	728ec0c7-61b5-498b-8ac7-e4a9618fd015	\N
8c991db6-ab90-42ad-8fff-e645ff0c87e8	\N	idp-confirm-link	d1e198d9-8425-49d2-bc78-93f0a86674d0	728ec0c7-61b5-498b-8ac7-e4a9618fd015	0	10	f	\N	\N
a0d8f51d-3494-42dd-a174-c5eb22b8c39f	\N	\N	d1e198d9-8425-49d2-bc78-93f0a86674d0	728ec0c7-61b5-498b-8ac7-e4a9618fd015	0	20	t	4a0b796c-1a5c-4f6a-948a-c7e28961462b	\N
f2eff294-1f56-4911-8eab-af1b4d22dbd2	\N	idp-email-verification	d1e198d9-8425-49d2-bc78-93f0a86674d0	4a0b796c-1a5c-4f6a-948a-c7e28961462b	2	10	f	\N	\N
00cacf97-78fd-4f02-9344-6943c4504b0e	\N	\N	d1e198d9-8425-49d2-bc78-93f0a86674d0	4a0b796c-1a5c-4f6a-948a-c7e28961462b	2	20	t	55e43f25-5537-43d9-9ca5-87d506450153	\N
2d8e113a-09e0-462b-b399-b8057948e615	\N	idp-username-password-form	d1e198d9-8425-49d2-bc78-93f0a86674d0	55e43f25-5537-43d9-9ca5-87d506450153	0	10	f	\N	\N
9ec17e84-2075-4ccc-8b13-fe5665bff938	\N	\N	d1e198d9-8425-49d2-bc78-93f0a86674d0	55e43f25-5537-43d9-9ca5-87d506450153	1	20	t	b13b00fd-7e12-4a24-8aba-1902e43186c8	\N
a4162167-7052-4b49-b820-ca2fd5084ccd	\N	conditional-user-configured	d1e198d9-8425-49d2-bc78-93f0a86674d0	b13b00fd-7e12-4a24-8aba-1902e43186c8	0	10	f	\N	\N
a1b1abf2-4da1-4744-a6e9-1c42d31d6757	\N	auth-otp-form	d1e198d9-8425-49d2-bc78-93f0a86674d0	b13b00fd-7e12-4a24-8aba-1902e43186c8	0	20	f	\N	\N
b6ff7e8a-2432-4352-998c-150615b1d7a2	\N	http-basic-authenticator	d1e198d9-8425-49d2-bc78-93f0a86674d0	d9a2f07b-b3a9-4e3d-90be-c90f9e019d84	0	10	f	\N	\N
4c3084e7-43f5-42fd-894f-ab0094c49b6b	\N	docker-http-basic-authenticator	d1e198d9-8425-49d2-bc78-93f0a86674d0	39c040fe-909d-434b-97e6-f2db5a5e3265	0	10	f	\N	\N
b4e6131e-c175-4f50-9c40-02497f642992	\N	auth-cookie	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	a4cd7229-efb8-4c3b-9ec4-c80e9c6024bf	2	10	f	\N	\N
dc3c77c3-e65a-4eb3-86d5-dc4985d09285	\N	auth-spnego	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	a4cd7229-efb8-4c3b-9ec4-c80e9c6024bf	3	20	f	\N	\N
6cb26ae0-9391-47d1-b4b3-263fc5a0c6e4	\N	identity-provider-redirector	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	a4cd7229-efb8-4c3b-9ec4-c80e9c6024bf	2	25	f	\N	\N
c605d7f3-9190-4074-b1ca-52c30a8e60f4	\N	\N	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	a4cd7229-efb8-4c3b-9ec4-c80e9c6024bf	2	30	t	a2a859be-e36a-4ca4-91fa-a2df35467671	\N
6eddc57b-39e4-4d45-b230-253a2ef88119	\N	auth-username-password-form	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	a2a859be-e36a-4ca4-91fa-a2df35467671	0	10	f	\N	\N
82f2d24e-383b-45c8-8e25-351000492251	\N	\N	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	a2a859be-e36a-4ca4-91fa-a2df35467671	1	20	t	360062f4-b27e-4b4c-ba7d-d78e55938cca	\N
d08a699f-74cc-4cb7-8ab9-43a8e8ea25a0	\N	conditional-user-configured	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	360062f4-b27e-4b4c-ba7d-d78e55938cca	0	10	f	\N	\N
70baa755-af32-4867-907a-6bd7068cfd9e	\N	auth-otp-form	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	360062f4-b27e-4b4c-ba7d-d78e55938cca	0	20	f	\N	\N
fedac092-7b87-47e4-9b9f-47ba34e2e1d0	\N	\N	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	a4cd7229-efb8-4c3b-9ec4-c80e9c6024bf	2	26	t	131c3ec9-89bf-4d41-b9b4-eb1f6d034723	\N
daa42d35-eb64-41a6-8502-fcad3702a118	\N	\N	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	131c3ec9-89bf-4d41-b9b4-eb1f6d034723	1	10	t	b922b173-1caa-4025-ae42-7991469ed0d0	\N
52a01397-7ab4-43f0-b9cd-18726f462576	\N	conditional-user-configured	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	b922b173-1caa-4025-ae42-7991469ed0d0	0	10	f	\N	\N
58cb9afc-84eb-4dbb-a5aa-b573dcb92e8b	\N	organization	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	b922b173-1caa-4025-ae42-7991469ed0d0	2	20	f	\N	\N
32d87ea4-5129-4768-9a1f-4dfaa7462478	\N	direct-grant-validate-username	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	a3e639e4-86a0-4521-a3ff-fd98a06b9dbd	0	10	f	\N	\N
ac1eda15-1ebc-4320-9b18-55a675438aa4	\N	direct-grant-validate-password	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	a3e639e4-86a0-4521-a3ff-fd98a06b9dbd	0	20	f	\N	\N
42f9a9d5-c302-4d66-a74c-ee1197bdc83b	\N	\N	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	a3e639e4-86a0-4521-a3ff-fd98a06b9dbd	1	30	t	cb413c7a-aca7-498e-8e43-50e1b7971d92	\N
c5aa9fe1-8c57-4ecc-ad40-0569d86ba38d	\N	conditional-user-configured	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	cb413c7a-aca7-498e-8e43-50e1b7971d92	0	10	f	\N	\N
a692ebc5-96ba-4a1d-977b-ed247eb157ba	\N	direct-grant-validate-otp	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	cb413c7a-aca7-498e-8e43-50e1b7971d92	0	20	f	\N	\N
6853dc0c-fecd-4a06-bfb0-59c8e662c3e9	\N	registration-page-form	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	14747f04-79bd-4788-827c-6f28c3087bea	0	10	t	40459266-0fc8-4cb9-8279-15dc35799e64	\N
1f905d43-3f6e-4524-80a8-8923b14f1319	\N	registration-user-creation	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	40459266-0fc8-4cb9-8279-15dc35799e64	0	20	f	\N	\N
bd46b3a9-3e3e-48d3-b2b6-bc3064f65125	\N	registration-password-action	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	40459266-0fc8-4cb9-8279-15dc35799e64	0	50	f	\N	\N
5c55193d-55ae-44fe-b847-48f8605029c4	\N	registration-recaptcha-action	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	40459266-0fc8-4cb9-8279-15dc35799e64	3	60	f	\N	\N
06a5294a-8a6b-4dcb-9635-0acb83b02e49	\N	registration-terms-and-conditions	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	40459266-0fc8-4cb9-8279-15dc35799e64	3	70	f	\N	\N
9b3b6acd-0ed0-4f6e-99e7-a5c269573f7f	\N	reset-credentials-choose-user	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	be5f294a-da00-4675-b3df-c5e9ec4fa1ce	0	10	f	\N	\N
0c41fb1b-f6ab-4092-b387-4c77181bf1fc	\N	reset-credential-email	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	be5f294a-da00-4675-b3df-c5e9ec4fa1ce	0	20	f	\N	\N
00e19f2a-e025-40d4-b556-f904f916c60d	\N	reset-password	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	be5f294a-da00-4675-b3df-c5e9ec4fa1ce	0	30	f	\N	\N
910e2428-251d-4596-a722-59f186a3f9f9	\N	\N	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	be5f294a-da00-4675-b3df-c5e9ec4fa1ce	1	40	t	929a76cb-a086-4d76-8a21-559d1dedea14	\N
80baa0a6-85e5-4fd0-b71d-174a2ef1e17e	\N	conditional-user-configured	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	929a76cb-a086-4d76-8a21-559d1dedea14	0	10	f	\N	\N
6ef0acb2-3cf1-4f72-aad6-047df133cc58	\N	reset-otp	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	929a76cb-a086-4d76-8a21-559d1dedea14	0	20	f	\N	\N
d6456491-b7f5-401c-b6d6-c939e53133bc	\N	client-secret	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	dde9386b-542c-49c7-a1cd-f622046c3588	2	10	f	\N	\N
e43a2b27-a01c-457f-a7d9-6e8964114379	\N	client-jwt	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	dde9386b-542c-49c7-a1cd-f622046c3588	2	20	f	\N	\N
58ac60e2-9e59-4cb0-a7ab-b5137ff6b575	\N	client-secret-jwt	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	dde9386b-542c-49c7-a1cd-f622046c3588	2	30	f	\N	\N
c39c3c9f-0390-4354-8f77-fe3b018e25a4	\N	client-x509	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	dde9386b-542c-49c7-a1cd-f622046c3588	2	40	f	\N	\N
a037e887-6543-4bed-8cf9-207362426cbb	\N	idp-review-profile	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	f770cd9a-613f-4b55-82f0-3925eaf28481	0	10	f	\N	57b5f58a-4ec7-45cf-99bc-728eec6b851b
8200be65-49cf-4997-8ae5-83c51a6bcfd7	\N	\N	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	f770cd9a-613f-4b55-82f0-3925eaf28481	0	20	t	7edd30ea-17b2-4729-9c28-74e05a0e1479	\N
3d732d4b-7cb1-43e7-ad4f-a06a7f0a68bc	\N	idp-create-user-if-unique	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	7edd30ea-17b2-4729-9c28-74e05a0e1479	2	10	f	\N	5efb9fa5-f1dc-469c-806c-e1851c2423e2
2f751916-2918-493b-b0a0-d72616bb8abc	\N	\N	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	7edd30ea-17b2-4729-9c28-74e05a0e1479	2	20	t	8ed36cad-6673-49a3-b5b9-64dd61691ac3	\N
e3279608-7236-45cf-b4c3-323f04785d0e	\N	idp-confirm-link	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	8ed36cad-6673-49a3-b5b9-64dd61691ac3	0	10	f	\N	\N
f6a153bf-75ec-4396-86cb-e873d9f516e2	\N	\N	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	8ed36cad-6673-49a3-b5b9-64dd61691ac3	0	20	t	2f6a5d23-103a-4862-a72d-c844973e3a91	\N
393956df-0097-425b-88dc-8b2b40676773	\N	idp-email-verification	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	2f6a5d23-103a-4862-a72d-c844973e3a91	2	10	f	\N	\N
6af34580-cc26-4271-b371-8ba637fa57f0	\N	\N	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	2f6a5d23-103a-4862-a72d-c844973e3a91	2	20	t	cf2a62a3-8a73-4003-aedb-efc31d803b6f	\N
ab763125-117a-4425-a978-708a9c47230e	\N	idp-username-password-form	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	cf2a62a3-8a73-4003-aedb-efc31d803b6f	0	10	f	\N	\N
e2d05cd6-d1b7-4e5e-ac68-be957821e8dd	\N	\N	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	cf2a62a3-8a73-4003-aedb-efc31d803b6f	1	20	t	de1c6c48-9948-4f20-b00b-3cfe4fc9e64b	\N
09560ed1-4050-4a0a-afe5-ab4b41801766	\N	conditional-user-configured	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	de1c6c48-9948-4f20-b00b-3cfe4fc9e64b	0	10	f	\N	\N
ce64d974-bf0d-498c-b4fb-84418858c07f	\N	auth-otp-form	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	de1c6c48-9948-4f20-b00b-3cfe4fc9e64b	0	20	f	\N	\N
c3e5454a-cd5f-47c7-b786-2e1968449993	\N	\N	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	f770cd9a-613f-4b55-82f0-3925eaf28481	1	50	t	ec50fe2d-9331-4fc2-b25c-cdd9baa075fc	\N
dda14019-2f8b-41f9-8fc5-df8b6092a795	\N	conditional-user-configured	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	ec50fe2d-9331-4fc2-b25c-cdd9baa075fc	0	10	f	\N	\N
4da4b55f-51a0-4994-b1b8-55ff9bace9ae	\N	idp-add-organization-member	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	ec50fe2d-9331-4fc2-b25c-cdd9baa075fc	0	20	f	\N	\N
447fad13-a59f-445f-a8cd-6ce3d2868a27	\N	http-basic-authenticator	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	69b78db7-e03e-420a-9d4b-fb0bf210ca45	0	10	f	\N	\N
2ea1be74-4813-43de-879b-6caad0fd4958	\N	docker-http-basic-authenticator	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	35f0cba9-2bcb-49c2-b4e9-a6c076e6a296	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
3e53cabd-a63f-4a78-889f-11557b24c745	browser	Browser based authentication	d1e198d9-8425-49d2-bc78-93f0a86674d0	basic-flow	t	t
372682ae-249f-4449-8d56-bb5ed69238dc	forms	Username, password, otp and other auth forms.	d1e198d9-8425-49d2-bc78-93f0a86674d0	basic-flow	f	t
e271a1ac-7499-488f-8cc4-3f1162cfb535	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	d1e198d9-8425-49d2-bc78-93f0a86674d0	basic-flow	f	t
f5ddc59c-8c13-4836-883d-faeb17096890	direct grant	OpenID Connect Resource Owner Grant	d1e198d9-8425-49d2-bc78-93f0a86674d0	basic-flow	t	t
e3e44c1c-0f1a-4a1e-99b7-9d0d49eddfea	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	d1e198d9-8425-49d2-bc78-93f0a86674d0	basic-flow	f	t
648cc273-03cc-45d5-ae49-d0cc6c8a0bc3	registration	Registration flow	d1e198d9-8425-49d2-bc78-93f0a86674d0	basic-flow	t	t
ab6a8111-04f4-4793-b566-d39d01b0bda4	registration form	Registration form	d1e198d9-8425-49d2-bc78-93f0a86674d0	form-flow	f	t
d9c363c8-680b-4ca5-9283-c91fc5c215c3	reset credentials	Reset credentials for a user if they forgot their password or something	d1e198d9-8425-49d2-bc78-93f0a86674d0	basic-flow	t	t
0c430466-3ac5-4ee7-8fb9-d18835072cd8	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	d1e198d9-8425-49d2-bc78-93f0a86674d0	basic-flow	f	t
15e346f4-755a-4c9b-9715-eab3939ae6c9	clients	Base authentication for clients	d1e198d9-8425-49d2-bc78-93f0a86674d0	client-flow	t	t
71a6753d-06e8-456c-840b-ce8b3bf770ba	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	d1e198d9-8425-49d2-bc78-93f0a86674d0	basic-flow	t	t
71e67721-3f54-4dc9-bcd5-6a48737c9bb5	User creation or linking	Flow for the existing/non-existing user alternatives	d1e198d9-8425-49d2-bc78-93f0a86674d0	basic-flow	f	t
728ec0c7-61b5-498b-8ac7-e4a9618fd015	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	d1e198d9-8425-49d2-bc78-93f0a86674d0	basic-flow	f	t
4a0b796c-1a5c-4f6a-948a-c7e28961462b	Account verification options	Method with which to verity the existing account	d1e198d9-8425-49d2-bc78-93f0a86674d0	basic-flow	f	t
55e43f25-5537-43d9-9ca5-87d506450153	Verify Existing Account by Re-authentication	Reauthentication of existing account	d1e198d9-8425-49d2-bc78-93f0a86674d0	basic-flow	f	t
b13b00fd-7e12-4a24-8aba-1902e43186c8	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	d1e198d9-8425-49d2-bc78-93f0a86674d0	basic-flow	f	t
d9a2f07b-b3a9-4e3d-90be-c90f9e019d84	saml ecp	SAML ECP Profile Authentication Flow	d1e198d9-8425-49d2-bc78-93f0a86674d0	basic-flow	t	t
39c040fe-909d-434b-97e6-f2db5a5e3265	docker auth	Used by Docker clients to authenticate against the IDP	d1e198d9-8425-49d2-bc78-93f0a86674d0	basic-flow	t	t
a4cd7229-efb8-4c3b-9ec4-c80e9c6024bf	browser	Browser based authentication	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	basic-flow	t	t
a2a859be-e36a-4ca4-91fa-a2df35467671	forms	Username, password, otp and other auth forms.	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	basic-flow	f	t
360062f4-b27e-4b4c-ba7d-d78e55938cca	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	basic-flow	f	t
131c3ec9-89bf-4d41-b9b4-eb1f6d034723	Organization	\N	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	basic-flow	f	t
b922b173-1caa-4025-ae42-7991469ed0d0	Browser - Conditional Organization	Flow to determine if the organization identity-first login is to be used	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	basic-flow	f	t
a3e639e4-86a0-4521-a3ff-fd98a06b9dbd	direct grant	OpenID Connect Resource Owner Grant	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	basic-flow	t	t
cb413c7a-aca7-498e-8e43-50e1b7971d92	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	basic-flow	f	t
14747f04-79bd-4788-827c-6f28c3087bea	registration	Registration flow	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	basic-flow	t	t
40459266-0fc8-4cb9-8279-15dc35799e64	registration form	Registration form	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	form-flow	f	t
be5f294a-da00-4675-b3df-c5e9ec4fa1ce	reset credentials	Reset credentials for a user if they forgot their password or something	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	basic-flow	t	t
929a76cb-a086-4d76-8a21-559d1dedea14	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	basic-flow	f	t
dde9386b-542c-49c7-a1cd-f622046c3588	clients	Base authentication for clients	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	client-flow	t	t
f770cd9a-613f-4b55-82f0-3925eaf28481	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	basic-flow	t	t
7edd30ea-17b2-4729-9c28-74e05a0e1479	User creation or linking	Flow for the existing/non-existing user alternatives	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	basic-flow	f	t
8ed36cad-6673-49a3-b5b9-64dd61691ac3	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	basic-flow	f	t
2f6a5d23-103a-4862-a72d-c844973e3a91	Account verification options	Method with which to verity the existing account	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	basic-flow	f	t
cf2a62a3-8a73-4003-aedb-efc31d803b6f	Verify Existing Account by Re-authentication	Reauthentication of existing account	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	basic-flow	f	t
de1c6c48-9948-4f20-b00b-3cfe4fc9e64b	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	basic-flow	f	t
ec50fe2d-9331-4fc2-b25c-cdd9baa075fc	First Broker Login - Conditional Organization	Flow to determine if the authenticator that adds organization members is to be used	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	basic-flow	f	t
69b78db7-e03e-420a-9d4b-fb0bf210ca45	saml ecp	SAML ECP Profile Authentication Flow	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	basic-flow	t	t
35f0cba9-2bcb-49c2-b4e9-a6c076e6a296	docker auth	Used by Docker clients to authenticate against the IDP	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
60ffa714-f0f8-47b6-8a3f-63afd28659e3	review profile config	d1e198d9-8425-49d2-bc78-93f0a86674d0
f9985402-ae25-4abb-b523-b9de888fddcf	create unique user config	d1e198d9-8425-49d2-bc78-93f0a86674d0
57b5f58a-4ec7-45cf-99bc-728eec6b851b	review profile config	ce9366ab-71c7-4e77-b7dc-1e69c9458b62
5efb9fa5-f1dc-469c-806c-e1851c2423e2	create unique user config	ce9366ab-71c7-4e77-b7dc-1e69c9458b62
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
60ffa714-f0f8-47b6-8a3f-63afd28659e3	missing	update.profile.on.first.login
f9985402-ae25-4abb-b523-b9de888fddcf	false	require.password.update.after.registration
57b5f58a-4ec7-45cf-99bc-728eec6b851b	missing	update.profile.on.first.login
5efb9fa5-f1dc-469c-806c-e1851c2423e2	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
c15b624c-74e1-4846-9b13-437b714eb009	t	f	master-realm	0	f	\N	\N	t	\N	f	d1e198d9-8425-49d2-bc78-93f0a86674d0	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
21a58005-5b16-4573-a738-7f8ead425601	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	d1e198d9-8425-49d2-bc78-93f0a86674d0	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
8043b157-f18f-453a-af2b-f982773b836d	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	d1e198d9-8425-49d2-bc78-93f0a86674d0	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
46ea88a6-96e5-423e-a421-417b0b7ed4c3	t	f	broker	0	f	\N	\N	t	\N	f	d1e198d9-8425-49d2-bc78-93f0a86674d0	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
37270d19-ac39-4c63-b628-eb5e3371546d	t	t	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	d1e198d9-8425-49d2-bc78-93f0a86674d0	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
1ae80258-fca9-40d4-bb17-509fa72ecf01	t	t	admin-cli	0	t	\N	\N	f	\N	f	d1e198d9-8425-49d2-bc78-93f0a86674d0	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
16f41b45-36c4-4db5-adfd-33de04c58368	t	f	realm-management	0	f	\N	\N	t	\N	f	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
c7ec91f0-159e-4664-b306-e59567bff305	t	t	admin-cli	0	f	hjXaSYoOVUDWV6GoVjIf7jf3OplB8how		f		f	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	openid-connect	0	f	f	${client_admin-cli}	t	client-secret			\N	f	f	t	f
2b8a29d1-dfc3-4f71-b5b2-1024060b950d	t	f	broker	0	f	\N	\N	t	\N	f	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
975635d5-0c2b-4fce-a2a3-dd81ab1eac7a	t	t	boxty_client	0	t	\N		f	http://localhost:5004	f	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	openid-connect	-1	t	f	Boxty Client Application	f	client-secret	http://localhost:5004		\N	t	f	f	f
65985cf3-3664-4734-8ea3-d79f101ed400	t	f	Boxty-realm	0	f	\N	\N	t	\N	f	d1e198d9-8425-49d2-bc78-93f0a86674d0	\N	0	f	f	boxty Realm	f	client-secret	\N	\N	\N	t	f	f	f
d69b827d-2fd5-42b4-a977-55b636ca4ecc	t	t	security-admin-console	0	t	\N	/admin/Boxty/console/	f	\N	f	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
a4cb068a-7f7e-4441-ab59-466479c727f8	t	f	account	0	t	\N	/realms/Boxty/account/	f	\N	f	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
91ac20eb-19d4-4312-86e0-6e13b2fbb0d4	t	f	account-console	0	t	\N	/realms/Boxty/account/	f	\N	f	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
6905d5cc-a4c4-41c7-8e03-b991b5a6076e	t	t	boxty_webapi	0	t	\N		f		f	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	openid-connect	-1	t	f	Boxty Web Api	f	client-secret			\N	f	f	f	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
21a58005-5b16-4573-a738-7f8ead425601	post.logout.redirect.uris	+
8043b157-f18f-453a-af2b-f982773b836d	post.logout.redirect.uris	+
8043b157-f18f-453a-af2b-f982773b836d	pkce.code.challenge.method	S256
37270d19-ac39-4c63-b628-eb5e3371546d	post.logout.redirect.uris	+
37270d19-ac39-4c63-b628-eb5e3371546d	pkce.code.challenge.method	S256
37270d19-ac39-4c63-b628-eb5e3371546d	client.use.lightweight.access.token.enabled	true
1ae80258-fca9-40d4-bb17-509fa72ecf01	client.use.lightweight.access.token.enabled	true
a4cb068a-7f7e-4441-ab59-466479c727f8	post.logout.redirect.uris	+
91ac20eb-19d4-4312-86e0-6e13b2fbb0d4	post.logout.redirect.uris	+
91ac20eb-19d4-4312-86e0-6e13b2fbb0d4	pkce.code.challenge.method	S256
d69b827d-2fd5-42b4-a977-55b636ca4ecc	post.logout.redirect.uris	+
d69b827d-2fd5-42b4-a977-55b636ca4ecc	pkce.code.challenge.method	S256
d69b827d-2fd5-42b4-a977-55b636ca4ecc	client.use.lightweight.access.token.enabled	true
c7ec91f0-159e-4664-b306-e59567bff305	client.use.lightweight.access.token.enabled	true
c7ec91f0-159e-4664-b306-e59567bff305	client.secret.creation.time	1768682494
c7ec91f0-159e-4664-b306-e59567bff305	realm_client	false
c7ec91f0-159e-4664-b306-e59567bff305	oauth2.device.authorization.grant.enabled	false
c7ec91f0-159e-4664-b306-e59567bff305	oidc.ciba.grant.enabled	false
c7ec91f0-159e-4664-b306-e59567bff305	display.on.consent.screen	false
c7ec91f0-159e-4664-b306-e59567bff305	backchannel.logout.session.required	true
c7ec91f0-159e-4664-b306-e59567bff305	backchannel.logout.revoke.offline.tokens	false
975635d5-0c2b-4fce-a2a3-dd81ab1eac7a	oauth2.device.authorization.grant.enabled	false
975635d5-0c2b-4fce-a2a3-dd81ab1eac7a	oidc.ciba.grant.enabled	false
975635d5-0c2b-4fce-a2a3-dd81ab1eac7a	post.logout.redirect.uris	http://localhost:5004/authentication/logout-callback
975635d5-0c2b-4fce-a2a3-dd81ab1eac7a	backchannel.logout.session.required	true
975635d5-0c2b-4fce-a2a3-dd81ab1eac7a	backchannel.logout.revoke.offline.tokens	false
6905d5cc-a4c4-41c7-8e03-b991b5a6076e	oauth2.device.authorization.grant.enabled	false
6905d5cc-a4c4-41c7-8e03-b991b5a6076e	oidc.ciba.grant.enabled	false
6905d5cc-a4c4-41c7-8e03-b991b5a6076e	backchannel.logout.session.required	true
6905d5cc-a4c4-41c7-8e03-b991b5a6076e	backchannel.logout.revoke.offline.tokens	false
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
79844d2e-3022-495b-b9a7-5a64d4a07c92	offline_access	d1e198d9-8425-49d2-bc78-93f0a86674d0	OpenID Connect built-in scope: offline_access	openid-connect
89b6ccba-0ceb-4fd6-bf26-afa10d3a0203	role_list	d1e198d9-8425-49d2-bc78-93f0a86674d0	SAML role list	saml
f21f92dc-9e52-45b4-8200-1bffa83eba9a	saml_organization	d1e198d9-8425-49d2-bc78-93f0a86674d0	Organization Membership	saml
5159c8bb-b08a-4f3c-992a-b5a39c1b4779	profile	d1e198d9-8425-49d2-bc78-93f0a86674d0	OpenID Connect built-in scope: profile	openid-connect
9711cbec-2695-4017-b902-d18284e917bf	email	d1e198d9-8425-49d2-bc78-93f0a86674d0	OpenID Connect built-in scope: email	openid-connect
5f5924d8-2cf7-411b-b2f2-9494cb19a710	address	d1e198d9-8425-49d2-bc78-93f0a86674d0	OpenID Connect built-in scope: address	openid-connect
df8d0e89-d1e8-4d2a-b360-83b3926dc53a	phone	d1e198d9-8425-49d2-bc78-93f0a86674d0	OpenID Connect built-in scope: phone	openid-connect
285c0f70-91a0-483d-a961-4abcf1b53b15	roles	d1e198d9-8425-49d2-bc78-93f0a86674d0	OpenID Connect scope for add user roles to the access token	openid-connect
63b93bb7-9496-4b07-bbc5-2c44fc521b6d	web-origins	d1e198d9-8425-49d2-bc78-93f0a86674d0	OpenID Connect scope for add allowed web origins to the access token	openid-connect
3bac3b68-c660-43d8-8099-04e5dbb3b835	microprofile-jwt	d1e198d9-8425-49d2-bc78-93f0a86674d0	Microprofile - JWT built-in scope	openid-connect
baf14ede-f1ce-468d-b3cc-86a1f5036cbe	acr	d1e198d9-8425-49d2-bc78-93f0a86674d0	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
284ac003-5e92-4715-819a-d053bfb5d35b	basic	d1e198d9-8425-49d2-bc78-93f0a86674d0	OpenID Connect scope for add all basic claims to the token	openid-connect
eb1c8960-0199-4e23-b868-77c647921092	service_account	d1e198d9-8425-49d2-bc78-93f0a86674d0	Specific scope for a client enabled for service accounts	openid-connect
4f7c1ae3-2df4-4064-9026-cd6fde4195f6	organization	d1e198d9-8425-49d2-bc78-93f0a86674d0	Additional claims about the organization a subject belongs to	openid-connect
ee214e36-9f2f-4207-84ac-ce12848b0550	offline_access	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	OpenID Connect built-in scope: offline_access	openid-connect
c33c200e-e074-4722-a730-33d87bfab61c	role_list	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	SAML role list	saml
356a372e-712c-4aa3-bedf-1eaac0de3baf	saml_organization	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	Organization Membership	saml
33930219-11f7-43a5-b413-9ce7a1ae60a1	profile	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	OpenID Connect built-in scope: profile	openid-connect
db4fa263-45bd-4efd-a612-51d4972ca6d7	email	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	OpenID Connect built-in scope: email	openid-connect
130e15d8-94d1-4e6a-bd38-f507ed5468ba	address	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	OpenID Connect built-in scope: address	openid-connect
41ea5502-3b1c-4aaa-9708-b6545251311f	phone	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	OpenID Connect built-in scope: phone	openid-connect
b2619f52-3b42-4375-8960-a8def3c96d39	roles	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	OpenID Connect scope for add user roles to the access token	openid-connect
db76de7b-5f64-43e1-81b5-86bca09fb0bb	web-origins	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	OpenID Connect scope for add allowed web origins to the access token	openid-connect
363cdf68-d20b-4a1b-a263-fee42b8695c3	microprofile-jwt	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	Microprofile - JWT built-in scope	openid-connect
d984e2db-6e4b-4a85-8d41-5e049f274145	acr	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
f0ac861f-3f0e-4c7a-bfb8-5d8c7a26680e	basic	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	OpenID Connect scope for add all basic claims to the token	openid-connect
a5e4ec15-29cd-4ace-a76f-09d80b16b636	service_account	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	Specific scope for a client enabled for service accounts	openid-connect
6c8fe887-ac8c-4c77-a801-8b52f956833a	organization	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	Additional claims about the organization a subject belongs to	openid-connect
b3d140e6-1c36-4d74-9cbf-361707af3dae	boxty_webapi-scope	ce9366ab-71c7-4e77-b7dc-1e69c9458b62		openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
79844d2e-3022-495b-b9a7-5a64d4a07c92	true	display.on.consent.screen
79844d2e-3022-495b-b9a7-5a64d4a07c92	${offlineAccessScopeConsentText}	consent.screen.text
89b6ccba-0ceb-4fd6-bf26-afa10d3a0203	true	display.on.consent.screen
89b6ccba-0ceb-4fd6-bf26-afa10d3a0203	${samlRoleListScopeConsentText}	consent.screen.text
f21f92dc-9e52-45b4-8200-1bffa83eba9a	false	display.on.consent.screen
5159c8bb-b08a-4f3c-992a-b5a39c1b4779	true	display.on.consent.screen
5159c8bb-b08a-4f3c-992a-b5a39c1b4779	${profileScopeConsentText}	consent.screen.text
5159c8bb-b08a-4f3c-992a-b5a39c1b4779	true	include.in.token.scope
9711cbec-2695-4017-b902-d18284e917bf	true	display.on.consent.screen
9711cbec-2695-4017-b902-d18284e917bf	${emailScopeConsentText}	consent.screen.text
9711cbec-2695-4017-b902-d18284e917bf	true	include.in.token.scope
5f5924d8-2cf7-411b-b2f2-9494cb19a710	true	display.on.consent.screen
5f5924d8-2cf7-411b-b2f2-9494cb19a710	${addressScopeConsentText}	consent.screen.text
5f5924d8-2cf7-411b-b2f2-9494cb19a710	true	include.in.token.scope
df8d0e89-d1e8-4d2a-b360-83b3926dc53a	true	display.on.consent.screen
df8d0e89-d1e8-4d2a-b360-83b3926dc53a	${phoneScopeConsentText}	consent.screen.text
df8d0e89-d1e8-4d2a-b360-83b3926dc53a	true	include.in.token.scope
285c0f70-91a0-483d-a961-4abcf1b53b15	true	display.on.consent.screen
285c0f70-91a0-483d-a961-4abcf1b53b15	${rolesScopeConsentText}	consent.screen.text
285c0f70-91a0-483d-a961-4abcf1b53b15	false	include.in.token.scope
63b93bb7-9496-4b07-bbc5-2c44fc521b6d	false	display.on.consent.screen
63b93bb7-9496-4b07-bbc5-2c44fc521b6d		consent.screen.text
63b93bb7-9496-4b07-bbc5-2c44fc521b6d	false	include.in.token.scope
3bac3b68-c660-43d8-8099-04e5dbb3b835	false	display.on.consent.screen
3bac3b68-c660-43d8-8099-04e5dbb3b835	true	include.in.token.scope
baf14ede-f1ce-468d-b3cc-86a1f5036cbe	false	display.on.consent.screen
baf14ede-f1ce-468d-b3cc-86a1f5036cbe	false	include.in.token.scope
284ac003-5e92-4715-819a-d053bfb5d35b	false	display.on.consent.screen
284ac003-5e92-4715-819a-d053bfb5d35b	false	include.in.token.scope
eb1c8960-0199-4e23-b868-77c647921092	false	display.on.consent.screen
eb1c8960-0199-4e23-b868-77c647921092	false	include.in.token.scope
4f7c1ae3-2df4-4064-9026-cd6fde4195f6	true	display.on.consent.screen
4f7c1ae3-2df4-4064-9026-cd6fde4195f6	${organizationScopeConsentText}	consent.screen.text
4f7c1ae3-2df4-4064-9026-cd6fde4195f6	true	include.in.token.scope
ee214e36-9f2f-4207-84ac-ce12848b0550	true	display.on.consent.screen
ee214e36-9f2f-4207-84ac-ce12848b0550	${offlineAccessScopeConsentText}	consent.screen.text
c33c200e-e074-4722-a730-33d87bfab61c	true	display.on.consent.screen
c33c200e-e074-4722-a730-33d87bfab61c	${samlRoleListScopeConsentText}	consent.screen.text
356a372e-712c-4aa3-bedf-1eaac0de3baf	false	display.on.consent.screen
33930219-11f7-43a5-b413-9ce7a1ae60a1	true	display.on.consent.screen
33930219-11f7-43a5-b413-9ce7a1ae60a1	${profileScopeConsentText}	consent.screen.text
33930219-11f7-43a5-b413-9ce7a1ae60a1	true	include.in.token.scope
db4fa263-45bd-4efd-a612-51d4972ca6d7	true	display.on.consent.screen
db4fa263-45bd-4efd-a612-51d4972ca6d7	${emailScopeConsentText}	consent.screen.text
db4fa263-45bd-4efd-a612-51d4972ca6d7	true	include.in.token.scope
130e15d8-94d1-4e6a-bd38-f507ed5468ba	true	display.on.consent.screen
130e15d8-94d1-4e6a-bd38-f507ed5468ba	${addressScopeConsentText}	consent.screen.text
130e15d8-94d1-4e6a-bd38-f507ed5468ba	true	include.in.token.scope
41ea5502-3b1c-4aaa-9708-b6545251311f	true	display.on.consent.screen
41ea5502-3b1c-4aaa-9708-b6545251311f	${phoneScopeConsentText}	consent.screen.text
41ea5502-3b1c-4aaa-9708-b6545251311f	true	include.in.token.scope
b2619f52-3b42-4375-8960-a8def3c96d39	true	display.on.consent.screen
b2619f52-3b42-4375-8960-a8def3c96d39	${rolesScopeConsentText}	consent.screen.text
b2619f52-3b42-4375-8960-a8def3c96d39	false	include.in.token.scope
db76de7b-5f64-43e1-81b5-86bca09fb0bb	false	display.on.consent.screen
db76de7b-5f64-43e1-81b5-86bca09fb0bb		consent.screen.text
db76de7b-5f64-43e1-81b5-86bca09fb0bb	false	include.in.token.scope
363cdf68-d20b-4a1b-a263-fee42b8695c3	false	display.on.consent.screen
363cdf68-d20b-4a1b-a263-fee42b8695c3	true	include.in.token.scope
d984e2db-6e4b-4a85-8d41-5e049f274145	false	display.on.consent.screen
d984e2db-6e4b-4a85-8d41-5e049f274145	false	include.in.token.scope
f0ac861f-3f0e-4c7a-bfb8-5d8c7a26680e	false	display.on.consent.screen
f0ac861f-3f0e-4c7a-bfb8-5d8c7a26680e	false	include.in.token.scope
a5e4ec15-29cd-4ace-a76f-09d80b16b636	false	display.on.consent.screen
a5e4ec15-29cd-4ace-a76f-09d80b16b636	false	include.in.token.scope
6c8fe887-ac8c-4c77-a801-8b52f956833a	true	display.on.consent.screen
6c8fe887-ac8c-4c77-a801-8b52f956833a	${organizationScopeConsentText}	consent.screen.text
6c8fe887-ac8c-4c77-a801-8b52f956833a	true	include.in.token.scope
b3d140e6-1c36-4d74-9cbf-361707af3dae	true	display.on.consent.screen
b3d140e6-1c36-4d74-9cbf-361707af3dae		consent.screen.text
b3d140e6-1c36-4d74-9cbf-361707af3dae	true	include.in.token.scope
b3d140e6-1c36-4d74-9cbf-361707af3dae		gui.order
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
21a58005-5b16-4573-a738-7f8ead425601	285c0f70-91a0-483d-a961-4abcf1b53b15	t
21a58005-5b16-4573-a738-7f8ead425601	63b93bb7-9496-4b07-bbc5-2c44fc521b6d	t
21a58005-5b16-4573-a738-7f8ead425601	baf14ede-f1ce-468d-b3cc-86a1f5036cbe	t
21a58005-5b16-4573-a738-7f8ead425601	284ac003-5e92-4715-819a-d053bfb5d35b	t
21a58005-5b16-4573-a738-7f8ead425601	5159c8bb-b08a-4f3c-992a-b5a39c1b4779	t
21a58005-5b16-4573-a738-7f8ead425601	9711cbec-2695-4017-b902-d18284e917bf	t
21a58005-5b16-4573-a738-7f8ead425601	df8d0e89-d1e8-4d2a-b360-83b3926dc53a	f
21a58005-5b16-4573-a738-7f8ead425601	3bac3b68-c660-43d8-8099-04e5dbb3b835	f
21a58005-5b16-4573-a738-7f8ead425601	4f7c1ae3-2df4-4064-9026-cd6fde4195f6	f
21a58005-5b16-4573-a738-7f8ead425601	79844d2e-3022-495b-b9a7-5a64d4a07c92	f
21a58005-5b16-4573-a738-7f8ead425601	5f5924d8-2cf7-411b-b2f2-9494cb19a710	f
8043b157-f18f-453a-af2b-f982773b836d	285c0f70-91a0-483d-a961-4abcf1b53b15	t
8043b157-f18f-453a-af2b-f982773b836d	63b93bb7-9496-4b07-bbc5-2c44fc521b6d	t
8043b157-f18f-453a-af2b-f982773b836d	baf14ede-f1ce-468d-b3cc-86a1f5036cbe	t
8043b157-f18f-453a-af2b-f982773b836d	284ac003-5e92-4715-819a-d053bfb5d35b	t
8043b157-f18f-453a-af2b-f982773b836d	5159c8bb-b08a-4f3c-992a-b5a39c1b4779	t
8043b157-f18f-453a-af2b-f982773b836d	9711cbec-2695-4017-b902-d18284e917bf	t
8043b157-f18f-453a-af2b-f982773b836d	df8d0e89-d1e8-4d2a-b360-83b3926dc53a	f
8043b157-f18f-453a-af2b-f982773b836d	3bac3b68-c660-43d8-8099-04e5dbb3b835	f
8043b157-f18f-453a-af2b-f982773b836d	4f7c1ae3-2df4-4064-9026-cd6fde4195f6	f
8043b157-f18f-453a-af2b-f982773b836d	79844d2e-3022-495b-b9a7-5a64d4a07c92	f
8043b157-f18f-453a-af2b-f982773b836d	5f5924d8-2cf7-411b-b2f2-9494cb19a710	f
1ae80258-fca9-40d4-bb17-509fa72ecf01	285c0f70-91a0-483d-a961-4abcf1b53b15	t
1ae80258-fca9-40d4-bb17-509fa72ecf01	63b93bb7-9496-4b07-bbc5-2c44fc521b6d	t
1ae80258-fca9-40d4-bb17-509fa72ecf01	baf14ede-f1ce-468d-b3cc-86a1f5036cbe	t
1ae80258-fca9-40d4-bb17-509fa72ecf01	284ac003-5e92-4715-819a-d053bfb5d35b	t
1ae80258-fca9-40d4-bb17-509fa72ecf01	5159c8bb-b08a-4f3c-992a-b5a39c1b4779	t
1ae80258-fca9-40d4-bb17-509fa72ecf01	9711cbec-2695-4017-b902-d18284e917bf	t
1ae80258-fca9-40d4-bb17-509fa72ecf01	df8d0e89-d1e8-4d2a-b360-83b3926dc53a	f
1ae80258-fca9-40d4-bb17-509fa72ecf01	3bac3b68-c660-43d8-8099-04e5dbb3b835	f
1ae80258-fca9-40d4-bb17-509fa72ecf01	4f7c1ae3-2df4-4064-9026-cd6fde4195f6	f
1ae80258-fca9-40d4-bb17-509fa72ecf01	79844d2e-3022-495b-b9a7-5a64d4a07c92	f
1ae80258-fca9-40d4-bb17-509fa72ecf01	5f5924d8-2cf7-411b-b2f2-9494cb19a710	f
46ea88a6-96e5-423e-a421-417b0b7ed4c3	285c0f70-91a0-483d-a961-4abcf1b53b15	t
46ea88a6-96e5-423e-a421-417b0b7ed4c3	63b93bb7-9496-4b07-bbc5-2c44fc521b6d	t
46ea88a6-96e5-423e-a421-417b0b7ed4c3	baf14ede-f1ce-468d-b3cc-86a1f5036cbe	t
46ea88a6-96e5-423e-a421-417b0b7ed4c3	284ac003-5e92-4715-819a-d053bfb5d35b	t
46ea88a6-96e5-423e-a421-417b0b7ed4c3	5159c8bb-b08a-4f3c-992a-b5a39c1b4779	t
46ea88a6-96e5-423e-a421-417b0b7ed4c3	9711cbec-2695-4017-b902-d18284e917bf	t
46ea88a6-96e5-423e-a421-417b0b7ed4c3	df8d0e89-d1e8-4d2a-b360-83b3926dc53a	f
46ea88a6-96e5-423e-a421-417b0b7ed4c3	3bac3b68-c660-43d8-8099-04e5dbb3b835	f
46ea88a6-96e5-423e-a421-417b0b7ed4c3	4f7c1ae3-2df4-4064-9026-cd6fde4195f6	f
46ea88a6-96e5-423e-a421-417b0b7ed4c3	79844d2e-3022-495b-b9a7-5a64d4a07c92	f
46ea88a6-96e5-423e-a421-417b0b7ed4c3	5f5924d8-2cf7-411b-b2f2-9494cb19a710	f
c15b624c-74e1-4846-9b13-437b714eb009	285c0f70-91a0-483d-a961-4abcf1b53b15	t
c15b624c-74e1-4846-9b13-437b714eb009	63b93bb7-9496-4b07-bbc5-2c44fc521b6d	t
c15b624c-74e1-4846-9b13-437b714eb009	baf14ede-f1ce-468d-b3cc-86a1f5036cbe	t
c15b624c-74e1-4846-9b13-437b714eb009	284ac003-5e92-4715-819a-d053bfb5d35b	t
c15b624c-74e1-4846-9b13-437b714eb009	5159c8bb-b08a-4f3c-992a-b5a39c1b4779	t
c15b624c-74e1-4846-9b13-437b714eb009	9711cbec-2695-4017-b902-d18284e917bf	t
c15b624c-74e1-4846-9b13-437b714eb009	df8d0e89-d1e8-4d2a-b360-83b3926dc53a	f
c15b624c-74e1-4846-9b13-437b714eb009	3bac3b68-c660-43d8-8099-04e5dbb3b835	f
c15b624c-74e1-4846-9b13-437b714eb009	4f7c1ae3-2df4-4064-9026-cd6fde4195f6	f
c15b624c-74e1-4846-9b13-437b714eb009	79844d2e-3022-495b-b9a7-5a64d4a07c92	f
c15b624c-74e1-4846-9b13-437b714eb009	5f5924d8-2cf7-411b-b2f2-9494cb19a710	f
37270d19-ac39-4c63-b628-eb5e3371546d	285c0f70-91a0-483d-a961-4abcf1b53b15	t
37270d19-ac39-4c63-b628-eb5e3371546d	63b93bb7-9496-4b07-bbc5-2c44fc521b6d	t
37270d19-ac39-4c63-b628-eb5e3371546d	baf14ede-f1ce-468d-b3cc-86a1f5036cbe	t
37270d19-ac39-4c63-b628-eb5e3371546d	284ac003-5e92-4715-819a-d053bfb5d35b	t
37270d19-ac39-4c63-b628-eb5e3371546d	5159c8bb-b08a-4f3c-992a-b5a39c1b4779	t
37270d19-ac39-4c63-b628-eb5e3371546d	9711cbec-2695-4017-b902-d18284e917bf	t
37270d19-ac39-4c63-b628-eb5e3371546d	df8d0e89-d1e8-4d2a-b360-83b3926dc53a	f
37270d19-ac39-4c63-b628-eb5e3371546d	3bac3b68-c660-43d8-8099-04e5dbb3b835	f
37270d19-ac39-4c63-b628-eb5e3371546d	4f7c1ae3-2df4-4064-9026-cd6fde4195f6	f
37270d19-ac39-4c63-b628-eb5e3371546d	79844d2e-3022-495b-b9a7-5a64d4a07c92	f
37270d19-ac39-4c63-b628-eb5e3371546d	5f5924d8-2cf7-411b-b2f2-9494cb19a710	f
a4cb068a-7f7e-4441-ab59-466479c727f8	f0ac861f-3f0e-4c7a-bfb8-5d8c7a26680e	t
a4cb068a-7f7e-4441-ab59-466479c727f8	db76de7b-5f64-43e1-81b5-86bca09fb0bb	t
a4cb068a-7f7e-4441-ab59-466479c727f8	d984e2db-6e4b-4a85-8d41-5e049f274145	t
a4cb068a-7f7e-4441-ab59-466479c727f8	b2619f52-3b42-4375-8960-a8def3c96d39	t
a4cb068a-7f7e-4441-ab59-466479c727f8	db4fa263-45bd-4efd-a612-51d4972ca6d7	t
a4cb068a-7f7e-4441-ab59-466479c727f8	33930219-11f7-43a5-b413-9ce7a1ae60a1	t
a4cb068a-7f7e-4441-ab59-466479c727f8	363cdf68-d20b-4a1b-a263-fee42b8695c3	f
a4cb068a-7f7e-4441-ab59-466479c727f8	41ea5502-3b1c-4aaa-9708-b6545251311f	f
a4cb068a-7f7e-4441-ab59-466479c727f8	ee214e36-9f2f-4207-84ac-ce12848b0550	f
a4cb068a-7f7e-4441-ab59-466479c727f8	6c8fe887-ac8c-4c77-a801-8b52f956833a	f
a4cb068a-7f7e-4441-ab59-466479c727f8	130e15d8-94d1-4e6a-bd38-f507ed5468ba	f
91ac20eb-19d4-4312-86e0-6e13b2fbb0d4	f0ac861f-3f0e-4c7a-bfb8-5d8c7a26680e	t
91ac20eb-19d4-4312-86e0-6e13b2fbb0d4	db76de7b-5f64-43e1-81b5-86bca09fb0bb	t
91ac20eb-19d4-4312-86e0-6e13b2fbb0d4	d984e2db-6e4b-4a85-8d41-5e049f274145	t
91ac20eb-19d4-4312-86e0-6e13b2fbb0d4	b2619f52-3b42-4375-8960-a8def3c96d39	t
91ac20eb-19d4-4312-86e0-6e13b2fbb0d4	db4fa263-45bd-4efd-a612-51d4972ca6d7	t
91ac20eb-19d4-4312-86e0-6e13b2fbb0d4	33930219-11f7-43a5-b413-9ce7a1ae60a1	t
91ac20eb-19d4-4312-86e0-6e13b2fbb0d4	363cdf68-d20b-4a1b-a263-fee42b8695c3	f
91ac20eb-19d4-4312-86e0-6e13b2fbb0d4	41ea5502-3b1c-4aaa-9708-b6545251311f	f
91ac20eb-19d4-4312-86e0-6e13b2fbb0d4	ee214e36-9f2f-4207-84ac-ce12848b0550	f
91ac20eb-19d4-4312-86e0-6e13b2fbb0d4	6c8fe887-ac8c-4c77-a801-8b52f956833a	f
91ac20eb-19d4-4312-86e0-6e13b2fbb0d4	130e15d8-94d1-4e6a-bd38-f507ed5468ba	f
c7ec91f0-159e-4664-b306-e59567bff305	f0ac861f-3f0e-4c7a-bfb8-5d8c7a26680e	t
c7ec91f0-159e-4664-b306-e59567bff305	db76de7b-5f64-43e1-81b5-86bca09fb0bb	t
c7ec91f0-159e-4664-b306-e59567bff305	d984e2db-6e4b-4a85-8d41-5e049f274145	t
c7ec91f0-159e-4664-b306-e59567bff305	b2619f52-3b42-4375-8960-a8def3c96d39	t
c7ec91f0-159e-4664-b306-e59567bff305	db4fa263-45bd-4efd-a612-51d4972ca6d7	t
c7ec91f0-159e-4664-b306-e59567bff305	33930219-11f7-43a5-b413-9ce7a1ae60a1	t
c7ec91f0-159e-4664-b306-e59567bff305	363cdf68-d20b-4a1b-a263-fee42b8695c3	f
c7ec91f0-159e-4664-b306-e59567bff305	41ea5502-3b1c-4aaa-9708-b6545251311f	f
c7ec91f0-159e-4664-b306-e59567bff305	ee214e36-9f2f-4207-84ac-ce12848b0550	f
c7ec91f0-159e-4664-b306-e59567bff305	6c8fe887-ac8c-4c77-a801-8b52f956833a	f
c7ec91f0-159e-4664-b306-e59567bff305	130e15d8-94d1-4e6a-bd38-f507ed5468ba	f
2b8a29d1-dfc3-4f71-b5b2-1024060b950d	f0ac861f-3f0e-4c7a-bfb8-5d8c7a26680e	t
2b8a29d1-dfc3-4f71-b5b2-1024060b950d	db76de7b-5f64-43e1-81b5-86bca09fb0bb	t
2b8a29d1-dfc3-4f71-b5b2-1024060b950d	d984e2db-6e4b-4a85-8d41-5e049f274145	t
2b8a29d1-dfc3-4f71-b5b2-1024060b950d	b2619f52-3b42-4375-8960-a8def3c96d39	t
2b8a29d1-dfc3-4f71-b5b2-1024060b950d	db4fa263-45bd-4efd-a612-51d4972ca6d7	t
2b8a29d1-dfc3-4f71-b5b2-1024060b950d	33930219-11f7-43a5-b413-9ce7a1ae60a1	t
2b8a29d1-dfc3-4f71-b5b2-1024060b950d	363cdf68-d20b-4a1b-a263-fee42b8695c3	f
2b8a29d1-dfc3-4f71-b5b2-1024060b950d	41ea5502-3b1c-4aaa-9708-b6545251311f	f
2b8a29d1-dfc3-4f71-b5b2-1024060b950d	ee214e36-9f2f-4207-84ac-ce12848b0550	f
2b8a29d1-dfc3-4f71-b5b2-1024060b950d	6c8fe887-ac8c-4c77-a801-8b52f956833a	f
2b8a29d1-dfc3-4f71-b5b2-1024060b950d	130e15d8-94d1-4e6a-bd38-f507ed5468ba	f
16f41b45-36c4-4db5-adfd-33de04c58368	f0ac861f-3f0e-4c7a-bfb8-5d8c7a26680e	t
16f41b45-36c4-4db5-adfd-33de04c58368	db76de7b-5f64-43e1-81b5-86bca09fb0bb	t
16f41b45-36c4-4db5-adfd-33de04c58368	d984e2db-6e4b-4a85-8d41-5e049f274145	t
16f41b45-36c4-4db5-adfd-33de04c58368	b2619f52-3b42-4375-8960-a8def3c96d39	t
16f41b45-36c4-4db5-adfd-33de04c58368	db4fa263-45bd-4efd-a612-51d4972ca6d7	t
16f41b45-36c4-4db5-adfd-33de04c58368	33930219-11f7-43a5-b413-9ce7a1ae60a1	t
16f41b45-36c4-4db5-adfd-33de04c58368	363cdf68-d20b-4a1b-a263-fee42b8695c3	f
16f41b45-36c4-4db5-adfd-33de04c58368	41ea5502-3b1c-4aaa-9708-b6545251311f	f
16f41b45-36c4-4db5-adfd-33de04c58368	ee214e36-9f2f-4207-84ac-ce12848b0550	f
16f41b45-36c4-4db5-adfd-33de04c58368	6c8fe887-ac8c-4c77-a801-8b52f956833a	f
16f41b45-36c4-4db5-adfd-33de04c58368	130e15d8-94d1-4e6a-bd38-f507ed5468ba	f
d69b827d-2fd5-42b4-a977-55b636ca4ecc	f0ac861f-3f0e-4c7a-bfb8-5d8c7a26680e	t
d69b827d-2fd5-42b4-a977-55b636ca4ecc	db76de7b-5f64-43e1-81b5-86bca09fb0bb	t
d69b827d-2fd5-42b4-a977-55b636ca4ecc	d984e2db-6e4b-4a85-8d41-5e049f274145	t
d69b827d-2fd5-42b4-a977-55b636ca4ecc	b2619f52-3b42-4375-8960-a8def3c96d39	t
d69b827d-2fd5-42b4-a977-55b636ca4ecc	db4fa263-45bd-4efd-a612-51d4972ca6d7	t
d69b827d-2fd5-42b4-a977-55b636ca4ecc	33930219-11f7-43a5-b413-9ce7a1ae60a1	t
d69b827d-2fd5-42b4-a977-55b636ca4ecc	363cdf68-d20b-4a1b-a263-fee42b8695c3	f
d69b827d-2fd5-42b4-a977-55b636ca4ecc	41ea5502-3b1c-4aaa-9708-b6545251311f	f
d69b827d-2fd5-42b4-a977-55b636ca4ecc	ee214e36-9f2f-4207-84ac-ce12848b0550	f
d69b827d-2fd5-42b4-a977-55b636ca4ecc	6c8fe887-ac8c-4c77-a801-8b52f956833a	f
d69b827d-2fd5-42b4-a977-55b636ca4ecc	130e15d8-94d1-4e6a-bd38-f507ed5468ba	f
c7ec91f0-159e-4664-b306-e59567bff305	a5e4ec15-29cd-4ace-a76f-09d80b16b636	t
975635d5-0c2b-4fce-a2a3-dd81ab1eac7a	f0ac861f-3f0e-4c7a-bfb8-5d8c7a26680e	t
975635d5-0c2b-4fce-a2a3-dd81ab1eac7a	db76de7b-5f64-43e1-81b5-86bca09fb0bb	t
975635d5-0c2b-4fce-a2a3-dd81ab1eac7a	d984e2db-6e4b-4a85-8d41-5e049f274145	t
975635d5-0c2b-4fce-a2a3-dd81ab1eac7a	b2619f52-3b42-4375-8960-a8def3c96d39	t
975635d5-0c2b-4fce-a2a3-dd81ab1eac7a	db4fa263-45bd-4efd-a612-51d4972ca6d7	t
975635d5-0c2b-4fce-a2a3-dd81ab1eac7a	33930219-11f7-43a5-b413-9ce7a1ae60a1	t
975635d5-0c2b-4fce-a2a3-dd81ab1eac7a	363cdf68-d20b-4a1b-a263-fee42b8695c3	f
975635d5-0c2b-4fce-a2a3-dd81ab1eac7a	41ea5502-3b1c-4aaa-9708-b6545251311f	f
975635d5-0c2b-4fce-a2a3-dd81ab1eac7a	ee214e36-9f2f-4207-84ac-ce12848b0550	f
975635d5-0c2b-4fce-a2a3-dd81ab1eac7a	130e15d8-94d1-4e6a-bd38-f507ed5468ba	f
6905d5cc-a4c4-41c7-8e03-b991b5a6076e	f0ac861f-3f0e-4c7a-bfb8-5d8c7a26680e	t
6905d5cc-a4c4-41c7-8e03-b991b5a6076e	db76de7b-5f64-43e1-81b5-86bca09fb0bb	t
6905d5cc-a4c4-41c7-8e03-b991b5a6076e	d984e2db-6e4b-4a85-8d41-5e049f274145	t
6905d5cc-a4c4-41c7-8e03-b991b5a6076e	b2619f52-3b42-4375-8960-a8def3c96d39	t
6905d5cc-a4c4-41c7-8e03-b991b5a6076e	db4fa263-45bd-4efd-a612-51d4972ca6d7	t
6905d5cc-a4c4-41c7-8e03-b991b5a6076e	33930219-11f7-43a5-b413-9ce7a1ae60a1	t
6905d5cc-a4c4-41c7-8e03-b991b5a6076e	363cdf68-d20b-4a1b-a263-fee42b8695c3	f
6905d5cc-a4c4-41c7-8e03-b991b5a6076e	41ea5502-3b1c-4aaa-9708-b6545251311f	f
6905d5cc-a4c4-41c7-8e03-b991b5a6076e	ee214e36-9f2f-4207-84ac-ce12848b0550	f
6905d5cc-a4c4-41c7-8e03-b991b5a6076e	130e15d8-94d1-4e6a-bd38-f507ed5468ba	f
975635d5-0c2b-4fce-a2a3-dd81ab1eac7a	b3d140e6-1c36-4d74-9cbf-361707af3dae	t
6905d5cc-a4c4-41c7-8e03-b991b5a6076e	b3d140e6-1c36-4d74-9cbf-361707af3dae	f
6905d5cc-a4c4-41c7-8e03-b991b5a6076e	6c8fe887-ac8c-4c77-a801-8b52f956833a	t
975635d5-0c2b-4fce-a2a3-dd81ab1eac7a	6c8fe887-ac8c-4c77-a801-8b52f956833a	t
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
79844d2e-3022-495b-b9a7-5a64d4a07c92	6f945141-2201-4835-9872-0ddf395b939e
ee214e36-9f2f-4207-84ac-ce12848b0550	52aac5e2-8b15-48c8-9b31-2e068b0518e3
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
ffe1002d-ee95-4563-b556-9fe0e2105651	Trusted Hosts	d1e198d9-8425-49d2-bc78-93f0a86674d0	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d1e198d9-8425-49d2-bc78-93f0a86674d0	anonymous
17a95ef1-f33e-414a-b53a-4a63207ab242	Consent Required	d1e198d9-8425-49d2-bc78-93f0a86674d0	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d1e198d9-8425-49d2-bc78-93f0a86674d0	anonymous
c9789592-e91f-4ee3-96f5-887c4b97371f	Full Scope Disabled	d1e198d9-8425-49d2-bc78-93f0a86674d0	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d1e198d9-8425-49d2-bc78-93f0a86674d0	anonymous
ef2014a7-0597-4d57-a85a-dc2a4c9b03e3	Max Clients Limit	d1e198d9-8425-49d2-bc78-93f0a86674d0	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d1e198d9-8425-49d2-bc78-93f0a86674d0	anonymous
bfbe0d48-72a7-4bf1-8c17-c28b2e9e0f9a	Allowed Protocol Mapper Types	d1e198d9-8425-49d2-bc78-93f0a86674d0	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d1e198d9-8425-49d2-bc78-93f0a86674d0	anonymous
a597513b-087b-4eeb-a316-7db7c6785de5	Allowed Client Scopes	d1e198d9-8425-49d2-bc78-93f0a86674d0	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d1e198d9-8425-49d2-bc78-93f0a86674d0	anonymous
aedda01b-e1a3-4160-b1b6-ab98f06354bc	Allowed Protocol Mapper Types	d1e198d9-8425-49d2-bc78-93f0a86674d0	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d1e198d9-8425-49d2-bc78-93f0a86674d0	authenticated
013231d1-5d64-4606-a35f-99913ad900de	Allowed Client Scopes	d1e198d9-8425-49d2-bc78-93f0a86674d0	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d1e198d9-8425-49d2-bc78-93f0a86674d0	authenticated
699314ba-552f-47cd-a8e0-c34054630e00	rsa-generated	d1e198d9-8425-49d2-bc78-93f0a86674d0	rsa-generated	org.keycloak.keys.KeyProvider	d1e198d9-8425-49d2-bc78-93f0a86674d0	\N
189d3a1f-51d3-4f83-82d9-4b1ba48a1f01	rsa-enc-generated	d1e198d9-8425-49d2-bc78-93f0a86674d0	rsa-enc-generated	org.keycloak.keys.KeyProvider	d1e198d9-8425-49d2-bc78-93f0a86674d0	\N
723430f7-5241-461e-bd72-cfd93945d07a	hmac-generated-hs512	d1e198d9-8425-49d2-bc78-93f0a86674d0	hmac-generated	org.keycloak.keys.KeyProvider	d1e198d9-8425-49d2-bc78-93f0a86674d0	\N
fccebe61-2075-41ad-8d3a-15c399118df7	aes-generated	d1e198d9-8425-49d2-bc78-93f0a86674d0	aes-generated	org.keycloak.keys.KeyProvider	d1e198d9-8425-49d2-bc78-93f0a86674d0	\N
a4be6799-259b-44ae-bd63-31ce1ea4d60f	\N	d1e198d9-8425-49d2-bc78-93f0a86674d0	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	d1e198d9-8425-49d2-bc78-93f0a86674d0	\N
c8a918ee-198f-48c3-9e99-71b09d8fdc47	rsa-generated	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	rsa-generated	org.keycloak.keys.KeyProvider	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	\N
9ad23cf7-cc8e-4754-9077-d29ca33524a5	rsa-enc-generated	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	rsa-enc-generated	org.keycloak.keys.KeyProvider	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	\N
9e45d639-9fae-4f28-bd53-9d0529bde049	hmac-generated-hs512	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	hmac-generated	org.keycloak.keys.KeyProvider	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	\N
fa3d3bab-cf52-47d2-97ec-2f53340d7adc	aes-generated	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	aes-generated	org.keycloak.keys.KeyProvider	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	\N
0beb3f91-8486-4df5-9ba8-803386819b73	Trusted Hosts	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	anonymous
120bf1dd-5273-41fb-ba0b-d51f3426a4ef	Consent Required	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	anonymous
05bc2e88-2017-4018-8cb6-1164cc11f2d0	Full Scope Disabled	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	anonymous
8eb26305-4938-440a-a8bc-c7dfa3250104	Max Clients Limit	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	anonymous
4f0028bd-4c1a-42cc-beb9-6c96a6ec45c0	Allowed Protocol Mapper Types	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	anonymous
6da42ceb-f3f4-49b1-867d-21362be59dd8	Allowed Client Scopes	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	anonymous
e16ca399-3b0a-42f8-b565-2c5d4e9b426d	Allowed Protocol Mapper Types	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	authenticated
8e54c58f-56b2-4949-b32e-cfd92852e4f5	Allowed Client Scopes	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
7bf35cec-b1b9-4b9e-bdf6-9a238e98627d	ffe1002d-ee95-4563-b556-9fe0e2105651	host-sending-registration-request-must-match	true
5aacd023-952b-4cb8-ae37-3c9e2e59f38b	ffe1002d-ee95-4563-b556-9fe0e2105651	client-uris-must-match	true
9acacc73-3424-4380-aa35-6db71e840253	013231d1-5d64-4606-a35f-99913ad900de	allow-default-scopes	true
238bf27f-bc8e-477a-b44d-f7815c91c8df	aedda01b-e1a3-4160-b1b6-ab98f06354bc	allowed-protocol-mapper-types	saml-user-attribute-mapper
61b7b65a-5b90-4134-9a6a-04e8afe45b7e	aedda01b-e1a3-4160-b1b6-ab98f06354bc	allowed-protocol-mapper-types	saml-role-list-mapper
e4ba2dc7-9d5c-4468-ba76-cfc50f911866	aedda01b-e1a3-4160-b1b6-ab98f06354bc	allowed-protocol-mapper-types	oidc-full-name-mapper
d0097aa2-9c7d-4991-8172-b4e5d688ba1f	aedda01b-e1a3-4160-b1b6-ab98f06354bc	allowed-protocol-mapper-types	saml-user-property-mapper
03eb57cb-c1b7-4e27-808b-e0f7176330ba	aedda01b-e1a3-4160-b1b6-ab98f06354bc	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
a9cb8856-2f88-40ee-933f-47ba96a04134	aedda01b-e1a3-4160-b1b6-ab98f06354bc	allowed-protocol-mapper-types	oidc-address-mapper
a3a8059d-e1c1-452e-b0a6-86f259a574e5	aedda01b-e1a3-4160-b1b6-ab98f06354bc	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
2b6e3a62-114b-475f-9352-890b4338bef1	aedda01b-e1a3-4160-b1b6-ab98f06354bc	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
78bebbba-5e11-44ee-ad36-6521ffffc003	ef2014a7-0597-4d57-a85a-dc2a4c9b03e3	max-clients	200
ee4d2f56-b085-4a06-b78b-33c170516689	a597513b-087b-4eeb-a316-7db7c6785de5	allow-default-scopes	true
ba585783-c9c3-48f4-bbc8-711f3ea9d9e7	bfbe0d48-72a7-4bf1-8c17-c28b2e9e0f9a	allowed-protocol-mapper-types	saml-user-property-mapper
7dc798c0-bdc4-4e82-84b3-f63d28ff980f	bfbe0d48-72a7-4bf1-8c17-c28b2e9e0f9a	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
a89cb5cd-0ce7-4d51-88aa-538aacc81e4a	bfbe0d48-72a7-4bf1-8c17-c28b2e9e0f9a	allowed-protocol-mapper-types	oidc-full-name-mapper
48ef19e4-f609-459b-bbfb-6d7c0384ebd4	bfbe0d48-72a7-4bf1-8c17-c28b2e9e0f9a	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
007ba63d-e62c-4452-9a0a-7a5ea16b8048	bfbe0d48-72a7-4bf1-8c17-c28b2e9e0f9a	allowed-protocol-mapper-types	saml-user-attribute-mapper
85f484d4-1d0b-492c-9600-ff09db9d3903	bfbe0d48-72a7-4bf1-8c17-c28b2e9e0f9a	allowed-protocol-mapper-types	oidc-address-mapper
b0e067fe-175a-4b3f-9137-290dc2a58ad2	bfbe0d48-72a7-4bf1-8c17-c28b2e9e0f9a	allowed-protocol-mapper-types	saml-role-list-mapper
34ae0f1d-8fb9-4419-8aaf-684953185036	bfbe0d48-72a7-4bf1-8c17-c28b2e9e0f9a	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
d5e9a1fe-1d04-4845-9730-7eb788e736ff	699314ba-552f-47cd-a8e0-c34054630e00	priority	100
8221098b-cf1b-48bd-8b0d-eba50a018d68	699314ba-552f-47cd-a8e0-c34054630e00	privateKey	MIIEpAIBAAKCAQEAv4jStXy90wHyVeV3TJJSPccuowG3hUkiKMmJdQxTCS7J5o4Fm9b3G4Rr1I3YR/GB0wr64tjppYlQj1r/5u6ROqTCmrCMw4s0pQYj+H2dKsp1D9l1dn+U8VSXKQog/q67nvNkk9m1ZL9nGdZV/p85tN3VEfuny0d3MuQqwjfRIAsU6TYr42ZeJvOy/9OKNCfyCPoAu3EQrazlAm3fSQDunMy0852/5Ek82gQPdwRsLFMRHGHvpUD7rSm1a3ab/8LTUl4JxLJlP3XIIlXy2LOdcdr5T1pKaNo0RLwXl+d9I4TJ1BNW3ccqHKzB17y0s+5l/5Qpf+9woP6PN+yHOjKbKQIDAQABAoIBABUBGTJj6qFAPmYjEvEnvrMdq8SehJSuT3uvlk5qupRwOB37hyvu6Axxei3GHGjPWFBfjOHhrcXEiDwgW53knbKTrO+v2s/67RwHz1wJ0nmF2E6Tp2kGVrwcbbNHdBTZ7qNgx6/bGSRiRRk1Qxr4NSjbhulA8sa9IJpJIVNJMbrUq5rYQ/PJxKoTaaWOYeigCiXoVRHN6k7tNC/imCmauF+6XfBS9xUqHktETT4WmfJvnS4ccffqh2M+5iz1fnAIQZa7SuoivXJoIb3Rz6pDqIFVxDBmBY3ar3J1a+SvaT8wBHXLsFcUfvynN7w8UaC2SUWNwRiASZAsYShmOsDoTj0CgYEA7KEbDMwYYesUf15CTwerbueurV+RGMfCScjI3Tv/fkh54EKi8QJA/CvL4M9QoDTHT0DFMbC2ra4NkJKHNbidAQaCrp5RLTkfvBim35BYwKuD4Eh/cQf4YbaZ85COKqF7FMjfJme4/371W5awwonI5q6O3W2Hsr3t20CeD8Aogz8CgYEAzzaxRDR8vPFjU16Z1agpEB2Je6z7WyQE7OX7NNZwri9lHZ2/l+q3YRS2VGX0H/4v1gdLqxl12Rmi8zvmH82WiUapG+jOKMYzIl+LMFiDzD9UzKbjL5U8G617yI2W4DfVEtZo7/9XE/Te9ZKB42GcE5J0FmI3OaZMvw08C7jDj5cCgYEAwR8PQ5eCws+oT/cu6O8ahA5EKq1Xb0EBGVTsUlr4PymJhnT8JPSw8t4Pq++nHslUbSMwjUhrHz5xRa/A+CAuyzp0B22gVOdNNidscgON29lfbPneQPK/TYhJB1bQIIzgNetm7CI1AxiryM8ofe0T8OlAIgmVeVS3PnzzQ2mR5uMCgYBi3NFOnUw2SWT+TdBPo9+TlMQXgbybC2BeNovX9cflEy/HJZBXxuCfLOag9dO3v+rKzshHZepYHmckbZup6Mi9zjy42CYkRgv3hmY+Nr0LIdwvmCAkf6sh+W9pjERDzd+XET0X5FeDaf1GZRQbjGKO4/0HAO0gUDulm4begNStGQKBgQC+hirSvEgwXkBgG5C3lsoR5jSvITv0/7hNXJiAbHg2gJQNaRizP1IIfhsSOwP0vsbbvYFWJ5RNk/JWlk7xaF1KAZAcAkHi647oagTD/npFTFPhU9UMaRyC08JHuuVE0CKt+l07QXIWGvrGmG5dXJCxrfwSMidhxj0INFwy9rg9hQ==
3a42c80e-33d8-4c47-b221-531a26258294	699314ba-552f-47cd-a8e0-c34054630e00	certificate	MIICmzCCAYMCBgGbzaYJ4zANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjYwMTE3MjAyNzQ5WhcNMzYwMTE3MjAyOTI5WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC/iNK1fL3TAfJV5XdMklI9xy6jAbeFSSIoyYl1DFMJLsnmjgWb1vcbhGvUjdhH8YHTCvri2OmliVCPWv/m7pE6pMKasIzDizSlBiP4fZ0qynUP2XV2f5TxVJcpCiD+rrue82ST2bVkv2cZ1lX+nzm03dUR+6fLR3cy5CrCN9EgCxTpNivjZl4m87L/04o0J/II+gC7cRCtrOUCbd9JAO6czLTznb/kSTzaBA93BGwsUxEcYe+lQPutKbVrdpv/wtNSXgnEsmU/dcgiVfLYs51x2vlPWkpo2jREvBeX530jhMnUE1bdxyocrMHXvLSz7mX/lCl/73Cg/o837Ic6MpspAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAIPVgi53mlpsMlf8HG35u9tLcT5vSJE96brFbz281Fz73aX4O98ceL6AZDk5edJ9Bie7nsksXi75EbXHOklDcDCEUrrL/PHofZ+oU33DZ+dQjYM+WUxZXXDYZbCeaaFpgVyjeXB4QinlfqtA+5uSkcn0c70j55o/1DLiLkowPSu6iITfG6XDPafGqMhJ9B/Ho702n3kV+v9TlPOTi8+rAVK5Isi1E0mRsesplB6Ym0utBKLVy7+KnbujPYWXV7n17PfIfhPfZOv2Wx+S8paypI0IOFh//FtG4r/fUWrWlEfKvAFcXlkM7TQ/H9H387eaRGBJa+s6DUhfadr9oWjtBXA=
2f625499-da15-4e70-9fbf-838a06990dca	699314ba-552f-47cd-a8e0-c34054630e00	keyUse	SIG
20afd867-4405-4b93-af9f-e55fc766b590	189d3a1f-51d3-4f83-82d9-4b1ba48a1f01	algorithm	RSA-OAEP
a42fd223-3723-4827-bedf-a003582a4648	189d3a1f-51d3-4f83-82d9-4b1ba48a1f01	privateKey	MIIEpAIBAAKCAQEAxuNPs8bBKr1HlBt8LUtCvav/1B/Ipi4h/Eakix97hnPnPviVkx/NbHP2go9erAKnocuyYq5M0qYmJX+GWQxAhNiSEQfFvGqQgS8Iv5ajCRUT4wvfpfjPojk7U6Qe75UiUguwR3B/FHWDHzV67tVKEYevosn8QWHyCel30b6f492weiAOHlymYYMFUwZ6w9MrLBpPR3+J19vNzOjA1Gt/+eJ1kr35C89eiEADs9fIgljq2Zd4vOcaZrehCbIG2i14DQA2rO/bDPBW0tYnoGm+ioJQRps3tlHDB4Z1vDpMgZAXrYLQ6oNsefY/RId66r5GzX9LWn/NHXLJEgJKKtoigwIDAQABAoIBAEC93wSI9vloKwRB3C7MWHnwovMUs5aw3rxF7KsjAO1YDlcXyWzehdq/dueyLuG0bYgEDFoGHhjWIAXF2OBk1h3Id+fWTV5TnB2JR4JCUWkT9OjMRS28bC6FDdRg0PcxZz4o8uWWb6+jvx6qJI3ZXWaOcjR+JsDL1uO2HZxnvpmITaNRqqotwf6t2PjT8eEZMvLxDuUCRFHsS2nfU5jkC0kpJm3hsrpOC7+x38hcrf4NqZMJFl0sNRhmt71mUUBRxedrrVj9bzp0SbbY/3CcOkilE55j1NTWeZ/ebbul0op5qlXHU6ev13sXDqKF7d7N2jR1XZeuUUum1IergdfFurkCgYEA+Hh09ZqrWIqRzkdqDpXfDsXxRh58Xb03HPT9ZEe34TT382XRikP6N/gP1P53yStaLbCnKzTcfuOa2yGGnmmEMZh06YZyd8XR4AH1nVU3HM3RmAhXM+DY2uF1apzvGfqDYCg/otBaHsx2ZulTy0UPjVQzayFBHt0OI19tyRvKUqsCgYEAzOo1+51QNfLU+K+MemxBkdvD6h8j+eBN7WxG/8mo0vv9ig2UCkTzzcLTix94/S1S06OtgzjMmEC8tk49dcOrmDI/67WIAteGksMXuW2WZniXr0qsl2y4r9Enk/ryAwW33J/7+TNQLNQstQP8Xio/sfz26noa/Ls173kWjY8zr4kCgYEA9hMN+kNQ2OJ7XmiZn5JME6xzs/bzQj7nezUiUpM4h8BWo+Y9rIqAH7f7rfzKkx/tMnzWQlMa4Ev3jHfag76KXjfX6YLukLIIlao7HrNLXqpznfb8rfNLsRJCn/CGWBsiyzNxOoTQC9qAlJEWHKTrrxMpzTpk7PUOUHftGZP9PvsCgYAA6oclQdXK9/P1zKsfHP7KDSZ6FHuPsW4HwrUqjZdAojnG9TqVNSu13sodVB2xXBODuLac4JMhlyCA3CawMRjCTG82uZALGzWR0Gd5v8CtYpqjAP12i9jjiFbZ9YRBeTQSO3Df81fHa4dro8HsFdpFDHF6KOOX/6pFENCF/37mqQKBgQDysiCRR/1wwPS2gruoOf2g6/dwiBQRM4WwSzv0zIYwkBwzYSnBDRioSJSpmC+MTiMtgvL7+sQOvqPPsfz7WKAluGaBe+YE7w61trmnkrz1onX/MQrQHoQnDpLqSGiMQlbNZTEXOn3DNwz2tqHdzRiZN7g0baGH4L35K3RMYAKc7Q==
aa417c37-f5b7-4c5e-ba20-9b3124c8a6dd	189d3a1f-51d3-4f83-82d9-4b1ba48a1f01	certificate	MIICmzCCAYMCBgGbzaYKdTANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjYwMTE3MjAyNzQ5WhcNMzYwMTE3MjAyOTI5WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDG40+zxsEqvUeUG3wtS0K9q//UH8imLiH8RqSLH3uGc+c++JWTH81sc/aCj16sAqehy7JirkzSpiYlf4ZZDECE2JIRB8W8apCBLwi/lqMJFRPjC9+l+M+iOTtTpB7vlSJSC7BHcH8UdYMfNXru1UoRh6+iyfxBYfIJ6XfRvp/j3bB6IA4eXKZhgwVTBnrD0yssGk9Hf4nX283M6MDUa3/54nWSvfkLz16IQAOz18iCWOrZl3i85xpmt6EJsgbaLXgNADas79sM8FbS1iegab6KglBGmze2UcMHhnW8OkyBkBetgtDqg2x59j9Eh3rqvkbNf0taf80dcskSAkoq2iKDAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAD/qN5t5d/o74dwz33GywOamWlku/gAAjVF56T5vdIVD1M/fTuAw4+aLb7a/9ElhL3VG91SI3tKLuWAwhg1vN1YpGgoPMo4qxGkXd4BzTSEibiH3oMlZJlEkFo/P+PlkS2D+Be17PgqSOqwyDkraQAfZ/zUfsVNDFaRWa/FRU1K/ElN4dKX9cf/HCCz2ktIToBmm9RWZEGHEUFbslhWIVeWTfCyj0B6qBuppqoplcFTtvy96mseWAuMUO8yhfQUPKuPqdK3WsJ1UxA5YjZrBy/xdsgTvrijxTvVN8ELYayLnSz1o59t0ymCBeYna1Fm6ggxboZ8O1yYS9jCQhursjSo=
2e132c9d-064f-4f58-aa39-a499b5f78aa1	189d3a1f-51d3-4f83-82d9-4b1ba48a1f01	priority	100
bcb5faca-d276-4539-94ee-13901b1db3dd	189d3a1f-51d3-4f83-82d9-4b1ba48a1f01	keyUse	ENC
244682c9-09f3-4182-8d23-ed4f899238e6	a4be6799-259b-44ae-bd63-31ce1ea4d60f	kc.user.profile.config	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{},"up-username-not-idn-homograph":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"firstName","displayName":"${firstName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false},{"name":"lastName","displayName":"${lastName}","validations":{"length":{"max":255},"person-name-prohibited-characters":{}},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"multivalued":false}],"groups":[{"name":"user-metadata","displayHeader":"User metadata","displayDescription":"Attributes, which refer to user metadata"}]}
6055422b-86a9-4563-bfce-b1ad9134dfe4	723430f7-5241-461e-bd72-cfd93945d07a	kid	cdeb2b42-99a0-4ed3-bdf9-dc63c60f1bef
59643fe3-9c72-49ae-a575-539c0aa9e391	723430f7-5241-461e-bd72-cfd93945d07a	algorithm	HS512
fdbdad1e-5c41-4b92-9b17-b7e9b365253e	723430f7-5241-461e-bd72-cfd93945d07a	priority	100
5d9c4ffe-3396-4372-9b53-204f861d42b7	723430f7-5241-461e-bd72-cfd93945d07a	secret	_Q9t60EhU_hhCngAj4X-yCCJa6B8SvsX3cYp_gKSgvW9AEVhJ8kZxQCgWSApK2Ovg-KMwaMYO9ieX4EB7Qd8vP9woBEL8Dxd7XT5nVczQmkRZlHxiznw6r8s4VxY0Bu2JDiBkA77rr8t1UiOqbiRSZ1ry-kPfQYNbmotXEFIYdQ
ec017239-3cfe-4ebf-9cfc-6f7d7b1ac6c4	fccebe61-2075-41ad-8d3a-15c399118df7	kid	e9f628c1-e01a-43bc-a43d-a3eb6b331c7f
6d3f0b22-dbb8-41cd-8727-7e9d7a833af7	fccebe61-2075-41ad-8d3a-15c399118df7	secret	KFaCmB4yBKQjGvI50YwybA
881db19f-203b-46bd-85d1-fa0bc0bee905	fccebe61-2075-41ad-8d3a-15c399118df7	priority	100
ee77f6ec-a16e-4226-8cf8-d1ddd5e43998	c8a918ee-198f-48c3-9e99-71b09d8fdc47	keyUse	SIG
3821312c-a176-49d7-9428-daeb84c8ff85	c8a918ee-198f-48c3-9e99-71b09d8fdc47	priority	100
71cfc78e-419c-42b8-b180-9181d3dc3866	c8a918ee-198f-48c3-9e99-71b09d8fdc47	privateKey	MIIEogIBAAKCAQEAxW2DEIrOKXrwDYO/VauK6mvNmVtPKOVgfx+yuzdo2x1DgmLoh0JU/Kvu9hD+/3KbZ5QtWVe16zDwDUSginLz+Cz+9t/gws0EC5JPq5YE4MAn52gLSyydThcsJxNMIedsmwPOdpyx4QYipJMXiHWyHY3qWkJ7bGTBMzAYHwkDbGyr+sO6JpnBfIOV25860+U8srV83jdupOkl39RI6vhOVKWAwN4OccYiTR293apw0SjLSNKVC3ioD73MY1HgOMbl1PbINMlVHvbcEzVQ980KKxPPteXlv+GPpNwrqCfZ6fifu5m32lXA6lECz3n4/dCEuTXygoTN5YOEkJXfZxCONQIDAQABAoIBABzKdd7TczGy4y+BW0V9zPYXLwYyfeaHns0jHQA22iR8DcSFsoXJG1Y2p5Q8UceEWdvezMc25olsG1HABI50KZZzT2JGr0MRPUoHtfUenUr+UsNpFZ6KnM0OzYpMQuG920V25mS/QKSBbctkxP2KNmWfdMHhaJjbz53soVPjT1u/8pRiD2uPzahrECLmQkNmskwIzAH6qxKXLrzBAowsC406E5gPY1H//VtDtwg67SIi3Nd+tImv3lwUigWF+SlSC6kpiFCWo/uKf9rhJlz5hDIg3FheB/yBIjCTFiH+TdII6hL5W+WspsNpFuc9Lx2bbhEJ4LrKjAO1eZsHKlzCs5ECgYEA8EkSAojljHeSoMqax1A2TvhLC2em18twKrwYZuQnnEdB4XI/KsmSc1CLRWhaHrBsv8xVfcLiBTozbwG93rkcbJSkrvOjc2so8wkZX7onpbQa5+hZoBZKzs8sPT3D7L/Wi0s5hINLSr3xXXa3zUjyk/gPip0AksJPKHqt0KJaciUCgYEA0lbn+/GXbuCxpbGrPjMJ4bcXgY+QlMexeikGMvt2UgfhlofzJBf4qh/2Dze9nHNUQbEDvjdqGLNMH/kDPHrtCz4UMmqpIzj9wm5IIfYLM4Xe1jY7EVeDdlE8mU7Luhn7SnZnh6sAB7hGHEfqGxP51w3hPnloYPqte+n09UNyhtECgYBCApDkCV+mWyL48S/cGXkR8LwNAgift8+0rb+2ZG9NS3YZzRz1UDLfYv0fsC8xxx3ZAvVpeyREc1y13jCfAxN/8MXdGimJB6NUQOermKRTrUrG8tnMVNNwRRHOMS2l2H3D/oJqmPcSLWQlXPvZdXTOmZMLbV4+8wp0AF/HtRJL0QKBgCRG1tXOEgcOe7UPEnC0zsR+FnDC+PWgB00BXE9YrUxyjYavxdB4zetRfdecDni4L1TxGasp1YOTENMG2HcK4G0q9MLJQIiRoLpy2L/6tm3ZbdhWHBPemw7B7gim3V4ocv2htDNi26t5LaZdBNRMuq9LdoiW2di4A0m2zQer7UmxAoGAGIiqchUjF421WLpGuqOJc+jYzXUWp59ZkfbrthpQpjAFrdKa31Z8kM6l2EsLOELUBeikfPbmIMgHXOxvLu2fi5PmgFDCfyC+XjSTM7kigC65FaIw2PmMMAod9F31xu42NmtYBDBGg4ZaCa3KKcHRmk5vYun83HI8uk7+jzZYYgc=
4028e612-1830-4d5a-9f0d-d5768683c7f1	c8a918ee-198f-48c3-9e99-71b09d8fdc47	certificate	MIICmTCCAYECBgGbzasV5DANBgkqhkiG9w0BAQsFADAQMQ4wDAYDVQQDDAVib3h0eTAeFw0yNjAxMTcyMDMzMjBaFw0zNjAxMTcyMDM1MDBaMBAxDjAMBgNVBAMMBWJveHR5MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxW2DEIrOKXrwDYO/VauK6mvNmVtPKOVgfx+yuzdo2x1DgmLoh0JU/Kvu9hD+/3KbZ5QtWVe16zDwDUSginLz+Cz+9t/gws0EC5JPq5YE4MAn52gLSyydThcsJxNMIedsmwPOdpyx4QYipJMXiHWyHY3qWkJ7bGTBMzAYHwkDbGyr+sO6JpnBfIOV25860+U8srV83jdupOkl39RI6vhOVKWAwN4OccYiTR293apw0SjLSNKVC3ioD73MY1HgOMbl1PbINMlVHvbcEzVQ980KKxPPteXlv+GPpNwrqCfZ6fifu5m32lXA6lECz3n4/dCEuTXygoTN5YOEkJXfZxCONQIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQA7SHySZmL+ZnNuBw3ABJL2al6yJ+g4oljir+rDD7WC29+yIbNclPdtXiYZi1H2KkpiyNaCLyQU7CVOG3V2wEJiwZqIW5L7upPDVn2itx1zzRPnnn+Vg13VW4fEC//S4lu0Z9ddnALQG9M4YwZPYdhMI56VGdeh67kH1hptBDUSJrpGi1m2iuTiYdaPGE26nmJrvO9fs0kPZlS37bs2xBivSg/azv2uinyqfVTJYdpnmUp4Jto+Tyo3VC2+fQ6WBp5E7iptdxn/XEWkHD71HLtLduust/jX8mXWpYgaq8ih3PPNnGdTlHIBVKt53TZUrjnJRYhXbrTAN+1L7THJ++OR
69cf927e-0e25-452e-b0c8-4c6beab2d089	9e45d639-9fae-4f28-bd53-9d0529bde049	secret	v4AdCMVqttqR2It12rZMosE9PI08o2KIXbYfFzRKJqBawKG7_Vb1EwIOaY4yKLnebZM5aPCX1184X2pRUIpQjoop-GxKyDGXYvExyd1dcrGJsVXr6Dy5J16wUW2ueG1V6BTIgwgYoiVsbCq1IdluqQZbBoI-b6o_trZLKJ3Y1Ps
7327c905-addd-4e27-bf2a-3f4204e8a15a	9e45d639-9fae-4f28-bd53-9d0529bde049	priority	100
7b1de2a2-8dbb-4eb9-ac4a-a61d7df2584c	9e45d639-9fae-4f28-bd53-9d0529bde049	algorithm	HS512
cc720fe1-8566-459d-b8ef-30bb7e8c93af	9e45d639-9fae-4f28-bd53-9d0529bde049	kid	c0a7e268-d820-4b5c-b262-bc5fd962125e
2069a1a1-a15e-485e-8d7a-9410de4982d9	9ad23cf7-cc8e-4754-9077-d29ca33524a5	priority	100
912a711f-d57a-488a-93c5-d82e76a9a840	9ad23cf7-cc8e-4754-9077-d29ca33524a5	certificate	MIICmTCCAYECBgGbzasWSTANBgkqhkiG9w0BAQsFADAQMQ4wDAYDVQQDDAVib3h0eTAeFw0yNjAxMTcyMDMzMjBaFw0zNjAxMTcyMDM1MDBaMBAxDjAMBgNVBAMMBWJveHR5MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA2UycbWlSNrF0JsMX6cCP5Bw/t/43ipx8A5nkBzJ3/05rMC+4qNzniooz4fT6e9UrwzWOysltNlHPwvR1VzTxKkAs7ArioQ+J1UC83ys99J00wDtprCKGJbw70ZON8c+CEl0YpbORLaxDL9OJxeDuso9uLQhr2VViEU33wBZAGLYenPDcsYxLoGt5rklZ4+VkPj5LD6+ho7mjxvXy/7k3b84HBtqQIp7cIDE2I7vq7TPcPDqCGIDbJvPfwszu6wJJg7ArQJyWDHCjgrsk0kKI0uvTZuCWJYIV5Ca/QznqJ5DbKtB3tLor6DjV0CNwG1Rs4LPsljtZIcz/BpNAnjTziQIDAQABMA0GCSqGSIb3DQEBCwUAA4IBAQDXSgJ778mLiDuOWjo+9AOub96Ule6mR7wk1zvo6XP0oK2NlVvHlwa93RxjmoVkwnHUs87SA2t6lqIZCQezgEvdh3VkFyKGWHOzS2v96nVZV2d/ODMXCl3IcQ5zFpIIw8SsbWAEKu2vvTxbtFOcJ33p95ZjkvoTimo4ifwQ99Igbgcg6n3STMseKA3hXI9wKpnBnq0aKH2Gf+zVRVPeZm9+Y/A6qJzzS2ilwzlrPShvi66owODyjVDr3BGTQAsWKbJ2LymoRLRHJLCPpwiMUhD/7WuXGThcaXErkyam2m7C5PZB5nnl6KvjuE43WqVWcgYJJVnatswxY/jsVt1iP6Sy
881fbcd7-bc7d-4093-ae66-3fbccc16f07b	9ad23cf7-cc8e-4754-9077-d29ca33524a5	privateKey	MIIEpAIBAAKCAQEA2UycbWlSNrF0JsMX6cCP5Bw/t/43ipx8A5nkBzJ3/05rMC+4qNzniooz4fT6e9UrwzWOysltNlHPwvR1VzTxKkAs7ArioQ+J1UC83ys99J00wDtprCKGJbw70ZON8c+CEl0YpbORLaxDL9OJxeDuso9uLQhr2VViEU33wBZAGLYenPDcsYxLoGt5rklZ4+VkPj5LD6+ho7mjxvXy/7k3b84HBtqQIp7cIDE2I7vq7TPcPDqCGIDbJvPfwszu6wJJg7ArQJyWDHCjgrsk0kKI0uvTZuCWJYIV5Ca/QznqJ5DbKtB3tLor6DjV0CNwG1Rs4LPsljtZIcz/BpNAnjTziQIDAQABAoIBAAqbI2hws09Rlnx82boySKOm4FJL8WyNyjzHwlo6k6JNsswhjCcLzy5TJAijkyU/qJjo0I0jyzWTRSt8EI0e26WHB9pGhry7PCxBMmbHHslFcglu7O+2qKsHVrkaNVun1+6rBhSyYMPkrEvVjJwwqB3lg8hlaJQtR3HWRyEkROEfzWQrqC3dXakPR4Ki2sLemcCr+htq0PiNQ2rs2pCSXkM7xYlxpcs5qUmwEpp3BDvNT3l4SNKCzxA4k0xpA6u3EmT0NHroWC2Hb8GX8Me4CyUU8jOnyfxJLTNQBd2tos9pZ/Pgo8rGUl8z2zZJb9peedhvXIANQY/L1oHyFmxHg20CgYEA/mpJHNDv3mqbDEqlhlF911GZuoNO/wtfE3uC4WTAI4NrtdzQod31motWqzTFB5I5TQFQliSCOnZqZMRYpWZFFeyn5UsqiywABO5+kCsPiEa2TuL0MklB8kGDMSFnswgQW8i2oqeasBQVNobe0XWU0yFtHAvOu7Z2M0uXQFN+r70CgYEA2qcjDLnFs2IyQooLtxpUIhSzOmIWS4gb0lNPk2HLxfwbgfxtHEa+3RMDnY7G+Tfr6WIHP/E5GsZf3NVVSeFbGC1c854a+0z+QH/5FZxZXjbZMupS+pfe8TyKh/k+wjasdzKD0e/Xqfb5ePrTUwNwT/xIrjbZ43ZkMl4pFtnu2b0CgYEA5dWUySCDodWCzl7dG/OgkJUaIKGhCsz2Dj6lJQOEhFCkTH34SFKhHwVDvZUFbeqOM1+9snW25CO3x+KNBpbWUJEjuAPooiOUvN/LnGgaNw1Sgv+KhacimTzPzOGVsenWBWTUgSqSlwD9jO3YezcSxI1M6WpNT8ztCTf/otALAa0CgYArAH3zLcIFAoXx8iZVr3bmcP3CuLG7zxvxpHLdAHnMCUX7rYJj8kHtRqUKYp8dOnNKJf5ZA/8AFg2aZ9ZrPkflHF7QhsK1s7G5S7HYHzSwQ8c5rT3+jMnK1eZE0a8XERugIa4tJqdahPkRYvsWs3FuOaatpJn7kzgnc79PADNqXQKBgQDtapPxvxTgiy8ObzPqzVCTHhPrCZHFIEIBYTnQ7PdBlw8uCeqVhsuK/S1JeLy5JDIECB64zCWlqhNxaVR/hKr/d30KKlwqbyjK0g6I71+0GzBcW10PV7fDnZraT7QPm4nXgtqAyTLx2CndOjLxFP3/4B6ox/gcS9DwpIL5NG8WYA==
4ccceeb2-5008-4c43-bc5d-88578345c049	9ad23cf7-cc8e-4754-9077-d29ca33524a5	algorithm	RSA-OAEP
7e0a0dfa-67d3-40d9-b308-43e262843077	9ad23cf7-cc8e-4754-9077-d29ca33524a5	keyUse	ENC
5aeb9180-c406-4e5e-8a19-218155cde30e	fa3d3bab-cf52-47d2-97ec-2f53340d7adc	priority	100
48746591-0d31-49f7-bbae-1c87ab202c8d	fa3d3bab-cf52-47d2-97ec-2f53340d7adc	kid	3b97138f-65da-49de-b869-37f12c6f9d76
9f663d10-8f6a-452f-b6ce-d54fc83ab978	fa3d3bab-cf52-47d2-97ec-2f53340d7adc	secret	gG3HR05LjTzDFMf3OCWceg
a3769878-f0e6-4aa1-9412-d9b333f66693	0beb3f91-8486-4df5-9ba8-803386819b73	client-uris-must-match	true
91fc1b9e-6483-4aa5-a708-b7624ecd4680	0beb3f91-8486-4df5-9ba8-803386819b73	host-sending-registration-request-must-match	true
1be09041-3bc5-4db3-b8d8-0282a234dcd6	8eb26305-4938-440a-a8bc-c7dfa3250104	max-clients	200
0b077bf2-e1cf-482d-aef8-6d8e9352f0dd	4f0028bd-4c1a-42cc-beb9-6c96a6ec45c0	allowed-protocol-mapper-types	oidc-address-mapper
c60971ad-a05f-4bb3-b254-b926195d5268	4f0028bd-4c1a-42cc-beb9-6c96a6ec45c0	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
32c1f251-36f6-47a9-8431-a0dbd79e0e7b	4f0028bd-4c1a-42cc-beb9-6c96a6ec45c0	allowed-protocol-mapper-types	saml-user-attribute-mapper
953eed48-837f-4f5c-b465-2a3758bf466f	4f0028bd-4c1a-42cc-beb9-6c96a6ec45c0	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
e4c8a2fa-7b28-4c24-a7dd-9a32ad380b56	4f0028bd-4c1a-42cc-beb9-6c96a6ec45c0	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
a27d8853-c7f6-4a97-9333-8c671a5ea7be	4f0028bd-4c1a-42cc-beb9-6c96a6ec45c0	allowed-protocol-mapper-types	saml-user-property-mapper
cc306741-5330-423a-af38-c1760c6c87ac	4f0028bd-4c1a-42cc-beb9-6c96a6ec45c0	allowed-protocol-mapper-types	saml-role-list-mapper
845eb0a5-d6df-4247-ba8a-5e48027a8a1f	4f0028bd-4c1a-42cc-beb9-6c96a6ec45c0	allowed-protocol-mapper-types	oidc-full-name-mapper
43c413f2-2a79-454c-8ee7-ca5f032270e6	8e54c58f-56b2-4949-b32e-cfd92852e4f5	allow-default-scopes	true
12e68a59-7959-40e2-ae67-d7178c0b08b8	6da42ceb-f3f4-49b1-867d-21362be59dd8	allow-default-scopes	true
90717019-9521-42f0-839e-2be9ec16ca3c	e16ca399-3b0a-42f8-b565-2c5d4e9b426d	allowed-protocol-mapper-types	oidc-full-name-mapper
cc21c287-0689-4ec3-9d76-ec23357bafcf	e16ca399-3b0a-42f8-b565-2c5d4e9b426d	allowed-protocol-mapper-types	saml-role-list-mapper
86b2f425-493e-4f27-aee5-1a9752df65c0	e16ca399-3b0a-42f8-b565-2c5d4e9b426d	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
2d393530-9329-4aaa-859c-75b4d6c54711	e16ca399-3b0a-42f8-b565-2c5d4e9b426d	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
4e1f3a2a-4c17-4d9a-a773-cfd8efc6c704	e16ca399-3b0a-42f8-b565-2c5d4e9b426d	allowed-protocol-mapper-types	saml-user-property-mapper
9f0991d2-1afd-4208-b76b-4dc07e3e8463	e16ca399-3b0a-42f8-b565-2c5d4e9b426d	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
dbe4e76d-9284-4df7-b42e-91969bffacb8	e16ca399-3b0a-42f8-b565-2c5d4e9b426d	allowed-protocol-mapper-types	oidc-address-mapper
83ffe111-dda0-49da-b8d0-8af24f090e1a	e16ca399-3b0a-42f8-b565-2c5d4e9b426d	allowed-protocol-mapper-types	saml-user-attribute-mapper
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.composite_role (composite, child_role) FROM stdin;
a205d29a-df0a-4fcf-aaea-312636fac4f8	ecc18ff7-85a6-40ef-941d-2f103b7d1c07
a205d29a-df0a-4fcf-aaea-312636fac4f8	95a69587-0d76-462b-b4ad-cd55c0a0fb14
a205d29a-df0a-4fcf-aaea-312636fac4f8	28839de6-368b-4b5b-aed0-3fa207957dac
a205d29a-df0a-4fcf-aaea-312636fac4f8	f0b33279-3214-4cf9-b9f6-4d69dd58fe27
a205d29a-df0a-4fcf-aaea-312636fac4f8	9bdda955-398d-4932-9a40-9a8e723bbaf5
a205d29a-df0a-4fcf-aaea-312636fac4f8	28cf274d-9ac6-4321-8b00-de541c945db2
a205d29a-df0a-4fcf-aaea-312636fac4f8	ade3ad7b-a7f1-4003-a0cc-e9d50636526f
a205d29a-df0a-4fcf-aaea-312636fac4f8	25972374-2516-464c-b922-28cc5fc49711
a205d29a-df0a-4fcf-aaea-312636fac4f8	99502015-1af9-4dec-8159-356ee0cd428c
a205d29a-df0a-4fcf-aaea-312636fac4f8	68d7b2f2-c568-4025-9e24-4c5569b4c882
a205d29a-df0a-4fcf-aaea-312636fac4f8	2f705273-32bd-4a99-ae02-692604bbc872
a205d29a-df0a-4fcf-aaea-312636fac4f8	5798e933-bc22-497e-b79b-4aa261912a5f
a205d29a-df0a-4fcf-aaea-312636fac4f8	f9438f9f-f743-479f-9161-fa0d1bc3b0f6
a205d29a-df0a-4fcf-aaea-312636fac4f8	a9dc43d7-954b-4e93-ac47-0bcba0411be2
a205d29a-df0a-4fcf-aaea-312636fac4f8	4b82bc9d-abbf-4db2-af6a-62a478ca6dfe
a205d29a-df0a-4fcf-aaea-312636fac4f8	cf0d04f8-b718-4a89-b363-9140d29223d6
a205d29a-df0a-4fcf-aaea-312636fac4f8	cb2b7210-d493-4772-a6a3-513dded5f2fe
a205d29a-df0a-4fcf-aaea-312636fac4f8	c197645c-364e-443a-8032-145844bb543a
129c5554-7cd2-4e26-93f9-ba743e323b41	d2f52567-77b9-49c0-bd22-b811cbc60ccb
9bdda955-398d-4932-9a40-9a8e723bbaf5	cf0d04f8-b718-4a89-b363-9140d29223d6
f0b33279-3214-4cf9-b9f6-4d69dd58fe27	4b82bc9d-abbf-4db2-af6a-62a478ca6dfe
f0b33279-3214-4cf9-b9f6-4d69dd58fe27	c197645c-364e-443a-8032-145844bb543a
129c5554-7cd2-4e26-93f9-ba743e323b41	2328c13d-b9fc-4f10-b600-a82176acd108
2328c13d-b9fc-4f10-b600-a82176acd108	c4e4a09a-a02b-45e3-9b6c-718b031eeb96
b744989e-2783-4d1b-b050-d924be2fbadf	d322c4b4-1484-4a2f-98ac-a49463abbf57
a205d29a-df0a-4fcf-aaea-312636fac4f8	7bf58337-4531-4fa6-ae18-5af289d0bfed
129c5554-7cd2-4e26-93f9-ba743e323b41	6f945141-2201-4835-9872-0ddf395b939e
129c5554-7cd2-4e26-93f9-ba743e323b41	9bcf2b29-7e23-4df9-91af-f7e705c65797
a205d29a-df0a-4fcf-aaea-312636fac4f8	f64433f9-2966-4bb3-8b9b-f16a47f8528b
a205d29a-df0a-4fcf-aaea-312636fac4f8	29d6c134-3e1f-4ea4-9058-33b0b16ce18f
a205d29a-df0a-4fcf-aaea-312636fac4f8	a27c7a06-9dac-4e64-8905-c38ae67506d5
a205d29a-df0a-4fcf-aaea-312636fac4f8	09f7fd64-fac6-455a-b211-c53e75cf1cf2
a205d29a-df0a-4fcf-aaea-312636fac4f8	3cda6482-07b5-4698-8e6a-36d7f91fca32
a205d29a-df0a-4fcf-aaea-312636fac4f8	21d4fa16-5afb-4e89-8165-53aba131a5a0
a205d29a-df0a-4fcf-aaea-312636fac4f8	ac6ea938-cb8c-46c9-a377-0d1ae9af73cd
a205d29a-df0a-4fcf-aaea-312636fac4f8	2f101f4c-7bc5-4021-add0-78f5c23368a1
a205d29a-df0a-4fcf-aaea-312636fac4f8	8eb962d5-0bfb-40e1-bd28-c6af0d296f68
a205d29a-df0a-4fcf-aaea-312636fac4f8	bc4316e7-10f7-4ffc-94a3-1941554300b6
a205d29a-df0a-4fcf-aaea-312636fac4f8	26e106e0-8e88-41ad-96ba-3cf991d1611f
a205d29a-df0a-4fcf-aaea-312636fac4f8	36c2edb7-13f2-4d06-975d-1f71e80adc34
a205d29a-df0a-4fcf-aaea-312636fac4f8	4541b18b-1d5b-441a-9e2b-4f79e4bacda2
a205d29a-df0a-4fcf-aaea-312636fac4f8	04a8e1c3-08b6-4974-b6a4-ca6b3a61c257
a205d29a-df0a-4fcf-aaea-312636fac4f8	8e6ce435-2cea-4330-8f17-e0a20a1bc579
a205d29a-df0a-4fcf-aaea-312636fac4f8	a5e456fa-e4bd-4c91-be68-0f19322de88f
a205d29a-df0a-4fcf-aaea-312636fac4f8	aa2a6d23-edda-42b4-ac16-83a692092fc0
09f7fd64-fac6-455a-b211-c53e75cf1cf2	8e6ce435-2cea-4330-8f17-e0a20a1bc579
a27c7a06-9dac-4e64-8905-c38ae67506d5	aa2a6d23-edda-42b4-ac16-83a692092fc0
a27c7a06-9dac-4e64-8905-c38ae67506d5	04a8e1c3-08b6-4974-b6a4-ca6b3a61c257
58cc6f53-b4b4-4b3e-85f9-679cabcbe4ad	e0c4b607-6780-4dd7-a3f5-35e8c0737d4d
58cc6f53-b4b4-4b3e-85f9-679cabcbe4ad	41287b27-34f9-4017-bcbf-28dac959242c
58cc6f53-b4b4-4b3e-85f9-679cabcbe4ad	430ae7c6-2567-441a-933a-b58644795bbd
58cc6f53-b4b4-4b3e-85f9-679cabcbe4ad	2b4cc9be-04ed-47a1-b23e-1c8df0ff1322
58cc6f53-b4b4-4b3e-85f9-679cabcbe4ad	422137dd-3a64-4917-ab0d-422493f0e6d5
58cc6f53-b4b4-4b3e-85f9-679cabcbe4ad	87b335fa-3933-41b5-96d9-d00257a44032
58cc6f53-b4b4-4b3e-85f9-679cabcbe4ad	026978be-dc8d-453a-8a3e-be03f9d46b72
58cc6f53-b4b4-4b3e-85f9-679cabcbe4ad	a5460bff-98c0-4667-b52e-41a355aa6be7
58cc6f53-b4b4-4b3e-85f9-679cabcbe4ad	77cc6527-d6c6-4091-b822-3655a70c4654
58cc6f53-b4b4-4b3e-85f9-679cabcbe4ad	67f1e222-0cd9-423e-bcc6-1f9ad10e5e92
58cc6f53-b4b4-4b3e-85f9-679cabcbe4ad	9cf4da6d-020c-4999-b1ca-51a669f73de8
58cc6f53-b4b4-4b3e-85f9-679cabcbe4ad	6749d4fb-f1d4-447f-adf4-ac1b7f2ad8c5
58cc6f53-b4b4-4b3e-85f9-679cabcbe4ad	ee80d3de-f54e-48cd-a958-6e9e4e5302bc
58cc6f53-b4b4-4b3e-85f9-679cabcbe4ad	a2bb1519-ac4c-480e-bcd4-c91d7eb9fcc8
58cc6f53-b4b4-4b3e-85f9-679cabcbe4ad	8140d602-ac57-471c-8616-a992190ffdc4
58cc6f53-b4b4-4b3e-85f9-679cabcbe4ad	c8b8736d-7201-4041-83f0-c1152e264cb6
58cc6f53-b4b4-4b3e-85f9-679cabcbe4ad	2e1147d4-5104-43e4-8ca2-91eade939bc6
2b4cc9be-04ed-47a1-b23e-1c8df0ff1322	8140d602-ac57-471c-8616-a992190ffdc4
41d517a4-c08a-4e1a-878e-1b1b5aadc9e0	31c0f576-6416-43e8-8158-c5050ca95d6e
430ae7c6-2567-441a-933a-b58644795bbd	2e1147d4-5104-43e4-8ca2-91eade939bc6
430ae7c6-2567-441a-933a-b58644795bbd	a2bb1519-ac4c-480e-bcd4-c91d7eb9fcc8
41d517a4-c08a-4e1a-878e-1b1b5aadc9e0	7dc39e18-6515-4401-87b5-da07408ee055
7dc39e18-6515-4401-87b5-da07408ee055	178b37d0-0a3a-44b7-b6a2-7045639f060a
557244cc-1a6a-40f3-9cca-83268c6e7adb	e81c0e33-b9dd-4a82-967b-66fda7933633
a205d29a-df0a-4fcf-aaea-312636fac4f8	3c985ed3-0db1-445a-aa0d-7f9dff4d2abb
58cc6f53-b4b4-4b3e-85f9-679cabcbe4ad	67704d9b-8ad8-45af-97af-4f46d1a0a326
41d517a4-c08a-4e1a-878e-1b1b5aadc9e0	52aac5e2-8b15-48c8-9b31-2e068b0518e3
41d517a4-c08a-4e1a-878e-1b1b5aadc9e0	3756b3c3-6a28-4b69-9d23-ad3d53b1be50
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
961143e8-27c0-46b7-82bf-83da79853d2a	\N	password	096e14ce-1d5f-409f-b00b-09d194cdfb21	1768681769738	\N	{"value":"JFLmbH08iuxKAEmD6XhfFn6UIfhbLsluV/NIMc3Nixk=","salt":"rLC73mRMTWU19PyTXKv0Bw==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
5be6aeb9-1610-4a3e-83d0-164295259c26	\N	password	de8d2617-58f1-4965-a523-811e2f1a1eec	1768683175455	My password	{"value":"jtJ4lRyEZ04VP4DOHMGyCMzTYOiDDq+9Y0CssH7PasU=","salt":"vMI/WfqoSZeCNzI0ZY7knw==","additionalParameters":{}}	{"hashIterations":5,"algorithm":"argon2","additionalParameters":{"hashLength":["32"],"memory":["7168"],"type":["id"],"version":["1.3"],"parallelism":["1"]}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2026-01-17 20:29:24.973937	1	EXECUTED	9:6f1016664e21e16d26517a4418f5e3df	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.29.1	\N	\N	8681764709
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2026-01-17 20:29:24.984892	2	MARK_RAN	9:828775b1596a07d1200ba1d49e5e3941	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.29.1	\N	\N	8681764709
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2026-01-17 20:29:25.006597	3	EXECUTED	9:5f090e44a7d595883c1fb61f4b41fd38	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.29.1	\N	\N	8681764709
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2026-01-17 20:29:25.009121	4	EXECUTED	9:c07e577387a3d2c04d1adc9aaad8730e	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	8681764709
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2026-01-17 20:29:25.048268	5	EXECUTED	9:b68ce996c655922dbcd2fe6b6ae72686	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.29.1	\N	\N	8681764709
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2026-01-17 20:29:25.084183	6	MARK_RAN	9:543b5c9989f024fe35c6f6c5a97de88e	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.29.1	\N	\N	8681764709
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2026-01-17 20:29:25.138353	7	EXECUTED	9:765afebbe21cf5bbca048e632df38336	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.29.1	\N	\N	8681764709
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2026-01-17 20:29:25.142914	8	MARK_RAN	9:db4a145ba11a6fdaefb397f6dbf829a1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.29.1	\N	\N	8681764709
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2026-01-17 20:29:25.147242	9	EXECUTED	9:9d05c7be10cdb873f8bcb41bc3a8ab23	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.29.1	\N	\N	8681764709
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2026-01-17 20:29:25.191871	10	EXECUTED	9:18593702353128d53111f9b1ff0b82b8	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.29.1	\N	\N	8681764709
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2026-01-17 20:29:25.212615	11	EXECUTED	9:6122efe5f090e41a85c0f1c9e52cbb62	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	8681764709
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2026-01-17 20:29:25.216559	12	MARK_RAN	9:e1ff28bf7568451453f844c5d54bb0b5	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	8681764709
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2026-01-17 20:29:25.228004	13	EXECUTED	9:7af32cd8957fbc069f796b61217483fd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.29.1	\N	\N	8681764709
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-01-17 20:29:25.236394	14	EXECUTED	9:6005e15e84714cd83226bf7879f54190	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.29.1	\N	\N	8681764709
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-01-17 20:29:25.237379	15	MARK_RAN	9:bf656f5a2b055d07f314431cae76f06c	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8681764709
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-01-17 20:29:25.238862	16	MARK_RAN	9:f8dadc9284440469dcf71e25ca6ab99b	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.29.1	\N	\N	8681764709
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2026-01-17 20:29:25.240312	17	EXECUTED	9:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.29.1	\N	\N	8681764709
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2026-01-17 20:29:25.255516	18	EXECUTED	9:3368ff0be4c2855ee2dd9ca813b38d8e	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.29.1	\N	\N	8681764709
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2026-01-17 20:29:25.271201	19	EXECUTED	9:8ac2fb5dd030b24c0570a763ed75ed20	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.29.1	\N	\N	8681764709
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2026-01-17 20:29:25.275028	20	EXECUTED	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.29.1	\N	\N	8681764709
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2026-01-17 20:29:25.277122	21	MARK_RAN	9:831e82914316dc8a57dc09d755f23c51	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.29.1	\N	\N	8681764709
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2026-01-17 20:29:25.278763	22	MARK_RAN	9:f91ddca9b19743db60e3057679810e6c	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.29.1	\N	\N	8681764709
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2026-01-17 20:29:25.319882	23	EXECUTED	9:bc3d0f9e823a69dc21e23e94c7a94bb1	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.29.1	\N	\N	8681764709
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2026-01-17 20:29:25.327554	24	EXECUTED	9:c9999da42f543575ab790e76439a2679	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.29.1	\N	\N	8681764709
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2026-01-17 20:29:25.329254	25	MARK_RAN	9:0d6c65c6f58732d81569e77b10ba301d	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.29.1	\N	\N	8681764709
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2026-01-17 20:29:25.629381	26	EXECUTED	9:fc576660fc016ae53d2d4778d84d86d0	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.29.1	\N	\N	8681764709
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2026-01-17 20:29:25.656994	27	EXECUTED	9:43ed6b0da89ff77206289e87eaa9c024	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.29.1	\N	\N	8681764709
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2026-01-17 20:29:25.660325	28	EXECUTED	9:44bae577f551b3738740281eceb4ea70	update tableName=RESOURCE_SERVER_POLICY		\N	4.29.1	\N	\N	8681764709
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2026-01-17 20:29:25.705207	29	EXECUTED	9:bd88e1f833df0420b01e114533aee5e8	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.29.1	\N	\N	8681764709
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2026-01-17 20:29:25.711037	30	EXECUTED	9:a7022af5267f019d020edfe316ef4371	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.29.1	\N	\N	8681764709
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2026-01-17 20:29:25.719306	31	EXECUTED	9:fc155c394040654d6a79227e56f5e25a	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.29.1	\N	\N	8681764709
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2026-01-17 20:29:25.72207	32	EXECUTED	9:eac4ffb2a14795e5dc7b426063e54d88	customChange		\N	4.29.1	\N	\N	8681764709
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-01-17 20:29:25.72456	33	EXECUTED	9:54937c05672568c4c64fc9524c1e9462	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8681764709
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-01-17 20:29:25.725758	34	MARK_RAN	9:3a32bace77c84d7678d035a7f5a8084e	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.29.1	\N	\N	8681764709
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-01-17 20:29:25.735126	35	EXECUTED	9:33d72168746f81f98ae3a1e8e0ca3554	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.29.1	\N	\N	8681764709
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2026-01-17 20:29:25.738193	36	EXECUTED	9:61b6d3d7a4c0e0024b0c839da283da0c	addColumn tableName=REALM		\N	4.29.1	\N	\N	8681764709
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2026-01-17 20:29:25.739974	37	EXECUTED	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	8681764709
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2026-01-17 20:29:25.741804	38	EXECUTED	9:a2b870802540cb3faa72098db5388af3	addColumn tableName=FED_USER_CONSENT		\N	4.29.1	\N	\N	8681764709
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2026-01-17 20:29:25.743462	39	EXECUTED	9:132a67499ba24bcc54fb5cbdcfe7e4c0	addColumn tableName=IDENTITY_PROVIDER		\N	4.29.1	\N	\N	8681764709
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2026-01-17 20:29:25.744145	40	MARK_RAN	9:938f894c032f5430f2b0fafb1a243462	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.29.1	\N	\N	8681764709
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2026-01-17 20:29:25.744994	41	MARK_RAN	9:845c332ff1874dc5d35974b0babf3006	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.29.1	\N	\N	8681764709
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2026-01-17 20:29:25.746845	42	EXECUTED	9:fc86359c079781adc577c5a217e4d04c	customChange		\N	4.29.1	\N	\N	8681764709
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2026-01-17 20:29:26.731292	43	EXECUTED	9:59a64800e3c0d09b825f8a3b444fa8f4	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.29.1	\N	\N	8681764709
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2026-01-17 20:29:26.734226	44	EXECUTED	9:d48d6da5c6ccf667807f633fe489ce88	addColumn tableName=USER_ENTITY		\N	4.29.1	\N	\N	8681764709
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-01-17 20:29:26.736263	45	EXECUTED	9:dde36f7973e80d71fceee683bc5d2951	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.29.1	\N	\N	8681764709
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-01-17 20:29:26.738284	46	EXECUTED	9:b855e9b0a406b34fa323235a0cf4f640	customChange		\N	4.29.1	\N	\N	8681764709
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-01-17 20:29:26.739	47	MARK_RAN	9:51abbacd7b416c50c4421a8cabf7927e	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.29.1	\N	\N	8681764709
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-01-17 20:29:26.789297	48	EXECUTED	9:bdc99e567b3398bac83263d375aad143	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.29.1	\N	\N	8681764709
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2026-01-17 20:29:26.791575	49	EXECUTED	9:d198654156881c46bfba39abd7769e69	addColumn tableName=REALM		\N	4.29.1	\N	\N	8681764709
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2026-01-17 20:29:26.799004	50	EXECUTED	9:cfdd8736332ccdd72c5256ccb42335db	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.29.1	\N	\N	8681764709
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2026-01-17 20:29:27.031953	51	EXECUTED	9:7c84de3d9bd84d7f077607c1a4dcb714	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.29.1	\N	\N	8681764709
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2026-01-17 20:29:27.034892	52	EXECUTED	9:5a6bb36cbefb6a9d6928452c0852af2d	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8681764709
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2026-01-17 20:29:27.037251	53	EXECUTED	9:8f23e334dbc59f82e0a328373ca6ced0	update tableName=REALM		\N	4.29.1	\N	\N	8681764709
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2026-01-17 20:29:27.039265	54	EXECUTED	9:9156214268f09d970cdf0e1564d866af	update tableName=CLIENT		\N	4.29.1	\N	\N	8681764709
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-01-17 20:29:27.043876	55	EXECUTED	9:db806613b1ed154826c02610b7dbdf74	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.29.1	\N	\N	8681764709
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-01-17 20:29:27.048025	56	EXECUTED	9:229a041fb72d5beac76bb94a5fa709de	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.29.1	\N	\N	8681764709
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-01-17 20:29:27.08542	57	EXECUTED	9:079899dade9c1e683f26b2aa9ca6ff04	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.29.1	\N	\N	8681764709
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2026-01-17 20:29:27.324625	58	EXECUTED	9:139b79bcbbfe903bb1c2d2a4dbf001d9	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.29.1	\N	\N	8681764709
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2026-01-17 20:29:27.334636	59	EXECUTED	9:b55738ad889860c625ba2bf483495a04	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.29.1	\N	\N	8681764709
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2026-01-17 20:29:27.337345	60	EXECUTED	9:e0057eac39aa8fc8e09ac6cfa4ae15fe	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.29.1	\N	\N	8681764709
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2026-01-17 20:29:27.341269	61	EXECUTED	9:42a33806f3a0443fe0e7feeec821326c	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.29.1	\N	\N	8681764709
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2026-01-17 20:29:27.343005	62	EXECUTED	9:9968206fca46eecc1f51db9c024bfe56	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.29.1	\N	\N	8681764709
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2026-01-17 20:29:27.344479	63	EXECUTED	9:92143a6daea0a3f3b8f598c97ce55c3d	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.29.1	\N	\N	8681764709
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2026-01-17 20:29:27.345987	64	EXECUTED	9:82bab26a27195d889fb0429003b18f40	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.29.1	\N	\N	8681764709
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2026-01-17 20:29:27.347258	65	EXECUTED	9:e590c88ddc0b38b0ae4249bbfcb5abc3	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.29.1	\N	\N	8681764709
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2026-01-17 20:29:27.364777	66	EXECUTED	9:5c1f475536118dbdc38d5d7977950cc0	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.29.1	\N	\N	8681764709
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2026-01-17 20:29:27.381215	67	EXECUTED	9:e7c9f5f9c4d67ccbbcc215440c718a17	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.29.1	\N	\N	8681764709
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2026-01-17 20:29:27.383938	68	EXECUTED	9:88e0bfdda924690d6f4e430c53447dd5	addColumn tableName=REALM		\N	4.29.1	\N	\N	8681764709
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2026-01-17 20:29:27.402855	69	EXECUTED	9:f53177f137e1c46b6a88c59ec1cb5218	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.29.1	\N	\N	8681764709
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2026-01-17 20:29:27.405358	70	EXECUTED	9:a74d33da4dc42a37ec27121580d1459f	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.29.1	\N	\N	8681764709
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2026-01-17 20:29:27.407276	71	EXECUTED	9:fd4ade7b90c3b67fae0bfcfcb42dfb5f	addColumn tableName=RESOURCE_SERVER		\N	4.29.1	\N	\N	8681764709
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-01-17 20:29:27.410835	72	EXECUTED	9:aa072ad090bbba210d8f18781b8cebf4	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	8681764709
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-01-17 20:29:27.41378	73	EXECUTED	9:1ae6be29bab7c2aa376f6983b932be37	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	8681764709
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-01-17 20:29:27.414693	74	MARK_RAN	9:14706f286953fc9a25286dbd8fb30d97	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.29.1	\N	\N	8681764709
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-01-17 20:29:27.422529	75	EXECUTED	9:2b9cc12779be32c5b40e2e67711a218b	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.29.1	\N	\N	8681764709
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2026-01-17 20:29:27.43889	76	EXECUTED	9:91fa186ce7a5af127a2d7a91ee083cc5	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.29.1	\N	\N	8681764709
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-01-17 20:29:27.440638	77	EXECUTED	9:6335e5c94e83a2639ccd68dd24e2e5ad	addColumn tableName=CLIENT		\N	4.29.1	\N	\N	8681764709
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-01-17 20:29:27.441288	78	MARK_RAN	9:6bdb5658951e028bfe16fa0a8228b530	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.29.1	\N	\N	8681764709
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-01-17 20:29:27.446002	79	EXECUTED	9:d5bc15a64117ccad481ce8792d4c608f	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.29.1	\N	\N	8681764709
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2026-01-17 20:29:27.446762	80	MARK_RAN	9:077cba51999515f4d3e7ad5619ab592c	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.29.1	\N	\N	8681764709
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-01-17 20:29:27.462417	81	EXECUTED	9:be969f08a163bf47c6b9e9ead8ac2afb	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.29.1	\N	\N	8681764709
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-01-17 20:29:27.463341	82	MARK_RAN	9:6d3bb4408ba5a72f39bd8a0b301ec6e3	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	8681764709
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-01-17 20:29:27.465344	83	EXECUTED	9:966bda61e46bebf3cc39518fbed52fa7	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	8681764709
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-01-17 20:29:27.465911	84	MARK_RAN	9:8dcac7bdf7378e7d823cdfddebf72fda	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.29.1	\N	\N	8681764709
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2026-01-17 20:29:27.480551	85	EXECUTED	9:7d93d602352a30c0c317e6a609b56599	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	8681764709
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2026-01-17 20:29:27.482314	86	EXECUTED	9:71c5969e6cdd8d7b6f47cebc86d37627	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.29.1	\N	\N	8681764709
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2026-01-17 20:29:27.484475	87	EXECUTED	9:a9ba7d47f065f041b7da856a81762021	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.29.1	\N	\N	8681764709
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2026-01-17 20:29:27.486857	88	EXECUTED	9:fffabce2bc01e1a8f5110d5278500065	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.29.1	\N	\N	8681764709
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-01-17 20:29:27.488957	89	EXECUTED	9:fa8a5b5445e3857f4b010bafb5009957	addColumn tableName=REALM; customChange		\N	4.29.1	\N	\N	8681764709
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-01-17 20:29:27.491027	90	EXECUTED	9:67ac3241df9a8582d591c5ed87125f39	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.29.1	\N	\N	8681764709
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-01-17 20:29:27.505684	91	EXECUTED	9:ad1194d66c937e3ffc82386c050ba089	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8681764709
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-01-17 20:29:27.508195	92	EXECUTED	9:d9be619d94af5a2f5d07b9f003543b91	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.29.1	\N	\N	8681764709
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-01-17 20:29:27.508798	93	MARK_RAN	9:544d201116a0fcc5a5da0925fbbc3bde	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.29.1	\N	\N	8681764709
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-01-17 20:29:27.511233	94	EXECUTED	9:43c0c1055b6761b4b3e89de76d612ccf	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.29.1	\N	\N	8681764709
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-01-17 20:29:27.512149	95	MARK_RAN	9:8bd711fd0330f4fe980494ca43ab1139	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.29.1	\N	\N	8681764709
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2026-01-17 20:29:27.514349	96	EXECUTED	9:e07d2bc0970c348bb06fb63b1f82ddbf	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.29.1	\N	\N	8681764709
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-01-17 20:29:27.556475	97	EXECUTED	9:24fb8611e97f29989bea412aa38d12b7	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8681764709
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-01-17 20:29:27.557481	98	MARK_RAN	9:259f89014ce2506ee84740cbf7163aa7	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8681764709
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-01-17 20:29:27.56455	99	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8681764709
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-01-17 20:29:27.582363	100	EXECUTED	9:60ca84a0f8c94ec8c3504a5a3bc88ee8	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8681764709
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-01-17 20:29:27.583359	101	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8681764709
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-01-17 20:29:27.600545	102	EXECUTED	9:0b305d8d1277f3a89a0a53a659ad274c	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.29.1	\N	\N	8681764709
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2026-01-17 20:29:27.602607	103	EXECUTED	9:2c374ad2cdfe20e2905a84c8fac48460	customChange		\N	4.29.1	\N	\N	8681764709
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2026-01-17 20:29:27.605314	104	EXECUTED	9:47a760639ac597360a8219f5b768b4de	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.29.1	\N	\N	8681764709
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2026-01-17 20:29:27.62217	105	EXECUTED	9:a6272f0576727dd8cad2522335f5d99e	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.29.1	\N	\N	8681764709
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2026-01-17 20:29:27.64112	106	EXECUTED	9:015479dbd691d9cc8669282f4828c41d	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.29.1	\N	\N	8681764709
18.0.15-30992-index-consent	keycloak	META-INF/jpa-changelog-18.0.15.xml	2026-01-17 20:29:27.68609	107	EXECUTED	9:80071ede7a05604b1f4906f3bf3b00f0	createIndex indexName=IDX_USCONSENT_SCOPE_ID, tableName=USER_CONSENT_CLIENT_SCOPE		\N	4.29.1	\N	\N	8681764709
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2026-01-17 20:29:27.691399	108	EXECUTED	9:9518e495fdd22f78ad6425cc30630221	customChange		\N	4.29.1	\N	\N	8681764709
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-01-17 20:29:27.720028	109	EXECUTED	9:e5f243877199fd96bcc842f27a1656ac	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.29.1	\N	\N	8681764709
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-01-17 20:29:27.721122	110	MARK_RAN	9:1a6fcaa85e20bdeae0a9ce49b41946a5	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.29.1	\N	\N	8681764709
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2026-01-17 20:29:27.724019	111	EXECUTED	9:3f332e13e90739ed0c35b0b25b7822ca	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8681764709
21.0.2-17277	keycloak	META-INF/jpa-changelog-21.0.2.xml	2026-01-17 20:29:27.726012	112	EXECUTED	9:7ee1f7a3fb8f5588f171fb9a6ab623c0	customChange		\N	4.29.1	\N	\N	8681764709
21.1.0-19404	keycloak	META-INF/jpa-changelog-21.1.0.xml	2026-01-17 20:29:27.731374	113	EXECUTED	9:3d7e830b52f33676b9d64f7f2b2ea634	modifyDataType columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=LOGIC, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=POLICY_ENFORCE_MODE, tableName=RESOURCE_SERVER		\N	4.29.1	\N	\N	8681764709
21.1.0-19404-2	keycloak	META-INF/jpa-changelog-21.1.0.xml	2026-01-17 20:29:27.733479	114	MARK_RAN	9:627d032e3ef2c06c0e1f73d2ae25c26c	addColumn tableName=RESOURCE_SERVER_POLICY; update tableName=RESOURCE_SERVER_POLICY; dropColumn columnName=DECISION_STRATEGY, tableName=RESOURCE_SERVER_POLICY; renameColumn newColumnName=DECISION_STRATEGY, oldColumnName=DECISION_STRATEGY_NEW, tabl...		\N	4.29.1	\N	\N	8681764709
22.0.0-17484-updated	keycloak	META-INF/jpa-changelog-22.0.0.xml	2026-01-17 20:29:27.735833	115	EXECUTED	9:90af0bfd30cafc17b9f4d6eccd92b8b3	customChange		\N	4.29.1	\N	\N	8681764709
22.0.5-24031	keycloak	META-INF/jpa-changelog-22.0.0.xml	2026-01-17 20:29:27.736379	116	MARK_RAN	9:a60d2d7b315ec2d3eba9e2f145f9df28	customChange		\N	4.29.1	\N	\N	8681764709
23.0.0-12062	keycloak	META-INF/jpa-changelog-23.0.0.xml	2026-01-17 20:29:27.738082	117	EXECUTED	9:2168fbe728fec46ae9baf15bf80927b8	addColumn tableName=COMPONENT_CONFIG; update tableName=COMPONENT_CONFIG; dropColumn columnName=VALUE, tableName=COMPONENT_CONFIG; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=COMPONENT_CONFIG		\N	4.29.1	\N	\N	8681764709
23.0.0-17258	keycloak	META-INF/jpa-changelog-23.0.0.xml	2026-01-17 20:29:27.739847	118	EXECUTED	9:36506d679a83bbfda85a27ea1864dca8	addColumn tableName=EVENT_ENTITY		\N	4.29.1	\N	\N	8681764709
24.0.0-9758	keycloak	META-INF/jpa-changelog-24.0.0.xml	2026-01-17 20:29:27.833003	119	EXECUTED	9:502c557a5189f600f0f445a9b49ebbce	addColumn tableName=USER_ATTRIBUTE; addColumn tableName=FED_USER_ATTRIBUTE; createIndex indexName=USER_ATTR_LONG_VALUES, tableName=USER_ATTRIBUTE; createIndex indexName=FED_USER_ATTR_LONG_VALUES, tableName=FED_USER_ATTRIBUTE; createIndex indexName...		\N	4.29.1	\N	\N	8681764709
24.0.0-9758-2	keycloak	META-INF/jpa-changelog-24.0.0.xml	2026-01-17 20:29:27.836165	120	EXECUTED	9:bf0fdee10afdf597a987adbf291db7b2	customChange		\N	4.29.1	\N	\N	8681764709
24.0.0-26618-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.0.xml	2026-01-17 20:29:27.838875	121	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8681764709
24.0.0-26618-reindex	keycloak	META-INF/jpa-changelog-24.0.0.xml	2026-01-17 20:29:27.857724	122	EXECUTED	9:08707c0f0db1cef6b352db03a60edc7f	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8681764709
24.0.2-27228	keycloak	META-INF/jpa-changelog-24.0.2.xml	2026-01-17 20:29:27.859591	123	EXECUTED	9:eaee11f6b8aa25d2cc6a84fb86fc6238	customChange		\N	4.29.1	\N	\N	8681764709
24.0.2-27967-drop-index-if-present	keycloak	META-INF/jpa-changelog-24.0.2.xml	2026-01-17 20:29:27.860183	124	MARK_RAN	9:04baaf56c116ed19951cbc2cca584022	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8681764709
24.0.2-27967-reindex	keycloak	META-INF/jpa-changelog-24.0.2.xml	2026-01-17 20:29:27.861029	125	MARK_RAN	9:d3d977031d431db16e2c181ce49d73e9	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.29.1	\N	\N	8681764709
25.0.0-28265-tables	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-01-17 20:29:27.862691	126	EXECUTED	9:deda2df035df23388af95bbd36c17cef	addColumn tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	8681764709
25.0.0-28265-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-01-17 20:29:27.879732	127	EXECUTED	9:3e96709818458ae49f3c679ae58d263a	createIndex indexName=IDX_OFFLINE_USS_BY_LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8681764709
25.0.0-28265-index-cleanup-uss-createdon	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-01-17 20:29:27.914673	128	EXECUTED	9:78ab4fc129ed5e8265dbcc3485fba92f	dropIndex indexName=IDX_OFFLINE_USS_CREATEDON, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8681764709
25.0.0-28265-index-cleanup-uss-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-01-17 20:29:27.962778	129	EXECUTED	9:de5f7c1f7e10994ed8b62e621d20eaab	dropIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8681764709
25.0.0-28265-index-cleanup-uss-by-usersess	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-01-17 20:29:27.995892	130	EXECUTED	9:6eee220d024e38e89c799417ec33667f	dropIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8681764709
25.0.0-28265-index-cleanup-css-preload	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-01-17 20:29:28.031069	131	EXECUTED	9:5411d2fb2891d3e8d63ddb55dfa3c0c9	dropIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	8681764709
25.0.0-28265-index-2-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-01-17 20:29:28.032518	132	MARK_RAN	9:b7ef76036d3126bb83c2423bf4d449d6	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8681764709
25.0.0-28265-index-2-not-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-01-17 20:29:28.068955	133	EXECUTED	9:23396cf51ab8bc1ae6f0cac7f9f6fcf7	createIndex indexName=IDX_OFFLINE_USS_BY_BROKER_SESSION_ID, tableName=OFFLINE_USER_SESSION		\N	4.29.1	\N	\N	8681764709
25.0.0-org	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-01-17 20:29:28.07429	134	EXECUTED	9:5c859965c2c9b9c72136c360649af157	createTable tableName=ORG; addUniqueConstraint constraintName=UK_ORG_NAME, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_GROUP, tableName=ORG; createTable tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	8681764709
unique-consentuser	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-01-17 20:29:28.07855	135	EXECUTED	9:5857626a2ea8767e9a6c66bf3a2cb32f	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	8681764709
unique-consentuser-mysql	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-01-17 20:29:28.079398	136	MARK_RAN	9:b79478aad5adaa1bc428e31563f55e8e	customChange; dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_LOCAL_CONSENT, tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_EXTERNAL_CONSENT, tableName=...		\N	4.29.1	\N	\N	8681764709
25.0.0-28861-index-creation	keycloak	META-INF/jpa-changelog-25.0.0.xml	2026-01-17 20:29:28.121088	137	EXECUTED	9:b9acb58ac958d9ada0fe12a5d4794ab1	createIndex indexName=IDX_PERM_TICKET_REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; createIndex indexName=IDX_PERM_TICKET_OWNER, tableName=RESOURCE_SERVER_PERM_TICKET		\N	4.29.1	\N	\N	8681764709
26.0.0-org-alias	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-01-17 20:29:28.124042	138	EXECUTED	9:6ef7d63e4412b3c2d66ed179159886a4	addColumn tableName=ORG; update tableName=ORG; addNotNullConstraint columnName=ALIAS, tableName=ORG; addUniqueConstraint constraintName=UK_ORG_ALIAS, tableName=ORG		\N	4.29.1	\N	\N	8681764709
26.0.0-org-group	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-01-17 20:29:28.127129	139	EXECUTED	9:da8e8087d80ef2ace4f89d8c5b9ca223	addColumn tableName=KEYCLOAK_GROUP; update tableName=KEYCLOAK_GROUP; addNotNullConstraint columnName=TYPE, tableName=KEYCLOAK_GROUP; customChange		\N	4.29.1	\N	\N	8681764709
26.0.0-org-indexes	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-01-17 20:29:28.146924	140	EXECUTED	9:79b05dcd610a8c7f25ec05135eec0857	createIndex indexName=IDX_ORG_DOMAIN_ORG_ID, tableName=ORG_DOMAIN		\N	4.29.1	\N	\N	8681764709
26.0.0-org-group-membership	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-01-17 20:29:28.149472	141	EXECUTED	9:a6ace2ce583a421d89b01ba2a28dc2d4	addColumn tableName=USER_GROUP_MEMBERSHIP; update tableName=USER_GROUP_MEMBERSHIP; addNotNullConstraint columnName=MEMBERSHIP_TYPE, tableName=USER_GROUP_MEMBERSHIP		\N	4.29.1	\N	\N	8681764709
31296-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-01-17 20:29:28.151953	142	EXECUTED	9:64ef94489d42a358e8304b0e245f0ed4	createTable tableName=REVOKED_TOKEN; addPrimaryKey constraintName=CONSTRAINT_RT, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	8681764709
31725-index-persist-revoked-access-tokens	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-01-17 20:29:28.173813	143	EXECUTED	9:b994246ec2bf7c94da881e1d28782c7b	createIndex indexName=IDX_REV_TOKEN_ON_EXPIRE, tableName=REVOKED_TOKEN		\N	4.29.1	\N	\N	8681764709
26.0.0-idps-for-login	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-01-17 20:29:28.215594	144	EXECUTED	9:51f5fffadf986983d4bd59582c6c1604	addColumn tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_REALM_ORG, tableName=IDENTITY_PROVIDER; createIndex indexName=IDX_IDP_FOR_LOGIN, tableName=IDENTITY_PROVIDER; customChange		\N	4.29.1	\N	\N	8681764709
26.0.0-32583-drop-redundant-index-on-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-01-17 20:29:28.240036	145	EXECUTED	9:24972d83bf27317a055d234187bb4af9	dropIndex indexName=IDX_US_SESS_ID_ON_CL_SESS, tableName=OFFLINE_CLIENT_SESSION		\N	4.29.1	\N	\N	8681764709
26.0.0.32582-remove-tables-user-session-user-session-note-and-client-session	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-01-17 20:29:28.243769	146	EXECUTED	9:febdc0f47f2ed241c59e60f58c3ceea5	dropTable tableName=CLIENT_SESSION_ROLE; dropTable tableName=CLIENT_SESSION_NOTE; dropTable tableName=CLIENT_SESSION_PROT_MAPPER; dropTable tableName=CLIENT_SESSION_AUTH_STATUS; dropTable tableName=CLIENT_USER_SESSION_NOTE; dropTable tableName=CLI...		\N	4.29.1	\N	\N	8681764709
26.0.0-33201-org-redirect-url	keycloak	META-INF/jpa-changelog-26.0.0.xml	2026-01-17 20:29:28.245093	147	EXECUTED	9:4d0e22b0ac68ebe9794fa9cb752ea660	addColumn tableName=ORG		\N	4.29.1	\N	\N	8681764709
29399-jdbc-ping-default	keycloak	META-INF/jpa-changelog-26.1.0.xml	2026-01-17 20:29:28.247165	148	EXECUTED	9:007dbe99d7203fca403b89d4edfdf21e	createTable tableName=JGROUPS_PING; addPrimaryKey constraintName=CONSTRAINT_JGROUPS_PING, tableName=JGROUPS_PING		\N	4.29.1	\N	\N	8681764709
26.1.0-34013	keycloak	META-INF/jpa-changelog-26.1.0.xml	2026-01-17 20:29:28.250705	149	EXECUTED	9:e6b686a15759aef99a6d758a5c4c6a26	addColumn tableName=ADMIN_EVENT_ENTITY		\N	4.29.1	\N	\N	8681764709
26.1.0-34380	keycloak	META-INF/jpa-changelog-26.1.0.xml	2026-01-17 20:29:28.25265	150	EXECUTED	9:ac8b9edb7c2b6c17a1c7a11fcf5ccf01	dropTable tableName=USERNAME_LOGIN_FAILURE		\N	4.29.1	\N	\N	8681764709
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
d1e198d9-8425-49d2-bc78-93f0a86674d0	79844d2e-3022-495b-b9a7-5a64d4a07c92	f
d1e198d9-8425-49d2-bc78-93f0a86674d0	89b6ccba-0ceb-4fd6-bf26-afa10d3a0203	t
d1e198d9-8425-49d2-bc78-93f0a86674d0	f21f92dc-9e52-45b4-8200-1bffa83eba9a	t
d1e198d9-8425-49d2-bc78-93f0a86674d0	5159c8bb-b08a-4f3c-992a-b5a39c1b4779	t
d1e198d9-8425-49d2-bc78-93f0a86674d0	9711cbec-2695-4017-b902-d18284e917bf	t
d1e198d9-8425-49d2-bc78-93f0a86674d0	5f5924d8-2cf7-411b-b2f2-9494cb19a710	f
d1e198d9-8425-49d2-bc78-93f0a86674d0	df8d0e89-d1e8-4d2a-b360-83b3926dc53a	f
d1e198d9-8425-49d2-bc78-93f0a86674d0	285c0f70-91a0-483d-a961-4abcf1b53b15	t
d1e198d9-8425-49d2-bc78-93f0a86674d0	63b93bb7-9496-4b07-bbc5-2c44fc521b6d	t
d1e198d9-8425-49d2-bc78-93f0a86674d0	3bac3b68-c660-43d8-8099-04e5dbb3b835	f
d1e198d9-8425-49d2-bc78-93f0a86674d0	baf14ede-f1ce-468d-b3cc-86a1f5036cbe	t
d1e198d9-8425-49d2-bc78-93f0a86674d0	284ac003-5e92-4715-819a-d053bfb5d35b	t
d1e198d9-8425-49d2-bc78-93f0a86674d0	4f7c1ae3-2df4-4064-9026-cd6fde4195f6	f
ce9366ab-71c7-4e77-b7dc-1e69c9458b62	ee214e36-9f2f-4207-84ac-ce12848b0550	f
ce9366ab-71c7-4e77-b7dc-1e69c9458b62	c33c200e-e074-4722-a730-33d87bfab61c	t
ce9366ab-71c7-4e77-b7dc-1e69c9458b62	356a372e-712c-4aa3-bedf-1eaac0de3baf	t
ce9366ab-71c7-4e77-b7dc-1e69c9458b62	33930219-11f7-43a5-b413-9ce7a1ae60a1	t
ce9366ab-71c7-4e77-b7dc-1e69c9458b62	db4fa263-45bd-4efd-a612-51d4972ca6d7	t
ce9366ab-71c7-4e77-b7dc-1e69c9458b62	130e15d8-94d1-4e6a-bd38-f507ed5468ba	f
ce9366ab-71c7-4e77-b7dc-1e69c9458b62	41ea5502-3b1c-4aaa-9708-b6545251311f	f
ce9366ab-71c7-4e77-b7dc-1e69c9458b62	b2619f52-3b42-4375-8960-a8def3c96d39	t
ce9366ab-71c7-4e77-b7dc-1e69c9458b62	db76de7b-5f64-43e1-81b5-86bca09fb0bb	t
ce9366ab-71c7-4e77-b7dc-1e69c9458b62	363cdf68-d20b-4a1b-a263-fee42b8695c3	f
ce9366ab-71c7-4e77-b7dc-1e69c9458b62	d984e2db-6e4b-4a85-8d41-5e049f274145	t
ce9366ab-71c7-4e77-b7dc-1e69c9458b62	f0ac861f-3f0e-4c7a-bfb8-5d8c7a26680e	t
ce9366ab-71c7-4e77-b7dc-1e69c9458b62	b3d140e6-1c36-4d74-9cbf-361707af3dae	f
ce9366ab-71c7-4e77-b7dc-1e69c9458b62	6c8fe887-ac8c-4c77-a801-8b52f956833a	t
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id, details_json_long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only, organization_id, hide_on_login) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: jgroups_ping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.jgroups_ping (address, name, cluster_name, ip, coord) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_group (id, name, parent_group, realm_id, type) FROM stdin;
d73d85c2-2568-464e-a820-0d8fc4709a95	c1e30e05-0655-42b6-9e4f-32310eb650c8	 	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	1
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
129c5554-7cd2-4e26-93f9-ba743e323b41	d1e198d9-8425-49d2-bc78-93f0a86674d0	f	${role_default-roles}	default-roles-master	d1e198d9-8425-49d2-bc78-93f0a86674d0	\N	\N
a205d29a-df0a-4fcf-aaea-312636fac4f8	d1e198d9-8425-49d2-bc78-93f0a86674d0	f	${role_admin}	admin	d1e198d9-8425-49d2-bc78-93f0a86674d0	\N	\N
ecc18ff7-85a6-40ef-941d-2f103b7d1c07	d1e198d9-8425-49d2-bc78-93f0a86674d0	f	${role_create-realm}	create-realm	d1e198d9-8425-49d2-bc78-93f0a86674d0	\N	\N
95a69587-0d76-462b-b4ad-cd55c0a0fb14	c15b624c-74e1-4846-9b13-437b714eb009	t	${role_create-client}	create-client	d1e198d9-8425-49d2-bc78-93f0a86674d0	c15b624c-74e1-4846-9b13-437b714eb009	\N
28839de6-368b-4b5b-aed0-3fa207957dac	c15b624c-74e1-4846-9b13-437b714eb009	t	${role_view-realm}	view-realm	d1e198d9-8425-49d2-bc78-93f0a86674d0	c15b624c-74e1-4846-9b13-437b714eb009	\N
f0b33279-3214-4cf9-b9f6-4d69dd58fe27	c15b624c-74e1-4846-9b13-437b714eb009	t	${role_view-users}	view-users	d1e198d9-8425-49d2-bc78-93f0a86674d0	c15b624c-74e1-4846-9b13-437b714eb009	\N
9bdda955-398d-4932-9a40-9a8e723bbaf5	c15b624c-74e1-4846-9b13-437b714eb009	t	${role_view-clients}	view-clients	d1e198d9-8425-49d2-bc78-93f0a86674d0	c15b624c-74e1-4846-9b13-437b714eb009	\N
28cf274d-9ac6-4321-8b00-de541c945db2	c15b624c-74e1-4846-9b13-437b714eb009	t	${role_view-events}	view-events	d1e198d9-8425-49d2-bc78-93f0a86674d0	c15b624c-74e1-4846-9b13-437b714eb009	\N
ade3ad7b-a7f1-4003-a0cc-e9d50636526f	c15b624c-74e1-4846-9b13-437b714eb009	t	${role_view-identity-providers}	view-identity-providers	d1e198d9-8425-49d2-bc78-93f0a86674d0	c15b624c-74e1-4846-9b13-437b714eb009	\N
25972374-2516-464c-b922-28cc5fc49711	c15b624c-74e1-4846-9b13-437b714eb009	t	${role_view-authorization}	view-authorization	d1e198d9-8425-49d2-bc78-93f0a86674d0	c15b624c-74e1-4846-9b13-437b714eb009	\N
99502015-1af9-4dec-8159-356ee0cd428c	c15b624c-74e1-4846-9b13-437b714eb009	t	${role_manage-realm}	manage-realm	d1e198d9-8425-49d2-bc78-93f0a86674d0	c15b624c-74e1-4846-9b13-437b714eb009	\N
68d7b2f2-c568-4025-9e24-4c5569b4c882	c15b624c-74e1-4846-9b13-437b714eb009	t	${role_manage-users}	manage-users	d1e198d9-8425-49d2-bc78-93f0a86674d0	c15b624c-74e1-4846-9b13-437b714eb009	\N
2f705273-32bd-4a99-ae02-692604bbc872	c15b624c-74e1-4846-9b13-437b714eb009	t	${role_manage-clients}	manage-clients	d1e198d9-8425-49d2-bc78-93f0a86674d0	c15b624c-74e1-4846-9b13-437b714eb009	\N
5798e933-bc22-497e-b79b-4aa261912a5f	c15b624c-74e1-4846-9b13-437b714eb009	t	${role_manage-events}	manage-events	d1e198d9-8425-49d2-bc78-93f0a86674d0	c15b624c-74e1-4846-9b13-437b714eb009	\N
f9438f9f-f743-479f-9161-fa0d1bc3b0f6	c15b624c-74e1-4846-9b13-437b714eb009	t	${role_manage-identity-providers}	manage-identity-providers	d1e198d9-8425-49d2-bc78-93f0a86674d0	c15b624c-74e1-4846-9b13-437b714eb009	\N
a9dc43d7-954b-4e93-ac47-0bcba0411be2	c15b624c-74e1-4846-9b13-437b714eb009	t	${role_manage-authorization}	manage-authorization	d1e198d9-8425-49d2-bc78-93f0a86674d0	c15b624c-74e1-4846-9b13-437b714eb009	\N
4b82bc9d-abbf-4db2-af6a-62a478ca6dfe	c15b624c-74e1-4846-9b13-437b714eb009	t	${role_query-users}	query-users	d1e198d9-8425-49d2-bc78-93f0a86674d0	c15b624c-74e1-4846-9b13-437b714eb009	\N
cf0d04f8-b718-4a89-b363-9140d29223d6	c15b624c-74e1-4846-9b13-437b714eb009	t	${role_query-clients}	query-clients	d1e198d9-8425-49d2-bc78-93f0a86674d0	c15b624c-74e1-4846-9b13-437b714eb009	\N
cb2b7210-d493-4772-a6a3-513dded5f2fe	c15b624c-74e1-4846-9b13-437b714eb009	t	${role_query-realms}	query-realms	d1e198d9-8425-49d2-bc78-93f0a86674d0	c15b624c-74e1-4846-9b13-437b714eb009	\N
c197645c-364e-443a-8032-145844bb543a	c15b624c-74e1-4846-9b13-437b714eb009	t	${role_query-groups}	query-groups	d1e198d9-8425-49d2-bc78-93f0a86674d0	c15b624c-74e1-4846-9b13-437b714eb009	\N
d2f52567-77b9-49c0-bd22-b811cbc60ccb	21a58005-5b16-4573-a738-7f8ead425601	t	${role_view-profile}	view-profile	d1e198d9-8425-49d2-bc78-93f0a86674d0	21a58005-5b16-4573-a738-7f8ead425601	\N
2328c13d-b9fc-4f10-b600-a82176acd108	21a58005-5b16-4573-a738-7f8ead425601	t	${role_manage-account}	manage-account	d1e198d9-8425-49d2-bc78-93f0a86674d0	21a58005-5b16-4573-a738-7f8ead425601	\N
c4e4a09a-a02b-45e3-9b6c-718b031eeb96	21a58005-5b16-4573-a738-7f8ead425601	t	${role_manage-account-links}	manage-account-links	d1e198d9-8425-49d2-bc78-93f0a86674d0	21a58005-5b16-4573-a738-7f8ead425601	\N
c62d4e7d-2730-422e-887d-23cbd7e75f12	21a58005-5b16-4573-a738-7f8ead425601	t	${role_view-applications}	view-applications	d1e198d9-8425-49d2-bc78-93f0a86674d0	21a58005-5b16-4573-a738-7f8ead425601	\N
d322c4b4-1484-4a2f-98ac-a49463abbf57	21a58005-5b16-4573-a738-7f8ead425601	t	${role_view-consent}	view-consent	d1e198d9-8425-49d2-bc78-93f0a86674d0	21a58005-5b16-4573-a738-7f8ead425601	\N
b744989e-2783-4d1b-b050-d924be2fbadf	21a58005-5b16-4573-a738-7f8ead425601	t	${role_manage-consent}	manage-consent	d1e198d9-8425-49d2-bc78-93f0a86674d0	21a58005-5b16-4573-a738-7f8ead425601	\N
9a6a2d8c-4569-47ac-bf7c-eb35b023db1b	21a58005-5b16-4573-a738-7f8ead425601	t	${role_view-groups}	view-groups	d1e198d9-8425-49d2-bc78-93f0a86674d0	21a58005-5b16-4573-a738-7f8ead425601	\N
2a30d0c2-345e-4aab-b5fa-425e596ca42a	21a58005-5b16-4573-a738-7f8ead425601	t	${role_delete-account}	delete-account	d1e198d9-8425-49d2-bc78-93f0a86674d0	21a58005-5b16-4573-a738-7f8ead425601	\N
126699af-a187-4c11-b900-ad67e050b219	46ea88a6-96e5-423e-a421-417b0b7ed4c3	t	${role_read-token}	read-token	d1e198d9-8425-49d2-bc78-93f0a86674d0	46ea88a6-96e5-423e-a421-417b0b7ed4c3	\N
7bf58337-4531-4fa6-ae18-5af289d0bfed	c15b624c-74e1-4846-9b13-437b714eb009	t	${role_impersonation}	impersonation	d1e198d9-8425-49d2-bc78-93f0a86674d0	c15b624c-74e1-4846-9b13-437b714eb009	\N
6f945141-2201-4835-9872-0ddf395b939e	d1e198d9-8425-49d2-bc78-93f0a86674d0	f	${role_offline-access}	offline_access	d1e198d9-8425-49d2-bc78-93f0a86674d0	\N	\N
9bcf2b29-7e23-4df9-91af-f7e705c65797	d1e198d9-8425-49d2-bc78-93f0a86674d0	f	${role_uma_authorization}	uma_authorization	d1e198d9-8425-49d2-bc78-93f0a86674d0	\N	\N
41d517a4-c08a-4e1a-878e-1b1b5aadc9e0	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	f	${role_default-roles}	default-roles-boxty	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	\N	\N
f64433f9-2966-4bb3-8b9b-f16a47f8528b	65985cf3-3664-4734-8ea3-d79f101ed400	t	${role_create-client}	create-client	d1e198d9-8425-49d2-bc78-93f0a86674d0	65985cf3-3664-4734-8ea3-d79f101ed400	\N
29d6c134-3e1f-4ea4-9058-33b0b16ce18f	65985cf3-3664-4734-8ea3-d79f101ed400	t	${role_view-realm}	view-realm	d1e198d9-8425-49d2-bc78-93f0a86674d0	65985cf3-3664-4734-8ea3-d79f101ed400	\N
a27c7a06-9dac-4e64-8905-c38ae67506d5	65985cf3-3664-4734-8ea3-d79f101ed400	t	${role_view-users}	view-users	d1e198d9-8425-49d2-bc78-93f0a86674d0	65985cf3-3664-4734-8ea3-d79f101ed400	\N
09f7fd64-fac6-455a-b211-c53e75cf1cf2	65985cf3-3664-4734-8ea3-d79f101ed400	t	${role_view-clients}	view-clients	d1e198d9-8425-49d2-bc78-93f0a86674d0	65985cf3-3664-4734-8ea3-d79f101ed400	\N
3cda6482-07b5-4698-8e6a-36d7f91fca32	65985cf3-3664-4734-8ea3-d79f101ed400	t	${role_view-events}	view-events	d1e198d9-8425-49d2-bc78-93f0a86674d0	65985cf3-3664-4734-8ea3-d79f101ed400	\N
21d4fa16-5afb-4e89-8165-53aba131a5a0	65985cf3-3664-4734-8ea3-d79f101ed400	t	${role_view-identity-providers}	view-identity-providers	d1e198d9-8425-49d2-bc78-93f0a86674d0	65985cf3-3664-4734-8ea3-d79f101ed400	\N
ac6ea938-cb8c-46c9-a377-0d1ae9af73cd	65985cf3-3664-4734-8ea3-d79f101ed400	t	${role_view-authorization}	view-authorization	d1e198d9-8425-49d2-bc78-93f0a86674d0	65985cf3-3664-4734-8ea3-d79f101ed400	\N
2f101f4c-7bc5-4021-add0-78f5c23368a1	65985cf3-3664-4734-8ea3-d79f101ed400	t	${role_manage-realm}	manage-realm	d1e198d9-8425-49d2-bc78-93f0a86674d0	65985cf3-3664-4734-8ea3-d79f101ed400	\N
8eb962d5-0bfb-40e1-bd28-c6af0d296f68	65985cf3-3664-4734-8ea3-d79f101ed400	t	${role_manage-users}	manage-users	d1e198d9-8425-49d2-bc78-93f0a86674d0	65985cf3-3664-4734-8ea3-d79f101ed400	\N
bc4316e7-10f7-4ffc-94a3-1941554300b6	65985cf3-3664-4734-8ea3-d79f101ed400	t	${role_manage-clients}	manage-clients	d1e198d9-8425-49d2-bc78-93f0a86674d0	65985cf3-3664-4734-8ea3-d79f101ed400	\N
26e106e0-8e88-41ad-96ba-3cf991d1611f	65985cf3-3664-4734-8ea3-d79f101ed400	t	${role_manage-events}	manage-events	d1e198d9-8425-49d2-bc78-93f0a86674d0	65985cf3-3664-4734-8ea3-d79f101ed400	\N
36c2edb7-13f2-4d06-975d-1f71e80adc34	65985cf3-3664-4734-8ea3-d79f101ed400	t	${role_manage-identity-providers}	manage-identity-providers	d1e198d9-8425-49d2-bc78-93f0a86674d0	65985cf3-3664-4734-8ea3-d79f101ed400	\N
4541b18b-1d5b-441a-9e2b-4f79e4bacda2	65985cf3-3664-4734-8ea3-d79f101ed400	t	${role_manage-authorization}	manage-authorization	d1e198d9-8425-49d2-bc78-93f0a86674d0	65985cf3-3664-4734-8ea3-d79f101ed400	\N
04a8e1c3-08b6-4974-b6a4-ca6b3a61c257	65985cf3-3664-4734-8ea3-d79f101ed400	t	${role_query-users}	query-users	d1e198d9-8425-49d2-bc78-93f0a86674d0	65985cf3-3664-4734-8ea3-d79f101ed400	\N
8e6ce435-2cea-4330-8f17-e0a20a1bc579	65985cf3-3664-4734-8ea3-d79f101ed400	t	${role_query-clients}	query-clients	d1e198d9-8425-49d2-bc78-93f0a86674d0	65985cf3-3664-4734-8ea3-d79f101ed400	\N
a5e456fa-e4bd-4c91-be68-0f19322de88f	65985cf3-3664-4734-8ea3-d79f101ed400	t	${role_query-realms}	query-realms	d1e198d9-8425-49d2-bc78-93f0a86674d0	65985cf3-3664-4734-8ea3-d79f101ed400	\N
aa2a6d23-edda-42b4-ac16-83a692092fc0	65985cf3-3664-4734-8ea3-d79f101ed400	t	${role_query-groups}	query-groups	d1e198d9-8425-49d2-bc78-93f0a86674d0	65985cf3-3664-4734-8ea3-d79f101ed400	\N
58cc6f53-b4b4-4b3e-85f9-679cabcbe4ad	16f41b45-36c4-4db5-adfd-33de04c58368	t	${role_realm-admin}	realm-admin	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	16f41b45-36c4-4db5-adfd-33de04c58368	\N
e0c4b607-6780-4dd7-a3f5-35e8c0737d4d	16f41b45-36c4-4db5-adfd-33de04c58368	t	${role_create-client}	create-client	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	16f41b45-36c4-4db5-adfd-33de04c58368	\N
41287b27-34f9-4017-bcbf-28dac959242c	16f41b45-36c4-4db5-adfd-33de04c58368	t	${role_view-realm}	view-realm	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	16f41b45-36c4-4db5-adfd-33de04c58368	\N
430ae7c6-2567-441a-933a-b58644795bbd	16f41b45-36c4-4db5-adfd-33de04c58368	t	${role_view-users}	view-users	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	16f41b45-36c4-4db5-adfd-33de04c58368	\N
2b4cc9be-04ed-47a1-b23e-1c8df0ff1322	16f41b45-36c4-4db5-adfd-33de04c58368	t	${role_view-clients}	view-clients	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	16f41b45-36c4-4db5-adfd-33de04c58368	\N
422137dd-3a64-4917-ab0d-422493f0e6d5	16f41b45-36c4-4db5-adfd-33de04c58368	t	${role_view-events}	view-events	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	16f41b45-36c4-4db5-adfd-33de04c58368	\N
87b335fa-3933-41b5-96d9-d00257a44032	16f41b45-36c4-4db5-adfd-33de04c58368	t	${role_view-identity-providers}	view-identity-providers	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	16f41b45-36c4-4db5-adfd-33de04c58368	\N
026978be-dc8d-453a-8a3e-be03f9d46b72	16f41b45-36c4-4db5-adfd-33de04c58368	t	${role_view-authorization}	view-authorization	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	16f41b45-36c4-4db5-adfd-33de04c58368	\N
a5460bff-98c0-4667-b52e-41a355aa6be7	16f41b45-36c4-4db5-adfd-33de04c58368	t	${role_manage-realm}	manage-realm	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	16f41b45-36c4-4db5-adfd-33de04c58368	\N
77cc6527-d6c6-4091-b822-3655a70c4654	16f41b45-36c4-4db5-adfd-33de04c58368	t	${role_manage-users}	manage-users	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	16f41b45-36c4-4db5-adfd-33de04c58368	\N
67f1e222-0cd9-423e-bcc6-1f9ad10e5e92	16f41b45-36c4-4db5-adfd-33de04c58368	t	${role_manage-clients}	manage-clients	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	16f41b45-36c4-4db5-adfd-33de04c58368	\N
9cf4da6d-020c-4999-b1ca-51a669f73de8	16f41b45-36c4-4db5-adfd-33de04c58368	t	${role_manage-events}	manage-events	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	16f41b45-36c4-4db5-adfd-33de04c58368	\N
6749d4fb-f1d4-447f-adf4-ac1b7f2ad8c5	16f41b45-36c4-4db5-adfd-33de04c58368	t	${role_manage-identity-providers}	manage-identity-providers	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	16f41b45-36c4-4db5-adfd-33de04c58368	\N
ee80d3de-f54e-48cd-a958-6e9e4e5302bc	16f41b45-36c4-4db5-adfd-33de04c58368	t	${role_manage-authorization}	manage-authorization	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	16f41b45-36c4-4db5-adfd-33de04c58368	\N
a2bb1519-ac4c-480e-bcd4-c91d7eb9fcc8	16f41b45-36c4-4db5-adfd-33de04c58368	t	${role_query-users}	query-users	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	16f41b45-36c4-4db5-adfd-33de04c58368	\N
8140d602-ac57-471c-8616-a992190ffdc4	16f41b45-36c4-4db5-adfd-33de04c58368	t	${role_query-clients}	query-clients	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	16f41b45-36c4-4db5-adfd-33de04c58368	\N
c8b8736d-7201-4041-83f0-c1152e264cb6	16f41b45-36c4-4db5-adfd-33de04c58368	t	${role_query-realms}	query-realms	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	16f41b45-36c4-4db5-adfd-33de04c58368	\N
2e1147d4-5104-43e4-8ca2-91eade939bc6	16f41b45-36c4-4db5-adfd-33de04c58368	t	${role_query-groups}	query-groups	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	16f41b45-36c4-4db5-adfd-33de04c58368	\N
31c0f576-6416-43e8-8158-c5050ca95d6e	a4cb068a-7f7e-4441-ab59-466479c727f8	t	${role_view-profile}	view-profile	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	a4cb068a-7f7e-4441-ab59-466479c727f8	\N
7dc39e18-6515-4401-87b5-da07408ee055	a4cb068a-7f7e-4441-ab59-466479c727f8	t	${role_manage-account}	manage-account	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	a4cb068a-7f7e-4441-ab59-466479c727f8	\N
178b37d0-0a3a-44b7-b6a2-7045639f060a	a4cb068a-7f7e-4441-ab59-466479c727f8	t	${role_manage-account-links}	manage-account-links	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	a4cb068a-7f7e-4441-ab59-466479c727f8	\N
3998c624-262a-4430-8f98-ce5978ff4748	a4cb068a-7f7e-4441-ab59-466479c727f8	t	${role_view-applications}	view-applications	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	a4cb068a-7f7e-4441-ab59-466479c727f8	\N
e81c0e33-b9dd-4a82-967b-66fda7933633	a4cb068a-7f7e-4441-ab59-466479c727f8	t	${role_view-consent}	view-consent	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	a4cb068a-7f7e-4441-ab59-466479c727f8	\N
557244cc-1a6a-40f3-9cca-83268c6e7adb	a4cb068a-7f7e-4441-ab59-466479c727f8	t	${role_manage-consent}	manage-consent	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	a4cb068a-7f7e-4441-ab59-466479c727f8	\N
24d0f6b8-d994-4ed8-8746-e1fad9ea9971	a4cb068a-7f7e-4441-ab59-466479c727f8	t	${role_view-groups}	view-groups	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	a4cb068a-7f7e-4441-ab59-466479c727f8	\N
90efcb33-147e-4cd6-a852-7a9e40e5eac0	a4cb068a-7f7e-4441-ab59-466479c727f8	t	${role_delete-account}	delete-account	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	a4cb068a-7f7e-4441-ab59-466479c727f8	\N
3c985ed3-0db1-445a-aa0d-7f9dff4d2abb	65985cf3-3664-4734-8ea3-d79f101ed400	t	${role_impersonation}	impersonation	d1e198d9-8425-49d2-bc78-93f0a86674d0	65985cf3-3664-4734-8ea3-d79f101ed400	\N
67704d9b-8ad8-45af-97af-4f46d1a0a326	16f41b45-36c4-4db5-adfd-33de04c58368	t	${role_impersonation}	impersonation	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	16f41b45-36c4-4db5-adfd-33de04c58368	\N
15905709-3f0a-4509-83ea-a8cd9591ae0c	2b8a29d1-dfc3-4f71-b5b2-1024060b950d	t	${role_read-token}	read-token	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	2b8a29d1-dfc3-4f71-b5b2-1024060b950d	\N
52aac5e2-8b15-48c8-9b31-2e068b0518e3	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	f	${role_offline-access}	offline_access	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	\N	\N
3756b3c3-6a28-4b69-9d23-ad3d53b1be50	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	f	${role_uma_authorization}	uma_authorization	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	\N	\N
73545b65-a146-42e6-bf03-5193671cffcd	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	f		administrator	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	\N	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.migration_model (id, version, update_time) FROM stdin;
3toxy	26.1.5	1768681768
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id, version) FROM stdin;
6a4fbd64-8166-4579-8014-806496d7eddb	975635d5-0c2b-4fce-a2a3-dd81ab1eac7a	0	1768690143	{"authMethod":"openid-connect","redirectUri":"http://localhost:5004/authentication/login-callback","notes":{"clientId":"975635d5-0c2b-4fce-a2a3-dd81ab1eac7a","iss":"http://localhost:8181/realms/Boxty","startedAt":"1768687459","response_type":"code","level-of-authentication":"-1","code_challenge_method":"S256","response_mode":"query","scope":"openid profile boxty_webapi-scope","userSessionStartedAt":"1768687459","redirect_uri":"http://localhost:5004/authentication/login-callback","state":"6f85b828497b4b8fa88eeae628a21533","code_challenge":"IYySMxYvCo-LdcdujCCrhiW3wdFUQZCZSojf4V_ROZs","prompt":"none","SSO_AUTH":"true"}}	local	local	7
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh, broker_session_id, version) FROM stdin;
6a4fbd64-8166-4579-8014-806496d7eddb	de8d2617-58f1-4965-a523-811e2f1a1eec	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	1768687459	0	{"ipAddress":"172.18.0.1","authMethod":"openid-connect","rememberMe":false,"started":0,"notes":{"KC_DEVICE_NOTE":"eyJpcEFkZHJlc3MiOiIxNzIuMTguMC4xIiwib3MiOiJVYnVudHUiLCJvc1ZlcnNpb24iOiJVbmtub3duIiwiYnJvd3NlciI6IkZpcmVmb3gvMTQ3LjAiLCJkZXZpY2UiOiJPdGhlciIsImxhc3RBY2Nlc3MiOjAsIm1vYmlsZSI6ZmFsc2V9","AUTH_TIME":"1768687459","authenticators-completed":"{\\"6eddc57b-39e4-4d45-b230-253a2ef88119\\":1768687420,\\"b4e6131e-c175-4f50-9c40-02497f642992\\":1768689490}"},"state":"LOGGED_IN"}	1768690143	\N	7
\.


--
-- Data for Name: org; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.org (id, enabled, realm_id, group_id, name, description, alias, redirect_url) FROM stdin;
c1e30e05-0655-42b6-9e4f-32310eb650c8	t	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	d73d85c2-2568-464e-a820-0d8fc4709a95	Boxty		Boxty	\N
\.


--
-- Data for Name: org_domain; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.org_domain (id, name, verified, org_id) FROM stdin;
d0bdd59d-028f-422c-ad01-8f7608e0a5e8	boxty.org	f	c1e30e05-0655-42b6-9e4f-32310eb650c8
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
570e8647-2c19-4e3e-a3a5-70d8ca017407	audience resolve	openid-connect	oidc-audience-resolve-mapper	8043b157-f18f-453a-af2b-f982773b836d	\N
9c480101-742f-41b8-8165-5d0bb1aa1d4b	locale	openid-connect	oidc-usermodel-attribute-mapper	37270d19-ac39-4c63-b628-eb5e3371546d	\N
20acd129-c4b5-4d1a-9134-f1f1778911f1	role list	saml	saml-role-list-mapper	\N	89b6ccba-0ceb-4fd6-bf26-afa10d3a0203
e717c7a4-2484-4fb5-a264-5b5369ab37bc	organization	saml	saml-organization-membership-mapper	\N	f21f92dc-9e52-45b4-8200-1bffa83eba9a
6cd12ce8-94b4-4316-ad30-fc7945f62d60	full name	openid-connect	oidc-full-name-mapper	\N	5159c8bb-b08a-4f3c-992a-b5a39c1b4779
d2546b05-452c-495d-9809-0b90ff98287e	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	5159c8bb-b08a-4f3c-992a-b5a39c1b4779
b90c8d26-ab08-4d9e-ab9c-94eca37c6c2f	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	5159c8bb-b08a-4f3c-992a-b5a39c1b4779
83d41094-7a2e-4200-be55-e8a44f4a4a74	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	5159c8bb-b08a-4f3c-992a-b5a39c1b4779
aa81d9a1-89ff-4f53-a87a-da4f1000c4e8	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	5159c8bb-b08a-4f3c-992a-b5a39c1b4779
9d230c7d-49f3-414a-a39f-44101419d458	username	openid-connect	oidc-usermodel-attribute-mapper	\N	5159c8bb-b08a-4f3c-992a-b5a39c1b4779
6435b4b6-7644-49ae-92e1-d5f0a0080fed	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	5159c8bb-b08a-4f3c-992a-b5a39c1b4779
e18b3360-8fd5-443e-b920-a980618b59b1	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	5159c8bb-b08a-4f3c-992a-b5a39c1b4779
7bd06758-5c34-4ae2-b5c1-3925f4261c61	website	openid-connect	oidc-usermodel-attribute-mapper	\N	5159c8bb-b08a-4f3c-992a-b5a39c1b4779
978b8f08-3078-4c23-96a4-e20cf7c4c674	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	5159c8bb-b08a-4f3c-992a-b5a39c1b4779
e6f01a25-4ae1-4b95-8746-54507f0901c2	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	5159c8bb-b08a-4f3c-992a-b5a39c1b4779
a06306eb-4761-4554-93fd-355680fad3fa	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	5159c8bb-b08a-4f3c-992a-b5a39c1b4779
543fb062-0b20-4199-9518-456ae8e7e0f5	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	5159c8bb-b08a-4f3c-992a-b5a39c1b4779
fb5c8684-12f0-4233-83ce-6a6be5ee1444	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	5159c8bb-b08a-4f3c-992a-b5a39c1b4779
bfb290c3-7041-40dc-994a-924f98f7e28f	email	openid-connect	oidc-usermodel-attribute-mapper	\N	9711cbec-2695-4017-b902-d18284e917bf
bd1ea5d4-3a62-484f-a85c-92808683fd10	email verified	openid-connect	oidc-usermodel-property-mapper	\N	9711cbec-2695-4017-b902-d18284e917bf
1593af75-cd4f-455d-95b5-5fc1f397ac9e	address	openid-connect	oidc-address-mapper	\N	5f5924d8-2cf7-411b-b2f2-9494cb19a710
dc7479ca-8b61-482b-8730-a00d0c3d5891	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	df8d0e89-d1e8-4d2a-b360-83b3926dc53a
d9601df5-b3ff-41eb-948f-8b0cf2c067bf	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	df8d0e89-d1e8-4d2a-b360-83b3926dc53a
d8b07d02-074f-4b3a-b526-e2b400cfd497	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	285c0f70-91a0-483d-a961-4abcf1b53b15
56845700-cac5-4265-b1a5-13a4eec9204f	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	285c0f70-91a0-483d-a961-4abcf1b53b15
facc145d-6908-4b71-b420-0ccd6aab8087	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	285c0f70-91a0-483d-a961-4abcf1b53b15
9039402c-8520-46ca-adde-9833fcf33cef	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	63b93bb7-9496-4b07-bbc5-2c44fc521b6d
9b703fb7-5402-46aa-8d31-d38b8d451fe1	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	3bac3b68-c660-43d8-8099-04e5dbb3b835
ca72ad35-734b-49df-b1da-8a9f735dd0ca	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	3bac3b68-c660-43d8-8099-04e5dbb3b835
8c325dab-09b3-4803-b6ae-a87509bfd22b	acr loa level	openid-connect	oidc-acr-mapper	\N	baf14ede-f1ce-468d-b3cc-86a1f5036cbe
3be5cb56-1d8d-41fa-9082-a0520f9c6c2a	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	284ac003-5e92-4715-819a-d053bfb5d35b
74c87f1b-48a8-41df-9952-57df11dc8e1c	sub	openid-connect	oidc-sub-mapper	\N	284ac003-5e92-4715-819a-d053bfb5d35b
063085fa-640f-46f9-95c7-3e58f9624bef	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	\N	eb1c8960-0199-4e23-b868-77c647921092
70db726f-6e4c-469a-80a5-fb54b142f8c0	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	\N	eb1c8960-0199-4e23-b868-77c647921092
ca7014eb-72cf-4a40-a80b-1f490c591dfa	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	\N	eb1c8960-0199-4e23-b868-77c647921092
06e5d39d-aa29-4f16-81af-efbe2dfd6ea4	organization	openid-connect	oidc-organization-membership-mapper	\N	4f7c1ae3-2df4-4064-9026-cd6fde4195f6
eac492d1-4af2-45f0-8ae7-009a5d9bbb4a	audience resolve	openid-connect	oidc-audience-resolve-mapper	91ac20eb-19d4-4312-86e0-6e13b2fbb0d4	\N
17d4a16a-9fc3-46ad-a472-f53267fb901a	role list	saml	saml-role-list-mapper	\N	c33c200e-e074-4722-a730-33d87bfab61c
8d095514-b2bd-48b0-a2f7-1ab1aae645b1	organization	saml	saml-organization-membership-mapper	\N	356a372e-712c-4aa3-bedf-1eaac0de3baf
4042e320-13d6-4dc4-b267-c5043f443aae	full name	openid-connect	oidc-full-name-mapper	\N	33930219-11f7-43a5-b413-9ce7a1ae60a1
153a91a8-a932-4a37-8fd7-b3714a959d7c	family name	openid-connect	oidc-usermodel-attribute-mapper	\N	33930219-11f7-43a5-b413-9ce7a1ae60a1
ab60df75-66c8-48fb-97a0-398adcda69fb	given name	openid-connect	oidc-usermodel-attribute-mapper	\N	33930219-11f7-43a5-b413-9ce7a1ae60a1
a9a4c01e-5374-43e8-98d9-6f1aa47cbccc	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	33930219-11f7-43a5-b413-9ce7a1ae60a1
684509f1-7b52-47d3-9ec4-481738ef14d5	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	33930219-11f7-43a5-b413-9ce7a1ae60a1
27e42f94-aa44-4df9-886b-8a7e1633616c	username	openid-connect	oidc-usermodel-attribute-mapper	\N	33930219-11f7-43a5-b413-9ce7a1ae60a1
cf51d07b-fe2c-43f3-831c-2935848cfe65	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	33930219-11f7-43a5-b413-9ce7a1ae60a1
1319f62a-379f-400b-9f61-1c91a3164777	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	33930219-11f7-43a5-b413-9ce7a1ae60a1
cb3e6e0e-7461-486d-8923-ad2d3430ec79	website	openid-connect	oidc-usermodel-attribute-mapper	\N	33930219-11f7-43a5-b413-9ce7a1ae60a1
5836b7a2-a359-4016-a5a3-e771976bea36	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	33930219-11f7-43a5-b413-9ce7a1ae60a1
5fac63ec-3390-45d1-9748-b4335d9a05b0	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	33930219-11f7-43a5-b413-9ce7a1ae60a1
176ed3ad-a2d3-4873-a601-1d5a52323b53	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	33930219-11f7-43a5-b413-9ce7a1ae60a1
b328ce72-b840-437f-a195-4e69a63bd15a	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	33930219-11f7-43a5-b413-9ce7a1ae60a1
1dee3e83-8cac-4c51-8bc4-85f714a57dcf	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	33930219-11f7-43a5-b413-9ce7a1ae60a1
822e589b-03be-4968-9a4e-709d60dcbdcb	email	openid-connect	oidc-usermodel-attribute-mapper	\N	db4fa263-45bd-4efd-a612-51d4972ca6d7
d91b9ad4-7cda-4100-84a6-7899d08c40a0	email verified	openid-connect	oidc-usermodel-property-mapper	\N	db4fa263-45bd-4efd-a612-51d4972ca6d7
a2b84cbf-9eda-4884-a43d-ebeee1063a89	address	openid-connect	oidc-address-mapper	\N	130e15d8-94d1-4e6a-bd38-f507ed5468ba
80fe8c75-586a-43c9-a149-8211e4f4421b	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	41ea5502-3b1c-4aaa-9708-b6545251311f
1ea8c27a-97c4-4309-ad4a-dedea00421c2	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	41ea5502-3b1c-4aaa-9708-b6545251311f
17a307c0-4d7b-401a-bd34-d6c7062a194c	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	b2619f52-3b42-4375-8960-a8def3c96d39
4efcc4f1-19b5-46cf-a226-9b3eb81daae6	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	b2619f52-3b42-4375-8960-a8def3c96d39
8762ecae-d063-418e-a7a8-921b4144738d	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	b2619f52-3b42-4375-8960-a8def3c96d39
3afa92dc-7658-42c4-8ba1-48a793c8db67	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	db76de7b-5f64-43e1-81b5-86bca09fb0bb
5a9b149e-84f8-4b99-9586-c5aeff5773eb	upn	openid-connect	oidc-usermodel-attribute-mapper	\N	363cdf68-d20b-4a1b-a263-fee42b8695c3
ae0a649b-d2a9-42bc-aa4a-bd9f5a7032fe	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	363cdf68-d20b-4a1b-a263-fee42b8695c3
c6c2b9eb-0daa-4f60-a3ef-63f39bd371b5	acr loa level	openid-connect	oidc-acr-mapper	\N	d984e2db-6e4b-4a85-8d41-5e049f274145
c6df2d38-5c7f-4907-9e37-e0289ee62eb6	auth_time	openid-connect	oidc-usersessionmodel-note-mapper	\N	f0ac861f-3f0e-4c7a-bfb8-5d8c7a26680e
aa11ac20-6088-4868-96e3-5acb4d3a046a	sub	openid-connect	oidc-sub-mapper	\N	f0ac861f-3f0e-4c7a-bfb8-5d8c7a26680e
95b93d35-aede-4410-a6d6-a173eaa94799	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	\N	a5e4ec15-29cd-4ace-a76f-09d80b16b636
84fe2013-d318-4763-97e8-36d5415bcd1e	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	\N	a5e4ec15-29cd-4ace-a76f-09d80b16b636
4f22da4e-c824-43a0-a3f5-8ec22614f712	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	\N	a5e4ec15-29cd-4ace-a76f-09d80b16b636
56d84693-0d7c-4094-8ac8-71b1023a40f5	organization	openid-connect	oidc-organization-membership-mapper	\N	6c8fe887-ac8c-4c77-a801-8b52f956833a
cc1156cf-ffdc-4be1-91f5-8e45b2540081	locale	openid-connect	oidc-usermodel-attribute-mapper	d69b827d-2fd5-42b4-a977-55b636ca4ecc	\N
f964afc1-5a2a-417f-a031-da1326301907	boxty_webapi audience	openid-connect	oidc-audience-mapper	\N	b3d140e6-1c36-4d74-9cbf-361707af3dae
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
9c480101-742f-41b8-8165-5d0bb1aa1d4b	true	introspection.token.claim
9c480101-742f-41b8-8165-5d0bb1aa1d4b	true	userinfo.token.claim
9c480101-742f-41b8-8165-5d0bb1aa1d4b	locale	user.attribute
9c480101-742f-41b8-8165-5d0bb1aa1d4b	true	id.token.claim
9c480101-742f-41b8-8165-5d0bb1aa1d4b	true	access.token.claim
9c480101-742f-41b8-8165-5d0bb1aa1d4b	locale	claim.name
9c480101-742f-41b8-8165-5d0bb1aa1d4b	String	jsonType.label
20acd129-c4b5-4d1a-9134-f1f1778911f1	false	single
20acd129-c4b5-4d1a-9134-f1f1778911f1	Basic	attribute.nameformat
20acd129-c4b5-4d1a-9134-f1f1778911f1	Role	attribute.name
543fb062-0b20-4199-9518-456ae8e7e0f5	true	introspection.token.claim
543fb062-0b20-4199-9518-456ae8e7e0f5	true	userinfo.token.claim
543fb062-0b20-4199-9518-456ae8e7e0f5	locale	user.attribute
543fb062-0b20-4199-9518-456ae8e7e0f5	true	id.token.claim
543fb062-0b20-4199-9518-456ae8e7e0f5	true	access.token.claim
543fb062-0b20-4199-9518-456ae8e7e0f5	locale	claim.name
543fb062-0b20-4199-9518-456ae8e7e0f5	String	jsonType.label
6435b4b6-7644-49ae-92e1-d5f0a0080fed	true	introspection.token.claim
6435b4b6-7644-49ae-92e1-d5f0a0080fed	true	userinfo.token.claim
6435b4b6-7644-49ae-92e1-d5f0a0080fed	profile	user.attribute
6435b4b6-7644-49ae-92e1-d5f0a0080fed	true	id.token.claim
6435b4b6-7644-49ae-92e1-d5f0a0080fed	true	access.token.claim
6435b4b6-7644-49ae-92e1-d5f0a0080fed	profile	claim.name
6435b4b6-7644-49ae-92e1-d5f0a0080fed	String	jsonType.label
6cd12ce8-94b4-4316-ad30-fc7945f62d60	true	introspection.token.claim
6cd12ce8-94b4-4316-ad30-fc7945f62d60	true	userinfo.token.claim
6cd12ce8-94b4-4316-ad30-fc7945f62d60	true	id.token.claim
6cd12ce8-94b4-4316-ad30-fc7945f62d60	true	access.token.claim
7bd06758-5c34-4ae2-b5c1-3925f4261c61	true	introspection.token.claim
7bd06758-5c34-4ae2-b5c1-3925f4261c61	true	userinfo.token.claim
7bd06758-5c34-4ae2-b5c1-3925f4261c61	website	user.attribute
7bd06758-5c34-4ae2-b5c1-3925f4261c61	true	id.token.claim
7bd06758-5c34-4ae2-b5c1-3925f4261c61	true	access.token.claim
7bd06758-5c34-4ae2-b5c1-3925f4261c61	website	claim.name
7bd06758-5c34-4ae2-b5c1-3925f4261c61	String	jsonType.label
83d41094-7a2e-4200-be55-e8a44f4a4a74	true	introspection.token.claim
83d41094-7a2e-4200-be55-e8a44f4a4a74	true	userinfo.token.claim
83d41094-7a2e-4200-be55-e8a44f4a4a74	middleName	user.attribute
83d41094-7a2e-4200-be55-e8a44f4a4a74	true	id.token.claim
83d41094-7a2e-4200-be55-e8a44f4a4a74	true	access.token.claim
83d41094-7a2e-4200-be55-e8a44f4a4a74	middle_name	claim.name
83d41094-7a2e-4200-be55-e8a44f4a4a74	String	jsonType.label
978b8f08-3078-4c23-96a4-e20cf7c4c674	true	introspection.token.claim
978b8f08-3078-4c23-96a4-e20cf7c4c674	true	userinfo.token.claim
978b8f08-3078-4c23-96a4-e20cf7c4c674	gender	user.attribute
978b8f08-3078-4c23-96a4-e20cf7c4c674	true	id.token.claim
978b8f08-3078-4c23-96a4-e20cf7c4c674	true	access.token.claim
978b8f08-3078-4c23-96a4-e20cf7c4c674	gender	claim.name
978b8f08-3078-4c23-96a4-e20cf7c4c674	String	jsonType.label
9d230c7d-49f3-414a-a39f-44101419d458	true	introspection.token.claim
9d230c7d-49f3-414a-a39f-44101419d458	true	userinfo.token.claim
9d230c7d-49f3-414a-a39f-44101419d458	username	user.attribute
9d230c7d-49f3-414a-a39f-44101419d458	true	id.token.claim
9d230c7d-49f3-414a-a39f-44101419d458	true	access.token.claim
9d230c7d-49f3-414a-a39f-44101419d458	preferred_username	claim.name
9d230c7d-49f3-414a-a39f-44101419d458	String	jsonType.label
a06306eb-4761-4554-93fd-355680fad3fa	true	introspection.token.claim
a06306eb-4761-4554-93fd-355680fad3fa	true	userinfo.token.claim
a06306eb-4761-4554-93fd-355680fad3fa	zoneinfo	user.attribute
a06306eb-4761-4554-93fd-355680fad3fa	true	id.token.claim
a06306eb-4761-4554-93fd-355680fad3fa	true	access.token.claim
a06306eb-4761-4554-93fd-355680fad3fa	zoneinfo	claim.name
a06306eb-4761-4554-93fd-355680fad3fa	String	jsonType.label
aa81d9a1-89ff-4f53-a87a-da4f1000c4e8	true	introspection.token.claim
aa81d9a1-89ff-4f53-a87a-da4f1000c4e8	true	userinfo.token.claim
aa81d9a1-89ff-4f53-a87a-da4f1000c4e8	nickname	user.attribute
aa81d9a1-89ff-4f53-a87a-da4f1000c4e8	true	id.token.claim
aa81d9a1-89ff-4f53-a87a-da4f1000c4e8	true	access.token.claim
aa81d9a1-89ff-4f53-a87a-da4f1000c4e8	nickname	claim.name
aa81d9a1-89ff-4f53-a87a-da4f1000c4e8	String	jsonType.label
b90c8d26-ab08-4d9e-ab9c-94eca37c6c2f	true	introspection.token.claim
b90c8d26-ab08-4d9e-ab9c-94eca37c6c2f	true	userinfo.token.claim
b90c8d26-ab08-4d9e-ab9c-94eca37c6c2f	firstName	user.attribute
b90c8d26-ab08-4d9e-ab9c-94eca37c6c2f	true	id.token.claim
b90c8d26-ab08-4d9e-ab9c-94eca37c6c2f	true	access.token.claim
b90c8d26-ab08-4d9e-ab9c-94eca37c6c2f	given_name	claim.name
b90c8d26-ab08-4d9e-ab9c-94eca37c6c2f	String	jsonType.label
d2546b05-452c-495d-9809-0b90ff98287e	true	introspection.token.claim
d2546b05-452c-495d-9809-0b90ff98287e	true	userinfo.token.claim
d2546b05-452c-495d-9809-0b90ff98287e	lastName	user.attribute
d2546b05-452c-495d-9809-0b90ff98287e	true	id.token.claim
d2546b05-452c-495d-9809-0b90ff98287e	true	access.token.claim
d2546b05-452c-495d-9809-0b90ff98287e	family_name	claim.name
d2546b05-452c-495d-9809-0b90ff98287e	String	jsonType.label
e18b3360-8fd5-443e-b920-a980618b59b1	true	introspection.token.claim
e18b3360-8fd5-443e-b920-a980618b59b1	true	userinfo.token.claim
e18b3360-8fd5-443e-b920-a980618b59b1	picture	user.attribute
e18b3360-8fd5-443e-b920-a980618b59b1	true	id.token.claim
e18b3360-8fd5-443e-b920-a980618b59b1	true	access.token.claim
e18b3360-8fd5-443e-b920-a980618b59b1	picture	claim.name
e18b3360-8fd5-443e-b920-a980618b59b1	String	jsonType.label
e6f01a25-4ae1-4b95-8746-54507f0901c2	true	introspection.token.claim
e6f01a25-4ae1-4b95-8746-54507f0901c2	true	userinfo.token.claim
e6f01a25-4ae1-4b95-8746-54507f0901c2	birthdate	user.attribute
e6f01a25-4ae1-4b95-8746-54507f0901c2	true	id.token.claim
e6f01a25-4ae1-4b95-8746-54507f0901c2	true	access.token.claim
e6f01a25-4ae1-4b95-8746-54507f0901c2	birthdate	claim.name
e6f01a25-4ae1-4b95-8746-54507f0901c2	String	jsonType.label
fb5c8684-12f0-4233-83ce-6a6be5ee1444	true	introspection.token.claim
fb5c8684-12f0-4233-83ce-6a6be5ee1444	true	userinfo.token.claim
fb5c8684-12f0-4233-83ce-6a6be5ee1444	updatedAt	user.attribute
fb5c8684-12f0-4233-83ce-6a6be5ee1444	true	id.token.claim
fb5c8684-12f0-4233-83ce-6a6be5ee1444	true	access.token.claim
fb5c8684-12f0-4233-83ce-6a6be5ee1444	updated_at	claim.name
fb5c8684-12f0-4233-83ce-6a6be5ee1444	long	jsonType.label
bd1ea5d4-3a62-484f-a85c-92808683fd10	true	introspection.token.claim
bd1ea5d4-3a62-484f-a85c-92808683fd10	true	userinfo.token.claim
bd1ea5d4-3a62-484f-a85c-92808683fd10	emailVerified	user.attribute
bd1ea5d4-3a62-484f-a85c-92808683fd10	true	id.token.claim
bd1ea5d4-3a62-484f-a85c-92808683fd10	true	access.token.claim
bd1ea5d4-3a62-484f-a85c-92808683fd10	email_verified	claim.name
bd1ea5d4-3a62-484f-a85c-92808683fd10	boolean	jsonType.label
bfb290c3-7041-40dc-994a-924f98f7e28f	true	introspection.token.claim
bfb290c3-7041-40dc-994a-924f98f7e28f	true	userinfo.token.claim
bfb290c3-7041-40dc-994a-924f98f7e28f	email	user.attribute
bfb290c3-7041-40dc-994a-924f98f7e28f	true	id.token.claim
bfb290c3-7041-40dc-994a-924f98f7e28f	true	access.token.claim
bfb290c3-7041-40dc-994a-924f98f7e28f	email	claim.name
bfb290c3-7041-40dc-994a-924f98f7e28f	String	jsonType.label
1593af75-cd4f-455d-95b5-5fc1f397ac9e	formatted	user.attribute.formatted
1593af75-cd4f-455d-95b5-5fc1f397ac9e	country	user.attribute.country
1593af75-cd4f-455d-95b5-5fc1f397ac9e	true	introspection.token.claim
1593af75-cd4f-455d-95b5-5fc1f397ac9e	postal_code	user.attribute.postal_code
1593af75-cd4f-455d-95b5-5fc1f397ac9e	true	userinfo.token.claim
1593af75-cd4f-455d-95b5-5fc1f397ac9e	street	user.attribute.street
1593af75-cd4f-455d-95b5-5fc1f397ac9e	true	id.token.claim
1593af75-cd4f-455d-95b5-5fc1f397ac9e	region	user.attribute.region
1593af75-cd4f-455d-95b5-5fc1f397ac9e	true	access.token.claim
1593af75-cd4f-455d-95b5-5fc1f397ac9e	locality	user.attribute.locality
d9601df5-b3ff-41eb-948f-8b0cf2c067bf	true	introspection.token.claim
d9601df5-b3ff-41eb-948f-8b0cf2c067bf	true	userinfo.token.claim
d9601df5-b3ff-41eb-948f-8b0cf2c067bf	phoneNumberVerified	user.attribute
d9601df5-b3ff-41eb-948f-8b0cf2c067bf	true	id.token.claim
d9601df5-b3ff-41eb-948f-8b0cf2c067bf	true	access.token.claim
d9601df5-b3ff-41eb-948f-8b0cf2c067bf	phone_number_verified	claim.name
d9601df5-b3ff-41eb-948f-8b0cf2c067bf	boolean	jsonType.label
dc7479ca-8b61-482b-8730-a00d0c3d5891	true	introspection.token.claim
dc7479ca-8b61-482b-8730-a00d0c3d5891	true	userinfo.token.claim
dc7479ca-8b61-482b-8730-a00d0c3d5891	phoneNumber	user.attribute
dc7479ca-8b61-482b-8730-a00d0c3d5891	true	id.token.claim
dc7479ca-8b61-482b-8730-a00d0c3d5891	true	access.token.claim
dc7479ca-8b61-482b-8730-a00d0c3d5891	phone_number	claim.name
dc7479ca-8b61-482b-8730-a00d0c3d5891	String	jsonType.label
56845700-cac5-4265-b1a5-13a4eec9204f	true	introspection.token.claim
56845700-cac5-4265-b1a5-13a4eec9204f	true	multivalued
56845700-cac5-4265-b1a5-13a4eec9204f	foo	user.attribute
56845700-cac5-4265-b1a5-13a4eec9204f	true	access.token.claim
56845700-cac5-4265-b1a5-13a4eec9204f	resource_access.${client_id}.roles	claim.name
56845700-cac5-4265-b1a5-13a4eec9204f	String	jsonType.label
d8b07d02-074f-4b3a-b526-e2b400cfd497	true	introspection.token.claim
d8b07d02-074f-4b3a-b526-e2b400cfd497	true	multivalued
d8b07d02-074f-4b3a-b526-e2b400cfd497	foo	user.attribute
d8b07d02-074f-4b3a-b526-e2b400cfd497	true	access.token.claim
d8b07d02-074f-4b3a-b526-e2b400cfd497	realm_access.roles	claim.name
d8b07d02-074f-4b3a-b526-e2b400cfd497	String	jsonType.label
facc145d-6908-4b71-b420-0ccd6aab8087	true	introspection.token.claim
facc145d-6908-4b71-b420-0ccd6aab8087	true	access.token.claim
9039402c-8520-46ca-adde-9833fcf33cef	true	introspection.token.claim
9039402c-8520-46ca-adde-9833fcf33cef	true	access.token.claim
9b703fb7-5402-46aa-8d31-d38b8d451fe1	true	introspection.token.claim
9b703fb7-5402-46aa-8d31-d38b8d451fe1	true	userinfo.token.claim
9b703fb7-5402-46aa-8d31-d38b8d451fe1	username	user.attribute
9b703fb7-5402-46aa-8d31-d38b8d451fe1	true	id.token.claim
9b703fb7-5402-46aa-8d31-d38b8d451fe1	true	access.token.claim
9b703fb7-5402-46aa-8d31-d38b8d451fe1	upn	claim.name
9b703fb7-5402-46aa-8d31-d38b8d451fe1	String	jsonType.label
ca72ad35-734b-49df-b1da-8a9f735dd0ca	true	introspection.token.claim
ca72ad35-734b-49df-b1da-8a9f735dd0ca	true	multivalued
ca72ad35-734b-49df-b1da-8a9f735dd0ca	foo	user.attribute
ca72ad35-734b-49df-b1da-8a9f735dd0ca	true	id.token.claim
ca72ad35-734b-49df-b1da-8a9f735dd0ca	true	access.token.claim
ca72ad35-734b-49df-b1da-8a9f735dd0ca	groups	claim.name
ca72ad35-734b-49df-b1da-8a9f735dd0ca	String	jsonType.label
8c325dab-09b3-4803-b6ae-a87509bfd22b	true	introspection.token.claim
8c325dab-09b3-4803-b6ae-a87509bfd22b	true	id.token.claim
8c325dab-09b3-4803-b6ae-a87509bfd22b	true	access.token.claim
3be5cb56-1d8d-41fa-9082-a0520f9c6c2a	AUTH_TIME	user.session.note
3be5cb56-1d8d-41fa-9082-a0520f9c6c2a	true	introspection.token.claim
3be5cb56-1d8d-41fa-9082-a0520f9c6c2a	true	id.token.claim
3be5cb56-1d8d-41fa-9082-a0520f9c6c2a	true	access.token.claim
3be5cb56-1d8d-41fa-9082-a0520f9c6c2a	auth_time	claim.name
3be5cb56-1d8d-41fa-9082-a0520f9c6c2a	long	jsonType.label
74c87f1b-48a8-41df-9952-57df11dc8e1c	true	introspection.token.claim
74c87f1b-48a8-41df-9952-57df11dc8e1c	true	access.token.claim
063085fa-640f-46f9-95c7-3e58f9624bef	client_id	user.session.note
063085fa-640f-46f9-95c7-3e58f9624bef	true	introspection.token.claim
063085fa-640f-46f9-95c7-3e58f9624bef	true	id.token.claim
063085fa-640f-46f9-95c7-3e58f9624bef	true	access.token.claim
063085fa-640f-46f9-95c7-3e58f9624bef	client_id	claim.name
063085fa-640f-46f9-95c7-3e58f9624bef	String	jsonType.label
70db726f-6e4c-469a-80a5-fb54b142f8c0	clientHost	user.session.note
70db726f-6e4c-469a-80a5-fb54b142f8c0	true	introspection.token.claim
70db726f-6e4c-469a-80a5-fb54b142f8c0	true	id.token.claim
70db726f-6e4c-469a-80a5-fb54b142f8c0	true	access.token.claim
70db726f-6e4c-469a-80a5-fb54b142f8c0	clientHost	claim.name
70db726f-6e4c-469a-80a5-fb54b142f8c0	String	jsonType.label
ca7014eb-72cf-4a40-a80b-1f490c591dfa	clientAddress	user.session.note
ca7014eb-72cf-4a40-a80b-1f490c591dfa	true	introspection.token.claim
ca7014eb-72cf-4a40-a80b-1f490c591dfa	true	id.token.claim
ca7014eb-72cf-4a40-a80b-1f490c591dfa	true	access.token.claim
ca7014eb-72cf-4a40-a80b-1f490c591dfa	clientAddress	claim.name
ca7014eb-72cf-4a40-a80b-1f490c591dfa	String	jsonType.label
06e5d39d-aa29-4f16-81af-efbe2dfd6ea4	true	introspection.token.claim
06e5d39d-aa29-4f16-81af-efbe2dfd6ea4	true	multivalued
06e5d39d-aa29-4f16-81af-efbe2dfd6ea4	true	id.token.claim
06e5d39d-aa29-4f16-81af-efbe2dfd6ea4	true	access.token.claim
06e5d39d-aa29-4f16-81af-efbe2dfd6ea4	organization	claim.name
06e5d39d-aa29-4f16-81af-efbe2dfd6ea4	String	jsonType.label
17d4a16a-9fc3-46ad-a472-f53267fb901a	false	single
17d4a16a-9fc3-46ad-a472-f53267fb901a	Basic	attribute.nameformat
17d4a16a-9fc3-46ad-a472-f53267fb901a	Role	attribute.name
1319f62a-379f-400b-9f61-1c91a3164777	true	introspection.token.claim
1319f62a-379f-400b-9f61-1c91a3164777	true	userinfo.token.claim
1319f62a-379f-400b-9f61-1c91a3164777	picture	user.attribute
1319f62a-379f-400b-9f61-1c91a3164777	true	id.token.claim
1319f62a-379f-400b-9f61-1c91a3164777	true	access.token.claim
1319f62a-379f-400b-9f61-1c91a3164777	picture	claim.name
1319f62a-379f-400b-9f61-1c91a3164777	String	jsonType.label
153a91a8-a932-4a37-8fd7-b3714a959d7c	true	introspection.token.claim
153a91a8-a932-4a37-8fd7-b3714a959d7c	true	userinfo.token.claim
153a91a8-a932-4a37-8fd7-b3714a959d7c	lastName	user.attribute
153a91a8-a932-4a37-8fd7-b3714a959d7c	true	id.token.claim
153a91a8-a932-4a37-8fd7-b3714a959d7c	true	access.token.claim
153a91a8-a932-4a37-8fd7-b3714a959d7c	family_name	claim.name
153a91a8-a932-4a37-8fd7-b3714a959d7c	String	jsonType.label
176ed3ad-a2d3-4873-a601-1d5a52323b53	true	introspection.token.claim
176ed3ad-a2d3-4873-a601-1d5a52323b53	true	userinfo.token.claim
176ed3ad-a2d3-4873-a601-1d5a52323b53	zoneinfo	user.attribute
176ed3ad-a2d3-4873-a601-1d5a52323b53	true	id.token.claim
176ed3ad-a2d3-4873-a601-1d5a52323b53	true	access.token.claim
176ed3ad-a2d3-4873-a601-1d5a52323b53	zoneinfo	claim.name
176ed3ad-a2d3-4873-a601-1d5a52323b53	String	jsonType.label
1dee3e83-8cac-4c51-8bc4-85f714a57dcf	true	introspection.token.claim
1dee3e83-8cac-4c51-8bc4-85f714a57dcf	true	userinfo.token.claim
1dee3e83-8cac-4c51-8bc4-85f714a57dcf	updatedAt	user.attribute
1dee3e83-8cac-4c51-8bc4-85f714a57dcf	true	id.token.claim
1dee3e83-8cac-4c51-8bc4-85f714a57dcf	true	access.token.claim
1dee3e83-8cac-4c51-8bc4-85f714a57dcf	updated_at	claim.name
1dee3e83-8cac-4c51-8bc4-85f714a57dcf	long	jsonType.label
27e42f94-aa44-4df9-886b-8a7e1633616c	true	introspection.token.claim
27e42f94-aa44-4df9-886b-8a7e1633616c	true	userinfo.token.claim
27e42f94-aa44-4df9-886b-8a7e1633616c	username	user.attribute
27e42f94-aa44-4df9-886b-8a7e1633616c	true	id.token.claim
27e42f94-aa44-4df9-886b-8a7e1633616c	true	access.token.claim
27e42f94-aa44-4df9-886b-8a7e1633616c	preferred_username	claim.name
27e42f94-aa44-4df9-886b-8a7e1633616c	String	jsonType.label
4042e320-13d6-4dc4-b267-c5043f443aae	true	introspection.token.claim
4042e320-13d6-4dc4-b267-c5043f443aae	true	userinfo.token.claim
4042e320-13d6-4dc4-b267-c5043f443aae	true	id.token.claim
4042e320-13d6-4dc4-b267-c5043f443aae	true	access.token.claim
5836b7a2-a359-4016-a5a3-e771976bea36	true	introspection.token.claim
5836b7a2-a359-4016-a5a3-e771976bea36	true	userinfo.token.claim
5836b7a2-a359-4016-a5a3-e771976bea36	gender	user.attribute
5836b7a2-a359-4016-a5a3-e771976bea36	true	id.token.claim
5836b7a2-a359-4016-a5a3-e771976bea36	true	access.token.claim
5836b7a2-a359-4016-a5a3-e771976bea36	gender	claim.name
5836b7a2-a359-4016-a5a3-e771976bea36	String	jsonType.label
5fac63ec-3390-45d1-9748-b4335d9a05b0	true	introspection.token.claim
5fac63ec-3390-45d1-9748-b4335d9a05b0	true	userinfo.token.claim
5fac63ec-3390-45d1-9748-b4335d9a05b0	birthdate	user.attribute
5fac63ec-3390-45d1-9748-b4335d9a05b0	true	id.token.claim
5fac63ec-3390-45d1-9748-b4335d9a05b0	true	access.token.claim
5fac63ec-3390-45d1-9748-b4335d9a05b0	birthdate	claim.name
5fac63ec-3390-45d1-9748-b4335d9a05b0	String	jsonType.label
684509f1-7b52-47d3-9ec4-481738ef14d5	true	introspection.token.claim
684509f1-7b52-47d3-9ec4-481738ef14d5	true	userinfo.token.claim
684509f1-7b52-47d3-9ec4-481738ef14d5	nickname	user.attribute
684509f1-7b52-47d3-9ec4-481738ef14d5	true	id.token.claim
684509f1-7b52-47d3-9ec4-481738ef14d5	true	access.token.claim
684509f1-7b52-47d3-9ec4-481738ef14d5	nickname	claim.name
684509f1-7b52-47d3-9ec4-481738ef14d5	String	jsonType.label
a9a4c01e-5374-43e8-98d9-6f1aa47cbccc	true	introspection.token.claim
a9a4c01e-5374-43e8-98d9-6f1aa47cbccc	true	userinfo.token.claim
a9a4c01e-5374-43e8-98d9-6f1aa47cbccc	middleName	user.attribute
a9a4c01e-5374-43e8-98d9-6f1aa47cbccc	true	id.token.claim
a9a4c01e-5374-43e8-98d9-6f1aa47cbccc	true	access.token.claim
a9a4c01e-5374-43e8-98d9-6f1aa47cbccc	middle_name	claim.name
a9a4c01e-5374-43e8-98d9-6f1aa47cbccc	String	jsonType.label
ab60df75-66c8-48fb-97a0-398adcda69fb	true	introspection.token.claim
ab60df75-66c8-48fb-97a0-398adcda69fb	true	userinfo.token.claim
ab60df75-66c8-48fb-97a0-398adcda69fb	firstName	user.attribute
ab60df75-66c8-48fb-97a0-398adcda69fb	true	id.token.claim
ab60df75-66c8-48fb-97a0-398adcda69fb	true	access.token.claim
ab60df75-66c8-48fb-97a0-398adcda69fb	given_name	claim.name
ab60df75-66c8-48fb-97a0-398adcda69fb	String	jsonType.label
b328ce72-b840-437f-a195-4e69a63bd15a	true	introspection.token.claim
b328ce72-b840-437f-a195-4e69a63bd15a	true	userinfo.token.claim
b328ce72-b840-437f-a195-4e69a63bd15a	locale	user.attribute
b328ce72-b840-437f-a195-4e69a63bd15a	true	id.token.claim
b328ce72-b840-437f-a195-4e69a63bd15a	true	access.token.claim
b328ce72-b840-437f-a195-4e69a63bd15a	locale	claim.name
b328ce72-b840-437f-a195-4e69a63bd15a	String	jsonType.label
cb3e6e0e-7461-486d-8923-ad2d3430ec79	true	introspection.token.claim
cb3e6e0e-7461-486d-8923-ad2d3430ec79	true	userinfo.token.claim
cb3e6e0e-7461-486d-8923-ad2d3430ec79	website	user.attribute
cb3e6e0e-7461-486d-8923-ad2d3430ec79	true	id.token.claim
cb3e6e0e-7461-486d-8923-ad2d3430ec79	true	access.token.claim
cb3e6e0e-7461-486d-8923-ad2d3430ec79	website	claim.name
cb3e6e0e-7461-486d-8923-ad2d3430ec79	String	jsonType.label
cf51d07b-fe2c-43f3-831c-2935848cfe65	true	introspection.token.claim
cf51d07b-fe2c-43f3-831c-2935848cfe65	true	userinfo.token.claim
cf51d07b-fe2c-43f3-831c-2935848cfe65	profile	user.attribute
cf51d07b-fe2c-43f3-831c-2935848cfe65	true	id.token.claim
cf51d07b-fe2c-43f3-831c-2935848cfe65	true	access.token.claim
cf51d07b-fe2c-43f3-831c-2935848cfe65	profile	claim.name
cf51d07b-fe2c-43f3-831c-2935848cfe65	String	jsonType.label
822e589b-03be-4968-9a4e-709d60dcbdcb	true	introspection.token.claim
822e589b-03be-4968-9a4e-709d60dcbdcb	true	userinfo.token.claim
822e589b-03be-4968-9a4e-709d60dcbdcb	email	user.attribute
822e589b-03be-4968-9a4e-709d60dcbdcb	true	id.token.claim
822e589b-03be-4968-9a4e-709d60dcbdcb	true	access.token.claim
822e589b-03be-4968-9a4e-709d60dcbdcb	email	claim.name
822e589b-03be-4968-9a4e-709d60dcbdcb	String	jsonType.label
d91b9ad4-7cda-4100-84a6-7899d08c40a0	true	introspection.token.claim
d91b9ad4-7cda-4100-84a6-7899d08c40a0	true	userinfo.token.claim
d91b9ad4-7cda-4100-84a6-7899d08c40a0	emailVerified	user.attribute
d91b9ad4-7cda-4100-84a6-7899d08c40a0	true	id.token.claim
d91b9ad4-7cda-4100-84a6-7899d08c40a0	true	access.token.claim
d91b9ad4-7cda-4100-84a6-7899d08c40a0	email_verified	claim.name
d91b9ad4-7cda-4100-84a6-7899d08c40a0	boolean	jsonType.label
a2b84cbf-9eda-4884-a43d-ebeee1063a89	formatted	user.attribute.formatted
a2b84cbf-9eda-4884-a43d-ebeee1063a89	country	user.attribute.country
a2b84cbf-9eda-4884-a43d-ebeee1063a89	true	introspection.token.claim
a2b84cbf-9eda-4884-a43d-ebeee1063a89	postal_code	user.attribute.postal_code
a2b84cbf-9eda-4884-a43d-ebeee1063a89	true	userinfo.token.claim
a2b84cbf-9eda-4884-a43d-ebeee1063a89	street	user.attribute.street
a2b84cbf-9eda-4884-a43d-ebeee1063a89	true	id.token.claim
a2b84cbf-9eda-4884-a43d-ebeee1063a89	region	user.attribute.region
a2b84cbf-9eda-4884-a43d-ebeee1063a89	true	access.token.claim
a2b84cbf-9eda-4884-a43d-ebeee1063a89	locality	user.attribute.locality
1ea8c27a-97c4-4309-ad4a-dedea00421c2	true	introspection.token.claim
1ea8c27a-97c4-4309-ad4a-dedea00421c2	true	userinfo.token.claim
1ea8c27a-97c4-4309-ad4a-dedea00421c2	phoneNumberVerified	user.attribute
1ea8c27a-97c4-4309-ad4a-dedea00421c2	true	id.token.claim
1ea8c27a-97c4-4309-ad4a-dedea00421c2	true	access.token.claim
1ea8c27a-97c4-4309-ad4a-dedea00421c2	phone_number_verified	claim.name
1ea8c27a-97c4-4309-ad4a-dedea00421c2	boolean	jsonType.label
80fe8c75-586a-43c9-a149-8211e4f4421b	true	introspection.token.claim
80fe8c75-586a-43c9-a149-8211e4f4421b	true	userinfo.token.claim
80fe8c75-586a-43c9-a149-8211e4f4421b	phoneNumber	user.attribute
80fe8c75-586a-43c9-a149-8211e4f4421b	true	id.token.claim
80fe8c75-586a-43c9-a149-8211e4f4421b	true	access.token.claim
80fe8c75-586a-43c9-a149-8211e4f4421b	phone_number	claim.name
80fe8c75-586a-43c9-a149-8211e4f4421b	String	jsonType.label
17a307c0-4d7b-401a-bd34-d6c7062a194c	true	introspection.token.claim
17a307c0-4d7b-401a-bd34-d6c7062a194c	true	multivalued
17a307c0-4d7b-401a-bd34-d6c7062a194c	foo	user.attribute
17a307c0-4d7b-401a-bd34-d6c7062a194c	true	access.token.claim
17a307c0-4d7b-401a-bd34-d6c7062a194c	String	jsonType.label
4efcc4f1-19b5-46cf-a226-9b3eb81daae6	true	introspection.token.claim
4efcc4f1-19b5-46cf-a226-9b3eb81daae6	true	multivalued
4efcc4f1-19b5-46cf-a226-9b3eb81daae6	foo	user.attribute
4efcc4f1-19b5-46cf-a226-9b3eb81daae6	true	access.token.claim
4efcc4f1-19b5-46cf-a226-9b3eb81daae6	resource_access.${client_id}.roles	claim.name
4efcc4f1-19b5-46cf-a226-9b3eb81daae6	String	jsonType.label
8762ecae-d063-418e-a7a8-921b4144738d	true	introspection.token.claim
8762ecae-d063-418e-a7a8-921b4144738d	true	access.token.claim
3afa92dc-7658-42c4-8ba1-48a793c8db67	true	introspection.token.claim
3afa92dc-7658-42c4-8ba1-48a793c8db67	true	access.token.claim
5a9b149e-84f8-4b99-9586-c5aeff5773eb	true	introspection.token.claim
5a9b149e-84f8-4b99-9586-c5aeff5773eb	true	userinfo.token.claim
5a9b149e-84f8-4b99-9586-c5aeff5773eb	username	user.attribute
5a9b149e-84f8-4b99-9586-c5aeff5773eb	true	id.token.claim
5a9b149e-84f8-4b99-9586-c5aeff5773eb	true	access.token.claim
5a9b149e-84f8-4b99-9586-c5aeff5773eb	upn	claim.name
5a9b149e-84f8-4b99-9586-c5aeff5773eb	String	jsonType.label
ae0a649b-d2a9-42bc-aa4a-bd9f5a7032fe	true	introspection.token.claim
ae0a649b-d2a9-42bc-aa4a-bd9f5a7032fe	true	multivalued
ae0a649b-d2a9-42bc-aa4a-bd9f5a7032fe	foo	user.attribute
ae0a649b-d2a9-42bc-aa4a-bd9f5a7032fe	true	id.token.claim
ae0a649b-d2a9-42bc-aa4a-bd9f5a7032fe	true	access.token.claim
ae0a649b-d2a9-42bc-aa4a-bd9f5a7032fe	groups	claim.name
ae0a649b-d2a9-42bc-aa4a-bd9f5a7032fe	String	jsonType.label
c6c2b9eb-0daa-4f60-a3ef-63f39bd371b5	true	introspection.token.claim
c6c2b9eb-0daa-4f60-a3ef-63f39bd371b5	true	id.token.claim
c6c2b9eb-0daa-4f60-a3ef-63f39bd371b5	true	access.token.claim
aa11ac20-6088-4868-96e3-5acb4d3a046a	true	introspection.token.claim
aa11ac20-6088-4868-96e3-5acb4d3a046a	true	access.token.claim
c6df2d38-5c7f-4907-9e37-e0289ee62eb6	AUTH_TIME	user.session.note
c6df2d38-5c7f-4907-9e37-e0289ee62eb6	true	introspection.token.claim
c6df2d38-5c7f-4907-9e37-e0289ee62eb6	true	id.token.claim
c6df2d38-5c7f-4907-9e37-e0289ee62eb6	true	access.token.claim
c6df2d38-5c7f-4907-9e37-e0289ee62eb6	auth_time	claim.name
c6df2d38-5c7f-4907-9e37-e0289ee62eb6	long	jsonType.label
4f22da4e-c824-43a0-a3f5-8ec22614f712	clientAddress	user.session.note
4f22da4e-c824-43a0-a3f5-8ec22614f712	true	introspection.token.claim
4f22da4e-c824-43a0-a3f5-8ec22614f712	true	id.token.claim
4f22da4e-c824-43a0-a3f5-8ec22614f712	true	access.token.claim
4f22da4e-c824-43a0-a3f5-8ec22614f712	clientAddress	claim.name
4f22da4e-c824-43a0-a3f5-8ec22614f712	String	jsonType.label
84fe2013-d318-4763-97e8-36d5415bcd1e	clientHost	user.session.note
84fe2013-d318-4763-97e8-36d5415bcd1e	true	introspection.token.claim
84fe2013-d318-4763-97e8-36d5415bcd1e	true	id.token.claim
84fe2013-d318-4763-97e8-36d5415bcd1e	true	access.token.claim
84fe2013-d318-4763-97e8-36d5415bcd1e	clientHost	claim.name
84fe2013-d318-4763-97e8-36d5415bcd1e	String	jsonType.label
95b93d35-aede-4410-a6d6-a173eaa94799	client_id	user.session.note
95b93d35-aede-4410-a6d6-a173eaa94799	true	introspection.token.claim
95b93d35-aede-4410-a6d6-a173eaa94799	true	id.token.claim
95b93d35-aede-4410-a6d6-a173eaa94799	true	access.token.claim
95b93d35-aede-4410-a6d6-a173eaa94799	client_id	claim.name
95b93d35-aede-4410-a6d6-a173eaa94799	String	jsonType.label
56d84693-0d7c-4094-8ac8-71b1023a40f5	true	introspection.token.claim
56d84693-0d7c-4094-8ac8-71b1023a40f5	true	multivalued
56d84693-0d7c-4094-8ac8-71b1023a40f5	true	id.token.claim
56d84693-0d7c-4094-8ac8-71b1023a40f5	true	access.token.claim
56d84693-0d7c-4094-8ac8-71b1023a40f5	organization	claim.name
cc1156cf-ffdc-4be1-91f5-8e45b2540081	true	introspection.token.claim
cc1156cf-ffdc-4be1-91f5-8e45b2540081	true	userinfo.token.claim
cc1156cf-ffdc-4be1-91f5-8e45b2540081	locale	user.attribute
cc1156cf-ffdc-4be1-91f5-8e45b2540081	true	id.token.claim
cc1156cf-ffdc-4be1-91f5-8e45b2540081	true	access.token.claim
cc1156cf-ffdc-4be1-91f5-8e45b2540081	locale	claim.name
cc1156cf-ffdc-4be1-91f5-8e45b2540081	String	jsonType.label
f964afc1-5a2a-417f-a031-da1326301907	boxty_webapi	included.client.audience
f964afc1-5a2a-417f-a031-da1326301907	false	id.token.claim
f964afc1-5a2a-417f-a031-da1326301907	false	lightweight.claim
f964afc1-5a2a-417f-a031-da1326301907	true	access.token.claim
f964afc1-5a2a-417f-a031-da1326301907	true	introspection.token.claim
56d84693-0d7c-4094-8ac8-71b1023a40f5	JSON	jsonType.label
56d84693-0d7c-4094-8ac8-71b1023a40f5	false	userinfo.token.claim
56d84693-0d7c-4094-8ac8-71b1023a40f5	false	lightweight.claim
56d84693-0d7c-4094-8ac8-71b1023a40f5	true	addOrganizationAttributes
56d84693-0d7c-4094-8ac8-71b1023a40f5	true	addOrganizationId
17a307c0-4d7b-401a-bd34-d6c7062a194c	role	claim.name
17a307c0-4d7b-401a-bd34-d6c7062a194c	true	userinfo.token.claim
17a307c0-4d7b-401a-bd34-d6c7062a194c	true	id.token.claim
17a307c0-4d7b-401a-bd34-d6c7062a194c	false	lightweight.claim
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
ce9366ab-71c7-4e77-b7dc-1e69c9458b62	60	300	300	\N	\N	\N	t	f	0	\N	Boxty	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	65985cf3-3664-4734-8ea3-d79f101ed400	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	a4cd7229-efb8-4c3b-9ec4-c80e9c6024bf	14747f04-79bd-4788-827c-6f28c3087bea	a3e639e4-86a0-4521-a3ff-fd98a06b9dbd	be5f294a-da00-4675-b3df-c5e9ec4fa1ce	dde9386b-542c-49c7-a1cd-f622046c3588	2592000	f	900	t	f	35f0cba9-2bcb-49c2-b4e9-a6c076e6a296	0	f	0	0	41d517a4-c08a-4e1a-878e-1b1b5aadc9e0
d1e198d9-8425-49d2-bc78-93f0a86674d0	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	c15b624c-74e1-4846-9b13-437b714eb009	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	3e53cabd-a63f-4a78-889f-11557b24c745	648cc273-03cc-45d5-ae49-d0cc6c8a0bc3	f5ddc59c-8c13-4836-883d-faeb17096890	d9c363c8-680b-4ca5-9283-c91fc5c215c3	15e346f4-755a-4c9b-9715-eab3939ae6c9	2592000	f	900	t	f	39c040fe-909d-434b-97e6-f2db5a5e3265	0	f	0	0	129c5554-7cd2-4e26-93f9-ba743e323b41
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	d1e198d9-8425-49d2-bc78-93f0a86674d0	
_browser_header.xContentTypeOptions	d1e198d9-8425-49d2-bc78-93f0a86674d0	nosniff
_browser_header.referrerPolicy	d1e198d9-8425-49d2-bc78-93f0a86674d0	no-referrer
_browser_header.xRobotsTag	d1e198d9-8425-49d2-bc78-93f0a86674d0	none
_browser_header.xFrameOptions	d1e198d9-8425-49d2-bc78-93f0a86674d0	SAMEORIGIN
_browser_header.contentSecurityPolicy	d1e198d9-8425-49d2-bc78-93f0a86674d0	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	d1e198d9-8425-49d2-bc78-93f0a86674d0	1; mode=block
_browser_header.strictTransportSecurity	d1e198d9-8425-49d2-bc78-93f0a86674d0	max-age=31536000; includeSubDomains
bruteForceProtected	d1e198d9-8425-49d2-bc78-93f0a86674d0	false
permanentLockout	d1e198d9-8425-49d2-bc78-93f0a86674d0	false
maxTemporaryLockouts	d1e198d9-8425-49d2-bc78-93f0a86674d0	0
bruteForceStrategy	d1e198d9-8425-49d2-bc78-93f0a86674d0	MULTIPLE
maxFailureWaitSeconds	d1e198d9-8425-49d2-bc78-93f0a86674d0	900
minimumQuickLoginWaitSeconds	d1e198d9-8425-49d2-bc78-93f0a86674d0	60
waitIncrementSeconds	d1e198d9-8425-49d2-bc78-93f0a86674d0	60
quickLoginCheckMilliSeconds	d1e198d9-8425-49d2-bc78-93f0a86674d0	1000
maxDeltaTimeSeconds	d1e198d9-8425-49d2-bc78-93f0a86674d0	43200
failureFactor	d1e198d9-8425-49d2-bc78-93f0a86674d0	30
realmReusableOtpCode	d1e198d9-8425-49d2-bc78-93f0a86674d0	false
firstBrokerLoginFlowId	d1e198d9-8425-49d2-bc78-93f0a86674d0	71a6753d-06e8-456c-840b-ce8b3bf770ba
displayName	d1e198d9-8425-49d2-bc78-93f0a86674d0	Keycloak
displayNameHtml	d1e198d9-8425-49d2-bc78-93f0a86674d0	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	d1e198d9-8425-49d2-bc78-93f0a86674d0	RS256
offlineSessionMaxLifespanEnabled	d1e198d9-8425-49d2-bc78-93f0a86674d0	false
offlineSessionMaxLifespan	d1e198d9-8425-49d2-bc78-93f0a86674d0	5184000
bruteForceProtected	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	false
permanentLockout	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	false
maxTemporaryLockouts	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	0
bruteForceStrategy	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	MULTIPLE
maxFailureWaitSeconds	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	900
minimumQuickLoginWaitSeconds	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	60
waitIncrementSeconds	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	60
quickLoginCheckMilliSeconds	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	1000
maxDeltaTimeSeconds	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	43200
failureFactor	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	30
realmReusableOtpCode	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	false
defaultSignatureAlgorithm	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	RS256
offlineSessionMaxLifespanEnabled	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	false
offlineSessionMaxLifespan	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	5184000
actionTokenGeneratedByAdminLifespan	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	43200
actionTokenGeneratedByUserLifespan	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	300
oauth2DeviceCodeLifespan	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	600
oauth2DevicePollingInterval	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	5
webAuthnPolicyRpEntityName	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	keycloak
webAuthnPolicySignatureAlgorithms	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	ES256,RS256
webAuthnPolicyRpId	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	
webAuthnPolicyAttestationConveyancePreference	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	not specified
webAuthnPolicyAuthenticatorAttachment	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	not specified
webAuthnPolicyRequireResidentKey	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	not specified
webAuthnPolicyUserVerificationRequirement	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	not specified
webAuthnPolicyCreateTimeout	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	0
webAuthnPolicyAvoidSameAuthenticatorRegister	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	false
webAuthnPolicyRpEntityNamePasswordless	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	ES256,RS256
webAuthnPolicyRpIdPasswordless	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	
webAuthnPolicyAttestationConveyancePreferencePasswordless	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	not specified
webAuthnPolicyRequireResidentKeyPasswordless	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	not specified
webAuthnPolicyCreateTimeoutPasswordless	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	false
cibaBackchannelTokenDeliveryMode	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	poll
cibaExpiresIn	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	120
cibaInterval	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	5
cibaAuthRequestedUserHint	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	login_hint
parRequestUriLifespan	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	60
firstBrokerLoginFlowId	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	f770cd9a-613f-4b55-82f0-3925eaf28481
frontendUrl	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	
acr.loa.map	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	{}
displayName	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	
displayNameHtml	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	
adminPermissionsEnabled	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	false
verifiableCredentialsEnabled	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	false
client-policies.profiles	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	{"profiles":[]}
client-policies.policies	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	{"policies":[]}
organizationsEnabled	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	true
clientSessionIdleTimeout	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	0
clientSessionMaxLifespan	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	0
clientOfflineSessionIdleTimeout	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	0
clientOfflineSessionMaxLifespan	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	0
_browser_header.contentSecurityPolicyReportOnly	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	
_browser_header.xContentTypeOptions	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	nosniff
_browser_header.referrerPolicy	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	no-referrer
_browser_header.xRobotsTag	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	none
_browser_header.xFrameOptions	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	SAMEORIGIN
_browser_header.contentSecurityPolicy	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	1; mode=block
_browser_header.strictTransportSecurity	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	max-age=31536000; includeSubDomains
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
d1e198d9-8425-49d2-bc78-93f0a86674d0	jboss-logging
ce9366ab-71c7-4e77-b7dc-1e69c9458b62	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	d1e198d9-8425-49d2-bc78-93f0a86674d0
password	password	t	t	ce9366ab-71c7-4e77-b7dc-1e69c9458b62
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.redirect_uris (client_id, value) FROM stdin;
21a58005-5b16-4573-a738-7f8ead425601	/realms/master/account/*
8043b157-f18f-453a-af2b-f982773b836d	/realms/master/account/*
37270d19-ac39-4c63-b628-eb5e3371546d	/admin/master/console/*
d69b827d-2fd5-42b4-a977-55b636ca4ecc	/admin/Boxty/console/*
a4cb068a-7f7e-4441-ab59-466479c727f8	/realms/Boxty/account/*
91ac20eb-19d4-4312-86e0-6e13b2fbb0d4	/realms/Boxty/account/*
975635d5-0c2b-4fce-a2a3-dd81ab1eac7a	http://localhost:5004/authentication/login-callback
6905d5cc-a4c4-41c7-8e03-b991b5a6076e	/*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
174d6c89-ac27-4fe0-9a74-592eaab53a8e	VERIFY_EMAIL	Verify Email	d1e198d9-8425-49d2-bc78-93f0a86674d0	t	f	VERIFY_EMAIL	50
205eb8f7-052c-466c-ac82-ff951dbb1f3d	UPDATE_PROFILE	Update Profile	d1e198d9-8425-49d2-bc78-93f0a86674d0	t	f	UPDATE_PROFILE	40
155c1a66-01be-4c79-b15b-b1bb46e3a988	CONFIGURE_TOTP	Configure OTP	d1e198d9-8425-49d2-bc78-93f0a86674d0	t	f	CONFIGURE_TOTP	10
fc8124f6-6451-41f5-b457-67667f119483	UPDATE_PASSWORD	Update Password	d1e198d9-8425-49d2-bc78-93f0a86674d0	t	f	UPDATE_PASSWORD	30
cd9e6eec-621b-4905-a18a-4a945e4cae99	TERMS_AND_CONDITIONS	Terms and Conditions	d1e198d9-8425-49d2-bc78-93f0a86674d0	f	f	TERMS_AND_CONDITIONS	20
6ddccb7b-1db4-41b5-9c1a-94cca1167ed7	delete_account	Delete Account	d1e198d9-8425-49d2-bc78-93f0a86674d0	f	f	delete_account	60
2d2afd8b-716e-49ab-b350-138256aa3bb9	delete_credential	Delete Credential	d1e198d9-8425-49d2-bc78-93f0a86674d0	t	f	delete_credential	100
1c6c372e-8370-4b06-81a2-6658dcdcee94	update_user_locale	Update User Locale	d1e198d9-8425-49d2-bc78-93f0a86674d0	t	f	update_user_locale	1000
61628d94-a2fb-476e-9e9c-28dd309db4ec	webauthn-register	Webauthn Register	d1e198d9-8425-49d2-bc78-93f0a86674d0	t	f	webauthn-register	70
bed29ecf-ea7b-419d-a109-4f6e325f0c4b	webauthn-register-passwordless	Webauthn Register Passwordless	d1e198d9-8425-49d2-bc78-93f0a86674d0	t	f	webauthn-register-passwordless	80
0911be45-9ad2-4a65-b56e-a7138173e44d	VERIFY_PROFILE	Verify Profile	d1e198d9-8425-49d2-bc78-93f0a86674d0	t	f	VERIFY_PROFILE	90
2add3558-a08d-4ff5-bb7a-e337a63931dd	VERIFY_EMAIL	Verify Email	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	t	f	VERIFY_EMAIL	50
9b3290c6-6c0b-4fbc-8331-7447f77ae8f9	UPDATE_PROFILE	Update Profile	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	t	f	UPDATE_PROFILE	40
144ff953-c5dc-4f47-8b16-79c05f426105	CONFIGURE_TOTP	Configure OTP	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	t	f	CONFIGURE_TOTP	10
4e581ff3-b804-47c4-bffb-64921f599abf	UPDATE_PASSWORD	Update Password	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	t	f	UPDATE_PASSWORD	30
e81aeed5-bcc2-4585-8f55-604e792dd6c2	TERMS_AND_CONDITIONS	Terms and Conditions	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	f	f	TERMS_AND_CONDITIONS	20
00d0eb7f-958c-47a5-ab98-54fba696a75c	delete_account	Delete Account	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	f	f	delete_account	60
0a671e23-866c-4a8a-a920-db58d973188f	delete_credential	Delete Credential	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	t	f	delete_credential	100
5c4074fd-cf07-4783-89fd-688735bfeb2e	update_user_locale	Update User Locale	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	t	f	update_user_locale	1000
ccf23e2c-3fcb-4a1b-9c2c-0cbd364192f0	webauthn-register	Webauthn Register	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	t	f	webauthn-register	70
ff9060e9-b564-45b2-a9c5-63e1e1e181fd	webauthn-register-passwordless	Webauthn Register Passwordless	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	t	f	webauthn-register-passwordless	80
f5ca8c8c-7e3c-430e-827f-51abd310d31e	VERIFY_PROFILE	Verify Profile	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	t	f	VERIFY_PROFILE	90
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- Data for Name: revoked_token; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.revoked_token (id, expire) FROM stdin;
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
8043b157-f18f-453a-af2b-f982773b836d	9a6a2d8c-4569-47ac-bf7c-eb35b023db1b
8043b157-f18f-453a-af2b-f982773b836d	2328c13d-b9fc-4f10-b600-a82176acd108
91ac20eb-19d4-4312-86e0-6e13b2fbb0d4	7dc39e18-6515-4401-87b5-da07408ee055
91ac20eb-19d4-4312-86e0-6e13b2fbb0d4	24d0f6b8-d994-4ed8-8746-e1fad9ea9971
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_attribute (name, value, user_id, id, long_value_hash, long_value_hash_lower_case, long_value) FROM stdin;
is_temporary_admin	true	096e14ce-1d5f-409f-b00b-09d194cdfb21	1756cb47-60e4-4139-a635-147989b25431	\N	\N	\N
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
096e14ce-1d5f-409f-b00b-09d194cdfb21	\N	75447a7e-9234-4601-8bf7-4ba3a3cd0b9e	f	t	\N	\N	\N	d1e198d9-8425-49d2-bc78-93f0a86674d0	admin	1768681769648	\N	0
e17f76df-78c3-4933-9dcc-f5e892763717	\N	07bdd4f9-384b-4d63-a06c-e34ff5c40a43	f	t	\N	\N	\N	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	service-account-admin-cli	1768682494381	c7ec91f0-159e-4664-b306-e59567bff305	0
de8d2617-58f1-4965-a523-811e2f1a1eec	admin@boxty.org	admin@boxty.org	f	t	\N	Admin	User	ce9366ab-71c7-4e77-b7dc-1e69c9458b62	admin	1768683161959	\N	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_group_membership (group_id, user_id, membership_type) FROM stdin;
d73d85c2-2568-464e-a820-0d8fc4709a95	de8d2617-58f1-4965-a523-811e2f1a1eec	UNMANAGED
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
129c5554-7cd2-4e26-93f9-ba743e323b41	096e14ce-1d5f-409f-b00b-09d194cdfb21
a205d29a-df0a-4fcf-aaea-312636fac4f8	096e14ce-1d5f-409f-b00b-09d194cdfb21
41d517a4-c08a-4e1a-878e-1b1b5aadc9e0	e17f76df-78c3-4933-9dcc-f5e892763717
58cc6f53-b4b4-4b3e-85f9-679cabcbe4ad	e17f76df-78c3-4933-9dcc-f5e892763717
41d517a4-c08a-4e1a-878e-1b1b5aadc9e0	de8d2617-58f1-4965-a523-811e2f1a1eec
73545b65-a146-42e6-bf03-5193671cffcd	de8d2617-58f1-4965-a523-811e2f1a1eec
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.web_origins (client_id, value) FROM stdin;
37270d19-ac39-4c63-b628-eb5e3371546d	+
d69b827d-2fd5-42b4-a977-55b636ca4ecc	+
975635d5-0c2b-4fce-a2a3-dd81ab1eac7a	http://localhost:5004
6905d5cc-a4c4-41c7-8e03-b991b5a6076e	/*
\.


--
-- Name: org_domain ORG_DOMAIN_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org_domain
    ADD CONSTRAINT "ORG_DOMAIN_pkey" PRIMARY KEY (id, name);


--
-- Name: org ORG_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT "ORG_pkey" PRIMARY KEY (id);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: jgroups_ping constraint_jgroups_ping; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.jgroups_ping
    ADD CONSTRAINT constraint_jgroups_ping PRIMARY KEY (address);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: revoked_token constraint_rt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.revoked_token
    ADD CONSTRAINT constraint_rt PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: user_consent uk_external_consent; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_external_consent UNIQUE (client_storage_provider, external_client_id, user_id);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_local_consent; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_local_consent UNIQUE (client_id, user_id);


--
-- Name: org uk_org_alias; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_alias UNIQUE (realm_id, alias);


--
-- Name: org uk_org_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_group UNIQUE (group_id);


--
-- Name: org uk_org_name; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.org
    ADD CONSTRAINT uk_org_name UNIQUE (realm_id, name);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: fed_user_attr_long_values; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX fed_user_attr_long_values ON public.fed_user_attribute USING btree (long_value_hash, name);


--
-- Name: fed_user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX fed_user_attr_long_values_lower_case ON public.fed_user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, substr(value, 1, 255));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_idp_for_login; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_idp_for_login ON public.identity_provider USING btree (realm_id, enabled, link_only, hide_on_login, organization_id);


--
-- Name: idx_idp_realm_org; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_idp_realm_org ON public.identity_provider USING btree (realm_id, organization_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_uss_by_broker_session_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_broker_session_id ON public.offline_user_session USING btree (broker_session_id, realm_id);


--
-- Name: idx_offline_uss_by_last_session_refresh; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_last_session_refresh ON public.offline_user_session USING btree (realm_id, offline_flag, last_session_refresh);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_org_domain_org_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_org_domain_org_id ON public.org_domain USING btree (org_id);


--
-- Name: idx_perm_ticket_owner; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_perm_ticket_owner ON public.resource_server_perm_ticket USING btree (owner);


--
-- Name: idx_perm_ticket_requester; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_perm_ticket_requester ON public.resource_server_perm_ticket USING btree (requester);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_rev_token_on_expire; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_rev_token_on_expire ON public.revoked_token USING btree (expire);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_usconsent_scope_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usconsent_scope_id ON public.user_consent_client_scope USING btree (scope_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: user_attr_long_values; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX user_attr_long_values ON public.user_attribute USING btree (long_value_hash, name);


--
-- Name: user_attr_long_values_lower_case; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX user_attr_long_values_lower_case ON public.user_attribute USING btree (long_value_hash_lower_case, name);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--

