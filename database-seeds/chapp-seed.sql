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

--
-- Name: auth; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO postgres;

--
-- Name: usermanagement; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA usermanagement;


ALTER SCHEMA usermanagement OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: Permission; Type: TABLE; Schema: auth; Owner: postgres
--

CREATE TABLE auth."Permission" (
    "Id" uuid DEFAULT gen_random_uuid() NOT NULL,
    "Name" text NOT NULL
);


ALTER TABLE auth."Permission" OWNER TO postgres;

--
-- Name: Role; Type: TABLE; Schema: auth; Owner: postgres
--

CREATE TABLE auth."Role" (
    "Id" uuid DEFAULT gen_random_uuid() NOT NULL,
    "Name" text NOT NULL
);


ALTER TABLE auth."Role" OWNER TO postgres;

--
-- Name: RolePermission; Type: TABLE; Schema: auth; Owner: postgres
--

CREATE TABLE auth."RolePermission" (
    "RoleId" uuid NOT NULL,
    "PermissionId" uuid NOT NULL
);


ALTER TABLE auth."RolePermission" OWNER TO postgres;

--
-- Name: UserEncryptionKeys; Type: TABLE; Schema: auth; Owner: postgres
--

CREATE TABLE auth."UserEncryptionKeys" (
    "Id" uuid DEFAULT gen_random_uuid() NOT NULL,
    "UserId" text NOT NULL,
    "EncryptedKey" bytea NOT NULL,
    "IV" bytea NOT NULL,
    "KeyGeneratedDate" timestamp with time zone NOT NULL,
    "KeyExpiryDate" timestamp with time zone,
    "MasterKeyVersion" text NOT NULL,
    "Notes" text,
    "IsActive" boolean NOT NULL,
    "CreatedBy" text NOT NULL,
    "LastModifiedBy" text NOT NULL,
    "CreatedDate" timestamp with time zone NOT NULL,
    "ModifiedDate" timestamp with time zone NOT NULL,
    "TenantId" uuid NOT NULL,
    "SubjectId" uuid NOT NULL,
    "CreatedById" uuid NOT NULL,
    "ModifiedById" uuid NOT NULL
);


ALTER TABLE auth."UserEncryptionKeys" OWNER TO postgres;

--
-- Name: __EFMigrationsHistory; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."__EFMigrationsHistory" (
    "MigrationId" character varying(150) NOT NULL,
    "ProductVersion" character varying(32) NOT NULL
);


ALTER TABLE public."__EFMigrationsHistory" OWNER TO postgres;

--
-- Name: SubjectDocuments; Type: TABLE; Schema: usermanagement; Owner: postgres
--

CREATE TABLE usermanagement."SubjectDocuments" (
    "Id" uuid DEFAULT gen_random_uuid() NOT NULL,
    "BlobContainerName" text NOT NULL,
    "BlobName" text NOT NULL,
    "Name" text NOT NULL,
    "Description" text,
    "SearchTags" text NOT NULL,
    "SubjectDocumentType" integer NOT NULL,
    "IsActive" boolean NOT NULL,
    "CreatedBy" text NOT NULL,
    "LastModifiedBy" text NOT NULL,
    "CreatedDate" timestamp with time zone NOT NULL,
    "ModifiedDate" timestamp with time zone NOT NULL,
    "TenantId" uuid NOT NULL,
    "SubjectId" uuid NOT NULL,
    "CreatedById" uuid NOT NULL,
    "ModifiedById" uuid NOT NULL
);


ALTER TABLE usermanagement."SubjectDocuments" OWNER TO postgres;

--
-- Name: SubjectNotes; Type: TABLE; Schema: usermanagement; Owner: postgres
--

CREATE TABLE usermanagement."SubjectNotes" (
    "Id" uuid DEFAULT gen_random_uuid() NOT NULL,
    "Content" text NOT NULL,
    "SubjectId" uuid NOT NULL,
    "IsActive" boolean NOT NULL,
    "CreatedBy" text NOT NULL,
    "LastModifiedBy" text NOT NULL,
    "CreatedDate" timestamp with time zone NOT NULL,
    "ModifiedDate" timestamp with time zone NOT NULL,
    "TenantId" uuid NOT NULL,
    "CreatedById" uuid NOT NULL,
    "ModifiedById" uuid NOT NULL
);


ALTER TABLE usermanagement."SubjectNotes" OWNER TO postgres;

--
-- Name: Subjects; Type: TABLE; Schema: usermanagement; Owner: postgres
--

CREATE TABLE usermanagement."Subjects" (
    "Id" uuid DEFAULT gen_random_uuid() NOT NULL,
    "FirstName" text NOT NULL,
    "LastName" text NOT NULL,
    "Username" text NOT NULL,
    "Telephone" text NOT NULL,
    "Email" text NOT NULL,
    "AvatarImageGuid" uuid NOT NULL,
    "AvatarImage" text,
    "AvatarTitle" text,
    "AvatarDescription" text,
    "DOB" timestamp with time zone,
    "Address1" text NOT NULL,
    "Address2" text,
    "Address3" text,
    "Postcode" text NOT NULL,
    "Notes" text NOT NULL,
    "RelatedDocumentIds" uuid[] NOT NULL,
    "SubjectId" uuid NOT NULL,
    "TenantId" uuid NOT NULL,
    "SearchTags" text NOT NULL,
    "RoleName" text,
    "IsActive" boolean NOT NULL,
    "CreatedBy" text NOT NULL,
    "LastModifiedBy" text NOT NULL,
    "CreatedDate" timestamp with time zone NOT NULL,
    "ModifiedDate" timestamp with time zone NOT NULL,
    "CreatedById" uuid NOT NULL,
    "ModifiedById" uuid NOT NULL
);


ALTER TABLE usermanagement."Subjects" OWNER TO postgres;

--
-- Name: TenantDocuments; Type: TABLE; Schema: usermanagement; Owner: postgres
--

CREATE TABLE usermanagement."TenantDocuments" (
    "Id" uuid DEFAULT gen_random_uuid() NOT NULL,
    "BlobContainerName" text NOT NULL,
    "BlobName" text NOT NULL,
    "Name" text NOT NULL,
    "Description" text,
    "SearchTags" text NOT NULL,
    "TenantDocumentType" integer NOT NULL,
    "IsActive" boolean NOT NULL,
    "CreatedBy" text NOT NULL,
    "LastModifiedBy" text NOT NULL,
    "CreatedDate" timestamp with time zone NOT NULL,
    "ModifiedDate" timestamp with time zone NOT NULL,
    "TenantId" uuid NOT NULL,
    "SubjectId" uuid NOT NULL,
    "CreatedById" uuid NOT NULL,
    "ModifiedById" uuid NOT NULL
);


ALTER TABLE usermanagement."TenantDocuments" OWNER TO postgres;

--
-- Name: TenantNotes; Type: TABLE; Schema: usermanagement; Owner: postgres
--

CREATE TABLE usermanagement."TenantNotes" (
    "Id" uuid DEFAULT gen_random_uuid() NOT NULL,
    "Content" text NOT NULL,
    "TenantId" uuid NOT NULL,
    "IsActive" boolean NOT NULL,
    "CreatedBy" text NOT NULL,
    "LastModifiedBy" text NOT NULL,
    "CreatedDate" timestamp with time zone NOT NULL,
    "ModifiedDate" timestamp with time zone NOT NULL,
    "SubjectId" uuid NOT NULL,
    "CreatedById" uuid NOT NULL,
    "ModifiedById" uuid NOT NULL
);


ALTER TABLE usermanagement."TenantNotes" OWNER TO postgres;

--
-- Name: Tenants; Type: TABLE; Schema: usermanagement; Owner: postgres
--

CREATE TABLE usermanagement."Tenants" (
    "Id" uuid DEFAULT gen_random_uuid() NOT NULL,
    "Name" text NOT NULL,
    "Domain" text NOT NULL,
    "Telephone" text NOT NULL,
    "Address" text NOT NULL,
    "Postcode" text NOT NULL,
    "Website" text NOT NULL,
    "Email" text NOT NULL,
    "Notes" text NOT NULL,
    "RelatedDocumentIds" uuid[] NOT NULL,
    "TenantId" uuid NOT NULL,
    "SearchTags" text NOT NULL,
    "IsActive" boolean NOT NULL,
    "CreatedBy" text NOT NULL,
    "LastModifiedBy" text NOT NULL,
    "CreatedDate" timestamp with time zone NOT NULL,
    "ModifiedDate" timestamp with time zone NOT NULL,
    "SubjectId" uuid NOT NULL,
    "CreatedById" uuid NOT NULL,
    "ModifiedById" uuid NOT NULL
);


ALTER TABLE usermanagement."Tenants" OWNER TO postgres;

--
-- Data for Name: Permission; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth."Permission" ("Id", "Name") FROM stdin;
4c054c76-8aed-4389-913e-e186f282b0cb	CreateRole
d396caf3-28a6-46e4-bf40-4c7952a5524d	DeleteUserEncryptionKey
6cad1c93-dd93-4bfa-9bc5-a5529e88e847	CreateSubjectNote
8bbc30f7-df1c-4473-812b-04befc3807aa	CreateTenant
b1635f55-e5a5-4e29-8f97-10bbf1991e3d	DeleteSubject
28d4cb1e-51dd-4669-803a-033dc77d08ce	DeleteSubjectNote
1b422f7b-7f02-479e-88ff-6e0427607bd3	ViewTenantDocument
4bc71963-1c97-49cc-9eae-963a755d2770	UpdateBaseEntity`1
d4a1311d-f709-4fba-b93b-20706bbe7eb2	UpdateSubjectDocument
8028b77a-cec1-40e5-ad42-ee98a21d92d7	UpdateSubject
96a82db2-8a31-4802-89c4-c4d3b9c59880	CreateSubjectDocument
69c5aa95-7e6f-464f-92f7-a89c3460d4b1	CreateBaseEntity`1
af1de59d-74a7-43ac-b2b0-cd03c1450336	DeleteTenantDocument
d9c34659-23e7-4760-b14c-a506cdbc8f15	UpdateTenantNote
3779b5ca-1120-4d63-96ff-48a3027ec85b	DeleteBaseEntity`1
f807d623-9236-4824-9596-c84db70c8700	DeleteRole
85681d7c-b4c5-4435-a7a8-6085274a0f5e	ViewSubjectDocument
2be0fa13-7a6a-48b8-9110-5a9db2e34968	CreateUserEncryptionKey
c0b80def-76c6-49bb-bcb0-722c86e13ffe	CreatePermission
c3624106-2052-4574-9dd8-848711b8c137	ViewUserEncryptionKey
199ed0d7-5a65-42da-a831-17764f3a8912	UpdateTenant
568a9c4a-f76d-495d-a5a1-7cb9ec0a8caa	UpdateTenantDocument
e0e0b155-2ab8-49ac-8842-88fa32e4c040	ViewSubject
8558d715-f1e4-43d9-997f-af8ebe946414	ViewPermission
cc8b9faf-2fee-4705-8008-aca38b2a0149	ViewTenant
36b0444f-f317-4297-b289-ec931a062a13	UpdateUserEncryptionKey
bc3887e1-5a9c-493c-b75c-e4f649da3784	CreateSubject
ebfc1995-046d-4ba4-ba33-84731a5886e1	UpdateRole
850b5c4c-d041-4b4a-b93e-85c3e87cb5ec	DeletePermission
06622bb7-6dea-4742-b2ff-01e334b5c0f6	ViewRole
8ae3c3a3-a879-403f-a833-de712309d733	ViewTenantNote
6854ab3e-74bd-429f-85ff-45d7bfd54a5c	DeleteTenant
8e73b9ee-2f48-49b0-a4d3-34defabedfaa	UpdatePermission
7d361a7c-3c2e-4519-9ed3-f9c4a498c5c3	ViewSubjectNote
e3147d0c-a4ad-46a2-9d23-ddf0e9b7d777	CreateTenantDocument
7f91f86d-8288-4254-acc4-de4d9c37d666	DeleteSubjectDocument
3eaf7467-d2ff-4cb6-a052-191057d4b75e	DeleteTenantNote
fa6920b0-1de1-47aa-8b1c-3cda90ccf704	CreateTenantNote
039b847e-eab8-49f7-9a33-bd39301851af	ViewBaseEntity`1
e471dc14-d84d-4ef3-9bcc-00817657c8f5	UpdateSubjectNote
\.


--
-- Data for Name: Role; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth."Role" ("Id", "Name") FROM stdin;
11111111-1111-1111-1111-111111111111	Administrator
22222222-2222-2222-2222-222222222222	TenantAdministrator
33333333-3333-3333-3333-333333333333	TenantLimitedAdministrator
44444444-4444-4444-4444-444444444444	Subject
\.


--
-- Data for Name: RolePermission; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth."RolePermission" ("RoleId", "PermissionId") FROM stdin;
11111111-1111-1111-1111-111111111111	06622bb7-6dea-4742-b2ff-01e334b5c0f6
11111111-1111-1111-1111-111111111111	4c054c76-8aed-4389-913e-e186f282b0cb
11111111-1111-1111-1111-111111111111	850b5c4c-d041-4b4a-b93e-85c3e87cb5ec
11111111-1111-1111-1111-111111111111	8558d715-f1e4-43d9-997f-af8ebe946414
11111111-1111-1111-1111-111111111111	8e73b9ee-2f48-49b0-a4d3-34defabedfaa
11111111-1111-1111-1111-111111111111	c0b80def-76c6-49bb-bcb0-722c86e13ffe
11111111-1111-1111-1111-111111111111	ebfc1995-046d-4ba4-ba33-84731a5886e1
11111111-1111-1111-1111-111111111111	f807d623-9236-4824-9596-c84db70c8700
11111111-1111-1111-1111-111111111111	199ed0d7-5a65-42da-a831-17764f3a8912
11111111-1111-1111-1111-111111111111	1b422f7b-7f02-479e-88ff-6e0427607bd3
11111111-1111-1111-1111-111111111111	28d4cb1e-51dd-4669-803a-033dc77d08ce
11111111-1111-1111-1111-111111111111	2be0fa13-7a6a-48b8-9110-5a9db2e34968
11111111-1111-1111-1111-111111111111	36b0444f-f317-4297-b289-ec931a062a13
11111111-1111-1111-1111-111111111111	3eaf7467-d2ff-4cb6-a052-191057d4b75e
11111111-1111-1111-1111-111111111111	568a9c4a-f76d-495d-a5a1-7cb9ec0a8caa
11111111-1111-1111-1111-111111111111	6854ab3e-74bd-429f-85ff-45d7bfd54a5c
11111111-1111-1111-1111-111111111111	6cad1c93-dd93-4bfa-9bc5-a5529e88e847
11111111-1111-1111-1111-111111111111	7d361a7c-3c2e-4519-9ed3-f9c4a498c5c3
11111111-1111-1111-1111-111111111111	7f91f86d-8288-4254-acc4-de4d9c37d666
11111111-1111-1111-1111-111111111111	8028b77a-cec1-40e5-ad42-ee98a21d92d7
11111111-1111-1111-1111-111111111111	85681d7c-b4c5-4435-a7a8-6085274a0f5e
11111111-1111-1111-1111-111111111111	8ae3c3a3-a879-403f-a833-de712309d733
11111111-1111-1111-1111-111111111111	8bbc30f7-df1c-4473-812b-04befc3807aa
11111111-1111-1111-1111-111111111111	96a82db2-8a31-4802-89c4-c4d3b9c59880
11111111-1111-1111-1111-111111111111	af1de59d-74a7-43ac-b2b0-cd03c1450336
11111111-1111-1111-1111-111111111111	b1635f55-e5a5-4e29-8f97-10bbf1991e3d
11111111-1111-1111-1111-111111111111	bc3887e1-5a9c-493c-b75c-e4f649da3784
11111111-1111-1111-1111-111111111111	c3624106-2052-4574-9dd8-848711b8c137
11111111-1111-1111-1111-111111111111	cc8b9faf-2fee-4705-8008-aca38b2a0149
11111111-1111-1111-1111-111111111111	d396caf3-28a6-46e4-bf40-4c7952a5524d
11111111-1111-1111-1111-111111111111	d4a1311d-f709-4fba-b93b-20706bbe7eb2
11111111-1111-1111-1111-111111111111	d9c34659-23e7-4760-b14c-a506cdbc8f15
11111111-1111-1111-1111-111111111111	e0e0b155-2ab8-49ac-8842-88fa32e4c040
11111111-1111-1111-1111-111111111111	e3147d0c-a4ad-46a2-9d23-ddf0e9b7d777
11111111-1111-1111-1111-111111111111	e471dc14-d84d-4ef3-9bcc-00817657c8f5
11111111-1111-1111-1111-111111111111	fa6920b0-1de1-47aa-8b1c-3cda90ccf704
\.


--
-- Data for Name: UserEncryptionKeys; Type: TABLE DATA; Schema: auth; Owner: postgres
--

COPY auth."UserEncryptionKeys" ("Id", "UserId", "EncryptedKey", "IV", "KeyGeneratedDate", "KeyExpiryDate", "MasterKeyVersion", "Notes", "IsActive", "CreatedBy", "LastModifiedBy", "CreatedDate", "ModifiedDate", "TenantId", "SubjectId", "CreatedById", "ModifiedById") FROM stdin;
818d6c7c-506f-4efe-8b7e-2c7de43ae3b9	de8d2617-58f1-4965-a523-811e2f1a1eec	\\x9e263db972d3c8ad2af82a4d95647d9c5693c3e2af9b0f9f3f4c1d8e703724b7ed988fa2e4eeb35510693f5d0bc1c0da	\\xd0690ad06ee6a0b673d43a085d054068	2026-01-17 22:05:33.799112+00	2027-01-17 22:05:33.799124+00	mock-version-1.0	Auto-generated user encryption key	t			-infinity	-infinity	00000000-0000-0000-0000-000000000000	00000000-0000-0000-0000-000000000000	00000000-0000-0000-0000-000000000000	00000000-0000-0000-0000-000000000000
\.


--
-- Data for Name: __EFMigrationsHistory; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."__EFMigrationsHistory" ("MigrationId", "ProductVersion") FROM stdin;
20251031221404_Auth_First_Migration	9.0.3
20251031221424_UserManagement_First_Migration	9.0.3
20260117210814_UserManagement_First_User	9.0.3
20260117211940_UserManagement_Static_Data	9.0.3
\.


--
-- Data for Name: SubjectDocuments; Type: TABLE DATA; Schema: usermanagement; Owner: postgres
--

COPY usermanagement."SubjectDocuments" ("Id", "BlobContainerName", "BlobName", "Name", "Description", "SearchTags", "SubjectDocumentType", "IsActive", "CreatedBy", "LastModifiedBy", "CreatedDate", "ModifiedDate", "TenantId", "SubjectId", "CreatedById", "ModifiedById") FROM stdin;
\.


--
-- Data for Name: SubjectNotes; Type: TABLE DATA; Schema: usermanagement; Owner: postgres
--

COPY usermanagement."SubjectNotes" ("Id", "Content", "SubjectId", "IsActive", "CreatedBy", "LastModifiedBy", "CreatedDate", "ModifiedDate", "TenantId", "CreatedById", "ModifiedById") FROM stdin;
\.


--
-- Data for Name: Subjects; Type: TABLE DATA; Schema: usermanagement; Owner: postgres
--

COPY usermanagement."Subjects" ("Id", "FirstName", "LastName", "Username", "Telephone", "Email", "AvatarImageGuid", "AvatarImage", "AvatarTitle", "AvatarDescription", "DOB", "Address1", "Address2", "Address3", "Postcode", "Notes", "RelatedDocumentIds", "SubjectId", "TenantId", "SearchTags", "RoleName", "IsActive", "CreatedBy", "LastModifiedBy", "CreatedDate", "ModifiedDate", "CreatedById", "ModifiedById") FROM stdin;
de8d2617-58f1-4965-a523-811e2f1a1eec	Admin	User	admin		admin@boxty.org	00000000-0000-0000-0000-000000000000	\N	\N	\N	\N		\N	\N		Root administrator	{}	de8d2617-58f1-4965-a523-811e2f1a1eec	c1e30e05-0655-42b6-9e4f-32310eb650c8		Administrator	t	System	System	2025-01-01 00:00:00+00	2025-01-01 00:00:00+00	de8d2617-58f1-4965-a523-811e2f1a1eec	de8d2617-58f1-4965-a523-811e2f1a1eec
\.


--
-- Data for Name: TenantDocuments; Type: TABLE DATA; Schema: usermanagement; Owner: postgres
--

COPY usermanagement."TenantDocuments" ("Id", "BlobContainerName", "BlobName", "Name", "Description", "SearchTags", "TenantDocumentType", "IsActive", "CreatedBy", "LastModifiedBy", "CreatedDate", "ModifiedDate", "TenantId", "SubjectId", "CreatedById", "ModifiedById") FROM stdin;
\.


--
-- Data for Name: TenantNotes; Type: TABLE DATA; Schema: usermanagement; Owner: postgres
--

COPY usermanagement."TenantNotes" ("Id", "Content", "TenantId", "IsActive", "CreatedBy", "LastModifiedBy", "CreatedDate", "ModifiedDate", "SubjectId", "CreatedById", "ModifiedById") FROM stdin;
\.


--
-- Data for Name: Tenants; Type: TABLE DATA; Schema: usermanagement; Owner: postgres
--

COPY usermanagement."Tenants" ("Id", "Name", "Domain", "Telephone", "Address", "Postcode", "Website", "Email", "Notes", "RelatedDocumentIds", "TenantId", "SearchTags", "IsActive", "CreatedBy", "LastModifiedBy", "CreatedDate", "ModifiedDate", "SubjectId", "CreatedById", "ModifiedById") FROM stdin;
c1e30e05-0655-42b6-9e4f-32310eb650c8	Boxty	boxty.org				https://boxty.org	admin@boxty.org	Root tenant organization	{}	c1e30e05-0655-42b6-9e4f-32310eb650c8		t	System	System	2025-01-01 00:00:00+00	2025-01-01 00:00:00+00	de8d2617-58f1-4965-a523-811e2f1a1eec	de8d2617-58f1-4965-a523-811e2f1a1eec	de8d2617-58f1-4965-a523-811e2f1a1eec
\.


--
-- Name: Permission PK_Permission; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth."Permission"
    ADD CONSTRAINT "PK_Permission" PRIMARY KEY ("Id");


--
-- Name: Role PK_Role; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth."Role"
    ADD CONSTRAINT "PK_Role" PRIMARY KEY ("Id");


--
-- Name: RolePermission PK_RolePermission; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth."RolePermission"
    ADD CONSTRAINT "PK_RolePermission" PRIMARY KEY ("RoleId", "PermissionId");


--
-- Name: UserEncryptionKeys PK_UserEncryptionKeys; Type: CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth."UserEncryptionKeys"
    ADD CONSTRAINT "PK_UserEncryptionKeys" PRIMARY KEY ("Id");


--
-- Name: __EFMigrationsHistory PK___EFMigrationsHistory; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."__EFMigrationsHistory"
    ADD CONSTRAINT "PK___EFMigrationsHistory" PRIMARY KEY ("MigrationId");


--
-- Name: SubjectDocuments PK_SubjectDocuments; Type: CONSTRAINT; Schema: usermanagement; Owner: postgres
--

ALTER TABLE ONLY usermanagement."SubjectDocuments"
    ADD CONSTRAINT "PK_SubjectDocuments" PRIMARY KEY ("Id");


--
-- Name: SubjectNotes PK_SubjectNotes; Type: CONSTRAINT; Schema: usermanagement; Owner: postgres
--

ALTER TABLE ONLY usermanagement."SubjectNotes"
    ADD CONSTRAINT "PK_SubjectNotes" PRIMARY KEY ("Id");


--
-- Name: Subjects PK_Subjects; Type: CONSTRAINT; Schema: usermanagement; Owner: postgres
--

ALTER TABLE ONLY usermanagement."Subjects"
    ADD CONSTRAINT "PK_Subjects" PRIMARY KEY ("Id");


--
-- Name: TenantDocuments PK_TenantDocuments; Type: CONSTRAINT; Schema: usermanagement; Owner: postgres
--

ALTER TABLE ONLY usermanagement."TenantDocuments"
    ADD CONSTRAINT "PK_TenantDocuments" PRIMARY KEY ("Id");


--
-- Name: TenantNotes PK_TenantNotes; Type: CONSTRAINT; Schema: usermanagement; Owner: postgres
--

ALTER TABLE ONLY usermanagement."TenantNotes"
    ADD CONSTRAINT "PK_TenantNotes" PRIMARY KEY ("Id");


--
-- Name: Tenants PK_Tenants; Type: CONSTRAINT; Schema: usermanagement; Owner: postgres
--

ALTER TABLE ONLY usermanagement."Tenants"
    ADD CONSTRAINT "PK_Tenants" PRIMARY KEY ("Id");


--
-- Name: IX_RolePermission_PermissionId; Type: INDEX; Schema: auth; Owner: postgres
--

CREATE INDEX "IX_RolePermission_PermissionId" ON auth."RolePermission" USING btree ("PermissionId");


--
-- Name: IX_UserEncryptionKeys_UserId; Type: INDEX; Schema: auth; Owner: postgres
--

CREATE INDEX "IX_UserEncryptionKeys_UserId" ON auth."UserEncryptionKeys" USING btree ("UserId");


--
-- Name: IX_UserEncryptionKeys_UserId_IsActive; Type: INDEX; Schema: auth; Owner: postgres
--

CREATE INDEX "IX_UserEncryptionKeys_UserId_IsActive" ON auth."UserEncryptionKeys" USING btree ("UserId", "IsActive");


--
-- Name: IX_SubjectNotes_SubjectId; Type: INDEX; Schema: usermanagement; Owner: postgres
--

CREATE INDEX "IX_SubjectNotes_SubjectId" ON usermanagement."SubjectNotes" USING btree ("SubjectId");


--
-- Name: IX_Subjects_TenantId; Type: INDEX; Schema: usermanagement; Owner: postgres
--

CREATE INDEX "IX_Subjects_TenantId" ON usermanagement."Subjects" USING btree ("TenantId");


--
-- Name: IX_TenantNotes_TenantId; Type: INDEX; Schema: usermanagement; Owner: postgres
--

CREATE INDEX "IX_TenantNotes_TenantId" ON usermanagement."TenantNotes" USING btree ("TenantId");


--
-- Name: RolePermission FK_RolePermission_Permission_PermissionId; Type: FK CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth."RolePermission"
    ADD CONSTRAINT "FK_RolePermission_Permission_PermissionId" FOREIGN KEY ("PermissionId") REFERENCES auth."Permission"("Id") ON DELETE CASCADE;


--
-- Name: RolePermission FK_RolePermission_Role_RoleId; Type: FK CONSTRAINT; Schema: auth; Owner: postgres
--

ALTER TABLE ONLY auth."RolePermission"
    ADD CONSTRAINT "FK_RolePermission_Role_RoleId" FOREIGN KEY ("RoleId") REFERENCES auth."Role"("Id") ON DELETE CASCADE;


--
-- Name: SubjectNotes FK_SubjectNotes_Subjects_SubjectId; Type: FK CONSTRAINT; Schema: usermanagement; Owner: postgres
--

ALTER TABLE ONLY usermanagement."SubjectNotes"
    ADD CONSTRAINT "FK_SubjectNotes_Subjects_SubjectId" FOREIGN KEY ("SubjectId") REFERENCES usermanagement."Subjects"("Id") ON DELETE CASCADE;


--
-- Name: Subjects FK_Subjects_Tenants_TenantId; Type: FK CONSTRAINT; Schema: usermanagement; Owner: postgres
--

ALTER TABLE ONLY usermanagement."Subjects"
    ADD CONSTRAINT "FK_Subjects_Tenants_TenantId" FOREIGN KEY ("TenantId") REFERENCES usermanagement."Tenants"("Id") ON DELETE CASCADE;


--
-- Name: TenantNotes FK_TenantNotes_Tenants_TenantId; Type: FK CONSTRAINT; Schema: usermanagement; Owner: postgres
--

ALTER TABLE ONLY usermanagement."TenantNotes"
    ADD CONSTRAINT "FK_TenantNotes_Tenants_TenantId" FOREIGN KEY ("TenantId") REFERENCES usermanagement."Tenants"("Id") ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

