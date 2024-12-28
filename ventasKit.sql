--
-- PostgreSQL database dump
--

-- Dumped from database version 16.2
-- Dumped by pg_dump version 16.2

-- Started on 2024-11-25 21:04:36

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
-- TOC entry 6 (class 2615 OID 16788)
-- Name: seguridad; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA seguridad;


ALTER SCHEMA seguridad OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 221 (class 1259 OID 16761)
-- Name: cliente; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cliente (
    cedula character varying(10) NOT NULL,
    direccion character varying(255),
    telefono character varying(15),
    correo character varying(255),
    nombre character varying(100),
    numero_ue integer
);


ALTER TABLE public.cliente OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 73990)
-- Name: compra_kit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.compra_kit (
    id_compra integer NOT NULL,
    cedula_cliente character varying(10) NOT NULL,
    nombre_cliente character varying(100) NOT NULL,
    direccion character varying(255),
    telefono character varying(15),
    correo character varying(100),
    numero_ue integer,
    nombre_kit character varying(100) NOT NULL,
    fecha_compra timestamp without time zone DEFAULT now(),
    monto numeric(10,2) DEFAULT 0.00 NOT NULL
);


ALTER TABLE public.compra_kit OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 73989)
-- Name: compra_kit_id_compra_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.compra_kit_id_compra_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.compra_kit_id_compra_seq OWNER TO postgres;

--
-- TOC entry 4841 (class 0 OID 0)
-- Dependencies: 224
-- Name: compra_kit_id_compra_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.compra_kit_id_compra_seq OWNED BY public.compra_kit.id_compra;


--
-- TOC entry 217 (class 1259 OID 16660)
-- Name: modelo_kit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.modelo_kit (
    num_kit integer NOT NULL,
    nombre character varying(200),
    precio numeric(10,2),
    total_vendido numeric DEFAULT 0,
    curso character varying(200),
    descripcion text,
    subtitulo text,
    url_imagen text
);


ALTER TABLE public.modelo_kit OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16760)
-- Name: modelo_kit_num_kit_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.modelo_kit ALTER COLUMN num_kit ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.modelo_kit_num_kit_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 218 (class 1259 OID 16666)
-- Name: ue_kit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ue_kit (
    numero_ue integer NOT NULL,
    num_kit integer NOT NULL
);


ALTER TABLE public.ue_kit OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16699)
-- Name: unidad_educativa_numero_ue_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.unidad_educativa_numero_ue_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.unidad_educativa_numero_ue_seq OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16633)
-- Name: unidad_educativa; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.unidad_educativa (
    numero_ue integer DEFAULT nextval('public.unidad_educativa_numero_ue_seq'::regclass) NOT NULL,
    nombre character varying(150),
    telefono character varying(15),
    direccion character varying(255)
);


ALTER TABLE public.unidad_educativa OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16790)
-- Name: usuarios; Type: TABLE; Schema: seguridad; Owner: postgres
--

CREATE TABLE seguridad.usuarios (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    password_hash character varying NOT NULL
);


ALTER TABLE seguridad.usuarios OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16789)
-- Name: usuarios_id_seq; Type: SEQUENCE; Schema: seguridad; Owner: postgres
--

CREATE SEQUENCE seguridad.usuarios_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE seguridad.usuarios_id_seq OWNER TO postgres;

--
-- TOC entry 4843 (class 0 OID 0)
-- Dependencies: 222
-- Name: usuarios_id_seq; Type: SEQUENCE OWNED BY; Schema: seguridad; Owner: postgres
--

ALTER SEQUENCE seguridad.usuarios_id_seq OWNED BY seguridad.usuarios.id;


--
-- TOC entry 4661 (class 2604 OID 73993)
-- Name: compra_kit id_compra; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compra_kit ALTER COLUMN id_compra SET DEFAULT nextval('public.compra_kit_id_compra_seq'::regclass);


--
-- TOC entry 4660 (class 2604 OID 16793)
-- Name: usuarios id; Type: DEFAULT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.usuarios ALTER COLUMN id SET DEFAULT nextval('seguridad.usuarios_id_seq'::regclass);


--
-- TOC entry 4831 (class 0 OID 16761)
-- Dependencies: 221
-- Data for Name: cliente; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cliente (cedula, direccion, telefono, correo, nombre, numero_ue) FROM stdin;
1727915552	Av. Naciones Unidas y 6 de Diciembre	0959623844	adrianmolina782@gmail.com	Adrian Molina	\N
1727915550	Av. Naciones Unidas y 6 de Diciembre	0959623844	adrianmolina782@gmail.com	Adrian Molina	\N
1727915559	Av. Naciones Unidas y 6 de Diciembre	0959623844	adrianmolina782@gmail.com	Adrian Molina	\N
1727934446	Av. Naciones Unidas y 6 de Diciembre	0959623844	adrianmolina782@gmail.com	Adrian Molina	\N
1727934443	Av. Naciones Unidas y 6 de Diciembre	0959623844	adrianmolina782@gmail.com	Adrian Molina	\N
1727934456	Av. Naciones Unidas y 6 de Diciembre	0959623844	adrianmolina782@gmail.com	Adrian Molina	\N
1727934402	Av. Naciones Unidas y 6 de Diciembre	0959623844	adrianmolina782@gmail.com	Adrian Molina	\N
1727934403	Av. Naciones Unidas y 6 de Diciembre	0959623844	adrianmolina782@gmail.com	Adrian Molina	\N
1727934404	Av. Naciones Unidas y 6 de Diciembre	0959623844	adrianmolina782@gmail.com	Adrian Molina	\N
1727934405	Av. Naciones Unidas y 6 de Diciembre	0959623844	adrianmolina782@gmail.com	Adrian Molina	\N
1727934406	Av. Naciones Unidas y 6 de Diciembre	0959623844	adrianmolina782@gmail.com	Adrian Molina	107
1727934407	Av. Naciones Unidas y 6 de Diciembre	0959623844	adrianmolina782@gmail.com	Adrian Molina	108
1727934408	Av. Naciones Unidas y 6 de Diciembre	0959623844	adrianmolina782@gmail.com	Adrian Molina	108
1727934409	Av. Naciones Unidas y 6 de Diciembre	0959623844	adrianmolina782@gmail.com	Adrian Molina	107
1727934279	Av. Naciones Unidas y 6 de Diciembre	0959623844	adrianmolina782@gmail.com	Adrian Molina	108
1727934273	Av. Naciones Unidas y 6 de Diciembre	0959623844	adrianmolina782@gmail.com	Allan Molina	106
1727934211	Av. Naciones Unidas y 6 de Diciembre	0959623844	adrianmolina782@gmail.com	Allan Molina	108
1712867702	Av. Naciones Unidas y 6 de Diciembre	0959623844	adrianmolina782@gmail.com	Allan Molina	108
1728078340	Av. Naciones Unidas y 6 de Diciembre	0976543746	juan.example@gmail.com	Juan Perez	106
1712867787	Av. Naciones Unidas y 6 de Diciembre	0959623844	adrianmolina782@gmail.com	Allan Molina	108
1712867788	Av. Naciones Unidas y 6 de Diciembre	0959623844	adrianmolina782@gmail.com	Allan Molina	108
1712867780	Av. Naciones Unidas y 6 de Diciembre	0959623844	adrianmolina782@gmail.com	Allan Molina	107
1727914442	Av. Naciones Unidas y 6 de Diciembre	0959623844	adrianmolina782@gmail.com	Allan Molinari	107
\.


--
-- TOC entry 4835 (class 0 OID 73990)
-- Dependencies: 225
-- Data for Name: compra_kit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.compra_kit (id_compra, cedula_cliente, nombre_cliente, direccion, telefono, correo, numero_ue, nombre_kit, fecha_compra, monto) FROM stdin;
1	1727915552	Allan Molinari	Av. Naciones Unidas y 6 de Diciembre	0959623844	adrianmolina782@gmail.com	106	Robot Fox	2024-11-25 13:28:05.447065	0.00
9	1727915557	Allan Molinari	Av. Naciones Unidas y 6 de Diciembre	0959623844	adrianmolina782@gmail.com	106	Panel Bee Bot	2024-11-25 13:57:33.471395	60.00
10	1727934442	Allan Molinari	Av. Naciones Unidas y 6 de Diciembre	0959623844	adrianmolina782@gmail.com	107	Accesorios	2024-11-25 14:58:20.517764	25.00
11	1727934449	Allan Molinari	Av. Naciones Unidas y 6 de Diciembre	0959623844	adrianmolina782@gmail.com	108	Accesorios	2024-11-25 16:30:23.857175	25.00
12	1727934446	Allan Molinari	Av. Naciones Unidas y 6 de Diciembre	0959623844	adrianmolina782@gmail.com	108	Panel Bee Bot	2024-11-25 16:31:36.976359	60.00
13	1727934441	Allan Molinari	Av. Naciones Unidas y 6 de Diciembre	0959623844	adrianmolina782@gmail.com	106	Panel Bee Bot	2024-11-25 16:50:16.062626	60.00
14	1727934445	Allan Molinari	Av. Naciones Unidas y 6 de Diciembre	0959623844	adrianmolina782@gmail.com	106	Lector Táctil	2024-11-25 17:01:57.915824	80.00
15	1727934446	Allan Molinari	Av. Naciones Unidas y 6 de Diciembre	0959623844	adrianmolina782@gmail.com	107	Lector Táctil	2024-11-25 17:03:02.366447	80.00
\.


--
-- TOC entry 4827 (class 0 OID 16660)
-- Dependencies: 217
-- Data for Name: modelo_kit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.modelo_kit (num_kit, nombre, precio, total_vendido, curso, descripcion, subtitulo, url_imagen) FROM stdin;
47	Robot Mouse	150.00	1	No aplica	Introduce a los niños la diversión de codificación y rompecabezas para resolver con este colorido, mouse programables con laberinto. Una gran manera de introducir a los niños pequeños a la ciencia, tecnología, ingeniería y matemáticas.	Introduce a los niños la diversión de codificación y rompecabezas para resolver con este colorido, mouse programables con laberinto. Una gran manera de introducir a los niños pequeños a la ciencia, tecnología, ingeniería y matemáticas. Programa el mouse con fácil botones de control, se utiliza para trabajar en el laboratorio con todas las asignaturas. Solicita la temática: Matemática, lenguaje, inglés, etc.	https://firebasestorage.googleapis.com/v0/b/correos-masivos-1c0c7.appspot.com/o/robotMouse.webp?alt=media&token=108fb041-c89e-4d54-a4b3-1d53f7f8b0f4
48	Panel Bee Bot	60.00	0	No aplica	Es un punto de partida perfecto para el control de la enseñanza, el lenguaje direccional y la programación. Los alumnos además encontrarán que es más accesible para todos, incluidos aquellos con necesidades auditivas o de procesamiento visual.	Es un punto de partida perfecto para el control de la enseñanza, el lenguaje direccional y la programación. Los alumnos además encontrarán que es más accesible para todos, incluidos aquellos con necesidades auditivas o de procesamiento visual.	https://firebasestorage.googleapis.com/v0/b/correos-masivos-1c0c7.appspot.com/o/panelbee.webp?alt=media&token=9a472ffc-743d-4cd9-ae82-a1f0db215056
49	Blue Bot	140.00	0	No aplica	Funciona como el robot educativo Bee-Bot® pero es más adecuado para niños a partir de 6 años que ya pueden aprender a programar mejor desde la tablet.	Funciona como el robot educativo Bee-Bot® pero es más adecuado para niños a partir de 6 años que ya pueden aprender a programar mejor desde la tablet aunque no sepan leer. Blue-Bot® es tan intuitiva que no necesita más de 2 minutos para conquistar a quien la conoce por primera vez. Pero lo que la hace realmente única es la posibilidad de conectarla con un dispositivo móvil para así controlarla desde la App.	https://firebasestorage.googleapis.com/v0/b/correos-masivos-1c0c7.appspot.com/o/bluebot.webp?alt=media&token=26f08986-5526-4bd4-8746-18173162fa63
50	Accesorios	25.00	1	No aplica	Empujadores y porta bollis Nos permite crear distintas figuras geométricas que optimizan el funcionamiento de tu robot.	Empujadores y porta bollis Nos permite crear distintas figuras geométricas que optimizan el funcionamiento de tu robot.	https://firebasestorage.googleapis.com/v0/b/correos-masivos-1c0c7.appspot.com/o/accesorios.webp?alt=media&token=3e9424d5-aca3-4091-abad-a8c1e8d8a690
51	Lector Táctil	80.00	2	No aplica	El lector permite conectarse inalámbricamente hasta una distancia de 10 metros con respecto a blue Bot para competencias.	El lector permite conectarse inalámbricamente hasta una distancia de 10 metros con respecto a blue Bot para competencias.	https://firebasestorage.googleapis.com/v0/b/correos-masivos-1c0c7.appspot.com/o/lector.webp?alt=media&token=50ac4f03-771a-42dc-a20b-b7f59c5106bc
46	Robot Fox	120.00	3	Inicial	Juego sin pantalla: construye habilidades de codificación sin pantalla, desde contar hasta pensamiento secuencial y pensamiento computacional. Este enfoque fomenta la resolución de problemas, la lógica y la creatividad, permitiendo a los niños desarrollar competencias clave.	Juego sin pantalla: construye habilidades de codificación sin pantalla, desde contar hasta pensamiento secuencial hasta pensamiento informático	https://firebasestorage.googleapis.com/v0/b/correos-masivos-1c0c7.appspot.com/o/robotFox.webp?alt=media&token=be4b66ad-3636-433d-8844-4d73aadde816
\.


--
-- TOC entry 4828 (class 0 OID 16666)
-- Dependencies: 218
-- Data for Name: ue_kit; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ue_kit (numero_ue, num_kit) FROM stdin;
108	46
108	47
108	48
108	49
108	50
108	51
\.


--
-- TOC entry 4826 (class 0 OID 16633)
-- Dependencies: 216
-- Data for Name: unidad_educativa; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.unidad_educativa (numero_ue, nombre, telefono, direccion) FROM stdin;
106	Unidad Educativa María Auxiliadora	2024567	Manta
107	Unidad Educativa Santa Ana	022068934	Sangolqui
108	No aplica	no aplica	no aplica
\.


--
-- TOC entry 4833 (class 0 OID 16790)
-- Dependencies: 223
-- Data for Name: usuarios; Type: TABLE DATA; Schema: seguridad; Owner: postgres
--

COPY seguridad.usuarios (id, username, password_hash) FROM stdin;
2	admin	$2b$10$Y3JZnaj4WG6DUbLEIUpGse1nSHg6uFHJXnWuvPcZMweT3md5meKY6
3	admin1	$2b$10$bV2OzTensYk4MvqfGOqJSOgcZ6hxwyuMZp04DwKeRksxIR7mjUfl6
10	cris	$2b$10$WEunGESKTOedoyj9vfSic.m5d6Ka/hNl/xNVypgxU1n2Gi7c6QF6u
\.


--
-- TOC entry 4844 (class 0 OID 0)
-- Dependencies: 224
-- Name: compra_kit_id_compra_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.compra_kit_id_compra_seq', 15, true);


--
-- TOC entry 4845 (class 0 OID 0)
-- Dependencies: 220
-- Name: modelo_kit_num_kit_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.modelo_kit_num_kit_seq', 51, true);


--
-- TOC entry 4846 (class 0 OID 0)
-- Dependencies: 219
-- Name: unidad_educativa_numero_ue_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.unidad_educativa_numero_ue_seq', 108, true);


--
-- TOC entry 4847 (class 0 OID 0)
-- Dependencies: 222
-- Name: usuarios_id_seq; Type: SEQUENCE SET; Schema: seguridad; Owner: postgres
--

SELECT pg_catalog.setval('seguridad.usuarios_id_seq', 16, true);


--
-- TOC entry 4671 (class 2606 OID 16767)
-- Name: cliente cliente_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_pkey PRIMARY KEY (cedula);


--
-- TOC entry 4678 (class 2606 OID 73998)
-- Name: compra_kit compra_kit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compra_kit
    ADD CONSTRAINT compra_kit_pkey PRIMARY KEY (id_compra);


--
-- TOC entry 4667 (class 2606 OID 16665)
-- Name: modelo_kit modelo_kit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.modelo_kit
    ADD CONSTRAINT modelo_kit_pkey PRIMARY KEY (num_kit);


--
-- TOC entry 4669 (class 2606 OID 16670)
-- Name: ue_kit ue_kit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ue_kit
    ADD CONSTRAINT ue_kit_pkey PRIMARY KEY (numero_ue, num_kit);


--
-- TOC entry 4665 (class 2606 OID 16637)
-- Name: unidad_educativa unidad_educativa_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unidad_educativa
    ADD CONSTRAINT unidad_educativa_pkey PRIMARY KEY (numero_ue);


--
-- TOC entry 4674 (class 2606 OID 16795)
-- Name: usuarios usuarios_pkey; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (id);


--
-- TOC entry 4676 (class 2606 OID 16797)
-- Name: usuarios usuarios_username_key; Type: CONSTRAINT; Schema: seguridad; Owner: postgres
--

ALTER TABLE ONLY seguridad.usuarios
    ADD CONSTRAINT usuarios_username_key UNIQUE (username);


--
-- TOC entry 4672 (class 1259 OID 16798)
-- Name: idx_username; Type: INDEX; Schema: seguridad; Owner: postgres
--

CREATE INDEX idx_username ON seguridad.usuarios USING btree (username);


--
-- TOC entry 4681 (class 2606 OID 16768)
-- Name: cliente cliente_numero_ue_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cliente
    ADD CONSTRAINT cliente_numero_ue_fkey FOREIGN KEY (numero_ue) REFERENCES public.unidad_educativa(numero_ue);


--
-- TOC entry 4682 (class 2606 OID 73999)
-- Name: compra_kit compra_kit_numero_ue_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.compra_kit
    ADD CONSTRAINT compra_kit_numero_ue_fkey FOREIGN KEY (numero_ue) REFERENCES public.unidad_educativa(numero_ue);


--
-- TOC entry 4679 (class 2606 OID 16676)
-- Name: ue_kit ue_kit_num_kit_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ue_kit
    ADD CONSTRAINT ue_kit_num_kit_fkey FOREIGN KEY (num_kit) REFERENCES public.modelo_kit(num_kit);


--
-- TOC entry 4680 (class 2606 OID 16671)
-- Name: ue_kit ue_kit_numero_ue_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ue_kit
    ADD CONSTRAINT ue_kit_numero_ue_fkey FOREIGN KEY (numero_ue) REFERENCES public.unidad_educativa(numero_ue);


--
-- TOC entry 4842 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE usuarios; Type: ACL; Schema: seguridad; Owner: postgres
--

GRANT SELECT,INSERT,DELETE,UPDATE ON TABLE seguridad.usuarios TO administrador;
GRANT SELECT ON TABLE seguridad.usuarios TO usuario;


-- Completed on 2024-11-25 21:04:36

--
-- PostgreSQL database dump complete
--

