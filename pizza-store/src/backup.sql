--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0 (Ubuntu 17.0-1.pgdg22.04+1)
-- Dumped by pg_dump version 17.0 (Ubuntu 17.0-1.pgdg22.04+1)

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
-- Name: orderstatus; Type: TYPE; Schema: public; Owner: maslova
--

CREATE TYPE public.orderstatus AS ENUM (
    'NEW',
    'ORDERED',
    'PREPARING',
    'READY',
    'DELIVERING',
    'DELIVERED',
    'COMPLETED'
);


ALTER TYPE public.orderstatus OWNER TO maslova;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: base_pizzas; Type: TABLE; Schema: public; Owner: maslova
--

CREATE TABLE public.base_pizzas (
    base_pizza_id character varying(40) NOT NULL,
    name character varying(50),
    description character varying(255),
    price_rub real
);


ALTER TABLE public.base_pizzas OWNER TO maslova;

--
-- Name: order_pizza; Type: TABLE; Schema: public; Owner: maslova
--

CREATE TABLE public.order_pizza (
    order_id character varying(40) NOT NULL,
    pizza_id character varying(40) NOT NULL
);


ALTER TABLE public.order_pizza OWNER TO maslova;

--
-- Name: orders; Type: TABLE; Schema: public; Owner: maslova
--

CREATE TABLE public.orders (
    order_id character varying(40) NOT NULL,
    user_id character varying(40),
    pizzas character varying(40)[],
    address character varying(100),
    order_status public.orderstatus,
    paid boolean DEFAULT false
);


ALTER TABLE public.orders OWNER TO maslova;

--
-- Name: pizza_topping; Type: TABLE; Schema: public; Owner: maslova
--

CREATE TABLE public.pizza_topping (
    pizza_id character varying(40) NOT NULL,
    topping_id character varying(40) NOT NULL
);


ALTER TABLE public.pizza_topping OWNER TO maslova;

--
-- Name: pizzas; Type: TABLE; Schema: public; Owner: maslova
--

CREATE TABLE public.pizzas (
    pizza_id character varying(40) NOT NULL,
    base_pizza_id character varying(40),
    topping_ids character varying(40)[]
);


ALTER TABLE public.pizzas OWNER TO maslova;

--
-- Name: toppings; Type: TABLE; Schema: public; Owner: maslova
--

CREATE TABLE public.toppings (
    topping_id character varying(40) NOT NULL,
    name character varying(50),
    description character varying(255),
    price_rub real
);


ALTER TABLE public.toppings OWNER TO maslova;

--
-- Name: users; Type: TABLE; Schema: public; Owner: maslova
--

CREATE TABLE public.users (
    user_id character varying(40) NOT NULL,
    name character varying(50),
    phone_number bigint
);


ALTER TABLE public.users OWNER TO maslova;

--
-- Data for Name: base_pizzas; Type: TABLE DATA; Schema: public; Owner: maslova
--

COPY public.base_pizzas (base_pizza_id, name, description, price_rub) FROM stdin;
75ea4cf1-2fb6-4695-9584-58941755fa71	Pepperoni	Pizza Pepperoni is the authentic Italian taste	650
f7f0785f-36c4-4808-8e4e-86440296d9c6	Pepperoni	Pizza Pepperoni is the authentic Italian taste	650
dde180ba-59c3-4172-a9b1-bdcedb34d0c4	Pepperoni	Pizza Pepperoni is the authentic Italian taste	650
997aed59-b36f-4f72-b555-a8136b4af45f	Pepperoni	Pizza Pepperoni is the authentic Italian taste	650
b3aa7f72-64aa-49b8-907e-8e3daffde2de	Pepperoni	Pizza Pepperoni is the authentic Italian taste	650
57972097-00a2-4091-b052-d09227f8d19d	Pepperoni	Pizza Pepperoni is the authentic Italian taste	650
46a866c4-b626-4110-b2dc-7afea4d7c4ab	Pepperoni	Pizza Pepperoni is the authentic Italian taste	650
c4bf7acc-9653-40ac-b7de-19773fa1d19a	Pepperoni	Pizza Pepperoni is the authentic Italian taste	650
37c046b1-6841-4e92-9992-72c8d3747020	Pepperoni	Pizza Pepperoni is the authentic Italian taste	650
797a8556-0398-4e8f-8e27-44a6a86f3ef1	Pepperoni	Pizza Pepperoni is the authentic Italian taste	650
a0757cb0-e1d3-45b1-9d9c-ff3e6c7e09f6	Pepperoni	Pizza Pepperoni is the authentic Italian taste	650
\.


--
-- Data for Name: order_pizza; Type: TABLE DATA; Schema: public; Owner: maslova
--

COPY public.order_pizza (order_id, pizza_id) FROM stdin;
ec66f7d7-2ba0-4970-87f1-686d96fd7b76	7492c867-d38f-410d-a005-852ea0829078
6a03a34c-2522-48b0-a800-96f46538d495	7492c867-d38f-410d-a005-852ea0829078
6bf7a885-76b4-465f-ae2c-7794964fe887	c3533623-1c71-4b8d-9e96-a276423ba76c
70542c50-32ae-4353-b099-ca778a8dc8a9	a5ef2112-c365-4c40-ac0e-971cdc7bf43e
13114eb7-c652-4d4d-a53d-938387ea2536	e6c0483c-6a50-4cc6-a352-9b83c5fb9690
b9e41a72-5b95-4105-b927-9a14c526543d	a260fd9f-9f12-4cb1-9fed-9037a2c62349
d521a9de-c853-4924-aa4f-1fd73435b042	147245ab-0823-461c-ab82-a6a514cde482
bc11b95c-368f-4320-a7d0-c91fde8564cc	5de188d5-5729-4023-b8cb-c3352c97e3e7
96e4c320-de9e-4db0-8c30-2af93aaae8b0	4b0e32de-fe8d-4c65-a565-234d0a58fc52
43646332-72fc-43fa-a837-d7bb8142bf2a	c1b411b1-a867-4d42-b84f-9463b43a2da0
8fceca1b-3f19-411a-8ae5-a39eef97c012	87337b80-d207-4ea8-8c24-95b03a934772
6fc78e70-ccfc-4eba-b44b-29469c4eefa3	df8d5ea3-618c-4498-9b73-64363594f52c
\.


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: maslova
--

COPY public.orders (order_id, user_id, pizzas, address, order_status, paid) FROM stdin;
6fc78e70-ccfc-4eba-b44b-29469c4eefa3	7ca20071-eef0-43ff-808e-65a6e6a63129	\N	Russia, Moscow, Krasnaya ploschad', 1	COMPLETED	t
ec66f7d7-2ba0-4970-87f1-686d96fd7b76	b7aa2465-6cb5-4c81-8004-fce44c247dbf	\N		COMPLETED	t
6a03a34c-2522-48b0-a800-96f46538d495	ec2a0d9e-5a17-44db-b6a6-4dca5e99c8df	\N	Testtsetstet	COMPLETED	t
bc11b95c-368f-4320-a7d0-c91fde8564cc	9b719d06-b2db-4afb-a728-56c1008ea9b1	\N	Russia, Moscow, Krasnaya ploschad', 1	COMPLETED	t
6bf7a885-76b4-465f-ae2c-7794964fe887	e7bb85d9-2750-41ef-89f4-2f222e820ecf	\N	Russia, Moscow, Krasnaya ploschad', 1	COMPLETED	t
96e4c320-de9e-4db0-8c30-2af93aaae8b0	b4900e8e-7937-4a39-97c5-0264f9d1c94c	\N	Russia, Moscow, Krasnaya ploschad', 1	COMPLETED	t
70542c50-32ae-4353-b099-ca778a8dc8a9	aad8de63-3d3d-4a78-805b-c65ee96ec435	\N	Russia, Moscow, Krasnaya ploschad', 1	COMPLETED	t
13114eb7-c652-4d4d-a53d-938387ea2536	088e6325-123b-41b3-84ce-53d57903bb85	\N	Russia, Moscow, Krasnaya ploschad', 1	COMPLETED	t
43646332-72fc-43fa-a837-d7bb8142bf2a	25ca2b5c-a642-4099-ac54-0ee82f2cb14c	\N	Russia, Moscow, Krasnaya ploschad', 1	COMPLETED	t
b9e41a72-5b95-4105-b927-9a14c526543d	ed604b7c-5e6b-4c93-b542-0b36f418746e	\N	Russia, Moscow, Krasnaya ploschad', 1	COMPLETED	t
8fceca1b-3f19-411a-8ae5-a39eef97c012	ff80e2d9-f3a0-4b62-be01-c9c61ceaed9a	\N	Russia, Moscow, Krasnaya ploschad', 1	COMPLETED	t
d521a9de-c853-4924-aa4f-1fd73435b042	27fcd6ee-2452-4ef3-95cf-d4a811e3b3ba	\N	Russia, Moscow, Krasnaya ploschad', 1	COMPLETED	t
\.


--
-- Data for Name: pizza_topping; Type: TABLE DATA; Schema: public; Owner: maslova
--

COPY public.pizza_topping (pizza_id, topping_id) FROM stdin;
\.


--
-- Data for Name: pizzas; Type: TABLE DATA; Schema: public; Owner: maslova
--

COPY public.pizzas (pizza_id, base_pizza_id, topping_ids) FROM stdin;
7492c867-d38f-410d-a005-852ea0829078	75ea4cf1-2fb6-4695-9584-58941755fa71	{6df7a90b-4610-4735-99a2-7a0a58fab5bf}
c3533623-1c71-4b8d-9e96-a276423ba76c	f7f0785f-36c4-4808-8e4e-86440296d9c6	{ff5f4893-0b6c-41fb-9941-9b980699f857}
a5ef2112-c365-4c40-ac0e-971cdc7bf43e	dde180ba-59c3-4172-a9b1-bdcedb34d0c4	{c5bf60fc-b7d5-4cf5-b68b-59c40544dbac}
e6c0483c-6a50-4cc6-a352-9b83c5fb9690	997aed59-b36f-4f72-b555-a8136b4af45f	{f6f3948d-ef85-4dd1-9b8f-4965e141a591}
a260fd9f-9f12-4cb1-9fed-9037a2c62349	b3aa7f72-64aa-49b8-907e-8e3daffde2de	{34f61bda-5bfb-4c64-ae34-8ea692e3930f}
147245ab-0823-461c-ab82-a6a514cde482	57972097-00a2-4091-b052-d09227f8d19d	{d9d8043d-79cd-4c1d-91ed-42842b0ec880}
5de188d5-5729-4023-b8cb-c3352c97e3e7	46a866c4-b626-4110-b2dc-7afea4d7c4ab	{caa9450b-d743-4588-9f31-71bc51559a63}
4b0e32de-fe8d-4c65-a565-234d0a58fc52	c4bf7acc-9653-40ac-b7de-19773fa1d19a	{ec9405c1-bd2d-4466-988d-bf648c00421b}
c1b411b1-a867-4d42-b84f-9463b43a2da0	37c046b1-6841-4e92-9992-72c8d3747020	{21e95289-3f01-45f1-8cfc-8d1d275515d4}
87337b80-d207-4ea8-8c24-95b03a934772	797a8556-0398-4e8f-8e27-44a6a86f3ef1	{80c60ab7-0c82-41cc-8ebe-547dbf884c29}
df8d5ea3-618c-4498-9b73-64363594f52c	a0757cb0-e1d3-45b1-9d9c-ff3e6c7e09f6	{b2461b32-cc80-4928-84ce-cbda5cb4d9b7}
\.


--
-- Data for Name: toppings; Type: TABLE DATA; Schema: public; Owner: maslova
--

COPY public.toppings (topping_id, name, description, price_rub) FROM stdin;
6df7a90b-4610-4735-99a2-7a0a58fab5bf	Pineapple	Delicious fresh pineaples for Hawaiian taste	50
ff5f4893-0b6c-41fb-9941-9b980699f857	Pineapple	Delicious fresh pineaples for Hawaiian taste	50
c5bf60fc-b7d5-4cf5-b68b-59c40544dbac	Pineapple	Delicious fresh pineaples for Hawaiian taste	50
f6f3948d-ef85-4dd1-9b8f-4965e141a591	Pineapple	Delicious fresh pineaples for Hawaiian taste	50
34f61bda-5bfb-4c64-ae34-8ea692e3930f	Pineapple	Delicious fresh pineaples for Hawaiian taste	50
d9d8043d-79cd-4c1d-91ed-42842b0ec880	Pineapple	Delicious fresh pineaples for Hawaiian taste	50
caa9450b-d743-4588-9f31-71bc51559a63	Pineapple	Delicious fresh pineaples for Hawaiian taste	50
ec9405c1-bd2d-4466-988d-bf648c00421b	Pineapple	Delicious fresh pineaples for Hawaiian taste	50
21e95289-3f01-45f1-8cfc-8d1d275515d4	Pineapple	Delicious fresh pineaples for Hawaiian taste	50
80c60ab7-0c82-41cc-8ebe-547dbf884c29	Pineapple	Delicious fresh pineaples for Hawaiian taste	50
b2461b32-cc80-4928-84ce-cbda5cb4d9b7	Pineapple	Delicious fresh pineaples for Hawaiian taste	50
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: maslova
--

COPY public.users (user_id, name, phone_number) FROM stdin;
b7aa2465-6cb5-4c81-8004-fce44c247dbf	Test1	9392934892802
ec2a0d9e-5a17-44db-b6a6-4dca5e99c8df	Test2	79196457834
e7bb85d9-2750-41ef-89f4-2f222e820ecf	Name	79003002010
aad8de63-3d3d-4a78-805b-c65ee96ec435	Name	79003002010
088e6325-123b-41b3-84ce-53d57903bb85	Name	79003002010
ed604b7c-5e6b-4c93-b542-0b36f418746e	Name	79003002010
27fcd6ee-2452-4ef3-95cf-d4a811e3b3ba	Name	79003002010
9b719d06-b2db-4afb-a728-56c1008ea9b1	Name	79003002010
b4900e8e-7937-4a39-97c5-0264f9d1c94c	Name	79003002010
25ca2b5c-a642-4099-ac54-0ee82f2cb14c	Name	79003002010
ff80e2d9-f3a0-4b62-be01-c9c61ceaed9a	Name	79003002010
e599a02a-9368-40de-a0fe-d857b9d8fbde	test_scr	234247289
7ca20071-eef0-43ff-808e-65a6e6a63129	Name	79003002010
\.


--
-- Name: base_pizzas base_pizzas_pkey; Type: CONSTRAINT; Schema: public; Owner: maslova
--

ALTER TABLE ONLY public.base_pizzas
    ADD CONSTRAINT base_pizzas_pkey PRIMARY KEY (base_pizza_id);


--
-- Name: order_pizza order_pizza_pkey; Type: CONSTRAINT; Schema: public; Owner: maslova
--

ALTER TABLE ONLY public.order_pizza
    ADD CONSTRAINT order_pizza_pkey PRIMARY KEY (order_id, pizza_id);


--
-- Name: orders orders_pkey; Type: CONSTRAINT; Schema: public; Owner: maslova
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (order_id);


--
-- Name: pizza_topping pizza_topping_pkey; Type: CONSTRAINT; Schema: public; Owner: maslova
--

ALTER TABLE ONLY public.pizza_topping
    ADD CONSTRAINT pizza_topping_pkey PRIMARY KEY (pizza_id, topping_id);


--
-- Name: pizzas pizzas_pkey; Type: CONSTRAINT; Schema: public; Owner: maslova
--

ALTER TABLE ONLY public.pizzas
    ADD CONSTRAINT pizzas_pkey PRIMARY KEY (pizza_id);


--
-- Name: toppings toppings_pkey; Type: CONSTRAINT; Schema: public; Owner: maslova
--

ALTER TABLE ONLY public.toppings
    ADD CONSTRAINT toppings_pkey PRIMARY KEY (topping_id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: maslova
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);


--
-- Name: pizzas fk_base_pizza; Type: FK CONSTRAINT; Schema: public; Owner: maslova
--

ALTER TABLE ONLY public.pizzas
    ADD CONSTRAINT fk_base_pizza FOREIGN KEY (base_pizza_id) REFERENCES public.base_pizzas(base_pizza_id);


--
-- Name: orders fk_user; Type: FK CONSTRAINT; Schema: public; Owner: maslova
--

ALTER TABLE ONLY public.orders
    ADD CONSTRAINT fk_user FOREIGN KEY (user_id) REFERENCES public.users(user_id);


--
-- Name: order_pizza order_pizza_order_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: maslova
--

ALTER TABLE ONLY public.order_pizza
    ADD CONSTRAINT order_pizza_order_id_fkey FOREIGN KEY (order_id) REFERENCES public.orders(order_id) ON DELETE CASCADE;


--
-- Name: order_pizza order_pizza_pizza_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: maslova
--

ALTER TABLE ONLY public.order_pizza
    ADD CONSTRAINT order_pizza_pizza_id_fkey FOREIGN KEY (pizza_id) REFERENCES public.pizzas(pizza_id) ON DELETE CASCADE;


--
-- Name: pizza_topping pizza_topping_pizza_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: maslova
--

ALTER TABLE ONLY public.pizza_topping
    ADD CONSTRAINT pizza_topping_pizza_id_fkey FOREIGN KEY (pizza_id) REFERENCES public.pizzas(pizza_id);


--
-- Name: pizza_topping pizza_topping_topping_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: maslova
--

ALTER TABLE ONLY public.pizza_topping
    ADD CONSTRAINT pizza_topping_topping_id_fkey FOREIGN KEY (topping_id) REFERENCES public.toppings(topping_id);


--
-- PostgreSQL database dump complete
--

