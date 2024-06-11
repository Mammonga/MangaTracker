--
-- PostgreSQL database dump
--

-- Dumped from database version 15.7
-- Dumped by pg_dump version 16.3

-- Started on 2024-06-11 10:59:14

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 215 (class 1259 OID 16916)
-- Name: book; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.book (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    author character varying(255),
    genre character varying(255),
    rating integer,
    review text,
    cover_url character varying(255),
    status character varying(50)
);


ALTER TABLE public.book OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16915)
-- Name: book_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.book_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.book_id_seq OWNER TO postgres;

--
-- TOC entry 3325 (class 0 OID 0)
-- Dependencies: 214
-- Name: book_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.book_id_seq OWNED BY public.book.id;


--
-- TOC entry 3173 (class 2604 OID 16919)
-- Name: book id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book ALTER COLUMN id SET DEFAULT nextval('public.book_id_seq'::regclass);


--
-- TOC entry 3319 (class 0 OID 16916)
-- Dependencies: 215
-- Data for Name: book; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.book (id, title, author, genre, rating, review, cover_url, status) FROM stdin;
3	Jujutsu Kaisen	Gege Akutami	shonen	8	The Jujutsu Kaisen manga is a gripping and intense shonen series that stands out for its intricate plot, well-developed characters, and stunning artwork. The story centers around Yuji Itadori, who gets entangled in the world of Jujutsu Sorcerers and cursed spirits, leading to thrilling and often dark adventures.\r\n\r\nGege Akutami, the creator, skillfully balances action, horror, and humor, providing a narrative that's both emotionally impactful and entertaining. The character development is a strong point, with each character, from protagonists to antagonists, having depth and complexity. The manga's pacing keeps readers hooked, and the action sequences are beautifully illustrated, showcasing Akutami's artistic prowess.\r\n\r\nOverall, Jujutsu Kaisen is a standout manga series that offers a compelling mix of supernatural elements, intense battles, and emotional depth, making it a must-read for fans of the genre.	9781974710027	reading
4	Toriko	Mitsutoshi Shimabukuro	Action, Adventure, Comedy, Fantasy	9	Toriko follows the adventures of Gourmet Hunter Toriko as he seeks the world's rarest ingredients to create his ultimate meal. Set in a fantastical world, the series brilliantly combines action and the art of gastronomy.	9781421535098	completed
6	Chainsaw Man	Tatsuki Fujimoto	Action, Horror, Dark Fantasy, Comedy	9	\r\nChainsaw Man is a unique and exhilarating manga series created by Tatsuki Fujimoto. It centers around Denji, a young man burdened by debt, who merges with his pet devil Pochita to become the titular Chainsaw Man. The series is lauded for its unpredictable and fast-paced storyline, filled with dark humor, intense action, and visceral horror. Fujimoto's art style is gritty and dynamic, perfectly complementing the chaotic narrative. The character development is profound, exploring themes of sacrifice, ambition, and the human desire for connection. Chainsaw Man's blend of grotesque imagery and heartfelt moments makes it a compelling read for fans of unconventional and daring manga.	9781974709939	reading
1	One Piece	Eichiro Oda	Adventure, Fantasy, Science Fiction	10	One Piece is a masterful anime that combines epic storytelling, rich world-building, and compelling characters to create an unforgettable adventure. With its intricate plot, diverse and well-developed cast, and emotionally resonant themes, it captivates viewers from start to finish. The imaginative settings and unique abilities add freshness to the action, while the series longevity and cultural impact underscore its significance in the anime world. Created by Eiichiro Oda, One Piece stands as a testament to creative dedication and remains a beloved and influential series in the genre.	9783551745811	completed
\.


--
-- TOC entry 3326 (class 0 OID 0)
-- Dependencies: 214
-- Name: book_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.book_id_seq', 6, true);


--
-- TOC entry 3175 (class 2606 OID 16923)
-- Name: book book_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_pkey PRIMARY KEY (id);


-- Completed on 2024-06-11 10:59:14

--
-- PostgreSQL database dump complete
--

