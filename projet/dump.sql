--
-- PostgreSQL database dump
--

-- Dumped from database version 13.8 (Debian 13.8-1.pgdg110+1)
-- Dumped by pg_dump version 13.8 (Debian 13.8-1.pgdg110+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: tiger; Type: SCHEMA; Schema: -; Owner: directus
--

CREATE SCHEMA IF NOT EXISTS tiger;


ALTER SCHEMA tiger OWNER TO directus;

--
-- Name: tiger_data; Type: SCHEMA; Schema: -; Owner: directus
--

CREATE SCHEMA IF NOT EXISTS tiger_data;


ALTER SCHEMA tiger_data OWNER TO directus;

--
-- Name: topology; Type: SCHEMA; Schema: -; Owner: directus
--

CREATE SCHEMA IF NOT EXISTS topology;


ALTER SCHEMA topology OWNER TO directus;

--
-- Name: SCHEMA topology; Type: COMMENT; Schema: -; Owner: directus
--

COMMENT ON SCHEMA topology IS 'PostGIS Topology schema';


--
-- Name: fuzzystrmatch; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS fuzzystrmatch WITH SCHEMA public;


--
-- Name: EXTENSION fuzzystrmatch; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION fuzzystrmatch IS 'determine similarities and distance between strings';


--
-- Name: postgis; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


--
-- Name: EXTENSION postgis; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis IS 'PostGIS geometry and geography spatial types and functions';


--
-- Name: postgis_tiger_geocoder; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder WITH SCHEMA tiger;


--
-- Name: EXTENSION postgis_tiger_geocoder; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_tiger_geocoder IS 'PostGIS tiger geocoder and reverse geocoder';


--
-- Name: postgis_topology; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS postgis_topology WITH SCHEMA topology;


--
-- Name: EXTENSION postgis_topology; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION postgis_topology IS 'PostGIS topology spatial types and functions';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: booking; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.booking (
    id integer NOT NULL,
    date_created timestamp with time zone,
    date_updated timestamp with time zone,
    start_date timestamp without time zone,
    end_date timestamp without time zone,
    workspace_id integer,
    user_id uuid
);


ALTER TABLE public.booking OWNER TO directus;

--
-- Name: booking_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.booking_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.booking_id_seq OWNER TO directus;

--
-- Name: booking_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.booking_id_seq OWNED BY public.booking.id;


--
-- Name: comment; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.comment (
    id integer NOT NULL,
    date_created timestamp with time zone,
    date_updated timestamp with time zone,
    title character varying(255),
    content text,
    date_time timestamp without time zone,
    workspace_id integer,
    user_id uuid
);


ALTER TABLE public.comment OWNER TO directus;

--
-- Name: comment_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.comment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.comment_id_seq OWNER TO directus;

--
-- Name: comment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.comment_id_seq OWNED BY public.comment.id;


--
-- Name: directus_activity; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_activity (
    id integer NOT NULL,
    action character varying(45) NOT NULL,
    "user" uuid,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    ip character varying(50),
    user_agent character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    comment text,
    origin character varying(255)
);


ALTER TABLE public.directus_activity OWNER TO directus;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_activity_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_activity_id_seq OWNER TO directus;

--
-- Name: directus_activity_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_activity_id_seq OWNED BY public.directus_activity.id;


--
-- Name: directus_collections; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_collections (
    collection character varying(64) NOT NULL,
    icon character varying(30),
    note text,
    display_template character varying(255),
    hidden boolean DEFAULT false NOT NULL,
    singleton boolean DEFAULT false NOT NULL,
    translations json,
    archive_field character varying(64),
    archive_app_filter boolean DEFAULT true NOT NULL,
    archive_value character varying(255),
    unarchive_value character varying(255),
    sort_field character varying(64),
    accountability character varying(255) DEFAULT 'all'::character varying,
    color character varying(255),
    item_duplication_fields json,
    sort integer,
    "group" character varying(64),
    collapse character varying(255) DEFAULT 'open'::character varying NOT NULL,
    preview_url character varying(255)
);


ALTER TABLE public.directus_collections OWNER TO directus;

--
-- Name: directus_dashboards; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_dashboards (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(30) DEFAULT 'dashboard'::character varying NOT NULL,
    note text,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid,
    color character varying(255)
);


ALTER TABLE public.directus_dashboards OWNER TO directus;

--
-- Name: directus_fields; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_fields (
    id integer NOT NULL,
    collection character varying(64) NOT NULL,
    field character varying(64) NOT NULL,
    special character varying(64),
    interface character varying(64),
    options json,
    display character varying(64),
    display_options json,
    readonly boolean DEFAULT false NOT NULL,
    hidden boolean DEFAULT false NOT NULL,
    sort integer,
    width character varying(30) DEFAULT 'full'::character varying,
    translations json,
    note text,
    conditions json,
    required boolean DEFAULT false,
    "group" character varying(64),
    validation json,
    validation_message text
);


ALTER TABLE public.directus_fields OWNER TO directus;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_fields_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_fields_id_seq OWNER TO directus;

--
-- Name: directus_fields_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_fields_id_seq OWNED BY public.directus_fields.id;


--
-- Name: directus_files; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_files (
    id uuid NOT NULL,
    storage character varying(255) NOT NULL,
    filename_disk character varying(255),
    filename_download character varying(255) NOT NULL,
    title character varying(255),
    type character varying(255),
    folder uuid,
    uploaded_by uuid,
    uploaded_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    modified_by uuid,
    modified_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    charset character varying(50),
    filesize bigint,
    width integer,
    height integer,
    duration integer,
    embed character varying(200),
    description text,
    location text,
    tags text,
    metadata json
);


ALTER TABLE public.directus_files OWNER TO directus;

--
-- Name: directus_flows; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_flows (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    icon character varying(30),
    color character varying(255),
    description text,
    status character varying(255) DEFAULT 'active'::character varying NOT NULL,
    trigger character varying(255),
    accountability character varying(255) DEFAULT 'all'::character varying,
    options json,
    operation uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_flows OWNER TO directus;

--
-- Name: directus_folders; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_folders (
    id uuid NOT NULL,
    name character varying(255) NOT NULL,
    parent uuid
);


ALTER TABLE public.directus_folders OWNER TO directus;

--
-- Name: directus_migrations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_migrations (
    version character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE public.directus_migrations OWNER TO directus;

--
-- Name: directus_notifications; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_notifications (
    id integer NOT NULL,
    "timestamp" timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    status character varying(255) DEFAULT 'inbox'::character varying,
    recipient uuid NOT NULL,
    sender uuid,
    subject character varying(255) NOT NULL,
    message text,
    collection character varying(64),
    item character varying(255)
);


ALTER TABLE public.directus_notifications OWNER TO directus;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_notifications_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_notifications_id_seq OWNER TO directus;

--
-- Name: directus_notifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_notifications_id_seq OWNED BY public.directus_notifications.id;


--
-- Name: directus_operations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_operations (
    id uuid NOT NULL,
    name character varying(255),
    key character varying(255) NOT NULL,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    options json,
    resolve uuid,
    reject uuid,
    flow uuid NOT NULL,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_operations OWNER TO directus;

--
-- Name: directus_panels; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_panels (
    id uuid NOT NULL,
    dashboard uuid NOT NULL,
    name character varying(255),
    icon character varying(30) DEFAULT NULL::character varying,
    color character varying(10),
    show_header boolean DEFAULT false NOT NULL,
    note text,
    type character varying(255) NOT NULL,
    position_x integer NOT NULL,
    position_y integer NOT NULL,
    width integer NOT NULL,
    height integer NOT NULL,
    options json,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    user_created uuid
);


ALTER TABLE public.directus_panels OWNER TO directus;

--
-- Name: directus_permissions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_permissions (
    id integer NOT NULL,
    role uuid,
    collection character varying(64) NOT NULL,
    action character varying(10) NOT NULL,
    permissions json,
    validation json,
    presets json,
    fields text
);


ALTER TABLE public.directus_permissions OWNER TO directus;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_permissions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_permissions_id_seq OWNER TO directus;

--
-- Name: directus_permissions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_permissions_id_seq OWNED BY public.directus_permissions.id;


--
-- Name: directus_presets; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_presets (
    id integer NOT NULL,
    bookmark character varying(255),
    "user" uuid,
    role uuid,
    collection character varying(64),
    search character varying(100),
    layout character varying(100) DEFAULT 'tabular'::character varying,
    layout_query json,
    layout_options json,
    refresh_interval integer,
    filter json,
    icon character varying(30) DEFAULT 'bookmark'::character varying,
    color character varying(255)
);


ALTER TABLE public.directus_presets OWNER TO directus;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_presets_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_presets_id_seq OWNER TO directus;

--
-- Name: directus_presets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_presets_id_seq OWNED BY public.directus_presets.id;


--
-- Name: directus_relations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_relations (
    id integer NOT NULL,
    many_collection character varying(64) NOT NULL,
    many_field character varying(64) NOT NULL,
    one_collection character varying(64),
    one_field character varying(64),
    one_collection_field character varying(64),
    one_allowed_collections text,
    junction_field character varying(64),
    sort_field character varying(64),
    one_deselect_action character varying(255) DEFAULT 'nullify'::character varying NOT NULL
);


ALTER TABLE public.directus_relations OWNER TO directus;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_relations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_relations_id_seq OWNER TO directus;

--
-- Name: directus_relations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_relations_id_seq OWNED BY public.directus_relations.id;


--
-- Name: directus_revisions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_revisions (
    id integer NOT NULL,
    activity integer NOT NULL,
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    data json,
    delta json,
    parent integer
);


ALTER TABLE public.directus_revisions OWNER TO directus;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_revisions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_revisions_id_seq OWNER TO directus;

--
-- Name: directus_revisions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_revisions_id_seq OWNED BY public.directus_revisions.id;


--
-- Name: directus_roles; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_roles (
    id uuid NOT NULL,
    name character varying(100) NOT NULL,
    icon character varying(30) DEFAULT 'supervised_user_circle'::character varying NOT NULL,
    description text,
    ip_access text,
    enforce_tfa boolean DEFAULT false NOT NULL,
    admin_access boolean DEFAULT false NOT NULL,
    app_access boolean DEFAULT true NOT NULL
);


ALTER TABLE public.directus_roles OWNER TO directus;

--
-- Name: directus_sessions; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_sessions (
    token character varying(64) NOT NULL,
    "user" uuid,
    expires timestamp with time zone NOT NULL,
    ip character varying(255),
    user_agent character varying(255),
    share uuid,
    origin character varying(255)
);


ALTER TABLE public.directus_sessions OWNER TO directus;

--
-- Name: directus_settings; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_settings (
    id integer NOT NULL,
    project_name character varying(100) DEFAULT 'Directus'::character varying NOT NULL,
    project_url character varying(255),
    project_color character varying(50) DEFAULT NULL::character varying,
    project_logo uuid,
    public_foreground uuid,
    public_background uuid,
    public_note text,
    auth_login_attempts integer DEFAULT 25,
    auth_password_policy character varying(100),
    storage_asset_transform character varying(7) DEFAULT 'all'::character varying,
    storage_asset_presets json,
    custom_css text,
    storage_default_folder uuid,
    basemaps json,
    mapbox_key character varying(255),
    module_bar json,
    project_descriptor character varying(100),
    default_language character varying(255) DEFAULT 'en-US'::character varying NOT NULL,
    custom_aspect_ratios json
);


ALTER TABLE public.directus_settings OWNER TO directus;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_settings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_settings_id_seq OWNER TO directus;

--
-- Name: directus_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_settings_id_seq OWNED BY public.directus_settings.id;


--
-- Name: directus_shares; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_shares (
    id uuid NOT NULL,
    name character varying(255),
    collection character varying(64) NOT NULL,
    item character varying(255) NOT NULL,
    role uuid,
    password character varying(255),
    user_created uuid,
    date_created timestamp with time zone DEFAULT CURRENT_TIMESTAMP,
    date_start timestamp with time zone,
    date_end timestamp with time zone,
    times_used integer DEFAULT 0,
    max_uses integer
);


ALTER TABLE public.directus_shares OWNER TO directus;

--
-- Name: directus_translations; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_translations (
    id uuid NOT NULL,
    language character varying(255) NOT NULL,
    key character varying(255) NOT NULL,
    value text NOT NULL
);


ALTER TABLE public.directus_translations OWNER TO directus;

--
-- Name: directus_users; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_users (
    id uuid NOT NULL,
    first_name character varying(50),
    last_name character varying(50),
    email character varying(128),
    password character varying(255),
    location character varying(255),
    title character varying(50),
    description text,
    tags json,
    avatar uuid,
    language character varying(255) DEFAULT NULL::character varying,
    theme character varying(20) DEFAULT 'auto'::character varying,
    tfa_secret character varying(255),
    status character varying(16) DEFAULT 'active'::character varying NOT NULL,
    role uuid,
    token character varying(255),
    last_access timestamp with time zone,
    last_page character varying(255),
    provider character varying(128) DEFAULT 'default'::character varying NOT NULL,
    external_identifier character varying(255),
    auth_data json,
    email_notifications boolean DEFAULT true
);


ALTER TABLE public.directus_users OWNER TO directus;

--
-- Name: directus_webhooks; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.directus_webhooks (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    method character varying(10) DEFAULT 'POST'::character varying NOT NULL,
    url character varying(255) NOT NULL,
    status character varying(10) DEFAULT 'active'::character varying NOT NULL,
    data boolean DEFAULT true NOT NULL,
    actions character varying(100) NOT NULL,
    collections character varying(255) NOT NULL,
    headers json
);


ALTER TABLE public.directus_webhooks OWNER TO directus;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.directus_webhooks_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.directus_webhooks_id_seq OWNER TO directus;

--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.directus_webhooks_id_seq OWNED BY public.directus_webhooks.id;


--
-- Name: workspace; Type: TABLE; Schema: public; Owner: directus
--

CREATE TABLE public.workspace (
    id integer NOT NULL,
    date_created timestamp with time zone,
    date_updated timestamp with time zone,
    name character varying(255),
    price real,
    capacity integer,
    description text,
    available boolean DEFAULT false,
    thumbnail uuid,
    image uuid,
    location character varying(255)
);


ALTER TABLE public.workspace OWNER TO directus;

--
-- Name: workspace_id_seq; Type: SEQUENCE; Schema: public; Owner: directus
--

CREATE SEQUENCE public.workspace_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.workspace_id_seq OWNER TO directus;

--
-- Name: workspace_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: directus
--

ALTER SEQUENCE public.workspace_id_seq OWNED BY public.workspace.id;


--
-- Name: booking id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.booking ALTER COLUMN id SET DEFAULT nextval('public.booking_id_seq'::regclass);


--
-- Name: comment id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.comment ALTER COLUMN id SET DEFAULT nextval('public.comment_id_seq'::regclass);


--
-- Name: directus_activity id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_activity ALTER COLUMN id SET DEFAULT nextval('public.directus_activity_id_seq'::regclass);


--
-- Name: directus_fields id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_fields ALTER COLUMN id SET DEFAULT nextval('public.directus_fields_id_seq'::regclass);


--
-- Name: directus_notifications id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications ALTER COLUMN id SET DEFAULT nextval('public.directus_notifications_id_seq'::regclass);


--
-- Name: directus_permissions id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions ALTER COLUMN id SET DEFAULT nextval('public.directus_permissions_id_seq'::regclass);


--
-- Name: directus_presets id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets ALTER COLUMN id SET DEFAULT nextval('public.directus_presets_id_seq'::regclass);


--
-- Name: directus_relations id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_relations ALTER COLUMN id SET DEFAULT nextval('public.directus_relations_id_seq'::regclass);


--
-- Name: directus_revisions id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions ALTER COLUMN id SET DEFAULT nextval('public.directus_revisions_id_seq'::regclass);


--
-- Name: directus_settings id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings ALTER COLUMN id SET DEFAULT nextval('public.directus_settings_id_seq'::regclass);


--
-- Name: directus_webhooks id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_webhooks ALTER COLUMN id SET DEFAULT nextval('public.directus_webhooks_id_seq'::regclass);


--
-- Name: workspace id; Type: DEFAULT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.workspace ALTER COLUMN id SET DEFAULT nextval('public.workspace_id_seq'::regclass);


--
-- Data for Name: booking; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.booking (id, date_created, date_updated, start_date, end_date, workspace_id, user_id) FROM stdin;
1	\N	\N	2023-09-01 15:24:00	2023-09-02 12:00:00	1	65b14b0d-c95a-49f7-a39b-53cafc2bfdef
2	\N	\N	2023-09-15 10:00:00	2023-09-20 18:00:00	2	bc9a9573-7fbe-4cd4-b64a-3564f6bfc31c
3	\N	\N	2023-10-01 09:00:00	2023-10-05 17:00:00	3	65b14b0d-c95a-49f7-a39b-53cafc2bfdef
4	\N	\N	2023-10-10 14:00:00	2023-10-15 16:00:00	4	bc9a9573-7fbe-4cd4-b64a-3564f6bfc31c
5	\N	\N	2023-11-01 11:00:00	2023-11-10 19:00:00	5	65b14b0d-c95a-49f7-a39b-53cafc2bfdef
6	2023-10-16 12:53:35.938+00	\N	2023-10-16 12:53:35.906	2023-10-17 18:00:00	1	131bafd7-768a-4229-b5aa-6ea5688b5537
\.


--
-- Data for Name: comment; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.comment (id, date_created, date_updated, title, content, date_time, workspace_id, user_id) FROM stdin;
1	\N	\N	On en a gros!	Cet espace est tellement spacieux, on pourrait y organiser un tournoi de catapultes!	2023-08-29 10:00:00	1	65b14b0d-c95a-49f7-a39b-53cafc2bfdef
2	\N	\N	Le gras, c’est la vie	Les chaises sont tellement confortables, on dirait qu'elles sont rembourrées avec du gras de canard!	2023-08-29 11:00:00	2	bc9a9573-7fbe-4cd4-b64a-3564f6bfc31c
3	\N	\N	C’est pas faux	Je ne sais pas ce que ça veut dire, mais cet espace de coworking est vraiment top!	2023-08-29 12:00:00	3	65b14b0d-c95a-49f7-a39b-53cafc2bfdef
4	\N	\N	Je me suis déjà exprimé à ce sujet	Je l'ai déjà dit mille fois, cet endroit est incroyable!	2023-08-29 13:00:00	4	bc9a9573-7fbe-4cd4-b64a-3564f6bfc31c
5	\N	\N	Je dirais même plus	Cet endroit est tellement bien que je dirais même plus, c'est le meilleur espace de coworking du monde!	2023-08-29 14:00:00	5	65b14b0d-c95a-49f7-a39b-53cafc2bfdef
6	\N	\N	C’est de la merde	C'est de la merde... de licorne, cet endroit est magique!	2023-08-29 15:00:00	1	bc9a9573-7fbe-4cd4-b64a-3564f6bfc31c
7	\N	\N	Je suis pas content	Je ne suis pas content, je suis super content de cet espace de coworking!	2023-08-29 16:00:00	2	65b14b0d-c95a-49f7-a39b-53cafc2bfdef
8	\N	\N	C’est nul	C'est nul... lement bien, je ne veux plus jamais partir d'ici!	2023-08-29 17:00:00	3	bc9a9573-7fbe-4cd4-b64a-3564f6bfc31c
9	\N	\N	Je suis pas d'accord	Je ne suis pas d'accord avec moi-même, cet endroit est encore mieux que ce que je pensais!	2023-08-29 18:00:00	4	65b14b0d-c95a-49f7-a39b-53cafc2bfdef
10	\N	\N	C’est la salle du trône	C’est la salle du trône. Il ferait beau voir que je puisse pas y rentrer!	2023-08-29 19:00:00	5	bc9a9573-7fbe-4cd4-b64a-3564f6bfc31c
11	\N	\N	C’est meilleur chaud	C’est meilleur chaud, hein. Seulement là aux cuisines ils sont sur le repas du soir. Hein, ils ont pas trop le temps.	2023-08-29 20:00:00	1	65b14b0d-c95a-49f7-a39b-53cafc2bfdef
12	\N	\N	Pas foutu de savoir son nom!	Pas foutu de savoir son nom! Vous binez pas… Même nous on a pas tout compris. Allez en garde ma mignonne!	2023-08-29 21:00:00	2	bc9a9573-7fbe-4cd4-b64a-3564f6bfc31c
13	\N	2023-09-01 12:34:10.131+00	Ah ah Sire!	Ah non, non ! Y a pas de pécor pour la quête du Graal ! Enfin… À moins ça ait changé ?	2023-08-29 22:00:00	3	65b14b0d-c95a-49f7-a39b-53cafc2bfdef
14	\N	2023-09-01 12:35:21.611+00	Pourquoi vous m’agressez?	Mais on en entend parler dans les tavernes à ivrognes ! Voilà ! Mais ça va !	2023-08-29 23:00:00	4	bc9a9573-7fbe-4cd4-b64a-3564f6bfc31c
15	2023-10-16 13:57:46.037+00	\N	Test	sfsdfdgsdfsdfsdf	2023-10-16 13:57:45	1	\N
\.


--
-- Data for Name: directus_activity; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_activity (id, action, "user", "timestamp", ip, user_agent, collection, item, comment, origin) FROM stdin;
1	login	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 11:50:55.298+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_users	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	http://localhost:8055
2	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 11:51:41.495+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_fields	1	\N	http://localhost:8055
3	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 11:51:41.511+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_fields	2	\N	http://localhost:8055
4	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 11:51:41.528+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_fields	3	\N	http://localhost:8055
5	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 11:51:41.546+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_collections	workspace	\N	http://localhost:8055
6	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 11:51:50.67+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_fields	4	\N	http://localhost:8055
7	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 11:52:03.18+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_fields	5	\N	http://localhost:8055
8	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 11:52:19.414+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_fields	6	\N	http://localhost:8055
9	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 11:52:31.228+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_fields	7	\N	http://localhost:8055
10	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 11:52:52.071+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_fields	8	\N	http://localhost:8055
11	login	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 11:54:33.754+00	10.223.47.1	insomnia/2022.7.5	directus_users	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	\N
12	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 11:54:34.422+00	10.223.47.1	insomnia/2022.7.5	directus_users	65b14b0d-c95a-49f7-a39b-53cafc2bfdef	\N	\N
13	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 11:54:34.671+00	10.223.47.1	insomnia/2022.7.5	directus_users	bc9a9573-7fbe-4cd4-b64a-3564f6bfc31c	\N	\N
14	login	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 11:59:27.745+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_users	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	http://localhost:8055
15	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 12:03:13.914+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_fields	9	\N	http://localhost:8055
16	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 12:03:13.955+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_fields	10	\N	http://localhost:8055
17	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 12:03:13.971+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_fields	11	\N	http://localhost:8055
18	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 12:03:14.003+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_collections	comment	\N	http://localhost:8055
19	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 12:03:27.428+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_fields	12	\N	http://localhost:8055
20	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 12:03:39.944+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_fields	13	\N	http://localhost:8055
21	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 12:04:16.606+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_fields	14	\N	http://localhost:8055
22	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 12:04:46.671+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_fields	15	\N	http://localhost:8055
23	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 12:05:09.774+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_fields	16	\N	http://localhost:8055
54	login	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 12:21:46.391+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_users	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	http://localhost:8055
55	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 12:34:10.143+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	comment	13	\N	http://localhost:8055
56	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 12:35:21.616+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	comment	14	\N	http://localhost:8055
57	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 12:36:42.571+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_permissions	1	\N	http://localhost:8055
58	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 12:36:43.659+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_permissions	2	\N	http://localhost:8055
59	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 13:17:34.387+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_fields	47	\N	http://localhost:8055
60	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 13:17:34.401+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_fields	48	\N	http://localhost:8055
61	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 13:17:34.413+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_fields	49	\N	http://localhost:8055
62	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 13:17:34.426+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_collections	booking	\N	http://localhost:8055
63	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 13:17:59.772+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_fields	50	\N	http://localhost:8055
64	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 13:18:14.784+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_fields	51	\N	http://localhost:8055
65	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 13:18:19.875+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_fields	50	\N	http://localhost:8055
66	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 13:18:22.283+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_fields	51	\N	http://localhost:8055
67	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 13:18:47.893+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_fields	52	\N	http://localhost:8055
68	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 13:19:07.571+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_fields	53	\N	http://localhost:8055
69	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 13:27:01.035+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_permissions	3	\N	http://localhost:8055
70	login	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 13:27:32.409+00	10.223.47.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_users	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	http://localhost:8055
71	login	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 16:06:40.205+00	10.223.47.1	insomnia/2022.7.5	directus_users	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	\N
72	login	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-01 16:06:46.852+00	10.223.47.1	insomnia/2022.7.5	directus_users	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	\N
73	login	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-04 08:55:15.375+00	192.168.160.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_users	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	http://localhost:8055
74	login	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-04 08:55:35.479+00	10.223.47.1	insomnia/2022.7.5	directus_users	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	\N
75	login	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-08 13:01:52.807+00	172.23.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_users	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	http://localhost:8055
76	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-08 13:02:12.39+00	172.23.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_permissions	4	\N	http://localhost:8055
77	login	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-08 13:07:45.278+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_users	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	http://localhost:8055
78	delete	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-08 13:14:52.566+00	172.25.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_permissions	4	\N	http://localhost:8055
79	login	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-08 13:25:12.92+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_users	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	http://localhost:8055
80	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-08 13:25:31.823+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_permissions	5	\N	http://localhost:8055
81	create	\N	2023-09-08 13:25:44.778+00	172.27.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_users	9497ed3d-0124-451e-b7c2-5ea66fbab1e0	\N	http://localhost:3000
82	delete	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-08 13:31:48.136+00	172.28.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_permissions	5	\N	http://localhost:8055
83	delete	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-08 13:34:40.688+00	172.29.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_users	9497ed3d-0124-451e-b7c2-5ea66fbab1e0	\N	http://localhost:8055
84	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-08 13:34:49.769+00	172.29.0.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_permissions	6	\N	http://localhost:8055
85	login	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-10 15:34:24.973+00	192.168.32.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_users	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	http://localhost:8055
86	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-10 15:34:37.51+00	192.168.32.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_permissions	7	\N	http://localhost:8055
87	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-09-10 15:34:38.844+00	192.168.32.1	Mozilla/5.0 (X11; Linux x86_64; rv:109.0) Gecko/20100101 Firefox/116.0	directus_permissions	8	\N	http://localhost:8055
88	create	\N	2023-10-02 13:47:11.607+00	172.20.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_users	ec7a3b74-afce-474a-a82c-236aa51f0c89	\N	http://localhost:3000
89	login	ec7a3b74-afce-474a-a82c-236aa51f0c89	2023-10-02 13:47:24.684+00	172.20.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_users	ec7a3b74-afce-474a-a82c-236aa51f0c89	\N	http://localhost:3000
90	login	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-02 13:51:46.039+00	172.20.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_users	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	http://localhost:3000
91	login	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-02 13:52:34.086+00	172.20.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_users	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	http://localhost:8055
92	login	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-02 14:33:28.026+00	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_users	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	http://localhost:3000
93	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-02 14:35:48.41+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_files	326714ed-eb3f-4918-8aa9-3687bcd887e8	\N	http://localhost:8055
94	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-02 14:35:48.416+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_files	f8b1f98f-e138-4e68-a82e-cda0a9d946a8	\N	http://localhost:8055
95	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-02 14:35:48.493+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_files	3431d056-61a5-4dff-8be3-2edbec09f0c5	\N	http://localhost:8055
96	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-02 14:35:48.508+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_files	a61e46d8-4cb2-484f-a045-326ce7d18c77	\N	http://localhost:8055
97	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-02 14:42:01.114+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_fields	54	\N	http://localhost:8055
98	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-02 14:42:12.192+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_fields	1	\N	http://localhost:8055
99	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-02 14:42:12.414+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_fields	2	\N	http://localhost:8055
100	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-02 14:42:12.523+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_fields	3	\N	http://localhost:8055
101	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-02 14:42:12.673+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_fields	4	\N	http://localhost:8055
102	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-02 14:42:12.931+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_fields	5	\N	http://localhost:8055
103	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-02 14:42:13.243+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_fields	6	\N	http://localhost:8055
104	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-02 14:42:13.383+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_fields	7	\N	http://localhost:8055
105	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-02 14:42:13.548+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_fields	8	\N	http://localhost:8055
106	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-02 14:42:13.646+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_fields	54	\N	http://localhost:8055
107	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-02 14:42:57.224+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	workspace	1	\N	http://localhost:8055
108	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-02 14:43:10.79+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	workspace	2	\N	http://localhost:8055
110	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-02 14:43:33.542+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	workspace	4	\N	http://localhost:8055
111	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-02 14:43:47.022+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	workspace	5	\N	http://localhost:8055
109	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-02 14:43:21.182+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	workspace	3	\N	http://localhost:8055
112	login	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-03 08:15:35.511+00	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_users	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	http://localhost:3000
113	login	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-03 08:31:52.629+00	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_users	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	http://localhost:3000
114	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-03 08:38:15.771+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_permissions	9	\N	http://localhost:8055
115	login	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-03 09:20:29.009+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_users	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	http://localhost:8055
116	login	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-03 09:24:02.483+00	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_users	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	http://localhost:3000
117	login	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-03 09:50:41.836+00	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_users	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	http://localhost:3000
118	login	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-03 10:18:53.196+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_users	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	http://localhost:8055
119	delete	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-03 10:19:47.105+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_users	ec7a3b74-afce-474a-a82c-236aa51f0c89	\N	http://localhost:8055
120	login	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-03 12:19:50.324+00	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_users	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	http://localhost:3000
121	login	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-03 12:31:09.102+00	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_users	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	http://localhost:3000
122	login	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-03 12:32:57.318+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_users	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	http://localhost:8055
123	delete	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-03 12:35:04.822+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_files	a61e46d8-4cb2-484f-a045-326ce7d18c77	\N	http://localhost:8055
124	delete	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-03 12:35:04.846+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_files	3431d056-61a5-4dff-8be3-2edbec09f0c5	\N	http://localhost:8055
125	delete	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-03 12:35:04.875+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_files	f8b1f98f-e138-4e68-a82e-cda0a9d946a8	\N	http://localhost:8055
126	delete	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-03 12:35:04.895+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_files	326714ed-eb3f-4918-8aa9-3687bcd887e8	\N	http://localhost:8055
127	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-03 12:44:11.802+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_fields	55	\N	http://localhost:8055
128	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-03 12:47:50.695+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_files	732a65f0-0bb2-40ef-9d55-27df1ff12845	\N	http://localhost:8055
129	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-03 12:48:01.184+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	directus_files	94d15bee-51df-41c3-8b30-db827f8d4556	\N	http://localhost:8055
130	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-03 12:48:03.737+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	workspace	1	\N	http://localhost:8055
131	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-03 12:49:05.725+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	workspace	2	\N	http://localhost:8055
132	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-03 12:49:34.19+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	workspace	3	\N	http://localhost:8055
133	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-03 12:50:13.868+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	workspace	4	\N	http://localhost:8055
134	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-03 12:50:31.17+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/117.0.0.0 Safari/537.36	workspace	5	\N	http://localhost:8055
135	login	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-16 07:31:23.366+00	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36	directus_users	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	http://localhost:3000
136	login	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-16 07:41:32.964+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36	directus_users	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	http://localhost:8055
137	login	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-16 12:53:26.566+00	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36	directus_users	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	http://localhost:3000
138	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-16 12:53:35.964+00	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36	booking	6	\N	http://localhost:3000
139	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-16 12:53:36.042+00	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36	workspace	1	\N	http://localhost:3000
140	login	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-16 12:53:59.207+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36	directus_users	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	http://localhost:8055
141	create	\N	2023-10-16 13:57:46.096+00	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36	comment	15	\N	http://localhost:3000
142	login	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-16 14:08:25.307+00	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36	directus_users	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	http://localhost:3000
143	login	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-16 14:37:05.437+00	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36	directus_users	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	http://localhost:3000
144	login	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-17 09:22:51.328+00	172.18.0.5	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36	directus_users	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	http://localhost:3000
145	login	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-17 14:10:33.83+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36	directus_users	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	http://localhost:8055
146	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-17 14:20:43.79+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36	directus_fields	56	\N	http://localhost:8055
147	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-17 14:21:15.515+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36	workspace	1	\N	http://localhost:8055
148	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-17 14:22:00.102+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36	workspace	1	\N	http://localhost:8055
149	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-17 14:22:52.509+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36	workspace	2	\N	http://localhost:8055
150	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-17 14:24:04.687+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36	workspace	3	\N	http://localhost:8055
151	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-17 14:24:47.788+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36	workspace	4	\N	http://localhost:8055
152	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-17 14:25:17.985+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36	workspace	5	\N	http://localhost:8055
153	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-18 11:43:56.532+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36	directus_fields	57	\N	http://localhost:8055
154	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-18 11:44:53.659+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36	workspace	1	\N	http://localhost:8055
155	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-18 11:46:27.569+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36	directus_fields	58	\N	http://localhost:8055
156	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-18 11:52:53.423+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36	workspace	1	\N	http://localhost:8055
157	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-18 12:03:45.115+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36	workspace	2	\N	http://localhost:8055
158	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-18 12:05:06.244+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36	workspace	3	\N	http://localhost:8055
159	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-18 12:06:03.491+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36	workspace	4	\N	http://localhost:8055
160	update	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-18 12:07:03.344+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36	workspace	5	\N	http://localhost:8055
161	login	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-24 15:19:07.265+00	192.168.16.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36	directus_users	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	http://localhost:8055
162	create	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-24 15:19:18.857+00	192.168.16.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36	directus_permissions	10	\N	http://localhost:8055
\.


--
-- Data for Name: directus_collections; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_collections (collection, icon, note, display_template, hidden, singleton, translations, archive_field, archive_app_filter, archive_value, unarchive_value, sort_field, accountability, color, item_duplication_fields, sort, "group", collapse, preview_url) FROM stdin;
workspace	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N
comment	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N
booking	\N	\N	\N	f	f	\N	\N	t	\N	\N	\N	all	\N	\N	\N	\N	open	\N
\.


--
-- Data for Name: directus_dashboards; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_dashboards (id, name, icon, note, date_created, user_created, color) FROM stdin;
\.


--
-- Data for Name: directus_fields; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_fields (id, collection, field, special, interface, options, display, display_options, readonly, hidden, sort, width, translations, note, conditions, required, "group", validation, validation_message) FROM stdin;
9	comment	id	\N	input	\N	\N	\N	t	t	\N	full	\N	\N	\N	f	\N	\N	\N
10	comment	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	\N	half	\N	\N	\N	f	\N	\N	\N
11	comment	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	\N	half	\N	\N	\N	f	\N	\N	\N
12	comment	title	\N	input	\N	\N	\N	f	f	\N	full	\N	\N	\N	t	\N	\N	\N
13	comment	content	\N	input-multiline	\N	\N	\N	f	f	\N	full	\N	\N	\N	t	\N	\N	\N
14	comment	date_time	\N	datetime	\N	\N	\N	f	f	\N	full	\N	\N	\N	t	\N	\N	\N
15	comment	workspace_id	m2o	select-dropdown-m2o	\N	\N	\N	f	f	\N	full	\N	\N	\N	t	\N	\N	\N
16	comment	user_id	m2o	select-dropdown-m2o	\N	\N	\N	f	f	\N	full	\N	\N	\N	t	\N	\N	\N
47	booking	id	\N	input	\N	\N	\N	t	t	\N	full	\N	\N	\N	f	\N	\N	\N
48	booking	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	\N	half	\N	\N	\N	f	\N	\N	\N
49	booking	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	\N	half	\N	\N	\N	f	\N	\N	\N
50	booking	start_date	\N	datetime	\N	\N	\N	f	f	\N	half	\N	\N	\N	t	\N	\N	\N
51	booking	end_date	\N	datetime	\N	\N	\N	f	f	\N	half	\N	\N	\N	t	\N	\N	\N
52	booking	workspace_id	m2o	select-dropdown-m2o	\N	\N	\N	f	f	\N	full	\N	\N	\N	t	\N	\N	\N
53	booking	user_id	m2o	select-dropdown-m2o	\N	\N	\N	f	f	\N	full	\N	\N	\N	t	\N	\N	\N
1	workspace	id	\N	input	\N	\N	\N	t	t	1	full	\N	\N	\N	f	\N	\N	\N
2	workspace	date_created	date-created	datetime	\N	datetime	{"relative":true}	t	t	2	half	\N	\N	\N	f	\N	\N	\N
3	workspace	date_updated	date-updated	datetime	\N	datetime	{"relative":true}	t	t	3	half	\N	\N	\N	f	\N	\N	\N
4	workspace	name	\N	input	\N	\N	\N	f	f	4	full	\N	\N	\N	t	\N	\N	\N
5	workspace	price	\N	input	\N	\N	\N	f	f	5	full	\N	\N	\N	t	\N	\N	\N
6	workspace	capacity	\N	input	\N	\N	\N	f	f	6	full	\N	\N	\N	t	\N	\N	\N
7	workspace	description	\N	input-multiline	\N	\N	\N	f	f	7	full	\N	\N	\N	t	\N	\N	\N
8	workspace	available	cast-boolean	boolean	\N	\N	\N	f	f	8	full	\N	\N	\N	t	\N	\N	\N
54	workspace	thumbnail	file	file-image	\N	\N	\N	f	f	9	full	\N	\N	\N	f	\N	\N	\N
55	workspace	image	file	file-image	\N	\N	\N	f	f	10	full	\N	\N	\N	f	\N	\N	\N
58	workspace	location	\N	\N	\N	\N	\N	f	f	12	full	\N	\N	\N	f	\N	\N	\N
\.


--
-- Data for Name: directus_files; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_files (id, storage, filename_disk, filename_download, title, type, folder, uploaded_by, uploaded_on, modified_by, modified_on, charset, filesize, width, height, duration, embed, description, location, tags, metadata) FROM stdin;
732a65f0-0bb2-40ef-9d55-27df1ff12845	local	732a65f0-0bb2-40ef-9d55-27df1ff12845.jpg	space-02-small.jpg	Space 02 Small	image/jpeg	\N	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-03 12:47:50.659166+00	\N	2023-10-03 12:47:50.888+00	\N	99428	640	427	\N	\N	\N	\N	\N	{}
94d15bee-51df-41c3-8b30-db827f8d4556	local	94d15bee-51df-41c3-8b30-db827f8d4556.jpg	space-01-large.jpg	Space 01 Large	image/jpeg	\N	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-03 12:48:01.14862+00	\N	2023-10-03 12:48:01.384+00	\N	429190	1920	1280	\N	\N	\N	\N	\N	{}
\.


--
-- Data for Name: directus_flows; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_flows (id, name, icon, color, description, status, trigger, accountability, options, operation, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_folders; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_folders (id, name, parent) FROM stdin;
\.


--
-- Data for Name: directus_migrations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_migrations (version, name, "timestamp") FROM stdin;
20201028A	Remove Collection Foreign Keys	2023-09-01 09:25:51.469161+00
20201029A	Remove System Relations	2023-09-01 09:25:51.473893+00
20201029B	Remove System Collections	2023-09-01 09:25:51.478013+00
20201029C	Remove System Fields	2023-09-01 09:25:51.494157+00
20201105A	Add Cascade System Relations	2023-09-01 09:25:51.537664+00
20201105B	Change Webhook URL Type	2023-09-01 09:25:51.544865+00
20210225A	Add Relations Sort Field	2023-09-01 09:25:51.549984+00
20210304A	Remove Locked Fields	2023-09-01 09:25:51.55354+00
20210312A	Webhooks Collections Text	2023-09-01 09:25:51.559627+00
20210331A	Add Refresh Interval	2023-09-01 09:25:51.562625+00
20210415A	Make Filesize Nullable	2023-09-01 09:25:51.569779+00
20210416A	Add Collections Accountability	2023-09-01 09:25:51.574275+00
20210422A	Remove Files Interface	2023-09-01 09:25:51.576932+00
20210506A	Rename Interfaces	2023-09-01 09:25:51.601637+00
20210510A	Restructure Relations	2023-09-01 09:25:51.623244+00
20210518A	Add Foreign Key Constraints	2023-09-01 09:25:51.629548+00
20210519A	Add System Fk Triggers	2023-09-01 09:25:51.653237+00
20210521A	Add Collections Icon Color	2023-09-01 09:25:51.656297+00
20210525A	Add Insights	2023-09-01 09:25:51.676088+00
20210608A	Add Deep Clone Config	2023-09-01 09:25:51.679358+00
20210626A	Change Filesize Bigint	2023-09-01 09:25:51.69244+00
20210716A	Add Conditions to Fields	2023-09-01 09:25:51.695697+00
20210721A	Add Default Folder	2023-09-01 09:25:51.701662+00
20210802A	Replace Groups	2023-09-01 09:25:51.706125+00
20210803A	Add Required to Fields	2023-09-01 09:25:51.709503+00
20210805A	Update Groups	2023-09-01 09:25:51.713194+00
20210805B	Change Image Metadata Structure	2023-09-01 09:25:51.717592+00
20210811A	Add Geometry Config	2023-09-01 09:25:51.720943+00
20210831A	Remove Limit Column	2023-09-01 09:25:51.723813+00
20210903A	Add Auth Provider	2023-09-01 09:25:51.740319+00
20210907A	Webhooks Collections Not Null	2023-09-01 09:25:51.747517+00
20210910A	Move Module Setup	2023-09-01 09:25:51.751644+00
20210920A	Webhooks URL Not Null	2023-09-01 09:25:51.758551+00
20210924A	Add Collection Organization	2023-09-01 09:25:51.763474+00
20210927A	Replace Fields Group	2023-09-01 09:25:51.77137+00
20210927B	Replace M2M Interface	2023-09-01 09:25:51.774024+00
20210929A	Rename Login Action	2023-09-01 09:25:51.776464+00
20211007A	Update Presets	2023-09-01 09:25:51.782545+00
20211009A	Add Auth Data	2023-09-01 09:25:51.785362+00
20211016A	Add Webhook Headers	2023-09-01 09:25:51.788131+00
20211103A	Set Unique to User Token	2023-09-01 09:25:51.793879+00
20211103B	Update Special Geometry	2023-09-01 09:25:51.796444+00
20211104A	Remove Collections Listing	2023-09-01 09:25:51.79907+00
20211118A	Add Notifications	2023-09-01 09:25:51.81109+00
20211211A	Add Shares	2023-09-01 09:25:51.827111+00
20211230A	Add Project Descriptor	2023-09-01 09:25:51.83186+00
20220303A	Remove Default Project Color	2023-09-01 09:25:51.838608+00
20220308A	Add Bookmark Icon and Color	2023-09-01 09:25:51.841622+00
20220314A	Add Translation Strings	2023-09-01 09:25:51.844849+00
20220322A	Rename Field Typecast Flags	2023-09-01 09:25:51.849859+00
20220323A	Add Field Validation	2023-09-01 09:25:51.857147+00
20220325A	Fix Typecast Flags	2023-09-01 09:25:51.867761+00
20220325B	Add Default Language	2023-09-01 09:25:51.891079+00
20220402A	Remove Default Value Panel Icon	2023-09-01 09:25:51.912628+00
20220429A	Add Flows	2023-09-01 09:25:51.958034+00
20220429B	Add Color to Insights Icon	2023-09-01 09:25:51.961488+00
20220429C	Drop Non Null From IP of Activity	2023-09-01 09:25:51.967219+00
20220429D	Drop Non Null From Sender of Notifications	2023-09-01 09:25:51.970467+00
20220614A	Rename Hook Trigger to Event	2023-09-01 09:25:51.972962+00
20220801A	Update Notifications Timestamp Column	2023-09-01 09:25:51.981695+00
20220802A	Add Custom Aspect Ratios	2023-09-01 09:25:51.985532+00
20220826A	Add Origin to Accountability	2023-09-01 09:25:51.992204+00
20230401A	Update Material Icons	2023-09-01 09:25:52.00495+00
20230525A	Add Preview Settings	2023-09-01 09:25:52.009144+00
20230526A	Migrate Translation Strings	2023-09-01 09:25:52.026957+00
20230721A	Require Shares Fields	2023-10-02 12:26:27.90275+00
\.


--
-- Data for Name: directus_notifications; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_notifications (id, "timestamp", status, recipient, sender, subject, message, collection, item) FROM stdin;
\.


--
-- Data for Name: directus_operations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_operations (id, name, key, type, position_x, position_y, options, resolve, reject, flow, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_panels; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_panels (id, dashboard, name, icon, color, show_header, note, type, position_x, position_y, width, height, options, date_created, user_created) FROM stdin;
\.


--
-- Data for Name: directus_permissions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_permissions (id, role, collection, action, permissions, validation, presets, fields) FROM stdin;
1	\N	comment	read	{}	{}	\N	*
2	\N	workspace	read	{}	{}	\N	*
3	\N	booking	read	{}	{}	\N	*
6	\N	directus_users	create	{}	{}	\N	*
7	\N	booking	create	{}	{}	\N	*
8	\N	comment	create	{}	{}	\N	*
9	\N	directus_files	read	{}	{}	\N	*
10	\N	directus_files	share	{}	{}	\N	*
\.


--
-- Data for Name: directus_presets; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_presets (id, bookmark, "user", role, collection, search, layout, layout_query, layout_options, refresh_interval, filter, icon, color) FROM stdin;
4	\N	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	booking	\N	\N	{"tabular":{"limit":25,"fields":["end_date","start_date","user_id","workspace_id"]}}	{"tabular":{"widths":{"start_date":298.449462890625}}}	\N	\N	bookmark	\N
3	\N	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	comment	\N	tabular	{"tabular":{"limit":25,"fields":["title","content","date_time","workspace_id"]},"cards":{"limit":25}}	{"tabular":{"widths":{"title":323}}}	\N	\N	bookmark	\N
5	\N	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	directus_files	\N	cards	{"cards":{"sort":["-uploaded_on"],"limit":25,"page":1}}	{"cards":{"icon":"insert_drive_file","title":"{{ title }}","subtitle":"{{ type }} • {{ filesize }}","size":4,"imageFit":"crop"}}	\N	\N	bookmark	\N
2	\N	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	directus_users	\N	cards	{"cards":{"sort":["email"],"limit":25}}	{"cards":{"icon":"account_circle","title":"{{ first_name }} {{ last_name }}","subtitle":"{{ email }}","size":4}}	\N	\N	bookmark	\N
1	\N	131bafd7-768a-4229-b5aa-6ea5688b5537	\N	workspace	\N	\N	{"tabular":{"limit":25,"fields":["id","capacity","description","name","coordinates","location"]}}	{"tabular":{"widths":{"coordinates":326.8642578125,"location":506.3243408203125}}}	\N	\N	bookmark	\N
\.


--
-- Data for Name: directus_relations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_relations (id, many_collection, many_field, one_collection, one_field, one_collection_field, one_allowed_collections, junction_field, sort_field, one_deselect_action) FROM stdin;
1	comment	workspace_id	workspace	\N	\N	\N	\N	\N	nullify
2	comment	user_id	directus_users	\N	\N	\N	\N	\N	nullify
34	booking	workspace_id	workspace	\N	\N	\N	\N	\N	nullify
35	booking	user_id	directus_users	\N	\N	\N	\N	\N	nullify
36	workspace	thumbnail	directus_files	\N	\N	\N	\N	\N	nullify
37	workspace	image	directus_files	\N	\N	\N	\N	\N	nullify
\.


--
-- Data for Name: directus_revisions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_revisions (id, activity, collection, item, data, delta, parent) FROM stdin;
1	2	directus_fields	1	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"workspace"}	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"workspace"}	\N
2	3	directus_fields	2	{"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"workspace"}	{"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"workspace"}	\N
3	4	directus_fields	3	{"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"workspace"}	{"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"workspace"}	\N
4	5	directus_collections	workspace	{"singleton":false,"collection":"workspace"}	{"singleton":false,"collection":"workspace"}	\N
5	6	directus_fields	4	{"interface":"input","special":null,"required":true,"collection":"workspace","field":"name"}	{"interface":"input","special":null,"required":true,"collection":"workspace","field":"name"}	\N
6	7	directus_fields	5	{"interface":"input","special":null,"required":true,"collection":"workspace","field":"price"}	{"interface":"input","special":null,"required":true,"collection":"workspace","field":"price"}	\N
7	8	directus_fields	6	{"interface":"input","special":null,"required":true,"collection":"workspace","field":"capacity"}	{"interface":"input","special":null,"required":true,"collection":"workspace","field":"capacity"}	\N
8	9	directus_fields	7	{"interface":"input-multiline","special":null,"required":true,"collection":"workspace","field":"description"}	{"interface":"input-multiline","special":null,"required":true,"collection":"workspace","field":"description"}	\N
9	10	directus_fields	8	{"interface":"boolean","special":["cast-boolean"],"required":true,"collection":"workspace","field":"available"}	{"interface":"boolean","special":["cast-boolean"],"required":true,"collection":"workspace","field":"available"}	\N
10	12	directus_users	65b14b0d-c95a-49f7-a39b-53cafc2bfdef	{"first_name":"Perceval","email":"perceval@example.com","password":"**********","role":"91786d99-b853-448d-81cf-1efc1a05986c"}	{"first_name":"Perceval","email":"perceval@example.com","password":"**********","role":"91786d99-b853-448d-81cf-1efc1a05986c"}	\N
11	13	directus_users	bc9a9573-7fbe-4cd4-b64a-3564f6bfc31c	{"first_name":"Karadoc","email":"karadoc@example.com","password":"**********","role":"91786d99-b853-448d-81cf-1efc1a05986c"}	{"first_name":"Karadoc","email":"karadoc@example.com","password":"**********","role":"91786d99-b853-448d-81cf-1efc1a05986c"}	\N
12	15	directus_fields	9	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"comment"}	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"comment"}	\N
13	16	directus_fields	10	{"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"comment"}	{"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"comment"}	\N
14	17	directus_fields	11	{"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"comment"}	{"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"comment"}	\N
15	18	directus_collections	comment	{"singleton":false,"collection":"comment"}	{"singleton":false,"collection":"comment"}	\N
16	19	directus_fields	12	{"interface":"input","special":null,"required":true,"collection":"comment","field":"title"}	{"interface":"input","special":null,"required":true,"collection":"comment","field":"title"}	\N
17	20	directus_fields	13	{"interface":"input-multiline","special":null,"required":true,"collection":"comment","field":"content"}	{"interface":"input-multiline","special":null,"required":true,"collection":"comment","field":"content"}	\N
18	21	directus_fields	14	{"interface":"datetime","special":null,"required":true,"collection":"comment","field":"date_time"}	{"interface":"datetime","special":null,"required":true,"collection":"comment","field":"date_time"}	\N
19	22	directus_fields	15	{"interface":"select-dropdown-m2o","special":["m2o"],"required":true,"collection":"comment","field":"workspace_id"}	{"interface":"select-dropdown-m2o","special":["m2o"],"required":true,"collection":"comment","field":"workspace_id"}	\N
20	23	directus_fields	16	{"interface":"select-dropdown-m2o","special":["m2o"],"required":true,"collection":"comment","field":"user_id"}	{"interface":"select-dropdown-m2o","special":["m2o"],"required":true,"collection":"comment","field":"user_id"}	\N
51	55	comment	13	{"id":13,"date_created":null,"date_updated":"2023-09-01T12:34:10.131Z","title":"Ah ah Sire!","content":"Ah non, non ! Y a pas de pécor pour la quête du Graal ! Enfin… À moins ça ait changé ?","date_time":"2023-08-29T22:00:00","workspace_id":3,"user_id":"65b14b0d-c95a-49f7-a39b-53cafc2bfdef"}	{"content":"Ah non, non ! Y a pas de pécor pour la quête du Graal ! Enfin… À moins ça ait changé ?","date_updated":"2023-09-01T12:34:10.131Z"}	\N
52	56	comment	14	{"id":14,"date_created":null,"date_updated":"2023-09-01T12:35:21.611Z","title":"Pourquoi vous m’agressez?","content":"Mais on en entend parler dans les tavernes à ivrognes ! Voilà ! Mais ça va !","date_time":"2023-08-29T23:00:00","workspace_id":4,"user_id":"bc9a9573-7fbe-4cd4-b64a-3564f6bfc31c"}	{"content":"Mais on en entend parler dans les tavernes à ivrognes ! Voilà ! Mais ça va !","date_updated":"2023-09-01T12:35:21.611Z"}	\N
53	57	directus_permissions	1	{"role":null,"collection":"comment","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"comment","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
54	58	directus_permissions	2	{"role":null,"collection":"workspace","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"workspace","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
55	59	directus_fields	47	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"booking"}	{"hidden":true,"interface":"input","readonly":true,"field":"id","collection":"booking"}	\N
56	60	directus_fields	48	{"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"booking"}	{"special":["date-created"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_created","collection":"booking"}	\N
57	61	directus_fields	49	{"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"booking"}	{"special":["date-updated"],"interface":"datetime","readonly":true,"hidden":true,"width":"half","display":"datetime","display_options":{"relative":true},"field":"date_updated","collection":"booking"}	\N
58	62	directus_collections	booking	{"singleton":false,"collection":"booking"}	{"singleton":false,"collection":"booking"}	\N
59	63	directus_fields	50	{"interface":"datetime","special":null,"required":true,"collection":"booking","field":"start_date"}	{"interface":"datetime","special":null,"required":true,"collection":"booking","field":"start_date"}	\N
60	64	directus_fields	51	{"interface":"datetime","special":null,"required":true,"collection":"booking","field":"end_date"}	{"interface":"datetime","special":null,"required":true,"collection":"booking","field":"end_date"}	\N
61	65	directus_fields	50	{"id":50,"collection":"booking","field":"start_date","special":null,"interface":"datetime","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"half","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"booking","field":"start_date","width":"half"}	\N
62	66	directus_fields	51	{"id":51,"collection":"booking","field":"end_date","special":null,"interface":"datetime","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":null,"width":"half","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"booking","field":"end_date","width":"half"}	\N
63	67	directus_fields	52	{"interface":"select-dropdown-m2o","special":["m2o"],"required":true,"collection":"booking","field":"workspace_id"}	{"interface":"select-dropdown-m2o","special":["m2o"],"required":true,"collection":"booking","field":"workspace_id"}	\N
64	68	directus_fields	53	{"interface":"select-dropdown-m2o","special":["m2o"],"required":true,"collection":"booking","field":"user_id"}	{"interface":"select-dropdown-m2o","special":["m2o"],"required":true,"collection":"booking","field":"user_id"}	\N
65	69	directus_permissions	3	{"role":null,"collection":"booking","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"booking","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
66	76	directus_permissions	4	{"role":null,"collection":"directus_users","action":"create","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"directus_users","action":"create","fields":["*"],"permissions":{},"validation":{}}	\N
67	80	directus_permissions	5	{"role":null,"collection":"directus_users","action":"create","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"directus_users","action":"create","fields":["*"],"permissions":{},"validation":{}}	\N
68	81	directus_users	9497ed3d-0124-451e-b7c2-5ea66fbab1e0	{"last_name":"Sei","first_name":"Chris","email":"chris2@chris.me","password":"**********","role":"91786d99-b853-448d-81cf-1efc1a05986c"}	{"last_name":"Sei","first_name":"Chris","email":"chris2@chris.me","password":"**********","role":"91786d99-b853-448d-81cf-1efc1a05986c"}	\N
69	84	directus_permissions	6	{"role":null,"collection":"directus_users","action":"create","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"directus_users","action":"create","fields":["*"],"permissions":{},"validation":{}}	\N
70	86	directus_permissions	7	{"role":null,"collection":"booking","action":"create","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"booking","action":"create","fields":["*"],"permissions":{},"validation":{}}	\N
71	87	directus_permissions	8	{"role":null,"collection":"comment","action":"create","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"comment","action":"create","fields":["*"],"permissions":{},"validation":{}}	\N
72	88	directus_users	ec7a3b74-afce-474a-a82c-236aa51f0c89	{"last_name":"Cluzel","first_name":"Kevin","email":"kevin@conciergerie.dev","password":"**********","role":"91786d99-b853-448d-81cf-1efc1a05986c"}	{"last_name":"Cluzel","first_name":"Kevin","email":"kevin@conciergerie.dev","password":"**********","role":"91786d99-b853-448d-81cf-1efc1a05986c"}	\N
73	93	directus_files	326714ed-eb3f-4918-8aa9-3687bcd887e8	{"title":"Space 01 Large","filename_download":"space-01-large.jpg","type":"image/jpeg","storage":"local"}	{"title":"Space 01 Large","filename_download":"space-01-large.jpg","type":"image/jpeg","storage":"local"}	\N
74	94	directus_files	f8b1f98f-e138-4e68-a82e-cda0a9d946a8	{"title":"Space 02 Small","filename_download":"space-02-small.jpg","type":"image/jpeg","storage":"local"}	{"title":"Space 02 Small","filename_download":"space-02-small.jpg","type":"image/jpeg","storage":"local"}	\N
75	95	directus_files	3431d056-61a5-4dff-8be3-2edbec09f0c5	{"title":"Space 02 Large","filename_download":"space-02-large.jpg","type":"image/jpeg","storage":"local"}	{"title":"Space 02 Large","filename_download":"space-02-large.jpg","type":"image/jpeg","storage":"local"}	\N
76	96	directus_files	a61e46d8-4cb2-484f-a045-326ce7d18c77	{"title":"Space 01 Small","filename_download":"space-01-small.jpg","type":"image/jpeg","storage":"local"}	{"title":"Space 01 Small","filename_download":"space-01-small.jpg","type":"image/jpeg","storage":"local"}	\N
77	97	directus_fields	54	{"sort":1,"interface":"file-image","special":["file"],"collection":"workspace","field":"thumbnail"}	{"sort":1,"interface":"file-image","special":["file"],"collection":"workspace","field":"thumbnail"}	\N
78	98	directus_fields	1	{"id":1,"collection":"workspace","field":"id","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":true,"hidden":true,"sort":1,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"workspace","field":"id","sort":1,"group":null}	\N
79	99	directus_fields	2	{"id":2,"collection":"workspace","field":"date_created","special":["date-created"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":2,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"workspace","field":"date_created","sort":2,"group":null}	\N
80	100	directus_fields	3	{"id":3,"collection":"workspace","field":"date_updated","special":["date-updated"],"interface":"datetime","options":null,"display":"datetime","display_options":{"relative":true},"readonly":true,"hidden":true,"sort":3,"width":"half","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"workspace","field":"date_updated","sort":3,"group":null}	\N
81	101	directus_fields	4	{"id":4,"collection":"workspace","field":"name","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":4,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"workspace","field":"name","sort":4,"group":null}	\N
82	102	directus_fields	5	{"id":5,"collection":"workspace","field":"price","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":5,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"workspace","field":"price","sort":5,"group":null}	\N
83	103	directus_fields	6	{"id":6,"collection":"workspace","field":"capacity","special":null,"interface":"input","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":6,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"workspace","field":"capacity","sort":6,"group":null}	\N
84	104	directus_fields	7	{"id":7,"collection":"workspace","field":"description","special":null,"interface":"input-multiline","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":7,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"workspace","field":"description","sort":7,"group":null}	\N
85	105	directus_fields	8	{"id":8,"collection":"workspace","field":"available","special":["cast-boolean"],"interface":"boolean","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":8,"width":"full","translations":null,"note":null,"conditions":null,"required":true,"group":null,"validation":null,"validation_message":null}	{"collection":"workspace","field":"available","sort":8,"group":null}	\N
86	106	directus_fields	54	{"id":54,"collection":"workspace","field":"thumbnail","special":["file"],"interface":"file-image","options":null,"display":null,"display_options":null,"readonly":false,"hidden":false,"sort":9,"width":"full","translations":null,"note":null,"conditions":null,"required":false,"group":null,"validation":null,"validation_message":null}	{"collection":"workspace","field":"thumbnail","sort":9,"group":null}	\N
87	107	workspace	1	{"id":1,"date_created":null,"date_updated":"2023-10-02T14:42:57.209Z","name":"Espace Zen","price":20.5,"capacity":10,"description":"Un espace calme et paisible avec des plantes et une décoration zen.","available":true,"thumbnail":"a61e46d8-4cb2-484f-a045-326ce7d18c77"}	{"thumbnail":"a61e46d8-4cb2-484f-a045-326ce7d18c77","date_updated":"2023-10-02T14:42:57.209Z"}	\N
88	108	workspace	2	{"id":2,"date_created":null,"date_updated":"2023-10-02T14:43:10.768Z","name":"Bureau Dynamique","price":15,"capacity":20,"description":"Un espace dynamique et énergisant, idéal pour les équipes et les start-ups.","available":true,"thumbnail":"f8b1f98f-e138-4e68-a82e-cda0a9d946a8"}	{"thumbnail":"f8b1f98f-e138-4e68-a82e-cda0a9d946a8","date_updated":"2023-10-02T14:43:10.768Z"}	\N
90	110	workspace	4	{"id":4,"date_created":null,"date_updated":"2023-10-02T14:43:33.529Z","name":"Salle de Conférence","price":30,"capacity":50,"description":"Une grande salle de conférence équipée de tout le matériel nécessaire pour vos réunions.","available":true,"thumbnail":"f8b1f98f-e138-4e68-a82e-cda0a9d946a8"}	{"thumbnail":"f8b1f98f-e138-4e68-a82e-cda0a9d946a8","date_updated":"2023-10-02T14:43:33.529Z"}	\N
91	111	workspace	5	{"id":5,"date_created":null,"date_updated":"2023-10-02T14:43:47.001Z","name":"Studio Silencieux","price":18,"capacity":5,"description":"Un studio silencieux, idéal pour la concentration et le travail individuel.","available":true,"thumbnail":"a61e46d8-4cb2-484f-a045-326ce7d18c77"}	{"thumbnail":"a61e46d8-4cb2-484f-a045-326ce7d18c77","date_updated":"2023-10-02T14:43:47.001Z"}	\N
89	109	workspace	3	{"id":3,"date_created":null,"date_updated":"2023-10-02T14:43:21.170Z","name":"Loft Créatif","price":25,"capacity":15,"description":"Un loft spacieux et lumineux, parfait pour les créatifs et les artistes.","available":false,"thumbnail":"a61e46d8-4cb2-484f-a045-326ce7d18c77"}	{"thumbnail":"a61e46d8-4cb2-484f-a045-326ce7d18c77","date_updated":"2023-10-02T14:43:21.170Z"}	\N
92	114	directus_permissions	9	{"role":null,"collection":"directus_files","action":"read","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"directus_files","action":"read","fields":["*"],"permissions":{},"validation":{}}	\N
93	127	directus_fields	55	{"sort":10,"interface":"file-image","special":["file"],"collection":"workspace","field":"image"}	{"sort":10,"interface":"file-image","special":["file"],"collection":"workspace","field":"image"}	\N
94	128	directus_files	732a65f0-0bb2-40ef-9d55-27df1ff12845	{"title":"Space 02 Small","filename_download":"space-02-small.jpg","type":"image/jpeg","storage":"local"}	{"title":"Space 02 Small","filename_download":"space-02-small.jpg","type":"image/jpeg","storage":"local"}	\N
95	129	directus_files	94d15bee-51df-41c3-8b30-db827f8d4556	{"title":"Space 01 Large","filename_download":"space-01-large.jpg","type":"image/jpeg","storage":"local"}	{"title":"Space 01 Large","filename_download":"space-01-large.jpg","type":"image/jpeg","storage":"local"}	\N
96	130	workspace	1	{"id":1,"date_created":null,"date_updated":"2023-10-03T12:48:03.710Z","name":"Espace Zen","price":20.5,"capacity":10,"description":"Un espace calme et paisible avec des plantes et une décoration zen.","available":true,"thumbnail":"732a65f0-0bb2-40ef-9d55-27df1ff12845","image":"94d15bee-51df-41c3-8b30-db827f8d4556"}	{"thumbnail":"732a65f0-0bb2-40ef-9d55-27df1ff12845","image":"94d15bee-51df-41c3-8b30-db827f8d4556","date_updated":"2023-10-03T12:48:03.710Z"}	\N
97	131	workspace	2	{"id":2,"date_created":null,"date_updated":"2023-10-03T12:49:05.705Z","name":"Bureau Dynamique","price":15,"capacity":20,"description":"Un espace dynamique et énergisant, idéal pour les équipes et les start-ups.","available":true,"thumbnail":"732a65f0-0bb2-40ef-9d55-27df1ff12845","image":"94d15bee-51df-41c3-8b30-db827f8d4556"}	{"thumbnail":"732a65f0-0bb2-40ef-9d55-27df1ff12845","image":"94d15bee-51df-41c3-8b30-db827f8d4556","date_updated":"2023-10-03T12:49:05.705Z"}	\N
98	132	workspace	3	{"id":3,"date_created":null,"date_updated":"2023-10-03T12:49:34.167Z","name":"Loft Créatif","price":25,"capacity":15,"description":"Un loft spacieux et lumineux, parfait pour les créatifs et les artistes.","available":false,"thumbnail":"732a65f0-0bb2-40ef-9d55-27df1ff12845","image":"94d15bee-51df-41c3-8b30-db827f8d4556"}	{"thumbnail":"732a65f0-0bb2-40ef-9d55-27df1ff12845","image":"94d15bee-51df-41c3-8b30-db827f8d4556","date_updated":"2023-10-03T12:49:34.167Z"}	\N
99	133	workspace	4	{"id":4,"date_created":null,"date_updated":"2023-10-03T12:50:13.852Z","name":"Salle de Conférence","price":30,"capacity":50,"description":"Une grande salle de conférence équipée de tout le matériel nécessaire pour vos réunions.","available":true,"thumbnail":"732a65f0-0bb2-40ef-9d55-27df1ff12845","image":"94d15bee-51df-41c3-8b30-db827f8d4556"}	{"thumbnail":"732a65f0-0bb2-40ef-9d55-27df1ff12845","image":"94d15bee-51df-41c3-8b30-db827f8d4556","date_updated":"2023-10-03T12:50:13.852Z"}	\N
100	134	workspace	5	{"id":5,"date_created":null,"date_updated":"2023-10-03T12:50:31.149Z","name":"Studio Silencieux","price":18,"capacity":5,"description":"Un studio silencieux, idéal pour la concentration et le travail individuel.","available":true,"thumbnail":"732a65f0-0bb2-40ef-9d55-27df1ff12845","image":"94d15bee-51df-41c3-8b30-db827f8d4556"}	{"thumbnail":"732a65f0-0bb2-40ef-9d55-27df1ff12845","image":"94d15bee-51df-41c3-8b30-db827f8d4556","date_updated":"2023-10-03T12:50:31.149Z"}	\N
101	138	booking	6	{"workspace_id":1,"user_id":"131bafd7-768a-4229-b5aa-6ea5688b5537","start_date":"2023-10-16T12:53:35","end_date":"2023-10-17T18:00:00"}	{"workspace_id":1,"user_id":"131bafd7-768a-4229-b5aa-6ea5688b5537","start_date":"2023-10-16T12:53:35","end_date":"2023-10-17T18:00:00"}	\N
102	139	workspace	1	{"id":1,"date_created":null,"date_updated":"2023-10-16T12:53:36.036Z","name":"Espace Zen","price":20.5,"capacity":10,"description":"Un espace calme et paisible avec des plantes et une décoration zen.","available":false,"thumbnail":"732a65f0-0bb2-40ef-9d55-27df1ff12845","image":"94d15bee-51df-41c3-8b30-db827f8d4556"}	{"available":false,"date_updated":"2023-10-16T12:53:36.036Z"}	\N
103	141	comment	15	{"title":"Test","content":"sfsdfdgsdfsdfsdf","date_time":"2023-10-16T13:57:45","workspace_id":1,"user_id":null}	{"title":"Test","content":"sfsdfdgsdfsdfsdf","date_time":"2023-10-16T13:57:45","workspace_id":1,"user_id":null}	\N
104	146	directus_fields	56	{"sort":11,"interface":"map","special":null,"options":{"defaultView":{"center":{"lng":-5.513108939994709,"lat":-14.67969531140892},"zoom":1.3333108129635078,"bearing":0,"pitch":0},"geometryType":"Point"},"collection":"workspace","field":"coordinates"}	{"sort":11,"interface":"map","special":null,"options":{"defaultView":{"center":{"lng":-5.513108939994709,"lat":-14.67969531140892},"zoom":1.3333108129635078,"bearing":0,"pitch":0},"geometryType":"Point"},"collection":"workspace","field":"coordinates"}	\N
105	147	workspace	1	{"id":1,"date_created":null,"date_updated":"2023-10-17T14:21:15.497Z","name":"Espace Zen","price":20.5,"capacity":10,"description":"Un espace calme et paisible avec des plantes et une décoration zen.","available":false,"thumbnail":"732a65f0-0bb2-40ef-9d55-27df1ff12845","image":"94d15bee-51df-41c3-8b30-db827f8d4556","coordinates":{"type":"Point","coordinates":[2.462436327558237,48.443789134830325]}}	{"coordinates":{"type":"Point","coordinates":[2.462436327558237,48.443789134830325]},"date_updated":"2023-10-17T14:21:15.497Z"}	\N
106	148	workspace	1	{"id":1,"date_created":null,"date_updated":"2023-10-17T14:22:00.091Z","name":"Espace Zen","price":20.5,"capacity":10,"description":"Un espace calme et paisible avec des plantes et une décoration zen.","available":false,"thumbnail":"732a65f0-0bb2-40ef-9d55-27df1ff12845","image":"94d15bee-51df-41c3-8b30-db827f8d4556","coordinates":{"type":"Point","coordinates":[2.335719515754164,48.85351217866244]}}	{"coordinates":{"type":"Point","coordinates":[2.335719515754164,48.85351217866244]},"date_updated":"2023-10-17T14:22:00.091Z"}	\N
107	149	workspace	2	{"id":2,"date_created":null,"date_updated":"2023-10-17T14:22:52.491Z","name":"Bureau Dynamique","price":15,"capacity":20,"description":"Un espace dynamique et énergisant, idéal pour les équipes et les start-ups.","available":true,"thumbnail":"732a65f0-0bb2-40ef-9d55-27df1ff12845","image":"94d15bee-51df-41c3-8b30-db827f8d4556","coordinates":{"type":"Point","coordinates":[-4.480184989958104,48.39689312346448]}}	{"coordinates":{"type":"Point","coordinates":[-4.480184989958104,48.39689312346448]},"date_updated":"2023-10-17T14:22:52.491Z"}	\N
108	150	workspace	3	{"id":3,"date_created":null,"date_updated":"2023-10-17T14:24:04.643Z","name":"Loft Créatif","price":25,"capacity":15,"description":"Un loft spacieux et lumineux, parfait pour les créatifs et les artistes.","available":false,"thumbnail":"732a65f0-0bb2-40ef-9d55-27df1ff12845","image":"94d15bee-51df-41c3-8b30-db827f8d4556","coordinates":{"type":"Point","coordinates":[4.825936975160545,45.76145581264544]}}	{"coordinates":{"type":"Point","coordinates":[4.825936975160545,45.76145581264544]},"date_updated":"2023-10-17T14:24:04.643Z"}	\N
109	151	workspace	4	{"id":4,"date_created":null,"date_updated":"2023-10-17T14:24:47.774Z","name":"Salle de Conférence","price":30,"capacity":50,"description":"Une grande salle de conférence équipée de tout le matériel nécessaire pour vos réunions.","available":true,"thumbnail":"732a65f0-0bb2-40ef-9d55-27df1ff12845","image":"94d15bee-51df-41c3-8b30-db827f8d4556","coordinates":{"type":"Point","coordinates":[7.785947283656071,48.590116465010226]}}	{"coordinates":{"type":"Point","coordinates":[7.785947283656071,48.590116465010226]},"date_updated":"2023-10-17T14:24:47.774Z"}	\N
110	152	workspace	5	{"id":5,"date_created":null,"date_updated":"2023-10-17T14:25:17.973Z","name":"Studio Silencieux","price":18,"capacity":5,"description":"Un studio silencieux, idéal pour la concentration et le travail individuel.","available":true,"thumbnail":"732a65f0-0bb2-40ef-9d55-27df1ff12845","image":"94d15bee-51df-41c3-8b30-db827f8d4556","coordinates":{"type":"Point","coordinates":[3.059933976412651,50.64193793866653]}}	{"coordinates":{"type":"Point","coordinates":[3.059933976412651,50.64193793866653]},"date_updated":"2023-10-17T14:25:17.973Z"}	\N
111	153	directus_fields	57	{"sort":12,"special":null,"collection":"workspace","field":"location"}	{"sort":12,"special":null,"collection":"workspace","field":"location"}	\N
112	154	workspace	1	{"id":1,"date_created":null,"date_updated":"2023-10-18T11:44:53.641Z","name":"Espace Zen","price":20.5,"capacity":10,"description":"Un espace calme et paisible avec des plantes et une décoration zen.","available":false,"thumbnail":"732a65f0-0bb2-40ef-9d55-27df1ff12845","image":"94d15bee-51df-41c3-8b30-db827f8d4556","coordinates":{"type":"Point","coordinates":[2.335719515754164,48.85351217866244]},"location":{"type":"Point","coordinates":[2.345923230376883,48.855485587057075]}}	{"location":{"type":"Point","coordinates":[2.345923230376883,48.855485587057075]},"date_updated":"2023-10-18T11:44:53.641Z"}	\N
113	155	directus_fields	58	{"sort":12,"special":null,"collection":"workspace","field":"location"}	{"sort":12,"special":null,"collection":"workspace","field":"location"}	\N
114	156	workspace	1	{"id":1,"date_created":null,"date_updated":"2023-10-18T11:52:53.405Z","name":"Espace Zen","price":20.5,"capacity":10,"description":"Un espace calme et paisible avec des plantes et une décoration zen.","available":false,"thumbnail":"732a65f0-0bb2-40ef-9d55-27df1ff12845","image":"94d15bee-51df-41c3-8b30-db827f8d4556","coordinates":{"type":"Point","coordinates":[2.335719515754164,48.85351217866244]},"location":"[48.85989059212367, 2.3084964717484846]"}	{"location":"[48.85989059212367, 2.3084964717484846]","date_updated":"2023-10-18T11:52:53.405Z"}	\N
115	157	workspace	2	{"id":2,"date_created":null,"date_updated":"2023-10-18T12:03:45.095Z","name":"Bureau Dynamique","price":15,"capacity":20,"description":"Un espace dynamique et énergisant, idéal pour les équipes et les start-ups.","available":true,"thumbnail":"732a65f0-0bb2-40ef-9d55-27df1ff12845","image":"94d15bee-51df-41c3-8b30-db827f8d4556","location":"[48.86378615930376, 2.3634780528003185]"}	{"location":"[48.86378615930376, 2.3634780528003185]","date_updated":"2023-10-18T12:03:45.095Z"}	\N
116	158	workspace	3	{"id":3,"date_created":null,"date_updated":"2023-10-18T12:05:06.226Z","name":"Loft Créatif","price":25,"capacity":15,"description":"Un loft spacieux et lumineux, parfait pour les créatifs et les artistes.","available":false,"thumbnail":"732a65f0-0bb2-40ef-9d55-27df1ff12845","image":"94d15bee-51df-41c3-8b30-db827f8d4556","location":"[48.582859672278, 7.74264115781536]"}	{"location":"[48.582859672278, 7.74264115781536]","date_updated":"2023-10-18T12:05:06.226Z"}	\N
117	159	workspace	4	{"id":4,"date_created":null,"date_updated":"2023-10-18T12:06:03.476Z","name":"Salle de Conférence","price":30,"capacity":50,"description":"Une grande salle de conférence équipée de tout le matériel nécessaire pour vos réunions.","available":true,"thumbnail":"732a65f0-0bb2-40ef-9d55-27df1ff12845","image":"94d15bee-51df-41c3-8b30-db827f8d4556","location":"[45.76212514497845, 4.827493139772305]"}	{"location":"[45.76212514497845, 4.827493139772305]","date_updated":"2023-10-18T12:06:03.476Z"}	\N
118	160	workspace	5	{"id":5,"date_created":null,"date_updated":"2023-10-18T12:07:03.338Z","name":"Studio Silencieux","price":18,"capacity":5,"description":"Un studio silencieux, idéal pour la concentration et le travail individuel.","available":true,"thumbnail":"732a65f0-0bb2-40ef-9d55-27df1ff12845","image":"94d15bee-51df-41c3-8b30-db827f8d4556","location":"[48.114030598543486, -1.678238635237772]"}	{"location":"[48.114030598543486, -1.678238635237772]","date_updated":"2023-10-18T12:07:03.338Z"}	\N
119	162	directus_permissions	10	{"role":null,"collection":"directus_files","action":"share","fields":["*"],"permissions":{},"validation":{}}	{"role":null,"collection":"directus_files","action":"share","fields":["*"],"permissions":{},"validation":{}}	\N
\.


--
-- Data for Name: directus_roles; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_roles (id, name, icon, description, ip_access, enforce_tfa, admin_access, app_access) FROM stdin;
91786d99-b853-448d-81cf-1efc1a05986c	Administrator	verified	$t:admin_description	\N	f	t	t
\.


--
-- Data for Name: directus_sessions; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_sessions (token, "user", expires, ip, user_agent, share, origin) FROM stdin;
4M8vyHsjxXeV-nRXqL95bVcZqVg4wp-DdGHZkR54k5egy6HZB8TWAnWYN1KN-27S	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-25 12:39:07.097+00	172.18.0.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36	\N	http://localhost:8055
7qj-0o_3-ppjrTo3PbZjAmrzQOv8sRZUGponRdWMweUThcLiHOFDqqBy1YBIxy2m	131bafd7-768a-4229-b5aa-6ea5688b5537	2023-10-31 15:19:07.242+00	192.168.16.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Safari/537.36	\N	http://localhost:8055
\.


--
-- Data for Name: directus_settings; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_settings (id, project_name, project_url, project_color, project_logo, public_foreground, public_background, public_note, auth_login_attempts, auth_password_policy, storage_asset_transform, storage_asset_presets, custom_css, storage_default_folder, basemaps, mapbox_key, module_bar, project_descriptor, default_language, custom_aspect_ratios) FROM stdin;
\.


--
-- Data for Name: directus_shares; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_shares (id, name, collection, item, role, password, user_created, date_created, date_start, date_end, times_used, max_uses) FROM stdin;
\.


--
-- Data for Name: directus_translations; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_translations (id, language, key, value) FROM stdin;
\.


--
-- Data for Name: directus_users; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_users (id, first_name, last_name, email, password, location, title, description, tags, avatar, language, theme, tfa_secret, status, role, token, last_access, last_page, provider, external_identifier, auth_data, email_notifications) FROM stdin;
65b14b0d-c95a-49f7-a39b-53cafc2bfdef	Perceval	\N	perceval@example.com	$argon2id$v=19$m=65536,t=3,p=4$XItFOiifoHWxWVFJd6qvqQ$BY5c0cXgvD5G0B/dxAdzTMS0A/N1eApnhu5LtQuBX4g	\N	\N	\N	\N	\N	\N	auto	\N	active	91786d99-b853-448d-81cf-1efc1a05986c	\N	\N	\N	default	\N	\N	t
bc9a9573-7fbe-4cd4-b64a-3564f6bfc31c	Karadoc	\N	karadoc@example.com	$argon2id$v=19$m=65536,t=3,p=4$Rn8g1anH16/9xJ/SngzC4Q$rt78DLpR1VtZpsjAQmC7yot/VpGS8ZeClXRrE8Lo3sI	\N	\N	\N	\N	\N	\N	auto	\N	active	91786d99-b853-448d-81cf-1efc1a05986c	\N	\N	\N	default	\N	\N	t
131bafd7-768a-4229-b5aa-6ea5688b5537	Admin	User	admin@example.com	$argon2id$v=19$m=65536,t=3,p=4$amJJH63+dIgma90VIRJ01w$5liOJKl9CUbUbnspHZPH6aYfdUga69LtC2DLd3kal3Y	\N	\N	\N	\N	\N	\N	auto	\N	active	91786d99-b853-448d-81cf-1efc1a05986c	\N	2023-10-24 15:19:07.276+00	/settings/roles/public	default	\N	\N	t
\.


--
-- Data for Name: directus_webhooks; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.directus_webhooks (id, name, method, url, status, data, actions, collections, headers) FROM stdin;
\.


--
-- Data for Name: spatial_ref_sys; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.spatial_ref_sys (srid, auth_name, auth_srid, srtext, proj4text) FROM stdin;
\.


--
-- Data for Name: workspace; Type: TABLE DATA; Schema: public; Owner: directus
--

COPY public.workspace (id, date_created, date_updated, name, price, capacity, description, available, thumbnail, image, location) FROM stdin;
1	\N	2023-10-18 11:52:53.405+00	Espace Zen	20.5	10	Un espace calme et paisible avec des plantes et une décoration zen.	f	732a65f0-0bb2-40ef-9d55-27df1ff12845	94d15bee-51df-41c3-8b30-db827f8d4556	[48.85989059212367, 2.3084964717484846]
2	\N	2023-10-18 12:03:45.095+00	Bureau Dynamique	15	20	Un espace dynamique et énergisant, idéal pour les équipes et les start-ups.	t	732a65f0-0bb2-40ef-9d55-27df1ff12845	94d15bee-51df-41c3-8b30-db827f8d4556	[48.86378615930376, 2.3634780528003185]
3	\N	2023-10-18 12:05:06.226+00	Loft Créatif	25	15	Un loft spacieux et lumineux, parfait pour les créatifs et les artistes.	f	732a65f0-0bb2-40ef-9d55-27df1ff12845	94d15bee-51df-41c3-8b30-db827f8d4556	[48.582859672278, 7.74264115781536]
4	\N	2023-10-18 12:06:03.476+00	Salle de Conférence	30	50	Une grande salle de conférence équipée de tout le matériel nécessaire pour vos réunions.	t	732a65f0-0bb2-40ef-9d55-27df1ff12845	94d15bee-51df-41c3-8b30-db827f8d4556	[45.76212514497845, 4.827493139772305]
5	\N	2023-10-18 12:07:03.338+00	Studio Silencieux	18	5	Un studio silencieux, idéal pour la concentration et le travail individuel.	t	732a65f0-0bb2-40ef-9d55-27df1ff12845	94d15bee-51df-41c3-8b30-db827f8d4556	[48.114030598543486, -1.678238635237772]
\.


--
-- Data for Name: geocode_settings; Type: TABLE DATA; Schema: tiger; Owner: directus
--

COPY tiger.geocode_settings (name, setting, unit, category, short_desc) FROM stdin;
\.


--
-- Data for Name: pagc_gaz; Type: TABLE DATA; Schema: tiger; Owner: directus
--

COPY tiger.pagc_gaz (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- Data for Name: pagc_lex; Type: TABLE DATA; Schema: tiger; Owner: directus
--

COPY tiger.pagc_lex (id, seq, word, stdword, token, is_custom) FROM stdin;
\.


--
-- Data for Name: pagc_rules; Type: TABLE DATA; Schema: tiger; Owner: directus
--

COPY tiger.pagc_rules (id, rule, is_custom) FROM stdin;
\.


--
-- Data for Name: topology; Type: TABLE DATA; Schema: topology; Owner: directus
--

COPY topology.topology (id, name, srid, "precision", hasz) FROM stdin;
\.


--
-- Data for Name: layer; Type: TABLE DATA; Schema: topology; Owner: directus
--

COPY topology.layer (topology_id, layer_id, schema_name, table_name, feature_column, feature_type, level, child_id) FROM stdin;
\.


--
-- Name: booking_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.booking_id_seq', 6, true);


--
-- Name: comment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.comment_id_seq', 15, true);


--
-- Name: directus_activity_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_activity_id_seq', 162, true);


--
-- Name: directus_fields_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_fields_id_seq', 58, true);


--
-- Name: directus_notifications_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_notifications_id_seq', 1, false);


--
-- Name: directus_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_permissions_id_seq', 10, true);


--
-- Name: directus_presets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_presets_id_seq', 5, true);


--
-- Name: directus_relations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_relations_id_seq', 37, true);


--
-- Name: directus_revisions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_revisions_id_seq', 119, true);


--
-- Name: directus_settings_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_settings_id_seq', 1, false);


--
-- Name: directus_webhooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.directus_webhooks_id_seq', 1, false);


--
-- Name: workspace_id_seq; Type: SEQUENCE SET; Schema: public; Owner: directus
--

SELECT pg_catalog.setval('public.workspace_id_seq', 33, true);


--
-- Name: booking booking_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_pkey PRIMARY KEY (id);


--
-- Name: comment comment_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);


--
-- Name: directus_activity directus_activity_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_activity
    ADD CONSTRAINT directus_activity_pkey PRIMARY KEY (id);


--
-- Name: directus_collections directus_collections_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_pkey PRIMARY KEY (collection);


--
-- Name: directus_dashboards directus_dashboards_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_pkey PRIMARY KEY (id);


--
-- Name: directus_fields directus_fields_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_fields
    ADD CONSTRAINT directus_fields_pkey PRIMARY KEY (id);


--
-- Name: directus_files directus_files_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_pkey PRIMARY KEY (id);


--
-- Name: directus_flows directus_flows_operation_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_operation_unique UNIQUE (operation);


--
-- Name: directus_flows directus_flows_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_pkey PRIMARY KEY (id);


--
-- Name: directus_folders directus_folders_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_pkey PRIMARY KEY (id);


--
-- Name: directus_migrations directus_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_migrations
    ADD CONSTRAINT directus_migrations_pkey PRIMARY KEY (version);


--
-- Name: directus_notifications directus_notifications_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_pkey PRIMARY KEY (id);


--
-- Name: directus_operations directus_operations_reject_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_unique UNIQUE (reject);


--
-- Name: directus_operations directus_operations_resolve_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_unique UNIQUE (resolve);


--
-- Name: directus_panels directus_panels_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_pkey PRIMARY KEY (id);


--
-- Name: directus_permissions directus_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_pkey PRIMARY KEY (id);


--
-- Name: directus_presets directus_presets_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_pkey PRIMARY KEY (id);


--
-- Name: directus_relations directus_relations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_relations
    ADD CONSTRAINT directus_relations_pkey PRIMARY KEY (id);


--
-- Name: directus_revisions directus_revisions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_pkey PRIMARY KEY (id);


--
-- Name: directus_roles directus_roles_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_roles
    ADD CONSTRAINT directus_roles_pkey PRIMARY KEY (id);


--
-- Name: directus_sessions directus_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_pkey PRIMARY KEY (token);


--
-- Name: directus_settings directus_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_pkey PRIMARY KEY (id);


--
-- Name: directus_shares directus_shares_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_pkey PRIMARY KEY (id);


--
-- Name: directus_translations directus_translations_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_translations
    ADD CONSTRAINT directus_translations_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_email_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_email_unique UNIQUE (email);


--
-- Name: directus_users directus_users_external_identifier_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_external_identifier_unique UNIQUE (external_identifier);


--
-- Name: directus_users directus_users_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_pkey PRIMARY KEY (id);


--
-- Name: directus_users directus_users_token_unique; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_token_unique UNIQUE (token);


--
-- Name: directus_webhooks directus_webhooks_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_webhooks
    ADD CONSTRAINT directus_webhooks_pkey PRIMARY KEY (id);


--
-- Name: workspace workspace_pkey; Type: CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.workspace
    ADD CONSTRAINT workspace_pkey PRIMARY KEY (id);


--
-- Name: booking booking_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: booking booking_workspace_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.booking
    ADD CONSTRAINT booking_workspace_id_foreign FOREIGN KEY (workspace_id) REFERENCES public.workspace(id) ON DELETE SET NULL;


--
-- Name: comment comment_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: comment comment_workspace_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_workspace_id_foreign FOREIGN KEY (workspace_id) REFERENCES public.workspace(id) ON DELETE SET NULL;


--
-- Name: directus_collections directus_collections_group_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_collections
    ADD CONSTRAINT directus_collections_group_foreign FOREIGN KEY ("group") REFERENCES public.directus_collections(collection);


--
-- Name: directus_dashboards directus_dashboards_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_dashboards
    ADD CONSTRAINT directus_dashboards_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_folder_foreign FOREIGN KEY (folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_files directus_files_modified_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_modified_by_foreign FOREIGN KEY (modified_by) REFERENCES public.directus_users(id);


--
-- Name: directus_files directus_files_uploaded_by_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_files
    ADD CONSTRAINT directus_files_uploaded_by_foreign FOREIGN KEY (uploaded_by) REFERENCES public.directus_users(id);


--
-- Name: directus_flows directus_flows_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_flows
    ADD CONSTRAINT directus_flows_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_folders directus_folders_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_folders
    ADD CONSTRAINT directus_folders_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_folders(id);


--
-- Name: directus_notifications directus_notifications_recipient_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_recipient_foreign FOREIGN KEY (recipient) REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_notifications directus_notifications_sender_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_notifications
    ADD CONSTRAINT directus_notifications_sender_foreign FOREIGN KEY (sender) REFERENCES public.directus_users(id);


--
-- Name: directus_operations directus_operations_flow_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_flow_foreign FOREIGN KEY (flow) REFERENCES public.directus_flows(id) ON DELETE CASCADE;


--
-- Name: directus_operations directus_operations_reject_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_reject_foreign FOREIGN KEY (reject) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_resolve_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_resolve_foreign FOREIGN KEY (resolve) REFERENCES public.directus_operations(id);


--
-- Name: directus_operations directus_operations_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_operations
    ADD CONSTRAINT directus_operations_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_panels directus_panels_dashboard_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_dashboard_foreign FOREIGN KEY (dashboard) REFERENCES public.directus_dashboards(id) ON DELETE CASCADE;


--
-- Name: directus_panels directus_panels_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_panels
    ADD CONSTRAINT directus_panels_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_permissions directus_permissions_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_permissions
    ADD CONSTRAINT directus_permissions_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_presets directus_presets_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_presets
    ADD CONSTRAINT directus_presets_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_activity_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_activity_foreign FOREIGN KEY (activity) REFERENCES public.directus_activity(id) ON DELETE CASCADE;


--
-- Name: directus_revisions directus_revisions_parent_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_revisions
    ADD CONSTRAINT directus_revisions_parent_foreign FOREIGN KEY (parent) REFERENCES public.directus_revisions(id);


--
-- Name: directus_sessions directus_sessions_share_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_share_foreign FOREIGN KEY (share) REFERENCES public.directus_shares(id) ON DELETE CASCADE;


--
-- Name: directus_sessions directus_sessions_user_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_sessions
    ADD CONSTRAINT directus_sessions_user_foreign FOREIGN KEY ("user") REFERENCES public.directus_users(id) ON DELETE CASCADE;


--
-- Name: directus_settings directus_settings_project_logo_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_project_logo_foreign FOREIGN KEY (project_logo) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_background_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_background_foreign FOREIGN KEY (public_background) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_public_foreground_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_public_foreground_foreign FOREIGN KEY (public_foreground) REFERENCES public.directus_files(id);


--
-- Name: directus_settings directus_settings_storage_default_folder_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_settings
    ADD CONSTRAINT directus_settings_storage_default_folder_foreign FOREIGN KEY (storage_default_folder) REFERENCES public.directus_folders(id) ON DELETE SET NULL;


--
-- Name: directus_shares directus_shares_collection_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_collection_foreign FOREIGN KEY (collection) REFERENCES public.directus_collections(collection) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE CASCADE;


--
-- Name: directus_shares directus_shares_user_created_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_shares
    ADD CONSTRAINT directus_shares_user_created_foreign FOREIGN KEY (user_created) REFERENCES public.directus_users(id) ON DELETE SET NULL;


--
-- Name: directus_users directus_users_role_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.directus_users
    ADD CONSTRAINT directus_users_role_foreign FOREIGN KEY (role) REFERENCES public.directus_roles(id) ON DELETE SET NULL;


--
-- Name: workspace workspace_image_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.workspace
    ADD CONSTRAINT workspace_image_foreign FOREIGN KEY (image) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- Name: workspace workspace_thumbnail_foreign; Type: FK CONSTRAINT; Schema: public; Owner: directus
--

ALTER TABLE ONLY public.workspace
    ADD CONSTRAINT workspace_thumbnail_foreign FOREIGN KEY (thumbnail) REFERENCES public.directus_files(id) ON DELETE SET NULL;


--
-- PostgreSQL database dump complete
--

