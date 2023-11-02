--
-- PostgreSQL database dump
--

-- Dumped from database version 15.4
-- Dumped by pg_dump version 15.4

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
-- Name: get_change_class_request_for_student(character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_change_class_request_for_student(studentid character varying) RETURNS TABLE(id integer, student character varying, old_class_id bigint, new_class_id bigint, status character varying, reason character varying)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY	
    SELECT cc.id, cc.student, cc.old_class_id, cc.new_class_id, cc.status, cc.reason
    FROM change_class cc
    WHERE cc.student = studentid
    ORDER BY cc.id DESC
    LIMIT 10; 
END;
$$;


ALTER FUNCTION public.get_change_class_request_for_student(studentid character varying) OWNER TO postgres;

--
-- Name: getstudentmark(bigint, character varying); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.getstudentmark(semesterid bigint, rollnumber character varying) RETURNS TABLE(id bigint, mark double precision, weight double precision)
    LANGUAGE plpgsql
    AS $$
BEGIN
    RETURN QUERY
    select m.id, m.mark, m.weight
	from users u 
	join student_transcript st
	on u.roll_number = st.student
	join transcript_mark tm
	on st.id = tm.transcript_id
	join mark m 
	on m.id = tm.mark_id
	where st.semester = semesterId and u.roll_number = rollnumber;
END;
$$;


ALTER FUNCTION public.getstudentmark(semesterid bigint, rollnumber character varying) OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: change_class; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.change_class (
    id bigint NOT NULL,
    reason character varying(255),
    status character varying(255),
    new_class_id bigint,
    old_class_id bigint,
    student character varying(255),
    teacher character varying(255),
    semester bigint
);


ALTER TABLE public.change_class OWNER TO sa;

--
-- Name: change_class_id_seq; Type: SEQUENCE; Schema: public; Owner: sa
--

CREATE SEQUENCE public.change_class_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.change_class_id_seq OWNER TO sa;

--
-- Name: change_class_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sa
--

ALTER SEQUENCE public.change_class_id_seq OWNED BY public.change_class.id;


--
-- Name: city; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.city (
    id bigint NOT NULL,
    cityname character varying(255),
    status character varying(255)
);


ALTER TABLE public.city OWNER TO sa;

--
-- Name: city_id_seq; Type: SEQUENCE; Schema: public; Owner: sa
--

CREATE SEQUENCE public.city_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.city_id_seq OWNER TO sa;

--
-- Name: city_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sa
--

ALTER SEQUENCE public.city_id_seq OWNED BY public.city.id;


--
-- Name: class; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.class (
    id bigint NOT NULL,
    classname character varying(255),
    class_organization bigint
);


ALTER TABLE public.class OWNER TO sa;

--
-- Name: class_id_seq; Type: SEQUENCE; Schema: public; Owner: sa
--

CREATE SEQUENCE public.class_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.class_id_seq OWNER TO sa;

--
-- Name: class_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sa
--

ALTER SEQUENCE public.class_id_seq OWNED BY public.class.id;


--
-- Name: district; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.district (
    id bigint NOT NULL,
    districname character varying(255),
    city bigint,
    status character varying(255)
);


ALTER TABLE public.district OWNER TO sa;

--
-- Name: district_id_seq; Type: SEQUENCE; Schema: public; Owner: sa
--

CREATE SEQUENCE public.district_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.district_id_seq OWNER TO sa;

--
-- Name: district_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sa
--

ALTER SEQUENCE public.district_id_seq OWNED BY public.district.id;


--
-- Name: ethnic; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.ethnic (
    id bigint NOT NULL,
    ethnic character varying(255),
    status character varying(255)
);


ALTER TABLE public.ethnic OWNER TO sa;

--
-- Name: ethnic_id_seq; Type: SEQUENCE; Schema: public; Owner: sa
--

CREATE SEQUENCE public.ethnic_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ethnic_id_seq OWNER TO sa;

--
-- Name: ethnic_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sa
--

ALTER SEQUENCE public.ethnic_id_seq OWNED BY public.ethnic.id;


--
-- Name: gender; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.gender (
    id bigint NOT NULL,
    gender character varying(255),
    status character varying(255)
);


ALTER TABLE public.gender OWNER TO sa;

--
-- Name: gender_id_seq; Type: SEQUENCE; Schema: public; Owner: sa
--

CREATE SEQUENCE public.gender_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.gender_id_seq OWNER TO sa;

--
-- Name: gender_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sa
--

ALTER SEQUENCE public.gender_id_seq OWNED BY public.gender.id;


--
-- Name: hibernate_sequence; Type: SEQUENCE; Schema: public; Owner: sa
--

CREATE SEQUENCE public.hibernate_sequence
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.hibernate_sequence OWNER TO sa;

--
-- Name: mark; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.mark (
    id bigint NOT NULL,
    mark double precision NOT NULL,
    weight double precision NOT NULL
);


ALTER TABLE public.mark OWNER TO sa;

--
-- Name: mark_id_seq; Type: SEQUENCE; Schema: public; Owner: sa
--

CREATE SEQUENCE public.mark_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.mark_id_seq OWNER TO sa;

--
-- Name: mark_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sa
--

ALTER SEQUENCE public.mark_id_seq OWNED BY public.mark.id;


--
-- Name: organization; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.organization (
    id bigint NOT NULL,
    operatingday timestamp without time zone,
    schoolcode character varying(255),
    schoolname character varying(255),
    status character varying(255),
    ward bigint,
    wardorganization bigint
);


ALTER TABLE public.organization OWNER TO sa;

--
-- Name: religion; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.religion (
    id bigint NOT NULL,
    religion character varying(255),
    status character varying(255)
);


ALTER TABLE public.religion OWNER TO sa;

--
-- Name: religion_id_seq; Type: SEQUENCE; Schema: public; Owner: sa
--

CREATE SEQUENCE public.religion_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.religion_id_seq OWNER TO sa;

--
-- Name: religion_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sa
--

ALTER SEQUENCE public.religion_id_seq OWNED BY public.religion.id;


--
-- Name: role; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.role (
    id bigint NOT NULL,
    rolename character varying(255)
);


ALTER TABLE public.role OWNER TO sa;

--
-- Name: role_id_seq; Type: SEQUENCE; Schema: public; Owner: sa
--

CREATE SEQUENCE public.role_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.role_id_seq OWNER TO sa;

--
-- Name: role_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sa
--

ALTER SEQUENCE public.role_id_seq OWNED BY public.role.id;


--
-- Name: semester; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.semester (
    id bigint NOT NULL,
    year character varying(255),
    semester character varying(255)
);


ALTER TABLE public.semester OWNER TO sa;

--
-- Name: semester_id_seq; Type: SEQUENCE; Schema: public; Owner: sa
--

CREATE SEQUENCE public.semester_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.semester_id_seq OWNER TO sa;

--
-- Name: semester_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sa
--

ALTER SEQUENCE public.semester_id_seq OWNED BY public.semester.id;


--
-- Name: student_transcript; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.student_transcript (
    id bigint NOT NULL,
    semester bigint,
    student character varying(255),
    subject character varying(255)
);


ALTER TABLE public.student_transcript OWNER TO sa;

--
-- Name: student_transcript_id_seq; Type: SEQUENCE; Schema: public; Owner: sa
--

CREATE SEQUENCE public.student_transcript_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.student_transcript_id_seq OWNER TO sa;

--
-- Name: student_transcript_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sa
--

ALTER SEQUENCE public.student_transcript_id_seq OWNED BY public.student_transcript.id;


--
-- Name: subject; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.subject (
    subjectcode character varying(255) NOT NULL,
    status character varying(255),
    subjectname character varying(255)
);


ALTER TABLE public.subject OWNER TO sa;

--
-- Name: subject_organization; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.subject_organization (
    subjectcode character varying(255) NOT NULL,
    organizationid bigint NOT NULL
);


ALTER TABLE public.subject_organization OWNER TO sa;

--
-- Name: teacher_class; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.teacher_class (
    id bigint NOT NULL,
    classid bigint,
    subjectcode character varying(255),
    rollnumber character varying(255),
    status character varying(255)
);


ALTER TABLE public.teacher_class OWNER TO sa;

--
-- Name: teacher_class_id_seq; Type: SEQUENCE; Schema: public; Owner: sa
--

CREATE SEQUENCE public.teacher_class_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.teacher_class_id_seq OWNER TO sa;

--
-- Name: teacher_class_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sa
--

ALTER SEQUENCE public.teacher_class_id_seq OWNED BY public.teacher_class.id;


--
-- Name: transcript_mark; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.transcript_mark (
    transcript_id bigint NOT NULL,
    mark_id bigint NOT NULL
);


ALTER TABLE public.transcript_mark OWNER TO sa;

--
-- Name: user_role; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.user_role (
    rollnumber character varying(255) NOT NULL,
    id bigint NOT NULL
);


ALTER TABLE public.user_role OWNER TO sa;

--
-- Name: users; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.users (
    roll_number character varying(255) NOT NULL,
    address character varying(255),
    email character varying(255),
    hobbies character varying(255),
    hometown character varying(255),
    lastchangepassword timestamp without time zone,
    mark_average double precision NOT NULL,
    parrent_name character varying(255),
    password character varying(255),
    picture character varying(255),
    status character varying(255),
    username character varying(255),
    ethnic bigint,
    gender bigint,
    religion bigint,
    student_class bigint,
    teacher_roll_number character varying(255),
    teacher_class bigint,
    fullname character varying(255),
    organization bigint,
    deactivetime timestamp without time zone
);


ALTER TABLE public.users OWNER TO sa;

--
-- Name: users_seq; Type: SEQUENCE; Schema: public; Owner: sa
--

CREATE SEQUENCE public.users_seq
    START WITH 1
    INCREMENT BY 50
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_seq OWNER TO sa;

--
-- Name: ward; Type: TABLE; Schema: public; Owner: sa
--

CREATE TABLE public.ward (
    id bigint NOT NULL,
    wardname character varying(255),
    district bigint,
    status character varying(255)
);


ALTER TABLE public.ward OWNER TO sa;

--
-- Name: ward_id_seq; Type: SEQUENCE; Schema: public; Owner: sa
--

CREATE SEQUENCE public.ward_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.ward_id_seq OWNER TO sa;

--
-- Name: ward_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: sa
--

ALTER SEQUENCE public.ward_id_seq OWNED BY public.ward.id;


--
-- Name: change_class id; Type: DEFAULT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.change_class ALTER COLUMN id SET DEFAULT nextval('public.change_class_id_seq'::regclass);


--
-- Name: city id; Type: DEFAULT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.city ALTER COLUMN id SET DEFAULT nextval('public.city_id_seq'::regclass);


--
-- Name: class id; Type: DEFAULT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.class ALTER COLUMN id SET DEFAULT nextval('public.class_id_seq'::regclass);


--
-- Name: district id; Type: DEFAULT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.district ALTER COLUMN id SET DEFAULT nextval('public.district_id_seq'::regclass);


--
-- Name: ethnic id; Type: DEFAULT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.ethnic ALTER COLUMN id SET DEFAULT nextval('public.ethnic_id_seq'::regclass);


--
-- Name: gender id; Type: DEFAULT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.gender ALTER COLUMN id SET DEFAULT nextval('public.gender_id_seq'::regclass);


--
-- Name: mark id; Type: DEFAULT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.mark ALTER COLUMN id SET DEFAULT nextval('public.mark_id_seq'::regclass);


--
-- Name: religion id; Type: DEFAULT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.religion ALTER COLUMN id SET DEFAULT nextval('public.religion_id_seq'::regclass);


--
-- Name: role id; Type: DEFAULT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.role ALTER COLUMN id SET DEFAULT nextval('public.role_id_seq'::regclass);


--
-- Name: semester id; Type: DEFAULT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.semester ALTER COLUMN id SET DEFAULT nextval('public.semester_id_seq'::regclass);


--
-- Name: student_transcript id; Type: DEFAULT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.student_transcript ALTER COLUMN id SET DEFAULT nextval('public.student_transcript_id_seq'::regclass);


--
-- Name: teacher_class id; Type: DEFAULT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.teacher_class ALTER COLUMN id SET DEFAULT nextval('public.teacher_class_id_seq'::regclass);


--
-- Name: ward id; Type: DEFAULT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.ward ALTER COLUMN id SET DEFAULT nextval('public.ward_id_seq'::regclass);


--
-- Data for Name: change_class; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.change_class (id, reason, status, new_class_id, old_class_id, student, teacher, semester) FROM stdin;
1	GPA <= 2.5	reject	3	1	ha0002	\N	1
11	GPA của học sinh không đủ điều kiện	reject	2	1	ha0001	\N	2
10	GPA đủ điều kiện	accept	2	1	ha0002	\N	2
\.


--
-- Data for Name: city; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.city (id, cityname, status) FROM stdin;
1	Thanh pho Hanoi	active
2	Ha Giang	active
4	Cao Bang	active
6	Bac Kan	active
8	Tuyen Quang	active
10	Lao Cai	active
11	Dien Bien	active
12	Lai Chau	active
14	Son La	active
15	Yen Bai	active
17	Hoa Binh	active
19	Thai Nguyen	active
20	Lang Son	active
22	Quang Ninh	active
24	Bac Giang	active
25	Phu Tho	active
26	Vinh Phuc	active
27	Bac Ninh	active
30	Hai Duong	active
31	Thanh Pho Hai Phong	active
33	Hung Yen	active
34	Thai Binh	active
35	Ha Nam	active
36	Nam Dinh	active
37	Ninh Binh	active
38	Thanh Hoa	active
40	Nghe An	active
42	Ha Tinh	active
44	Quang Binh	active
45	Quang Tri	active
46	Thua Thien Hue	active
48	Thanh Pho Da Nang	active
49	Quang Nam	active
51	Quang Ngai	active
52	Binh Dinh	active
54	Phu Yen	active
56	Khanh Hoa	active
58	Ninh Thuan	active
60	Binh Thuan	active
62	Kon Tum	active
64	Gia Lai	active
66	Dak Lak	active
67	Dak Nong	active
68	Lam Dong	active
70	Binh Phuoc	active
72	Tay Ninh	active
74	Binh Duong	active
75	Dong Nai	active
77	Ba Ria - Vung Tau	active
79	Thanh Pho Ho Chi Minh	active
80	Long An	active
82	Tien Giang	active
83	Ben Tre	active
84	Tra Vinh	active
86	Vinh Long	active
87	Dong Thap	active
89	An Giang	active
91	Kien Giang	active
92	Thanh Pho Can Tho	active
93	Hau Giang	active
94	Soc Trang	active
95	Bac Lieu	active
96	Ca Mau	active
97	Other	active
\.


--
-- Data for Name: class; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.class (id, classname, class_organization) FROM stdin;
1	SE1704	2
3	SE1706	2
2	SE1705	2
\.


--
-- Data for Name: district; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.district (id, districname, city, status) FROM stdin;
1	Quận Ba Đình	1	active
2	Quận Hoàn Kiếm	1	active
3	Quận Tây Hồ	1	active
4	Quận Long Biên	1	active
5	Quận Cầu Giấy	1	active
6	Quận Đống Đa	1	active
7	Quận Hai Bà Trưng	1	active
8	Quận Hoàng Mai	1	active
9	Quận Thanh Xuân	1	active
16	Huyện Sóc Sơn	1	active
17	Huyện Đông Anh	1	active
18	Huyện Gia Lâm	1	active
19	Quận Nam Từ Liêm	1	active
20	Huyện Thanh Trì	1	active
21	Quận Bắc Từ Liêm	1	active
250	Huyện Mê Linh	1	active
268	Quận Hà Đông	1	active
269	Thị xã Sơn Tây	1	active
271	Huyện Ba Vì	1	active
272	Huyện Phúc Thọ	1	active
273	Huyện Đan Phượng	1	active
274	Huyện Hoài Đức	1	active
275	Huyện Quốc Oai	1	active
276	Huyện Thạch Thất	1	active
277	Huyện Chương Mỹ	1	active
278	Huyện Thanh Oai	1	active
279	Huyện Thường Tín	1	active
280	Huyện Phú Xuyên	1	active
281	Huyện Ứng Hòa	1	active
282	Huyện Mỹ Đức	1	active
24	Thành phố Hà Giang	2	active
26	Huyện Đồng Văn	2	active
27	Huyện Mèo Vạc	2	active
28	Huyện Yên Minh	2	active
29	Huyện Quản Bạ	2	active
30	Huyện Vị Xuyên	2	active
31	Huyện Bắc Mê	2	active
32	Huyện Hoàng Su Phì	2	active
33	Huyện Xín Mần	2	active
34	Huyện Bắc Quang	2	active
35	Huyện Quang Bình	2	active
40	Thành phố Cao Bằng	4	active
42	Huyện Bảo Lâm	4	active
43	Huyện Bảo Lạc	4	active
45	Huyện Hà Quảng	4	active
47	Huyện Trùng Khánh	4	active
48	Huyện Hạ Lang	4	active
49	Huyện Quảng Hòa	4	active
51	Huyện Hoà An	4	active
52	Huyện Nguyên Bình	4	active
53	Huyện Thạch An	4	active
58	Thành Phố Bắc Kạn	6	active
60	Huyện Pác Nặm	6	active
61	Huyện Ba Bể	6	active
62	Huyện Ngân Sơn	6	active
63	Huyện Bạch Thông	6	active
64	Huyện Chợ Đồn	6	active
65	Huyện Chợ Mới	6	active
66	Huyện Na Rì	6	active
70	Thành phố Tuyên Quang	8	active
71	Huyện Lâm Bình	8	active
72	Huyện Na Hang	8	active
73	Huyện Chiêm Hóa	8	active
74	Huyện Hàm Yên	8	active
75	Huyện Yên Sơn	8	active
76	Huyện Sơn Dương	8	active
80	Thành phố Lào Cai	10	active
82	Huyện Bát Xát	10	active
83	Huyện Mường Khương	10	active
84	Huyện Si Ma Cai	10	active
85	Huyện Bắc Hà	10	active
86	Huyện Bảo Thắng	10	active
87	Huyện Bảo Yên	10	active
88	Thị xã Sa Pa	10	active
89	Huyện Văn Bàn	10	active
94	Thành phố Điện Biên Phủ	11	active
95	Thị Xã Mường Lay	11	active
96	Huyện Mường Nhé	11	active
97	Huyện Mường Chà	11	active
98	Huyện Tủa Chùa	11	active
99	Huyện Tuần Giáo	11	active
100	Huyện Điện Biên	11	active
101	Huyện Điện Biên Đông	11	active
102	Huyện Mường Ảng	11	active
103	Huyện Nậm Pồ	11	active
105	Thành phố Lai Châu	12	active
106	Huyện Tam Đường	12	active
107	Huyện Mường Tè	12	active
108	Huyện Sìn Hồ	12	active
109	Huyện Phong Thổ	12	active
110	Huyện Than Uyên	12	active
111	Huyện Tân Uyên	12	active
112	Huyện Nậm Nhùn	12	active
116	Thành phố Sơn La	14	active
118	Huyện Quỳnh Nhai	14	active
119	Huyện Thuận Châu	14	active
120	Huyện Mường La	14	active
121	Huyện Bắc Yên	14	active
122	Huyện Phù Yên	14	active
123	Huyện Mộc Châu	14	active
124	Huyện Yên Châu	14	active
125	Huyện Mai Sơn	14	active
126	Huyện Sông Mã	14	active
127	Huyện Sốp Cộp	14	active
128	Huyện Vân Hồ	14	active
132	Thành phố Yên Bái	15	active
133	Thị xã Nghĩa Lộ	15	active
135	Huyện Lục Yên	15	active
136	Huyện Văn Yên	15	active
137	Huyện Mù Căng Chải	15	active
138	Huyện Trấn Yên	15	active
139	Huyện Trạm Tấu	15	active
140	Huyện Văn Chấn	15	active
141	Huyện Yên Bình	15	active
148	Thành phố Hòa Bình	17	active
150	Huyện Đà Bắc	17	active
152	Huyện Lương Sơn	17	active
153	Huyện Kim Bôi	17	active
154	Huyện Cao Phong	17	active
155	Huyện Tân Lạc	17	active
156	Huyện Mai Châu	17	active
157	Huyện Lạc Sơn	17	active
158	Huyện Yên Thủy	17	active
159	Huyện Lạc Thủy	17	active
164	Thành phố Thái Nguyên	19	active
165	Thành phố Sông Công	19	active
167	Huyện Định Hóa	19	active
168	Huyện Phú Lương	19	active
169	Huyện Đồng Hỷ	19	active
170	Huyện Võ Nhai	19	active
171	Huyện Đại Từ	19	active
172	Thành phố Phổ Yên	19	active
173	Huyện Phú Bình	19	active
178	Thành phố Lạng Sơn	20	active
180	Huyện Tràng Định	20	active
181	Huyện Bình Gia	20	active
182	Huyện Văn Lãng	20	active
183	Huyện Cao Lộc	20	active
184	Huyện Văn Quan	20	active
185	Huyện Bắc Sơn	20	active
186	Huyện Hữu Lũng	20	active
187	Huyện Chi Lăng	20	active
188	Huyện Lộc Bình	20	active
189	Huyện Đình Lập	20	active
193	Thành phố Hạ Long	22	active
194	Thành phố Móng Cái	22	active
195	Thành phố Cẩm Phả	22	active
196	Thành phố Uông Bí	22	active
198	Huyện Bình Liêu	22	active
199	Huyện Tiên Yên	22	active
200	Huyện Đầm Hà	22	active
201	Huyện Hải Hà	22	active
202	Huyện Ba Chẽ	22	active
203	Huyện Vân Đồn	22	active
205	Thị xã Đông Triều	22	active
206	Thị xã Quảng Yên	22	active
207	Huyện Cô Tô	22	active
213	Thành phố Bắc Giang	24	active
215	Huyện Yên Thế	24	active
216	Huyện Tân Yên	24	active
217	Huyện Lạng Giang	24	active
218	Huyện Lục Nam	24	active
219	Huyện Lục Ngạn	24	active
220	Huyện Sơn Động	24	active
221	Huyện Yên Dũng	24	active
222	Huyện Việt Yên	24	active
223	Huyện Hiệp Hòa	24	active
227	Thành phố Việt Trì	25	active
228	Thị xã Phú Thọ	25	active
230	Huyện Đoan Hùng	25	active
231	Huyện Hạ Hoà	25	active
232	Huyện Thanh Ba	25	active
233	Huyện Phù Ninh	25	active
234	Huyện Yên Lập	25	active
235	Huyện Cẩm Khê	25	active
236	Huyện Tam Nông	25	active
237	Huyện Lâm Thao	25	active
238	Huyện Thanh Sơn	25	active
239	Huyện Thanh Thuỷ	25	active
240	Huyện Tân Sơn	25	active
243	Thành phố Vĩnh Yên	26	active
244	Thành phố Phúc Yên	26	active
246	Huyện Lập Thạch	26	active
247	Huyện Tam Dương	26	active
248	Huyện Tam Đảo	26	active
249	Huyện Bình Xuyên	26	active
251	Huyện Yên Lạc	26	active
252	Huyện Vĩnh Tường	26	active
253	Huyện Sông Lô	26	active
256	Thành phố Bắc Ninh	27	active
258	Huyện Yên Phong	27	active
259	Thị xã Quế Võ	27	active
260	Huyện Tiên Du	27	active
261	Thành phố Từ Sơn	27	active
262	Thị xã Thuận Thành	27	active
263	Huyện Gia Bình	27	active
264	Huyện Lương Tài	27	active
288	Thành phố Hải Dương	30	active
290	Thành phố Chí Linh	30	active
291	Huyện Nam Sách	30	active
292	Thị xã Kinh Môn	30	active
293	Huyện Kim Thành	30	active
294	Huyện Thanh Hà	30	active
295	Huyện Cẩm Giàng	30	active
296	Huyện Bình Giang	30	active
297	Huyện Gia Lộc	30	active
298	Huyện Tứ Kỳ	30	active
299	Huyện Ninh Giang	30	active
300	Huyện Thanh Miện	30	active
303	Quận Hồng Bàng	31	active
304	Quận Ngô Quyền	31	active
305	Quận Lê Chân	31	active
306	Quận Hải An	31	active
307	Quận Kiến An	31	active
308	Quận Đồ Sơn	31	active
309	Quận Dương Kinh	31	active
311	Huyện Thuỷ Nguyên	31	active
312	Huyện An Dương	31	active
313	Huyện An Lão	31	active
314	Huyện Kiến Thuỵ	31	active
315	Huyện Tiên Lãng	31	active
316	Huyện Vĩnh Bảo	31	active
317	Huyện Cát Hải	31	active
318	Huyện Bạch Long Vĩ	31	active
323	Thành phố Hưng Yên	33	active
325	Huyện Văn Lâm	33	active
326	Huyện Văn Giang	33	active
327	Huyện Yên Mỹ	33	active
328	Thị xã Mỹ Hào	33	active
329	Huyện Ân Thi	33	active
330	Huyện Khoái Châu	33	active
331	Huyện Kim Động	33	active
332	Huyện Tiên Lữ	33	active
333	Huyện Phù Cừ	33	active
336	Thành phố Thái Bình	34	active
338	Huyện Quỳnh Phụ	34	active
339	Huyện Hưng Hà	34	active
340	Huyện Đông Hưng	34	active
341	Huyện Thái Thụy	34	active
342	Huyện Tiền Hải	34	active
343	Huyện Kiến Xương	34	active
344	Huyện Vũ Thư	34	active
347	Thành phố Phủ Lý	35	active
349	Thị xã Duy Tiên	35	active
350	Huyện Kim Bảng	35	active
351	Huyện Thanh Liêm	35	active
352	Huyện Bình Lục	35	active
353	Huyện Lý Nhân	35	active
356	Thành phố Nam Định	36	active
358	Huyện Mỹ Lộc	36	active
359	Huyện Vụ Bản	36	active
360	Huyện Ý Yên	36	active
361	Huyện Nghĩa Hưng	36	active
362	Huyện Nam Trực	36	active
363	Huyện Trực Ninh	36	active
364	Huyện Xuân Trường	36	active
365	Huyện Giao Thủy	36	active
366	Huyện Hải Hậu	36	active
369	Thành phố Ninh Bình	37	active
370	Thành phố Tam Điệp	37	active
372	Huyện Nho Quan	37	active
373	Huyện Gia Viễn	37	active
374	Huyện Hoa Lư	37	active
375	Huyện Yên Khánh	37	active
376	Huyện Kim Sơn	37	active
377	Huyện Yên Mô	37	active
380	Thành phố Thanh Hóa	38	active
381	Thị xã Bỉm Sơn	38	active
382	Thành phố Sầm Sơn	38	active
384	Huyện Mường Lát	38	active
385	Huyện Quan Hóa	38	active
386	Huyện Bá Thước	38	active
387	Huyện Quan Sơn	38	active
388	Huyện Lang Chánh	38	active
389	Huyện Ngọc Lặc	38	active
390	Huyện Cẩm Thủy	38	active
391	Huyện Thạch Thành	38	active
392	Huyện Hà Trung	38	active
393	Huyện Vĩnh Lộc	38	active
394	Huyện Yên Định	38	active
395	Huyện Thọ Xuân	38	active
396	Huyện Thường Xuân	38	active
397	Huyện Triệu Sơn	38	active
398	Huyện Thiệu Hóa	38	active
399	Huyện Hoằng Hóa	38	active
400	Huyện Hậu Lộc	38	active
401	Huyện Nga Sơn	38	active
402	Huyện Như Xuân	38	active
403	Huyện Như Thanh	38	active
404	Huyện Nông Cống	38	active
405	Huyện Đông Sơn	38	active
406	Huyện Quảng Xương	38	active
407	Thị xã Nghi Sơn	38	active
412	Thành phố Vinh	40	active
413	Thị xã Cửa Lò	40	active
414	Thị xã Thái Hoà	40	active
415	Huyện Quế Phong	40	active
416	Huyện Quỳ Châu	40	active
417	Huyện Kỳ Sơn	40	active
418	Huyện Tương Dương	40	active
419	Huyện Nghĩa Đàn	40	active
420	Huyện Quỳ Hợp	40	active
421	Huyện Quỳnh Lưu	40	active
422	Huyện Con Cuông	40	active
423	Huyện Tân Kỳ	40	active
424	Huyện Anh Sơn	40	active
425	Huyện Diễn Châu	40	active
426	Huyện Yên Thành	40	active
427	Huyện Đô Lương	40	active
428	Huyện Thanh Chương	40	active
429	Huyện Nghi Lộc	40	active
430	Huyện Nam Đàn	40	active
431	Huyện Hưng Nguyên	40	active
432	Thị xã Hoàng Mai	40	active
436	Thành phố Hà Tĩnh	42	active
437	Thị xã Hồng Lĩnh	42	active
439	Huyện Hương Sơn	42	active
440	Huyện Đức Thọ	42	active
441	Huyện Vũ Quang	42	active
442	Huyện Nghi Xuân	42	active
443	Huyện Can Lộc	42	active
444	Huyện Hương Khê	42	active
445	Huyện Thạch Hà	42	active
446	Huyện Cẩm Xuyên	42	active
447	Huyện Kỳ Anh	42	active
448	Huyện Lộc Hà	42	active
449	Thị xã Kỳ Anh	42	active
450	Thành Phố Đồng Hới	44	active
452	Huyện Minh Hóa	44	active
453	Huyện Tuyên Hóa	44	active
454	Huyện Quảng Trạch	44	active
455	Huyện Bố Trạch	44	active
456	Huyện Quảng Ninh	44	active
457	Huyện Lệ Thủy	44	active
458	Thị xã Ba Đồn	44	active
461	Thành phố Đông Hà	45	active
462	Thị xã Quảng Trị	45	active
464	Huyện Vĩnh Linh	45	active
465	Huyện Hướng Hóa	45	active
466	Huyện Gio Linh	45	active
467	Huyện Đa Krông	45	active
468	Huyện Cam Lộ	45	active
469	Huyện Triệu Phong	45	active
470	Huyện Hải Lăng	45	active
471	Huyện Cồn Cỏ	45	active
474	Thành phố Huế	46	active
476	Huyện Phong Điền	46	active
477	Huyện Quảng Điền	46	active
478	Huyện Phú Vang	46	active
479	Thị xã Hương Thủy	46	active
480	Thị xã Hương Trà	46	active
481	Huyện A Lưới	46	active
482	Huyện Phú Lộc	46	active
483	Huyện Nam Đông	46	active
490	Quận Liên Chiểu	48	active
491	Quận Thanh Khê	48	active
492	Quận Hải Châu	48	active
493	Quận Sơn Trà	48	active
494	Quận Ngũ Hành Sơn	48	active
495	Quận Cẩm Lệ	48	active
497	Huyện Hòa Vang	48	active
498	Huyện Hoàng Sa	48	active
502	Thành phố Tam Kỳ	49	active
503	Thành phố Hội An	49	active
504	Huyện Tây Giang	49	active
505	Huyện Đông Giang	49	active
506	Huyện Đại Lộc	49	active
507	Thị xã Điện Bàn	49	active
508	Huyện Duy Xuyên	49	active
509	Huyện Quế Sơn	49	active
510	Huyện Nam Giang	49	active
511	Huyện Phước Sơn	49	active
512	Huyện Hiệp Đức	49	active
513	Huyện Thăng Bình	49	active
514	Huyện Tiên Phước	49	active
515	Huyện Bắc Trà My	49	active
516	Huyện Nam Trà My	49	active
517	Huyện Núi Thành	49	active
518	Huyện Phú Ninh	49	active
519	Huyện Nông Sơn	49	active
522	Thành phố Quảng Ngãi	51	active
524	Huyện Bình Sơn	51	active
525	Huyện Trà Bồng	51	active
527	Huyện Sơn Tịnh	51	active
528	Huyện Tư Nghĩa	51	active
529	Huyện Sơn Hà	51	active
530	Huyện Sơn Tây	51	active
531	Huyện Minh Long	51	active
532	Huyện Nghĩa Hành	51	active
533	Huyện Mộ Đức	51	active
534	Thị xã Đức Phổ	51	active
535	Huyện Ba Tơ	51	active
536	Huyện Lý Sơn	51	active
540	Thành phố Quy Nhơn	52	active
542	Huyện An Lão	52	active
543	Thị xã Hoài Nhơn	52	active
544	Huyện Hoài Ân	52	active
545	Huyện Phù Mỹ	52	active
546	Huyện Vĩnh Thạnh	52	active
547	Huyện Tây Sơn	52	active
548	Huyện Phù Cát	52	active
549	Thị xã An Nhơn	52	active
550	Huyện Tuy Phước	52	active
551	Huyện Vân Canh	52	active
555	Thành phố Tuy Hoà	54	active
557	Thị xã Sông Cầu	54	active
558	Huyện Đồng Xuân	54	active
559	Huyện Tuy An	54	active
560	Huyện Sơn Hòa	54	active
561	Huyện Sông Hinh	54	active
562	Huyện Tây Hoà	54	active
563	Huyện Phú Hoà	54	active
564	Thị xã Đông Hòa	54	active
568	Thành phố Nha Trang	56	active
569	Thành phố Cam Ranh	56	active
570	Huyện Cam Lâm	56	active
571	Huyện Vạn Ninh	56	active
572	Thị xã Ninh Hòa	56	active
573	Huyện Khánh Vĩnh	56	active
574	Huyện Diên Khánh	56	active
575	Huyện Khánh Sơn	56	active
576	Huyện Trường Sa	56	active
582	Thành phố Phan Rang-Tháp Chàm	58	active
584	Huyện Bác Ái	58	active
585	Huyện Ninh Sơn	58	active
586	Huyện Ninh Hải	58	active
587	Huyện Ninh Phước	58	active
588	Huyện Thuận Bắc	58	active
589	Huyện Thuận Nam	58	active
593	Thành phố Phan Thiết	60	active
594	Thị xã La Gi	60	active
595	Huyện Tuy Phong	60	active
596	Huyện Bắc Bình	60	active
597	Huyện Hàm Thuận Bắc	60	active
598	Huyện Hàm Thuận Nam	60	active
599	Huyện Tánh Linh	60	active
600	Huyện Đức Linh	60	active
601	Huyện Hàm Tân	60	active
602	Huyện Phú Quí	60	active
608	Thành phố Kon Tum	62	active
610	Huyện Đắk Glei	62	active
611	Huyện Ngọc Hồi	62	active
612	Huyện Đắk Tô	62	active
613	Huyện Kon Plông	62	active
614	Huyện Kon Rẫy	62	active
615	Huyện Đắk Hà	62	active
616	Huyện Sa Thầy	62	active
617	Huyện Tu Mơ Rông	62	active
618	Huyện Ia H' Drai	62	active
622	Thành phố Pleiku	64	active
623	Thị xã An Khê	64	active
624	Thị xã Ayun Pa	64	active
625	Huyện KBang	64	active
626	Huyện Đăk Đoa	64	active
627	Huyện Chư Păh	64	active
628	Huyện Ia Grai	64	active
629	Huyện Mang Yang	64	active
630	Huyện Kông Chro	64	active
631	Huyện Đức Cơ	64	active
632	Huyện Chư Prông	64	active
633	Huyện Chư Sê	64	active
634	Huyện Đăk Pơ	64	active
635	Huyện Ia Pa	64	active
637	Huyện Krông Pa	64	active
638	Huyện Phú Thiện	64	active
639	Huyện Chư Pưh	64	active
643	Thành phố Buôn Ma Thuột	66	active
644	Thị Xã Buôn Hồ	66	active
645	Huyện Ea H'leo	66	active
646	Huyện Ea Súp	66	active
647	Huyện Buôn Đôn	66	active
648	Huyện Cư M'gar	66	active
649	Huyện Krông Búk	66	active
650	Huyện Krông Năng	66	active
651	Huyện Ea Kar	66	active
652	Huyện M'Đrắk	66	active
653	Huyện Krông Bông	66	active
654	Huyện Krông Pắc	66	active
655	Huyện Krông A Na	66	active
656	Huyện Lắk	66	active
657	Huyện Cư Kuin	66	active
660	Thành phố Gia Nghĩa	67	active
661	Huyện Đăk Glong	67	active
662	Huyện Cư Jút	67	active
663	Huyện Đắk Mil	67	active
664	Huyện Krông Nô	67	active
665	Huyện Đắk Song	67	active
666	Huyện Đắk R'Lấp	67	active
667	Huyện Tuy Đức	67	active
672	Thành phố Đà Lạt	68	active
673	Thành phố Bảo Lộc	68	active
674	Huyện Đam Rông	68	active
675	Huyện Lạc Dương	68	active
676	Huyện Lâm Hà	68	active
677	Huyện Đơn Dương	68	active
678	Huyện Đức Trọng	68	active
679	Huyện Di Linh	68	active
680	Huyện Bảo Lâm	68	active
681	Huyện Đạ Huoai	68	active
682	Huyện Đạ Tẻh	68	active
683	Huyện Cát Tiên	68	active
688	Thị xã Phước Long	70	active
689	Thành phố Đồng Xoài	70	active
690	Thị xã Bình Long	70	active
691	Huyện Bù Gia Mập	70	active
692	Huyện Lộc Ninh	70	active
693	Huyện Bù Đốp	70	active
694	Huyện Hớn Quản	70	active
695	Huyện Đồng Phú	70	active
696	Huyện Bù Đăng	70	active
697	Thị xã Chơn Thành	70	active
698	Huyện Phú Riềng	70	active
703	Thành phố Tây Ninh	72	active
705	Huyện Tân Biên	72	active
706	Huyện Tân Châu	72	active
707	Huyện Dương Minh Châu	72	active
708	Huyện Châu Thành	72	active
709	Thị xã Hòa Thành	72	active
710	Huyện Gò Dầu	72	active
711	Huyện Bến Cầu	72	active
712	Thị xã Trảng Bàng	72	active
718	Thành phố Thủ Dầu Một	74	active
719	Huyện Bàu Bàng	74	active
720	Huyện Dầu Tiếng	74	active
721	Thị xã Bến Cát	74	active
722	Huyện Phú Giáo	74	active
723	Thị xã Tân Uyên	74	active
724	Thành phố Dĩ An	74	active
725	Thành phố Thuận An	74	active
726	Huyện Bắc Tân Uyên	74	active
731	Thành phố Biên Hòa	75	active
732	Thành phố Long Khánh	75	active
734	Huyện Tân Phú	75	active
735	Huyện Vĩnh Cửu	75	active
736	Huyện Định Quán	75	active
737	Huyện Trảng Bom	75	active
738	Huyện Thống Nhất	75	active
739	Huyện Cẩm Mỹ	75	active
740	Huyện Long Thành	75	active
741	Huyện Xuân Lộc	75	active
742	Huyện Nhơn Trạch	75	active
747	Thành phố Vũng Tàu	77	active
748	Thành phố Bà Rịa	77	active
750	Huyện Châu Đức	77	active
751	Huyện Xuyên Mộc	77	active
752	Huyện Long Điền	77	active
753	Huyện Đất Đỏ	77	active
754	Thị xã Phú Mỹ	77	active
755	Huyện Côn Đảo	77	active
760	Quận 1	79	active
761	Quận 12	79	active
764	Quận Gò Vấp	79	active
765	Quận Bình Thạnh	79	active
766	Quận Tân Bình	79	active
767	Quận Tân Phú	79	active
768	Quận Phú Nhuận	79	active
769	Thành phố Thủ Đức	79	active
770	Quận 3	79	active
771	Quận 10	79	active
772	Quận 11	79	active
773	Quận 4	79	active
774	Quận 5	79	active
775	Quận 6	79	active
776	Quận 8	79	active
777	Quận Bình Tân	79	active
778	Quận 7	79	active
783	Huyện Củ Chi	79	active
784	Huyện Hóc Môn	79	active
785	Huyện Bình Chánh	79	active
786	Huyện Nhà Bè	79	active
787	Huyện Cần Giờ	79	active
794	Thành phố Tân An	80	active
795	Thị xã Kiến Tường	80	active
796	Huyện Tân Hưng	80	active
797	Huyện Vĩnh Hưng	80	active
798	Huyện Mộc Hóa	80	active
799	Huyện Tân Thạnh	80	active
800	Huyện Thạnh Hóa	80	active
801	Huyện Đức Huệ	80	active
802	Huyện Đức Hòa	80	active
803	Huyện Bến Lức	80	active
804	Huyện Thủ Thừa	80	active
805	Huyện Tân Trụ	80	active
806	Huyện Cần Đước	80	active
807	Huyện Cần Giuộc	80	active
808	Huyện Châu Thành	80	active
815	Thành phố Mỹ Tho	82	active
816	Thị xã Gò Công	82	active
817	Thị xã Cai Lậy	82	active
818	Huyện Tân Phước	82	active
819	Huyện Cái Bè	82	active
820	Huyện Cai Lậy	82	active
821	Huyện Châu Thành	82	active
822	Huyện Chợ Gạo	82	active
823	Huyện Gò Công Tây	82	active
824	Huyện Gò Công Đông	82	active
825	Huyện Tân Phú Đông	82	active
829	Thành phố Bến Tre	83	active
831	Huyện Châu Thành	83	active
832	Huyện Chợ Lách	83	active
833	Huyện Mỏ Cày Nam	83	active
834	Huyện Giồng Trôm	83	active
835	Huyện Bình Đại	83	active
836	Huyện Ba Tri	83	active
837	Huyện Thạnh Phú	83	active
838	Huyện Mỏ Cày Bắc	83	active
842	Thành phố Trà Vinh	84	active
844	Huyện Càng Long	84	active
845	Huyện Cầu Kè	84	active
846	Huyện Tiểu Cần	84	active
847	Huyện Châu Thành	84	active
848	Huyện Cầu Ngang	84	active
849	Huyện Trà Cú	84	active
850	Huyện Duyên Hải	84	active
851	Thị xã Duyên Hải	84	active
855	Thành phố Vĩnh Long	86	active
857	Huyện Long Hồ	86	active
858	Huyện Mang Thít	86	active
859	Huyện Vũng Liêm	86	active
860	Huyện Tam Bình	86	active
861	Thị xã Bình Minh	86	active
862	Huyện Trà Ôn	86	active
863	Huyện Bình Tân	86	active
866	Thành phố Cao Lãnh	87	active
867	Thành phố Sa Đéc	87	active
868	Thành phố Hồng Ngự	87	active
869	Huyện Tân Hồng	87	active
870	Huyện Hồng Ngự	87	active
871	Huyện Tam Nông	87	active
872	Huyện Tháp Mười	87	active
873	Huyện Cao Lãnh	87	active
874	Huyện Thanh Bình	87	active
875	Huyện Lấp Vò	87	active
876	Huyện Lai Vung	87	active
877	Huyện Châu Thành	87	active
883	Thành phố Long Xuyên	89	active
884	Thành phố Châu Đốc	89	active
886	Huyện An Phú	89	active
887	Thị xã Tân Châu	89	active
888	Huyện Phú Tân	89	active
889	Huyện Châu Phú	89	active
890	Huyện Tịnh Biên	89	active
891	Huyện Tri Tôn	89	active
892	Huyện Châu Thành	89	active
893	Huyện Chợ Mới	89	active
894	Huyện Thoại Sơn	89	active
899	Thành phố Rạch Giá	91	active
900	Thành phố Hà Tiên	91	active
902	Huyện Kiên Lương	91	active
903	Huyện Hòn Đất	91	active
904	Huyện Tân Hiệp	91	active
905	Huyện Châu Thành	91	active
906	Huyện Giồng Riềng	91	active
907	Huyện Gò Quao	91	active
908	Huyện An Biên	91	active
909	Huyện An Minh	91	active
910	Huyện Vĩnh Thuận	91	active
911	Thành phố Phú Quốc	91	active
912	Huyện Kiên Hải	91	active
913	Huyện U Minh Thượng	91	active
914	Huyện Giang Thành	91	active
916	Quận Ninh Kiều	92	active
917	Quận Ô Môn	92	active
918	Quận Bình Thuỷ	92	active
919	Quận Cái Răng	92	active
923	Quận Thốt Nốt	92	active
924	Huyện Vĩnh Thạnh	92	active
925	Huyện Cờ Đỏ	92	active
926	Huyện Phong Điền	92	active
927	Huyện Thới Lai	92	active
930	Thành phố Vị Thanh	93	active
931	Thành phố Ngã Bảy	93	active
932	Huyện Châu Thành A	93	active
933	Huyện Châu Thành	93	active
934	Huyện Phụng Hiệp	93	active
935	Huyện Vị Thuỷ	93	active
936	Huyện Long Mỹ	93	active
937	Thị xã Long Mỹ	93	active
941	Thành phố Sóc Trăng	94	active
942	Huyện Châu Thành	94	active
943	Huyện Kế Sách	94	active
944	Huyện Mỹ Tú	94	active
945	Huyện Cù Lao Dung	94	active
946	Huyện Long Phú	94	active
947	Huyện Mỹ Xuyên	94	active
948	Thị xã Ngã Năm	94	active
949	Huyện Thạnh Trị	94	active
950	Thị xã Vĩnh Châu	94	active
951	Huyện Trần Đề	94	active
954	Thành phố Bạc Liêu	95	active
956	Huyện Hồng Dân	95	active
957	Huyện Phước Long	95	active
958	Huyện Vĩnh Lợi	95	active
959	Thị xã Giá Rai	95	active
960	Huyện Đông Hải	95	active
961	Huyện Hoà Bình	95	active
964	Thành phố Cà Mau	96	active
966	Huyện U Minh	96	active
967	Huyện Thới Bình	96	active
968	Huyện Trần Văn Thời	96	active
969	Huyện Cái Nước	96	active
970	Huyện Đầm Dơi	96	active
971	Huyện Năm Căn	96	active
972	Huyện Phú Tân	96	active
973	Huyện Ngọc Hiển	96	active
974	Khac	\N	active
\.


--
-- Data for Name: ethnic; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.ethnic (id, ethnic, status) FROM stdin;
7	Muong	active
41	Phu La	active
23	Xtieng	active
6	Khmer	active
38	Laos	active
28	Gie-Trieng	active
12	Ngai	active
45	Chut	active
1	Undefined	active
17	Co-ho	active
44	Lo Lo	active
27	Co-tu	active
51	Si La	active
11	Jarai	active
35	Xinh-mun	active
9	Hmong	active
18	Cham	active
33	Choro	active
19	San Diu	active
50	Bo Y	active
10	Dao	active
8	Nung	active
31	Co	active
21	Mnong	active
42	La Hu	active
39	La chi	active
54	O Du	active
40	La Ha	active
37	Chu-ru	active
52	Pu Peo	active
47	Pa Then	active
13	Ede	active
36	Ha Nhi	active
29	Ma	active
30	Khmu	active
14	Ba-na	active
46	Mang	active
20	Hre	active
4	Thai	active
2	Kinh	active
25	Tho	active
16	San Chay	active
32	Ta-oh	active
34	Resistance	active
3	Tay	active
53	Brau	active
24	Bru-Van Kieu	active
15	Xo-dang	active
48	Co Lao	active
43	Lu	active
5	Hoa	active
26	Giay	active
55	Ro mam	active
49	Cong	active
56	Foreigner	active
22	Raglai	active
\.


--
-- Data for Name: gender; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.gender (id, gender, status) FROM stdin;
1	male	active
2	female	active
3	unknow	active
\.


--
-- Data for Name: mark; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.mark (id, mark, weight) FROM stdin;
1	10	0.1
2	9	0.1
3	10	0.1
4	7	0.2
5	8	0.2
6	9	0.3
19	10	0.1
20	9	0.1
21	8	0.1
25	5	0.1
26	6	0.1
27	7	0.1
28	8	0.2
30	10	0.3
23	7	0.2
22	6	0.2
24	5	0.3
29	7	0.2
55	5	0.1
56	6	0.1
57	7	0.1
58	8	0.2
59	9	0.2
60	10	0.3
61	10	0.1
62	9	0.1
63	8	0.1
64	7	0.2
65	6	0.2
66	5	0.3
67	5	0.1
68	6	0.1
69	7	0.1
70	8	0.2
71	9	0.2
72	10	0.3
73	5	0.1
74	6	0.1
75	7	0.1
76	8	0.2
77	9	0.2
78	10	0.3
\.


--
-- Data for Name: organization; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.organization (id, operatingday, schoolcode, schoolname, status, ward, wardorganization) FROM stdin;
1	\N	\N	\N	active	9988	\N
2	2023-10-16 14:39:34	FPTU	Đại Học FPT	active	\N	1
3	2023-10-24 14:24:25	VNU	Đại Học Quốc Gia	active	\N	1
4	\N	\N	\N	active	280	\N
10877	2023-10-27 10:00:14.222	\N	\N	active	241	\N
5	2023-10-24 00:00:00	NEU	Đại Học Kinh Tế Quốc Dân	active	\N	4
10878	2023-10-30 09:51:50.973	HUST	Đại Học Bách Khoa HN	active	\N	4
10879	2023-10-30 09:53:33.162	\N	\N	active	163	\N
10880	2023-10-30 09:53:33.165	TMU	Đại Học Thương Mại	active	\N	10879
\.


--
-- Data for Name: religion; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.religion (id, religion, status) FROM stdin;
1	Chua xac dinh	active
2	Phat giao	active
3	Cong giao	active
4	Dao Tin lanh	active
5	Dao Cao Dai	active
6	Phat giao Hoa Hao	active
7	Hoi giao	active
8	Ton giao Bahai	active
9	Tinh do Cu si Phat hoi Viet Nam	active
10	Dao Tu An Hieu nghia	active
11	Buu Son Ky Huong	active
12	Giao hoi Phat duong Nam tong Minh su dao	active
13	Hoi thanh Minh Ly dao - Tam Tong Mieu	active
14	Cham Ba la mon	active
15	Giao hoi Cac Thanh huu Ngay sau cua Chua Gie Su Ky to (Mac Mon)	active
16	Ton giao khac	active
17	Khong theo ton giao nao	active
\.


--
-- Data for Name: role; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.role (id, rolename) FROM stdin;
1	student
2	teacher
4	superadmin
3	schooladmin
\.


--
-- Data for Name: semester; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.semester (id, year, semester) FROM stdin;
1	Năm 2023	Học Kỳ 1
2	Năm 2023	Học Kỳ 2
\.


--
-- Data for Name: student_transcript; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.student_transcript (id, semester, student, subject) FROM stdin;
1	1	ha0002	MAE101
2	1	ha0002	PHE101
5	2	ha0002	MAE101
11	2	ha0001	PHE101
12	2	ha0001	CEC101
13	2	ha0001	MAE102
14	1	ha0001	MAE101
\.


--
-- Data for Name: subject; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.subject (subjectcode, status, subjectname) FROM stdin;
MAE101	active	Toán
PHE101	active	Vật lý
CEC101	active	Hóa
HSR101	active	Sử
GEO101	active	Địa
BIO101	active	Sinh
ENG101	active	Tiếng Anh
GDG101	active	Giáo Dục Công Dân
TEC101	active	Công Nghệ
IT101	active	Tin Học
MAE102	active	Toán Học
LTE101	active	Văn
STR101	deactive	Thể Dục
PRN101	active	Programming dotNet 1
\.


--
-- Data for Name: subject_organization; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.subject_organization (subjectcode, organizationid) FROM stdin;
CEC101	2
MAE102	2
MAE101	3
MAE101	2
PHE101	2
PHE101	3
LTE101	2
IT101	3
PRN101	2
\.


--
-- Data for Name: teacher_class; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.teacher_class (id, classid, subjectcode, rollnumber, status) FROM stdin;
8	2	CEC101	ha0003	deactive
9	3	MAE101	ha0001	deactive
10	3	MAE101	ha0001	deactive
11	3	MAE101	ha0001	deactive
12	3	MAE101	ha0001	deactive
13	3	MAE101	ha0003	deactive
14	3	MAE101	ha0003	deactive
16	1	CEC101	ha0001	deactive
17	1	CEC101	ha0001	deactive
15	3	MAE101	ha0003	deactive
18	1	CEC101	ha0001	deactive
19	1	CEC101	ha0001	deactive
20	1	CEC101	ha0001	deactive
21	1	MAE102	ha0001	deactive
1	1	CEC101	ha0001	active
22	1	MAE102	ha0001	active
3	2	MAE101	ha0001	deactive
2	1	PHE101	ha0001	deactive
\.


--
-- Data for Name: transcript_mark; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.transcript_mark (transcript_id, mark_id) FROM stdin;
1	1
1	2
1	3
1	4
1	5
1	6
2	1
2	2
2	3
2	4
2	5
2	6
11	60
11	59
11	58
11	57
11	56
11	55
12	66
12	65
12	64
12	63
12	62
12	61
13	72
13	71
13	70
13	69
13	68
13	67
14	73
14	74
14	75
14	76
14	77
14	78
5	24
5	23
5	22
5	21
5	20
5	19
\.


--
-- Data for Name: user_role; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.user_role (rollnumber, id) FROM stdin;
ha0002	1
ha0001	1
ha0001	2
ha0001	3
he1706	1
ha0006	2
ha0022	1
ha0001	4
ha0003	2
ha0003	1
ha3372	1
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.users (roll_number, address, email, hobbies, hometown, lastchangepassword, mark_average, parrent_name, password, picture, status, username, ethnic, gender, religion, student_class, teacher_roll_number, teacher_class, fullname, organization, deactivetime) FROM stdin;
ha0001	Hà Nội	thanhpche170611@fpt.edu.vn	nothing	Thái Bình	2023-10-18 14:25:45.067	7.966666666666667	Phạm Công Trường	$2a$12$XjEi50pGwMFpZCjkKR0GouQknEqkl6duKL34Y48uLEGXSnqRoDz36	/images/ha0001.png	active	thanh318	2	1	2	1	ha0001	2	Phạm Công Thành	2	\N
ha0006	Hà Nội	gvacc@gmail.com	\N	\N	2023-10-18 16:35:31.745	0	\N	$2a$12$58bjg0yZ8JaYCFULxYG5leYA8/ldKOLhR.1XQg5FB6v5ao4.5uIpm	/images/ha0006.png\n	deactive	thanh999	7	1	2	\N	\N	\N	Student Test	2	2023-10-24 14:48:22.991
ha0003	HN	gvtest@gmail.com	nothing	Thái bình	2023-10-25 09:55:30.952	0	Phạm Công Trường	$2a$12$UnDlh3JE2zIgn3pptCqRtu6L2jyQ6TBkN73UeJVSLREvzHmkwCu4O	/images/ha0003.png	active	thanh234	2	1	2	\N	\N	\N	GV test	3	\N
ha3372	\N	123@gmail.com	\N	\N	2023-10-25 13:57:09.343	0	\N	$2a$12$ChF7YsICqYlL8D9GicKcv.EVJEB1WB37gzL3ZcQfe2vUGMnnYOH2a	\N	deactive	thanh111	7	1	1	\N	\N	\N	\N	5	\N
ha0002	Hà Nội	tpc23072003@gmail.com	game	Thái Bình	2023-10-30 14:18:35.782	7.7	Phạm Công Trường	$2a$12$Y7uZQ25pszPLThxD/V7kG.cfo0Qv89PJnVCTCTdU/QxUGX1ncZgQC	/images/ha0002.png\n	active	thanh123	2	1	2	2	ha0001	\N	Phạm Công Thành	2	\N
he1706	Hà Nội	acctest@gmail.com	\N	\N	2023-10-18 16:29:38.74	0	\N	$2a$12$Q44KP/sjrshtdpab4dsD3ueibamS9IhVb...zokOdHFMR7gStLc4y	/images/he1706.png\n	active	thanh333	7	1	2	\N	\N	\N	Student Test	2	2023-10-19 11:05:24
ha0022	Hà Nội	acctest1@gmail.com	\N	\N	2023-10-18 16:47:30.683	0	\N	$2a$12$pbJqhA5oTVVusT.GbmxuVuTQASUoi.PgehBiKj1seHE8dla.Y1BUm	/images/ha0022.png\n	active	thanh888	7	1	1	\N	\N	\N	Student Test	2	2023-10-19 11:05:28
\.


--
-- Data for Name: ward; Type: TABLE DATA; Schema: public; Owner: sa
--

COPY public.ward (id, wardname, district, status) FROM stdin;
1	Phường Phúc Xá	1	active
4	Phường Trúc Bạch	1	active
6	Phường Vĩnh Phúc	1	active
7	Phường Cống Vị	1	active
8	Phường Liễu Giai	1	active
10	Phường Nguyễn Trung Trực	1	active
13	Phường Quán Thánh	1	active
16	Phường Ngọc Hà	1	active
19	Phường Điện Biên	1	active
22	Phường Đội Cấn	1	active
25	Phường Ngọc Khánh	1	active
28	Phường Kim Mã	1	active
31	Phường Giảng Võ	1	active
34	Phường Thành Công	1	active
37	Phường Phúc Tân	2	active
40	Phường Đồng Xuân	2	active
43	Phường Hàng Mã	2	active
46	Phường Hàng Buồm	2	active
49	Phường Hàng Đào	2	active
52	Phường Hàng Bồ	2	active
55	Phường Cửa Đông	2	active
58	Phường Lý Thái Tổ	2	active
61	Phường Hàng Bạc	2	active
64	Phường Hàng Gai	2	active
67	Phường Chương Dương	2	active
70	Phường Hàng Trống	2	active
73	Phường Cửa Nam	2	active
76	Phường Hàng Bông	2	active
79	Phường Tràng Tiền	2	active
82	Phường Trần Hưng Đạo	2	active
85	Phường Phan Chu Trinh	2	active
88	Phường Hàng Bài	2	active
91	Phường Phú Thượng	3	active
94	Phường Nhật Tân	3	active
97	Phường Tứ Liên	3	active
100	Phường Quảng An	3	active
103	Phường Xuân La	3	active
106	Phường Yên Phụ	3	active
109	Phường Bưởi	3	active
112	Phường Thụy Khuê	3	active
115	Phường Thượng Thanh	4	active
118	Phường Ngọc Thụy	4	active
121	Phường Giang Biên	4	active
124	Phường Đức Giang	4	active
127	Phường Việt Hưng	4	active
130	Phường Gia Thụy	4	active
133	Phường Ngọc Lâm	4	active
136	Phường Phúc Lợi	4	active
139	Phường Bồ Đề	4	active
142	Phường Sài Đồng	4	active
145	Phường Long Biên	4	active
148	Phường Thạch Bàn	4	active
151	Phường Phúc Đồng	4	active
154	Phường Cự Khối	4	active
157	Phường Nghĩa Đô	5	active
160	Phường Nghĩa Tân	5	active
163	Phường Mai Dịch	5	active
166	Phường Dịch Vọng	5	active
167	Phường Dịch Vọng Hậu	5	active
169	Phường Quan Hoa	5	active
172	Phường Yên Hoà	5	active
175	Phường Trung Hoà	5	active
178	Phường Cát Linh	6	active
181	Phường Văn Miếu	6	active
184	Phường Quốc Tử Giám	6	active
187	Phường Láng Thượng	6	active
190	Phường Ô Chợ Dừa	6	active
193	Phường Văn Chương	6	active
196	Phường Hàng Bột	6	active
199	Phường Láng Hạ	6	active
202	Phường Khâm Thiên	6	active
205	Phường Thổ Quan	6	active
208	Phường Nam Đồng	6	active
211	Phường Trung Phụng	6	active
214	Phường Quang Trung	6	active
217	Phường Trung Liệt	6	active
220	Phường Phương Liên	6	active
223	Phường Thịnh Quang	6	active
226	Phường Trung Tự	6	active
229	Phường Kim Liên	6	active
232	Phường Phương Mai	6	active
235	Phường Ngã Tư Sở	6	active
238	Phường Khương Thượng	6	active
241	Phường Nguyễn Du	7	active
244	Phường Bạch Đằng	7	active
247	Phường Phạm Đình Hổ	7	active
256	Phường Lê Đại Hành	7	active
259	Phường Đồng Nhân	7	active
262	Phường Phố Huế	7	active
265	Phường Đống Mác	7	active
268	Phường Thanh Lương	7	active
271	Phường Thanh Nhàn	7	active
274	Phường Cầu Dền	7	active
277	Phường Bách Khoa	7	active
280	Phường Đồng Tâm	7	active
283	Phường Vĩnh Tuy	7	active
286	Phường Bạch Mai	7	active
289	Phường Quỳnh Mai	7	active
292	Phường Quỳnh Lôi	7	active
295	Phường Minh Khai	7	active
298	Phường Trương Định	7	active
301	Phường Thanh Trì	8	active
304	Phường Vĩnh Hưng	8	active
307	Phường Định Công	8	active
310	Phường Mai Động	8	active
313	Phường Tương Mai	8	active
316	Phường Đại Kim	8	active
319	Phường Tân Mai	8	active
322	Phường Hoàng Văn Thụ	8	active
325	Phường Giáp Bát	8	active
328	Phường Lĩnh Nam	8	active
331	Phường Thịnh Liệt	8	active
334	Phường Trần Phú	8	active
337	Phường Hoàng Liệt	8	active
340	Phường Yên Sở	8	active
343	Phường Nhân Chính	9	active
346	Phường Thượng Đình	9	active
349	Phường Khương Trung	9	active
352	Phường Khương Mai	9	active
355	Phường Thanh Xuân Trung	9	active
358	Phường Phương Liệt	9	active
361	Phường Hạ Đình	9	active
364	Phường Khương Đình	9	active
367	Phường Thanh Xuân Bắc	9	active
370	Phường Thanh Xuân Nam	9	active
373	Phường Kim Giang	9	active
376	Thị trấn Sóc Sơn	16	active
379	Xã Bắc Sơn	16	active
382	Xã Minh Trí	16	active
385	Xã Hồng Kỳ	16	active
388	Xã Nam Sơn	16	active
391	Xã Trung Giã	16	active
394	Xã Tân Hưng	16	active
397	Xã Minh Phú	16	active
400	Xã Phù Linh	16	active
403	Xã Bắc Phú	16	active
406	Xã Tân Minh	16	active
409	Xã Quang Tiến	16	active
412	Xã Hiền Ninh	16	active
415	Xã Tân Dân	16	active
418	Xã Tiên Dược	16	active
421	Xã Việt Long	16	active
424	Xã Xuân Giang	16	active
427	Xã Mai Đình	16	active
430	Xã Đức Hoà	16	active
433	Xã Thanh Xuân	16	active
436	Xã Đông Xuân	16	active
439	Xã Kim Lũ	16	active
442	Xã Phú Cường	16	active
445	Xã Phú Minh	16	active
448	Xã Phù Lỗ	16	active
451	Xã Xuân Thu	16	active
454	Thị trấn Đông Anh	17	active
457	Xã Xuân Nộn	17	active
460	Xã Thuỵ Lâm	17	active
463	Xã Bắc Hồng	17	active
466	Xã Nguyên Khê	17	active
469	Xã Nam Hồng	17	active
472	Xã Tiên Dương	17	active
475	Xã Vân Hà	17	active
478	Xã Uy Nỗ	17	active
481	Xã Vân Nội	17	active
484	Xã Liên Hà	17	active
487	Xã Việt Hùng	17	active
490	Xã Kim Nỗ	17	active
493	Xã Kim Chung	17	active
496	Xã Dục Tú	17	active
499	Xã Đại Mạch	17	active
502	Xã Vĩnh Ngọc	17	active
505	Xã Cổ Loa	17	active
508	Xã Hải Bối	17	active
511	Xã Xuân Canh	17	active
514	Xã Võng La	17	active
517	Xã Tàm Xá	17	active
520	Xã Mai Lâm	17	active
523	Xã Đông Hội	17	active
526	Thị trấn Yên Viên	18	active
529	Xã Yên Thường	18	active
532	Xã Yên Viên	18	active
535	Xã Ninh Hiệp	18	active
538	Xã Đình Xuyên	18	active
541	Xã Dương Hà	18	active
544	Xã Phù Đổng	18	active
547	Xã Trung Mầu	18	active
550	Xã Lệ Chi	18	active
553	Xã Cổ Bi	18	active
556	Xã Đặng Xá	18	active
559	Xã Phú Thị	18	active
562	Xã Kim Sơn	18	active
565	Thị trấn Trâu Quỳ	18	active
568	Xã Dương Quang	18	active
571	Xã Dương Xá	18	active
574	Xã Đông Dư	18	active
577	Xã Đa Tốn	18	active
580	Xã Kiêu Kỵ	18	active
583	Xã Bát Tràng	18	active
586	Xã Kim Lan	18	active
589	Xã Văn Đức	18	active
592	Phường Cầu Diễn	19	active
622	Phường Xuân Phương	19	active
623	Phường Phương Canh	19	active
625	Phường Mỹ Đình 1	19	active
626	Phường Mỹ Đình 2	19	active
628	Phường Tây Mỗ	19	active
631	Phường Mễ Trì	19	active
632	Phường Phú Đô	19	active
634	Phường Đại Mỗ	19	active
637	Phường Trung Văn	19	active
640	Thị trấn Văn Điển	20	active
643	Xã Tân Triều	20	active
646	Xã Thanh Liệt	20	active
649	Xã Tả Thanh Oai	20	active
652	Xã Hữu Hoà	20	active
655	Xã Tam Hiệp	20	active
658	Xã Tứ Hiệp	20	active
661	Xã Yên Mỹ	20	active
664	Xã Vĩnh Quỳnh	20	active
667	Xã Ngũ Hiệp	20	active
670	Xã Duyên Hà	20	active
673	Xã Ngọc Hồi	20	active
676	Xã Vạn Phúc	20	active
679	Xã Đại áng	20	active
682	Xã Liên Ninh	20	active
685	Xã Đông Mỹ	20	active
595	Phường Thượng Cát	21	active
598	Phường Liên Mạc	21	active
601	Phường Đông Ngạc	21	active
602	Phường Đức Thắng	21	active
604	Phường Thụy Phương	21	active
607	Phường Tây Tựu	21	active
610	Phường Xuân Đỉnh	21	active
611	Phường Xuân Tảo	21	active
613	Phường Minh Khai	21	active
616	Phường Cổ Nhuế 1	21	active
617	Phường Cổ Nhuế 2	21	active
619	Phường Phú Diễn	21	active
620	Phường Phúc Diễn	21	active
8973	Thị trấn Chi Đông	250	active
8974	Xã Đại Thịnh	250	active
8977	Xã Kim Hoa	250	active
8980	Xã Thạch Đà	250	active
8983	Xã Tiến Thắng	250	active
8986	Xã Tự Lập	250	active
8989	Thị trấn Quang Minh	250	active
8992	Xã Thanh Lâm	250	active
8995	Xã Tam Đồng	250	active
8998	Xã Liên Mạc	250	active
9001	Xã Vạn Yên	250	active
9004	Xã Chu Phan	250	active
9007	Xã Tiến Thịnh	250	active
9010	Xã Mê Linh	250	active
9013	Xã Văn Khê	250	active
9016	Xã Hoàng Kim	250	active
9019	Xã Tiền Phong	250	active
9022	Xã Tráng Việt	250	active
9538	Phường Nguyễn Trãi	268	active
9541	Phường Mộ Lao	268	active
9542	Phường Văn Quán	268	active
9544	Phường Vạn Phúc	268	active
9547	Phường Yết Kiêu	268	active
9550	Phường Quang Trung	268	active
9551	Phường La Khê	268	active
9552	Phường Phú La	268	active
9553	Phường Phúc La	268	active
9556	Phường Hà Cầu	268	active
9562	Phường Yên Nghĩa	268	active
9565	Phường Kiến Hưng	268	active
9568	Phường Phú Lãm	268	active
9571	Phường Phú Lương	268	active
9886	Phường Dương Nội	268	active
10117	Phường Đồng Mai	268	active
10123	Phường Biên Giang	268	active
9574	Phường Lê Lợi	269	active
9577	Phường Phú Thịnh	269	active
9580	Phường Ngô Quyền	269	active
9583	Phường Quang Trung	269	active
9586	Phường Sơn Lộc	269	active
9589	Phường Xuân Khanh	269	active
9592	Xã Đường Lâm	269	active
9595	Phường Viên Sơn	269	active
9598	Xã Xuân Sơn	269	active
9601	Phường Trung Hưng	269	active
9604	Xã Thanh Mỹ	269	active
9607	Phường Trung Sơn Trầm	269	active
9610	Xã Kim Sơn	269	active
9613	Xã Sơn Đông	269	active
9616	Xã Cổ Đông	269	active
9619	Thị trấn Tây Đằng	271	active
9625	Xã Phú Cường	271	active
9628	Xã Cổ Đô	271	active
9631	Xã Tản Hồng	271	active
9634	Xã Vạn Thắng	271	active
9637	Xã Châu Sơn	271	active
9640	Xã Phong Vân	271	active
9643	Xã Phú Đông	271	active
9646	Xã Phú Phương	271	active
9649	Xã Phú Châu	271	active
9652	Xã Thái Hòa	271	active
9655	Xã Đồng Thái	271	active
9658	Xã Phú Sơn	271	active
9661	Xã Minh Châu	271	active
9664	Xã Vật Lại	271	active
9667	Xã Chu Minh	271	active
9670	Xã Tòng Bạt	271	active
9673	Xã Cẩm Lĩnh	271	active
9676	Xã Sơn Đà	271	active
9679	Xã Đông Quang	271	active
9682	Xã Tiên Phong	271	active
9685	Xã Thụy An	271	active
9688	Xã Cam Thượng	271	active
9691	Xã Thuần Mỹ	271	active
9694	Xã Tản Lĩnh	271	active
9697	Xã Ba Trại	271	active
9700	Xã Minh Quang	271	active
9703	Xã Ba Vì	271	active
9706	Xã Vân Hòa	271	active
9709	Xã Yên Bài	271	active
9712	Xã Khánh Thượng	271	active
9715	Thị trấn Phúc Thọ	272	active
9718	Xã Vân Hà	272	active
9721	Xã Vân Phúc	272	active
9724	Xã Vân Nam	272	active
9727	Xã Xuân Đình	272	active
9733	Xã Sen Phương	272	active
9739	Xã Võng Xuyên	272	active
9742	Xã Thọ Lộc	272	active
9745	Xã Long Xuyên	272	active
9748	Xã Thượng Cốc	272	active
9751	Xã Hát Môn	272	active
9754	Xã Tích Giang	272	active
9757	Xã Thanh Đa	272	active
9760	Xã Trạch Mỹ Lộc	272	active
9763	Xã Phúc Hòa	272	active
9766	Xã Ngọc Tảo	272	active
9769	Xã Phụng Thượng	272	active
9772	Xã Tam Thuấn	272	active
9775	Xã Tam Hiệp	272	active
9778	Xã Hiệp Thuận	272	active
9781	Xã Liên Hiệp	272	active
9784	Thị trấn Phùng	273	active
9787	Xã Trung Châu	273	active
9790	Xã Thọ An	273	active
9793	Xã Thọ Xuân	273	active
9796	Xã Hồng Hà	273	active
9799	Xã Liên Hồng	273	active
9802	Xã Liên Hà	273	active
9805	Xã Hạ Mỗ	273	active
9808	Xã Liên Trung	273	active
9811	Xã Phương Đình	273	active
9814	Xã Thượng Mỗ	273	active
9817	Xã Tân Hội	273	active
9820	Xã Tân Lập	273	active
9823	Xã Đan Phượng	273	active
9826	Xã Đồng Tháp	273	active
9829	Xã Song Phượng	273	active
9832	Thị trấn Trạm Trôi	274	active
9835	Xã Đức Thượng	274	active
9838	Xã Minh Khai	274	active
9841	Xã Dương Liễu	274	active
9844	Xã Di Trạch	274	active
9847	Xã Đức Giang	274	active
9850	Xã Cát Quế	274	active
9853	Xã Kim Chung	274	active
9856	Xã Yên Sở	274	active
9859	Xã Sơn Đồng	274	active
9862	Xã Vân Canh	274	active
9865	Xã Đắc Sở	274	active
9868	Xã Lại Yên	274	active
9871	Xã Tiền Yên	274	active
9874	Xã Song Phương	274	active
9877	Xã An Khánh	274	active
9880	Xã An Thượng	274	active
9883	Xã Vân Côn	274	active
9889	Xã La Phù	274	active
9892	Xã Đông La	274	active
4939	Xã Đông Xuân	275	active
9895	Thị trấn Quốc Oai	275	active
9898	Xã Sài Sơn	275	active
9901	Xã Phượng Cách	275	active
9904	Xã Yên Sơn	275	active
9907	Xã Ngọc Liệp	275	active
9910	Xã Ngọc Mỹ	275	active
9913	Xã Liệp Tuyết	275	active
9916	Xã Thạch Thán	275	active
9919	Xã Đồng Quang	275	active
9922	Xã Phú Cát	275	active
9925	Xã Tuyết Nghĩa	275	active
9928	Xã Nghĩa Hương	275	active
9931	Xã Cộng Hòa	275	active
9934	Xã Tân Phú	275	active
9937	Xã Đại Thành	275	active
9940	Xã Phú Mãn	275	active
9943	Xã Cấn Hữu	275	active
9946	Xã Tân Hòa	275	active
9949	Xã Hòa Thạch	275	active
9952	Xã Đông Yên	275	active
4927	Xã Yên Trung	276	active
4930	Xã Yên Bình	276	active
4936	Xã Tiến Xuân	276	active
9955	Thị trấn Liên Quan	276	active
9958	Xã Đại Đồng	276	active
9961	Xã Cẩm Yên	276	active
9964	Xã Lại Thượng	276	active
9967	Xã Phú Kim	276	active
9970	Xã Hương Ngải	276	active
9973	Xã Canh Nậu	276	active
9976	Xã Kim Quan	276	active
9979	Xã Dị Nậu	276	active
9982	Xã Bình Yên	276	active
9985	Xã Chàng Sơn	276	active
9988	Xã Thạch Hoà	276	active
9991	Xã Cần Kiệm	276	active
9994	Xã Hữu Bằng	276	active
9997	Xã Phùng Xá	276	active
10000	Xã Tân Xã	276	active
10003	Xã Thạch Xá	276	active
10006	Xã Bình Phú	276	active
10009	Xã Hạ Bằng	276	active
10012	Xã Đồng Trúc	276	active
10015	Thị trấn Chúc Sơn	277	active
10018	Thị trấn Xuân Mai	277	active
10021	Xã Phụng Châu	277	active
10024	Xã Tiên Phương	277	active
10027	Xã Đông Sơn	277	active
10030	Xã Đông Phương Yên	277	active
10033	Xã Phú Nghĩa	277	active
10039	Xã Trường Yên	277	active
10042	Xã Ngọc Hòa	277	active
10045	Xã Thủy Xuân Tiên	277	active
10048	Xã Thanh Bình	277	active
10051	Xã Trung Hòa	277	active
10054	Xã Đại Yên	277	active
10057	Xã Thụy Hương	277	active
10060	Xã Tốt Động	277	active
10063	Xã Lam Điền	277	active
10066	Xã Tân Tiến	277	active
10069	Xã Nam Phương Tiến	277	active
10072	Xã Hợp Đồng	277	active
10075	Xã Hoàng Văn Thụ	277	active
10078	Xã Hoàng Diệu	277	active
10081	Xã Hữu Văn	277	active
10084	Xã Quảng Bị	277	active
10087	Xã Mỹ Lương	277	active
10090	Xã Thượng Vực	277	active
10093	Xã Hồng Phong	277	active
10096	Xã Đồng Phú	277	active
10099	Xã Trần Phú	277	active
10102	Xã Văn Võ	277	active
10105	Xã Đồng Lạc	277	active
10108	Xã Hòa Chính	277	active
10111	Xã Phú Nam An	277	active
10114	Thị trấn Kim Bài	278	active
10120	Xã Cự Khê	278	active
10126	Xã Bích Hòa	278	active
10129	Xã Mỹ Hưng	278	active
10132	Xã Cao Viên	278	active
10135	Xã Bình Minh	278	active
10138	Xã Tam Hưng	278	active
10141	Xã Thanh Cao	278	active
10144	Xã Thanh Thùy	278	active
10147	Xã Thanh Mai	278	active
10150	Xã Thanh Văn	278	active
10153	Xã Đỗ Động	278	active
10156	Xã Kim An	278	active
10159	Xã Kim Thư	278	active
10162	Xã Phương Trung	278	active
10165	Xã Tân Ước	278	active
10168	Xã Dân Hòa	278	active
10171	Xã Liên Châu	278	active
10174	Xã Cao Dương	278	active
10177	Xã Xuân Dương	278	active
10180	Xã Hồng Dương	278	active
10183	Thị trấn Thường Tín	279	active
10186	Xã Ninh Sở	279	active
10189	Xã Nhị Khê	279	active
10192	Xã Duyên Thái	279	active
10195	Xã Khánh Hà	279	active
10198	Xã Hòa Bình	279	active
10201	Xã Văn Bình	279	active
10204	Xã Hiền Giang	279	active
10207	Xã Hồng Vân	279	active
10210	Xã Vân Tảo	279	active
10213	Xã Liên Phương	279	active
10216	Xã Văn Phú	279	active
10219	Xã Tự Nhiên	279	active
10222	Xã Tiền Phong	279	active
10225	Xã Hà Hồi	279	active
10228	Xã Thư Phú	279	active
10231	Xã Nguyễn Trãi	279	active
10234	Xã Quất Động	279	active
10237	Xã Chương Dương	279	active
10240	Xã Tân Minh	279	active
10243	Xã Lê Lợi	279	active
10246	Xã Thắng Lợi	279	active
10249	Xã Dũng Tiến	279	active
10252	Xã Thống Nhất	279	active
10255	Xã Nghiêm Xuyên	279	active
10258	Xã Tô Hiệu	279	active
10261	Xã Văn Tự	279	active
10264	Xã Vạn Điểm	279	active
10267	Xã Minh Cường	279	active
10270	Thị trấn Phú Minh	280	active
10273	Thị trấn Phú Xuyên	280	active
10276	Xã Hồng Minh	280	active
10279	Xã Phượng Dực	280	active
10282	Xã Nam Tiến	280	active
10288	Xã Tri Trung	280	active
10291	Xã Đại Thắng	280	active
10294	Xã Phú Túc	280	active
10297	Xã Văn Hoàng	280	active
10300	Xã Hồng Thái	280	active
10303	Xã Hoàng Long	280	active
10306	Xã Quang Trung	280	active
10309	Xã Nam Phong	280	active
10312	Xã Nam Triều	280	active
10315	Xã Tân Dân	280	active
10318	Xã Sơn Hà	280	active
10321	Xã Chuyên Mỹ	280	active
10324	Xã Khai Thái	280	active
10327	Xã Phúc Tiến	280	active
10330	Xã Vân Từ	280	active
10333	Xã Tri Thủy	280	active
10336	Xã Đại Xuyên	280	active
10339	Xã Phú Yên	280	active
10342	Xã Bạch Hạ	280	active
10345	Xã Quang Lãng	280	active
10348	Xã Châu Can	280	active
10351	Xã Minh Tân	280	active
10354	Thị trấn Vân Đình	281	active
10357	Xã Viên An	281	active
10360	Xã Viên Nội	281	active
10363	Xã Hoa Sơn	281	active
10366	Xã Quảng Phú Cầu	281	active
10369	Xã Trường Thịnh	281	active
10372	Xã Cao Thành	281	active
10375	Xã Liên Bạt	281	active
10378	Xã Sơn Công	281	active
10381	Xã Đồng Tiến	281	active
10384	Xã Phương Tú	281	active
10387	Xã Trung Tú	281	active
10390	Xã Đồng Tân	281	active
10393	Xã Tảo Dương Văn	281	active
10396	Xã Vạn Thái	281	active
10399	Xã Minh Đức	281	active
10402	Xã Hòa Lâm	281	active
10405	Xã Hòa Xá	281	active
10408	Xã Trầm Lộng	281	active
10411	Xã Kim Đường	281	active
10414	Xã Hòa Nam	281	active
10417	Xã Hòa Phú	281	active
10420	Xã Đội Bình	281	active
10423	Xã Đại Hùng	281	active
10426	Xã Đông Lỗ	281	active
10429	Xã Phù Lưu	281	active
10432	Xã Đại Cường	281	active
10435	Xã Lưu Hoàng	281	active
10438	Xã Hồng Quang	281	active
10441	Thị trấn Đại Nghĩa	282	active
10444	Xã Đồng Tâm	282	active
10447	Xã Thượng Lâm	282	active
10450	Xã Tuy Lai	282	active
10453	Xã Phúc Lâm	282	active
10456	Xã Mỹ Thành	282	active
10459	Xã Bột Xuyên	282	active
10462	Xã An Mỹ	282	active
10465	Xã Hồng Sơn	282	active
10468	Xã Lê Thanh	282	active
10471	Xã Xuy Xá	282	active
10474	Xã Phùng Xá	282	active
10477	Xã Phù Lưu Tế	282	active
10480	Xã Đại Hưng	282	active
10483	Xã Vạn Kim	282	active
10486	Xã Đốc Tín	282	active
10489	Xã Hương Sơn	282	active
10492	Xã Hùng Tiến	282	active
10495	Xã An Tiến	282	active
10498	Xã Hợp Tiến	282	active
10501	Xã Hợp Thanh	282	active
10504	Xã An Phú	282	active
688	Phường Quang Trung	24	active
691	Phường Trần Phú	24	active
692	Phường Ngọc Hà	24	active
694	Phường Nguyễn Trãi	24	active
697	Phường Minh Khai	24	active
700	Xã Ngọc Đường	24	active
946	Xã Phương Độ	24	active
949	Xã Phương Thiện	24	active
712	Thị trấn Phó Bảng	26	active
715	Xã Lũng Cú	26	active
718	Xã Má Lé	26	active
721	Thị trấn Đồng Văn	26	active
724	Xã Lũng Táo	26	active
727	Xã Phố Là	26	active
730	Xã Thài Phìn Tủng	26	active
733	Xã Sủng Là	26	active
736	Xã Xà Phìn	26	active
739	Xã Tả Phìn	26	active
742	Xã Tả Lủng	26	active
745	Xã Phố Cáo	26	active
748	Xã Sính Lủng	26	active
751	Xã Sảng Tủng	26	active
754	Xã Lũng Thầu	26	active
757	Xã Hố Quáng Phìn	26	active
760	Xã Vần Chải	26	active
763	Xã Lũng Phìn	26	active
766	Xã Sủng Trái	26	active
769	Thị trấn Mèo Vạc	27	active
772	Xã Thượng Phùng	27	active
775	Xã Pải Lủng	27	active
778	Xã Xín Cái	27	active
781	Xã Pả Vi	27	active
784	Xã Giàng Chu Phìn	27	active
787	Xã Sủng Trà	27	active
790	Xã Sủng Máng	27	active
793	Xã Sơn Vĩ	27	active
796	Xã Tả Lủng	27	active
799	Xã Cán Chu Phìn	27	active
802	Xã Lũng Pù	27	active
805	Xã Lũng Chinh	27	active
808	Xã Tát Ngà	27	active
811	Xã Nậm Ban	27	active
814	Xã Khâu Vai	27	active
815	Xã Niêm Tòng	27	active
817	Xã Niêm Sơn	27	active
820	Thị trấn Yên Minh	28	active
823	Xã Thắng Mố	28	active
826	Xã Phú Lũng	28	active
829	Xã Sủng Tráng	28	active
832	Xã Bạch Đích	28	active
835	Xã Na Khê	28	active
838	Xã Sủng Thài	28	active
841	Xã Hữu Vinh	28	active
844	Xã Lao Và Chải	28	active
847	Xã Mậu Duệ	28	active
850	Xã Đông Minh	28	active
853	Xã Mậu Long	28	active
856	Xã Ngam La	28	active
859	Xã Ngọc Long	28	active
862	Xã Đường Thượng	28	active
865	Xã Lũng Hồ	28	active
868	Xã Du Tiến	28	active
871	Xã Du Già	28	active
874	Thị trấn Tam Sơn	29	active
877	Xã Bát Đại Sơn	29	active
880	Xã Nghĩa Thuận	29	active
883	Xã Cán Tỷ	29	active
886	Xã Cao Mã Pờ	29	active
889	Xã Thanh Vân	29	active
892	Xã Tùng Vài	29	active
895	Xã Đông Hà	29	active
898	Xã Quản Bạ	29	active
901	Xã Lùng Tám	29	active
904	Xã Quyết Tiến	29	active
907	Xã Tả Ván	29	active
910	Xã Thái An	29	active
703	Xã Kim Thạch	30	active
706	Xã Phú Linh	30	active
709	Xã Kim Linh	30	active
913	Thị trấn Vị Xuyên	30	active
916	Thị trấn Nông Trường Việt Lâm	30	active
919	Xã Minh Tân	30	active
922	Xã Thuận Hoà	30	active
925	Xã Tùng Bá	30	active
928	Xã Thanh Thủy	30	active
931	Xã Thanh Đức	30	active
934	Xã Phong Quang	30	active
937	Xã Xín Chải	30	active
940	Xã Phương Tiến	30	active
943	Xã Lao Chải	30	active
952	Xã Cao Bồ	30	active
955	Xã Đạo Đức	30	active
958	Xã Thượng Sơn	30	active
961	Xã Linh Hồ	30	active
964	Xã Quảng Ngần	30	active
967	Xã Việt Lâm	30	active
970	Xã Ngọc Linh	30	active
973	Xã Ngọc Minh	30	active
976	Xã Bạch Ngọc	30	active
979	Xã Trung Thành	30	active
982	Xã Minh Sơn	31	active
985	Xã Giáp Trung	31	active
988	Xã Yên Định	31	active
991	Thị trấn Yên Phú	31	active
994	Xã Minh Ngọc	31	active
997	Xã Yên Phong	31	active
1000	Xã Lạc Nông	31	active
1003	Xã Phú Nam	31	active
1006	Xã Yên Cường	31	active
1009	Xã Thượng Tân	31	active
1012	Xã Đường Âm	31	active
1015	Xã Đường Hồng	31	active
1018	Xã Phiêng Luông	31	active
1021	Thị trấn Vinh Quang	32	active
1024	Xã Bản Máy	32	active
1027	Xã Thàng Tín	32	active
1030	Xã Thèn Chu Phìn	32	active
1033	Xã Pố Lồ	32	active
1036	Xã Bản Phùng	32	active
1039	Xã Túng Sán	32	active
1042	Xã Chiến Phố	32	active
1045	Xã Đản Ván	32	active
1048	Xã Tụ Nhân	32	active
1051	Xã Tân Tiến	32	active
1054	Xã Nàng Đôn	32	active
1057	Xã Pờ Ly Ngài	32	active
1060	Xã Sán Xả Hồ	32	active
1063	Xã Bản Luốc	32	active
1066	Xã Ngàm Đăng Vài	32	active
1069	Xã Bản Nhùng	32	active
1072	Xã Tả Sử Choóng	32	active
1075	Xã Nậm Dịch	32	active
1081	Xã Hồ Thầu	32	active
1084	Xã Nam Sơn	32	active
1087	Xã Nậm Tỵ	32	active
1090	Xã Thông Nguyên	32	active
1093	Xã Nậm Khòa	32	active
1096	Thị trấn Cốc Pài	33	active
1099	Xã Nàn Xỉn	33	active
1102	Xã Bản Díu	33	active
1105	Xã Chí Cà	33	active
1108	Xã Xín Mần	33	active
1114	Xã Thèn Phàng	33	active
1117	Xã Trung Thịnh	33	active
1120	Xã Pà Vầy Sủ	33	active
1123	Xã Cốc Rế	33	active
1126	Xã Thu Tà	33	active
1129	Xã Nàn Ma	33	active
1132	Xã Tả Nhìu	33	active
1135	Xã Bản Ngò	33	active
1138	Xã Chế Là	33	active
1141	Xã Nấm Dẩn	33	active
1144	Xã Quảng Nguyên	33	active
1147	Xã Nà Chì	33	active
1150	Xã Khuôn Lùng	33	active
1153	Thị trấn Việt Quang	34	active
1156	Thị trấn Vĩnh Tuy	34	active
1159	Xã Tân Lập	34	active
1162	Xã Tân Thành	34	active
1165	Xã Đồng Tiến	34	active
1168	Xã Đồng Tâm	34	active
1171	Xã Tân Quang	34	active
1174	Xã Thượng Bình	34	active
1177	Xã Hữu Sản	34	active
1180	Xã Kim Ngọc	34	active
1183	Xã Việt Vinh	34	active
1186	Xã Bằng Hành	34	active
1189	Xã Quang Minh	34	active
1192	Xã Liên Hiệp	34	active
1195	Xã Vô Điếm	34	active
1198	Xã Việt Hồng	34	active
1201	Xã Hùng An	34	active
1204	Xã Đức Xuân	34	active
1207	Xã Tiên Kiều	34	active
1210	Xã Vĩnh Hảo	34	active
1213	Xã Vĩnh Phúc	34	active
1216	Xã Đồng Yên	34	active
1219	Xã Đông Thành	34	active
1222	Xã Xuân Minh	35	active
1225	Xã Tiên Nguyên	35	active
1228	Xã Tân Nam	35	active
1231	Xã Bản Rịa	35	active
1234	Xã Yên Thành	35	active
1237	Thị trấn Yên Bình	35	active
1240	Xã Tân Trịnh	35	active
1243	Xã Tân Bắc	35	active
1246	Xã Bằng Lang	35	active
1249	Xã Yên Hà	35	active
1252	Xã Hương Sơn	35	active
1255	Xã Xuân Giang	35	active
1258	Xã Nà Khương	35	active
1261	Xã Tiên Yên	35	active
1264	Xã Vĩ Thượng	35	active
1267	Phường Sông Hiến	40	active
1270	Phường Sông Bằng	40	active
1273	Phường Hợp Giang	40	active
1276	Phường Tân Giang	40	active
1279	Phường Ngọc Xuân	40	active
1282	Phường Đề Thám	40	active
1285	Phường Hoà Chung	40	active
1288	Phường Duyệt Trung	40	active
1693	Xã Vĩnh Quang	40	active
1705	Xã Hưng Đạo	40	active
1720	Xã Chu Trinh	40	active
1290	Thị trấn Pác Miầu	42	active
1291	Xã Đức Hạnh	42	active
1294	Xã Lý Bôn	42	active
1296	Xã Nam Cao	42	active
1297	Xã Nam Quang	42	active
1300	Xã Vĩnh Quang	42	active
1303	Xã Quảng Lâm	42	active
1304	Xã Thạch Lâm	42	active
1309	Xã Vĩnh Phong	42	active
1312	Xã Mông Ân	42	active
1315	Xã Thái Học	42	active
1316	Xã Thái Sơn	42	active
1318	Xã Yên Thổ	42	active
1321	Thị trấn Bảo Lạc	43	active
1324	Xã Cốc Pàng	43	active
1327	Xã Thượng Hà	43	active
1330	Xã Cô Ba	43	active
1333	Xã Bảo Toàn	43	active
1336	Xã Khánh Xuân	43	active
1339	Xã Xuân Trường	43	active
1342	Xã Hồng Trị	43	active
1343	Xã Kim Cúc	43	active
1345	Xã Phan Thanh	43	active
1348	Xã Hồng An	43	active
1351	Xã Hưng Đạo	43	active
1352	Xã Hưng Thịnh	43	active
1354	Xã Huy Giáp	43	active
1357	Xã Đình Phùng	43	active
1359	Xã Sơn Lập	43	active
1360	Xã Sơn Lộ	43	active
1363	Thị trấn Thông Nông	45	active
1366	Xã Cần Yên	45	active
1367	Xã Cần Nông	45	active
1372	Xã Lương Thông	45	active
1375	Xã Đa Thông	45	active
1378	Xã Ngọc Động	45	active
1381	Xã Yên Sơn	45	active
1384	Xã Lương Can	45	active
1387	Xã Thanh Long	45	active
1392	Thị trấn Xuân Hòa	45	active
1393	Xã Lũng Nặm	45	active
1399	Xã Trường Hà	45	active
1402	Xã Cải Viên	45	active
1411	Xã Nội Thôn	45	active
1414	Xã Tổng Cọt	45	active
1417	Xã Sóc Hà	45	active
1420	Xã Thượng Thôn	45	active
1429	Xã Hồng Sỹ	45	active
1432	Xã Quý Quân	45	active
1435	Xã Mã Ba	45	active
1438	Xã Ngọc Đào	45	active
1447	Thị trấn Trà Lĩnh	47	active
1453	Xã Tri Phương	47	active
1456	Xã Quang Hán	47	active
1462	Xã Xuân Nội	47	active
1465	Xã Quang Trung	47	active
1468	Xã Quang Vinh	47	active
1471	Xã Cao Chương	47	active
1477	Thị trấn Trùng Khánh	47	active
1480	Xã Ngọc Khê	47	active
1481	Xã Ngọc Côn	47	active
1483	Xã Phong Nậm	47	active
1489	Xã Đình Phong	47	active
1495	Xã Đàm Thuỷ	47	active
1498	Xã Khâm Thành	47	active
1501	Xã Chí Viễn	47	active
1504	Xã Lăng Hiếu	47	active
1507	Xã Phong Châu	47	active
1516	Xã Trung Phúc	47	active
1519	Xã Cao Thăng	47	active
1522	Xã Đức Hồng	47	active
1525	Xã Đoài Dương	47	active
1534	Xã Minh Long	48	active
1537	Xã Lý Quốc	48	active
1540	Xã Thắng Lợi	48	active
1543	Xã Đồng Loan	48	active
1546	Xã Đức Quang	48	active
1549	Xã Kim Loan	48	active
1552	Xã Quang Long	48	active
1555	Xã An Lạc	48	active
1558	Thị trấn Thanh Nhật	48	active
1561	Xã Vinh Quý	48	active
1564	Xã Thống Nhất	48	active
1567	Xã Cô Ngân	48	active
1573	Xã Thị Hoa	48	active
1474	Xã Quốc Toản	49	active
1576	Thị trấn Quảng Uyên	49	active
1579	Xã Phi Hải	49	active
1582	Xã Quảng Hưng	49	active
1594	Xã Độc Lập	49	active
1597	Xã Cai Bộ	49	active
1603	Xã Phúc Sen	49	active
1606	Xã Chí Thảo	49	active
1609	Xã Tự Do	49	active
1615	Xã Hồng Quang	49	active
1618	Xã Ngọc Động	49	active
1624	Xã Hạnh Phúc	49	active
1627	Thị trấn Tà Lùng	49	active
1630	Xã Bế Văn Đàn	49	active
1636	Xã Cách Linh	49	active
1639	Xã Đại Sơn	49	active
1645	Xã Tiên Thành	49	active
1648	Thị trấn Hoà Thuận	49	active
1651	Xã Mỹ Hưng	49	active
1654	Thị trấn Nước Hai	51	active
1657	Xã Dân Chủ	51	active
1660	Xã Nam Tuấn	51	active
1666	Xã Đại Tiến	51	active
1669	Xã Đức Long	51	active
1672	Xã Ngũ Lão	51	active
1675	Xã Trương Lương	51	active
1687	Xã Hồng Việt	51	active
1696	Xã Hoàng Tung	51	active
1699	Xã Nguyễn Huệ	51	active
1702	Xã Quang Trung	51	active
1708	Xã Bạch Đằng	51	active
1711	Xã Bình Dương	51	active
1714	Xã Lê Chung	51	active
1723	Xã Hồng Nam	51	active
1726	Thị trấn Nguyên Bình	52	active
1729	Thị trấn Tĩnh Túc	52	active
1732	Xã Yên Lạc	52	active
1735	Xã Triệu Nguyên	52	active
1738	Xã Ca Thành	52	active
1744	Xã Vũ Nông	52	active
1747	Xã Minh Tâm	52	active
1750	Xã Thể Dục	52	active
1756	Xã Mai Long	52	active
1762	Xã Vũ Minh	52	active
1765	Xã Hoa Thám	52	active
1768	Xã Phan Thanh	52	active
1771	Xã Quang Thành	52	active
1774	Xã Tam Kim	52	active
1777	Xã Thành Công	52	active
1780	Xã Thịnh Vượng	52	active
1783	Xã Hưng Đạo	52	active
1786	Thị trấn Đông Khê	53	active
1789	Xã Canh Tân	53	active
1792	Xã Kim Đồng	53	active
1795	Xã Minh Khai	53	active
1801	Xã Đức Thông	53	active
1804	Xã Thái Cường	53	active
1807	Xã Vân Trình	53	active
1810	Xã Thụy Hùng	53	active
1813	Xã Quang Trọng	53	active
1816	Xã Trọng Con	53	active
1819	Xã Lê Lai	53	active
1822	Xã Đức Long	53	active
1828	Xã Lê Lợi	53	active
1831	Xã Đức Xuân	53	active
1834	Phường Nguyễn Thị Minh Khai	58	active
1837	Phường Sông Cầu	58	active
1840	Phường Đức Xuân	58	active
1843	Phường Phùng Chí Kiên	58	active
1846	Phường Huyền Tụng	58	active
1849	Xã Dương Quang	58	active
1852	Xã Nông Thượng	58	active
1855	Phường Xuất Hóa	58	active
1858	Xã Bằng Thành	60	active
1861	Xã Nhạn Môn	60	active
1864	Xã Bộc Bố	60	active
1867	Xã Công Bằng	60	active
1870	Xã Giáo Hiệu	60	active
1873	Xã Xuân La	60	active
1876	Xã An Thắng	60	active
1879	Xã Cổ Linh	60	active
1882	Xã Nghiên Loan	60	active
1885	Xã Cao Tân	60	active
1888	Thị trấn Chợ Rã	61	active
1891	Xã Bành Trạch	61	active
1894	Xã Phúc Lộc	61	active
1897	Xã Hà Hiệu	61	active
1900	Xã Cao Thượng	61	active
1906	Xã Khang Ninh	61	active
1909	Xã Nam Mẫu	61	active
1912	Xã Thượng Giáo	61	active
1915	Xã Địa Linh	61	active
1918	Xã Yến Dương	61	active
1921	Xã Chu Hương	61	active
1924	Xã Quảng Khê	61	active
1927	Xã Mỹ Phương	61	active
1930	Xã Hoàng Trĩ	61	active
1933	Xã Đồng Phúc	61	active
1936	Thị trấn Nà Phặc	62	active
1939	Xã Thượng Ân	62	active
1942	Xã Bằng Vân	62	active
1945	Xã Cốc Đán	62	active
1948	Xã Trung Hoà	62	active
1951	Xã Đức Vân	62	active
1954	Xã Vân Tùng	62	active
1957	Xã Thượng Quan	62	active
1960	Xã Hiệp Lực	62	active
1963	Xã Thuần Mang	62	active
1969	Thị trấn Phủ Thông	63	active
1975	Xã Vi Hương	63	active
1978	Xã Sĩ Bình	63	active
1981	Xã Vũ Muộn	63	active
1984	Xã Đôn Phong	63	active
1990	Xã Lục Bình	63	active
1993	Xã Tân Tú	63	active
1999	Xã Nguyên Phúc	63	active
2002	Xã Cao Sơn	63	active
2005	Xã Quân Hà	63	active
2008	Xã Cẩm Giàng	63	active
2011	Xã Mỹ Thanh	63	active
2014	Xã Dương Phong	63	active
2017	Xã Quang Thuận	63	active
2020	Thị trấn Bằng Lũng	64	active
2023	Xã Xuân Lạc	64	active
2026	Xã Nam Cường	64	active
2029	Xã Đồng Lạc	64	active
2032	Xã Tân Lập	64	active
2035	Xã Bản Thi	64	active
2038	Xã Quảng Bạch	64	active
2041	Xã Bằng Phúc	64	active
2044	Xã Yên Thịnh	64	active
2047	Xã Yên Thượng	64	active
2050	Xã Phương Viên	64	active
2053	Xã Ngọc Phái	64	active
2059	Xã Đồng Thắng	64	active
2062	Xã Lương Bằng	64	active
2065	Xã Bằng Lãng	64	active
2068	Xã Đại Sảo	64	active
2071	Xã Nghĩa Tá	64	active
2077	Xã Yên Mỹ	64	active
2080	Xã Bình Trung	64	active
2083	Xã Yên Phong	64	active
2086	Thị trấn Đồng Tâm	65	active
2089	Xã Tân Sơn	65	active
2092	Xã Thanh Vận	65	active
2095	Xã Mai Lạp	65	active
2098	Xã Hoà Mục	65	active
2101	Xã Thanh Mai	65	active
2104	Xã Cao Kỳ	65	active
2107	Xã Nông Hạ	65	active
2110	Xã Yên Cư	65	active
2113	Xã Thanh Thịnh	65	active
2116	Xã Yên Hân	65	active
2122	Xã Như Cố	65	active
2125	Xã Bình Văn	65	active
2131	Xã Quảng Chu	65	active
2137	Xã Văn Vũ	66	active
2140	Xã Văn Lang	66	active
2143	Xã Lương Thượng	66	active
2146	Xã Kim Hỷ	66	active
2152	Xã Cường Lợi	66	active
2155	Thị trấn Yến Lạc	66	active
2158	Xã Kim Lư	66	active
2161	Xã Sơn Thành	66	active
2170	Xã Văn Minh	66	active
2173	Xã Côn Minh	66	active
2176	Xã Cư Lễ	66	active
2179	Xã Trần Phú	66	active
2185	Xã Quang Phong	66	active
2188	Xã Dương Sơn	66	active
2191	Xã Xuân Dương	66	active
2194	Xã Đổng Xá	66	active
2197	Xã Liêm Thuỷ	66	active
2200	Phường Phan Thiết	70	active
2203	Phường Minh Xuân	70	active
2206	Phường Tân Quang	70	active
2209	Xã Tràng Đà	70	active
2212	Phường Nông Tiến	70	active
2215	Phường Ỷ La	70	active
2216	Phường Tân Hà	70	active
2218	Phường Hưng Thành	70	active
2497	Xã Kim Phú	70	active
2503	Xã An Khang	70	active
2509	Phường Mỹ Lâm	70	active
2512	Phường An Tường	70	active
2515	Xã Lưỡng Vượng	70	active
2521	Xã Thái Long	70	active
2524	Phường Đội Cấn	70	active
2233	Xã Phúc Yên	71	active
2242	Xã Xuân Lập	71	active
2251	Xã Khuôn Hà	71	active
2266	Thị trấn Lăng Can	71	active
2269	Xã Thượng Lâm	71	active
2290	Xã Bình An	71	active
2293	Xã Hồng Quang	71	active
2296	Xã Thổ Bình	71	active
2299	Xã Phúc Sơn	71	active
2302	Xã Minh Quang	71	active
2221	Thị trấn Na Hang	72	active
2227	Xã Sinh Long	72	active
2230	Xã Thượng Giáp	72	active
2239	Xã Thượng Nông	72	active
2245	Xã Côn Lôn	72	active
2248	Xã Yên Hoa	72	active
2254	Xã Hồng Thái	72	active
2260	Xã Đà Vị	72	active
2263	Xã Khau Tinh	72	active
2275	Xã Sơn Phú	72	active
2281	Xã Năng Khả	72	active
2284	Xã Thanh Tương	72	active
2287	Thị trấn Vĩnh Lộc	73	active
2305	Xã Trung Hà	73	active
2308	Xã Tân Mỹ	73	active
2311	Xã Hà Lang	73	active
2314	Xã Hùng Mỹ	73	active
2317	Xã Yên Lập	73	active
2320	Xã Tân An	73	active
2323	Xã Bình Phú	73	active
2326	Xã Xuân Quang	73	active
2329	Xã Ngọc Hội	73	active
2332	Xã Phú Bình	73	active
2335	Xã Hòa Phú	73	active
2338	Xã Phúc Thịnh	73	active
2341	Xã Kiên Đài	73	active
2344	Xã Tân Thịnh	73	active
2347	Xã Trung Hòa	73	active
2350	Xã Kim Bình	73	active
2353	Xã Hòa An	73	active
2356	Xã Vinh Quang	73	active
2359	Xã Tri Phú	73	active
2362	Xã Nhân Lý	73	active
2365	Xã Yên Nguyên	73	active
2368	Xã Linh Phú	73	active
2371	Xã Bình Nhân	73	active
2374	Thị trấn Tân Yên	74	active
2377	Xã Yên Thuận	74	active
2380	Xã Bạch Xa	74	active
2383	Xã Minh Khương	74	active
2386	Xã Yên Lâm	74	active
2389	Xã Minh Dân	74	active
2392	Xã Phù Lưu	74	active
2395	Xã Minh Hương	74	active
2398	Xã Yên Phú	74	active
2401	Xã Tân Thành	74	active
2404	Xã Bình Xa	74	active
2407	Xã Thái Sơn	74	active
2410	Xã Nhân Mục	74	active
2413	Xã Thành Long	74	active
2416	Xã Bằng Cốc	74	active
2419	Xã Thái Hòa	74	active
2422	Xã Đức Ninh	74	active
2425	Xã Hùng Đức	74	active
2431	Xã Quí Quân	75	active
2434	Xã Lực Hành	75	active
2437	Xã Kiến Thiết	75	active
2440	Xã Trung Minh	75	active
2443	Xã Chiêu Yên	75	active
2446	Xã Trung Trực	75	active
2449	Xã Xuân Vân	75	active
2452	Xã Phúc Ninh	75	active
2455	Xã Hùng Lợi	75	active
2458	Xã Trung Sơn	75	active
2461	Xã Tân Tiến	75	active
2464	Xã Tứ Quận	75	active
2467	Xã Đạo Viện	75	active
2470	Xã Tân Long	75	active
2473	Thị trấn Yên Sơn	75	active
2476	Xã Kim Quan	75	active
2479	Xã Lang Quán	75	active
2482	Xã Phú Thịnh	75	active
2485	Xã Công Đa	75	active
2488	Xã Trung Môn	75	active
2491	Xã Chân Sơn	75	active
2494	Xã Thái Bình	75	active
2500	Xã Tiến Bộ	75	active
2506	Xã Mỹ Bằng	75	active
2518	Xã Hoàng Khai	75	active
2527	Xã Nhữ Hán	75	active
2530	Xã Nhữ Khê	75	active
2533	Xã Đội Bình	75	active
2536	Thị trấn Sơn Dương	76	active
2539	Xã Trung Yên	76	active
2542	Xã Minh Thanh	76	active
2545	Xã Tân Trào	76	active
2548	Xã Vĩnh Lợi	76	active
2551	Xã Thượng Ấm	76	active
2554	Xã Bình Yên	76	active
2557	Xã Lương Thiện	76	active
2560	Xã Tú Thịnh	76	active
2563	Xã Cấp Tiến	76	active
2566	Xã Hợp Thành	76	active
2569	Xã Phúc Ứng	76	active
2572	Xã Đông Thọ	76	active
2575	Xã Kháng Nhật	76	active
2578	Xã Hợp Hòa	76	active
2584	Xã Quyết Thắng	76	active
2587	Xã Đồng Quý	76	active
2590	Xã Tân Thanh	76	active
2593	Xã Vân Sơn	76	active
2596	Xã Văn Phú	76	active
2599	Xã Chi Thiết	76	active
2602	Xã Đông Lợi	76	active
2605	Xã Thiện Kế	76	active
2608	Xã Hồng Lạc	76	active
2611	Xã Phú Lương	76	active
2614	Xã Ninh Lai	76	active
2617	Xã Đại Phú	76	active
2620	Xã Sơn Nam	76	active
2623	Xã Hào Phú	76	active
2626	Xã Tam Đa	76	active
2632	Xã Trường Sinh	76	active
2635	Phường Duyên Hải	80	active
2641	Phường Lào Cai	80	active
2644	Phường Cốc Lếu	80	active
2647	Phường Kim Tân	80	active
2650	Phường Bắc Lệnh	80	active
2653	Phường Pom Hán	80	active
2656	Phường Xuân Tăng	80	active
2658	Phường Bình Minh	80	active
2659	Xã Thống Nhất	80	active
2662	Xã Đồng Tuyển	80	active
2665	Xã Vạn Hoà	80	active
2668	Phường Bắc Cường	80	active
2671	Phường Nam Cường	80	active
2674	Xã Cam Đường	80	active
2677	Xã Tả Phời	80	active
2680	Xã Hợp Thành	80	active
2746	Xã Cốc San	80	active
2683	Thị trấn Bát Xát	82	active
2686	Xã A Mú Sung	82	active
2689	Xã Nậm Chạc	82	active
2692	Xã A Lù	82	active
2695	Xã Trịnh Tường	82	active
2701	Xã Y Tý	82	active
2704	Xã Cốc Mỳ	82	active
2707	Xã Dền Sáng	82	active
2710	Xã Bản Vược	82	active
2713	Xã Sàng Ma Sáo	82	active
2716	Xã Bản Qua	82	active
2719	Xã Mường Vi	82	active
2722	Xã Dền Thàng	82	active
2725	Xã Bản Xèo	82	active
2728	Xã Mường Hum	82	active
2731	Xã Trung Lèng Hồ	82	active
2734	Xã Quang Kim	82	active
2737	Xã Pa Cheo	82	active
2740	Xã Nậm Pung	82	active
2743	Xã Phìn Ngan	82	active
2749	Xã Tòng Sành	82	active
2752	Xã Pha Long	83	active
2755	Xã Tả Ngải Chồ	83	active
2758	Xã Tung Chung Phố	83	active
2761	Thị trấn Mường Khương	83	active
2764	Xã Dìn Chin	83	active
2767	Xã Tả Gia Khâu	83	active
2770	Xã Nậm Chảy	83	active
2773	Xã Nấm Lư	83	active
2776	Xã Lùng Khấu Nhin	83	active
2779	Xã Thanh Bình	83	active
2782	Xã Cao Sơn	83	active
2785	Xã Lùng Vai	83	active
2788	Xã Bản Lầu	83	active
2791	Xã La Pan Tẩn	83	active
2794	Xã Tả Thàng	83	active
2797	Xã Bản Sen	83	active
2800	Xã Nàn Sán	84	active
11653	Xã An Thắng	313	active
2803	Xã Thào Chư Phìn	84	active
2806	Xã Bản Mế	84	active
2809	Thị trấn Si Ma Cai	84	active
2812	Xã Sán Chải	84	active
2818	Xã Lùng Thẩn	84	active
2821	Xã Cán Cấu	84	active
2824	Xã Sín Chéng	84	active
2827	Xã Quan Hồ Thẩn	84	active
2836	Xã Nàn Xín	84	active
2839	Thị trấn Bắc Hà	85	active
2842	Xã Lùng Cải	85	active
2848	Xã Lùng Phình	85	active
2851	Xã Tả Van Chư	85	active
2854	Xã Tả Củ Tỷ	85	active
2857	Xã Thải Giàng Phố	85	active
2863	Xã Hoàng Thu Phố	85	active
2866	Xã Bản Phố	85	active
2869	Xã Bản Liền	85	active
2872	Xã Tà Chải	85	active
2875	Xã Na Hối	85	active
2878	Xã Cốc Ly	85	active
2881	Xã Nậm Mòn	85	active
2884	Xã Nậm Đét	85	active
2887	Xã Nậm Khánh	85	active
2890	Xã Bảo Nhai	85	active
2893	Xã Nậm Lúc	85	active
2896	Xã Cốc Lầu	85	active
2899	Xã Bản Cái	85	active
2902	Thị trấn N.T Phong Hải	86	active
2905	Thị trấn Phố Lu	86	active
2908	Thị trấn Tằng Loỏng	86	active
2911	Xã Bản Phiệt	86	active
2914	Xã Bản Cầm	86	active
2917	Xã Thái Niên	86	active
2920	Xã Phong Niên	86	active
2923	Xã Gia Phú	86	active
2926	Xã Xuân Quang	86	active
2929	Xã Sơn Hải	86	active
2932	Xã Xuân Giao	86	active
2935	Xã Trì Quang	86	active
2938	Xã Sơn Hà	86	active
2944	Xã Phú Nhuận	86	active
2947	Thị trấn Phố Ràng	87	active
2950	Xã Tân Tiến	87	active
2953	Xã Nghĩa Đô	87	active
2956	Xã Vĩnh Yên	87	active
2959	Xã Điện Quan	87	active
2962	Xã Xuân Hoà	87	active
2965	Xã Tân Dương	87	active
2968	Xã Thượng Hà	87	active
2971	Xã Kim Sơn	87	active
2974	Xã Cam Cọn	87	active
2977	Xã Minh Tân	87	active
2980	Xã Xuân Thượng	87	active
2983	Xã Việt Tiến	87	active
2986	Xã Yên Sơn	87	active
2989	Xã Bảo Hà	87	active
2992	Xã Lương Sơn	87	active
2998	Xã Phúc Khánh	87	active
3001	Phường Sa Pa	88	active
3002	Phường Sa Pả	88	active
3003	Phường Ô Quý Hồ	88	active
3004	Xã Ngũ Chỉ Sơn	88	active
3006	Phường Phan Si Păng	88	active
3010	Xã Trung Chải	88	active
3013	Xã Tả Phìn	88	active
3016	Phường Hàm Rồng	88	active
3019	Xã Hoàng Liên	88	active
3022	Xã Thanh Bình	88	active
3028	Phường Cầu Mây	88	active
3037	Xã Mường Hoa	88	active
3040	Xã Tả Van	88	active
3043	Xã Mường Bo	88	active
3046	Xã Bản Hồ	88	active
3052	Xã Liên Minh	88	active
3055	Thị trấn Khánh Yên	89	active
3061	Xã Võ Lao	89	active
3064	Xã Sơn Thuỷ	89	active
3067	Xã Nậm Mả	89	active
3070	Xã Tân Thượng	89	active
3073	Xã Nậm Rạng	89	active
3076	Xã Nậm Chầy	89	active
3079	Xã Tân An	89	active
3082	Xã Khánh Yên Thượng	89	active
3085	Xã Nậm Xé	89	active
3088	Xã Dần Thàng	89	active
3091	Xã Chiềng Ken	89	active
3094	Xã Làng Giàng	89	active
3097	Xã Hoà Mạc	89	active
3100	Xã Khánh Yên Trung	89	active
3103	Xã Khánh Yên Hạ	89	active
3106	Xã Dương Quỳ	89	active
3109	Xã Nậm Tha	89	active
3112	Xã Minh Lương	89	active
3115	Xã Thẩm Dương	89	active
3118	Xã Liêm Phú	89	active
3121	Xã Nậm Xây	89	active
3124	Phường Noong Bua	94	active
3127	Phường Him Lam	94	active
3130	Phường Thanh Bình	94	active
3133	Phường Tân Thanh	94	active
3136	Phường Mường Thanh	94	active
3139	Phường Nam Thanh	94	active
3142	Phường Thanh Trường	94	active
3145	Xã Thanh Minh	94	active
3316	Xã Nà Tấu	94	active
3317	Xã Nà Nhạn	94	active
3325	Xã Mường Phăng	94	active
3326	Xã Pá Khoang	94	active
3148	Phường Sông Đà	95	active
3151	Phường Na Lay	95	active
3184	Xã Lay Nưa	95	active
3154	Xã Sín Thầu	96	active
3155	Xã Sen Thượng	96	active
3157	Xã Chung Chải	96	active
3158	Xã Leng Su Sìn	96	active
3159	Xã Pá Mỳ	96	active
3160	Xã Mường Nhé	96	active
3161	Xã Nậm Vì	96	active
3162	Xã Nậm Kè	96	active
3163	Xã Mường Toong	96	active
3164	Xã Quảng Lâm	96	active
3177	Xã Huổi Lếch	96	active
3172	Thị Trấn Mường Chà	97	active
3178	Xã Sá Tổng	97	active
3181	Xã Mường Tùng	97	active
3190	Xã Hừa Ngài	97	active
3191	Xã Huổi Mí	97	active
3193	Xã Pa Ham	97	active
3194	Xã Nậm Nèn	97	active
3196	Xã Huổi Lèng	97	active
3197	Xã Sa Lông	97	active
3200	Xã Ma Thì Hồ	97	active
3201	Xã Na Sang	97	active
3202	Xã Mường Mươn	97	active
3217	Thị trấn Tủa Chùa	98	active
3220	Xã Huổi Só	98	active
3223	Xã Sín Chải	98	active
3226	Xã Tả Sìn Thàng	98	active
3229	Xã Lao Xả Phình	98	active
3232	Xã Tả Phìn	98	active
3235	Xã Tủa Thàng	98	active
3238	Xã Trung Thu	98	active
3241	Xã Sính Phình	98	active
3244	Xã Xá Nhè	98	active
3247	Xã Mường Đun	98	active
3250	Xã Mường Báng	98	active
3253	Thị trấn Tuần Giáo	99	active
3259	Xã Phình Sáng	99	active
3260	Xã Rạng Đông	99	active
3262	Xã Mùn Chung	99	active
3263	Xã Nà Tòng	99	active
3265	Xã Ta Ma	99	active
3268	Xã Mường Mùn	99	active
3269	Xã Pú Xi	99	active
3271	Xã Pú Nhung	99	active
3274	Xã Quài Nưa	99	active
3277	Xã Mường Thín	99	active
3280	Xã Tỏa Tình	99	active
3283	Xã Nà Sáy	99	active
3284	Xã Mường Khong	99	active
3289	Xã Quài Cang	99	active
3295	Xã Quài Tở	99	active
3298	Xã Chiềng Sinh	99	active
3299	Xã Chiềng Đông	99	active
3304	Xã Tênh Phông	99	active
3319	Xã Mường Pồn	100	active
3322	Xã Thanh Nưa	100	active
3323	Xã Hua Thanh	100	active
3328	Xã Thanh Luông	100	active
3331	Xã Thanh Hưng	100	active
3334	Xã Thanh Xương	100	active
3337	Xã Thanh Chăn	100	active
3340	Xã Pa Thơm	100	active
3343	Xã Thanh An	100	active
3346	Xã Thanh Yên	100	active
3349	Xã Noong Luống	100	active
3352	Xã Noong Hẹt	100	active
3355	Xã Sam Mứn	100	active
3356	Xã Pom Lót	100	active
3358	Xã Núa Ngam	100	active
3359	Xã Hẹ Muông	100	active
3361	Xã Na Ư	100	active
3364	Xã Mường Nhà	100	active
3365	Xã Na Tông	100	active
3367	Xã Mường Lói	100	active
3368	Xã Phu Luông	100	active
3203	Thị trấn Điện Biên Đông	101	active
3205	Xã Na Son	101	active
3208	Xã Phì Nhừ	101	active
3211	Xã Chiềng Sơ	101	active
3214	Xã Mường Luân	101	active
3370	Xã Pú Nhi	101	active
3371	Xã Nong U	101	active
3373	Xã Xa Dung	101	active
3376	Xã Keo Lôm	101	active
3379	Xã Luân Giói	101	active
3382	Xã Phình Giàng	101	active
3383	Xã Pú Hồng	101	active
3384	Xã Tìa Dình	101	active
3385	Xã Háng Lìa	101	active
3256	Thị trấn Mường Ảng	102	active
3286	Xã Mường Đăng	102	active
3287	Xã Ngối Cáy	102	active
3292	Xã Ẳng Tở	102	active
3301	Xã Búng Lao	102	active
3302	Xã Xuân Lao	102	active
3307	Xã Ẳng Nưa	102	active
3310	Xã Ẳng Cang	102	active
3312	Xã Nặm Lịch	102	active
3313	Xã Mường Lạn	102	active
3156	Xã Nậm Tin	103	active
3165	Xã Pa Tần	103	active
3166	Xã Chà Cang	103	active
3167	Xã Na Cô Sa	103	active
3168	Xã Nà Khoa	103	active
3169	Xã Nà Hỳ	103	active
3170	Xã Nà Bủng	103	active
3171	Xã Nậm Nhừ	103	active
3173	Xã Nậm Chua	103	active
3174	Xã Nậm Khăn	103	active
3175	Xã Chà Tở	103	active
3176	Xã Vàng Đán	103	active
3187	Xã Chà Nưa	103	active
3198	Xã Phìn Hồ	103	active
3199	Xã Si Pa Phìn	103	active
3386	Phường Quyết Thắng	105	active
3387	Phường Tân Phong	105	active
3388	Phường Quyết Tiến	105	active
3389	Phường Đoàn Kết	105	active
3403	Xã Sùng Phài	105	active
3408	Phường Đông Phong	105	active
3409	Xã San Thàng	105	active
3390	Thị trấn Tam Đường	106	active
3394	Xã Thèn Sin	106	active
3400	Xã Tả Lèng	106	active
3405	Xã Giang Ma	106	active
3406	Xã Hồ Thầu	106	active
3412	Xã Bình Lư	106	active
3413	Xã Sơn Bình	106	active
3415	Xã Nùng Nàng	106	active
3418	Xã Bản Giang	106	active
3421	Xã Bản Hon	106	active
3424	Xã Bản Bo	106	active
3427	Xã Nà Tăm	106	active
3430	Xã Khun Há	106	active
3433	Thị trấn Mường Tè	107	active
3436	Xã Thu Lũm	107	active
3439	Xã Ka Lăng	107	active
3440	Xã Tá Bạ	107	active
3442	Xã Pa ủ	107	active
3445	Xã Mường Tè	107	active
3448	Xã Pa Vệ Sử	107	active
3451	Xã Mù Cả	107	active
3454	Xã Bum Tở	107	active
3457	Xã Nậm Khao	107	active
3463	Xã Tà Tổng	107	active
3466	Xã Bum Nưa	107	active
3467	Xã Vàng San	107	active
3469	Xã Kan Hồ	107	active
3478	Thị trấn Sìn Hồ	108	active
3487	Xã Chăn Nưa	108	active
3493	Xã Pa Tần	108	active
3496	Xã Phìn Hồ	108	active
3499	Xã Hồng Thu	108	active
3505	Xã Phăng Sô Lin	108	active
3508	Xã Ma Quai	108	active
3509	Xã Lùng Thàng	108	active
3511	Xã Tả Phìn	108	active
3514	Xã Sà Dề Phìn	108	active
3517	Xã Nậm Tăm	108	active
3520	Xã Tả Ngảo	108	active
3523	Xã Pu Sam Cáp	108	active
3526	Xã Nậm Cha	108	active
3527	Xã Pa Khoá	108	active
3529	Xã Làng Mô	108	active
3532	Xã Noong Hẻo	108	active
3535	Xã Nậm Mạ	108	active
3538	Xã Căn Co	108	active
3541	Xã Tủa Sín Chải	108	active
3544	Xã Nậm Cuổi	108	active
3547	Xã Nậm Hăn	108	active
3391	Xã Lả Nhì Thàng	109	active
3490	Xã Huổi Luông	109	active
3549	Thị trấn Phong Thổ	109	active
3550	Xã Sì Lở Lầu	109	active
3553	Xã Mồ Sì San	109	active
3559	Xã Pa Vây Sử	109	active
3562	Xã Vàng Ma Chải	109	active
3565	Xã Tông Qua Lìn	109	active
3568	Xã Mù Sang	109	active
3571	Xã Dào San	109	active
3574	Xã Ma Ly Pho	109	active
3577	Xã Bản Lang	109	active
3580	Xã Hoang Thèn	109	active
3583	Xã Khổng Lào	109	active
3586	Xã Nậm Xe	109	active
3589	Xã Mường So	109	active
3592	Xã Sin Suối Hồ	109	active
3595	Thị trấn Than Uyên	110	active
3618	Xã Phúc Than	110	active
3619	Xã Mường Than	110	active
3625	Xã Mường Mít	110	active
3628	Xã Pha Mu	110	active
3631	Xã Mường Cang	110	active
3632	Xã Hua Nà	110	active
3634	Xã Tà Hừa	110	active
3637	Xã Mường Kim	110	active
3638	Xã Tà Mung	110	active
3640	Xã Tà Gia	110	active
3643	Xã Khoen On	110	active
3598	Thị trấn Tân Uyên	111	active
3601	Xã Mường Khoa	111	active
3602	Xã Phúc Khoa	111	active
3604	Xã Thân Thuộc	111	active
3605	Xã Trung Đồng	111	active
3607	Xã Hố Mít	111	active
3610	Xã Nậm Cần	111	active
3613	Xã Nậm Sỏ	111	active
3616	Xã Pắc Ta	111	active
3622	Xã Tà Mít	111	active
3434	Thị trấn Nậm Nhùn	112	active
3460	Xã Hua Bun	112	active
3472	Xã Mường Mô	112	active
3473	Xã Nậm Chà	112	active
3474	Xã Nậm Manh	112	active
3475	Xã Nậm Hàng	112	active
3481	Xã Lê Lợi	112	active
3484	Xã Pú Đao	112	active
3488	Xã Nậm Pì	112	active
3502	Xã Nậm Ban	112	active
3503	Xã Trung Chải	112	active
3646	Phường Chiềng Lề	116	active
3649	Phường Tô Hiệu	116	active
3652	Phường Quyết Thắng	116	active
3655	Phường Quyết Tâm	116	active
3658	Xã Chiềng Cọ	116	active
3661	Xã Chiềng Đen	116	active
3664	Xã Chiềng Xôm	116	active
3667	Phường Chiềng An	116	active
3670	Phường Chiềng Cơi	116	active
3673	Xã Chiềng Ngần	116	active
3676	Xã Hua La	116	active
3679	Phường Chiềng Sinh	116	active
3682	Xã Mường Chiên	118	active
3685	Xã Cà Nàng	118	active
3688	Xã Chiềng Khay	118	active
3694	Xã Mường Giôn	118	active
3697	Xã Pá Ma Pha Khinh	118	active
3700	Xã Chiềng Ơn	118	active
3703	Xã Mường Giàng	118	active
3706	Xã Chiềng Bằng	118	active
3709	Xã Mường Sại	118	active
3712	Xã Nậm ét	118	active
3718	Xã Chiềng Khoang	118	active
3721	Thị trấn Thuận Châu	119	active
3724	Xã Phổng Lái	119	active
3727	Xã Mường é	119	active
3730	Xã Chiềng Pha	119	active
3733	Xã Chiềng La	119	active
3736	Xã Chiềng Ngàm	119	active
3739	Xã Liệp Tè	119	active
3742	Xã é Tòng	119	active
3745	Xã Phổng Lập	119	active
3748	Xã Phổng Lăng	119	active
3751	Xã Chiềng Ly	119	active
3754	Xã Noong Lay	119	active
3757	Xã Mường Khiêng	119	active
3760	Xã Mường Bám	119	active
3763	Xã Long Hẹ	119	active
3766	Xã Chiềng Bôm	119	active
3769	Xã Thôm Mòn	119	active
3772	Xã Tông Lạnh	119	active
3775	Xã Tông Cọ	119	active
3778	Xã Bó Mười	119	active
3781	Xã Co Mạ	119	active
3784	Xã Púng Tra	119	active
3787	Xã Chiềng Pấc	119	active
3790	Xã Nậm Lầu	119	active
3793	Xã Bon Phặng	119	active
3796	Xã Co Tòng	119	active
3799	Xã Muổi Nọi	119	active
3802	Xã Pá Lông	119	active
3805	Xã Bản Lầm	119	active
3808	Thị trấn Ít Ong	120	active
3811	Xã Nậm Giôn	120	active
3814	Xã Chiềng Lao	120	active
3817	Xã Hua Trai	120	active
3820	Xã Ngọc Chiến	120	active
3823	Xã Mường Trai	120	active
3826	Xã Nậm Păm	120	active
3829	Xã Chiềng Muôn	120	active
3832	Xã Chiềng Ân	120	active
3835	Xã Pi Toong	120	active
3838	Xã Chiềng Công	120	active
3841	Xã Tạ Bú	120	active
3844	Xã Chiềng San	120	active
3847	Xã Mường Bú	120	active
3850	Xã Chiềng Hoa	120	active
3853	Xã Mường Chùm	120	active
3856	Thị trấn Bắc Yên	121	active
3859	Xã Phiêng Ban	121	active
3862	Xã Hang Chú	121	active
3865	Xã Xím Vàng	121	active
3868	Xã Tà Xùa	121	active
3869	Xã Háng Đồng	121	active
3871	Xã Pắc Ngà	121	active
3874	Xã Làng Chếu	121	active
3877	Xã Chim Vàn	121	active
3880	Xã Mường Khoa	121	active
3883	Xã Song Pe	121	active
3886	Xã Hồng Ngài	121	active
3889	Xã Tạ Khoa	121	active
3890	Xã Hua Nhàn	121	active
3892	Xã Phiêng Côn	121	active
3895	Xã Chiềng Sại	121	active
3898	Thị trấn Phù Yên	122	active
3901	Xã Suối Tọ	122	active
3904	Xã Mường Thải	122	active
3907	Xã Mường Cơi	122	active
3910	Xã Quang Huy	122	active
3913	Xã Huy Bắc	122	active
3916	Xã Huy Thượng	122	active
3919	Xã Tân Lang	122	active
3922	Xã Gia Phù	122	active
3925	Xã Tường Phù	122	active
3928	Xã Huy Hạ	122	active
3931	Xã Huy Tân	122	active
3934	Xã Mường Lang	122	active
3937	Xã Suối Bau	122	active
3940	Xã Huy Tường	122	active
3943	Xã Mường Do	122	active
3946	Xã Sập Xa	122	active
3949	Xã Tường Thượng	122	active
3952	Xã Tường Tiến	122	active
3955	Xã Tường Phong	122	active
3958	Xã Tường Hạ	122	active
3961	Xã Kim Bon	122	active
3964	Xã Mường Bang	122	active
3967	Xã Đá Đỏ	122	active
3970	Xã Tân Phong	122	active
3973	Xã Nam Phong	122	active
3976	Xã Bắc Phong	122	active
3979	Thị trấn Mộc Châu	123	active
3982	Thị trấn NT Mộc Châu	123	active
3985	Xã Chiềng Sơn	123	active
3988	Xã Tân Hợp	123	active
3991	Xã Quy Hướng	123	active
3997	Xã Tân Lập	123	active
4000	Xã Nà Mường	123	active
4003	Xã Tà Lại	123	active
4012	Xã Chiềng Hắc	123	active
4015	Xã Hua Păng	123	active
4024	Xã Chiềng Khừa	123	active
4027	Xã Mường Sang	123	active
4030	Xã Đông Sang	123	active
4033	Xã Phiêng Luông	123	active
4045	Xã Lóng Sập	123	active
4060	Thị trấn Yên Châu	124	active
4063	Xã Chiềng Đông	124	active
4066	Xã Sập Vạt	124	active
4069	Xã Chiềng Sàng	124	active
4072	Xã Chiềng Pằn	124	active
4075	Xã Viêng Lán	124	active
4078	Xã Chiềng Hặc	124	active
4081	Xã Mường Lựm	124	active
4084	Xã Chiềng On	124	active
4087	Xã Yên Sơn	124	active
4090	Xã Chiềng Khoi	124	active
4093	Xã Tú Nang	124	active
4096	Xã Lóng Phiêng	124	active
4099	Xã Phiêng Khoài	124	active
4102	Xã Chiềng Tương	124	active
4105	Thị trấn Hát Lót	125	active
4108	Xã Chiềng Sung	125	active
4111	Xã Mường Bằng	125	active
4114	Xã Chiềng Chăn	125	active
4117	Xã Mường Chanh	125	active
4120	Xã Chiềng Ban	125	active
4123	Xã Chiềng Mung	125	active
4126	Xã Mường Bon	125	active
4129	Xã Chiềng Chung	125	active
4132	Xã Chiềng Mai	125	active
4135	Xã Hát Lót	125	active
4136	Xã Nà Bó	125	active
4138	Xã Cò Nòi	125	active
4141	Xã Chiềng Nơi	125	active
4144	Xã Phiêng Cằm	125	active
4147	Xã Chiềng Dong	125	active
4150	Xã Chiềng Kheo	125	active
4153	Xã Chiềng Ve	125	active
4156	Xã Chiềng Lương	125	active
4159	Xã Phiêng Pằn	125	active
4162	Xã Nà Ớt	125	active
4165	Xã Tà Hộc	125	active
4168	Thị trấn Sông Mã	126	active
4171	Xã Bó Sinh	126	active
4174	Xã Pú Bẩu	126	active
4177	Xã Chiềng Phung	126	active
4180	Xã Chiềng En	126	active
4183	Xã Mường Lầm	126	active
4186	Xã Nậm Ty	126	active
4189	Xã Đứa Mòn	126	active
4192	Xã Yên Hưng	126	active
4195	Xã Chiềng Sơ	126	active
4198	Xã Nà Nghịu	126	active
4201	Xã Nậm Mằn	126	active
4204	Xã Chiềng Khoong	126	active
4207	Xã Chiềng Cang	126	active
4210	Xã Huổi Một	126	active
4213	Xã Mường Sai	126	active
4216	Xã Mường Cai	126	active
4219	Xã Mường Hung	126	active
4222	Xã Chiềng Khương	126	active
4225	Xã Sam Kha	127	active
4228	Xã Púng Bánh	127	active
4231	Xã Sốp Cộp	127	active
4234	Xã Dồm Cang	127	active
4237	Xã Nậm Lạnh	127	active
4240	Xã Mường Lèo	127	active
4243	Xã Mường Và	127	active
4246	Xã Mường Lạn	127	active
3994	Xã Suối Bàng	128	active
4006	Xã Song Khủa	128	active
4009	Xã Liên Hoà	128	active
4018	Xã Tô Múa	128	active
4021	Xã Mường Tè	128	active
4036	Xã Chiềng Khoa	128	active
4039	Xã Mường Men	128	active
4042	Xã Quang Minh	128	active
4048	Xã Vân Hồ	128	active
4051	Xã Lóng Luông	128	active
4054	Xã Chiềng Yên	128	active
4056	Xã Chiềng Xuân	128	active
4057	Xã Xuân Nha	128	active
4058	Xã Tân Xuân	128	active
4249	Phường Yên Thịnh	132	active
4252	Phường Yên Ninh	132	active
4255	Phường Minh Tân	132	active
4258	Phường Nguyễn Thái Học	132	active
4261	Phường Đồng Tâm	132	active
4264	Phường Nguyễn Phúc	132	active
4267	Phường Hồng Hà	132	active
4270	Xã Minh Bảo	132	active
4273	Phường Nam Cường	132	active
4276	Xã Tuy Lộc	132	active
4279	Xã Tân Thịnh	132	active
4540	Xã Âu Lâu	132	active
4543	Xã Giới Phiên	132	active
4546	Phường Hợp Minh	132	active
4558	Xã Văn Phú	132	active
4282	Phường Pú Trạng	133	active
4285	Phường Trung Tâm	133	active
4288	Phường Tân An	133	active
4291	Phường Cầu Thia	133	active
4294	Xã Nghĩa Lợi	133	active
4297	Xã Nghĩa Phúc	133	active
4300	Xã Nghĩa An	133	active
4624	Xã Nghĩa Lộ	133	active
4660	Xã Sơn A	133	active
4663	Xã Phù Nham	133	active
4675	Xã Thanh Lương	133	active
4678	Xã Hạnh Sơn	133	active
4681	Xã Phúc Sơn	133	active
4684	Xã Thạch Lương	133	active
4303	Thị trấn Yên Thế	135	active
4306	Xã Tân Phượng	135	active
4309	Xã Lâm Thượng	135	active
4312	Xã Khánh Thiện	135	active
4315	Xã Minh Chuẩn	135	active
4318	Xã Mai Sơn	135	active
4321	Xã Khai Trung	135	active
4324	Xã Mường Lai	135	active
4327	Xã An Lạc	135	active
4330	Xã Minh Xuân	135	active
4333	Xã Tô Mậu	135	active
4336	Xã Tân Lĩnh	135	active
4339	Xã Yên Thắng	135	active
4342	Xã Khánh Hoà	135	active
4345	Xã Vĩnh Lạc	135	active
4348	Xã Liễu Đô	135	active
4351	Xã Động Quan	135	active
4354	Xã Tân Lập	135	active
4357	Xã Minh Tiến	135	active
4360	Xã Trúc Lâu	135	active
4363	Xã Phúc Lợi	135	active
4366	Xã Phan Thanh	135	active
4369	Xã An Phú	135	active
4372	Xã Trung Tâm	135	active
4375	Thị trấn Mậu A	136	active
4378	Xã Lang Thíp	136	active
4381	Xã Lâm Giang	136	active
4384	Xã Châu Quế Thượng	136	active
4387	Xã Châu Quế Hạ	136	active
4390	Xã An Bình	136	active
4393	Xã Quang Minh	136	active
4396	Xã Đông An	136	active
4399	Xã Đông Cuông	136	active
4402	Xã Phong Dụ Hạ	136	active
4405	Xã Mậu Đông	136	active
4408	Xã Ngòi A	136	active
4411	Xã Xuân Tầm	136	active
4414	Xã Tân Hợp	136	active
4417	Xã An Thịnh	136	active
4420	Xã Yên Thái	136	active
4423	Xã Phong Dụ Thượng	136	active
4426	Xã Yên Hợp	136	active
4429	Xã Đại Sơn	136	active
4435	Xã Đại Phác	136	active
4438	Xã Yên Phú	136	active
4441	Xã Xuân Ái	136	active
4447	Xã Viễn Sơn	136	active
4450	Xã Mỏ Vàng	136	active
4453	Xã Nà Hẩu	136	active
4456	Thị trấn Mù Căng Chải	137	active
4459	Xã Hồ Bốn	137	active
4462	Xã Nậm Có	137	active
4465	Xã Khao Mang	137	active
4468	Xã Mồ Dề	137	active
4471	Xã Chế Cu Nha	137	active
4474	Xã Lao Chải	137	active
4477	Xã Kim Nọi	137	active
4480	Xã Cao Phạ	137	active
4483	Xã La Pán Tẩn	137	active
4486	Xã Dế Xu Phình	137	active
4489	Xã Chế Tạo	137	active
4492	Xã Púng Luông	137	active
4495	Xã Nậm Khắt	137	active
4498	Thị trấn Cổ Phúc	138	active
4501	Xã Tân Đồng	138	active
4504	Xã Báo Đáp	138	active
4507	Xã Đào Thịnh	138	active
4510	Xã Việt Thành	138	active
4513	Xã Hòa Cuông	138	active
4516	Xã Minh Quán	138	active
4519	Xã Quy Mông	138	active
4522	Xã Cường Thịnh	138	active
4525	Xã Kiên Thành	138	active
4528	Xã Nga Quán	138	active
4531	Xã Y Can	138	active
4537	Xã Lương Thịnh	138	active
4561	Xã Bảo Hưng	138	active
4564	Xã Việt Cường	138	active
4567	Xã Minh Quân	138	active
4570	Xã Hồng Ca	138	active
4573	Xã Hưng Thịnh	138	active
4576	Xã Hưng Khánh	138	active
4579	Xã Việt Hồng	138	active
4582	Xã Vân Hội	138	active
4585	Thị trấn Trạm Tấu	139	active
4588	Xã Túc Đán	139	active
4591	Xã Pá Lau	139	active
4594	Xã Xà Hồ	139	active
4597	Xã Phình Hồ	139	active
4600	Xã Trạm Tấu	139	active
4603	Xã Tà Xi Láng	139	active
4606	Xã Pá Hu	139	active
4609	Xã Làng Nhì	139	active
4612	Xã Bản Công	139	active
4615	Xã Bản Mù	139	active
4618	Xã Hát Lừu	139	active
4621	Thị trấn NT Liên Sơn	140	active
4627	Thị trấn NT Trần Phú	140	active
4630	Xã Tú Lệ	140	active
4633	Xã Nậm Búng	140	active
4636	Xã Gia Hội	140	active
4639	Xã Sùng Đô	140	active
4642	Xã Nậm Mười	140	active
4645	Xã An Lương	140	active
4648	Xã Nậm Lành	140	active
4651	Xã Sơn Lương	140	active
4654	Xã Suối Quyền	140	active
4657	Xã Suối Giàng	140	active
4666	Xã Nghĩa Sơn	140	active
4669	Xã Suối Bu	140	active
4672	Thị trấn Sơn Thịnh	140	active
4687	Xã Đại Lịch	140	active
4690	Xã Đồng Khê	140	active
4693	Xã Cát Thịnh	140	active
4696	Xã Tân Thịnh	140	active
4699	Xã Chấn Thịnh	140	active
4702	Xã Bình Thuận	140	active
4705	Xã Thượng Bằng La	140	active
4708	Xã Minh An	140	active
4711	Xã Nghĩa Tâm	140	active
4714	Thị trấn Yên Bình	141	active
4717	Thị trấn Thác Bà	141	active
4720	Xã Xuân Long	141	active
4726	Xã Cảm Nhân	141	active
4729	Xã Ngọc Chấn	141	active
4732	Xã Tân Nguyên	141	active
4735	Xã Phúc Ninh	141	active
4738	Xã Bảo Ái	141	active
4741	Xã Mỹ Gia	141	active
4744	Xã Xuân Lai	141	active
4747	Xã Mông Sơn	141	active
4750	Xã Cảm Ân	141	active
4753	Xã Yên Thành	141	active
4756	Xã Tân Hương	141	active
4759	Xã Phúc An	141	active
4762	Xã Bạch Hà	141	active
4765	Xã Vũ Linh	141	active
4768	Xã Đại Đồng	141	active
4771	Xã Vĩnh Kiên	141	active
4774	Xã Yên Bình	141	active
4777	Xã Thịnh Hưng	141	active
4780	Xã Hán Đà	141	active
4783	Xã Phú Thịnh	141	active
4786	Xã Đại Minh	141	active
4789	Phường Thái Bình	148	active
4792	Phường Tân Hòa	148	active
4795	Phường Thịnh Lang	148	active
4798	Phường Hữu Nghị	148	active
4801	Phường Tân Thịnh	148	active
4804	Phường Đồng Tiến	148	active
4807	Phường Phương Lâm	148	active
4813	Xã Yên Mông	148	active
4816	Phường Quỳnh Lâm	148	active
4819	Phường Dân Chủ	148	active
4825	Xã Hòa Bình	148	active
4828	Phường Thống Nhất	148	active
4894	Phường Kỳ Sơn	148	active
4897	Xã Thịnh Minh	148	active
4903	Xã Hợp Thành	148	active
4906	Xã Quang Tiến	148	active
4912	Xã Mông Hóa	148	active
4918	Phường Trung Minh	148	active
4921	Xã Độc Lập	148	active
4831	Thị trấn Đà Bắc	150	active
4834	Xã Nánh Nghê	150	active
4840	Xã Giáp Đắt	150	active
4846	Xã Mường Chiềng	150	active
4849	Xã Tân Pheo	150	active
4852	Xã Đồng Chum	150	active
4855	Xã Tân Minh	150	active
4858	Xã Đoàn Kết	150	active
4861	Xã Đồng Ruộng	150	active
4867	Xã Tú Lý	150	active
4870	Xã Trung Thành	150	active
4873	Xã Yên Hòa	150	active
4876	Xã Cao Sơn	150	active
4879	Xã Toàn Sơn	150	active
4885	Xã Hiền Lương	150	active
4888	Xã Tiền Phong	150	active
4891	Xã Vầy Nưa	150	active
4924	Thị trấn Lương Sơn	152	active
4942	Xã Lâm Sơn	152	active
4945	Xã Hòa Sơn	152	active
4951	Xã Tân Vinh	152	active
4954	Xã Nhuận Trạch	152	active
4957	Xã Cao Sơn	152	active
4960	Xã Cư Yên	152	active
4969	Xã Liên Sơn	152	active
5008	Xã Cao Dương	152	active
5041	Xã Thanh Sơn	152	active
5047	Xã Thanh Cao	152	active
4978	Thị trấn Bo	153	active
4984	Xã Đú Sáng	153	active
4987	Xã Hùng Sơn	153	active
4990	Xã Bình Sơn	153	active
4999	Xã Tú Sơn	153	active
5005	Xã Vĩnh Tiến	153	active
5014	Xã Đông Bắc	153	active
5017	Xã Xuân Thủy	153	active
5026	Xã Vĩnh Đồng	153	active
5035	Xã Kim Lập	153	active
5038	Xã Hợp Tiến	153	active
5065	Xã Kim Bôi	153	active
5068	Xã Nam Thượng	153	active
5077	Xã Cuối Hạ	153	active
5080	Xã Sào Báy	153	active
5083	Xã Mi Hòa	153	active
5086	Xã Nuông Dăm	153	active
5089	Thị trấn Cao Phong	154	active
5092	Xã Bình Thanh	154	active
5095	Xã Thung Nai	154	active
5098	Xã Bắc Phong	154	active
5101	Xã Thu Phong	154	active
5104	Xã Hợp Phong	154	active
5110	Xã Tây Phong	154	active
5116	Xã Dũng Phong	154	active
5119	Xã Nam Phong	154	active
5125	Xã Thạch Yên	154	active
5128	Thị trấn Mãn Đức	155	active
5134	Xã Suối Hoa	155	active
5137	Xã Phú Vinh	155	active
5140	Xã Phú Cường	155	active
5143	Xã Mỹ Hòa	155	active
5152	Xã Quyết Chiến	155	active
5158	Xã Phong Phú	155	active
5164	Xã Tử Nê	155	active
5167	Xã Thanh Hối	155	active
5170	Xã Ngọc Mỹ	155	active
5173	Xã Đông Lai	155	active
5176	Xã Vân Sơn	155	active
5182	Xã Nhân Mỹ	155	active
5191	Xã Lỗ Sơn	155	active
5194	Xã Ngổ Luông	155	active
5197	Xã Gia Mô	155	active
4882	Xã Tân Thành	156	active
5200	Thị trấn Mai Châu	156	active
5206	Xã Sơn Thủy	156	active
5209	Xã Pà Cò	156	active
5212	Xã Hang Kia	156	active
5221	Xã Đồng Tân	156	active
5224	Xã Cun Pheo	156	active
5227	Xã Bao La	156	active
5233	Xã Tòng Đậu	156	active
5242	Xã Nà Phòn	156	active
5245	Xã Săm Khóe	156	active
5248	Xã Chiềng Châu	156	active
5251	Xã Mai Hạ	156	active
5254	Xã Thành Sơn	156	active
5257	Xã Mai Hịch	156	active
5263	Xã Vạn Mai	156	active
5266	Thị trấn Vụ Bản	157	active
5269	Xã Quý Hòa	157	active
5272	Xã Miền Đồi	157	active
5275	Xã Mỹ Thành	157	active
5278	Xã Tuân Đạo	157	active
5281	Xã Văn Nghĩa	157	active
5284	Xã Văn Sơn	157	active
5287	Xã Tân Lập	157	active
5290	Xã Nhân Nghĩa	157	active
5293	Xã Thượng Cốc	157	active
5299	Xã Quyết Thắng	157	active
5302	Xã Xuất Hóa	157	active
5305	Xã Yên Phú	157	active
5308	Xã Bình Hẻm	157	active
5320	Xã Định Cư	157	active
5323	Xã Chí Đạo	157	active
5329	Xã Ngọc Sơn	157	active
5332	Xã Hương Nhượng	157	active
5335	Xã Vũ Bình	157	active
5338	Xã Tự Do	157	active
5341	Xã Yên Nghiệp	157	active
5344	Xã Tân Mỹ	157	active
5347	Xã Ân Nghĩa	157	active
5350	Xã Ngọc Lâu	157	active
5353	Thị trấn Hàng Trạm	158	active
5356	Xã Lạc Sỹ	158	active
5362	Xã Lạc Lương	158	active
5365	Xã Bảo Hiệu	158	active
5368	Xã Đa Phúc	158	active
5371	Xã Hữu Lợi	158	active
5374	Xã Lạc Thịnh	158	active
5380	Xã Đoàn Kết	158	active
5383	Xã Phú Lai	158	active
5386	Xã Yên Trị	158	active
5389	Xã Ngọc Lương	158	active
4981	Thị trấn Ba Hàng Đồi	159	active
5392	Thị trấn Chi Nê	159	active
5395	Xã Phú Nghĩa	159	active
5398	Xã Phú Thành	159	active
5404	Xã Hưng Thi	159	active
5413	Xã Khoan Dụ	159	active
5419	Xã Đồng Tâm	159	active
5422	Xã Yên Bồng	159	active
5425	Xã Thống Nhất	159	active
5428	Xã An Bình	159	active
5431	Phường Quán Triều	164	active
5434	Phường Quang Vinh	164	active
5437	Phường Túc Duyên	164	active
5440	Phường Hoàng Văn Thụ	164	active
5443	Phường Trưng Vương	164	active
5446	Phường Quang Trung	164	active
5449	Phường Phan Đình Phùng	164	active
5452	Phường Tân Thịnh	164	active
5455	Phường Thịnh Đán	164	active
5458	Phường Đồng Quang	164	active
5461	Phường Gia Sàng	164	active
5464	Phường Tân Lập	164	active
5467	Phường Cam Giá	164	active
5470	Phường Phú Xá	164	active
5473	Phường Hương Sơn	164	active
5476	Phường Trung Thành	164	active
5479	Phường Tân Thành	164	active
5482	Phường Tân Long	164	active
5485	Xã Phúc Hà	164	active
5488	Xã Phúc Xuân	164	active
5491	Xã Quyết Thắng	164	active
5494	Xã Phúc Trìu	164	active
5497	Xã Thịnh Đức	164	active
5500	Phường Tích Lương	164	active
5503	Xã Tân Cương	164	active
5653	Xã Sơn Cẩm	164	active
5659	Phường Chùa Hang	164	active
5695	Xã Cao Ngạn	164	active
5701	Xã Linh Sơn	164	active
5710	Phường Đồng Bẩm	164	active
5713	Xã Huống Thượng	164	active
5914	Xã Đồng Liên	164	active
5506	Phường Lương Sơn	165	active
5509	Phường Châu Sơn	165	active
5512	Phường Mỏ Chè	165	active
5515	Phường Cải Đan	165	active
5518	Phường Thắng Lợi	165	active
5521	Phường Phố Cò	165	active
5527	Xã Tân Quang	165	active
5528	Phường Bách Quang	165	active
5530	Xã Bình Sơn	165	active
5533	Xã Bá Xuyên	165	active
5536	Thị trấn Chợ Chu	167	active
5539	Xã Linh Thông	167	active
5542	Xã Lam Vỹ	167	active
5545	Xã Quy Kỳ	167	active
5548	Xã Tân Thịnh	167	active
5551	Xã Kim Phượng	167	active
5554	Xã Bảo Linh	167	active
5560	Xã Phúc Chu	167	active
5563	Xã Tân Dương	167	active
5566	Xã Phượng Tiến	167	active
5569	Xã Bảo Cường	167	active
5572	Xã Đồng Thịnh	167	active
5575	Xã Định Biên	167	active
5578	Xã Thanh Định	167	active
5581	Xã Trung Hội	167	active
5584	Xã Trung Lương	167	active
5587	Xã Bình Yên	167	active
5590	Xã Điềm Mặc	167	active
5593	Xã Phú Tiến	167	active
5596	Xã Bộc Nhiêu	167	active
5599	Xã Sơn Phú	167	active
5602	Xã Phú Đình	167	active
5605	Xã Bình Thành	167	active
5608	Thị trấn Giang Tiên	168	active
5611	Thị trấn Đu	168	active
5614	Xã Yên Ninh	168	active
5617	Xã Yên Trạch	168	active
5620	Xã Yên Đổ	168	active
5623	Xã Yên Lạc	168	active
5626	Xã Ôn Lương	168	active
5629	Xã Động Đạt	168	active
5632	Xã Phủ Lý	168	active
5635	Xã Phú Đô	168	active
5638	Xã Hợp Thành	168	active
5641	Xã Tức Tranh	168	active
5644	Xã Phấn Mễ	168	active
5647	Xã Vô Tranh	168	active
5650	Xã Cổ Lũng	168	active
5656	Thị trấn Sông Cầu	169	active
5662	Thị trấn Trại Cau	169	active
5665	Xã Văn Lăng	169	active
5668	Xã Tân Long	169	active
5671	Xã Hòa Bình	169	active
5674	Xã Quang Sơn	169	active
5677	Xã Minh Lập	169	active
5680	Xã Văn Hán	169	active
5683	Xã Hóa Trung	169	active
5686	Xã Khe Mo	169	active
5689	Xã Cây Thị	169	active
5692	Xã Hóa Thượng	169	active
5698	Xã Hợp Tiến	169	active
5704	Xã Tân Lợi	169	active
5707	Xã Nam Hòa	169	active
5716	Thị trấn Đình Cả	170	active
5719	Xã Sảng Mộc	170	active
5722	Xã Nghinh Tường	170	active
5725	Xã Thần Xa	170	active
5728	Xã Vũ Chấn	170	active
5731	Xã Thượng Nung	170	active
5734	Xã Phú Thượng	170	active
5737	Xã Cúc Đường	170	active
5740	Xã La Hiên	170	active
5743	Xã Lâu Thượng	170	active
5746	Xã Tràng Xá	170	active
5749	Xã Phương Giao	170	active
5752	Xã Liên Minh	170	active
5755	Xã Dân Tiến	170	active
5758	Xã Bình Long	170	active
5761	Thị trấn Hùng Sơn	171	active
5764	Thị trấn Quân Chu	171	active
5767	Xã Phúc Lương	171	active
5770	Xã Minh Tiến	171	active
5773	Xã Yên Lãng	171	active
5776	Xã Đức Lương	171	active
5779	Xã Phú Cường	171	active
5782	Xã Na Mao	171	active
5785	Xã Phú Lạc	171	active
5788	Xã Tân Linh	171	active
5791	Xã Phú Thịnh	171	active
5794	Xã Phục Linh	171	active
5797	Xã Phú Xuyên	171	active
5800	Xã Bản Ngoại	171	active
5803	Xã Tiên Hội	171	active
5809	Xã Cù Vân	171	active
5812	Xã Hà Thượng	171	active
5815	Xã La Bằng	171	active
5818	Xã Hoàng Nông	171	active
5821	Xã Khôi Kỳ	171	active
5824	Xã An Khánh	171	active
5827	Xã Tân Thái	171	active
5830	Xã Bình Thuận	171	active
5833	Xã Lục Ba	171	active
5836	Xã Mỹ Yên	171	active
5839	Xã Vạn Thọ	171	active
5842	Xã Văn Yên	171	active
5845	Xã Ký Phú	171	active
5848	Xã Cát Nê	171	active
5851	Xã Quân Chu	171	active
5854	Phường Bãi Bông	172	active
5857	Phường Bắc Sơn	172	active
5860	Phường Ba Hàng	172	active
5863	Xã Phúc Tân	172	active
5866	Xã Phúc Thuận	172	active
5869	Phường Hồng Tiến	172	active
5872	Xã Minh Đức	172	active
5875	Phường Đắc Sơn	172	active
5878	Phường Đồng Tiến	172	active
5881	Xã Thành Công	172	active
5884	Phường Tiên Phong	172	active
5887	Xã Vạn Phái	172	active
5890	Phường Nam Tiến	172	active
5893	Phường Tân Hương	172	active
5896	Phường Đông Cao	172	active
5899	Phường Trung Thành	172	active
5902	Phường Tân Phú	172	active
5905	Phường Thuận Thành	172	active
5908	Thị trấn Hương Sơn	173	active
5911	Xã Bàn Đạt	173	active
5917	Xã Tân Khánh	173	active
5920	Xã Tân Kim	173	active
5923	Xã Tân Thành	173	active
5926	Xã Đào Xá	173	active
5929	Xã Bảo Lý	173	active
5932	Xã Thượng Đình	173	active
5935	Xã Tân Hòa	173	active
5938	Xã Nhã Lộng	173	active
5941	Xã Điềm Thụy	173	active
5944	Xã Xuân Phương	173	active
5947	Xã Tân Đức	173	active
5950	Xã Úc Kỳ	173	active
5953	Xã Lương Phú	173	active
5956	Xã Nga My	173	active
5959	Xã Kha Sơn	173	active
5962	Xã Thanh Ninh	173	active
5965	Xã Dương Thành	173	active
5968	Xã Hà Châu	173	active
5971	Phường Hoàng Văn Thụ	178	active
5974	Phường Tam Thanh	178	active
5977	Phường Vĩnh Trại	178	active
5980	Phường Đông Kinh	178	active
5983	Phường Chi Lăng	178	active
5986	Xã Hoàng Đồng	178	active
5989	Xã Quảng Lạc	178	active
5992	Xã Mai Pha	178	active
5995	Thị trấn Thất Khê	180	active
5998	Xã Khánh Long	180	active
6001	Xã Đoàn Kết	180	active
6004	Xã Quốc Khánh	180	active
6007	Xã Vĩnh Tiến	180	active
6010	Xã Cao Minh	180	active
6013	Xã Chí Minh	180	active
6016	Xã Tri Phương	180	active
6019	Xã Tân Tiến	180	active
6022	Xã Tân Yên	180	active
6025	Xã Đội Cấn	180	active
6028	Xã Tân Minh	180	active
6031	Xã Kim Đồng	180	active
6034	Xã Chi Lăng	180	active
6037	Xã Trung Thành	180	active
6040	Xã Đại Đồng	180	active
6043	Xã Đào Viên	180	active
6046	Xã Đề Thám	180	active
6049	Xã Kháng Chiến	180	active
6055	Xã Hùng Sơn	180	active
6058	Xã Quốc Việt	180	active
6061	Xã Hùng Việt	180	active
6067	Xã Hưng Đạo	181	active
6070	Xã Vĩnh Yên	181	active
6073	Xã Hoa Thám	181	active
6076	Xã Quý Hòa	181	active
6079	Xã Hồng Phong	181	active
6082	Xã Yên Lỗ	181	active
6085	Xã Thiện Hòa	181	active
6088	Xã Quang Trung	181	active
6091	Xã Thiện Thuật	181	active
6094	Xã Minh Khai	181	active
6097	Xã Thiện Long	181	active
6100	Xã Hoàng Văn Thụ	181	active
6103	Xã Hòa Bình	181	active
6106	Xã Mông Ân	181	active
6109	Xã Tân Hòa	181	active
6112	Thị trấn Bình Gia	181	active
6115	Xã Hồng Thái	181	active
6118	Xã Bình La	181	active
6121	Xã Tân Văn	181	active
6124	Thị trấn Na Sầm	182	active
6127	Xã Trùng Khánh	182	active
6133	Xã Bắc La	182	active
6136	Xã Thụy Hùng	182	active
6139	Xã Bắc Hùng	182	active
6142	Xã Tân Tác	182	active
6148	Xã Thanh Long	182	active
6151	Xã Hội Hoan	182	active
6154	Xã Bắc Việt	182	active
6157	Xã Hoàng Việt	182	active
6160	Xã Gia Miễn	182	active
6163	Xã Thành Hòa	182	active
6166	Xã Tân Thanh	182	active
6172	Xã Tân Mỹ	182	active
6175	Xã Hồng Thái	182	active
6178	Xã Hoàng Văn Thụ	182	active
6181	Xã Nhạc Kỳ	182	active
6184	Thị trấn Đồng Đăng	183	active
6187	Thị trấn Cao Lộc	183	active
6190	Xã Bảo Lâm	183	active
6193	Xã Thanh Lòa	183	active
6196	Xã Cao Lâu	183	active
6199	Xã Thạch Đạn	183	active
6202	Xã Xuất Lễ	183	active
6205	Xã Hồng Phong	183	active
6208	Xã Thụy Hùng	183	active
6211	Xã Lộc Yên	183	active
6214	Xã Phú Xá	183	active
6217	Xã Bình Trung	183	active
6220	Xã Hải Yến	183	active
6223	Xã Hòa Cư	183	active
6226	Xã Hợp Thành	183	active
6232	Xã Công Sơn	183	active
6235	Xã Gia Cát	183	active
6238	Xã Mẫu Sơn	183	active
6241	Xã Xuân Long	183	active
6244	Xã Tân Liên	183	active
6247	Xã Yên Trạch	183	active
6250	Xã Tân Thành	183	active
6253	Thị trấn Văn Quan	184	active
6256	Xã Trấn Ninh	184	active
6268	Xã Liên Hội	184	active
6274	Xã Hòa Bình	184	active
6277	Xã Tú Xuyên	184	active
6280	Xã Điềm He	184	active
6283	Xã An Sơn	184	active
6286	Xã Khánh Khê	184	active
6292	Xã Lương Năng	184	active
6295	Xã Đồng Giáp	184	active
6298	Xã Bình Phúc	184	active
6301	Xã Tràng Các	184	active
6307	Xã Tân Đoàn	184	active
6313	Xã Tri Lễ	184	active
6316	Xã Tràng Phái	184	active
6319	Xã Yên Phúc	184	active
6322	Xã Hữu Lễ	184	active
6325	Thị trấn Bắc Sơn	185	active
6328	Xã Long Đống	185	active
6331	Xã Vạn Thủy	185	active
6337	Xã Đồng ý	185	active
6340	Xã Tân Tri	185	active
6343	Xã Bắc Quỳnh	185	active
6349	Xã Hưng Vũ	185	active
6352	Xã Tân Lập	185	active
6355	Xã Vũ Sơn	185	active
6358	Xã Chiêu Vũ	185	active
6361	Xã Tân Hương	185	active
6364	Xã Chiến Thắng	185	active
6367	Xã Vũ Lăng	185	active
6370	Xã Trấn Yên	185	active
6373	Xã Vũ Lễ	185	active
6376	Xã Nhất Hòa	185	active
6379	Xã Tân Thành	185	active
6382	Xã Nhất Tiến	185	active
6385	Thị trấn Hữu Lũng	186	active
6388	Xã Hữu Liên	186	active
6391	Xã Yên Bình	186	active
6394	Xã Quyết Thắng	186	active
6397	Xã Hòa Bình	186	active
6400	Xã Yên Thịnh	186	active
6403	Xã Yên Sơn	186	active
6406	Xã Thiện Tân	186	active
6412	Xã Yên Vượng	186	active
6415	Xã Minh Tiến	186	active
6418	Xã Nhật Tiến	186	active
6421	Xã Thanh Sơn	186	active
6424	Xã Đồng Tân	186	active
6427	Xã Cai Kinh	186	active
6430	Xã Hòa Lạc	186	active
6433	Xã Vân Nham	186	active
6436	Xã Đồng Tiến	186	active
6442	Xã Tân Thành	186	active
6445	Xã Hòa Sơn	186	active
6448	Xã Minh Sơn	186	active
6451	Xã Hồ Sơn	186	active
6454	Xã Sơn Hà	186	active
6457	Xã Minh Hòa	186	active
6460	Xã Hòa Thắng	186	active
6463	Thị trấn Đồng Mỏ	187	active
6466	Thị trấn Chi Lăng	187	active
6469	Xã Vân An	187	active
6472	Xã Vân Thủy	187	active
6475	Xã Gia Lộc	187	active
6478	Xã Bắc Thủy	187	active
6481	Xã Chiến Thắng	187	active
6484	Xã Mai Sao	187	active
6487	Xã Bằng Hữu	187	active
6490	Xã Thượng Cường	187	active
6493	Xã Bằng Mạc	187	active
6496	Xã Nhân Lý	187	active
6499	Xã Lâm Sơn	187	active
6502	Xã Liên Sơn	187	active
6505	Xã Vạn Linh	187	active
6508	Xã Hòa Bình	187	active
6514	Xã Hữu Kiên	187	active
6517	Xã Quan Sơn	187	active
6520	Xã Y Tịch	187	active
6523	Xã Chi Lăng	187	active
6526	Thị trấn Na Dương	188	active
6529	Thị trấn Lộc Bình	188	active
6532	Xã Mẫu Sơn	188	active
6541	Xã Yên Khoái	188	active
6544	Xã Khánh Xuân	188	active
6547	Xã Tú Mịch	188	active
6550	Xã Hữu Khánh	188	active
6553	Xã Đồng Bục	188	active
6559	Xã Tam Gia	188	active
6562	Xã Tú Đoạn	188	active
6565	Xã Khuất Xá	188	active
6574	Xã Tĩnh Bắc	188	active
6577	Xã Thống Nhất	188	active
6589	Xã Sàn Viên	188	active
6592	Xã Đông Quan	188	active
6595	Xã Minh Hiệp	188	active
6598	Xã Hữu Lân	188	active
6601	Xã Lợi Bác	188	active
6604	Xã Nam Quan	188	active
6607	Xã Xuân Dương	188	active
6610	Xã Ái Quốc	188	active
6613	Thị trấn Đình Lập	189	active
6616	Thị trấn NT Thái Bình	189	active
6619	Xã Bắc Xa	189	active
6622	Xã Bính Xá	189	active
6625	Xã Kiên Mộc	189	active
6628	Xã Đình Lập	189	active
6631	Xã Thái Bình	189	active
6634	Xã Cường Lợi	189	active
6637	Xã Châu Sơn	189	active
6640	Xã Lâm Ca	189	active
6643	Xã Đồng Thắng	189	active
6646	Xã Bắc Lãng	189	active
6649	Phường Hà Khánh	193	active
6652	Phường Hà Phong	193	active
6655	Phường Hà Khẩu	193	active
6658	Phường Cao Xanh	193	active
6661	Phường Giếng Đáy	193	active
6664	Phường Hà Tu	193	active
6667	Phường Hà Trung	193	active
6670	Phường Hà Lầm	193	active
6673	Phường Bãi Cháy	193	active
6676	Phường Cao Thắng	193	active
6679	Phường Hùng Thắng	193	active
6682	Phường Yết Kiêu	193	active
6685	Phường Trần Hưng Đạo	193	active
6688	Phường Hồng Hải	193	active
6691	Phường Hồng Gai	193	active
6694	Phường Bạch Đằng	193	active
6697	Phường Hồng Hà	193	active
6700	Phường Tuần Châu	193	active
6703	Phường Việt Hưng	193	active
6706	Phường Đại Yên	193	active
7030	Phường Hoành Bồ	193	active
7033	Xã Kỳ Thượng	193	active
7036	Xã Đồng Sơn	193	active
7039	Xã Tân Dân	193	active
7042	Xã Đồng Lâm	193	active
7045	Xã Hòa Bình	193	active
7048	Xã Vũ Oai	193	active
7051	Xã Dân Chủ	193	active
7054	Xã Quảng La	193	active
7057	Xã Bằng Cả	193	active
7060	Xã Thống Nhất	193	active
7063	Xã Sơn Dương	193	active
7066	Xã Lê Lợi	193	active
6709	Phường Ka Long	194	active
6712	Phường Trần Phú	194	active
6715	Phường Ninh Dương	194	active
6718	Phường Hoà Lạc	194	active
6721	Phường Trà Cổ	194	active
6724	Xã Hải Sơn	194	active
6727	Xã Bắc Sơn	194	active
6730	Xã Hải Đông	194	active
6733	Xã Hải Tiến	194	active
6736	Phường Hải Yên	194	active
6739	Xã Quảng Nghĩa	194	active
6742	Phường Hải Hoà	194	active
6745	Xã Hải Xuân	194	active
6748	Xã Vạn Ninh	194	active
6751	Phường Bình Ngọc	194	active
6754	Xã Vĩnh Trung	194	active
6757	Xã Vĩnh Thực	194	active
6760	Phường Mông Dương	195	active
6763	Phường Cửa Ông	195	active
6766	Phường Cẩm Sơn	195	active
6769	Phường Cẩm Đông	195	active
6772	Phường Cẩm Phú	195	active
6775	Phường Cẩm Tây	195	active
6778	Phường Quang Hanh	195	active
6781	Phường Cẩm Thịnh	195	active
6784	Phường Cẩm Thủy	195	active
6787	Phường Cẩm Thạch	195	active
6790	Phường Cẩm Thành	195	active
6793	Phường Cẩm Trung	195	active
6796	Phường Cẩm Bình	195	active
6799	Xã Cộng Hòa	195	active
6802	Xã Cẩm Hải	195	active
6805	Xã Dương Huy	195	active
6808	Phường Vàng Danh	196	active
6811	Phường Thanh Sơn	196	active
6814	Phường Bắc Sơn	196	active
6817	Phường Quang Trung	196	active
6820	Phường Trưng Vương	196	active
6823	Phường Nam Khê	196	active
6826	Phường Yên Thanh	196	active
6829	Xã Thượng Yên Công	196	active
6832	Phường Phương Đông	196	active
6835	Phường Phương Nam	196	active
6838	Thị trấn Bình Liêu	198	active
6841	Xã Hoành Mô	198	active
6844	Xã Đồng Tâm	198	active
6847	Xã Đồng Văn	198	active
6853	Xã Vô Ngại	198	active
6856	Xã Lục Hồn	198	active
6859	Xã Húc Động	198	active
6862	Thị trấn Tiên Yên	199	active
6865	Xã Hà Lâu	199	active
6868	Xã Đại Dực	199	active
6871	Xã Phong Dụ	199	active
6874	Xã Điền Xá	199	active
6877	Xã Đông Ngũ	199	active
6880	Xã Yên Than	199	active
6883	Xã Đông Hải	199	active
6886	Xã Hải Lạng	199	active
6889	Xã Tiên Lãng	199	active
6892	Xã Đồng Rui	199	active
6895	Thị trấn Đầm Hà	200	active
6898	Xã Quảng Lâm	200	active
6901	Xã Quảng An	200	active
6904	Xã Tân Bình	200	active
6910	Xã Dực Yên	200	active
6913	Xã Quảng Tân	200	active
6916	Xã Đầm Hà	200	active
6917	Xã Tân Lập	200	active
6919	Xã Đại Bình	200	active
6922	Thị trấn Quảng Hà	201	active
6925	Xã Quảng Đức	201	active
6928	Xã Quảng Sơn	201	active
6931	Xã Quảng Thành	201	active
6937	Xã Quảng Thịnh	201	active
6940	Xã Quảng Minh	201	active
6943	Xã Quảng Chính	201	active
6946	Xã Quảng Long	201	active
6949	Xã Đường Hoa	201	active
6952	Xã Quảng Phong	201	active
6967	Xã Cái Chiên	201	active
6970	Thị trấn Ba Chẽ	202	active
6973	Xã Thanh Sơn	202	active
6976	Xã Thanh Lâm	202	active
6979	Xã Đạp Thanh	202	active
6982	Xã Nam Sơn	202	active
6985	Xã Lương Mông	202	active
6988	Xã Đồn Đạc	202	active
6991	Xã Minh Cầm	202	active
6994	Thị trấn Cái Rồng	203	active
6997	Xã Đài Xuyên	203	active
7000	Xã Bình Dân	203	active
7003	Xã Vạn Yên	203	active
7006	Xã Minh Châu	203	active
7009	Xã Đoàn Kết	203	active
7012	Xã Hạ Long	203	active
7015	Xã Đông Xá	203	active
7018	Xã Bản Sen	203	active
7021	Xã Thắng Lợi	203	active
7024	Xã Quan Lạn	203	active
7027	Xã Ngọc Vừng	203	active
7069	Phường Mạo Khê	205	active
7072	Phường Đông Triều	205	active
7075	Xã An Sinh	205	active
7078	Xã Tràng Lương	205	active
7081	Xã Bình Khê	205	active
7084	Xã Việt Dân	205	active
7087	Xã Tân Việt	205	active
7090	Xã Bình Dương	205	active
7093	Phường Đức Chính	205	active
7096	Phường Tràng An	205	active
7099	Xã Nguyễn Huệ	205	active
7102	Xã Thủy An	205	active
7105	Phường Xuân Sơn	205	active
7108	Xã Hồng Thái Tây	205	active
7111	Xã Hồng Thái Đông	205	active
7114	Phường Hoàng Quế	205	active
7117	Phường Yên Thọ	205	active
7120	Phường Hồng Phong	205	active
7123	Phường Kim Sơn	205	active
7126	Phường Hưng Đạo	205	active
7129	Xã Yên Đức	205	active
7132	Phường Quảng Yên	206	active
7135	Phường Đông Mai	206	active
7138	Phường Minh Thành	206	active
7144	Xã Sông Khoai	206	active
7147	Xã Hiệp Hòa	206	active
7150	Phường Cộng Hòa	206	active
7153	Xã Tiền An	206	active
7156	Xã Hoàng Tân	206	active
7159	Phường Tân An	206	active
7162	Phường Yên Giang	206	active
7165	Phường Nam Hoà	206	active
7168	Phường Hà An	206	active
7171	Xã Cẩm La	206	active
7174	Phường Phong Hải	206	active
7177	Phường Yên Hải	206	active
7180	Xã Liên Hòa	206	active
7183	Phường Phong Cốc	206	active
7186	Xã Liên Vị	206	active
7189	Xã Tiền Phong	206	active
7192	Thị trấn Cô Tô	207	active
7195	Xã Đồng Tiến	207	active
7198	Xã Thanh Lân	207	active
7201	Phường Thọ Xương	213	active
7204	Phường Trần Nguyên Hãn	213	active
7207	Phường Ngô Quyền	213	active
7210	Phường Hoàng Văn Thụ	213	active
7213	Phường Trần Phú	213	active
7216	Phường Mỹ Độ	213	active
7219	Phường Lê Lợi	213	active
7222	Xã Song Mai	213	active
7225	Phường Xương Giang	213	active
7228	Phường Đa Mai	213	active
7231	Phường Dĩnh Kế	213	active
7441	Xã Dĩnh Trì	213	active
7687	Xã Tân Mỹ	213	active
7696	Xã Đồng Sơn	213	active
7699	Xã Tân Tiến	213	active
7705	Xã Song Khê	213	active
7243	Xã Đồng Tiến	215	active
7246	Xã Canh Nậu	215	active
7249	Xã Xuân Lương	215	active
7252	Xã Tam Tiến	215	active
7255	Xã Đồng Vương	215	active
7258	Xã Đồng Hưu	215	active
7260	Xã Đồng Tâm	215	active
7261	Xã Tam Hiệp	215	active
7264	Xã Tiến Thắng	215	active
7267	Xã Hồng Kỳ	215	active
7270	Xã Đồng Lạc	215	active
7273	Xã Đông Sơn	215	active
7276	Xã Tân Hiệp	215	active
7279	Xã Hương Vĩ	215	active
7282	Xã Đồng Kỳ	215	active
7285	Xã An Thượng	215	active
7288	Thị trấn Phồn Xương	215	active
7291	Xã Tân Sỏi	215	active
7294	Thị trấn Bố Hạ	215	active
7303	Xã Lan Giới	216	active
7306	Thị trấn Nhã Nam	216	active
7309	Xã Tân Trung	216	active
7312	Xã Đại Hóa	216	active
7315	Xã Quang Tiến	216	active
7318	Xã Phúc Sơn	216	active
7321	Xã An Dương	216	active
7324	Xã Phúc Hòa	216	active
7327	Xã Liên Sơn	216	active
7330	Xã Hợp Đức	216	active
7333	Xã Lam Cốt	216	active
7336	Xã Cao Xá	216	active
7339	Thị trấn Cao Thượng	216	active
7342	Xã Việt Ngọc	216	active
7345	Xã Song Vân	216	active
7348	Xã Ngọc Châu	216	active
7351	Xã Ngọc Vân	216	active
7354	Xã Việt Lập	216	active
7357	Xã Liên Chung	216	active
7360	Xã Ngọc Thiện	216	active
7363	Xã Ngọc Lý	216	active
7366	Xã Quế Nham	216	active
7375	Thị trấn Vôi	217	active
7378	Xã Nghĩa Hòa	217	active
7381	Xã Nghĩa Hưng	217	active
7384	Xã Quang Thịnh	217	active
7387	Xã Hương Sơn	217	active
7390	Xã Đào Mỹ	217	active
7393	Xã Tiên Lục	217	active
7396	Xã An Hà	217	active
7399	Thị trấn Kép	217	active
7402	Xã Mỹ Hà	217	active
7405	Xã Hương Lạc	217	active
7408	Xã Dương Đức	217	active
7411	Xã Tân Thanh	217	active
7414	Xã Yên Mỹ	217	active
7417	Xã Tân Hưng	217	active
7420	Xã Mỹ Thái	217	active
7426	Xã Xương Lâm	217	active
7429	Xã Xuân Hương	217	active
7432	Xã Tân Dĩnh	217	active
7435	Xã Đại Lâm	217	active
7438	Xã Thái Đào	217	active
7444	Thị trấn Đồi Ngô	218	active
7450	Xã Đông Hưng	218	active
7453	Xã Đông Phú	218	active
7456	Xã Tam Dị	218	active
7459	Xã Bảo Sơn	218	active
7462	Xã Bảo Đài	218	active
7465	Xã Thanh Lâm	218	active
7468	Xã Tiên Nha	218	active
7471	Xã Trường Giang	218	active
7477	Thị trấn Phương Sơn	218	active
7480	Xã Chu Điện	218	active
7483	Xã Cương Sơn	218	active
7486	Xã Nghĩa Phương	218	active
7489	Xã Vô Tranh	218	active
7492	Xã Bình Sơn	218	active
7495	Xã Lan Mẫu	218	active
7498	Xã Yên Sơn	218	active
7501	Xã Khám Lạng	218	active
7504	Xã Huyền Sơn	218	active
7507	Xã Trường Sơn	218	active
7510	Xã Lục Sơn	218	active
7513	Xã Bắc Lũng	218	active
7516	Xã Vũ Xá	218	active
7519	Xã Cẩm Lý	218	active
7522	Xã Đan Hội	218	active
7525	Thị trấn Chũ	219	active
7528	Xã Cấm Sơn	219	active
7531	Xã Tân Sơn	219	active
7534	Xã Phong Minh	219	active
7537	Xã Phong Vân	219	active
7540	Xã Xa Lý	219	active
7543	Xã Hộ Đáp	219	active
7546	Xã Sơn Hải	219	active
7549	Xã Thanh Hải	219	active
7552	Xã Kiên Lao	219	active
7555	Xã Biên Sơn	219	active
7558	Xã Kiên Thành	219	active
7561	Xã Hồng Giang	219	active
7564	Xã Kim Sơn	219	active
7567	Xã Tân Hoa	219	active
7570	Xã Giáp Sơn	219	active
7573	Xã Biển Động	219	active
7576	Xã Quý Sơn	219	active
7579	Xã Trù Hựu	219	active
7582	Xã Phì Điền	219	active
7588	Xã Tân Quang	219	active
7591	Xã Đồng Cốc	219	active
7594	Xã Tân Lập	219	active
7597	Xã Phú Nhuận	219	active
7600	Xã Mỹ An	219	active
7603	Xã Nam Dương	219	active
7606	Xã Tân Mộc	219	active
7609	Xã Đèo Gia	219	active
7612	Xã Phượng Sơn	219	active
7615	Thị trấn An Châu	220	active
7616	Thị trấn Tây Yên Tử	220	active
7621	Xã Vân Sơn	220	active
7624	Xã Hữu Sản	220	active
7627	Xã Đại Sơn	220	active
7630	Xã Phúc Sơn	220	active
7636	Xã Giáo Liêm	220	active
7642	Xã Cẩm Đàn	220	active
7645	Xã An Lạc	220	active
7648	Xã Vĩnh An	220	active
7651	Xã Yên Định	220	active
7654	Xã Lệ Viễn	220	active
7660	Xã An Bá	220	active
7663	Xã Tuấn Đạo	220	active
7666	Xã Dương Hưu	220	active
7672	Xã Long Sơn	220	active
7678	Xã Thanh Luận	220	active
7681	Thị trấn Nham Biền	221	active
7682	Thị trấn Tân An	221	active
7684	Xã Lão Hộ	221	active
7690	Xã Hương Gián	221	active
7702	Xã Quỳnh Sơn	221	active
7708	Xã Nội Hoàng	221	active
7711	Xã Tiền Phong	221	active
7714	Xã Xuân Phú	221	active
7717	Xã Tân Liễu	221	active
7720	Xã Trí Yên	221	active
7723	Xã Lãng Sơn	221	active
7726	Xã Yên Lư	221	active
7729	Xã Tiến Dũng	221	active
7735	Xã Đức Giang	221	active
7738	Xã Cảnh Thụy	221	active
7741	Xã Tư Mại	221	active
7747	Xã Đồng Việt	221	active
7750	Xã Đồng Phúc	221	active
7759	Xã Thượng Lan	222	active
7762	Xã Việt Tiến	222	active
7765	Xã Nghĩa Trung	222	active
7768	Xã Minh Đức	222	active
7771	Xã Hương Mai	222	active
7774	Xã Tự Lạn	222	active
7777	Thị trấn Bích Động	222	active
7780	Xã Trung Sơn	222	active
7783	Xã Hồng Thái	222	active
7786	Xã Tiên Sơn	222	active
7789	Xã Tăng Tiến	222	active
7792	Xã Quảng Minh	222	active
7795	Thị trấn Nếnh	222	active
7798	Xã Ninh Sơn	222	active
7801	Xã Vân Trung	222	active
7804	Xã Vân Hà	222	active
7807	Xã Quang Châu	222	active
7813	Xã Đồng Tân	223	active
7816	Xã Thanh Vân	223	active
7819	Xã Hoàng Lương	223	active
7822	Xã Hoàng Vân	223	active
7825	Xã Hoàng Thanh	223	active
7828	Xã Hoàng An	223	active
7831	Xã Ngọc Sơn	223	active
7834	Xã Thái Sơn	223	active
7837	Xã Hòa Sơn	223	active
7840	Thị trấn Thắng	223	active
7843	Xã Quang Minh	223	active
7846	Xã Lương Phong	223	active
7849	Xã Hùng Sơn	223	active
7852	Xã Đại Thành	223	active
7855	Xã Thường Thắng	223	active
7858	Xã Hợp Thịnh	223	active
7861	Xã Danh Thắng	223	active
7864	Xã Mai Trung	223	active
7867	Xã Đoan Bái	223	active
7870	Thị trấn Bắc Lý	223	active
7873	Xã Xuân Cẩm	223	active
7876	Xã Hương Lâm	223	active
7879	Xã Đông Lỗ	223	active
7882	Xã Châu Minh	223	active
7885	Xã Mai Đình	223	active
7888	Phường Dữu Lâu	227	active
7891	Phường Vân Cơ	227	active
7894	Phường Nông Trang	227	active
7897	Phường Tân Dân	227	active
7900	Phường Gia Cẩm	227	active
7903	Phường Tiên Cát	227	active
7906	Phường Thọ Sơn	227	active
7909	Phường Thanh Miếu	227	active
7912	Phường Bạch Hạc	227	active
7915	Phường Bến Gót	227	active
7918	Phường Vân Phú	227	active
7921	Xã Phượng Lâu	227	active
7924	Xã Thụy Vân	227	active
7927	Phường Minh Phương	227	active
7930	Xã Trưng Vương	227	active
7933	Phường Minh Nông	227	active
7936	Xã Sông Lô	227	active
8281	Xã Kim Đức	227	active
8287	Xã Hùng Lô	227	active
8503	Xã Hy Cương	227	active
8506	Xã Chu Hóa	227	active
8515	Xã Thanh Đình	227	active
7942	Phường Hùng Vương	228	active
7945	Phường Phong Châu	228	active
7948	Phường Âu Cơ	228	active
7951	Xã Hà Lộc	228	active
7954	Xã Phú Hộ	228	active
7957	Xã Văn Lung	228	active
7960	Xã Thanh Minh	228	active
7963	Xã Hà Thạch	228	active
7966	Phường Thanh Vinh	228	active
7969	Thị trấn Đoan Hùng	230	active
7975	Xã Hùng Xuyên	230	active
7981	Xã Bằng Luân	230	active
7984	Xã Vân Du	230	active
7987	Xã Phú Lâm	230	active
7993	Xã Minh Lương	230	active
7996	Xã Bằng Doãn	230	active
7999	Xã Chí Đám	230	active
8005	Xã Phúc Lai	230	active
8008	Xã Ngọc Quan	230	active
8014	Xã Hợp Nhất	230	active
8017	Xã Sóc Đăng	230	active
8023	Xã Tây Cốc	230	active
8026	Xã Yên Kiện	230	active
8029	Xã Hùng Long	230	active
8032	Xã Vụ Quang	230	active
8035	Xã Vân Đồn	230	active
8038	Xã Tiêu Sơn	230	active
8041	Xã Minh Tiến	230	active
8044	Xã Minh Phú	230	active
8047	Xã Chân Mộng	230	active
8050	Xã Ca Đình	230	active
8053	Thị trấn Hạ Hoà	231	active
8056	Xã Đại Phạm	231	active
8062	Xã Đan Thượng	231	active
8065	Xã Hà Lương	231	active
8071	Xã Tứ Hiệp	231	active
8080	Xã Hiền Lương	231	active
8089	Xã Phương Viên	231	active
8092	Xã Gia Điền	231	active
8095	Xã Ấm Hạ	231	active
8104	Xã Hương Xạ	231	active
8110	Xã Xuân Áng	231	active
8113	Xã Yên Kỳ	231	active
8119	Xã Minh Hạc	231	active
8122	Xã Lang Sơn	231	active
8125	Xã Bằng Giã	231	active
8128	Xã Yên Luật	231	active
8131	Xã Vô Tranh	231	active
8134	Xã Văn Lang	231	active
8140	Xã Minh Côi	231	active
8143	Xã Vĩnh Chân	231	active
8152	Thị trấn Thanh Ba	232	active
8156	Xã Vân Lĩnh	232	active
8158	Xã Đông Lĩnh	232	active
8161	Xã Đại An	232	active
8164	Xã Hanh Cù	232	active
8170	Xã Đồng Xuân	232	active
8173	Xã Quảng Yên	232	active
8179	Xã Ninh Dân	232	active
8194	Xã Võ Lao	232	active
8197	Xã Khải Xuân	232	active
8200	Xã Mạn Lạn	232	active
8203	Xã Hoàng Cương	232	active
8206	Xã Chí Tiên	232	active
8209	Xã Đông Thành	232	active
8215	Xã Sơn Cương	232	active
8218	Xã Thanh Hà	232	active
8221	Xã Đỗ Sơn	232	active
8224	Xã Đỗ Xuyên	232	active
8227	Xã Lương Lỗ	232	active
8230	Thị trấn Phong Châu	233	active
8233	Xã Phú Mỹ	233	active
8234	Xã Lệ Mỹ	233	active
8236	Xã Liên Hoa	233	active
8239	Xã Trạm Thản	233	active
8242	Xã Trị Quận	233	active
8245	Xã Trung Giáp	233	active
8248	Xã Tiên Phú	233	active
8251	Xã Hạ Giáp	233	active
8254	Xã Bảo Thanh	233	active
8257	Xã Phú Lộc	233	active
8260	Xã Gia Thanh	233	active
8263	Xã Tiên Du	233	active
8266	Xã Phú Nham	233	active
8272	Xã An Đạo	233	active
8275	Xã Bình Phú	233	active
8278	Xã Phù Ninh	233	active
8290	Thị trấn Yên Lập	234	active
8293	Xã Mỹ Lung	234	active
8296	Xã Mỹ Lương	234	active
8299	Xã Lương Sơn	234	active
8302	Xã Xuân An	234	active
8305	Xã Xuân Viên	234	active
8308	Xã Xuân Thủy	234	active
8311	Xã Trung Sơn	234	active
8314	Xã Hưng Long	234	active
8317	Xã Nga Hoàng	234	active
8320	Xã Đồng Lạc	234	active
8323	Xã Thượng Long	234	active
8326	Xã Đồng Thịnh	234	active
8329	Xã Phúc Khánh	234	active
8332	Xã Minh Hòa	234	active
8335	Xã Ngọc Lập	234	active
8338	Xã Ngọc Đồng	234	active
8341	Thị trấn Cẩm Khê	235	active
8344	Xã Tiên Lương	235	active
8347	Xã Tuy Lộc	235	active
8350	Xã Ngô Xá	235	active
8353	Xã Minh Tân	235	active
8356	Xã Phượng Vĩ	235	active
8362	Xã Thụy Liễu	235	active
8374	Xã Tùng Khê	235	active
8377	Xã Tam Sơn	235	active
8380	Xã Văn Bán	235	active
8383	Xã Cấp Dẫn	235	active
8389	Xã Xương Thịnh	235	active
8392	Xã Phú Khê	235	active
8395	Xã Sơn Tình	235	active
8398	Xã Yên Tập	235	active
8401	Xã Hương Lung	235	active
8404	Xã Tạ Xá	235	active
8407	Xã Phú Lạc	235	active
8413	Xã Chương Xá	235	active
8416	Xã Hùng Việt	235	active
8419	Xã Văn Khúc	235	active
8422	Xã Yên Dưỡng	235	active
8428	Xã Điêu Lương	235	active
8431	Xã Đồng Lương	235	active
8434	Thị trấn Hưng Hoá	236	active
8440	Xã Hiền Quan	236	active
8443	Xã Bắc Sơn	236	active
8446	Xã Thanh Uyên	236	active
8461	Xã Lam Sơn	236	active
8467	Xã Vạn Xuân	236	active
8470	Xã Quang Húc	236	active
8473	Xã Hương Nộn	236	active
8476	Xã Tề Lễ	236	active
8479	Xã Thọ Văn	236	active
8482	Xã Dị Nậu	236	active
8491	Xã Dân Quyền	236	active
8494	Thị trấn Lâm Thao	237	active
8497	Xã Tiên Kiên	237	active
8498	Thị trấn Hùng Sơn	237	active
8500	Xã Xuân Lũng	237	active
8509	Xã Xuân Huy	237	active
8512	Xã Thạch Sơn	237	active
8518	Xã Sơn Vi	237	active
8521	Xã Phùng Nguyên	237	active
8527	Xã Cao Xá	237	active
8533	Xã Vĩnh Lại	237	active
8536	Xã Tứ Xã	237	active
8539	Xã Bản Nguyên	237	active
8542	Thị trấn Thanh Sơn	238	active
8563	Xã Sơn Hùng	238	active
8572	Xã Địch Quả	238	active
8575	Xã Giáp Lai	238	active
8581	Xã Thục Luyện	238	active
8584	Xã Võ Miếu	238	active
8587	Xã Thạch Khoán	238	active
8602	Xã Cự Thắng	238	active
8605	Xã Tất Thắng	238	active
8611	Xã Văn Miếu	238	active
8614	Xã Cự Đồng	238	active
8623	Xã Thắng Sơn	238	active
8629	Xã Tân Minh	238	active
8632	Xã Hương Cần	238	active
8635	Xã Khả Cửu	238	active
8638	Xã Đông Cửu	238	active
8641	Xã Tân Lập	238	active
8644	Xã Yên Lãng	238	active
8647	Xã Yên Lương	238	active
8650	Xã Thượng Cửu	238	active
8653	Xã Lương Nha	238	active
8656	Xã Yên Sơn	238	active
8659	Xã Tinh Nhuệ	238	active
8662	Xã Đào Xá	239	active
8665	Xã Thạch Đồng	239	active
8668	Xã Xuân Lộc	239	active
8671	Xã Tân Phương	239	active
8674	Thị trấn Thanh Thủy	239	active
8677	Xã Sơn Thủy	239	active
8680	Xã Bảo Yên	239	active
8683	Xã Đoan Hạ	239	active
8686	Xã Đồng Trung	239	active
8689	Xã Hoàng Xá	239	active
8701	Xã Tu Vũ	239	active
8545	Xã Thu Cúc	240	active
8548	Xã Thạch Kiệt	240	active
8551	Xã Thu Ngạc	240	active
8554	Xã Kiệt Sơn	240	active
8557	Xã Đồng Sơn	240	active
8560	Xã Lai Đồng	240	active
8566	Xã Tân Phú	240	active
8569	Xã Mỹ Thuận	240	active
8578	Xã Tân Sơn	240	active
8590	Xã Xuân Đài	240	active
8593	Xã Minh Đài	240	active
8596	Xã Văn Luông	240	active
8599	Xã Xuân Sơn	240	active
8608	Xã Long Cốc	240	active
8617	Xã Kim Thượng	240	active
8620	Xã Tam Thanh	240	active
8626	Xã Vinh Tiền	240	active
8707	Phường Tích Sơn	243	active
8710	Phường Liên Bảo	243	active
8713	Phường Hội Hợp	243	active
8716	Phường Đống Đa	243	active
8719	Phường Ngô Quyền	243	active
8722	Phường Đồng Tâm	243	active
8725	Xã Định Trung	243	active
8728	Phường Khai Quang	243	active
8731	Xã Thanh Trù	243	active
8734	Phường Trưng Trắc	244	active
8737	Phường Hùng Vương	244	active
8740	Phường Trưng Nhị	244	active
8743	Phường Phúc Thắng	244	active
8746	Phường Xuân Hoà	244	active
8747	Phường Đồng Xuân	244	active
8749	Xã Ngọc Thanh	244	active
8752	Xã Cao Minh	244	active
8755	Phường Nam Viêm	244	active
8758	Phường Tiền Châu	244	active
8761	Thị trấn Lập Thạch	246	active
8764	Xã Quang Sơn	246	active
8767	Xã Ngọc Mỹ	246	active
8770	Xã Hợp Lý	246	active
8785	Xã Bắc Bình	246	active
8788	Xã Thái Hòa	246	active
8789	Thị trấn Hoa Sơn	246	active
8791	Xã Liễn Sơn	246	active
8794	Xã Xuân Hòa	246	active
8797	Xã Vân Trục	246	active
8812	Xã Liên Hòa	246	active
8815	Xã Tử Du	246	active
8833	Xã Bàn Giản	246	active
8836	Xã Xuân Lôi	246	active
8839	Xã Đồng Ích	246	active
8842	Xã Tiên Lữ	246	active
8845	Xã Văn Quán	246	active
8857	Xã Đình Chu	246	active
8863	Xã Triệu Đề	246	active
8866	Xã Sơn Đông	246	active
8869	Thị trấn Hợp Hòa	247	active
8872	Xã Hoàng Hoa	247	active
8875	Xã Đồng Tĩnh	247	active
8878	Xã Kim Long	247	active
8881	Xã Hướng Đạo	247	active
8884	Xã Đạo Tú	247	active
8887	Xã An Hòa	247	active
8890	Xã Thanh Vân	247	active
8893	Xã Duy Phiên	247	active
8896	Xã Hoàng Đan	247	active
8899	Xã Hoàng Lâu	247	active
8902	Xã Vân Hội	247	active
8905	Xã Hợp Thịnh	247	active
8908	Thị trấn Tam Đảo	248	active
8911	Thị trấn Hợp Châu	248	active
8914	Xã Đạo Trù	248	active
8917	Xã Yên Dương	248	active
8920	Xã Bồ Lý	248	active
8923	Thị trấn Đại Đình	248	active
8926	Xã Tam Quan	248	active
8929	Xã Hồ Sơn	248	active
8932	Xã Minh Quang	248	active
8935	Thị trấn Hương Canh	249	active
8936	Thị trấn Gia Khánh	249	active
8938	Xã Trung Mỹ	249	active
8944	Thị trấn Bá Hiến	249	active
8947	Xã Thiện Kế	249	active
8950	Xã Hương Sơn	249	active
8953	Xã Tam Hợp	249	active
8956	Xã Quất Lưu	249	active
8959	Xã Sơn Lôi	249	active
8962	Thị trấn Đạo Đức	249	active
8965	Xã Tân Phong	249	active
8968	Thị trấn Thanh Lãng	249	active
8971	Xã Phú Xuân	249	active
9025	Thị trấn Yên Lạc	251	active
9028	Xã Đồng Cương	251	active
9031	Xã Đồng Văn	251	active
9034	Xã Bình Định	251	active
9037	Xã Trung Nguyên	251	active
9040	Xã Tề Lỗ	251	active
9043	Xã Tam Hồng	251	active
9046	Xã Yên Đồng	251	active
9049	Xã Văn Tiến	251	active
9052	Xã Nguyệt Đức	251	active
9055	Xã Yên Phương	251	active
9058	Xã Hồng Phương	251	active
9061	Xã Trung Kiên	251	active
9064	Xã Liên Châu	251	active
9067	Xã Đại Tự	251	active
9070	Xã Hồng Châu	251	active
9073	Xã Trung Hà	251	active
9076	Thị trấn Vĩnh Tường	252	active
9079	Xã Kim Xá	252	active
9082	Xã Yên Bình	252	active
9085	Xã Chấn Hưng	252	active
9088	Xã Nghĩa Hưng	252	active
9091	Xã Yên Lập	252	active
9094	Xã Việt Xuân	252	active
9097	Xã Bồ Sao	252	active
9100	Xã Đại Đồng	252	active
9103	Xã Tân Tiến	252	active
9106	Xã Lũng Hoà	252	active
9109	Xã Cao Đại	252	active
9112	Thị Trấn Thổ Tang	252	active
9115	Xã Vĩnh Sơn	252	active
9118	Xã Bình Dương	252	active
9124	Xã Tân Phú	252	active
9127	Xã Thượng Trưng	252	active
9130	Xã Vũ Di	252	active
9133	Xã Lý Nhân	252	active
9136	Xã Tuân Chính	252	active
9139	Xã Vân Xuân	252	active
9142	Xã Tam Phúc	252	active
9145	Thị trấn Tứ Trưng	252	active
9148	Xã Ngũ Kiên	252	active
9151	Xã An Tường	252	active
9154	Xã Vĩnh Thịnh	252	active
9157	Xã Phú Đa	252	active
9160	Xã Vĩnh Ninh	252	active
8773	Xã Lãng Công	253	active
8776	Xã Quang Yên	253	active
8779	Xã Bạch Lưu	253	active
8782	Xã Hải Lựu	253	active
8800	Xã Đồng Quế	253	active
8803	Xã Nhân Đạo	253	active
8806	Xã Đôn Nhân	253	active
8809	Xã Phương Khoan	253	active
8818	Xã Tân Lập	253	active
8821	Xã Nhạo Sơn	253	active
8824	Thị trấn Tam Sơn	253	active
8827	Xã Như Thụy	253	active
8830	Xã Yên Thạch	253	active
8848	Xã Đồng Thịnh	253	active
8851	Xã Tứ Yên	253	active
8854	Xã Đức Bác	253	active
8860	Xã Cao Phong	253	active
9163	Phường Vũ Ninh	256	active
9166	Phường Đáp Cầu	256	active
9169	Phường Thị Cầu	256	active
9172	Phường Kinh Bắc	256	active
9175	Phường Vệ An	256	active
9178	Phường Tiền An	256	active
9181	Phường Đại Phúc	256	active
9184	Phường Ninh Xá	256	active
9187	Phường Suối Hoa	256	active
9190	Phường Võ Cường	256	active
9214	Phường Hòa Long	256	active
9226	Phường Vạn An	256	active
9235	Phường Khúc Xuyên	256	active
9244	Phường Phong Khê	256	active
9256	Phường Kim Chân	256	active
9271	Phường Vân Dương	256	active
9286	Phường Nam Sơn	256	active
9325	Phường Khắc Niệm	256	active
9331	Phường Hạp Lĩnh	256	active
9193	Thị trấn Chờ	258	active
9196	Xã Dũng Liệt	258	active
9199	Xã Tam Đa	258	active
9202	Xã Tam Giang	258	active
9205	Xã Yên Trung	258	active
9208	Xã Thụy Hòa	258	active
9211	Xã Hòa Tiến	258	active
9217	Xã Đông Tiến	258	active
9220	Xã Yên Phụ	258	active
9223	Xã Trung Nghĩa	258	active
9229	Xã Đông Phong	258	active
9232	Xã Long Châu	258	active
9238	Xã Văn Môn	258	active
9241	Xã Đông Thọ	258	active
9247	Phường Phố Mới	259	active
9250	Xã Việt Thống	259	active
9253	Phường Đại Xuân	259	active
9259	Phường Nhân Hòa	259	active
9262	Phường Bằng An	259	active
9265	Phường Phương Liễu	259	active
9268	Phường Quế Tân	259	active
9274	Phường Phù Lương	259	active
9277	Xã Phù Lãng	259	active
9280	Phường Phượng Mao	259	active
9283	Phường Việt Hùng	259	active
9289	Xã Ngọc Xá	259	active
9292	Xã Châu Phong	259	active
9295	Phường Bồng Lai	259	active
9298	Phường Cách Bi	259	active
9301	Xã Đào Viên	259	active
9304	Xã Yên Giả	259	active
9307	Xã Mộ Đạo	259	active
9310	Xã Đức Long	259	active
9313	Xã Chi Lăng	259	active
9316	Xã Hán Quảng	259	active
9319	Thị trấn Lim	260	active
9322	Xã Phú Lâm	260	active
9328	Xã Nội Duệ	260	active
9334	Xã Liên Bão	260	active
9337	Xã Hiên Vân	260	active
9340	Xã Hoàn Sơn	260	active
9343	Xã Lạc Vệ	260	active
9346	Xã Việt Đoàn	260	active
9349	Xã Phật Tích	260	active
9352	Xã Tân Chi	260	active
9355	Xã Đại Đồng	260	active
9358	Xã Tri Phương	260	active
9361	Xã Minh Đạo	260	active
9364	Xã Cảnh Hưng	260	active
9367	Phường Đông Ngàn	261	active
9370	Phường Tam Sơn	261	active
9373	Phường Hương Mạc	261	active
9376	Phường Tương Giang	261	active
9379	Phường Phù Khê	261	active
9382	Phường Đồng Kỵ	261	active
9383	Phường Trang Hạ	261	active
9385	Phường Đồng Nguyên	261	active
9388	Phường Châu Khê	261	active
9391	Phường Tân Hồng	261	active
9394	Phường Đình Bảng	261	active
9397	Phường Phù Chẩn	261	active
9400	Phường Hồ	262	active
9403	Xã Hoài Thượng	262	active
9406	Xã Đại Đồng Thành	262	active
9409	Xã Mão Điền	262	active
9412	Phường Song Hồ	262	active
9415	Xã Đình Tổ	262	active
9418	Phường An Bình	262	active
9421	Phường Trí Quả	262	active
9424	Phường Gia Đông	262	active
9427	Phường Thanh Khương	262	active
9430	Phường Trạm Lộ	262	active
9433	Phường Xuân Lâm	262	active
9436	Phường Hà Mãn	262	active
9439	Xã Ngũ Thái	262	active
9442	Xã Nguyệt Đức	262	active
9445	Phường Ninh Xá	262	active
9448	Xã Nghĩa Đạo	262	active
9451	Xã Song Liễu	262	active
9454	Thị trấn Gia Bình	263	active
9457	Xã Vạn Ninh	263	active
9460	Xã Thái Bảo	263	active
9463	Xã Giang Sơn	263	active
9466	Xã Cao Đức	263	active
9469	Xã Đại Lai	263	active
9472	Xã Song Giang	263	active
9475	Xã Bình Dương	263	active
9478	Xã Lãng Ngâm	263	active
9481	Xã Nhân Thắng	263	active
9484	Xã Xuân Lai	263	active
9487	Xã Đông Cứu	263	active
9490	Xã Đại Bái	263	active
9493	Xã Quỳnh Phú	263	active
9496	Thị trấn Thứa	264	active
9499	Xã An Thịnh	264	active
9502	Xã Trung Kênh	264	active
9505	Xã Phú Hòa	264	active
9508	Xã Mỹ Hương	264	active
9511	Xã Tân Lãng	264	active
9514	Xã Quảng Phú	264	active
9517	Xã Trừng Xá	264	active
9520	Xã Lai Hạ	264	active
9523	Xã Trung Chính	264	active
9526	Xã Minh Tân	264	active
9529	Xã Bình Định	264	active
9532	Xã Phú Lương	264	active
9535	Xã Lâm Thao	264	active
10507	Phường Cẩm Thượng	288	active
10510	Phường Bình Hàn	288	active
10513	Phường Ngọc Châu	288	active
10514	Phường Nhị Châu	288	active
10516	Phường Quang Trung	288	active
10519	Phường Nguyễn Trãi	288	active
10522	Phường Phạm Ngũ Lão	288	active
10525	Phường Trần Hưng Đạo	288	active
10528	Phường Trần Phú	288	active
10531	Phường Thanh Bình	288	active
10532	Phường Tân Bình	288	active
10534	Phường Lê Thanh Nghị	288	active
10537	Phường Hải Tân	288	active
10540	Phường Tứ Minh	288	active
10543	Phường Việt Hoà	288	active
10660	Phường Ái Quốc	288	active
10663	Xã An Thượng	288	active
10672	Phường Nam Đồng	288	active
10822	Xã Quyết Thắng	288	active
10837	Xã Tiền Tiến	288	active
11002	Phường Thạch Khôi	288	active
11005	Xã Liên Hồng	288	active
11011	Phường Tân Hưng	288	active
11017	Xã Gia Xuyên	288	active
11077	Xã Ngọc Sơn	288	active
10546	Phường Phả Lại	290	active
10549	Phường Sao Đỏ	290	active
10552	Phường Bến Tắm	290	active
10555	Xã Hoàng Hoa Thám	290	active
10558	Xã Bắc An	290	active
10561	Xã Hưng Đạo	290	active
10564	Xã Lê Lợi	290	active
10567	Phường Hoàng Tiến	290	active
10570	Phường Cộng Hoà	290	active
10573	Phường Hoàng Tân	290	active
10576	Phường Cổ Thành	290	active
10579	Phường Văn An	290	active
10582	Phường Chí Minh	290	active
10585	Phường Văn Đức	290	active
10588	Phường Thái Học	290	active
10591	Xã Nhân Huệ	290	active
10594	Phường An Lạc	290	active
10600	Phường Đồng Lạc	290	active
10603	Phường Tân Dân	290	active
10606	Thị trấn Nam Sách	291	active
10609	Xã Nam Hưng	291	active
10612	Xã Nam Tân	291	active
10615	Xã Hợp Tiến	291	active
10618	Xã Hiệp Cát	291	active
10621	Xã Thanh Quang	291	active
10624	Xã Quốc Tuấn	291	active
10627	Xã Nam Chính	291	active
10630	Xã An Bình	291	active
10633	Xã Nam Trung	291	active
10636	Xã An Sơn	291	active
10639	Xã Cộng Hòa	291	active
10642	Xã Thái Tân	291	active
10645	Xã An Lâm	291	active
10648	Xã Phú Điền	291	active
10651	Xã Nam Hồng	291	active
10654	Xã Hồng Phong	291	active
10657	Xã Đồng Lạc	291	active
10666	Xã Minh Tân	291	active
10675	Phường An Lưu	292	active
10678	Xã Bạch Đằng	292	active
10681	Phường Thất Hùng	292	active
10684	Xã Lê Ninh	292	active
10687	Xã Hoành Sơn	292	active
10693	Phường Phạm Thái	292	active
10696	Phường Duy Tân	292	active
10699	Phường Tân Dân	292	active
10702	Phường Minh Tân	292	active
10705	Xã Quang Thành	292	active
10708	Xã Hiệp Hòa	292	active
10714	Phường Phú Thứ	292	active
10717	Xã Thăng Long	292	active
10720	Xã Lạc Long	292	active
10723	Phường An Sinh	292	active
10726	Phường Hiệp Sơn	292	active
10729	Xã Thượng Quận	292	active
10732	Phường An Phụ	292	active
10735	Phường Hiệp An	292	active
10738	Phường Long Xuyên	292	active
10741	Phường Thái Thịnh	292	active
10744	Phường Hiến Thành	292	active
10747	Xã Minh Hòa	292	active
10750	Thị trấn Phú Thái	293	active
10753	Xã Lai Vu	293	active
10756	Xã Cộng Hòa	293	active
10759	Xã Thượng Vũ	293	active
10762	Xã Cổ Dũng	293	active
10768	Xã Tuấn Việt	293	active
10771	Xã Kim Xuyên	293	active
10774	Xã Phúc Thành A	293	active
10777	Xã Ngũ Phúc	293	active
10780	Xã Kim Anh	293	active
10783	Xã Kim Liên	293	active
10786	Xã Kim Tân	293	active
10792	Xã Kim Đính	293	active
10798	Xã Bình Dân	293	active
10801	Xã Tam Kỳ	293	active
10804	Xã Đồng Cẩm	293	active
10807	Xã Liên Hòa	293	active
10810	Xã Đại Đức	293	active
10813	Thị trấn Thanh Hà	294	active
10816	Xã Hồng Lạc	294	active
10819	Xã Việt Hồng	294	active
10825	Xã Tân Việt	294	active
10828	Xã Cẩm Chế	294	active
10831	Xã Thanh An	294	active
10834	Xã Thanh Lang	294	active
10840	Xã Tân An	294	active
10843	Xã Liên Mạc	294	active
10846	Xã Thanh Hải	294	active
10849	Xã Thanh Khê	294	active
10852	Xã Thanh Xá	294	active
10855	Xã Thanh Xuân	294	active
10861	Xã Thanh Thủy	294	active
10864	Xã An Phượng	294	active
10867	Xã Thanh Sơn	294	active
10876	Xã Thanh Quang	294	active
10879	Xã Thanh Hồng	294	active
10882	Xã Thanh Cường	294	active
10885	Xã Vĩnh Lập	294	active
10888	Thị trấn Cẩm Giang	295	active
10891	Thị trấn Lai Cách	295	active
10894	Xã Cẩm Hưng	295	active
10897	Xã Cẩm Hoàng	295	active
10900	Xã Cẩm Văn	295	active
10903	Xã Ngọc Liên	295	active
10906	Xã Thạch Lỗi	295	active
10909	Xã Cẩm Vũ	295	active
10912	Xã Đức Chính	295	active
10918	Xã Định Sơn	295	active
10924	Xã Lương Điền	295	active
10927	Xã Cao An	295	active
10930	Xã Tân Trường	295	active
10933	Xã Cẩm Phúc	295	active
10936	Xã Cẩm Điền	295	active
10939	Xã Cẩm Đông	295	active
10942	Xã Cẩm Đoài	295	active
10945	Thị trấn Kẻ Sặt	296	active
10951	Xã Vĩnh Hưng	296	active
10954	Xã Hùng Thắng	296	active
10960	Xã Vĩnh Hồng	296	active
10963	Xã Long Xuyên	296	active
10966	Xã Tân Việt	296	active
10969	Xã Thúc Kháng	296	active
10972	Xã Tân Hồng	296	active
10975	Xã Bình Minh	296	active
10978	Xã Hồng Khê	296	active
10981	Xã Thái Học	296	active
10984	Xã Cổ Bì	296	active
10987	Xã Nhân Quyền	296	active
10990	Xã Thái Dương	296	active
10993	Xã Thái Hòa	296	active
10996	Xã Bình Xuyên	296	active
10999	Thị trấn Gia Lộc	297	active
11008	Xã Thống Nhất	297	active
11020	Xã Yết Kiêu	297	active
11029	Xã Gia Tân	297	active
11032	Xã Tân Tiến	297	active
11035	Xã Gia Khánh	297	active
11038	Xã Gia Lương	297	active
11041	Xã Lê Lợi	297	active
11044	Xã Toàn Thắng	297	active
11047	Xã Hoàng Diệu	297	active
11050	Xã Hồng Hưng	297	active
11053	Xã Phạm Trấn	297	active
11056	Xã Đoàn Thượng	297	active
11059	Xã Thống Kênh	297	active
11062	Xã Quang Minh	297	active
11065	Xã Đồng Quang	297	active
11068	Xã Nhật Tân	297	active
11071	Xã Đức Xương	297	active
11074	Thị trấn Tứ Kỳ	298	active
11083	Xã Đại Sơn	298	active
11086	Xã Hưng Đạo	298	active
11089	Xã Ngọc Kỳ	298	active
11092	Xã Bình Lăng	298	active
11095	Xã Chí Minh	298	active
11098	Xã Tái Sơn	298	active
11101	Xã Quang Phục	298	active
11110	Xã Dân Chủ	298	active
11113	Xã Tân Kỳ	298	active
11116	Xã Quang Khải	298	active
11119	Xã Đại Hợp	298	active
11122	Xã Quảng Nghiệp	298	active
11125	Xã An Thanh	298	active
11128	Xã Minh Đức	298	active
11131	Xã Văn Tố	298	active
11134	Xã Quang Trung	298	active
11137	Xã Phượng Kỳ	298	active
11140	Xã Cộng Lạc	298	active
11143	Xã Tiên Động	298	active
11146	Xã Nguyên Giáp	298	active
11149	Xã Hà Kỳ	298	active
11152	Xã Hà Thanh	298	active
11155	Thị trấn Ninh Giang	299	active
11161	Xã Ứng Hoè	299	active
11164	Xã Nghĩa An	299	active
11167	Xã Hồng Đức	299	active
11173	Xã An Đức	299	active
11176	Xã Vạn Phúc	299	active
11179	Xã Tân Hương	299	active
11185	Xã Vĩnh Hòa	299	active
11188	Xã Đông Xuyên	299	active
11197	Xã Tân Phong	299	active
11200	Xã Ninh Hải	299	active
11203	Xã Đồng Tâm	299	active
11206	Xã Tân Quang	299	active
11209	Xã Kiến Quốc	299	active
11215	Xã Hồng Dụ	299	active
11218	Xã Văn Hội	299	active
11224	Xã Hồng Phong	299	active
11227	Xã Hiệp Lực	299	active
11230	Xã Hồng Phúc	299	active
11233	Xã Hưng Long	299	active
11239	Thị trấn Thanh Miện	300	active
11242	Xã Thanh Tùng	300	active
11245	Xã Phạm Kha	300	active
11248	Xã Ngô Quyền	300	active
11251	Xã Đoàn Tùng	300	active
11254	Xã Hồng Quang	300	active
11257	Xã Tân Trào	300	active
11260	Xã Lam Sơn	300	active
11263	Xã Đoàn Kết	300	active
11266	Xã Lê Hồng	300	active
11269	Xã Tứ Cường	300	active
11275	Xã Ngũ Hùng	300	active
11278	Xã Cao Thắng	300	active
11281	Xã Chi Lăng Bắc	300	active
11284	Xã Chi Lăng Nam	300	active
11287	Xã Thanh Giang	300	active
11293	Xã Hồng Phong	300	active
11296	Phường Quán Toan	303	active
11299	Phường Hùng Vương	303	active
11302	Phường Sở Dầu	303	active
11305	Phường Thượng Lý	303	active
11308	Phường Hạ Lý	303	active
11311	Phường Minh Khai	303	active
11314	Phường Trại Chuối	303	active
11320	Phường Hoàng Văn Thụ	303	active
11323	Phường Phan Bội Châu	303	active
11329	Phường Máy Chai	304	active
11332	Phường Máy Tơ	304	active
11335	Phường Vạn Mỹ	304	active
11338	Phường Cầu Tre	304	active
11341	Phường Lạc Viên	304	active
11344	Phường Cầu Đất	304	active
11347	Phường Gia Viên	304	active
11350	Phường Đông Khê	304	active
11356	Phường Lê Lợi	304	active
11359	Phường Đằng Giang	304	active
11362	Phường Lạch Tray	304	active
11365	Phường Đổng Quốc Bình	304	active
11368	Phường Cát Dài	305	active
11371	Phường An Biên	305	active
11374	Phường Lam Sơn	305	active
11377	Phường An Dương	305	active
11380	Phường Trần Nguyên Hãn	305	active
11383	Phường Hồ Nam	305	active
11386	Phường Trại Cau	305	active
11389	Phường Dư Hàng	305	active
11392	Phường Hàng Kênh	305	active
11395	Phường Đông Hải	305	active
11398	Phường Niệm Nghĩa	305	active
11401	Phường Nghĩa Xá	305	active
11404	Phường Dư Hàng Kênh	305	active
11405	Phường Kênh Dương	305	active
11407	Phường Vĩnh Niệm	305	active
11410	Phường Đông Hải 1	306	active
11411	Phường Đông Hải 2	306	active
11413	Phường Đằng Lâm	306	active
11414	Phường Thành Tô	306	active
11416	Phường Đằng Hải	306	active
11419	Phường Nam Hải	306	active
11422	Phường Cát Bi	306	active
11425	Phường Tràng Cát	306	active
11428	Phường Quán Trữ	307	active
11429	Phường Lãm Hà	307	active
11431	Phường Đồng Hoà	307	active
11434	Phường Bắc Sơn	307	active
11437	Phường Nam Sơn	307	active
11440	Phường Ngọc Sơn	307	active
11443	Phường Trần Thành Ngọ	307	active
11446	Phường Văn Đẩu	307	active
11449	Phường Phù Liễn	307	active
11452	Phường Tràng Minh	307	active
11455	Phường Ngọc Xuyên	308	active
11458	Phường Hải Sơn	308	active
11461	Phường Vạn Hương	308	active
11465	Phường Minh Đức	308	active
11467	Phường Bàng La	308	active
11737	Phường Hợp Đức	308	active
11683	Phường Đa Phúc	309	active
11686	Phường Hưng Đạo	309	active
11689	Phường Anh Dũng	309	active
11692	Phường Hải Thành	309	active
11707	Phường Hoà Nghĩa	309	active
11740	Phường Tân Thành	309	active
11470	Thị trấn Núi Đèo	311	active
11473	Thị trấn Minh Đức	311	active
11476	Xã Lại Xuân	311	active
11479	Xã An Sơn	311	active
11482	Xã Kỳ Sơn	311	active
11485	Xã Liên Khê	311	active
11488	Xã Lưu Kiếm	311	active
11491	Xã Lưu Kỳ	311	active
11494	Xã Gia Minh	311	active
11497	Xã Gia Đức	311	active
11500	Xã Minh Tân	311	active
11503	Xã Phù Ninh	311	active
11506	Xã Quảng Thanh	311	active
11509	Xã Chính Mỹ	311	active
11512	Xã Kênh Giang	311	active
11515	Xã Hợp Thành	311	active
11518	Xã Cao Nhân	311	active
11521	Xã Mỹ Đồng	311	active
11524	Xã Đông Sơn	311	active
11527	Xã Hoà Bình	311	active
11530	Xã Trung Hà	311	active
11533	Xã An Lư	311	active
11536	Xã Thuỷ Triều	311	active
11539	Xã Ngũ Lão	311	active
11542	Xã Phục Lễ	311	active
11545	Xã Tam Hưng	311	active
11548	Xã Phả Lễ	311	active
11551	Xã Lập Lễ	311	active
11554	Xã Kiền Bái	311	active
11557	Xã Thiên Hương	311	active
11560	Xã Thuỷ Sơn	311	active
11563	Xã Thuỷ Đường	311	active
11566	Xã Hoàng Động	311	active
11569	Xã Lâm Động	311	active
11572	Xã Hoa Động	311	active
11575	Xã Tân Dương	311	active
11578	Xã Dương Quan	311	active
11581	Thị trấn An Dương	312	active
11584	Xã Lê Thiện	312	active
11587	Xã Đại Bản	312	active
11590	Xã An Hoà	312	active
11593	Xã Hồng Phong	312	active
11596	Xã Tân Tiến	312	active
11599	Xã An Hưng	312	active
11602	Xã An Hồng	312	active
11605	Xã Bắc Sơn	312	active
11608	Xã Nam Sơn	312	active
11611	Xã Lê Lợi	312	active
11614	Xã Đặng Cương	312	active
11617	Xã Đồng Thái	312	active
11620	Xã Quốc Tuấn	312	active
11623	Xã An Đồng	312	active
11626	Xã Hồng Thái	312	active
11629	Thị trấn An Lão	313	active
11632	Xã Bát Trang	313	active
11635	Xã Trường Thọ	313	active
11638	Xã Trường Thành	313	active
11641	Xã An Tiến	313	active
11644	Xã Quang Hưng	313	active
11647	Xã Quang Trung	313	active
11650	Xã Quốc Tuấn	313	active
11656	Thị trấn Trường Sơn	313	active
11659	Xã Tân Dân	313	active
11662	Xã Thái Sơn	313	active
11665	Xã Tân Viên	313	active
11668	Xã Mỹ Đức	313	active
11671	Xã Chiến Thắng	313	active
11674	Xã An Thọ	313	active
11677	Xã An Thái	313	active
11680	Thị trấn Núi Đối	314	active
11695	Xã Đông Phương	314	active
11698	Xã Thuận Thiên	314	active
11701	Xã Hữu Bằng	314	active
11704	Xã Đại Đồng	314	active
11710	Xã Ngũ Phúc	314	active
11713	Xã Kiến Quốc	314	active
11716	Xã Du Lễ	314	active
11719	Xã Thuỵ Hương	314	active
11722	Xã Thanh Sơn	314	active
11725	Xã Minh Tân	314	active
11728	Xã Đại Hà	314	active
11731	Xã Ngũ Đoan	314	active
11734	Xã Tân Phong	314	active
11743	Xã Tân Trào	314	active
11746	Xã Đoàn Xá	314	active
11749	Xã Tú Sơn	314	active
11752	Xã Đại Hợp	314	active
11755	Thị trấn Tiên Lãng	315	active
11758	Xã Đại Thắng	315	active
11761	Xã Tiên Cường	315	active
11764	Xã Tự Cường	315	active
11770	Xã Quyết Tiến	315	active
11773	Xã Khởi Nghĩa	315	active
11776	Xã Tiên Thanh	315	active
11779	Xã Cấp Tiến	315	active
11782	Xã Kiến Thiết	315	active
11785	Xã Đoàn Lập	315	active
11788	Xã Bạch Đằng	315	active
11791	Xã Quang Phục	315	active
11794	Xã Toàn Thắng	315	active
11797	Xã Tiên Thắng	315	active
11800	Xã Tiên Minh	315	active
11803	Xã Bắc Hưng	315	active
11806	Xã Nam Hưng	315	active
11809	Xã Hùng Thắng	315	active
11812	Xã Tây Hưng	315	active
11815	Xã Đông Hưng	315	active
11821	Xã Vinh Quang	315	active
11824	Thị trấn Vĩnh Bảo	316	active
11827	Xã Dũng Tiến	316	active
11830	Xã Giang Biên	316	active
11833	Xã Thắng Thuỷ	316	active
11836	Xã Trung Lập	316	active
11839	Xã Việt Tiến	316	active
11842	Xã Vĩnh An	316	active
11845	Xã Vĩnh Long	316	active
11848	Xã Hiệp Hoà	316	active
11851	Xã Hùng Tiến	316	active
11854	Xã An Hoà	316	active
11857	Xã Tân Hưng	316	active
11860	Xã Tân Liên	316	active
11863	Xã Nhân Hoà	316	active
11866	Xã Tam Đa	316	active
11869	Xã Hưng Nhân	316	active
11872	Xã Vinh Quang	316	active
11875	Xã Đồng Minh	316	active
11878	Xã Thanh Lương	316	active
11881	Xã Liên Am	316	active
11884	Xã Lý Học	316	active
11887	Xã Tam Cường	316	active
11890	Xã Hoà Bình	316	active
11893	Xã Tiền Phong	316	active
11896	Xã Vĩnh Phong	316	active
11899	Xã Cộng Hiền	316	active
11902	Xã Cao Minh	316	active
11905	Xã Cổ Am	316	active
11908	Xã Vĩnh Tiến	316	active
11911	Xã Trấn Dương	316	active
11914	Thị trấn Cát Bà	317	active
11917	Thị trấn Cát Hải	317	active
11920	Xã Nghĩa Lộ	317	active
11923	Xã Đồng Bài	317	active
11926	Xã Hoàng Châu	317	active
11929	Xã Văn Phong	317	active
11932	Xã Phù Long	317	active
11935	Xã Gia Luận	317	active
11938	Xã Hiền Hào	317	active
11941	Xã Trân Châu	317	active
11944	Xã Việt Hải	317	active
11947	Xã Xuân Đám	317	active
11950	Phường Lam Sơn	323	active
11953	Phường Hiến Nam	323	active
11956	Phường An Tảo	323	active
11959	Phường Lê Lợi	323	active
11962	Phường Minh Khai	323	active
11965	Phường Quang Trung	323	active
11968	Phường Hồng Châu	323	active
11971	Xã Trung Nghĩa	323	active
11974	Xã Liên Phương	323	active
11977	Xã Hồng Nam	323	active
11980	Xã Quảng Châu	323	active
11983	Xã Bảo Khê	323	active
12331	Xã Phú Cường	323	active
12334	Xã Hùng Cường	323	active
12382	Xã Phương Chiểu	323	active
12385	Xã Tân Hưng	323	active
12388	Xã Hoàng Hanh	323	active
11986	Thị trấn Như Quỳnh	325	active
11989	Xã Lạc Đạo	325	active
11992	Xã Chỉ Đạo	325	active
11995	Xã Đại Đồng	325	active
11998	Xã Việt Hưng	325	active
12001	Xã Tân Quang	325	active
12004	Xã Đình Dù	325	active
12007	Xã Minh Hải	325	active
12010	Xã Lương Tài	325	active
12013	Xã Trưng Trắc	325	active
12016	Xã Lạc Hồng	325	active
12019	Thị trấn Văn Giang	326	active
12022	Xã Xuân Quan	326	active
12025	Xã Cửu Cao	326	active
12028	Xã Phụng Công	326	active
12031	Xã Nghĩa Trụ	326	active
12034	Xã Long Hưng	326	active
12037	Xã Vĩnh Khúc	326	active
12040	Xã Liên Nghĩa	326	active
12043	Xã Tân Tiến	326	active
12046	Xã Thắng Lợi	326	active
12049	Xã Mễ Sở	326	active
12052	Thị trấn Yên Mỹ	327	active
12055	Xã Giai Phạm	327	active
12058	Xã Nghĩa Hiệp	327	active
12061	Xã Đồng Than	327	active
12064	Xã Ngọc Long	327	active
12067	Xã Liêu Xá	327	active
12070	Xã Hoàn Long	327	active
12073	Xã Tân Lập	327	active
12076	Xã Thanh Long	327	active
12079	Xã Yên Phú	327	active
12082	Xã Việt Cường	327	active
12085	Xã Trung Hòa	327	active
12088	Xã Yên Hòa	327	active
12091	Xã Minh Châu	327	active
12094	Xã Trung Hưng	327	active
12097	Xã Lý Thường Kiệt	327	active
12100	Xã Tân Việt	327	active
12103	Phường Bần Yên Nhân	328	active
12106	Phường Phan Đình Phùng	328	active
12109	Xã Cẩm Xá	328	active
12112	Xã Dương Quang	328	active
12115	Xã Hòa Phong	328	active
12118	Phường Nhân Hòa	328	active
12121	Phường Dị Sử	328	active
12124	Phường Bạch Sam	328	active
12127	Phường Minh Đức	328	active
12130	Phường Phùng Chí Kiên	328	active
12133	Xã Xuân Dục	328	active
12136	Xã Ngọc Lâm	328	active
12139	Xã Hưng Long	328	active
12142	Thị trấn Ân Thi	329	active
12145	Xã Phù Ủng	329	active
12148	Xã Bắc Sơn	329	active
12151	Xã Bãi Sậy	329	active
12154	Xã Đào Dương	329	active
12157	Xã Tân Phúc	329	active
12160	Xã Vân Du	329	active
12163	Xã Quang Vinh	329	active
12166	Xã Xuân Trúc	329	active
12169	Xã Hoàng Hoa Thám	329	active
12172	Xã Quảng Lãng	329	active
12175	Xã Văn Nhuệ	329	active
12178	Xã Đặng Lễ	329	active
12181	Xã Cẩm Ninh	329	active
12184	Xã Nguyễn Trãi	329	active
12187	Xã Đa Lộc	329	active
12190	Xã Hồ Tùng Mậu	329	active
12193	Xã Tiền Phong	329	active
12196	Xã Hồng Vân	329	active
12199	Xã Hồng Quang	329	active
12202	Xã Hạ Lễ	329	active
12205	Thị trấn Khoái Châu	330	active
12208	Xã Đông Tảo	330	active
12211	Xã Bình Minh	330	active
12214	Xã Dạ Trạch	330	active
12217	Xã Hàm Tử	330	active
12220	Xã Ông Đình	330	active
12223	Xã Tân Dân	330	active
12226	Xã Tứ Dân	330	active
12229	Xã An Vĩ	330	active
12232	Xã Đông Kết	330	active
12235	Xã Bình Kiều	330	active
12238	Xã Dân Tiến	330	active
12241	Xã Đồng Tiến	330	active
12244	Xã Hồng Tiến	330	active
12247	Xã Tân Châu	330	active
12250	Xã Liên Khê	330	active
12253	Xã Phùng Hưng	330	active
12256	Xã Việt Hòa	330	active
12259	Xã Đông Ninh	330	active
12262	Xã Đại Tập	330	active
12265	Xã Chí Tân	330	active
12268	Xã Đại Hưng	330	active
12271	Xã Thuần Hưng	330	active
12274	Xã Thành Công	330	active
12277	Xã Nhuế Dương	330	active
12280	Thị trấn Lương Bằng	331	active
12283	Xã Nghĩa Dân	331	active
12286	Xã Toàn Thắng	331	active
12289	Xã Vĩnh Xá	331	active
12292	Xã Phạm Ngũ Lão	331	active
12295	Xã Thọ Vinh	331	active
12298	Xã Đồng Thanh	331	active
12301	Xã Song Mai	331	active
12304	Xã Chính Nghĩa	331	active
12307	Xã Nhân La	331	active
12310	Xã Phú Thịnh	331	active
12313	Xã Mai Động	331	active
12316	Xã Đức Hợp	331	active
12319	Xã Hùng An	331	active
12322	Xã Ngọc Thanh	331	active
12325	Xã Vũ Xá	331	active
12328	Xã Hiệp Cường	331	active
12337	Thị trấn Vương	332	active
12340	Xã Hưng Đạo	332	active
12343	Xã Ngô Quyền	332	active
12346	Xã Nhật Tân	332	active
12349	Xã Dị Chế	332	active
12352	Xã Lệ Xá	332	active
12355	Xã An Viên	332	active
12358	Xã Đức Thắng	332	active
12361	Xã Trung Dũng	332	active
12364	Xã Hải Triều	332	active
12367	Xã Thủ Sỹ	332	active
12370	Xã Thiện Phiến	332	active
12373	Xã Thụy Lôi	332	active
12376	Xã Cương Chính	332	active
12379	Xã Minh Phượng	332	active
12391	Thị trấn Trần Cao	333	active
12394	Xã Minh Tân	333	active
12397	Xã Phan Sào Nam	333	active
12400	Xã Quang Hưng	333	active
12403	Xã Minh Hoàng	333	active
12406	Xã Đoàn Đào	333	active
12409	Xã Tống Phan	333	active
12412	Xã Đình Cao	333	active
12415	Xã Nhật Quang	333	active
12418	Xã Tiền Tiến	333	active
12421	Xã Tam Đa	333	active
12424	Xã Minh Tiến	333	active
12427	Xã Nguyên Hòa	333	active
12430	Xã Tống Trân	333	active
12433	Phường Lê Hồng Phong	336	active
12436	Phường Bồ Xuyên	336	active
12439	Phường Đề Thám	336	active
12442	Phường Kỳ Bá	336	active
12445	Phường Quang Trung	336	active
12448	Phường Phú Khánh	336	active
12451	Phường Tiền Phong	336	active
12452	Phường Trần Hưng Đạo	336	active
12454	Phường Trần Lãm	336	active
12457	Xã Đông Hòa	336	active
12460	Phường Hoàng Diệu	336	active
12463	Xã Phú Xuân	336	active
12466	Xã Vũ Phúc	336	active
12469	Xã Vũ Chính	336	active
12817	Xã Đông Mỹ	336	active
12820	Xã Đông Thọ	336	active
13084	Xã Vũ Đông	336	active
13108	Xã Vũ Lạc	336	active
13225	Xã Tân Bình	336	active
12472	Thị trấn Quỳnh Côi	338	active
12475	Xã An Khê	338	active
12478	Xã An Đồng	338	active
12481	Xã Quỳnh Hoa	338	active
12484	Xã Quỳnh Lâm	338	active
12487	Xã Quỳnh Thọ	338	active
12490	Xã An Hiệp	338	active
12493	Xã Quỳnh Hoàng	338	active
12496	Xã Quỳnh Giao	338	active
12499	Xã An Thái	338	active
12502	Xã An Cầu	338	active
12505	Xã Quỳnh Hồng	338	active
12508	Xã Quỳnh Khê	338	active
12511	Xã Quỳnh Minh	338	active
12514	Xã An Ninh	338	active
12517	Xã Quỳnh Ngọc	338	active
12520	Xã Quỳnh Hải	338	active
12523	Thị trấn An Bài	338	active
12526	Xã An Ấp	338	active
12529	Xã Quỳnh Hội	338	active
12532	Xã Châu Sơn	338	active
12535	Xã Quỳnh Mỹ	338	active
12538	Xã An Quí	338	active
12541	Xã An Thanh	338	active
12547	Xã An Vũ	338	active
12550	Xã An Lễ	338	active
12553	Xã Quỳnh Hưng	338	active
12556	Xã Quỳnh Bảo	338	active
12559	Xã An Mỹ	338	active
12562	Xã Quỳnh Nguyên	338	active
12565	Xã An Vinh	338	active
12568	Xã Quỳnh Xá	338	active
12571	Xã An Dục	338	active
12574	Xã Đông Hải	338	active
12577	Xã Quỳnh Trang	338	active
12580	Xã An Tràng	338	active
12583	Xã Đồng Tiến	338	active
12586	Thị trấn Hưng Hà	339	active
12589	Xã Điệp Nông	339	active
12592	Xã Tân Lễ	339	active
12595	Xã Cộng Hòa	339	active
12598	Xã Dân Chủ	339	active
12601	Xã Canh Tân	339	active
12604	Xã Hòa Tiến	339	active
12607	Xã Hùng Dũng	339	active
12610	Xã Tân Tiến	339	active
12613	Thị trấn Hưng Nhân	339	active
12616	Xã Đoan Hùng	339	active
12619	Xã Duyên Hải	339	active
12622	Xã Tân Hòa	339	active
12625	Xã Văn Cẩm	339	active
12628	Xã Bắc Sơn	339	active
12631	Xã Đông Đô	339	active
12634	Xã Phúc Khánh	339	active
12637	Xã Liên Hiệp	339	active
12640	Xã Tây Đô	339	active
12643	Xã Thống Nhất	339	active
12646	Xã Tiến Đức	339	active
12649	Xã Thái Hưng	339	active
12652	Xã Thái Phương	339	active
12655	Xã Hòa Bình	339	active
12656	Xã Chi Lăng	339	active
12658	Xã Minh Khai	339	active
12661	Xã Hồng An	339	active
12664	Xã Kim Chung	339	active
12667	Xã Hồng Lĩnh	339	active
12670	Xã Minh Tân	339	active
12673	Xã Văn Lang	339	active
12676	Xã Độc Lập	339	active
12679	Xã Chí Hòa	339	active
12682	Xã Minh Hòa	339	active
12685	Xã Hồng Minh	339	active
12688	Thị trấn Đông Hưng	340	active
12691	Xã Đô Lương	340	active
12694	Xã Đông Phương	340	active
12697	Xã Liên Giang	340	active
12700	Xã An Châu	340	active
12703	Xã Đông Sơn	340	active
12706	Xã Đông Cường	340	active
12709	Xã Phú Lương	340	active
12712	Xã Mê Linh	340	active
12715	Xã Lô Giang	340	active
12718	Xã Đông La	340	active
12721	Xã Minh Tân	340	active
12724	Xã Đông Xá	340	active
12727	Xã Chương Dương	340	active
12730	Xã Nguyên Xá	340	active
12733	Xã Phong Châu	340	active
12736	Xã Hợp Tiến	340	active
12739	Xã Hồng Việt	340	active
12745	Xã Hà Giang	340	active
12748	Xã Đông Kinh	340	active
12751	Xã Đông Hợp	340	active
12754	Xã Thăng Long	340	active
12757	Xã Đông Các	340	active
12760	Xã Phú Châu	340	active
12763	Xã Liên Hoa	340	active
12769	Xã Đông Tân	340	active
12772	Xã Đông Vinh	340	active
12775	Xã Đông Động	340	active
12778	Xã Hồng Bạch	340	active
12784	Xã Trọng Quan	340	active
12790	Xã Hồng Giang	340	active
12793	Xã Đông Quan	340	active
12796	Xã Đông Quang	340	active
12799	Xã Đông Xuân	340	active
12802	Xã Đông Á	340	active
12808	Xã Đông Hoàng	340	active
12811	Xã Đông Dương	340	active
12823	Xã Minh Phú	340	active
12826	Thị trấn Diêm Điền	341	active
12832	Xã Thụy Trường	341	active
12841	Xã Hồng Dũng	341	active
12844	Xã Thụy Quỳnh	341	active
12847	Xã An Tân	341	active
12850	Xã Thụy Ninh	341	active
12853	Xã Thụy Hưng	341	active
12856	Xã Thụy Việt	341	active
12859	Xã Thụy Văn	341	active
12862	Xã Thụy Xuân	341	active
12865	Xã Dương Phúc	341	active
12868	Xã Thụy Trình	341	active
12871	Xã Thụy Bình	341	active
12874	Xã Thụy Chính	341	active
12877	Xã Thụy Dân	341	active
12880	Xã Thụy Hải	341	active
12889	Xã Thụy Liên	341	active
12892	Xã Thụy Duyên	341	active
12898	Xã Thụy Thanh	341	active
12901	Xã Thụy Sơn	341	active
12904	Xã Thụy Phong	341	active
12907	Xã Thái Thượng	341	active
12910	Xã Thái Nguyên	341	active
12916	Xã Dương Hồng Thủy	341	active
12919	Xã Thái Giang	341	active
12922	Xã Hòa An	341	active
12925	Xã Sơn Hà	341	active
12934	Xã Thái Phúc	341	active
12937	Xã Thái Hưng	341	active
12940	Xã Thái Đô	341	active
12943	Xã Thái Xuyên	341	active
12949	Xã Mỹ Lộc	341	active
12958	Xã Tân Học	341	active
12961	Xã Thái Thịnh	341	active
12964	Xã Thuần Thành	341	active
12967	Xã Thái Thọ	341	active
12970	Thị trấn Tiền Hải	342	active
12976	Xã Đông Trà	342	active
12979	Xã Đông Long	342	active
12982	Xã Đông Quí	342	active
12985	Xã Vũ Lăng	342	active
12988	Xã Đông Xuyên	342	active
12991	Xã Tây Lương	342	active
12994	Xã Tây Ninh	342	active
12997	Xã Đông Trung	342	active
13000	Xã Đông Hoàng	342	active
13003	Xã Đông Minh	342	active
13009	Xã Đông Phong	342	active
13012	Xã An Ninh	342	active
13018	Xã Đông Cơ	342	active
13021	Xã Tây Giang	342	active
13024	Xã Đông Lâm	342	active
13027	Xã Phương Công	342	active
13030	Xã Tây Phong	342	active
13033	Xã Tây Tiến	342	active
13036	Xã Nam Cường	342	active
13039	Xã Vân Trường	342	active
13042	Xã Nam Thắng	342	active
13045	Xã Nam Chính	342	active
13048	Xã Bắc Hải	342	active
13051	Xã Nam Thịnh	342	active
13054	Xã Nam Hà	342	active
13057	Xã Nam Thanh	342	active
13060	Xã Nam Trung	342	active
13063	Xã Nam Hồng	342	active
13066	Xã Nam Hưng	342	active
13069	Xã Nam Hải	342	active
13072	Xã Nam Phú	342	active
13075	Thị trấn Kiến Xương	343	active
13078	Xã Trà Giang	343	active
13081	Xã Quốc Tuấn	343	active
13087	Xã An Bình	343	active
13090	Xã Tây Sơn	343	active
13093	Xã Hồng Thái	343	active
13096	Xã Bình Nguyên	343	active
13102	Xã Lê Lợi	343	active
13111	Xã Vũ Lễ	343	active
13114	Xã Thanh Tân	343	active
13117	Xã Thượng Hiền	343	active
13120	Xã Nam Cao	343	active
13123	Xã Đình Phùng	343	active
13126	Xã Vũ Ninh	343	active
13129	Xã Vũ An	343	active
13132	Xã Quang Lịch	343	active
13135	Xã Hòa Bình	343	active
13138	Xã Bình Minh	343	active
13141	Xã Vũ Quí	343	active
13144	Xã Quang Bình	343	active
13150	Xã Vũ Trung	343	active
13153	Xã Vũ Thắng	343	active
13156	Xã Vũ Công	343	active
13159	Xã Vũ Hòa	343	active
13162	Xã Quang Minh	343	active
13165	Xã Quang Trung	343	active
13171	Xã Minh Quang	343	active
13174	Xã Vũ Bình	343	active
13177	Xã Minh Tân	343	active
13180	Xã Nam Bình	343	active
13183	Xã Bình Thanh	343	active
13186	Xã Bình Định	343	active
13189	Xã Hồng Tiến	343	active
13192	Thị trấn Vũ Thư	344	active
13195	Xã Hồng Lý	344	active
13198	Xã Đồng Thanh	344	active
13201	Xã Xuân Hòa	344	active
13204	Xã Hiệp Hòa	344	active
13207	Xã Phúc Thành	344	active
13210	Xã Tân Phong	344	active
13213	Xã Song Lãng	344	active
13216	Xã Tân Hòa	344	active
13219	Xã Việt Hùng	344	active
13222	Xã Minh Lãng	344	active
13228	Xã Minh Khai	344	active
13231	Xã Dũng Nghĩa	344	active
13234	Xã Minh Quang	344	active
13237	Xã Tam Quang	344	active
13240	Xã Tân Lập	344	active
13243	Xã Bách Thuận	344	active
13246	Xã Tự Tân	344	active
13249	Xã Song An	344	active
13252	Xã Trung An	344	active
13255	Xã Vũ Hội	344	active
13258	Xã Hòa Bình	344	active
13261	Xã Nguyên Xá	344	active
13264	Xã Việt Thuận	344	active
13267	Xã Vũ Vinh	344	active
13270	Xã Vũ Đoài	344	active
13273	Xã Vũ Tiến	344	active
13276	Xã Vũ Vân	344	active
13279	Xã Duy Nhất	344	active
13282	Xã Hồng Phong	344	active
13285	Phường Quang Trung	347	active
13288	Phường Lương Khánh Thiện	347	active
13291	Phường Lê Hồng Phong	347	active
13294	Phường Minh Khai	347	active
13297	Phường Hai Bà Trưng	347	active
13300	Phường Trần Hưng Đạo	347	active
13303	Phường Lam Hạ	347	active
13306	Xã Phù Vân	347	active
13309	Phường Liêm Chính	347	active
13312	Xã Liêm Chung	347	active
13315	Phường Thanh Châu	347	active
13318	Phường Châu Sơn	347	active
13366	Xã Tiên Tân	347	active
13372	Xã Tiên Hiệp	347	active
13381	Xã Tiên Hải	347	active
13426	Xã Kim Bình	347	active
13444	Xã Liêm Tuyền	347	active
13447	Xã Liêm Tiết	347	active
13459	Phường Thanh Tuyền	347	active
13507	Xã Đinh Xá	347	active
13513	Xã Trịnh Xá	347	active
13321	Phường Đồng Văn	349	active
13324	Phường Hòa Mạc	349	active
13327	Xã Mộc Bắc	349	active
13330	Phường Châu Giang	349	active
13333	Phường Bạch Thượng	349	active
13336	Phường Duy Minh	349	active
13339	Xã Mộc Nam	349	active
13342	Phường Duy Hải	349	active
13345	Xã Chuyên Ngoại	349	active
13348	Phường Yên Bắc	349	active
13351	Xã Trác Văn	349	active
13354	Phường Tiên Nội	349	active
13357	Phường Hoàng Đông	349	active
13360	Xã Yên Nam	349	active
13363	Xã Tiên Ngoại	349	active
13369	Xã Tiên Sơn	349	active
13384	Thị trấn Quế	350	active
13387	Xã Nguyễn Úy	350	active
13390	Xã Đại Cương	350	active
13393	Xã Lê Hồ	350	active
13396	Xã Tượng Lĩnh	350	active
13399	Xã Nhật Tựu	350	active
13402	Xã Nhật Tân	350	active
13405	Xã Đồng Hóa	350	active
13408	Xã Hoàng Tây	350	active
13411	Xã Tân Sơn	350	active
13414	Xã Thụy Lôi	350	active
13417	Xã Văn Xá	350	active
13420	Xã Khả Phong	350	active
13423	Xã Ngọc Sơn	350	active
13429	Thị trấn Ba Sao	350	active
13432	Xã Liên Sơn	350	active
13435	Xã Thi Sơn	350	active
13438	Xã Thanh Sơn	350	active
13441	Thị trấn Kiện Khê	351	active
13450	Xã Liêm Phong	351	active
13453	Xã Thanh Hà	351	active
13456	Xã Liêm Cần	351	active
13465	Xã Liêm Thuận	351	active
13468	Xã Thanh Thủy	351	active
13471	Xã Thanh Phong	351	active
13474	Thị trấn Tân Thanh	351	active
13477	Xã Thanh Tân	351	active
13480	Xã Liêm Túc	351	active
13483	Xã Liêm Sơn	351	active
13486	Xã Thanh Hương	351	active
13489	Xã Thanh Nghị	351	active
13492	Xã Thanh Tâm	351	active
13495	Xã Thanh Nguyên	351	active
13498	Xã Thanh Hải	351	active
13501	Thị trấn Bình Mỹ	352	active
13504	Xã Bình Nghĩa	352	active
13510	Xã Tràng An	352	active
13516	Xã Đồng Du	352	active
13519	Xã Ngọc Lũ	352	active
13522	Xã Hưng Công	352	active
13525	Xã Đồn Xá	352	active
13528	Xã An Ninh	352	active
13531	Xã Bồ Đề	352	active
13534	Xã Bối Cầu	352	active
13540	Xã An Nội	352	active
13543	Xã Vũ Bản	352	active
13546	Xã Trung Lương	352	active
13552	Xã An Đổ	352	active
13555	Xã La Sơn	352	active
13558	Xã Tiêu Động	352	active
13561	Xã An Lão	352	active
13567	Xã Hợp Lý	353	active
13570	Xã Nguyên Lý	353	active
13573	Xã Chính Lý	353	active
13576	Xã Chân Lý	353	active
13579	Xã Đạo Lý	353	active
13582	Xã Công Lý	353	active
13585	Xã Văn Lý	353	active
13588	Xã Bắc Lý	353	active
13591	Xã Đức Lý	353	active
13594	Xã Trần Hưng Đạo	353	active
13597	Thị trấn Vĩnh Trụ	353	active
13600	Xã Nhân Thịnh	353	active
13606	Xã Nhân Khang	353	active
13609	Xã Nhân Mỹ	353	active
13612	Xã Nhân Nghĩa	353	active
13615	Xã Nhân Chính	353	active
13618	Xã Nhân Bình	353	active
13621	Xã Phú Phúc	353	active
13624	Xã Xuân Khê	353	active
13627	Xã Tiến Thắng	353	active
13630	Xã Hòa Hậu	353	active
13633	Phường Hạ Long	356	active
13636	Phường Trần Tế Xương	356	active
13639	Phường Vị Hoàng	356	active
13642	Phường Vị Xuyên	356	active
13645	Phường Quang Trung	356	active
13648	Phường Cửa Bắc	356	active
13651	Phường Nguyễn Du	356	active
13654	Phường Bà Triệu	356	active
13657	Phường Trường Thi	356	active
13660	Phường Phan Đình Phùng	356	active
13663	Phường Ngô Quyền	356	active
13666	Phường Trần Hưng Đạo	356	active
13669	Phường Trần Đăng Ninh	356	active
13672	Phường Năng Tĩnh	356	active
13675	Phường Văn Miếu	356	active
13678	Phường Trần Quang Khải	356	active
13681	Phường Thống Nhất	356	active
13684	Phường Lộc Hạ	356	active
13687	Phường Lộc Vượng	356	active
13690	Phường Cửa Nam	356	active
13693	Phường Lộc Hòa	356	active
13696	Xã Nam Phong	356	active
13699	Phường Mỹ Xá	356	active
13702	Xã Lộc An	356	active
13705	Xã Nam Vân	356	active
13708	Thị trấn Mỹ Lộc	358	active
13711	Xã Mỹ Hà	358	active
13714	Xã Mỹ Tiến	358	active
13717	Xã Mỹ Thắng	358	active
13720	Xã Mỹ Trung	358	active
13723	Xã Mỹ Tân	358	active
13726	Xã Mỹ Phúc	358	active
13729	Xã Mỹ Hưng	358	active
13732	Xã Mỹ Thuận	358	active
13735	Xã Mỹ Thịnh	358	active
13738	Xã Mỹ Thành	358	active
13741	Thị trấn Gôi	359	active
13744	Xã Minh Thuận	359	active
13747	Xã Hiển Khánh	359	active
13750	Xã Tân Khánh	359	active
13753	Xã Hợp Hưng	359	active
13756	Xã Đại An	359	active
13759	Xã Tân Thành	359	active
13762	Xã Cộng Hòa	359	active
13765	Xã Trung Thành	359	active
13768	Xã Quang Trung	359	active
13771	Xã Minh Tân	359	active
13774	Xã Liên Bảo	359	active
13777	Xã Thành Lợi	359	active
13780	Xã Kim Thái	359	active
13783	Xã Liên Minh	359	active
13786	Xã Đại Thắng	359	active
13789	Xã Tam Thanh	359	active
13792	Xã Vĩnh Hào	359	active
13795	Thị trấn Lâm	360	active
13798	Xã Yên Trung	360	active
13801	Xã Yên Thành	360	active
13804	Xã Yên Tân	360	active
13807	Xã Yên Lợi	360	active
13810	Xã Yên Thọ	360	active
13813	Xã Yên Nghĩa	360	active
13816	Xã Yên Minh	360	active
13819	Xã Yên Phương	360	active
13822	Xã Yên Chính	360	active
13825	Xã Yên Bình	360	active
13828	Xã Yên Phú	360	active
13831	Xã Yên Mỹ	360	active
13834	Xã Yên Dương	360	active
13840	Xã Yên Hưng	360	active
13843	Xã Yên Khánh	360	active
13846	Xã Yên Phong	360	active
13849	Xã Yên Ninh	360	active
13852	Xã Yên Lương	360	active
13855	Xã Yên Hồng	360	active
13858	Xã Yên Quang	360	active
13861	Xã Yên Tiến	360	active
13864	Xã Yên Thắng	360	active
13867	Xã Yên Phúc	360	active
13870	Xã Yên Cường	360	active
13873	Xã Yên Lộc	360	active
13876	Xã Yên Bằng	360	active
13879	Xã Yên Đồng	360	active
13882	Xã Yên Khang	360	active
13885	Xã Yên Nhân	360	active
13888	Xã Yên Trị	360	active
13891	Thị trấn Liễu Đề	361	active
13894	Thị trấn Rạng Đông	361	active
13897	Xã Nghĩa Đồng	361	active
13900	Xã Nghĩa Thịnh	361	active
13903	Xã Nghĩa Minh	361	active
13906	Xã Nghĩa Thái	361	active
13909	Xã Hoàng Nam	361	active
13912	Xã Nghĩa Châu	361	active
13915	Xã Nghĩa Trung	361	active
13918	Xã Nghĩa Sơn	361	active
13921	Xã Nghĩa Lạc	361	active
13924	Xã Nghĩa Hồng	361	active
13927	Xã Nghĩa Phong	361	active
13930	Xã Nghĩa Phú	361	active
13933	Xã Nghĩa Bình	361	active
13936	Thị trấn Quỹ Nhất	361	active
13939	Xã Nghĩa Tân	361	active
13942	Xã Nghĩa Hùng	361	active
13945	Xã Nghĩa Lâm	361	active
13948	Xã Nghĩa Thành	361	active
13951	Xã Phúc Thắng	361	active
13954	Xã Nghĩa Lợi	361	active
13957	Xã Nghĩa Hải	361	active
13963	Xã Nam Điền	361	active
13966	Thị trấn Nam Giang	362	active
13969	Xã Nam Mỹ	362	active
13972	Xã Điền Xá	362	active
13975	Xã Nghĩa An	362	active
13978	Xã Nam Thắng	362	active
13981	Xã Nam Toàn	362	active
13984	Xã Hồng Quang	362	active
13987	Xã Tân Thịnh	362	active
13990	Xã Nam Cường	362	active
13993	Xã Nam Hồng	362	active
13996	Xã Nam Hùng	362	active
13999	Xã Nam Hoa	362	active
14002	Xã Nam Dương	362	active
14005	Xã Nam Thanh	362	active
14008	Xã Nam Lợi	362	active
14011	Xã Bình Minh	362	active
14014	Xã Đồng Sơn	362	active
14017	Xã Nam Tiến	362	active
14020	Xã Nam Hải	362	active
14023	Xã Nam Thái	362	active
14026	Thị trấn Cổ Lễ	363	active
14029	Xã Phương Định	363	active
14032	Xã Trực Chính	363	active
14035	Xã Trung Đông	363	active
14038	Xã Liêm Hải	363	active
14041	Xã Trực Tuấn	363	active
14044	Xã Việt Hùng	363	active
14047	Xã Trực Đạo	363	active
14050	Xã Trực Hưng	363	active
14053	Xã Trực Nội	363	active
14056	Thị trấn Cát Thành	363	active
14059	Xã Trực Thanh	363	active
14062	Xã Trực Khang	363	active
14065	Xã Trực Thuận	363	active
14068	Xã Trực Mỹ	363	active
14071	Xã Trực Đại	363	active
14074	Xã Trực Cường	363	active
14077	Thị trấn Ninh Cường	363	active
14080	Xã Trực Thái	363	active
14083	Xã Trực Hùng	363	active
14086	Xã Trực Thắng	363	active
14089	Thị trấn Xuân Trường	364	active
14092	Xã Xuân Châu	364	active
14095	Xã Xuân Hồng	364	active
14098	Xã Xuân Thành	364	active
14101	Xã Xuân Thượng	364	active
14104	Xã Xuân Phong	364	active
14107	Xã Xuân Đài	364	active
14110	Xã Xuân Tân	364	active
14113	Xã Xuân Thủy	364	active
14116	Xã Xuân Ngọc	364	active
14119	Xã Xuân Bắc	364	active
14122	Xã Xuân Phương	364	active
14125	Xã Thọ Nghiệp	364	active
14128	Xã Xuân Phú	364	active
14131	Xã Xuân Trung	364	active
14134	Xã Xuân Vinh	364	active
14137	Xã Xuân Kiên	364	active
14140	Xã Xuân Tiến	364	active
14143	Xã Xuân Ninh	364	active
14146	Xã Xuân Hòa	364	active
14149	Thị trấn Ngô Đồng	365	active
14152	Thị trấn Quất Lâm	365	active
14155	Xã Giao Hương	365	active
14158	Xã Hồng Thuận	365	active
14161	Xã Giao Thiện	365	active
14164	Xã Giao Thanh	365	active
14167	Xã Hoành Sơn	365	active
14170	Xã Bình Hòa	365	active
14173	Xã Giao Tiến	365	active
14176	Xã Giao Hà	365	active
14179	Xã Giao Nhân	365	active
14182	Xã Giao An	365	active
14185	Xã Giao Lạc	365	active
14188	Xã Giao Châu	365	active
14191	Xã Giao Tân	365	active
14194	Xã Giao Yến	365	active
14197	Xã Giao Xuân	365	active
14200	Xã Giao Thịnh	365	active
14203	Xã Giao Hải	365	active
14206	Xã Bạch Long	365	active
14209	Xã Giao Long	365	active
14212	Xã Giao Phong	365	active
14215	Thị trấn Yên Định	366	active
14218	Thị trấn Cồn	366	active
14221	Thị trấn Thịnh Long	366	active
14224	Xã Hải Nam	366	active
14227	Xã Hải Trung	366	active
14230	Xã Hải Vân	366	active
14233	Xã Hải Minh	366	active
14236	Xã Hải Anh	366	active
14239	Xã Hải Hưng	366	active
14242	Xã Hải Bắc	366	active
14245	Xã Hải Phúc	366	active
14248	Xã Hải Thanh	366	active
14251	Xã Hải Hà	366	active
14254	Xã Hải Long	366	active
14257	Xã Hải Phương	366	active
14260	Xã Hải Đường	366	active
14263	Xã Hải Lộc	366	active
14266	Xã Hải Quang	366	active
14269	Xã Hải Đông	366	active
14272	Xã Hải Sơn	366	active
14275	Xã Hải Tân	366	active
14281	Xã Hải Phong	366	active
14284	Xã Hải An	366	active
14287	Xã Hải Tây	366	active
14290	Xã Hải Lý	366	active
14293	Xã Hải Phú	366	active
14296	Xã Hải Giang	366	active
14299	Xã Hải Cường	366	active
14302	Xã Hải Ninh	366	active
14305	Xã Hải Chính	366	active
14308	Xã Hải Xuân	366	active
14311	Xã Hải Châu	366	active
14314	Xã Hải Triều	366	active
14317	Xã Hải Hòa	366	active
14320	Phường Đông Thành	369	active
14323	Phường Tân Thành	369	active
14326	Phường Thanh Bình	369	active
14329	Phường Vân Giang	369	active
14332	Phường Bích Đào	369	active
14335	Phường Phúc Thành	369	active
14338	Phường Nam Bình	369	active
14341	Phường Nam Thành	369	active
14344	Phường Ninh Khánh	369	active
14347	Xã Ninh Nhất	369	active
14350	Xã Ninh Tiến	369	active
14353	Xã Ninh Phúc	369	active
14356	Phường Ninh Sơn	369	active
14359	Phường Ninh Phong	369	active
14362	Phường Bắc Sơn	370	active
14365	Phường Trung Sơn	370	active
14368	Phường Nam Sơn	370	active
14369	Phường Tây Sơn	370	active
14371	Xã Yên Sơn	370	active
14374	Phường Yên Bình	370	active
14375	Phường Tân Bình	370	active
14377	Xã Quang Sơn	370	active
14380	Xã Đông Sơn	370	active
14383	Thị trấn Nho Quan	372	active
14386	Xã Xích Thổ	372	active
14389	Xã Gia Lâm	372	active
14392	Xã Gia Sơn	372	active
14395	Xã Thạch Bình	372	active
14398	Xã Gia Thủy	372	active
14401	Xã Gia Tường	372	active
14404	Xã Cúc Phương	372	active
14407	Xã Phú Sơn	372	active
14410	Xã Đức Long	372	active
14413	Xã Lạc Vân	372	active
14416	Xã Đồng Phong	372	active
14419	Xã Yên Quang	372	active
14422	Xã Lạng Phong	372	active
14425	Xã Thượng Hòa	372	active
14428	Xã Văn Phong	372	active
14431	Xã Văn Phương	372	active
14434	Xã Thanh Lạc	372	active
14437	Xã Sơn Lai	372	active
14440	Xã Sơn Thành	372	active
14443	Xã Văn Phú	372	active
14446	Xã Phú Lộc	372	active
14449	Xã Kỳ Phú	372	active
14452	Xã Quỳnh Lưu	372	active
14455	Xã Sơn Hà	372	active
14458	Xã Phú Long	372	active
14461	Xã Quảng Lạc	372	active
14464	Thị trấn Me	373	active
14467	Xã Gia Hòa	373	active
14470	Xã Gia Hưng	373	active
14473	Xã Liên Sơn	373	active
14476	Xã Gia Thanh	373	active
14479	Xã Gia Vân	373	active
14482	Xã Gia Phú	373	active
14485	Xã Gia Xuân	373	active
14488	Xã Gia Lập	373	active
14491	Xã Gia Vượng	373	active
14494	Xã Gia Trấn	373	active
14497	Xã Gia Thịnh	373	active
14500	Xã Gia Phương	373	active
14503	Xã Gia Tân	373	active
14506	Xã Gia Thắng	373	active
14509	Xã Gia Trung	373	active
14512	Xã Gia Minh	373	active
14515	Xã Gia Lạc	373	active
14518	Xã Gia Tiến	373	active
14521	Xã Gia Sinh	373	active
14524	Xã Gia Phong	373	active
14527	Thị trấn Thiên Tôn	374	active
14530	Xã Ninh Giang	374	active
14533	Xã Trường Yên	374	active
14536	Xã Ninh Khang	374	active
14539	Xã Ninh Mỹ	374	active
14542	Xã Ninh Hòa	374	active
14545	Xã Ninh Xuân	374	active
14548	Xã Ninh Hải	374	active
14551	Xã Ninh Thắng	374	active
14554	Xã Ninh Vân	374	active
14557	Xã Ninh An	374	active
14560	Thị trấn Yên Ninh	375	active
14563	Xã Khánh Tiên	375	active
14566	Xã Khánh Phú	375	active
14569	Xã Khánh Hòa	375	active
14572	Xã Khánh Lợi	375	active
14575	Xã Khánh An	375	active
14578	Xã Khánh Cường	375	active
14581	Xã Khánh Cư	375	active
14584	Xã Khánh Thiện	375	active
14587	Xã Khánh Hải	375	active
14590	Xã Khánh Trung	375	active
14593	Xã Khánh Mậu	375	active
14596	Xã Khánh Vân	375	active
14599	Xã Khánh Hội	375	active
14602	Xã Khánh Công	375	active
14608	Xã Khánh Thành	375	active
14611	Xã Khánh Nhạc	375	active
14614	Xã Khánh Thủy	375	active
14617	Xã Khánh Hồng	375	active
14620	Thị trấn Phát Diệm	376	active
14623	Thị trấn Bình Minh	376	active
14629	Xã Hồi Ninh	376	active
14632	Xã Xuân Chính	376	active
14635	Xã Kim Định	376	active
14638	Xã Ân Hòa	376	active
14641	Xã Hùng Tiến	376	active
14647	Xã Quang Thiện	376	active
14650	Xã Như Hòa	376	active
14653	Xã Chất Bình	376	active
14656	Xã Đồng Hướng	376	active
14659	Xã Kim Chính	376	active
14662	Xã Thượng Kiệm	376	active
14665	Xã Lưu Phương	376	active
14668	Xã Tân Thành	376	active
14671	Xã Yên Lộc	376	active
14674	Xã Lai Thành	376	active
14677	Xã Định Hóa	376	active
14680	Xã Văn Hải	376	active
14683	Xã Kim Tân	376	active
14686	Xã Kim Mỹ	376	active
14689	Xã Cồn Thoi	376	active
14692	Xã Kim Hải	376	active
14695	Xã Kim Trung	376	active
14698	Xã Kim Đông	376	active
14701	Thị trấn Yên Thịnh	377	active
14704	Xã Khánh Thượng	377	active
14707	Xã Khánh Dương	377	active
14710	Xã Mai Sơn	377	active
14713	Xã Khánh Thịnh	377	active
14719	Xã Yên Phong	377	active
14722	Xã Yên Hòa	377	active
14725	Xã Yên Thắng	377	active
14728	Xã Yên Từ	377	active
14731	Xã Yên Hưng	377	active
14734	Xã Yên Thành	377	active
14737	Xã Yên Nhân	377	active
14740	Xã Yên Mỹ	377	active
14743	Xã Yên Mạc	377	active
14746	Xã Yên Đồng	377	active
14749	Xã Yên Thái	377	active
14752	Xã Yên Lâm	377	active
14755	Phường Hàm Rồng	380	active
14758	Phường Đông Thọ	380	active
14761	Phường Nam Ngạn	380	active
14764	Phường Trường Thi	380	active
14767	Phường Điện Biên	380	active
14770	Phường Phú Sơn	380	active
14773	Phường Lam Sơn	380	active
14776	Phường Ba Đình	380	active
14779	Phường Ngọc Trạo	380	active
14782	Phường Đông Vệ	380	active
14785	Phường Đông Sơn	380	active
14788	Phường Tân Sơn	380	active
14791	Phường Đông Cương	380	active
14794	Phường Đông Hương	380	active
14797	Phường Đông Hải	380	active
14800	Phường Quảng Hưng	380	active
14803	Phường Quảng Thắng	380	active
14806	Phường Quảng Thành	380	active
15850	Xã Thiệu Vân	380	active
15856	Phường Thiệu Khánh	380	active
15859	Phường Thiệu Dương	380	active
15913	Phường Tào Xuyên	380	active
15922	Phường Long Anh	380	active
15925	Xã Hoằng Quang	380	active
15970	Xã Hoằng Đại	380	active
15118	Xã Kiên Thọ	389	active
16396	Phường Đông Lĩnh	380	active
16429	Xã Đông Vinh	380	active
16432	Phường Đông Tân	380	active
16435	Phường An Hưng	380	active
16441	Phường Quảng Thịnh	380	active
16459	Phường Quảng Đông	380	active
16507	Phường Quảng Cát	380	active
16522	Phường Quảng Phú	380	active
16525	Phường Quảng Tâm	380	active
14809	Phường Bắc Sơn	381	active
14812	Phường Ba Đình	381	active
14815	Phường Lam Sơn	381	active
14818	Phường Ngọc Trạo	381	active
14821	Phường Đông Sơn	381	active
14823	Phường Phú Sơn	381	active
14824	Xã Quang Trung	381	active
14830	Phường Trung Sơn	382	active
14833	Phường Bắc Sơn	382	active
14836	Phường Trường Sơn	382	active
14839	Phường Quảng Cư	382	active
14842	Phường Quảng Tiến	382	active
16513	Xã Quảng Minh	382	active
16516	Xã Quảng Hùng	382	active
16528	Phường Quảng Thọ	382	active
16531	Phường Quảng Châu	382	active
16534	Phường Quảng Vinh	382	active
16537	Xã Quảng Đại	382	active
14845	Thị trấn Mường Lát	384	active
14848	Xã Tam Chung	384	active
14854	Xã Mường Lý	384	active
14857	Xã Trung Lý	384	active
14860	Xã Quang Chiểu	384	active
14863	Xã Pù Nhi	384	active
14864	Xã Nhi Sơn	384	active
14866	Xã Mường Chanh	384	active
14869	Thị trấn Hồi Xuân	385	active
14872	Xã Thành Sơn	385	active
14875	Xã Trung Sơn	385	active
14878	Xã Phú Thanh	385	active
14881	Xã Trung Thành	385	active
14884	Xã Phú Lệ	385	active
14887	Xã Phú Sơn	385	active
14890	Xã Phú Xuân	385	active
14896	Xã Hiền Chung	385	active
14899	Xã Hiền Kiệt	385	active
14902	Xã Nam Tiến	385	active
14908	Xã Thiên Phủ	385	active
14911	Xã Phú Nghiêm	385	active
14914	Xã Nam Xuân	385	active
14917	Xã Nam Động	385	active
14923	Thị trấn Cành Nàng	386	active
14926	Xã Điền Thượng	386	active
14929	Xã Điền Hạ	386	active
14932	Xã Điền Quang	386	active
14935	Xã Điền Trung	386	active
14938	Xã Thành Sơn	386	active
14941	Xã Lương Ngoại	386	active
14944	Xã Ái Thượng	386	active
14947	Xã Lương Nội	386	active
14950	Xã Điền Lư	386	active
14953	Xã Lương Trung	386	active
14956	Xã Lũng Niêm	386	active
14959	Xã Lũng Cao	386	active
14962	Xã Hạ Trung	386	active
14965	Xã Cổ Lũng	386	active
14968	Xã Thành Lâm	386	active
14971	Xã Ban Công	386	active
14974	Xã Kỳ Tân	386	active
14977	Xã Văn Nho	386	active
14980	Xã Thiết Ống	386	active
14986	Xã Thiết Kế	386	active
14995	Xã Trung Xuân	387	active
14998	Xã Trung Thượng	387	active
14999	Xã Trung Tiến	387	active
15001	Xã Trung Hạ	387	active
15004	Xã Sơn Hà	387	active
15007	Xã Tam Thanh	387	active
15010	Xã Sơn Thủy	387	active
15013	Xã Na Mèo	387	active
15016	Thị trấn Sơn Lư	387	active
15019	Xã Tam Lư	387	active
15022	Xã Sơn Điện	387	active
15025	Xã Mường Mìn	387	active
15031	Xã Yên Khương	388	active
15034	Xã Yên Thắng	388	active
15037	Xã Trí Nang	388	active
15040	Xã Giao An	388	active
15043	Xã Giao Thiện	388	active
15046	Xã Tân Phúc	388	active
15049	Xã Tam Văn	388	active
15052	Xã Lâm Phú	388	active
15055	Thị trấn Lang Chánh	388	active
15058	Xã Đồng Lương	388	active
15061	Thị Trấn Ngọc Lặc	389	active
15064	Xã Lam Sơn	389	active
15067	Xã Mỹ Tân	389	active
15070	Xã Thúy Sơn	389	active
15073	Xã Thạch Lập	389	active
15076	Xã Vân Am	389	active
15079	Xã Cao Ngọc	389	active
15085	Xã Quang Trung	389	active
15088	Xã Đồng Thịnh	389	active
15091	Xã Ngọc Liên	389	active
15094	Xã Ngọc Sơn	389	active
15097	Xã Lộc Thịnh	389	active
15100	Xã Cao Thịnh	389	active
15103	Xã Ngọc Trung	389	active
15106	Xã Phùng Giáo	389	active
15109	Xã Phùng Minh	389	active
15112	Xã Phúc Thịnh	389	active
15115	Xã Nguyệt Ấn	389	active
15121	Xã Minh Tiến	389	active
15124	Xã Minh Sơn	389	active
15127	Thị trấn Phong Sơn	390	active
15133	Xã Cẩm Thành	390	active
15136	Xã Cẩm Quý	390	active
15139	Xã Cẩm Lương	390	active
15142	Xã Cẩm Thạch	390	active
15145	Xã Cẩm Liên	390	active
15148	Xã Cẩm Giang	390	active
15151	Xã Cẩm Bình	390	active
15154	Xã Cẩm Tú	390	active
15160	Xã Cẩm Châu	390	active
15163	Xã Cẩm Tâm	390	active
15169	Xã Cẩm Ngọc	390	active
15172	Xã Cẩm Long	390	active
15175	Xã Cẩm Yên	390	active
15178	Xã Cẩm Tân	390	active
15181	Xã Cẩm Phú	390	active
15184	Xã Cẩm Vân	390	active
15187	Thị trấn Kim Tân	391	active
15190	Thị trấn Vân Du	391	active
15196	Xã Thạch Lâm	391	active
15199	Xã Thạch Quảng	391	active
15202	Xã Thạch Tượng	391	active
15205	Xã Thạch Cẩm	391	active
15208	Xã Thạch Sơn	391	active
15211	Xã Thạch Bình	391	active
15214	Xã Thạch Định	391	active
15217	Xã Thạch Đồng	391	active
15220	Xã Thạch Long	391	active
15223	Xã Thành Mỹ	391	active
15226	Xã Thành Yên	391	active
15229	Xã Thành Vinh	391	active
15232	Xã Thành Minh	391	active
15235	Xã Thành Công	391	active
15238	Xã Thành Tân	391	active
15241	Xã Thành Trực	391	active
15247	Xã Thành Tâm	391	active
15250	Xã Thành An	391	active
15253	Xã Thành Thọ	391	active
15256	Xã Thành Tiến	391	active
15259	Xã Thành Long	391	active
15265	Xã Thành Hưng	391	active
15268	Xã Ngọc Trạo	391	active
15271	Thị trấn Hà Trung	392	active
15274	Xã Hà Long	392	active
15277	Xã Hà Vinh	392	active
15280	Xã Hà Bắc	392	active
15283	Xã Hoạt Giang	392	active
15286	Xã Yên Dương	392	active
15292	Xã Hà Giang	392	active
15298	Xã Lĩnh Toại	392	active
15304	Xã Hà Ngọc	392	active
15307	Xã Yến Sơn	392	active
15313	Xã Hà Sơn	392	active
15316	Xã Hà Lĩnh	392	active
15319	Xã Hà Đông	392	active
15322	Xã Hà Tân	392	active
15325	Xã Hà Tiến	392	active
15328	Xã Hà Bình	392	active
15331	Xã Hà Lai	392	active
15334	Xã Hà Châu	392	active
15340	Xã Hà Thái	392	active
15343	Xã Hà Hải	392	active
15349	Thị trấn Vĩnh Lộc	393	active
15352	Xã Vĩnh Quang	393	active
15355	Xã Vĩnh Yên	393	active
15358	Xã Vĩnh Tiến	393	active
15361	Xã Vĩnh Long	393	active
15364	Xã Vĩnh Phúc	393	active
15367	Xã Vĩnh Hưng	393	active
15376	Xã Vĩnh Hòa	393	active
15379	Xã Vĩnh Hùng	393	active
15382	Xã Minh Tân	393	active
15385	Xã Ninh Khang	393	active
15388	Xã Vĩnh Thịnh	393	active
15391	Xã Vĩnh An	393	active
15397	Thị trấn Thống Nhất	394	active
15403	Thị trấn Yên Lâm	394	active
15406	Xã Yên Tâm	394	active
15409	Xã Yên Phú	394	active
15412	Thị trấn Quý Lộc	394	active
15415	Xã Yên Thọ	394	active
15418	Xã Yên Trung	394	active
15421	Xã Yên Trường	394	active
15427	Xã Yên Phong	394	active
15430	Xã Yên Thái	394	active
15433	Xã Yên Hùng	394	active
15436	Xã Yên Thịnh	394	active
15439	Xã Yên Ninh	394	active
15442	Xã Yên Lạc	394	active
15445	Xã Định Tăng	394	active
15448	Xã Định Hòa	394	active
15451	Xã Định Thành	394	active
15454	Xã Định Công	394	active
15457	Xã Định Tân	394	active
15460	Xã Định Tiến	394	active
15463	Xã Định Long	394	active
15466	Xã Định Liên	394	active
15469	Thị trấn Quán Lào	394	active
15472	Xã Định Hưng	394	active
15475	Xã Định Hải	394	active
15478	Xã Định Bình	394	active
15493	Xã Xuân Hồng	395	active
15499	Thị trấn Thọ Xuân	395	active
15502	Xã Bắc Lương	395	active
15505	Xã Nam Giang	395	active
15508	Xã Xuân Phong	395	active
15511	Xã Thọ Lộc	395	active
15514	Xã Xuân Trường	395	active
15517	Xã Xuân Hòa	395	active
15520	Xã Thọ Hải	395	active
15523	Xã Tây Hồ	395	active
15526	Xã Xuân Giang	395	active
15532	Xã Xuân Sinh	395	active
15535	Xã Xuân Hưng	395	active
15538	Xã Thọ Diên	395	active
15541	Xã Thọ Lâm	395	active
15544	Xã Thọ Xương	395	active
15547	Xã Xuân Bái	395	active
15550	Xã Xuân Phú	395	active
15553	Thị trấn Sao Vàng	395	active
15556	Thị trấn Lam Sơn	395	active
15559	Xã Xuân Thiên	395	active
15565	Xã Thuận Minh	395	active
15568	Xã Thọ Lập	395	active
15571	Xã Quảng Phú	395	active
15574	Xã Xuân Tín	395	active
15577	Xã Phú Xuân	395	active
15583	Xã Xuân Lai	395	active
15586	Xã Xuân Lập	395	active
15592	Xã Xuân Minh	395	active
15598	Xã Trường Xuân	395	active
15607	Xã Bát Mọt	396	active
15610	Xã Yên Nhân	396	active
15619	Xã Xuân Lẹ	396	active
15622	Xã Vạn Xuân	396	active
15628	Xã Lương Sơn	396	active
15631	Xã Xuân Cao	396	active
15634	Xã Luận Thành	396	active
15637	Xã Luận Khê	396	active
15640	Xã Xuân Thắng	396	active
15643	Xã Xuân Lộc	396	active
15646	Thị trấn Thường Xuân	396	active
15649	Xã Xuân Dương	396	active
15652	Xã Thọ Thanh	396	active
15655	Xã Ngọc Phụng	396	active
15658	Xã Xuân Chinh	396	active
15661	Xã Tân Thành	396	active
15664	Thị trấn Triệu Sơn	397	active
15667	Xã Thọ Sơn	397	active
15670	Xã Thọ Bình	397	active
15673	Xã Thọ Tiến	397	active
15676	Xã Hợp Lý	397	active
15679	Xã Hợp Tiến	397	active
15682	Xã Hợp Thành	397	active
15685	Xã Triệu Thành	397	active
15688	Xã Hợp Thắng	397	active
15691	Xã Minh Sơn	397	active
15700	Xã Dân Lực	397	active
15703	Xã Dân Lý	397	active
15706	Xã Dân Quyền	397	active
15709	Xã An Nông	397	active
15712	Xã Văn Sơn	397	active
15715	Xã Thái Hòa	397	active
15718	Thị trấn Nưa	397	active
15721	Xã Đồng Lợi	397	active
15724	Xã Đồng Tiến	397	active
15727	Xã Đồng Thắng	397	active
15730	Xã Tiến Nông	397	active
15733	Xã Khuyến Nông	397	active
15736	Xã Xuân Thịnh	397	active
15739	Xã Xuân Lộc	397	active
15742	Xã Thọ Dân	397	active
15745	Xã Xuân Thọ	397	active
15748	Xã Thọ Tân	397	active
15751	Xã Thọ Ngọc	397	active
15754	Xã Thọ Cường	397	active
15757	Xã Thọ Phú	397	active
15760	Xã Thọ Vực	397	active
15763	Xã Thọ Thế	397	active
15766	Xã Nông Trường	397	active
15769	Xã Bình Sơn	397	active
15772	Thị trấn Thiệu Hóa	398	active
15775	Xã Thiệu Ngọc	398	active
15778	Xã Thiệu Vũ	398	active
15781	Xã Thiệu Phúc	398	active
15784	Xã Thiệu Tiến	398	active
15787	Xã Thiệu Công	398	active
15790	Xã Thiệu Phú	398	active
15793	Xã Thiệu Long	398	active
15796	Xã Thiệu Giang	398	active
15799	Xã Thiệu Duy	398	active
15802	Xã Thiệu Nguyên	398	active
15805	Xã Thiệu Hợp	398	active
15808	Xã Thiệu Thịnh	398	active
15811	Xã Thiệu Quang	398	active
15814	Xã Thiệu Thành	398	active
15817	Xã Thiệu Toán	398	active
15820	Xã Thiệu Chính	398	active
15823	Xã Thiệu Hòa	398	active
15829	Xã Minh Tâm	398	active
15832	Xã Thiệu Viên	398	active
15835	Xã Thiệu Lý	398	active
15838	Xã Thiệu Vận	398	active
15841	Xã Thiệu Trung	398	active
15847	Xã Tân Châu	398	active
15853	Xã Thiệu Giao	398	active
15865	Thị trấn Bút Sơn	399	active
15871	Xã Hoằng Giang	399	active
15877	Xã Hoằng Xuân	399	active
15880	Xã Hoằng Phượng	399	active
15883	Xã Hoằng Phú	399	active
15886	Xã Hoằng Quỳ	399	active
15889	Xã Hoằng Kim	399	active
15892	Xã Hoằng Trung	399	active
15895	Xã Hoằng Trinh	399	active
15901	Xã Hoằng Sơn	399	active
15907	Xã Hoằng Cát	399	active
15910	Xã Hoằng Xuyên	399	active
15916	Xã Hoằng Quý	399	active
15919	Xã Hoằng Hợp	399	active
15928	Xã Hoằng Đức	399	active
15937	Xã Hoằng Hà	399	active
15940	Xã Hoằng Đạt	399	active
15946	Xã Hoằng Đạo	399	active
15949	Xã Hoằng Thắng	399	active
15952	Xã Hoằng Đồng	399	active
15955	Xã Hoằng Thái	399	active
15958	Xã Hoằng Thịnh	399	active
15961	Xã Hoằng Thành	399	active
15964	Xã Hoằng Lộc	399	active
15967	Xã Hoằng Trạch	399	active
15973	Xã Hoằng Phong	399	active
15976	Xã Hoằng Lưu	399	active
15979	Xã Hoằng Châu	399	active
15982	Xã Hoằng Tân	399	active
15985	Xã Hoằng Yến	399	active
15988	Xã Hoằng Tiến	399	active
15991	Xã Hoằng Hải	399	active
15994	Xã Hoằng Ngọc	399	active
15997	Xã Hoằng Đông	399	active
16000	Xã Hoằng Thanh	399	active
16003	Xã Hoằng Phụ	399	active
16006	Xã Hoằng Trường	399	active
16012	Thị trấn Hậu Lộc	400	active
16015	Xã Đồng Lộc	400	active
16018	Xã Đại Lộc	400	active
16021	Xã Triệu Lộc	400	active
16027	Xã Tiến Lộc	400	active
16030	Xã Lộc Sơn	400	active
16033	Xã Cầu Lộc	400	active
16036	Xã Thành Lộc	400	active
16039	Xã Tuy Lộc	400	active
16042	Xã Phong Lộc	400	active
16045	Xã Mỹ Lộc	400	active
16048	Xã Thuần Lộc	400	active
16057	Xã Xuân Lộc	400	active
16063	Xã Hoa Lộc	400	active
16066	Xã Liên Lộc	400	active
16069	Xã Quang Lộc	400	active
16072	Xã Phú Lộc	400	active
16075	Xã Hòa Lộc	400	active
16078	Xã Minh Lộc	400	active
16081	Xã Hưng Lộc	400	active
16084	Xã Hải Lộc	400	active
16087	Xã Đa Lộc	400	active
16090	Xã Ngư Lộc	400	active
16093	Thị trấn Nga Sơn	401	active
16096	Xã Ba Đình	401	active
16099	Xã Nga Vịnh	401	active
16102	Xã Nga Văn	401	active
16105	Xã Nga Thiện	401	active
16108	Xã Nga Tiến	401	active
16114	Xã Nga Phượng	401	active
16117	Xã Nga Trung	401	active
16120	Xã Nga Bạch	401	active
16123	Xã Nga Thanh	401	active
16132	Xã Nga Yên	401	active
16135	Xã Nga Giáp	401	active
16138	Xã Nga Hải	401	active
16141	Xã Nga Thành	401	active
16144	Xã Nga An	401	active
16147	Xã Nga Phú	401	active
16150	Xã Nga Điền	401	active
16153	Xã Nga Tân	401	active
16156	Xã Nga Thủy	401	active
16159	Xã Nga Liên	401	active
16162	Xã Nga Thái	401	active
16165	Xã Nga Thạch	401	active
16168	Xã Nga Thắng	401	active
16171	Xã Nga Trường	401	active
16174	Thị trấn Yên Cát	402	active
16177	Xã Bãi Trành	402	active
16180	Xã Xuân Hòa	402	active
16183	Xã Xuân Bình	402	active
16186	Xã Hóa Quỳ	402	active
16195	Xã Cát Vân	402	active
16198	Xã Cát Tân	402	active
16201	Xã Tân Bình	402	active
16204	Xã Bình Lương	402	active
16207	Xã Thanh Quân	402	active
16210	Xã Thanh Xuân	402	active
16213	Xã Thanh Hòa	402	active
16216	Xã Thanh Phong	402	active
16219	Xã Thanh Lâm	402	active
16222	Xã Thanh Sơn	402	active
16225	Xã Thượng Ninh	402	active
16228	Thị trấn Bến Sung	403	active
16231	Xã Cán Khê	403	active
16234	Xã Xuân Du	403	active
16240	Xã Phượng Nghi	403	active
16243	Xã Mậu Lâm	403	active
16246	Xã Xuân Khang	403	active
16249	Xã Phú Nhuận	403	active
16252	Xã Hải Long	403	active
16258	Xã Xuân Thái	403	active
16261	Xã Xuân Phúc	403	active
16264	Xã Yên Thọ	403	active
16267	Xã Yên Lạc	403	active
16273	Xã Thanh Tân	403	active
16276	Xã Thanh Kỳ	403	active
16279	Thị trấn Nông Cống	404	active
16282	Xã Tân Phúc	404	active
16285	Xã Tân Thọ	404	active
16288	Xã Hoàng Sơn	404	active
16291	Xã Tân Khang	404	active
16294	Xã Hoàng Giang	404	active
16297	Xã Trung Chính	404	active
16303	Xã Trung Thành	404	active
16309	Xã Tế Thắng	404	active
16315	Xã Tế Lợi	404	active
16318	Xã Tế Nông	404	active
16321	Xã Minh Nghĩa	404	active
16324	Xã Minh Khôi	404	active
16327	Xã Vạn Hòa	404	active
16330	Xã Trường Trung	404	active
16333	Xã Vạn Thắng	404	active
16336	Xã Trường Giang	404	active
16339	Xã Vạn Thiện	404	active
16342	Xã Thăng Long	404	active
16345	Xã Trường Minh	404	active
16348	Xã Trường Sơn	404	active
16351	Xã Thăng Bình	404	active
16354	Xã Công Liêm	404	active
16357	Xã Tượng Văn	404	active
16360	Xã Thăng Thọ	404	active
16363	Xã Tượng Lĩnh	404	active
16366	Xã Tượng Sơn	404	active
16369	Xã Công Chính	404	active
16375	Xã Yên Mỹ	404	active
16378	Thị trấn Rừng Thông	405	active
16381	Xã Đông Hoàng	405	active
16384	Xã Đông Ninh	405	active
16390	Xã Đông Hòa	405	active
16393	Xã Đông Yên	405	active
16399	Xã Đông Minh	405	active
16402	Xã Đông Thanh	405	active
16405	Xã Đông Tiến	405	active
16408	Xã Đông Khê	405	active
16414	Xã Đông Thịnh	405	active
16417	Xã Đông Văn	405	active
16420	Xã Đông Phú	405	active
16423	Xã Đông Nam	405	active
16426	Xã Đông Quang	405	active
16438	Thị trấn Tân Phong	406	active
16447	Xã Quảng Trạch	406	active
16453	Xã Quảng Đức	406	active
16456	Xã Quảng Định	406	active
16462	Xã Quảng Nhân	406	active
16465	Xã Quảng Ninh	406	active
16468	Xã Quảng Bình	406	active
16471	Xã Quảng Hợp	406	active
16474	Xã Quảng Văn	406	active
16477	Xã Quảng Long	406	active
16480	Xã Quảng Yên	406	active
16483	Xã Quảng Hòa	406	active
16489	Xã Quảng Khê	406	active
16492	Xã Quảng Trung	406	active
16495	Xã Quảng Chính	406	active
16498	Xã Quảng Ngọc	406	active
16501	Xã Quảng Trường	406	active
16510	Xã Quảng Phúc	406	active
16519	Xã Quảng Giao	406	active
16540	Xã Quảng Hải	406	active
16543	Xã Quảng Lưu	406	active
16546	Xã Quảng Lộc	406	active
16549	Xã Tiên Trang	406	active
16552	Xã Quảng Nham	406	active
16555	Xã Quảng Thạch	406	active
16558	Xã Quảng Thái	406	active
16561	Phường Hải Hòa	407	active
16564	Phường Hải Châu	407	active
16567	Xã Thanh Thủy	407	active
16570	Xã Thanh Sơn	407	active
16576	Phường Hải Ninh	407	active
16579	Xã Anh Sơn	407	active
16582	Xã Ngọc Lĩnh	407	active
16585	Phường Hải An	407	active
16591	Xã Các Sơn	407	active
16594	Phường Tân Dân	407	active
16597	Phường Hải Lĩnh	407	active
16600	Xã Định Hải	407	active
16603	Xã Phú Sơn	407	active
16606	Phường Ninh Hải	407	active
16609	Phường Nguyên Bình	407	active
16612	Xã Hải Nhân	407	active
16618	Phường Bình Minh	407	active
16621	Phường Hải Thanh	407	active
16624	Xã Phú Lâm	407	active
16627	Phường Xuân Lâm	407	active
16630	Phường Trúc Lâm	407	active
16633	Phường Hải Bình	407	active
16636	Xã Tân Trường	407	active
16639	Xã Tùng Lâm	407	active
16642	Phường Tĩnh Hải	407	active
16645	Phường Mai Lâm	407	active
16648	Xã Trường Lâm	407	active
16651	Xã Hải Yến	407	active
16654	Phường Hải Thượng	407	active
16657	Xã Nghi Sơn	407	active
16660	Xã Hải Hà	407	active
16663	Phường Đông Vĩnh	412	active
16666	Phường Hà Huy Tập	412	active
16669	Phường Lê Lợi	412	active
16670	Phường Quán Bàu	412	active
16672	Phường Hưng Bình	412	active
16673	Phường Hưng Phúc	412	active
16675	Phường Hưng Dũng	412	active
16678	Phường Cửa Nam	412	active
16681	Phường Quang Trung	412	active
16684	Phường Đội Cung	412	active
16687	Phường Lê Mao	412	active
16690	Phường Trường Thi	412	active
16693	Phường Bến Thủy	412	active
16696	Phường Hồng Sơn	412	active
16699	Phường Trung Đô	412	active
16702	Xã Nghi Phú	412	active
16705	Xã Hưng Đông	412	active
16708	Xã Hưng Lộc	412	active
16711	Xã Hưng Hòa	412	active
16714	Phường Vinh Tân	412	active
17908	Xã Nghi Liên	412	active
17914	Xã Nghi Ân	412	active
17920	Xã Nghi Kim	412	active
17923	Xã Nghi Đức	412	active
18013	Xã Hưng Chính	412	active
16717	Phường Nghi Thuỷ	413	active
16720	Phường Nghi Tân	413	active
16723	Phường Thu Thuỷ	413	active
16726	Phường Nghi Hòa	413	active
16729	Phường Nghi Hải	413	active
16732	Phường Nghi Hương	413	active
16735	Phường Nghi Thu	413	active
16939	Phường Hoà Hiếu	414	active
16993	Phường Quang Phong	414	active
16994	Phường Quang Tiến	414	active
17003	Phường Long Sơn	414	active
17005	Xã Nghĩa Tiến	414	active
17008	Xã Nghĩa Mỹ	414	active
17011	Xã Tây Hiếu	414	active
17014	Xã Nghĩa Thuận	414	active
17017	Xã Đông Hiếu	414	active
16738	Thị trấn Kim Sơn	415	active
16741	Xã Thông Thụ	415	active
16744	Xã Đồng Văn	415	active
16747	Xã Hạnh Dịch	415	active
16750	Xã Tiền Phong	415	active
16753	Xã Nậm Giải	415	active
16756	Xã Tri Lễ	415	active
16759	Xã Châu Kim	415	active
16763	Xã Mường Nọc	415	active
16765	Xã Châu Thôn	415	active
16768	Xã Nậm Nhoóng	415	active
16771	Xã Quang Phong	415	active
16774	Xã Căm Muộn	415	active
16777	Thị trấn Tân Lạc	416	active
16780	Xã Châu Bính	416	active
16783	Xã Châu Thuận	416	active
16786	Xã Châu Hội	416	active
16789	Xã Châu Nga	416	active
16792	Xã Châu Tiến	416	active
16795	Xã Châu Hạnh	416	active
16798	Xã Châu Thắng	416	active
16801	Xã Châu Phong	416	active
16804	Xã Châu Bình	416	active
16807	Xã Châu Hoàn	416	active
16810	Xã Diên Lãm	416	active
16813	Thị trấn Mường Xén	417	active
16816	Xã Mỹ Lý	417	active
16819	Xã Bắc Lý	417	active
16822	Xã Keng Đu	417	active
16825	Xã Đoọc Mạy	417	active
16828	Xã Huồi Tụ	417	active
16831	Xã Mường Lống	417	active
16834	Xã Na Loi	417	active
16837	Xã Nậm Cắn	417	active
16840	Xã Bảo Nam	417	active
16843	Xã Phà Đánh	417	active
16846	Xã Bảo Thắng	417	active
16849	Xã Hữu Lập	417	active
16852	Xã Tà Cạ	417	active
16855	Xã Chiêu Lưu	417	active
16858	Xã Mường Típ	417	active
16861	Xã Hữu Kiệm	417	active
16864	Xã Tây Sơn	417	active
16867	Xã Mường Ải	417	active
16870	Xã Na Ngoi	417	active
16873	Xã Nậm Càn	417	active
16876	Thị trấn Thạch Giám	418	active
16879	Xã Mai Sơn	418	active
16882	Xã Nhôn Mai	418	active
16885	Xã Hữu Khuông	418	active
16900	Xã Yên Tĩnh	418	active
16903	Xã Nga My	418	active
16904	Xã Xiêng My	418	active
16906	Xã Lưỡng Minh	418	active
16909	Xã Yên Hòa	418	active
16912	Xã Yên Na	418	active
16915	Xã Lưu Kiền	418	active
16921	Xã Xá Lượng	418	active
16924	Xã Tam Thái	418	active
16927	Xã Tam Đình	418	active
16930	Xã Yên Thắng	418	active
16933	Xã Tam Quang	418	active
16936	Xã Tam Hợp	418	active
16941	Thị trấn Nghĩa Đàn	419	active
16942	Xã Nghĩa Mai	419	active
16945	Xã Nghĩa Yên	419	active
16948	Xã Nghĩa Lạc	419	active
16951	Xã Nghĩa Lâm	419	active
16954	Xã Nghĩa Sơn	419	active
16957	Xã Nghĩa Lợi	419	active
16960	Xã Nghĩa Bình	419	active
16963	Xã Nghĩa Thọ	419	active
16966	Xã Nghĩa Minh	419	active
16969	Xã Nghĩa Phú	419	active
16972	Xã Nghĩa Hưng	419	active
16975	Xã Nghĩa Hồng	419	active
16978	Xã Nghĩa Thịnh	419	active
16981	Xã Nghĩa Trung	419	active
16984	Xã Nghĩa Hội	419	active
16987	Xã Nghĩa Thành	419	active
16996	Xã Nghĩa Hiếu	419	active
17020	Xã Nghĩa Đức	419	active
17023	Xã Nghĩa An	419	active
17026	Xã Nghĩa Long	419	active
17029	Xã Nghĩa Lộc	419	active
17032	Xã Nghĩa Khánh	419	active
17035	Thị trấn Quỳ Hợp	420	active
17038	Xã Yên Hợp	420	active
17041	Xã Châu Tiến	420	active
17044	Xã Châu Hồng	420	active
17047	Xã Đồng Hợp	420	active
17050	Xã Châu Thành	420	active
17053	Xã Liên Hợp	420	active
17056	Xã Châu Lộc	420	active
17059	Xã Tam Hợp	420	active
17062	Xã Châu Cường	420	active
17065	Xã Châu Quang	420	active
17068	Xã Thọ Hợp	420	active
17071	Xã Minh Hợp	420	active
17074	Xã Nghĩa Xuân	420	active
17077	Xã Châu Thái	420	active
17080	Xã Châu Đình	420	active
17083	Xã Văn Lợi	420	active
17086	Xã Nam Sơn	420	active
17089	Xã Châu Lý	420	active
17092	Xã Hạ Sơn	420	active
17095	Xã Bắc Sơn	420	active
17098	Thị trấn Cầu Giát	421	active
17101	Xã Quỳnh Thắng	421	active
17119	Xã Quỳnh Tân	421	active
17122	Xã Quỳnh Châu	421	active
17140	Xã Tân Sơn	421	active
17143	Xã Quỳnh Văn	421	active
17146	Xã Ngọc Sơn	421	active
17149	Xã Quỳnh Tam	421	active
17152	Xã Quỳnh Hoa	421	active
17155	Xã Quỳnh Thạch	421	active
17158	Xã Quỳnh Bảng	421	active
17161	Xã Quỳnh Mỹ	421	active
17164	Xã Quỳnh Thanh	421	active
17167	Xã Quỳnh Hậu	421	active
17170	Xã Quỳnh Lâm	421	active
17173	Xã Quỳnh Đôi	421	active
17176	Xã Quỳnh Lương	421	active
17179	Xã Quỳnh Hồng	421	active
17182	Xã Quỳnh Yên	421	active
17185	Xã Quỳnh Bá	421	active
17188	Xã Quỳnh Minh	421	active
17191	Xã Quỳnh Diễn	421	active
17194	Xã Quỳnh Hưng	421	active
17197	Xã Quỳnh Giang	421	active
17200	Xã Quỳnh Ngọc	421	active
17203	Xã Quỳnh Nghĩa	421	active
17206	Xã An Hòa	421	active
17209	Xã Tiến Thủy	421	active
17212	Xã Sơn Hải	421	active
17215	Xã Quỳnh Thọ	421	active
17218	Xã Quỳnh Thuận	421	active
17221	Xã Quỳnh Long	421	active
17224	Xã Tân Thắng	421	active
17227	Thị trấn Con Cuông	422	active
17230	Xã Bình Chuẩn	422	active
17233	Xã Lạng Khê	422	active
17236	Xã Cam Lâm	422	active
17239	Xã Thạch Ngàn	422	active
17242	Xã Đôn Phục	422	active
17245	Xã Mậu Đức	422	active
17248	Xã Châu Khê	422	active
17251	Xã Chi Khê	422	active
17254	Xã Bồng Khê	422	active
17257	Xã Yên Khê	422	active
17260	Xã Lục Dạ	422	active
17263	Xã Môn Sơn	422	active
17266	Thị trấn Tân Kỳ	423	active
17269	Xã Tân Hợp	423	active
17272	Xã Tân Phú	423	active
17275	Xã Tân Xuân	423	active
17278	Xã Giai Xuân	423	active
17281	Xã Nghĩa Bình	423	active
17284	Xã Nghĩa Đồng	423	active
17287	Xã Đồng Văn	423	active
17290	Xã Nghĩa Thái	423	active
17293	Xã Nghĩa Hợp	423	active
17296	Xã Nghĩa Hoàn	423	active
17299	Xã Nghĩa Phúc	423	active
17302	Xã Tiên Kỳ	423	active
17305	Xã Tân An	423	active
17308	Xã Nghĩa Dũng	423	active
17311	Xã Tân Long	423	active
17314	Xã Kỳ Sơn	423	active
17317	Xã Hương Sơn	423	active
17320	Xã Kỳ Tân	423	active
17323	Xã Phú Sơn	423	active
17325	Xã Tân Hương	423	active
17326	Xã Nghĩa Hành	423	active
17329	Thị trấn Anh Sơn	424	active
17332	Xã Thọ Sơn	424	active
17335	Xã Thành Sơn	424	active
17338	Xã Bình Sơn	424	active
17341	Xã Tam Sơn	424	active
17344	Xã Đỉnh Sơn	424	active
17347	Xã Hùng Sơn	424	active
17350	Xã Cẩm Sơn	424	active
17353	Xã Đức Sơn	424	active
17356	Xã Tường Sơn	424	active
17357	Xã Hoa Sơn	424	active
17359	Xã Tào Sơn	424	active
17362	Xã Vĩnh Sơn	424	active
17365	Xã Lạng Sơn	424	active
17368	Xã Hội Sơn	424	active
17371	Xã Thạch Sơn	424	active
17374	Xã Phúc Sơn	424	active
17377	Xã Long Sơn	424	active
17380	Xã Khai Sơn	424	active
17383	Xã Lĩnh Sơn	424	active
17386	Xã Cao Sơn	424	active
17389	Thị trấn Diễn Châu	425	active
17392	Xã Diễn Lâm	425	active
17395	Xã Diễn Đoài	425	active
17398	Xã Diễn Trường	425	active
17401	Xã Diễn Yên	425	active
17404	Xã Diễn Hoàng	425	active
17407	Xã Diễn Hùng	425	active
17410	Xã Diễn Mỹ	425	active
17413	Xã Diễn Hồng	425	active
17416	Xã Diễn Phong	425	active
17419	Xã Diễn Hải	425	active
17422	Xã Diễn Tháp	425	active
17425	Xã Diễn Liên	425	active
17428	Xã Diễn Vạn	425	active
17431	Xã Diễn Kim	425	active
17434	Xã Diễn Kỷ	425	active
17437	Xã Diễn Xuân	425	active
17440	Xã Diễn Thái	425	active
17443	Xã Diễn Đồng	425	active
17446	Xã Diễn Bích	425	active
17449	Xã Diễn Hạnh	425	active
17452	Xã Diễn Ngọc	425	active
17455	Xã Diễn Quảng	425	active
17458	Xã Diễn Nguyên	425	active
17461	Xã Diễn Hoa	425	active
17464	Xã Diễn Thành	425	active
17467	Xã Diễn Phúc	425	active
17476	Xã Diễn Cát	425	active
17479	Xã Diễn Thịnh	425	active
17482	Xã Diễn Tân	425	active
17485	Xã Minh Châu	425	active
17488	Xã Diễn Thọ	425	active
17491	Xã Diễn Lợi	425	active
17494	Xã Diễn Lộc	425	active
17497	Xã Diễn Trung	425	active
17500	Xã Diễn An	425	active
17503	Xã Diễn Phú	425	active
17506	Thị trấn Yên Thành	426	active
17509	Xã Mã Thành	426	active
17510	Xã Tiến Thành	426	active
17512	Xã Lăng Thành	426	active
17515	Xã Tân Thành	426	active
17518	Xã Đức Thành	426	active
17521	Xã Kim Thành	426	active
17524	Xã Hậu Thành	426	active
17525	Xã Hùng Thành	426	active
17527	Xã Đô Thành	426	active
17530	Xã Thọ Thành	426	active
17533	Xã Quang Thành	426	active
17536	Xã Tây Thành	426	active
17539	Xã Phúc Thành	426	active
17542	Xã Hồng Thành	426	active
17545	Xã Đồng Thành	426	active
17548	Xã Phú Thành	426	active
17551	Xã Hoa Thành	426	active
17554	Xã Tăng Thành	426	active
17557	Xã Văn Thành	426	active
17560	Xã Thịnh Thành	426	active
17563	Xã Hợp Thành	426	active
17566	Xã Xuân Thành	426	active
17569	Xã Bắc Thành	426	active
17572	Xã Nhân Thành	426	active
17575	Xã Trung Thành	426	active
17578	Xã Long Thành	426	active
17581	Xã Minh Thành	426	active
17584	Xã Nam Thành	426	active
17587	Xã Vĩnh Thành	426	active
17590	Xã Lý Thành	426	active
17593	Xã Khánh Thành	426	active
17596	Xã Viên Thành	426	active
17599	Xã Đại Thành	426	active
17602	Xã Liên Thành	426	active
17605	Xã Bảo Thành	426	active
17608	Xã Mỹ Thành	426	active
17611	Xã Công Thành	426	active
17614	Xã Sơn Thành	426	active
17617	Thị trấn Đô Lương	427	active
17619	Xã Giang Sơn Đông	427	active
17620	Xã Giang Sơn Tây	427	active
17623	Xã Lam Sơn	427	active
17626	Xã Bồi Sơn	427	active
17629	Xã Hồng Sơn	427	active
17632	Xã Bài Sơn	427	active
17635	Xã Ngọc Sơn	427	active
17638	Xã Bắc Sơn	427	active
17641	Xã Tràng Sơn	427	active
17644	Xã Thượng Sơn	427	active
17647	Xã Hòa Sơn	427	active
17650	Xã Đặng Sơn	427	active
17653	Xã Đông Sơn	427	active
17656	Xã Nam Sơn	427	active
17659	Xã Lưu Sơn	427	active
17662	Xã Yên Sơn	427	active
17665	Xã Văn Sơn	427	active
17668	Xã Đà Sơn	427	active
17671	Xã Lạc Sơn	427	active
17674	Xã Tân Sơn	427	active
17677	Xã Thái Sơn	427	active
17680	Xã Quang Sơn	427	active
17683	Xã Thịnh Sơn	427	active
17686	Xã Trung Sơn	427	active
17689	Xã Xuân Sơn	427	active
17692	Xã Minh Sơn	427	active
17695	Xã Thuận Sơn	427	active
17698	Xã Nhân Sơn	427	active
17701	Xã Hiến Sơn	427	active
17704	Xã Mỹ Sơn	427	active
17707	Xã Trù Sơn	427	active
17710	Xã Đại Sơn	427	active
17713	Thị trấn Thanh Chương	428	active
17716	Xã Cát Văn	428	active
17719	Xã Thanh Nho	428	active
17722	Xã Hạnh Lâm	428	active
17723	Xã Thanh Sơn	428	active
17725	Xã Thanh Hòa	428	active
17728	Xã Phong Thịnh	428	active
17731	Xã Thanh Phong	428	active
17734	Xã Thanh Mỹ	428	active
17737	Xã Thanh Tiên	428	active
17743	Xã Thanh Liên	428	active
17749	Xã Đại Đồng	428	active
17752	Xã Thanh Đồng	428	active
17755	Xã Thanh Ngọc	428	active
17758	Xã Thanh Hương	428	active
17759	Xã Ngọc Lâm	428	active
17761	Xã Thanh Lĩnh	428	active
17764	Xã Đồng Văn	428	active
17767	Xã Ngọc Sơn	428	active
17770	Xã Thanh Thịnh	428	active
17773	Xã Thanh An	428	active
17776	Xã Thanh Chi	428	active
17779	Xã Xuân Tường	428	active
17782	Xã Thanh Dương	428	active
17785	Xã Thanh Lương	428	active
17788	Xã Thanh Khê	428	active
17791	Xã Võ Liệt	428	active
17794	Xã Thanh Long	428	active
17797	Xã Thanh Thủy	428	active
17800	Xã Thanh Khai	428	active
17803	Xã Thanh Yên	428	active
17806	Xã Thanh Hà	428	active
17809	Xã Thanh Giang	428	active
17812	Xã Thanh Tùng	428	active
17815	Xã Thanh Lâm	428	active
17818	Xã Thanh Mai	428	active
17821	Xã Thanh Xuân	428	active
17824	Xã Thanh Đức	428	active
17827	Thị trấn Quán Hành	429	active
17830	Xã Nghi Văn	429	active
17833	Xã Nghi Yên	429	active
17836	Xã Nghi Tiến	429	active
17839	Xã Nghi Hưng	429	active
17842	Xã Nghi Đồng	429	active
17845	Xã Nghi Thiết	429	active
17848	Xã Nghi Lâm	429	active
17851	Xã Nghi Quang	429	active
17854	Xã Nghi Kiều	429	active
17857	Xã Nghi Mỹ	429	active
17860	Xã Nghi Phương	429	active
17863	Xã Nghi Thuận	429	active
17866	Xã Nghi Long	429	active
17869	Xã Nghi Xá	429	active
17875	Xã Nghi Hoa	429	active
17878	Xã Khánh Hợp	429	active
17881	Xã Nghi Thịnh	429	active
17884	Xã Nghi Công Bắc	429	active
17887	Xã Nghi Công Nam	429	active
17890	Xã Nghi Thạch	429	active
17893	Xã Nghi Trung	429	active
17896	Xã Nghi Trường	429	active
17899	Xã Nghi Diên	429	active
17902	Xã Nghi Phong	429	active
17905	Xã Nghi Xuân	429	active
17911	Xã Nghi Vạn	429	active
17917	Xã Phúc Thọ	429	active
17926	Xã Nghi Thái	429	active
17932	Xã Nam Hưng	430	active
17935	Xã Nam Nghĩa	430	active
17938	Xã Nam Thanh	430	active
17941	Xã Nam Anh	430	active
17944	Xã Nam Xuân	430	active
17947	Xã Nam Thái	430	active
17950	Thị trấn Nam Đàn	430	active
17953	Xã Nam Lĩnh	430	active
17956	Xã Nam Giang	430	active
17959	Xã Xuân Hòa	430	active
17962	Xã Hùng Tiến	430	active
17968	Xã Thượng Tân Lộc	430	active
17971	Xã Kim Liên	430	active
17977	Xã Hồng Long	430	active
17980	Xã Xuân Lâm	430	active
17983	Xã Nam Cát	430	active
17986	Xã Khánh Sơn	430	active
17989	Xã Trung Phúc Cường	430	active
17998	Xã Nam Kim	430	active
18001	Thị trấn Hưng Nguyên	431	active
18004	Xã Hưng Trung	431	active
18007	Xã Hưng Yên	431	active
18008	Xã Hưng Yên Bắc	431	active
18010	Xã Hưng Tây	431	active
18016	Xã Hưng Đạo	431	active
18019	Xã Hưng Mỹ	431	active
18022	Xã Hưng Thịnh	431	active
18025	Xã Hưng Lĩnh	431	active
18028	Xã Hưng Thông	431	active
18031	Xã Hưng Tân	431	active
18034	Xã Hưng Lợi	431	active
18037	Xã Hưng Nghĩa	431	active
18040	Xã Hưng Phúc	431	active
18043	Xã Long Xá	431	active
18052	Xã Châu Nhân	431	active
18055	Xã Xuân Lam	431	active
18064	Xã Hưng Thành	431	active
17104	Xã Quỳnh Vinh	432	active
17107	Xã Quỳnh Lộc	432	active
17110	Phường Quỳnh Thiện	432	active
17113	Xã Quỳnh Lập	432	active
17116	Xã Quỳnh Trang	432	active
17125	Phường Mai Hùng	432	active
17128	Phường Quỳnh Dị	432	active
17131	Phường Quỳnh Xuân	432	active
17134	Phường Quỳnh Phương	432	active
17137	Xã Quỳnh Liên	432	active
18070	Phường Trần Phú	436	active
18073	Phường Nam Hà	436	active
18076	Phường Bắc Hà	436	active
18077	Phường Nguyễn Du	436	active
18079	Phường Tân Giang	436	active
18082	Phường Đại Nài	436	active
18085	Phường Hà Huy Tập	436	active
18088	Xã Thạch Trung	436	active
18091	Phường Thạch Quý	436	active
18094	Phường Thạch Linh	436	active
18097	Phường Văn Yên	436	active
18100	Xã Thạch Hạ	436	active
18103	Xã Đồng Môn	436	active
18109	Xã Thạch Hưng	436	active
18112	Xã Thạch Bình	436	active
18115	Phường Bắc Hồng	437	active
18931	Xã Minh Hóa	452	active
18118	Phường Nam Hồng	437	active
18121	Phường Trung Lương	437	active
18124	Phường Đức Thuận	437	active
18127	Phường Đậu Liêu	437	active
18130	Xã Thuận Lộc	437	active
18133	Thị trấn Phố Châu	439	active
18136	Thị trấn Tây Sơn	439	active
18139	Xã Sơn Hồng	439	active
18142	Xã Sơn Tiến	439	active
18145	Xã Sơn Lâm	439	active
18148	Xã Sơn Lễ	439	active
18157	Xã Sơn Giang	439	active
18160	Xã Sơn Lĩnh	439	active
18163	Xã An Hòa Thịnh	439	active
18172	Xã Sơn Tây	439	active
18175	Xã Sơn Ninh	439	active
18178	Xã Sơn Châu	439	active
18181	Xã Tân Mỹ Hà	439	active
18184	Xã Quang Diệm	439	active
18187	Xã Sơn Trung	439	active
18190	Xã Sơn Bằng	439	active
18193	Xã Sơn Bình	439	active
18196	Xã Sơn Kim 1	439	active
18199	Xã Sơn Kim 2	439	active
18202	Xã Sơn Trà	439	active
18205	Xã Sơn Long	439	active
18211	Xã Kim Hoa	439	active
18214	Xã Sơn Hàm	439	active
18217	Xã Sơn Phú	439	active
18223	Xã Sơn Trường	439	active
18229	Thị trấn Đức Thọ	440	active
18235	Xã Quang Vĩnh	440	active
18241	Xã Tùng Châu	440	active
18244	Xã Trường Sơn	440	active
18247	Xã Liên Minh	440	active
18253	Xã Yên Hồ	440	active
18259	Xã Tùng Ảnh	440	active
18262	Xã Bùi La Nhân	440	active
18274	Xã Thanh Bình Thịnh	440	active
18277	Xã Lâm Trung Thủy	440	active
18280	Xã Hòa Lạc	440	active
18283	Xã Tân Dân	440	active
18298	Xã An Dũng	440	active
18304	Xã Đức Đồng	440	active
18307	Xã Đức Lạng	440	active
18310	Xã Tân Hương	440	active
18313	Thị trấn Vũ Quang	441	active
18316	Xã Ân Phú	441	active
18319	Xã Đức Giang	441	active
18322	Xã Đức Lĩnh	441	active
18325	Xã Thọ Điền	441	active
18328	Xã Đức Hương	441	active
18331	Xã Đức Bồng	441	active
18334	Xã Đức Liên	441	active
18340	Xã Hương Minh	441	active
18343	Xã Quang Thọ	441	active
18352	Thị trấn Xuân An	442	active
18355	Xã Xuân Hội	442	active
18358	Xã Đan Trường	442	active
18364	Xã Xuân Phổ	442	active
18367	Xã Xuân Hải	442	active
18370	Xã Xuân Giang	442	active
18373	Thị trấn Tiên Điền	442	active
18376	Xã Xuân Yên	442	active
18379	Xã Xuân Mỹ	442	active
18382	Xã Xuân Thành	442	active
18385	Xã Xuân Viên	442	active
18388	Xã Xuân Hồng	442	active
18391	Xã Cỗ Đạm	442	active
18394	Xã Xuân Liên	442	active
18397	Xã Xuân Lĩnh	442	active
18400	Xã Xuân Lam	442	active
18403	Xã Cương Gián	442	active
18406	Thị trấn Nghèn	443	active
18415	Xã Thiên Lộc	443	active
18418	Xã Thuần Thiện	443	active
18427	Xã Vượng Lộc	443	active
18433	Xã Thanh Lộc	443	active
18436	Xã Kim Song Trường	443	active
18439	Xã Thường Nga	443	active
18445	Xã Tùng Lộc	443	active
18454	Xã Phú Lộc	443	active
18463	Xã Gia Hanh	443	active
18466	Xã Khánh Vĩnh Yên	443	active
18472	Xã Trung Lộc	443	active
18475	Xã Xuân Lộc	443	active
18478	Xã Thượng Lộc	443	active
18481	Xã Quang Lộc	443	active
18484	Thị trấn Đồng Lộc	443	active
18487	Xã Mỹ Lộc	443	active
18490	Xã Sơn Lộc	443	active
18496	Thị trấn Hương Khê	444	active
18499	Xã Điền Mỹ	444	active
18502	Xã Hà Linh	444	active
18505	Xã Hương Thủy	444	active
18508	Xã Hòa Hải	444	active
18514	Xã Phúc Đồng	444	active
18517	Xã Hương Giang	444	active
18520	Xã Lộc Yên	444	active
18523	Xã Hương Bình	444	active
18526	Xã Hương Long	444	active
18529	Xã Phú Gia	444	active
18532	Xã Gia Phố	444	active
18535	Xã Phú Phong	444	active
18538	Xã Hương Đô	444	active
18541	Xã Hương Vĩnh	444	active
18544	Xã Hương Xuân	444	active
18547	Xã Phúc Trạch	444	active
18550	Xã Hương Trà	444	active
18553	Xã Hương Trạch	444	active
18556	Xã Hương Lâm	444	active
18559	Xã Hương Liên	444	active
18562	Thị trấn Thạch Hà	445	active
18565	Xã Ngọc Sơn	445	active
18571	Xã Thạch Hải	445	active
18586	Xã Thạch Kênh	445	active
18589	Xã Thạch Sơn	445	active
18592	Xã Thạch Liên	445	active
18595	Xã Đỉnh Bàn	445	active
18601	Xã Việt Tiến	445	active
18604	Xã Thạch Khê	445	active
18607	Xã Thạch Long	445	active
18619	Xã Thạch Trị	445	active
18622	Xã Thạch Lạc	445	active
18625	Xã Thạch Ngọc	445	active
18628	Xã Tượng Sơn	445	active
18631	Xã Thạch Văn	445	active
18634	Xã Lưu Vĩnh Sơn	445	active
18637	Xã Thạch Thắng	445	active
18643	Xã Thạch Đài	445	active
18649	Xã Thạch Hội	445	active
18652	Xã Tân Lâm Hương	445	active
18658	Xã Thạch Xuân	445	active
18667	Xã Nam Điền	445	active
18673	Thị trấn Cẩm Xuyên	446	active
18676	Thị trấn Thiên Cầm	446	active
18679	Xã Yên Hòa	446	active
18682	Xã Cẩm Dương	446	active
18685	Xã Cẩm Bình	446	active
18691	Xã Cẩm Vĩnh	446	active
18694	Xã Cẩm Thành	446	active
18697	Xã Cẩm Quang	446	active
18706	Xã Cẩm Thạch	446	active
18709	Xã Cẩm Nhượng	446	active
18712	Xã Nam Phúc Thăng	446	active
18715	Xã Cẩm Duệ	446	active
18721	Xã Cẩm Lĩnh	446	active
18724	Xã Cẩm Quan	446	active
18727	Xã Cẩm Hà	446	active
18730	Xã Cẩm Lộc	446	active
18733	Xã Cẩm Hưng	446	active
18736	Xã Cẩm Thịnh	446	active
18739	Xã Cẩm Mỹ	446	active
18742	Xã Cẩm Trung	446	active
18745	Xã Cẩm Sơn	446	active
18748	Xã Cẩm Lạc	446	active
18751	Xã Cẩm Minh	446	active
18757	Xã Kỳ Xuân	447	active
18760	Xã Kỳ Bắc	447	active
18763	Xã Kỳ Phú	447	active
18766	Xã Kỳ Phong	447	active
18769	Xã Kỳ Tiến	447	active
18772	Xã Kỳ Giang	447	active
18775	Xã Kỳ Đồng	447	active
18778	Xã Kỳ Khang	447	active
18784	Xã Kỳ Văn	447	active
18787	Xã Kỳ Trung	447	active
18790	Xã Kỳ Thọ	447	active
18793	Xã Kỳ Tây	447	active
18799	Xã Kỳ Thượng	447	active
18802	Xã Kỳ Hải	447	active
18805	Xã Kỳ Thư	447	active
18811	Xã Kỳ Châu	447	active
18814	Xã Kỳ Tân	447	active
18838	Xã Lâm Hợp	447	active
18844	Xã Kỳ Sơn	447	active
18850	Xã Kỳ Lạc	447	active
18409	Xã Tân Lộc	448	active
18412	Xã Hồng Lộc	448	active
18421	Xã Thịnh Lộc	448	active
18430	Xã Bình An	448	active
18457	Xã Ích Hậu	448	active
18493	Xã Phù Lưu	448	active
18568	Thị trấn Lộc Hà	448	active
18577	Xã Thạch Mỹ	448	active
18580	Xã Thạch Kim	448	active
18583	Xã Thạch Châu	448	active
18598	Xã Hộ Độ	448	active
18670	Xã Mai Phụ	448	active
18754	Phường Hưng Trí	449	active
18781	Xã Kỳ Ninh	449	active
18796	Xã Kỳ Lợi	449	active
18808	Xã Kỳ Hà	449	active
18820	Phường Kỳ Trinh	449	active
18823	Phường Kỳ Thịnh	449	active
18829	Xã Kỳ Hoa	449	active
18832	Phường Kỳ Phương	449	active
18835	Phường Kỳ Long	449	active
18841	Phường Kỳ Liên	449	active
18847	Xã Kỳ Nam	449	active
18853	Phường Hải Thành	450	active
18856	Phường Đồng Phú	450	active
18859	Phường Bắc Lý	450	active
18865	Phường Nam Lý	450	active
18868	Phường Đồng Hải	450	active
18871	Phường Đồng Sơn	450	active
18874	Phường Phú Hải	450	active
18877	Phường Bắc Nghĩa	450	active
18880	Phường Đức Ninh Đông	450	active
18883	Xã Quang Phú	450	active
18886	Xã Lộc Ninh	450	active
18889	Xã Bảo Ninh	450	active
18892	Xã Nghĩa Ninh	450	active
18895	Xã Thuận Đức	450	active
18898	Xã Đức Ninh	450	active
18901	Thị trấn Quy Đạt	452	active
18904	Xã Dân Hóa	452	active
18907	Xã Trọng Hóa	452	active
18910	Xã Hóa Phúc	452	active
18913	Xã Hồng Hóa	452	active
18916	Xã Hóa Thanh	452	active
18919	Xã Hóa Tiến	452	active
18922	Xã Hóa Hợp	452	active
18925	Xã Xuân Hóa	452	active
18928	Xã Yên Hóa	452	active
18934	Xã Tân Hóa	452	active
18937	Xã Hóa Sơn	452	active
18943	Xã Trung Hóa	452	active
18946	Xã Thượng Hóa	452	active
18949	Thị trấn Đồng Lê	453	active
18952	Xã Hương Hóa	453	active
18955	Xã Kim Hóa	453	active
18958	Xã Thanh Hóa	453	active
18961	Xã Thanh Thạch	453	active
18964	Xã Thuận Hóa	453	active
18967	Xã Lâm Hóa	453	active
18970	Xã Lê Hóa	453	active
18973	Xã Sơn Hóa	453	active
18976	Xã Đồng Hóa	453	active
18979	Xã Ngư Hóa	453	active
18985	Xã Thạch Hóa	453	active
18988	Xã Đức Hóa	453	active
18991	Xã Phong Hóa	453	active
18994	Xã Mai Hóa	453	active
18997	Xã Tiến Hóa	453	active
19000	Xã Châu Hóa	453	active
19003	Xã Cao Quảng	453	active
19006	Xã Văn Hóa	453	active
19012	Xã Quảng Hợp	454	active
19015	Xã Quảng Kim	454	active
19018	Xã Quảng Đông	454	active
19021	Xã Quảng Phú	454	active
19024	Xã Quảng Châu	454	active
19027	Xã Quảng Thạch	454	active
19030	Xã Quảng Lưu	454	active
19033	Xã Quảng Tùng	454	active
19036	Xã Cảnh Dương	454	active
19039	Xã Quảng Tiến	454	active
19042	Xã Quảng Hưng	454	active
19045	Xã Quảng Xuân	454	active
19048	Xã Cảnh Hóa	454	active
19051	Xã Liên Trường	454	active
19057	Xã Quảng Phương	454	active
19063	Xã Phù Hóa	454	active
19072	Xã Quảng Thanh	454	active
19111	Thị trấn Hoàn Lão	455	active
19114	Thị trấn NT Việt Trung	455	active
19117	Xã Xuân Trạch	455	active
19120	Xã Mỹ Trạch	455	active
19123	Xã Hạ Trạch	455	active
19126	Xã Bắc Trạch	455	active
19129	Xã Lâm Trạch	455	active
19132	Xã Thanh Trạch	455	active
19135	Xã Liên Trạch	455	active
19138	Xã Phúc Trạch	455	active
19141	Xã Cự Nẫm	455	active
19144	Xã Hải Phú	455	active
19147	Xã Thượng Trạch	455	active
19150	Xã Sơn Lộc	455	active
19156	Xã Hưng Trạch	455	active
19159	Xã Đồng Trạch	455	active
19162	Xã Đức Trạch	455	active
19165	Thị trấn Phong Nha	455	active
19168	Xã Vạn Trạch	455	active
19174	Xã Phú Định	455	active
19177	Xã Trung Trạch	455	active
19180	Xã Tây Trạch	455	active
19183	Xã Hòa Trạch	455	active
19186	Xã Đại Trạch	455	active
19189	Xã Nhân Trạch	455	active
19192	Xã Tân Trạch	455	active
19195	Xã Nam Trạch	455	active
19198	Xã Lý Trạch	455	active
19201	Thị trấn Quán Hàu	456	active
19204	Xã Trường Sơn	456	active
19207	Xã Lương Ninh	456	active
19210	Xã Vĩnh Ninh	456	active
19213	Xã Võ Ninh	456	active
19216	Xã Hải Ninh	456	active
19219	Xã Hàm Ninh	456	active
19222	Xã Duy Ninh	456	active
19225	Xã Gia Ninh	456	active
19228	Xã Trường Xuân	456	active
19231	Xã Hiền Ninh	456	active
19234	Xã Tân Ninh	456	active
19237	Xã Xuân Ninh	456	active
19240	Xã An Ninh	456	active
19243	Xã Vạn Ninh	456	active
19246	Thị trấn NT Lệ Ninh	457	active
19249	Thị trấn Kiến Giang	457	active
19252	Xã Hồng Thủy	457	active
19255	Xã Ngư Thủy Bắc	457	active
19258	Xã Hoa Thủy	457	active
19261	Xã Thanh Thủy	457	active
19264	Xã An Thủy	457	active
19267	Xã Phong Thủy	457	active
19270	Xã Cam Thủy	457	active
19273	Xã Ngân Thủy	457	active
19276	Xã Sơn Thủy	457	active
19279	Xã Lộc Thủy	457	active
19285	Xã Liên Thủy	457	active
19288	Xã Hưng Thủy	457	active
19291	Xã Dương Thủy	457	active
19294	Xã Tân Thủy	457	active
19297	Xã Phú Thủy	457	active
19300	Xã Xuân Thủy	457	active
19303	Xã Mỹ Thủy	457	active
19306	Xã Ngư Thủy	457	active
19309	Xã Mai Thủy	457	active
19312	Xã Sen Thủy	457	active
19315	Xã Thái Thủy	457	active
19318	Xã Kim Thủy	457	active
19321	Xã Trường Thủy	457	active
19327	Xã Lâm Thủy	457	active
19009	Phường Ba Đồn	458	active
19060	Phường Quảng Long	458	active
19066	Phường Quảng Thọ	458	active
19069	Xã Quảng Tiên	458	active
19075	Xã Quảng Trung	458	active
19078	Phường Quảng Phong	458	active
19081	Phường Quảng Thuận	458	active
19084	Xã Quảng Tân	458	active
19087	Xã Quảng Hải	458	active
19090	Xã Quảng Sơn	458	active
19093	Xã Quảng Lộc	458	active
19096	Xã Quảng Thủy	458	active
19099	Xã Quảng Văn	458	active
19102	Phường Quảng Phúc	458	active
19105	Xã Quảng Hòa	458	active
19108	Xã Quảng Minh	458	active
19330	Phường Đông Giang	461	active
19333	Phường 1	461	active
19336	Phường Đông Lễ	461	active
19339	Phường Đông Thanh	461	active
19342	Phường 2	461	active
19345	Phường 4	461	active
19348	Phường 5	461	active
19351	Phường Đông Lương	461	active
19354	Phường 3	461	active
19357	Phường 1	462	active
19358	Phường An Đôn	462	active
19360	Phường 2	462	active
19361	Phường 3	462	active
19705	Xã Hải Lệ	462	active
19363	Thị trấn Hồ Xá	464	active
19366	Thị trấn Bến Quan	464	active
19369	Xã Vĩnh Thái	464	active
19372	Xã Vĩnh Tú	464	active
19375	Xã Vĩnh Chấp	464	active
19378	Xã Trung Nam	464	active
19384	Xã Kim Thạch	464	active
19387	Xã Vĩnh Long	464	active
19393	Xã Vĩnh Khê	464	active
19396	Xã Vĩnh Hòa	464	active
19402	Xã Vĩnh Thủy	464	active
19405	Xã Vĩnh Lâm	464	active
19408	Xã Hiền Thành	464	active
19414	Thị trấn Cửa Tùng	464	active
19417	Xã Vĩnh Hà	464	active
19420	Xã Vĩnh Sơn	464	active
19423	Xã Vĩnh Giang	464	active
19426	Xã Vĩnh Ô	464	active
19429	Thị trấn Khe Sanh	465	active
19432	Thị trấn Lao Bảo	465	active
19435	Xã Hướng Lập	465	active
19438	Xã Hướng Việt	465	active
19441	Xã Hướng Phùng	465	active
19444	Xã Hướng Sơn	465	active
19447	Xã Hướng Linh	465	active
19450	Xã Tân Hợp	465	active
19453	Xã Hướng Tân	465	active
19456	Xã Tân Thành	465	active
19459	Xã Tân Long	465	active
19462	Xã Tân Lập	465	active
19465	Xã Tân Liên	465	active
19468	Xã Húc	465	active
19471	Xã Thuận	465	active
19474	Xã Hướng Lộc	465	active
19477	Xã Ba Tầng	465	active
19480	Xã Thanh	465	active
19483	Xã A Dơi	465	active
19489	Xã Lìa	465	active
19492	Xã Xy	465	active
19495	Thị trấn Gio Linh	466	active
19496	Thị trấn Cửa Việt	466	active
19498	Xã Trung Giang	466	active
19501	Xã Trung Hải	466	active
19504	Xã Trung Sơn	466	active
19507	Xã Phong Bình	466	active
19510	Xã Gio Mỹ	466	active
19519	Xã Gio Hải	466	active
19522	Xã Gio An	466	active
19525	Xã Gio Châu	466	active
19531	Xã Gio Việt	466	active
19534	Xã Linh Trường	466	active
19537	Xã Gio Sơn	466	active
19543	Xã Gio Mai	466	active
19546	Xã Hải Thái	466	active
19549	Xã Linh Hải	466	active
19552	Xã Gio Quang	466	active
19555	Thị trấn Krông Klang	467	active
19558	Xã Mò Ó	467	active
19561	Xã Hướng Hiệp	467	active
19564	Xã Đa Krông	467	active
19567	Xã Triệu Nguyên	467	active
19570	Xã Ba Lòng	467	active
19576	Xã Ba Nang	467	active
19579	Xã Tà Long	467	active
19582	Xã Húc Nghì	467	active
19585	Xã A Vao	467	active
19588	Xã Tà Rụt	467	active
19591	Xã A Bung	467	active
19594	Xã A Ngo	467	active
19597	Thị trấn Cam Lộ	468	active
19600	Xã Cam Tuyền	468	active
19603	Xã Thanh An	468	active
19606	Xã Cam Thủy	468	active
19612	Xã Cam Thành	468	active
19615	Xã Cam Hiếu	468	active
19618	Xã Cam Chính	468	active
19621	Xã Cam Nghĩa	468	active
19624	Thị Trấn Ái Tử	469	active
19627	Xã Triệu An	469	active
19630	Xã Triệu Vân	469	active
19633	Xã Triệu Phước	469	active
19636	Xã Triệu Độ	469	active
19639	Xã Triệu Trạch	469	active
19642	Xã Triệu Thuận	469	active
19645	Xã Triệu Đại	469	active
19648	Xã Triệu Hòa	469	active
19990	Xã Phú Sơn	479	active
19651	Xã Triệu Lăng	469	active
19654	Xã Triệu Sơn	469	active
19657	Xã Triệu Long	469	active
19660	Xã Triệu Tài	469	active
19666	Xã Triệu Trung	469	active
19669	Xã Triệu Ái	469	active
19672	Xã Triệu Thượng	469	active
19675	Xã Triệu Giang	469	active
19678	Xã Triệu Thành	469	active
19681	Thị trấn Diên Sanh	470	active
19684	Xã Hải An	470	active
19687	Xã Hải Ba	470	active
19693	Xã Hải Quy	470	active
19696	Xã Hải Quế	470	active
19699	Xã Hải Hưng	470	active
19702	Xã Hải Phú	470	active
19708	Xã Hải Thượng	470	active
19711	Xã Hải Dương	470	active
19714	Xã Hải Định	470	active
19717	Xã Hải Lâm	470	active
19726	Xã Hải Phong	470	active
19729	Xã Hải Trường	470	active
19735	Xã Hải Sơn	470	active
19738	Xã Hải Chánh	470	active
19741	Xã Hải Khê	470	active
19750	Phường Tây Lộc	474	active
19753	Phường Thuận Lộc	474	active
19756	Phường Gia Hội	474	active
19759	Phường Phú Hậu	474	active
19762	Phường Thuận Hòa	474	active
19768	Phường Đông Ba	474	active
19774	Phường Kim Long	474	active
19777	Phường Vỹ Dạ	474	active
19780	Phường Phường Đúc	474	active
19783	Phường Vĩnh Ninh	474	active
19786	Phường Phú Hội	474	active
19789	Phường Phú Nhuận	474	active
19792	Phường Xuân Phú	474	active
19795	Phường Trường An	474	active
19798	Phường Phước Vĩnh	474	active
19801	Phường An Cựu	474	active
19803	Phường An Hòa	474	active
19804	Phường Hương Sơ	474	active
19807	Phường Thuỷ Biều	474	active
19810	Phường Hương Long	474	active
19813	Phường Thuỷ Xuân	474	active
19815	Phường An Đông	474	active
19816	Phường An Tây	474	active
19900	Phường Thuận An	474	active
19906	Xã Phú Dương	474	active
19909	Xã Phú Mậu	474	active
19924	Xã Phú Thanh	474	active
19930	Phường Phú Thượng	474	active
19963	Phường Thủy Vân	474	active
19981	Xã Thủy Bằng	474	active
19999	Xã Hải Dương	474	active
20002	Xã Hương Phong	474	active
20014	Phường Hương Vinh	474	active
20023	Phường Hương An	474	active
20029	Phường Hương Hồ	474	active
20032	Xã Hương Thọ	474	active
19819	Thị trấn Phong Điền	476	active
19822	Xã Điền Hương	476	active
19825	Xã Điền Môn	476	active
19828	Xã Điền Lộc	476	active
19831	Xã Phong Bình	476	active
19834	Xã Điền Hòa	476	active
19837	Xã Phong Chương	476	active
19840	Xã Phong Hải	476	active
19843	Xã Điền Hải	476	active
19846	Xã Phong Hòa	476	active
19849	Xã Phong Thu	476	active
19852	Xã Phong Hiền	476	active
19855	Xã Phong Mỹ	476	active
19858	Xã Phong An	476	active
19861	Xã Phong Xuân	476	active
19864	Xã Phong Sơn	476	active
19867	Thị trấn Sịa	477	active
19870	Xã Quảng Thái	477	active
19873	Xã Quảng Ngạn	477	active
19876	Xã Quảng Lợi	477	active
19879	Xã Quảng Công	477	active
19882	Xã Quảng Phước	477	active
19885	Xã Quảng Vinh	477	active
19888	Xã Quảng An	477	active
19891	Xã Quảng Thành	477	active
19894	Xã Quảng Thọ	477	active
19897	Xã Quảng Phú	477	active
19903	Xã Phú Thuận	478	active
19912	Xã Phú An	478	active
19915	Xã Phú Hải	478	active
19918	Xã Phú Xuân	478	active
19921	Xã Phú Diên	478	active
19927	Xã Phú Mỹ	478	active
19933	Xã Phú Hồ	478	active
19936	Xã Vinh Xuân	478	active
19939	Xã Phú Lương	478	active
19942	Thị trấn Phú Đa	478	active
19945	Xã Vinh Thanh	478	active
19948	Xã Vinh An	478	active
19954	Xã Phú Gia	478	active
19957	Xã Vinh Hà	478	active
19960	Phường Phú Bài	479	active
19966	Xã Thủy Thanh	479	active
19969	Phường Thủy Dương	479	active
19972	Phường Thủy Phương	479	active
19975	Phường Thủy Châu	479	active
19978	Phường Thủy Lương	479	active
19984	Xã Thủy Tân	479	active
19987	Xã Thủy Phù	479	active
19993	Xã Dương Hòa	479	active
19996	Phường Tứ Hạ	480	active
20005	Xã Hương Toàn	480	active
20008	Phường Hương Vân	480	active
20011	Phường Hương Văn	480	active
20017	Phường Hương Xuân	480	active
20020	Phường Hương Chữ	480	active
20026	Xã Hương Bình	480	active
20035	Xã Bình Tiến	480	active
20041	Xã Bình Thành	480	active
20044	Thị trấn A Lưới	481	active
20047	Xã Hồng Vân	481	active
20050	Xã Hồng Hạ	481	active
20053	Xã Hồng Kim	481	active
20056	Xã Trung Sơn	481	active
20059	Xã Hương Nguyên	481	active
20065	Xã Hồng Bắc	481	active
20068	Xã A Ngo	481	active
20071	Xã Sơn Thủy	481	active
20074	Xã Phú Vinh	481	active
20080	Xã Hương Phong	481	active
20083	Xã Quảng Nhâm	481	active
20086	Xã Hồng Thượng	481	active
20089	Xã Hồng Thái	481	active
20095	Xã A Roàng	481	active
20098	Xã Đông Sơn	481	active
20101	Xã Lâm Đớt	481	active
20104	Xã Hồng Thủy	481	active
20107	Thị trấn Phú Lộc	482	active
20110	Thị trấn Lăng Cô	482	active
20113	Xã Vinh Mỹ	482	active
20116	Xã Vinh Hưng	482	active
20122	Xã Giang Hải	482	active
20125	Xã Vinh Hiền	482	active
20128	Xã Lộc Bổn	482	active
20131	Xã Lộc Sơn	482	active
20134	Xã Lộc Bình	482	active
20137	Xã Lộc Vĩnh	482	active
20140	Xã Lộc An	482	active
20143	Xã Lộc Điền	482	active
20146	Xã Lộc Thủy	482	active
20149	Xã Lộc Trì	482	active
20152	Xã Lộc Tiến	482	active
20155	Xã Lộc Hòa	482	active
20158	Xã Xuân Lộc	482	active
20161	Thị trấn Khe Tre	483	active
20164	Xã Hương Phú	483	active
20167	Xã Hương Sơn	483	active
20170	Xã Hương Lộc	483	active
20173	Xã Thượng Quảng	483	active
20179	Xã Hương Xuân	483	active
20182	Xã Hương Hữu	483	active
20185	Xã Thượng Lộ	483	active
20188	Xã Thượng Long	483	active
20191	Xã Thượng Nhật	483	active
20194	Phường Hòa Hiệp Bắc	490	active
20195	Phường Hòa Hiệp Nam	490	active
20197	Phường Hòa Khánh Bắc	490	active
20198	Phường Hòa Khánh Nam	490	active
20200	Phường Hòa Minh	490	active
20203	Phường Tam Thuận	491	active
20206	Phường Thanh Khê Tây	491	active
20207	Phường Thanh Khê Đông	491	active
20209	Phường Xuân Hà	491	active
20212	Phường Tân Chính	491	active
20215	Phường Chính Gián	491	active
20218	Phường Vĩnh Trung	491	active
20221	Phường Thạc Gián	491	active
20224	Phường An Khê	491	active
20225	Phường Hòa Khê	491	active
20227	Phường Thanh Bình	492	active
20230	Phường Thuận Phước	492	active
20233	Phường Thạch Thang	492	active
20236	Phường Hải Châu I	492	active
20239	Phường Hải Châu II	492	active
20242	Phường Phước Ninh	492	active
20245	Phường Hòa Thuận Tây	492	active
20246	Phường Hòa Thuận Đông	492	active
20248	Phường Nam Dương	492	active
20251	Phường Bình Hiên	492	active
20254	Phường Bình Thuận	492	active
20257	Phường Hòa Cường Bắc	492	active
20258	Phường Hòa Cường Nam	492	active
20263	Phường Thọ Quang	493	active
20266	Phường Nại Hiên Đông	493	active
20269	Phường Mân Thái	493	active
20272	Phường An Hải Bắc	493	active
20275	Phường Phước Mỹ	493	active
20278	Phường An Hải Tây	493	active
20281	Phường An Hải Đông	493	active
20284	Phường Mỹ An	494	active
20285	Phường Khuê Mỹ	494	active
20287	Phường Hoà Quý	494	active
20290	Phường Hoà Hải	494	active
20260	Phường Khuê Trung	495	active
20305	Phường Hòa Phát	495	active
20306	Phường Hòa An	495	active
20311	Phường Hòa Thọ Tây	495	active
20312	Phường Hòa Thọ Đông	495	active
20314	Phường Hòa Xuân	495	active
20293	Xã Hòa Bắc	497	active
20296	Xã Hòa Liên	497	active
20299	Xã Hòa Ninh	497	active
20302	Xã Hòa Sơn	497	active
20308	Xã Hòa Nhơn	497	active
20317	Xã Hòa Phú	497	active
20320	Xã Hòa Phong	497	active
20323	Xã Hòa Châu	497	active
20326	Xã Hòa Tiến	497	active
20329	Xã Hòa Phước	497	active
20332	Xã Hòa Khương	497	active
20335	Phường Tân Thạnh	502	active
20338	Phường Phước Hòa	502	active
20341	Phường An Mỹ	502	active
20344	Phường Hòa Hương	502	active
20347	Phường An Xuân	502	active
20350	Phường An Sơn	502	active
20353	Phường Trường Xuân	502	active
20356	Phường An Phú	502	active
20359	Xã Tam Thanh	502	active
20362	Xã Tam Thăng	502	active
20371	Xã Tam Phú	502	active
20375	Phường Hoà Thuận	502	active
20389	Xã Tam Ngọc	502	active
20398	Phường Minh An	503	active
20401	Phường Tân An	503	active
20404	Phường Cẩm Phô	503	active
20407	Phường Thanh Hà	503	active
20410	Phường Sơn Phong	503	active
20413	Phường Cẩm Châu	503	active
20416	Phường Cửa Đại	503	active
20419	Phường Cẩm An	503	active
20422	Xã Cẩm Hà	503	active
20425	Xã Cẩm Kim	503	active
20428	Phường Cẩm Nam	503	active
20431	Xã Cẩm Thanh	503	active
20434	Xã Tân Hiệp	503	active
20437	Xã Ch'ơm	504	active
20440	Xã Ga Ri	504	active
20443	Xã A Xan	504	active
20446	Xã Tr'Hy	504	active
20449	Xã Lăng	504	active
20452	Xã A Nông	504	active
20455	Xã A Tiêng	504	active
20458	Xã Bha Lê	504	active
20461	Xã A Vương	504	active
20464	Xã Dang	504	active
20467	Thị trấn P Rao	505	active
20470	Xã Tà Lu	505	active
20473	Xã Sông Kôn	505	active
20476	Xã Jơ Ngây	505	active
20479	Xã A Ting	505	active
20482	Xã Tư	505	active
20485	Xã Ba	505	active
20488	Xã A Rooi	505	active
20491	Xã Za Hung	505	active
20494	Xã Mà Cooi	505	active
20497	Xã Ka Dăng	505	active
20500	Thị Trấn Ái Nghĩa	506	active
20503	Xã Đại Sơn	506	active
20506	Xã Đại Lãnh	506	active
20509	Xã Đại Hưng	506	active
20512	Xã Đại Hồng	506	active
20515	Xã Đại Đồng	506	active
20518	Xã Đại Quang	506	active
20521	Xã Đại Nghĩa	506	active
20524	Xã Đại Hiệp	506	active
20527	Xã Đại Thạnh	506	active
20530	Xã Đại Chánh	506	active
20533	Xã Đại Tân	506	active
20536	Xã Đại Phong	506	active
20539	Xã Đại Minh	506	active
20542	Xã Đại Thắng	506	active
20545	Xã Đại Cường	506	active
20547	Xã Đại An	506	active
20548	Xã Đại Hòa	506	active
20551	Phường Vĩnh Điện	507	active
20554	Xã Điện Tiến	507	active
20557	Xã Điện Hòa	507	active
20560	Xã Điện Thắng Bắc	507	active
20561	Xã Điện Thắng Trung	507	active
20562	Xã Điện Thắng Nam	507	active
20563	Phường Điện Ngọc	507	active
20566	Xã Điện Hồng	507	active
20569	Xã Điện Thọ	507	active
20572	Xã Điện Phước	507	active
20575	Phường Điện An	507	active
20578	Phường Điện Nam Bắc	507	active
20579	Phường Điện Nam Trung	507	active
20580	Phường Điện Nam Đông	507	active
20581	Phường Điện Dương	507	active
20584	Xã Điện Quang	507	active
20587	Xã Điện Trung	507	active
20590	Xã Điện Phong	507	active
20593	Xã Điện Minh	507	active
20596	Xã Điện Phương	507	active
20599	Thị trấn Nam Phước	508	active
20602	Xã Duy Thu	508	active
20605	Xã Duy Phú	508	active
20608	Xã Duy Tân	508	active
20611	Xã Duy Hòa	508	active
20614	Xã Duy Châu	508	active
20617	Xã Duy Trinh	508	active
20620	Xã Duy Sơn	508	active
20623	Xã Duy Trung	508	active
20626	Xã Duy Phước	508	active
20629	Xã Duy Thành	508	active
20632	Xã Duy Vinh	508	active
20635	Xã Duy Nghĩa	508	active
20638	Xã Duy Hải	508	active
20641	Thị trấn Đông Phú	509	active
20644	Xã Quế Xuân 1	509	active
20647	Xã Quế Xuân 2	509	active
20650	Xã Quế Phú	509	active
20651	Thị trấn Hương An	509	active
20659	Xã Quế Hiệp	509	active
20662	Xã Quế Thuận	509	active
20665	Xã Quế Mỹ	509	active
20677	Xã Quế Long	509	active
20680	Xã Quế Châu	509	active
20683	Xã Quế Phong	509	active
20686	Xã Quế An	509	active
20689	Xã Quế Minh	509	active
20695	Thị trấn Thạnh Mỹ	510	active
20698	Xã Laêê	510	active
20699	Xã Chơ Chun	510	active
20701	Xã Zuôich	510	active
20702	Xã Tà Pơơ	510	active
20704	Xã La Dêê	510	active
20705	Xã Đắc Tôi	510	active
20707	Xã Chà Vàl	510	active
20710	Xã Tà Bhinh	510	active
20713	Xã Cà Dy	510	active
20716	Xã Đắc Pre	510	active
20719	Xã Đắc Pring	510	active
20722	Thị trấn Khâm Đức	511	active
20725	Xã Phước Xuân	511	active
20728	Xã Phước Hiệp	511	active
20729	Xã Phước Hoà	511	active
20731	Xã Phước Đức	511	active
20734	Xã Phước Năng	511	active
20737	Xã Phước Mỹ	511	active
20740	Xã Phước Chánh	511	active
20743	Xã Phước Công	511	active
20746	Xã Phước Kim	511	active
20749	Xã Phước Lộc	511	active
20752	Xã Phước Thành	511	active
20758	Xã Hiệp Hòa	512	active
20761	Xã Hiệp Thuận	512	active
20764	Xã Quế Thọ	512	active
20767	Xã Bình Lâm	512	active
20770	Xã Sông Trà	512	active
20773	Xã Phước Trà	512	active
20776	Xã Phước Gia	512	active
20779	Thị trấn Tân Bình	512	active
20782	Xã Quế Lưu	512	active
20785	Xã Thăng Phước	512	active
20788	Xã Bình Sơn	512	active
20791	Thị trấn Hà Lam	513	active
20794	Xã Bình Dương	513	active
20797	Xã Bình Giang	513	active
20800	Xã Bình Nguyên	513	active
20803	Xã Bình Phục	513	active
20806	Xã Bình Triều	513	active
20809	Xã Bình Đào	513	active
20812	Xã Bình Minh	513	active
20815	Xã Bình Lãnh	513	active
20818	Xã Bình Trị	513	active
20821	Xã Bình Định Bắc	513	active
20822	Xã Bình Định Nam	513	active
20824	Xã Bình Quý	513	active
20827	Xã Bình Phú	513	active
20830	Xã Bình Chánh	513	active
20833	Xã Bình Tú	513	active
20836	Xã Bình Sa	513	active
20839	Xã Bình Hải	513	active
20842	Xã Bình Quế	513	active
20845	Xã Bình An	513	active
20848	Xã Bình Trung	513	active
20851	Xã Bình Nam	513	active
20854	Thị trấn Tiên Kỳ	514	active
20857	Xã Tiên Sơn	514	active
20860	Xã Tiên Hà	514	active
20863	Xã Tiên Cẩm	514	active
20866	Xã Tiên Châu	514	active
20869	Xã Tiên Lãnh	514	active
20872	Xã Tiên Ngọc	514	active
20875	Xã Tiên Hiệp	514	active
20878	Xã Tiên Cảnh	514	active
20881	Xã Tiên Mỹ	514	active
20884	Xã Tiên Phong	514	active
20887	Xã Tiên Thọ	514	active
20890	Xã Tiên An	514	active
20893	Xã Tiên Lộc	514	active
20896	Xã Tiên Lập	514	active
20899	Thị trấn Trà My	515	active
20900	Xã Trà Sơn	515	active
20902	Xã Trà Kót	515	active
20905	Xã Trà Nú	515	active
20908	Xã Trà Đông	515	active
20911	Xã Trà Dương	515	active
20914	Xã Trà Giang	515	active
20917	Xã Trà Bui	515	active
20920	Xã Trà Đốc	515	active
20923	Xã Trà Tân	515	active
20926	Xã Trà Giác	515	active
20929	Xã Trà Giáp	515	active
20932	Xã Trà Ka	515	active
20935	Xã Trà Leng	516	active
20938	Xã Trà Dơn	516	active
20941	Xã Trà Tập	516	active
20944	Xã Trà Mai	516	active
20947	Xã Trà Cang	516	active
20950	Xã Trà Linh	516	active
20953	Xã Trà Nam	516	active
20956	Xã Trà Don	516	active
20959	Xã Trà Vân	516	active
20962	Xã Trà Vinh	516	active
20965	Thị trấn Núi Thành	517	active
20968	Xã Tam Xuân I	517	active
20971	Xã Tam Xuân II	517	active
20974	Xã Tam Tiến	517	active
20977	Xã Tam Sơn	517	active
20980	Xã Tam Thạnh	517	active
20983	Xã Tam Anh Bắc	517	active
20984	Xã Tam Anh Nam	517	active
20986	Xã Tam Hòa	517	active
20989	Xã Tam Hiệp	517	active
20992	Xã Tam Hải	517	active
20995	Xã Tam Giang	517	active
20998	Xã Tam Quang	517	active
21001	Xã Tam Nghĩa	517	active
21004	Xã Tam Mỹ Tây	517	active
21005	Xã Tam Mỹ Đông	517	active
21007	Xã Tam Trà	517	active
20364	Thị trấn Phú Thịnh	518	active
20365	Xã Tam Thành	518	active
20368	Xã Tam An	518	active
20374	Xã Tam Đàn	518	active
20377	Xã Tam Lộc	518	active
20380	Xã Tam Phước	518	active
20383	Xã Tam Vinh	518	active
20386	Xã Tam Thái	518	active
20387	Xã Tam Đại	518	active
20392	Xã Tam Dân	518	active
20395	Xã Tam Lãnh	518	active
20656	Xã Quế Trung	519	active
20668	Xã Ninh Phước	519	active
20669	Xã Phước Ninh	519	active
20671	Xã Quế Lộc	519	active
20672	Xã Sơn Viên	519	active
20692	Xã Quế Lâm	519	active
21010	Phường Lê Hồng Phong	522	active
21013	Phường Trần Phú	522	active
21016	Phường Quảng Phú	522	active
21019	Phường Nghĩa Chánh	522	active
21022	Phường Trần Hưng Đạo	522	active
21025	Phường Nguyễn Nghiêm	522	active
21028	Phường Nghĩa Lộ	522	active
21031	Phường Chánh Lộ	522	active
21034	Xã Nghĩa Dũng	522	active
21037	Xã Nghĩa Dõng	522	active
21172	Phường Trương Quang Trọng	522	active
21187	Xã Tịnh Hòa	522	active
21190	Xã Tịnh Kỳ	522	active
21199	Xã Tịnh Thiện	522	active
21202	Xã Tịnh Ấn Đông	522	active
21208	Xã Tịnh Châu	522	active
21211	Xã Tịnh Khê	522	active
21214	Xã Tịnh Long	522	active
21223	Xã Tịnh Ấn Tây	522	active
21232	Xã Tịnh An	522	active
21253	Xã Nghĩa Phú	522	active
21256	Xã Nghĩa Hà	522	active
21262	Xã Nghĩa An	522	active
21040	Thị Trấn Châu Ổ	524	active
21043	Xã Bình Thuận	524	active
21046	Xã Bình Thạnh	524	active
21049	Xã Bình Đông	524	active
21052	Xã Bình Chánh	524	active
21055	Xã Bình Nguyên	524	active
21058	Xã Bình Khương	524	active
21061	Xã Bình Trị	524	active
21064	Xã Bình An	524	active
21067	Xã Bình Hải	524	active
21070	Xã Bình Dương	524	active
21073	Xã Bình Phước	524	active
21079	Xã Bình Hòa	524	active
21082	Xã Bình Trung	524	active
21085	Xã Bình Minh	524	active
21088	Xã Bình Long	524	active
21091	Xã Bình Thanh	524	active
21100	Xã Bình Chương	524	active
21103	Xã Bình Hiệp	524	active
21106	Xã Bình Mỹ	524	active
21109	Xã Bình Tân Phú	524	active
21112	Xã Bình Châu	524	active
21115	Thị trấn Trà Xuân	525	active
21118	Xã Trà Giang	525	active
21121	Xã Trà Thủy	525	active
21124	Xã Trà Hiệp	525	active
21127	Xã Trà Bình	525	active
21130	Xã Trà Phú	525	active
21133	Xã Trà Lâm	525	active
21136	Xã Trà Tân	525	active
21139	Xã Trà Sơn	525	active
21142	Xã Trà Bùi	525	active
21145	Xã Trà Thanh	525	active
21148	Xã Sơn Trà	525	active
21154	Xã Trà Phong	525	active
21157	Xã Hương Trà	525	active
21163	Xã Trà Xinh	525	active
21166	Xã Trà Tây	525	active
21175	Xã Tịnh Thọ	527	active
21178	Xã Tịnh Trà	527	active
21181	Xã Tịnh Phong	527	active
21184	Xã Tịnh Hiệp	527	active
21193	Xã Tịnh Bình	527	active
21196	Xã Tịnh Đông	527	active
21205	Xã Tịnh Bắc	527	active
21217	Xã Tịnh Sơn	527	active
21220	Xã Tịnh Hà	527	active
21226	Xã Tịnh Giang	527	active
21229	Xã Tịnh Minh	527	active
21235	Thị trấn La Hà	528	active
21238	Thị trấn Sông Vệ	528	active
21241	Xã Nghĩa Lâm	528	active
21244	Xã Nghĩa Thắng	528	active
21247	Xã Nghĩa Thuận	528	active
21250	Xã Nghĩa Kỳ	528	active
21259	Xã Nghĩa Sơn	528	active
21268	Xã Nghĩa Hòa	528	active
21271	Xã Nghĩa Điền	528	active
21274	Xã Nghĩa Thương	528	active
21277	Xã Nghĩa Trung	528	active
21280	Xã Nghĩa Hiệp	528	active
21283	Xã Nghĩa Phương	528	active
21286	Xã Nghĩa Mỹ	528	active
21289	Thị trấn Di Lăng	529	active
21292	Xã Sơn Hạ	529	active
21295	Xã Sơn Thành	529	active
21298	Xã Sơn Nham	529	active
21301	Xã Sơn Bao	529	active
21304	Xã Sơn Linh	529	active
21307	Xã Sơn Giang	529	active
21310	Xã Sơn Trung	529	active
21313	Xã Sơn Thượng	529	active
21316	Xã Sơn Cao	529	active
21319	Xã Sơn Hải	529	active
21322	Xã Sơn Thủy	529	active
21325	Xã Sơn Kỳ	529	active
21328	Xã Sơn Ba	529	active
21331	Xã Sơn Bua	530	active
21334	Xã Sơn Mùa	530	active
21335	Xã Sơn Liên	530	active
21337	Xã Sơn Tân	530	active
21338	Xã Sơn Màu	530	active
21340	Xã Sơn Dung	530	active
21341	Xã Sơn Long	530	active
21343	Xã Sơn Tinh	530	active
21346	Xã Sơn Lập	530	active
21349	Xã Long Sơn	531	active
21352	Xã Long Mai	531	active
21355	Xã Thanh An	531	active
21358	Xã Long Môn	531	active
21361	Xã Long Hiệp	531	active
21364	Thị trấn Chợ Chùa	532	active
21367	Xã Hành Thuận	532	active
21370	Xã Hành Dũng	532	active
21373	Xã Hành Trung	532	active
21376	Xã Hành Nhân	532	active
21379	Xã Hành Đức	532	active
21382	Xã Hành Minh	532	active
21385	Xã Hành Phước	532	active
21388	Xã Hành Thiện	532	active
21391	Xã Hành Thịnh	532	active
21394	Xã Hành Tín Tây	532	active
21397	Xã Hành Tín Đông	532	active
21400	Thị trấn Mộ Đức	533	active
21403	Xã Đức Lợi	533	active
21406	Xã Đức Thắng	533	active
21409	Xã Đức Nhuận	533	active
21412	Xã Đức Chánh	533	active
21415	Xã Đức Hiệp	533	active
21418	Xã Đức Minh	533	active
21421	Xã Đức Thạnh	533	active
21424	Xã Đức Hòa	533	active
21427	Xã Đức Tân	533	active
21430	Xã Đức Phú	533	active
21433	Xã Đức Phong	533	active
21436	Xã Đức Lân	533	active
21439	Phường Nguyễn Nghiêm	534	active
21442	Xã Phổ An	534	active
21445	Xã Phổ Phong	534	active
21448	Xã Phổ Thuận	534	active
21451	Phường Phổ Văn	534	active
21454	Phường Phổ Quang	534	active
21457	Xã Phổ Nhơn	534	active
21460	Phường Phổ Ninh	534	active
21463	Phường Phổ Minh	534	active
21466	Phường Phổ Vinh	534	active
21469	Phường Phổ Hòa	534	active
21472	Xã Phổ Cường	534	active
21475	Xã Phổ Khánh	534	active
21478	Phường Phổ Thạnh	534	active
21481	Xã Phổ Châu	534	active
21484	Thị trấn Ba Tơ	535	active
21487	Xã Ba Điền	535	active
21490	Xã Ba Vinh	535	active
21493	Xã Ba Thành	535	active
21496	Xã Ba Động	535	active
21499	Xã Ba Dinh	535	active
21500	Xã Ba Giang	535	active
21502	Xã Ba Liên	535	active
21505	Xã Ba Ngạc	535	active
21508	Xã Ba Khâm	535	active
21511	Xã Ba Cung	535	active
21517	Xã Ba Tiêu	535	active
21520	Xã Ba Trang	535	active
21523	Xã Ba Tô	535	active
21526	Xã Ba Bích	535	active
21529	Xã Ba Vì	535	active
21532	Xã Ba Lế	535	active
21535	Xã Ba Nam	535	active
21538	Xã Ba Xa	535	active
21550	Phường Nhơn Bình	540	active
21553	Phường Nhơn Phú	540	active
21556	Phường Đống Đa	540	active
21559	Phường Trần Quang Diệu	540	active
21562	Phường Hải Cảng	540	active
21565	Phường Quang Trung	540	active
21568	Phường Thị Nại	540	active
21571	Phường Lê Hồng Phong	540	active
21574	Phường Trần Hưng Đạo	540	active
21577	Phường Ngô Mây	540	active
21580	Phường Lý Thường Kiệt	540	active
21583	Phường Lê Lợi	540	active
21586	Phường Trần Phú	540	active
21589	Phường Bùi Thị Xuân	540	active
21592	Phường Nguyễn Văn Cừ	540	active
21595	Phường Ghềnh Ráng	540	active
21598	Xã Nhơn Lý	540	active
21601	Xã Nhơn Hội	540	active
21604	Xã Nhơn Hải	540	active
21607	Xã Nhơn Châu	540	active
21991	Xã Phước Mỹ	540	active
21609	Thị trấn An Lão	542	active
21610	Xã An Hưng	542	active
21613	Xã An Trung	542	active
21616	Xã An Dũng	542	active
21619	Xã An Vinh	542	active
21622	Xã An Toàn	542	active
21625	Xã An Tân	542	active
21628	Xã An Hòa	542	active
21631	Xã An Quang	542	active
21634	Xã An Nghĩa	542	active
21637	Phường Tam Quan	543	active
21640	Phường Bồng Sơn	543	active
21643	Xã Hoài Sơn	543	active
21646	Xã Hoài Châu Bắc	543	active
21649	Xã Hoài Châu	543	active
21652	Xã Hoài Phú	543	active
21655	Phường Tam Quan Bắc	543	active
21658	Phường Tam Quan Nam	543	active
21661	Phường Hoài Hảo	543	active
21664	Phường Hoài Thanh Tây	543	active
21667	Phường Hoài Thanh	543	active
21670	Phường Hoài Hương	543	active
21673	Phường Hoài Tân	543	active
21676	Xã Hoài Hải	543	active
21679	Phường Hoài Xuân	543	active
21682	Xã Hoài Mỹ	543	active
21685	Phường Hoài Đức	543	active
21688	Thị trấn Tăng Bạt Hổ	544	active
21690	Xã Ân Hảo Tây	544	active
21691	Xã Ân Hảo Đông	544	active
21694	Xã Ân Sơn	544	active
21697	Xã Ân Mỹ	544	active
21700	Xã Đak Mang	544	active
21703	Xã Ân Tín	544	active
21706	Xã Ân Thạnh	544	active
21709	Xã Ân Phong	544	active
21712	Xã Ân Đức	544	active
21715	Xã Ân Hữu	544	active
21718	Xã Bok Tới	544	active
21721	Xã Ân Tường Tây	544	active
21724	Xã Ân Tường Đông	544	active
21727	Xã Ân Nghĩa	544	active
21730	Thị trấn Phù Mỹ	545	active
21733	Thị trấn Bình Dương	545	active
21736	Xã Mỹ Đức	545	active
21739	Xã Mỹ Châu	545	active
21742	Xã Mỹ Thắng	545	active
21745	Xã Mỹ Lộc	545	active
21748	Xã Mỹ Lợi	545	active
21751	Xã Mỹ An	545	active
21754	Xã Mỹ Phong	545	active
21757	Xã Mỹ Trinh	545	active
21760	Xã Mỹ Thọ	545	active
21763	Xã Mỹ Hòa	545	active
21766	Xã Mỹ Thành	545	active
21769	Xã Mỹ Chánh	545	active
21772	Xã Mỹ Quang	545	active
21775	Xã Mỹ Hiệp	545	active
21778	Xã Mỹ Tài	545	active
21781	Xã Mỹ Cát	545	active
21784	Xã Mỹ Chánh Tây	545	active
21786	Thị trấn Vĩnh Thạnh	546	active
21787	Xã Vĩnh Sơn	546	active
21790	Xã Vĩnh Kim	546	active
21796	Xã Vĩnh Hiệp	546	active
21799	Xã Vĩnh Hảo	546	active
21801	Xã Vĩnh Hòa	546	active
21802	Xã Vĩnh Thịnh	546	active
21804	Xã Vĩnh Thuận	546	active
21805	Xã Vĩnh Quang	546	active
21808	Thị trấn Phú Phong	547	active
21811	Xã Bình Tân	547	active
21814	Xã Tây Thuận	547	active
21817	Xã Bình Thuận	547	active
21820	Xã Tây Giang	547	active
21823	Xã Bình Thành	547	active
21826	Xã Tây An	547	active
21829	Xã Bình Hòa	547	active
21832	Xã Tây Bình	547	active
21835	Xã Bình Tường	547	active
21838	Xã Tây Vinh	547	active
21841	Xã Vĩnh An	547	active
21844	Xã Tây Xuân	547	active
21847	Xã Bình Nghi	547	active
21850	Xã Tây Phú	547	active
21853	Thị trấn Ngô Mây	548	active
21856	Xã Cát Sơn	548	active
21859	Xã Cát Minh	548	active
21862	Xã Cát Khánh	548	active
21865	Xã Cát Tài	548	active
21868	Xã Cát Lâm	548	active
21871	Xã Cát Hanh	548	active
21874	Xã Cát Thành	548	active
21877	Xã Cát Trinh	548	active
21880	Xã Cát Hải	548	active
21883	Xã Cát Hiệp	548	active
21886	Xã Cát Nhơn	548	active
21889	Xã Cát Hưng	548	active
21892	Xã Cát Tường	548	active
21895	Xã Cát Tân	548	active
21898	Thị trấn Cát Tiến	548	active
21901	Xã Cát Thắng	548	active
21904	Xã Cát Chánh	548	active
21907	Phường Bình Định	549	active
21910	Phường Đập Đá	549	active
21913	Xã Nhơn Mỹ	549	active
21916	Phường Nhơn Thành	549	active
21919	Xã Nhơn Hạnh	549	active
21922	Xã Nhơn Hậu	549	active
21925	Xã Nhơn Phong	549	active
21928	Xã Nhơn An	549	active
21931	Xã Nhơn Phúc	549	active
21934	Phường Nhơn Hưng	549	active
21937	Xã Nhơn Khánh	549	active
21940	Xã Nhơn Lộc	549	active
21943	Phường Nhơn Hoà	549	active
21946	Xã Nhơn Tân	549	active
21949	Xã Nhơn Thọ	549	active
21952	Thị trấn Tuy Phước	550	active
21955	Thị trấn Diêu Trì	550	active
21958	Xã Phước Thắng	550	active
21961	Xã Phước Hưng	550	active
21964	Xã Phước Quang	550	active
21967	Xã Phước Hòa	550	active
21970	Xã Phước Sơn	550	active
21973	Xã Phước Hiệp	550	active
21976	Xã Phước Lộc	550	active
21979	Xã Phước Nghĩa	550	active
21982	Xã Phước Thuận	550	active
21985	Xã Phước An	550	active
21988	Xã Phước Thành	550	active
21994	Thị trấn Vân Canh	551	active
21997	Xã Canh Liên	551	active
22000	Xã Canh Hiệp	551	active
22003	Xã Canh Vinh	551	active
22006	Xã Canh Hiển	551	active
22009	Xã Canh Thuận	551	active
22012	Xã Canh Hòa	551	active
22015	Phường 1	555	active
22018	Phường 8	555	active
22021	Phường 2	555	active
22024	Phường 9	555	active
22027	Phường 3	555	active
22030	Phường 4	555	active
22033	Phường 5	555	active
22036	Phường 7	555	active
22039	Phường 6	555	active
22040	Phường Phú Thạnh	555	active
22041	Phường Phú Đông	555	active
22042	Xã Hòa Kiến	555	active
22045	Xã Bình Kiến	555	active
22048	Xã Bình Ngọc	555	active
22162	Xã An Phú	555	active
22240	Phường Phú Lâm	555	active
22051	Phường Xuân Phú	557	active
22052	Xã Xuân Lâm	557	active
22053	Phường Xuân Thành	557	active
22054	Xã Xuân Hải	557	active
22057	Xã Xuân Lộc	557	active
22060	Xã Xuân Bình	557	active
22066	Xã Xuân Cảnh	557	active
22069	Xã Xuân Thịnh	557	active
22072	Xã Xuân Phương	557	active
22073	Phường Xuân Yên	557	active
22075	Xã Xuân Thọ 1	557	active
22076	Phường Xuân Đài	557	active
22078	Xã Xuân Thọ 2	557	active
22081	Thị trấn La Hai	558	active
22084	Xã Đa Lộc	558	active
22087	Xã Phú Mỡ	558	active
22090	Xã Xuân Lãnh	558	active
22093	Xã Xuân Long	558	active
22096	Xã Xuân Quang 1	558	active
22099	Xã Xuân Sơn Bắc	558	active
22102	Xã Xuân Quang 2	558	active
22105	Xã Xuân Sơn Nam	558	active
22108	Xã Xuân Quang 3	558	active
22111	Xã Xuân Phước	558	active
22114	Thị trấn Chí Thạnh	559	active
22117	Xã An Dân	559	active
22120	Xã An Ninh Tây	559	active
22123	Xã An Ninh Đông	559	active
22126	Xã An Thạch	559	active
22129	Xã An Định	559	active
22132	Xã An Nghiệp	559	active
22138	Xã An Cư	559	active
22141	Xã An Xuân	559	active
22144	Xã An Lĩnh	559	active
22147	Xã An Hòa Hải	559	active
22150	Xã An Hiệp	559	active
22153	Xã An Mỹ	559	active
22156	Xã An Chấn	559	active
22159	Xã An Thọ	559	active
22165	Thị trấn Củng Sơn	560	active
22168	Xã Phước Tân	560	active
22171	Xã Sơn Hội	560	active
22174	Xã Sơn Định	560	active
22177	Xã Sơn Long	560	active
22180	Xã Cà Lúi	560	active
22183	Xã Sơn Phước	560	active
22186	Xã Sơn Xuân	560	active
22189	Xã Sơn Nguyên	560	active
22192	Xã Eachà Rang	560	active
22195	Xã Krông Pa	560	active
22198	Xã Suối Bạc	560	active
22201	Xã Sơn Hà	560	active
22204	Xã Suối Trai	560	active
22207	Thị trấn Hai Riêng	561	active
22210	Xã Ea Lâm	561	active
22213	Xã Đức Bình Tây	561	active
22216	Xã Ea Bá	561	active
22219	Xã Sơn Giang	561	active
22222	Xã Đức Bình Đông	561	active
22225	Xã EaBar	561	active
22228	Xã EaBia	561	active
22231	Xã EaTrol	561	active
22234	Xã Sông Hinh	561	active
22237	Xã Ealy	561	active
22249	Xã Sơn Thành Tây	562	active
22250	Xã Sơn Thành Đông	562	active
22252	Xã Hòa Bình 1	562	active
22255	Thị trấn Phú Thứ	562	active
22264	Xã Hòa Phong	562	active
22270	Xã Hòa Phú	562	active
22273	Xã Hòa Tân Tây	562	active
22276	Xã Hòa Đồng	562	active
22285	Xã Hòa Mỹ Đông	562	active
22288	Xã Hòa Mỹ Tây	562	active
22294	Xã Hòa Thịnh	562	active
22303	Xã Hòa Quang Bắc	563	active
22306	Xã Hòa Quang Nam	563	active
22309	Xã Hòa Hội	563	active
22312	Xã Hòa Trị	563	active
22315	Xã Hòa An	563	active
22318	Xã Hòa Định Đông	563	active
22319	Thị Trấn Phú Hoà	563	active
22321	Xã Hòa Định Tây	563	active
22324	Xã Hòa Thắng	563	active
22243	Xã Hòa Thành	564	active
22246	Phường Hòa Hiệp Bắc	564	active
22258	Phường Hoà Vinh	564	active
22261	Phường Hoà Hiệp Trung	564	active
22267	Xã Hòa Tân Đông	564	active
22279	Phường Hòa Xuân Tây	564	active
22282	Phường Hòa Hiệp Nam	564	active
22291	Xã Hòa Xuân Đông	564	active
22297	Xã Hòa Tâm	564	active
22300	Xã Hòa Xuân Nam	564	active
22327	Phường Vĩnh Hòa	568	active
22330	Phường Vĩnh Hải	568	active
22333	Phường Vĩnh Phước	568	active
22336	Phường Ngọc Hiệp	568	active
22339	Phường Vĩnh Thọ	568	active
22342	Phường Xương Huân	568	active
22345	Phường Vạn Thắng	568	active
22348	Phường Vạn Thạnh	568	active
22351	Phường Phương Sài	568	active
22354	Phường Phương Sơn	568	active
22357	Phường Phước Hải	568	active
22360	Phường Phước Tân	568	active
22363	Phường Lộc Thọ	568	active
22366	Phường Phước Tiến	568	active
22369	Phường Tân Lập	568	active
22372	Phường Phước Hòa	568	active
22375	Phường Vĩnh Nguyên	568	active
22378	Phường Phước Long	568	active
22381	Phường Vĩnh Trường	568	active
22384	Xã Vĩnh Lương	568	active
22387	Xã Vĩnh Phương	568	active
22390	Xã Vĩnh Ngọc	568	active
22393	Xã Vĩnh Thạnh	568	active
22396	Xã Vĩnh Trung	568	active
22399	Xã Vĩnh Hiệp	568	active
22402	Xã Vĩnh Thái	568	active
22405	Xã Phước Đồng	568	active
22408	Phường Cam Nghĩa	569	active
22411	Phường Cam Phúc Bắc	569	active
22414	Phường Cam Phúc Nam	569	active
22417	Phường Cam Lộc	569	active
22420	Phường Cam Phú	569	active
22423	Phường Ba Ngòi	569	active
22426	Phường Cam Thuận	569	active
22429	Phường Cam Lợi	569	active
22432	Phường Cam Linh	569	active
22468	Xã Cam Thành Nam	569	active
22474	Xã Cam Phước Đông	569	active
22477	Xã Cam Thịnh Tây	569	active
22480	Xã Cam Thịnh Đông	569	active
22483	Xã Cam Lập	569	active
22486	Xã Cam Bình	569	active
22435	Xã Cam Tân	570	active
22438	Xã Cam Hòa	570	active
22441	Xã Cam Hải Đông	570	active
22444	Xã Cam Hải Tây	570	active
22447	Xã Sơn Tân	570	active
22450	Xã Cam Hiệp Bắc	570	active
22453	Thị trấn Cam Đức	570	active
22456	Xã Cam Hiệp Nam	570	active
22459	Xã Cam Phước Tây	570	active
22462	Xã Cam Thành Bắc	570	active
22465	Xã Cam An Bắc	570	active
22471	Xã Cam An Nam	570	active
22708	Xã Suối Cát	570	active
22711	Xã Suối Tân	570	active
22489	Thị trấn Vạn Giã	571	active
22492	Xã Đại Lãnh	571	active
22495	Xã Vạn Phước	571	active
22498	Xã Vạn Long	571	active
22501	Xã Vạn Bình	571	active
22504	Xã Vạn Thọ	571	active
22507	Xã Vạn Khánh	571	active
22510	Xã Vạn Phú	571	active
22513	Xã Vạn Lương	571	active
22516	Xã Vạn Thắng	571	active
22519	Xã Vạn Thạnh	571	active
22522	Xã Xuân Sơn	571	active
22525	Xã Vạn Hưng	571	active
22528	Phường Ninh Hiệp	572	active
22531	Xã Ninh Sơn	572	active
22534	Xã Ninh Tây	572	active
22537	Xã Ninh Thượng	572	active
22540	Xã Ninh An	572	active
22543	Phường Ninh Hải	572	active
22546	Xã Ninh Thọ	572	active
22549	Xã Ninh Trung	572	active
22552	Xã Ninh Sim	572	active
22555	Xã Ninh Xuân	572	active
22558	Xã Ninh Thân	572	active
22561	Phường Ninh Diêm	572	active
22564	Xã Ninh Đông	572	active
22567	Phường Ninh Thủy	572	active
22570	Phường Ninh Đa	572	active
22573	Xã Ninh Phụng	572	active
22576	Xã Ninh Bình	572	active
22579	Xã Ninh Phước	572	active
22582	Xã Ninh Phú	572	active
22585	Xã Ninh Tân	572	active
22588	Xã Ninh Quang	572	active
22591	Phường Ninh Giang	572	active
22594	Phường Ninh Hà	572	active
22597	Xã Ninh Hưng	572	active
22600	Xã Ninh Lộc	572	active
22603	Xã Ninh Ích	572	active
22606	Xã Ninh Vân	572	active
22609	Thị trấn Khánh Vĩnh	573	active
22612	Xã Khánh Hiệp	573	active
22615	Xã Khánh Bình	573	active
22618	Xã Khánh Trung	573	active
22621	Xã Khánh Đông	573	active
22624	Xã Khánh Thượng	573	active
22627	Xã Khánh Nam	573	active
22630	Xã Sông Cầu	573	active
22633	Xã Giang Ly	573	active
22636	Xã Cầu Bà	573	active
22639	Xã Liên Sang	573	active
22642	Xã Khánh Thành	573	active
22645	Xã Khánh Phú	573	active
22648	Xã Sơn Thái	573	active
22651	Thị trấn Diên Khánh	574	active
22654	Xã Diên Lâm	574	active
22657	Xã Diên Điền	574	active
22660	Xã Diên Xuân	574	active
22663	Xã Diên Sơn	574	active
22666	Xã Diên Đồng	574	active
22669	Xã Diên Phú	574	active
22672	Xã Diên Thọ	574	active
22675	Xã Diên Phước	574	active
22678	Xã Diên Lạc	574	active
22681	Xã Diên Tân	574	active
22684	Xã Diên Hòa	574	active
22687	Xã Diên Thạnh	574	active
22690	Xã Diên Toàn	574	active
22693	Xã Diên An	574	active
22696	Xã Bình Lộc	574	active
22702	Xã Suối Hiệp	574	active
22705	Xã Suối Tiên	574	active
22714	Thị trấn Tô Hạp	575	active
22717	Xã Thành Sơn	575	active
22720	Xã Sơn Lâm	575	active
22723	Xã Sơn Hiệp	575	active
22726	Xã Sơn Bình	575	active
22729	Xã Sơn Trung	575	active
22732	Xã Ba Cụm Bắc	575	active
22735	Xã Ba Cụm Nam	575	active
22736	Thị trấn Trường Sa	576	active
22737	Xã Song Tử Tây	576	active
22739	Xã Sinh Tồn	576	active
22738	Phường Đô Vinh	582	active
22741	Phường Phước Mỹ	582	active
22744	Phường Bảo An	582	active
22747	Phường Phủ Hà	582	active
22750	Phường Thanh Sơn	582	active
22753	Phường Mỹ Hương	582	active
22756	Phường Tấn Tài	582	active
22759	Phường Kinh Dinh	582	active
22762	Phường Đạo Long	582	active
22765	Phường Đài Sơn	582	active
22768	Phường Đông Hải	582	active
22771	Phường Mỹ Đông	582	active
22774	Xã Thành Hải	582	active
22777	Phường Văn Hải	582	active
22779	Phường Mỹ Bình	582	active
22780	Phường Mỹ Hải	582	active
22783	Xã Phước Bình	584	active
22786	Xã Phước Hòa	584	active
22789	Xã Phước Tân	584	active
22792	Xã Phước Tiến	584	active
22795	Xã Phước Thắng	584	active
22798	Xã Phước Thành	584	active
22801	Xã Phước Đại	584	active
22804	Xã Phước Chính	584	active
22807	Xã Phước Trung	584	active
22810	Thị trấn Tân Sơn	585	active
22813	Xã Lâm Sơn	585	active
22816	Xã Lương Sơn	585	active
22819	Xã Quảng Sơn	585	active
22822	Xã Mỹ Sơn	585	active
22825	Xã Hòa Sơn	585	active
22828	Xã Ma Nới	585	active
22831	Xã Nhơn Sơn	585	active
22834	Thị trấn Khánh Hải	586	active
22846	Xã Vĩnh Hải	586	active
22852	Xã Phương Hải	586	active
22855	Xã Tân Hải	586	active
22858	Xã Xuân Hải	586	active
22861	Xã Hộ Hải	586	active
22864	Xã Tri Hải	586	active
22867	Xã Nhơn Hải	586	active
22868	Xã Thanh Hải	586	active
22870	Thị trấn Phước Dân	587	active
22873	Xã Phước Sơn	587	active
22876	Xã Phước Thái	587	active
22879	Xã Phước Hậu	587	active
22882	Xã Phước Thuận	587	active
22888	Xã An Hải	587	active
22891	Xã Phước Hữu	587	active
22894	Xã Phước Hải	587	active
22912	Xã Phước Vinh	587	active
22837	Xã Phước Chiến	588	active
22840	Xã Công Hải	588	active
22843	Xã Phước Kháng	588	active
22849	Xã Lợi Hải	588	active
22853	Xã Bắc Sơn	588	active
22856	Xã Bắc Phong	588	active
22885	Xã Phước Hà	589	active
22897	Xã Phước Nam	589	active
22898	Xã Phước Ninh	589	active
22900	Xã Nhị Hà	589	active
22903	Xã Phước Dinh	589	active
22906	Xã Phước Minh	589	active
22909	Xã Phước Diêm	589	active
22910	Xã Cà Ná	589	active
22915	Phường Mũi Né	593	active
22918	Phường Hàm Tiến	593	active
22921	Phường Phú Hài	593	active
22924	Phường Phú Thủy	593	active
22927	Phường Phú Tài	593	active
22930	Phường Phú Trinh	593	active
22933	Phường Xuân An	593	active
22936	Phường Thanh Hải	593	active
22939	Phường Bình Hưng	593	active
22942	Phường Đức Nghĩa	593	active
22945	Phường Lạc Đạo	593	active
22948	Phường Đức Thắng	593	active
22951	Phường Hưng Long	593	active
22954	Phường Đức Long	593	active
22957	Xã Thiện Nghiệp	593	active
22960	Xã Phong Nẫm	593	active
22963	Xã Tiến Lợi	593	active
22966	Xã Tiến Thành	593	active
23231	Phường Phước Hội	594	active
23232	Phường Phước Lộc	594	active
23234	Phường Tân Thiện	594	active
23235	Phường Tân An	594	active
23237	Phường Bình Tân	594	active
23245	Xã Tân Hải	594	active
23246	Xã Tân Tiến	594	active
23248	Xã Tân Bình	594	active
23268	Xã Tân Phước	594	active
22969	Thị trấn Liên Hương	595	active
22972	Thị trấn Phan Rí Cửa	595	active
22975	Xã Phan Dũng	595	active
22978	Xã Phong Phú	595	active
22981	Xã Vĩnh Hảo	595	active
22984	Xã Vĩnh Tân	595	active
22987	Xã Phú Lạc	595	active
22990	Xã Phước Thể	595	active
22993	Xã Hòa Minh	595	active
22996	Xã Chí Công	595	active
22999	Xã Bình Thạnh	595	active
23005	Thị trấn Chợ Lầu	596	active
23008	Xã Phan Sơn	596	active
23011	Xã Phan Lâm	596	active
23014	Xã Bình An	596	active
23017	Xã Phan Điền	596	active
23020	Xã Hải Ninh	596	active
23023	Xã Sông Lũy	596	active
23026	Xã Phan Tiến	596	active
23029	Xã Sông Bình	596	active
23032	Thị trấn Lương Sơn	596	active
23035	Xã Phan Hòa	596	active
23038	Xã Phan Thanh	596	active
23041	Xã Hồng Thái	596	active
23044	Xã Phan Hiệp	596	active
23047	Xã Bình Tân	596	active
23050	Xã Phan Rí Thành	596	active
23053	Xã Hòa Thắng	596	active
23056	Xã Hồng Phong	596	active
23059	Thị trấn Ma Lâm	597	active
23062	Thị trấn Phú Long	597	active
23065	Xã La Dạ	597	active
23068	Xã Đông Tiến	597	active
23071	Xã Thuận Hòa	597	active
23074	Xã Đông Giang	597	active
23077	Xã Hàm Phú	597	active
23080	Xã Hồng Liêm	597	active
23083	Xã Thuận Minh	597	active
23086	Xã Hồng Sơn	597	active
23089	Xã Hàm Trí	597	active
23092	Xã Hàm Đức	597	active
23095	Xã Hàm Liêm	597	active
23098	Xã Hàm Chính	597	active
23101	Xã Hàm Hiệp	597	active
23104	Xã Hàm Thắng	597	active
23107	Xã Đa Mi	597	active
23110	Thị trấn Thuận Nam	598	active
23113	Xã Mỹ Thạnh	598	active
23116	Xã Hàm Cần	598	active
23119	Xã Mương Mán	598	active
23122	Xã Hàm Thạnh	598	active
23125	Xã Hàm Kiệm	598	active
23128	Xã Hàm Cường	598	active
23131	Xã Hàm Mỹ	598	active
23134	Xã Tân Lập	598	active
23137	Xã Hàm Minh	598	active
23140	Xã Thuận Quí	598	active
23143	Xã Tân Thuận	598	active
23146	Xã Tân Thành	598	active
23149	Thị trấn Lạc Tánh	599	active
23152	Xã Bắc Ruộng	599	active
23158	Xã Nghị Đức	599	active
23161	Xã La Ngâu	599	active
23164	Xã Huy Khiêm	599	active
23167	Xã Măng Tố	599	active
23170	Xã Đức Phú	599	active
23173	Xã Đồng Kho	599	active
23176	Xã Gia An	599	active
23179	Xã Đức Bình	599	active
23182	Xã Gia Huynh	599	active
23185	Xã Đức Thuận	599	active
23188	Xã Suối Kiết	599	active
23191	Thị trấn Võ Xu	600	active
23194	Thị trấn Đức Tài	600	active
23197	Xã Đa Kai	600	active
23200	Xã Sùng Nhơn	600	active
23203	Xã Mê Pu	600	active
23206	Xã Nam Chính	600	active
23212	Xã Đức Hạnh	600	active
23215	Xã Đức Tín	600	active
23218	Xã Vũ Hoà	600	active
23221	Xã Tân Hà	600	active
23224	Xã Đông Hà	600	active
23227	Xã Trà Tân	600	active
23230	Thị trấn Tân Minh	601	active
23236	Thị trấn Tân Nghĩa	601	active
23239	Xã Sông Phan	601	active
23242	Xã Tân Phúc	601	active
23251	Xã Tân Đức	601	active
23254	Xã Tân Thắng	601	active
23255	Xã Thắng Hải	601	active
23257	Xã Tân Hà	601	active
23260	Xã Tân Xuân	601	active
23266	Xã Sơn Mỹ	601	active
23272	Xã Ngũ Phụng	602	active
23275	Xã Long Hải	602	active
23278	Xã Tam Thanh	602	active
23281	Phường Quang Trung	608	active
23284	Phường Duy Tân	608	active
23287	Phường Quyết Thắng	608	active
23290	Phường Trường Chinh	608	active
23293	Phường Thắng Lợi	608	active
23296	Phường Ngô Mây	608	active
23299	Phường Thống Nhất	608	active
23302	Phường Lê Lợi	608	active
23305	Phường Nguyễn Trãi	608	active
23308	Phường Trần Hưng Đạo	608	active
23311	Xã Đắk Cấm	608	active
23314	Xã Kroong	608	active
23317	Xã Ngọk Bay	608	active
23320	Xã Vinh Quang	608	active
23323	Xã Đắk Blà	608	active
23326	Xã Ia Chim	608	active
23327	Xã Đăk Năng	608	active
23329	Xã Đoàn Kết	608	active
23332	Xã Chư Hreng	608	active
23335	Xã Đắk Rơ Wa	608	active
23338	Xã Hòa Bình	608	active
23341	Thị trấn Đắk Glei	610	active
23344	Xã Đắk Blô	610	active
23347	Xã Đắk Man	610	active
23350	Xã Đắk Nhoong	610	active
23353	Xã Đắk Pék	610	active
23356	Xã Đắk Choong	610	active
23359	Xã Xốp	610	active
23362	Xã Mường Hoong	610	active
23365	Xã Ngọc Linh	610	active
23368	Xã Đắk Long	610	active
23371	Xã Đắk KRoong	610	active
23374	Xã Đắk Môn	610	active
23377	Thị trấn Plei Kần	611	active
23380	Xã Đắk Ang	611	active
23383	Xã Đắk Dục	611	active
23386	Xã Đắk Nông	611	active
23389	Xã Đắk Xú	611	active
23392	Xã Đắk Kan	611	active
23395	Xã Bờ Y	611	active
23398	Xã Sa Loong	611	active
23401	Thị trấn Đắk Tô	612	active
23427	Xã Đắk Rơ Nga	612	active
23428	Xã Ngọk Tụ	612	active
23430	Xã Đắk Trăm	612	active
23431	Xã Văn Lem	612	active
23434	Xã Kon Đào	612	active
23437	Xã Tân Cảnh	612	active
23440	Xã Diên Bình	612	active
23443	Xã Pô Kô	612	active
23452	Xã Đắk Nên	613	active
23455	Xã Đắk Ring	613	active
23458	Xã Măng Buk	613	active
23461	Xã Đắk Tăng	613	active
23464	Xã Ngok Tem	613	active
23467	Xã Pờ Ê	613	active
23470	Xã Măng Cành	613	active
23473	Thị trấn Măng Đen	613	active
23476	Xã Hiếu	613	active
23479	Thị trấn Đắk Rve	614	active
23482	Xã Đắk Kôi	614	active
23485	Xã Đắk Tơ Lung	614	active
23488	Xã Đắk Ruồng	614	active
23491	Xã Đắk Pne	614	active
23494	Xã Đắk Tờ Re	614	active
23497	Xã Tân Lập	614	active
23500	Thị trấn Đắk Hà	615	active
23503	Xã Đắk PXi	615	active
23504	Xã Đăk Long	615	active
23506	Xã Đắk HRing	615	active
23509	Xã Đắk Ui	615	active
23510	Xã Đăk Ngọk	615	active
23512	Xã Đắk Mar	615	active
23515	Xã Ngok Wang	615	active
23518	Xã Ngok Réo	615	active
23521	Xã Hà Mòn	615	active
23524	Xã Đắk La	615	active
23527	Thị trấn Sa Thầy	616	active
23530	Xã Rơ Kơi	616	active
23533	Xã Sa Nhơn	616	active
23534	Xã Hơ Moong	616	active
23536	Xã Mô Rai	616	active
23539	Xã Sa Sơn	616	active
23542	Xã Sa Nghĩa	616	active
23545	Xã Sa Bình	616	active
23548	Xã Ya Xiêr	616	active
23551	Xã Ya Tăng	616	active
23554	Xã Ya ly	616	active
23404	Xã Ngọc Lây	617	active
23407	Xã Đắk Na	617	active
23410	Xã Măng Ri	617	active
23413	Xã Ngọc Yêu	617	active
23416	Xã Đắk Sao	617	active
23417	Xã Đắk Rơ Ông	617	active
23419	Xã Đắk Tờ Kan	617	active
23422	Xã Tu Mơ Rông	617	active
23425	Xã Đắk Hà	617	active
23446	Xã Tê Xăng	617	active
23449	Xã Văn Xuôi	617	active
23535	Xã Ia Đal	618	active
23537	Xã Ia Dom	618	active
23538	Xã Ia Tơi	618	active
23557	Phường Yên Đỗ	622	active
23560	Phường Diên Hồng	622	active
23563	Phường Ia Kring	622	active
23566	Phường Hội Thương	622	active
23569	Phường Hội Phú	622	active
23570	Phường Phù Đổng	622	active
23572	Phường Hoa Lư	622	active
23575	Phường Tây Sơn	622	active
23578	Phường Thống Nhất	622	active
23579	Phường Đống Đa	622	active
23581	Phường Trà Bá	622	active
23582	Phường Thắng Lợi	622	active
23584	Phường Yên Thế	622	active
23586	Phường Chi Lăng	622	active
23590	Xã Biển Hồ	622	active
23593	Xã Tân Sơn	622	active
23596	Xã Trà Đa	622	active
23599	Xã Chư Á	622	active
23602	Xã An Phú	622	active
23605	Xã Diên Phú	622	active
23608	Xã Ia Kênh	622	active
23611	Xã Gào	622	active
23614	Phường An Bình	623	active
23617	Phường Tây Sơn	623	active
23620	Phường An Phú	623	active
23623	Phường An Tân	623	active
23626	Xã Tú An	623	active
23627	Xã Xuân An	623	active
23629	Xã Cửu An	623	active
23630	Phường An Phước	623	active
23632	Xã Song An	623	active
23633	Phường Ngô Mây	623	active
23635	Xã Thành An	623	active
24041	Phường Cheo Reo	624	active
24042	Phường Hòa Bình	624	active
24044	Phường Đoàn Kết	624	active
24045	Phường Sông Bờ	624	active
24064	Xã Ia RBol	624	active
24065	Xã Chư Băh	624	active
24070	Xã Ia RTô	624	active
24073	Xã Ia Sao	624	active
23638	Thị trấn KBang	625	active
23641	Xã Kon Pne	625	active
23644	Xã Đăk Roong	625	active
23647	Xã Sơn Lang	625	active
23650	Xã KRong	625	active
23653	Xã Sơ Pai	625	active
23656	Xã Lơ Ku	625	active
23659	Xã Đông	625	active
23660	Xã Đak SMar	625	active
23662	Xã Nghĩa An	625	active
23665	Xã Tơ Tung	625	active
23668	Xã Kông Lơng Khơng	625	active
23671	Xã Kông Pla	625	active
23674	Xã Đăk HLơ	625	active
23677	Thị trấn Đăk Đoa	626	active
23680	Xã Hà Đông	626	active
23683	Xã Đăk Sơmei	626	active
23684	Xã Đăk Krong	626	active
23686	Xã Hải Yang	626	active
23689	Xã Kon Gang	626	active
23692	Xã Hà Bầu	626	active
23695	Xã Nam Yang	626	active
23698	Xã K' Dang	626	active
23701	Xã H' Neng	626	active
23704	Xã Tân Bình	626	active
23707	Xã Glar	626	active
23710	Xã A Dơk	626	active
23713	Xã Trang	626	active
23714	Xã HNol	626	active
23716	Xã Ia Pết	626	active
23719	Xã Ia Băng	626	active
23722	Thị trấn Phú Hòa	627	active
23725	Xã Hà Tây	627	active
23728	Xã Ia Khươl	627	active
23731	Xã Ia Phí	627	active
23734	Thị trấn Ia Ly	627	active
23737	Xã Ia Mơ Nông	627	active
23738	Xã Ia Kreng	627	active
23740	Xã Đăk Tơ Ver	627	active
23743	Xã Hòa Phú	627	active
23746	Xã Chư Đăng Ya	627	active
23749	Xã Ia Ka	627	active
23752	Xã Ia Nhin	627	active
23755	Xã Nghĩa Hòa	627	active
23761	Xã Nghĩa Hưng	627	active
23764	Thị trấn Ia Kha	628	active
23767	Xã Ia Sao	628	active
23768	Xã Ia Yok	628	active
23770	Xã Ia Hrung	628	active
23771	Xã Ia Bă	628	active
23773	Xã Ia Khai	628	active
23776	Xã Ia KRai	628	active
23778	Xã Ia Grăng	628	active
23779	Xã Ia Tô	628	active
23782	Xã Ia O	628	active
23785	Xã Ia Dêr	628	active
23788	Xã Ia Chia	628	active
23791	Xã Ia Pếch	628	active
23794	Thị trấn Kon Dơng	629	active
23797	Xã Ayun	629	active
23798	Xã Đak Jơ Ta	629	active
23799	Xã Đak Ta Ley	629	active
23800	Xã Hra	629	active
23803	Xã Đăk Yă	629	active
23806	Xã Đăk Djrăng	629	active
23809	Xã Lơ Pang	629	active
23812	Xã Kon Thụp	629	active
23815	Xã Đê Ar	629	active
23818	Xã Kon Chiêng	629	active
23821	Xã Đăk Trôi	629	active
23824	Thị trấn Kông Chro	630	active
23827	Xã Chư Krêy	630	active
23830	Xã An Trung	630	active
23833	Xã Kông Yang	630	active
23836	Xã Đăk Tơ Pang	630	active
23839	Xã SRó	630	active
23840	Xã Đắk Kơ Ning	630	active
23842	Xã Đăk Song	630	active
23843	Xã Đăk Pling	630	active
23845	Xã Yang Trung	630	active
23846	Xã Đăk Pơ Pho	630	active
23848	Xã Ya Ma	630	active
23851	Xã Chơ Long	630	active
23854	Xã Yang Nam	630	active
23857	Thị trấn Chư Ty	631	active
23860	Xã Ia Dơk	631	active
23863	Xã Ia Krêl	631	active
23866	Xã Ia Din	631	active
23869	Xã Ia Kla	631	active
23872	Xã Ia Dom	631	active
23875	Xã Ia Lang	631	active
23878	Xã Ia Kriêng	631	active
23881	Xã Ia Pnôn	631	active
23884	Xã Ia Nan	631	active
23887	Thị trấn Chư Prông	632	active
23888	Xã Ia Kly	632	active
23890	Xã Bình Giáo	632	active
23893	Xã Ia Drăng	632	active
23896	Xã Thăng Hưng	632	active
23899	Xã Bàu Cạn	632	active
23902	Xã Ia Phìn	632	active
23905	Xã Ia Băng	632	active
23908	Xã Ia Tôr	632	active
23911	Xã Ia Boòng	632	active
23914	Xã Ia O	632	active
23917	Xã Ia Púch	632	active
23920	Xã Ia Me	632	active
23923	Xã Ia Vê	632	active
23924	Xã Ia Bang	632	active
23926	Xã Ia Pia	632	active
23929	Xã Ia Ga	632	active
23932	Xã Ia Lâu	632	active
23935	Xã Ia Piơr	632	active
23938	Xã Ia Mơ	632	active
23941	Thị trấn Chư Sê	633	active
23944	Xã Ia Tiêm	633	active
23945	Xã Chư Pơng	633	active
23946	Xã Bar Măih	633	active
23947	Xã Bờ Ngoong	633	active
23950	Xã Ia Glai	633	active
23953	Xã AL Bá	633	active
23954	Xã Kông HTok	633	active
23956	Xã AYun	633	active
23959	Xã Ia HLốp	633	active
23962	Xã Ia Blang	633	active
23965	Xã Dun	633	active
23966	Xã Ia Pal	633	active
23968	Xã H Bông	633	active
23977	Xã Ia Ko	633	active
23989	Xã Hà Tam	634	active
23992	Xã An Thành	634	active
23995	Thị trấn Đak Pơ	634	active
23998	Xã Yang Bắc	634	active
24001	Xã Cư An	634	active
24004	Xã Tân An	634	active
24007	Xã Phú An	634	active
24010	Xã Ya Hội	634	active
24013	Xã Pờ Tó	635	active
24016	Xã Chư Răng	635	active
24019	Xã Ia KDăm	635	active
24022	Xã Kim Tân	635	active
24025	Xã Chư Mố	635	active
24028	Xã Ia Tul	635	active
24031	Xã Ia Ma Rơn	635	active
24034	Xã Ia Broăi	635	active
24037	Xã Ia Trok	635	active
24076	Thị trấn Phú Túc	637	active
24079	Xã Ia RSai	637	active
24082	Xã Ia RSươm	637	active
24085	Xã Chư Gu	637	active
24088	Xã Đất Bằng	637	active
24091	Xã Ia Mláh	637	active
24094	Xã Chư Drăng	637	active
24097	Xã Phú Cần	637	active
24100	Xã Ia HDreh	637	active
24103	Xã Ia RMok	637	active
24106	Xã Chư Ngọc	637	active
24109	Xã Uar	637	active
24112	Xã Chư Rcăm	637	active
24115	Xã Krông Năng	637	active
24043	Thị trấn Phú Thiện	638	active
24046	Xã Chư A Thai	638	active
24048	Xã Ayun Hạ	638	active
24049	Xã Ia Ake	638	active
24052	Xã Ia Sol	638	active
24055	Xã Ia Piar	638	active
24058	Xã Ia Peng	638	active
24060	Xã Chrôh Pơnan	638	active
24061	Xã Ia Hiao	638	active
24067	Xã Ia Yeng	638	active
23942	Thị trấn Nhơn Hoà	639	active
23971	Xã Ia Hrú	639	active
23972	Xã Ia Rong	639	active
23974	Xã Ia Dreng	639	active
23978	Xã Ia Hla	639	active
23980	Xã Chư Don	639	active
23983	Xã Ia Phang	639	active
23986	Xã Ia Le	639	active
23987	Xã Ia BLứ	639	active
24118	Phường Tân Lập	643	active
24121	Phường Tân Hòa	643	active
24124	Phường Tân An	643	active
24127	Phường Thống Nhất	643	active
24130	Phường Thành Nhất	643	active
24133	Phường Thắng Lợi	643	active
24136	Phường Tân Lợi	643	active
24139	Phường Thành Công	643	active
24142	Phường Tân Thành	643	active
24145	Phường Tân Tiến	643	active
24148	Phường Tự An	643	active
24151	Phường Ea Tam	643	active
24154	Phường Khánh Xuân	643	active
24157	Xã Hòa Thuận	643	active
24160	Xã Cư ÊBur	643	active
24163	Xã Ea Tu	643	active
24166	Xã Hòa Thắng	643	active
24169	Xã Ea Kao	643	active
24172	Xã Hòa Phú	643	active
24175	Xã Hòa Khánh	643	active
24178	Xã Hòa Xuân	643	active
24305	Phường An Lạc	644	active
24308	Phường An Bình	644	active
24311	Phường Thiện An	644	active
24318	Phường Đạt Hiếu	644	active
24322	Phường Đoàn Kết	644	active
24325	Xã Ea Blang	644	active
24328	Xã Ea Drông	644	active
24331	Phường Thống Nhất	644	active
24332	Phường Bình Tân	644	active
24334	Xã Ea Siên	644	active
24337	Xã Bình Thuận	644	active
24340	Xã Cư Bao	644	active
24181	Thị trấn Ea Drăng	645	active
24184	Xã Ea H'leo	645	active
24187	Xã Ea Sol	645	active
24190	Xã Ea Ral	645	active
24193	Xã Ea Wy	645	active
24194	Xã Cư A Mung	645	active
24196	Xã Cư Mốt	645	active
24199	Xã Ea Hiao	645	active
24202	Xã Ea Khal	645	active
24205	Xã Dliê Yang	645	active
24207	Xã Ea Tir	645	active
24208	Xã Ea Nam	645	active
24211	Thị trấn Ea Súp	646	active
24214	Xã Ia Lốp	646	active
24215	Xã Ia JLơi	646	active
24217	Xã Ea Rốk	646	active
24220	Xã Ya Tờ Mốt	646	active
24221	Xã Ia RVê	646	active
24223	Xã Ea Lê	646	active
24226	Xã Cư KBang	646	active
24229	Xã Ea Bung	646	active
24232	Xã Cư M'Lan	646	active
24235	Xã Krông Na	647	active
24238	Xã Ea Huar	647	active
24241	Xã Ea Wer	647	active
24244	Xã Tân Hoà	647	active
24247	Xã Cuôr KNia	647	active
24250	Xã Ea Bar	647	active
24253	Xã Ea Nuôl	647	active
24256	Thị trấn Ea Pốk	648	active
24259	Thị trấn Quảng Phú	648	active
24262	Xã Quảng Tiến	648	active
24264	Xã Ea Kuêh	648	active
24265	Xã Ea Kiết	648	active
24268	Xã Ea Tar	648	active
24271	Xã Cư Dliê M'nông	648	active
24274	Xã Ea H'đinh	648	active
24277	Xã Ea Tul	648	active
24280	Xã Ea KPam	648	active
24283	Xã Ea M'DRóh	648	active
24286	Xã Quảng Hiệp	648	active
24289	Xã Cư M'gar	648	active
24292	Xã Ea D'Rơng	648	active
24295	Xã Ea M'nang	648	active
24298	Xã Cư Suê	648	active
24301	Xã Cuor Đăng	648	active
24307	Xã Cư Né	649	active
24310	Xã Chư KBô	649	active
24313	Xã Cư Pơng	649	active
24314	Xã Ea Sin	649	active
24316	Xã Pơng Drang	649	active
24317	Xã Tân Lập	649	active
24319	Xã Ea Ngai	649	active
24343	Thị trấn Krông Năng	650	active
24346	Xã ĐLiê Ya	650	active
24349	Xã Ea Tóh	650	active
24352	Xã Ea Tam	650	active
24355	Xã Phú Lộc	650	active
24358	Xã Tam Giang	650	active
24359	Xã Ea Puk	650	active
24360	Xã Ea Dăh	650	active
24361	Xã Ea Hồ	650	active
24364	Xã Phú Xuân	650	active
24367	Xã Cư Klông	650	active
24370	Xã Ea Tân	650	active
24373	Thị trấn Ea Kar	651	active
24376	Thị trấn Ea Knốp	651	active
24379	Xã Ea Sô	651	active
24380	Xã Ea Sar	651	active
24382	Xã Xuân Phú	651	active
24385	Xã Cư Huê	651	active
24388	Xã Ea Tih	651	active
24391	Xã Ea Đar	651	active
24394	Xã Ea Kmút	651	active
24397	Xã Cư Ni	651	active
24400	Xã Ea Păl	651	active
24401	Xã Cư Prông	651	active
24403	Xã Ea Ô	651	active
24404	Xã Cư ELang	651	active
24406	Xã Cư Bông	651	active
24409	Xã Cư Jang	651	active
24412	Thị trấn M'Đrắk	652	active
24415	Xã Cư Prao	652	active
24418	Xã Ea Pil	652	active
24421	Xã Ea Lai	652	active
24424	Xã Ea H'MLay	652	active
24427	Xã Krông Jing	652	active
24430	Xã Ea M' Doal	652	active
24433	Xã Ea Riêng	652	active
24436	Xã Cư M'ta	652	active
24439	Xã Cư K Róa	652	active
24442	Xã Krông Á	652	active
24444	Xã Cư San	652	active
24445	Xã Ea Trang	652	active
24448	Thị trấn Krông Kmar	653	active
24451	Xã Dang Kang	653	active
24454	Xã Cư KTy	653	active
24457	Xã Hòa Thành	653	active
24460	Xã Hòa Tân	653	active
24463	Xã Hòa Phong	653	active
24466	Xã Hòa Lễ	653	active
24469	Xã Yang Reh	653	active
24472	Xã Ea Trul	653	active
25402	Xã Thọ Sơn	696	active
24475	Xã Khuê Ngọc Điền	653	active
24478	Xã Cư Pui	653	active
24481	Xã Hòa Sơn	653	active
24484	Xã Cư Drăm	653	active
24487	Xã Yang Mao	653	active
24490	Thị trấn Phước An	654	active
24493	Xã KRông Búk	654	active
24496	Xã Ea Kly	654	active
24499	Xã Ea Kênh	654	active
24502	Xã Ea Phê	654	active
24505	Xã Ea KNuec	654	active
24508	Xã Ea Yông	654	active
24511	Xã Hòa An	654	active
24514	Xã Ea Kuăng	654	active
24517	Xã Hòa Đông	654	active
24520	Xã Ea Hiu	654	active
24523	Xã Hòa Tiến	654	active
24526	Xã Tân Tiến	654	active
24529	Xã Vụ Bổn	654	active
24532	Xã Ea Uy	654	active
24535	Xã Ea Yiêng	654	active
24538	Thị trấn Buôn Trấp	655	active
24556	Xã Dray Sáp	655	active
24559	Xã Ea Na	655	active
24565	Xã Ea Bông	655	active
24568	Xã Băng A Drênh	655	active
24571	Xã Dur KMăl	655	active
24574	Xã Bình Hòa	655	active
24577	Xã Quảng Điền	655	active
24580	Thị trấn Liên Sơn	656	active
24583	Xã Yang Tao	656	active
24586	Xã Bông Krang	656	active
24589	Xã Đắk Liêng	656	active
24592	Xã Buôn Triết	656	active
24595	Xã Buôn Tría	656	active
24598	Xã Đắk Phơi	656	active
24601	Xã Đắk Nuê	656	active
24604	Xã Krông Nô	656	active
24607	Xã Nam Ka	656	active
24610	Xã Ea R'Bin	656	active
24540	Xã Ea Ning	657	active
24541	Xã Cư Ê Wi	657	active
24544	Xã Ea Ktur	657	active
24547	Xã Ea Tiêu	657	active
24550	Xã Ea BHốk	657	active
24553	Xã Ea Hu	657	active
24561	Xã Dray Bhăng	657	active
24562	Xã Hòa Hiệp	657	active
24611	Phường Nghĩa Đức	660	active
24612	Phường Nghĩa Thành	660	active
24614	Phường Nghĩa Phú	660	active
24615	Phường Nghĩa Tân	660	active
24617	Phường Nghĩa Trung	660	active
24618	Xã Đăk R'Moan	660	active
24619	Phường Quảng Thành	660	active
24628	Xã Đắk Nia	660	active
24616	Xã Quảng Sơn	661	active
24620	Xã Quảng Hoà	661	active
24622	Xã Đắk Ha	661	active
24625	Xã Đắk R'Măng	661	active
24631	Xã Quảng Khê	661	active
24634	Xã Đắk Plao	661	active
24637	Xã Đắk Som	661	active
24640	Thị trấn Ea T'Ling	662	active
24643	Xã Đắk Wil	662	active
24646	Xã Ea Pô	662	active
24649	Xã Nam Dong	662	active
24652	Xã Đắk DRông	662	active
24655	Xã Tâm Thắng	662	active
24658	Xã Cư Knia	662	active
24661	Xã Trúc Sơn	662	active
24664	Thị trấn Đắk Mil	663	active
24667	Xã Đắk Lao	663	active
24670	Xã Đắk R'La	663	active
24673	Xã Đắk Gằn	663	active
24676	Xã Đức Mạnh	663	active
24677	Xã Đắk N'Drót	663	active
24678	Xã Long Sơn	663	active
24679	Xã Đắk Sắk	663	active
24682	Xã Thuận An	663	active
24685	Xã Đức Minh	663	active
24688	Thị trấn Đắk Mâm	664	active
24691	Xã Đắk Sôr	664	active
24692	Xã Nam Xuân	664	active
24694	Xã Buôn Choah	664	active
24697	Xã Nam Đà	664	active
24699	Xã Tân Thành	664	active
24700	Xã Đắk Drô	664	active
24703	Xã Nâm Nung	664	active
24706	Xã Đức Xuyên	664	active
24709	Xã Đắk Nang	664	active
24712	Xã Quảng Phú	664	active
24715	Xã Nâm N'Đir	664	active
24717	Thị trấn Đức An	665	active
24718	Xã Đắk Môl	665	active
24719	Xã Đắk Hòa	665	active
24721	Xã Nam Bình	665	active
24722	Xã Thuận Hà	665	active
24724	Xã Thuận Hạnh	665	active
24727	Xã Đắk N'Dung	665	active
24728	Xã Nâm N'Jang	665	active
24730	Xã Trường Xuân	665	active
24733	Thị trấn Kiến Đức	666	active
24745	Xã Quảng Tín	666	active
24750	Xã Đắk Wer	666	active
24751	Xã Nhân Cơ	666	active
24754	Xã Kiến Thành	666	active
24756	Xã Nghĩa Thắng	666	active
24757	Xã Đạo Nghĩa	666	active
24760	Xã Đắk Sin	666	active
24761	Xã Hưng Bình	666	active
24763	Xã Đắk Ru	666	active
24766	Xã Nhân Đạo	666	active
24736	Xã Quảng Trực	667	active
24739	Xã Đắk Búk So	667	active
24740	Xã Quảng Tâm	667	active
24742	Xã Đắk R'Tíh	667	active
24746	Xã Đắk Ngo	667	active
24748	Xã Quảng Tân	667	active
24769	Phường 7	672	active
24772	Phường 8	672	active
24775	Phường 12	672	active
24778	Phường 9	672	active
24781	Phường 2	672	active
24784	Phường 1	672	active
24787	Phường 6	672	active
24790	Phường 5	672	active
24793	Phường 4	672	active
24796	Phường 10	672	active
24799	Phường 11	672	active
24802	Phường 3	672	active
24805	Xã Xuân Thọ	672	active
24808	Xã Tà Nung	672	active
24810	Xã Trạm Hành	672	active
24811	Xã Xuân Trường	672	active
24814	Phường Lộc Phát	673	active
24817	Phường Lộc Tiến	673	active
24820	Phường 2	673	active
24823	Phường 1	673	active
24826	Phường B'lao	673	active
24829	Phường Lộc Sơn	673	active
24832	Xã Đạm Bri	673	active
24835	Xã Lộc Thanh	673	active
24838	Xã Lộc Nga	673	active
24841	Xã Lộc Châu	673	active
24844	Xã Đại Lào	673	active
24853	Xã Đạ Tông	674	active
24856	Xã Đạ Long	674	active
24859	Xã Đạ M' Rong	674	active
24874	Xã Liêng Srônh	674	active
24875	Xã Đạ Rsal	674	active
24877	Xã Rô Men	674	active
24886	Xã Phi Liêng	674	active
24889	Xã Đạ K' Nàng	674	active
24846	Thị trấn Lạc Dương	675	active
24847	Xã Đạ Chais	675	active
24848	Xã Đạ Nhim	675	active
24850	Xã Đưng KNớ	675	active
24862	Xã Lát	675	active
24865	Xã Đạ Sar	675	active
24868	Thị trấn Nam Ban	676	active
24871	Thị trấn Đinh Văn	676	active
24880	Xã Phú Sơn	676	active
24883	Xã Phi Tô	676	active
24892	Xã Mê Linh	676	active
24895	Xã Đạ Đờn	676	active
24898	Xã Phúc Thọ	676	active
24901	Xã Đông Thanh	676	active
24904	Xã Gia Lâm	676	active
24907	Xã Tân Thanh	676	active
24910	Xã Tân Văn	676	active
24913	Xã Hoài Đức	676	active
24916	Xã Tân Hà	676	active
24919	Xã Liên Hà	676	active
24922	Xã Đan Phượng	676	active
24925	Xã Nam Hà	676	active
24928	Thị trấn D'Ran	677	active
24931	Thị trấn Thạnh Mỹ	677	active
24934	Xã Lạc Xuân	677	active
24937	Xã Đạ Ròn	677	active
24940	Xã Lạc Lâm	677	active
24943	Xã Ka Đô	677	active
24946	Xã Quảng Lập	677	active
24949	Xã Ka Đơn	677	active
24952	Xã Tu Tra	677	active
24955	Xã Pró	677	active
24958	Thị trấn Liên Nghĩa	678	active
24961	Xã Hiệp An	678	active
24964	Xã Liên Hiệp	678	active
24967	Xã Hiệp Thạnh	678	active
24970	Xã Bình Thạnh	678	active
24973	Xã N'Thol Hạ	678	active
24976	Xã Tân Hội	678	active
24979	Xã Tân Thành	678	active
24982	Xã Phú Hội	678	active
24985	Xã Ninh Gia	678	active
24988	Xã Tà Năng	678	active
24989	Xã Đa Quyn	678	active
24991	Xã Tà Hine	678	active
24994	Xã Đà Loan	678	active
24997	Xã Ninh Loan	678	active
25000	Thị trấn Di Linh	679	active
25003	Xã Đinh Trang Thượng	679	active
25006	Xã Tân Thượng	679	active
25007	Xã Tân Lâm	679	active
25009	Xã Tân Châu	679	active
25012	Xã Tân Nghĩa	679	active
25015	Xã Gia Hiệp	679	active
25018	Xã Đinh Lạc	679	active
25021	Xã Tam Bố	679	active
25024	Xã Đinh Trang Hòa	679	active
25027	Xã Liên Đầm	679	active
25030	Xã Gung Ré	679	active
25033	Xã Bảo Thuận	679	active
25036	Xã Hòa Ninh	679	active
25039	Xã Hòa Trung	679	active
25042	Xã Hòa Nam	679	active
25045	Xã Hòa Bắc	679	active
25048	Xã Sơn Điền	679	active
25051	Xã Gia Bắc	679	active
25054	Thị trấn Lộc Thắng	680	active
25057	Xã Lộc Bảo	680	active
25060	Xã Lộc Lâm	680	active
25063	Xã Lộc Phú	680	active
25066	Xã Lộc Bắc	680	active
25069	Xã B' Lá	680	active
25072	Xã Lộc Ngãi	680	active
25075	Xã Lộc Quảng	680	active
25078	Xã Lộc Tân	680	active
25081	Xã Lộc Đức	680	active
25084	Xã Lộc An	680	active
25087	Xã Tân Lạc	680	active
25090	Xã Lộc Thành	680	active
25093	Xã Lộc Nam	680	active
25096	Thị trấn Đạ M'ri	681	active
25099	Thị trấn Ma Đa Guôi	681	active
25105	Xã Hà Lâm	681	active
25108	Xã Đạ Tồn	681	active
25111	Xã Đạ Oai	681	active
25114	Xã Đạ Ploa	681	active
25117	Xã Ma Đa Guôi	681	active
25120	Xã Đoàn Kết	681	active
25123	Xã Phước Lộc	681	active
25126	Thị trấn Đạ Tẻh	682	active
25129	Xã An Nhơn	682	active
25132	Xã Quốc Oai	682	active
25135	Xã Mỹ Đức	682	active
25138	Xã Quảng Trị	682	active
25141	Xã Đạ Lây	682	active
25147	Xã Triệu Hải	682	active
25153	Xã Đạ Kho	682	active
25156	Xã Đạ Pal	682	active
25159	Thị trấn Cát Tiên	683	active
25162	Xã Tiên Hoàng	683	active
25165	Xã Phước Cát 2	683	active
25168	Xã Gia Viễn	683	active
25171	Xã Nam Ninh	683	active
25180	Thị trấn Phước Cát	683	active
25183	Xã Đức Phổ	683	active
25189	Xã Quảng Ngãi	683	active
25192	Xã Đồng Nai Thượng	683	active
25216	Phường Thác Mơ	688	active
25217	Phường Long Thủy	688	active
25219	Phường Phước Bình	688	active
25220	Phường Long Phước	688	active
25237	Phường Sơn Giang	688	active
25245	Xã Long Giang	688	active
25249	Xã Phước Tín	688	active
25195	Phường Tân Phú	689	active
25198	Phường Tân Đồng	689	active
25201	Phường Tân Bình	689	active
25204	Phường Tân Xuân	689	active
25205	Phường Tân Thiện	689	active
25207	Xã Tân Thành	689	active
25210	Phường Tiến Thành	689	active
25213	Xã Tiến Hưng	689	active
25320	Phường Hưng Chiến	690	active
25324	Phường An Lộc	690	active
25325	Phường Phú Thịnh	690	active
25326	Phường Phú Đức	690	active
25333	Xã Thanh Lương	690	active
25336	Xã Thanh Phú	690	active
25222	Xã Bù Gia Mập	691	active
25225	Xã Đak Ơ	691	active
25228	Xã Đức Hạnh	691	active
25229	Xã Phú Văn	691	active
25231	Xã Đa Kia	691	active
25232	Xã Phước Minh	691	active
25234	Xã Bình Thắng	691	active
25267	Xã Phú Nghĩa	691	active
25270	Thị trấn Lộc Ninh	692	active
25273	Xã Lộc Hòa	692	active
25276	Xã Lộc An	692	active
25279	Xã Lộc Tấn	692	active
25280	Xã Lộc Thạnh	692	active
25282	Xã Lộc Hiệp	692	active
25285	Xã Lộc Thiện	692	active
25288	Xã Lộc Thuận	692	active
25291	Xã Lộc Quang	692	active
25292	Xã Lộc Phú	692	active
25294	Xã Lộc Thành	692	active
25297	Xã Lộc Thái	692	active
25300	Xã Lộc Điền	692	active
25303	Xã Lộc Hưng	692	active
25305	Xã Lộc Thịnh	692	active
25306	Xã Lộc Khánh	692	active
25308	Thị trấn Thanh Bình	693	active
25309	Xã Hưng Phước	693	active
25310	Xã Phước Thiện	693	active
25312	Xã Thiện Hưng	693	active
25315	Xã Thanh Hòa	693	active
25318	Xã Tân Thành	693	active
25321	Xã Tân Tiến	693	active
25327	Xã Thanh An	694	active
25330	Xã An Khương	694	active
25339	Xã An Phú	694	active
25342	Xã Tân Lợi	694	active
25345	Xã Tân Hưng	694	active
25348	Xã Minh Đức	694	active
25349	Xã Minh Tâm	694	active
25351	Xã Phước An	694	active
25354	Xã Thanh Bình	694	active
25357	Thị trấn Tân Khai	694	active
25360	Xã Đồng Nơ	694	active
25361	Xã Tân Hiệp	694	active
25438	Xã Tân Quan	694	active
25363	Thị trấn Tân Phú	695	active
25366	Xã Thuận Lợi	695	active
25369	Xã Đồng Tâm	695	active
25372	Xã Tân Phước	695	active
25375	Xã Tân Hưng	695	active
25378	Xã Tân Lợi	695	active
25381	Xã Tân Lập	695	active
25384	Xã Tân Hòa	695	active
25387	Xã Thuận Phú	695	active
25390	Xã Đồng Tiến	695	active
25393	Xã Tân Tiến	695	active
25396	Thị trấn Đức Phong	696	active
25398	Xã Đường 10	696	active
25399	Xã Đak Nhau	696	active
25400	Xã Phú Sơn	696	active
25404	Xã Bình Minh	696	active
25405	Xã Bom Bo	696	active
25408	Xã Minh Hưng	696	active
25411	Xã Đoàn Kết	696	active
25414	Xã Đồng Nai	696	active
25417	Xã Đức Liễu	696	active
25420	Xã Thống Nhất	696	active
25423	Xã Nghĩa Trung	696	active
25424	Xã Nghĩa Bình	696	active
25426	Xã Đăng Hà	696	active
25429	Xã Phước Sơn	696	active
25432	Thị trấn Chơn Thành	697	active
25433	Xã Thành Tâm	697	active
25435	Xã Minh Lập	697	active
25439	Xã Quang Minh	697	active
25441	Xã Minh Hưng	697	active
25444	Xã Minh Long	697	active
25447	Xã Minh Thành	697	active
25450	Xã Nha Bích	697	active
25453	Xã Minh Thắng	697	active
25240	Xã Long Bình	698	active
25243	Xã Bình Tân	698	active
25244	Xã Bình Sơn	698	active
25246	Xã Long Hưng	698	active
25250	Xã Phước Tân	698	active
25252	Xã Bù Nho	698	active
25255	Xã Long Hà	698	active
25258	Xã Long Tân	698	active
25261	Xã Phú Trung	698	active
25264	Xã Phú Riềng	698	active
25456	Phường 1	703	active
25459	Phường 3	703	active
25462	Phường 4	703	active
25465	Phường Hiệp Ninh	703	active
25468	Phường 2	703	active
25471	Xã Thạnh Tân	703	active
25474	Xã Tân Bình	703	active
25477	Xã Bình Minh	703	active
25480	Phường Ninh Sơn	703	active
25483	Phường Ninh Thạnh	703	active
25486	Thị trấn Tân Biên	705	active
25489	Xã Tân Lập	705	active
25492	Xã Thạnh Bắc	705	active
25495	Xã Tân Bình	705	active
25498	Xã Thạnh Bình	705	active
25501	Xã Thạnh Tây	705	active
25504	Xã Hòa Hiệp	705	active
25507	Xã Tân Phong	705	active
25510	Xã Mỏ Công	705	active
25513	Xã Trà Vong	705	active
25516	Thị trấn Tân Châu	706	active
25519	Xã Tân Hà	706	active
25522	Xã Tân Đông	706	active
25525	Xã Tân Hội	706	active
25528	Xã Tân Hòa	706	active
25531	Xã Suối Ngô	706	active
25534	Xã Suối Dây	706	active
25537	Xã Tân Hiệp	706	active
25540	Xã Thạnh Đông	706	active
25543	Xã Tân Thành	706	active
25546	Xã Tân Phú	706	active
25549	Xã Tân Hưng	706	active
25552	Thị trấn Dương Minh Châu	707	active
25555	Xã Suối Đá	707	active
25558	Xã Phan	707	active
25561	Xã Phước Ninh	707	active
25564	Xã Phước Minh	707	active
25567	Xã Bàu Năng	707	active
25570	Xã Chà Là	707	active
25573	Xã Cầu Khởi	707	active
25576	Xã Bến Củi	707	active
25579	Xã Lộc Ninh	707	active
25582	Xã Truông Mít	707	active
25585	Thị trấn Châu Thành	708	active
25588	Xã Hảo Đước	708	active
25591	Xã Phước Vinh	708	active
25594	Xã Đồng Khởi	708	active
25597	Xã Thái Bình	708	active
25600	Xã An Cơ	708	active
25603	Xã Biên Giới	708	active
25606	Xã Hòa Thạnh	708	active
25609	Xã Trí Bình	708	active
25612	Xã Hòa Hội	708	active
25615	Xã An Bình	708	active
25618	Xã Thanh Điền	708	active
25621	Xã Thành Long	708	active
25624	Xã Ninh Điền	708	active
25627	Xã Long Vĩnh	708	active
25630	Phường Long Hoa	709	active
25633	Phường Hiệp Tân	709	active
25636	Phường Long Thành Bắc	709	active
25639	Xã Trường Hòa	709	active
25642	Xã Trường Đông	709	active
25645	Phường Long Thành Trung	709	active
25648	Xã Trường Tây	709	active
25651	Xã Long Thành Nam	709	active
25654	Thị trấn Gò Dầu	710	active
25657	Xã Thạnh Đức	710	active
25660	Xã Cẩm Giang	710	active
25663	Xã Hiệp Thạnh	710	active
25666	Xã Bàu Đồn	710	active
25669	Xã Phước Thạnh	710	active
25672	Xã Phước Đông	710	active
25675	Xã Phước Trạch	710	active
25678	Xã Thanh Phước	710	active
25681	Thị trấn Bến Cầu	711	active
25684	Xã Long Chữ	711	active
25687	Xã Long Phước	711	active
25690	Xã Long Giang	711	active
25693	Xã Tiên Thuận	711	active
25696	Xã Long Khánh	711	active
25699	Xã Lợi Thuận	711	active
25702	Xã Long Thuận	711	active
25705	Xã An Thạnh	711	active
25708	Phường Trảng Bàng	712	active
25711	Xã Đôn Thuận	712	active
25714	Xã Hưng Thuận	712	active
25717	Phường Lộc Hưng	712	active
25720	Phường Gia Lộc	712	active
25723	Phường Gia Bình	712	active
25729	Xã Phước Bình	712	active
25732	Phường An Tịnh	712	active
25735	Phường An Hòa	712	active
25738	Xã Phước Chỉ	712	active
25741	Phường Hiệp Thành	718	active
25744	Phường Phú Lợi	718	active
25747	Phường Phú Cường	718	active
25750	Phường Phú Hòa	718	active
25753	Phường Phú Thọ	718	active
25756	Phường Chánh Nghĩa	718	active
25759	Phường Định Hoà	718	active
25760	Phường Hoà Phú	718	active
25762	Phường Phú Mỹ	718	active
25763	Phường Phú Tân	718	active
25765	Phường Tân An	718	active
25768	Phường Hiệp An	718	active
25771	Phường Tương Bình Hiệp	718	active
25774	Phường Chánh Mỹ	718	active
25816	Xã Trừ Văn Thố	719	active
25819	Xã Cây Trường II	719	active
25822	Thị trấn Lai Uyên	719	active
25825	Xã Tân Hưng	719	active
25828	Xã Long Nguyên	719	active
25831	Xã Hưng Hòa	719	active
25834	Xã Lai Hưng	719	active
25777	Thị trấn Dầu Tiếng	720	active
25780	Xã Minh Hoà	720	active
25783	Xã Minh Thạnh	720	active
25786	Xã Minh Tân	720	active
25789	Xã Định An	720	active
25792	Xã Long Hoà	720	active
25795	Xã Định Thành	720	active
25798	Xã Định Hiệp	720	active
25801	Xã An Lập	720	active
25804	Xã Long Tân	720	active
25807	Xã Thanh An	720	active
25810	Xã Thanh Tuyền	720	active
25813	Phường Mỹ Phước	721	active
25837	Phường Chánh Phú Hòa	721	active
25840	Xã An Điền	721	active
25843	Xã An Tây	721	active
25846	Phường Thới Hòa	721	active
25849	Phường Hòa Lợi	721	active
25852	Phường Tân Định	721	active
25855	Xã Phú An	721	active
25858	Thị trấn Phước Vĩnh	722	active
25861	Xã An Linh	722	active
25864	Xã Phước Sang	722	active
25865	Xã An Thái	722	active
25867	Xã An Long	722	active
25870	Xã An Bình	722	active
25873	Xã Tân Hiệp	722	active
25876	Xã Tam Lập	722	active
25879	Xã Tân Long	722	active
25882	Xã Vĩnh Hoà	722	active
25885	Xã Phước Hoà	722	active
25888	Phường Uyên Hưng	723	active
25891	Phường Tân Phước Khánh	723	active
25912	Phường Vĩnh Tân	723	active
25915	Phường Hội Nghĩa	723	active
25920	Phường Tân Hiệp	723	active
25921	Phường Khánh Bình	723	active
25924	Phường Phú Chánh	723	active
25930	Xã Bạch Đằng	723	active
25933	Phường Tân Vĩnh Hiệp	723	active
25936	Phường Thạnh Phước	723	active
25937	Xã Thạnh Hội	723	active
25939	Phường Thái Hòa	723	active
25942	Phường Dĩ An	724	active
25945	Phường Tân Bình	724	active
25948	Phường Tân Đông Hiệp	724	active
25951	Phường Bình An	724	active
25954	Phường Bình Thắng	724	active
25957	Phường Đông Hòa	724	active
25960	Phường An Bình	724	active
25963	Phường An Thạnh	725	active
25966	Phường Lái Thiêu	725	active
25969	Phường Bình Chuẩn	725	active
25972	Phường Thuận Giao	725	active
25975	Phường An Phú	725	active
25978	Phường Hưng Định	725	active
25981	Xã An Sơn	725	active
25984	Phường Bình Nhâm	725	active
25987	Phường Bình Hòa	725	active
25990	Phường Vĩnh Phú	725	active
25894	Xã Tân Định	726	active
25897	Xã Bình Mỹ	726	active
25900	Thị trấn Tân Bình	726	active
25903	Xã Tân Lập	726	active
25906	Thị trấn Tân Thành	726	active
25907	Xã Đất Cuốc	726	active
25908	Xã Hiếu Liêm	726	active
25909	Xã Lạc An	726	active
25918	Xã Tân Mỹ	726	active
25927	Xã Thường Tân	726	active
25993	Phường Trảng Dài	731	active
25996	Phường Tân Phong	731	active
25999	Phường Tân Biên	731	active
26002	Phường Hố Nai	731	active
26005	Phường Tân Hòa	731	active
26008	Phường Tân Hiệp	731	active
26011	Phường Bửu Long	731	active
26014	Phường Tân Tiến	731	active
26017	Phường Tam Hiệp	731	active
26020	Phường Long Bình	731	active
26023	Phường Quang Vinh	731	active
26026	Phường Tân Mai	731	active
26029	Phường Thống Nhất	731	active
26032	Phường Trung Dũng	731	active
26035	Phường Tam Hòa	731	active
26038	Phường Hòa Bình	731	active
26041	Phường Quyết Thắng	731	active
26044	Phường Thanh Bình	731	active
26047	Phường Bình Đa	731	active
26050	Phường An Bình	731	active
26053	Phường Bửu Hòa	731	active
26056	Phường Long Bình Tân	731	active
26059	Phường Tân Vạn	731	active
26062	Phường Tân Hạnh	731	active
26065	Phường Hiệp Hòa	731	active
26068	Phường Hóa An	731	active
26371	Phường An Hòa	731	active
26374	Phường Tam Phước	731	active
26377	Phường Phước Tân	731	active
26380	Xã Long Hưng	731	active
26071	Phường Xuân Trung	732	active
26074	Phường Xuân Thanh	732	active
26077	Phường Xuân Bình	732	active
26080	Phường Xuân An	732	active
26083	Phường Xuân Hoà	732	active
26086	Phường Phú Bình	732	active
26089	Xã Bình Lộc	732	active
26092	Xã Bảo Quang	732	active
26095	Phường Suối Tre	732	active
26098	Phường Bảo Vinh	732	active
26101	Phường Xuân Lập	732	active
26104	Phường Bàu Sen	732	active
26107	Xã Bàu Trâm	732	active
26110	Phường Xuân Tân	732	active
26113	Xã Hàng Gòn	732	active
26116	Thị trấn Tân Phú	734	active
26119	Xã Dak Lua	734	active
26122	Xã Nam Cát Tiên	734	active
26125	Xã Phú An	734	active
26128	Xã Núi Tượng	734	active
26131	Xã Tà Lài	734	active
26134	Xã Phú Lập	734	active
26137	Xã Phú Sơn	734	active
26140	Xã Phú Thịnh	734	active
26143	Xã Thanh Sơn	734	active
26146	Xã Phú Trung	734	active
26149	Xã Phú Xuân	734	active
26152	Xã Phú Lộc	734	active
26155	Xã Phú Lâm	734	active
26158	Xã Phú Bình	734	active
26161	Xã Phú Thanh	734	active
26164	Xã Trà Cổ	734	active
26167	Xã Phú Điền	734	active
26170	Thị trấn Vĩnh An	735	active
26173	Xã Phú Lý	735	active
26176	Xã Trị An	735	active
26179	Xã Tân An	735	active
26182	Xã Vĩnh Tân	735	active
26185	Xã Bình Lợi	735	active
26188	Xã Thạnh Phú	735	active
26191	Xã Thiện Tân	735	active
26194	Xã Tân Bình	735	active
26197	Xã Bình Hòa	735	active
26200	Xã Mã Đà	735	active
26203	Xã Hiếu Liêm	735	active
26206	Thị trấn Định Quán	736	active
26209	Xã Thanh Sơn	736	active
26212	Xã Phú Tân	736	active
26215	Xã Phú Vinh	736	active
26218	Xã Phú Lợi	736	active
26221	Xã Phú Hòa	736	active
26224	Xã Ngọc Định	736	active
26227	Xã La Ngà	736	active
26230	Xã Gia Canh	736	active
26233	Xã Phú Ngọc	736	active
26236	Xã Phú Cường	736	active
26239	Xã Túc Trưng	736	active
26242	Xã Phú Túc	736	active
26245	Xã Suối Nho	736	active
26248	Thị trấn Trảng Bom	737	active
26251	Xã Thanh Bình	737	active
26254	Xã Cây Gáo	737	active
26257	Xã Bàu Hàm	737	active
26260	Xã Sông Thao	737	active
26263	Xã Sông Trầu	737	active
26266	Xã Đông Hoà	737	active
26269	Xã Bắc Sơn	737	active
26272	Xã Hố Nai 3	737	active
26275	Xã Tây Hoà	737	active
26278	Xã Bình Minh	737	active
26281	Xã Trung Hoà	737	active
26284	Xã Đồi 61	737	active
26287	Xã Hưng Thịnh	737	active
26290	Xã Quảng Tiến	737	active
26293	Xã Giang Điền	737	active
26296	Xã An Viễn	737	active
26299	Xã Gia Tân 1	738	active
26302	Xã Gia Tân 2	738	active
26305	Xã Gia Tân 3	738	active
26308	Xã Gia Kiệm	738	active
26311	Xã Quang Trung	738	active
26314	Xã Bàu Hàm 2	738	active
26317	Xã Hưng Lộc	738	active
26320	Xã Lộ 25	738	active
26323	Xã Xuân Thiện	738	active
26326	Thị trấn Dầu Giây	738	active
26329	Xã Sông Nhạn	739	active
26332	Xã Xuân Quế	739	active
26335	Xã Nhân Nghĩa	739	active
27073	Phường 11	768	active
26338	Xã Xuân Đường	739	active
26341	Thị trấn Long Giao	739	active
26344	Xã Xuân Mỹ	739	active
26347	Xã Thừa Đức	739	active
26350	Xã Bảo Bình	739	active
26353	Xã Xuân Bảo	739	active
26356	Xã Xuân Tây	739	active
26359	Xã Xuân Đông	739	active
26362	Xã Sông Ray	739	active
26365	Xã Lâm San	739	active
26368	Thị trấn Long Thành	740	active
26383	Xã An Phước	740	active
26386	Xã Bình An	740	active
26389	Xã Long Đức	740	active
26392	Xã Lộc An	740	active
26395	Xã Bình Sơn	740	active
26398	Xã Tam An	740	active
26401	Xã Cẩm Đường	740	active
26404	Xã Long An	740	active
26410	Xã Bàu Cạn	740	active
26413	Xã Long Phước	740	active
26416	Xã Phước Bình	740	active
26419	Xã Tân Hiệp	740	active
26422	Xã Phước Thái	740	active
26425	Thị trấn Gia Ray	741	active
26428	Xã Xuân Bắc	741	active
26431	Xã Suối Cao	741	active
26434	Xã Xuân Thành	741	active
26437	Xã Xuân Thọ	741	active
26440	Xã Xuân Trường	741	active
26443	Xã Xuân Hòa	741	active
26446	Xã Xuân Hưng	741	active
26449	Xã Xuân Tâm	741	active
26452	Xã Suối Cát	741	active
26455	Xã Xuân Hiệp	741	active
26458	Xã Xuân Phú	741	active
26461	Xã Xuân Định	741	active
26464	Xã Bảo Hoà	741	active
26467	Xã Lang Minh	741	active
26470	Xã Phước Thiền	742	active
26473	Xã Long Tân	742	active
26476	Xã Đại Phước	742	active
26479	Thị trấn Hiệp Phước	742	active
26482	Xã Phú Hữu	742	active
26485	Xã Phú Hội	742	active
26488	Xã Phú Thạnh	742	active
26491	Xã Phú Đông	742	active
26494	Xã Long Thọ	742	active
26497	Xã Vĩnh Thanh	742	active
26500	Xã Phước Khánh	742	active
26503	Xã Phước An	742	active
26506	Phường 1	747	active
26508	Phường Thắng Tam	747	active
26509	Phường 2	747	active
26512	Phường 3	747	active
26515	Phường 4	747	active
26518	Phường 5	747	active
26521	Phường Thắng Nhì	747	active
26524	Phường 7	747	active
26526	Phường Nguyễn An Ninh	747	active
26527	Phường 8	747	active
26530	Phường 9	747	active
26533	Phường Thắng Nhất	747	active
26535	Phường Rạch Dừa	747	active
26536	Phường 10	747	active
26539	Phường 11	747	active
26542	Phường 12	747	active
26545	Xã Long Sơn	747	active
26548	Phường Phước Hưng	748	active
26551	Phường Phước Hiệp	748	active
26554	Phường Phước Nguyên	748	active
26557	Phường Long Toàn	748	active
26558	Phường Long Tâm	748	active
26560	Phường Phước Trung	748	active
26563	Phường Long Hương	748	active
26566	Phường Kim Dinh	748	active
26567	Xã Tân Hưng	748	active
26569	Xã Long Phước	748	active
26572	Xã Hoà Long	748	active
26574	Xã Bàu Chinh	750	active
26575	Thị trấn Ngãi Giao	750	active
26578	Xã Bình Ba	750	active
26581	Xã Suối Nghệ	750	active
26584	Xã Xuân Sơn	750	active
26587	Xã Sơn Bình	750	active
26590	Xã Bình Giã	750	active
26593	Xã Bình Trung	750	active
26596	Xã Xà Bang	750	active
26599	Xã Cù Bị	750	active
26602	Xã Láng Lớn	750	active
26605	Xã Quảng Thành	750	active
26608	Xã Kim Long	750	active
26611	Xã Suối Rao	750	active
26614	Xã Đá Bạc	750	active
26617	Xã Nghĩa Thành	750	active
26620	Thị trấn Phước Bửu	751	active
26623	Xã Phước Thuận	751	active
26626	Xã Phước Tân	751	active
26629	Xã Xuyên Mộc	751	active
26632	Xã Bông Trang	751	active
26635	Xã Tân Lâm	751	active
26638	Xã Bàu Lâm	751	active
26641	Xã Hòa Bình	751	active
26644	Xã Hòa Hưng	751	active
26647	Xã Hòa Hiệp	751	active
26650	Xã Hòa Hội	751	active
26653	Xã Bưng Riềng	751	active
26656	Xã Bình Châu	751	active
26659	Thị trấn Long Điền	752	active
26662	Thị trấn Long Hải	752	active
26665	Xã An Ngãi	752	active
26668	Xã Tam Phước	752	active
26671	Xã An Nhứt	752	active
26674	Xã Phước Tỉnh	752	active
26677	Xã Phước Hưng	752	active
26680	Thị trấn Đất Đỏ	753	active
26683	Xã Phước Long Thọ	753	active
26686	Xã Phước Hội	753	active
26689	Xã Long Mỹ	753	active
26692	Thị trấn Phước Hải	753	active
26695	Xã Long Tân	753	active
26698	Xã Láng Dài	753	active
26701	Xã Lộc An	753	active
26704	Phường Phú Mỹ	754	active
26707	Xã Tân Hoà	754	active
26710	Xã Tân Hải	754	active
26713	Phường Phước Hoà	754	active
26716	Phường Tân Phước	754	active
26719	Phường Mỹ Xuân	754	active
26722	Xã Sông Xoài	754	active
26725	Phường Hắc Dịch	754	active
26728	Xã Châu Pha	754	active
26731	Xã Tóc Tiên	754	active
26734	Phường Tân Định	760	active
26737	Phường Đa Kao	760	active
26740	Phường Bến Nghé	760	active
26743	Phường Bến Thành	760	active
26746	Phường Nguyễn Thái Bình	760	active
26749	Phường Phạm Ngũ Lão	760	active
26752	Phường Cầu Ông Lãnh	760	active
26755	Phường Cô Giang	760	active
26758	Phường Nguyễn Cư Trinh	760	active
26761	Phường Cầu Kho	760	active
26764	Phường Thạnh Xuân	761	active
26767	Phường Thạnh Lộc	761	active
26770	Phường Hiệp Thành	761	active
26773	Phường Thới An	761	active
26776	Phường Tân Chánh Hiệp	761	active
26779	Phường An Phú Đông	761	active
26782	Phường Tân Thới Hiệp	761	active
26785	Phường Trung Mỹ Tây	761	active
26787	Phường Tân Hưng Thuận	761	active
26788	Phường Đông Hưng Thuận	761	active
26791	Phường Tân Thới Nhất	761	active
26869	Phường 15	764	active
26872	Phường 13	764	active
26875	Phường 17	764	active
26876	Phường 6	764	active
26878	Phường 16	764	active
26881	Phường 12	764	active
26882	Phường 14	764	active
26884	Phường 10	764	active
26887	Phường 05	764	active
26890	Phường 07	764	active
26893	Phường 04	764	active
26896	Phường 01	764	active
26897	Phường 9	764	active
26898	Phường 8	764	active
26899	Phường 11	764	active
26902	Phường 03	764	active
26905	Phường 13	765	active
26908	Phường 11	765	active
26911	Phường 27	765	active
26914	Phường 26	765	active
26917	Phường 12	765	active
26920	Phường 25	765	active
26923	Phường 05	765	active
26926	Phường 07	765	active
26929	Phường 24	765	active
26932	Phường 06	765	active
26935	Phường 14	765	active
26938	Phường 15	765	active
26941	Phường 02	765	active
26944	Phường 01	765	active
26947	Phường 03	765	active
26950	Phường 17	765	active
26953	Phường 21	765	active
26956	Phường 22	765	active
26959	Phường 19	765	active
26962	Phường 28	765	active
26965	Phường 02	766	active
26968	Phường 04	766	active
26971	Phường 12	766	active
26974	Phường 13	766	active
26977	Phường 01	766	active
26980	Phường 03	766	active
26983	Phường 11	766	active
26986	Phường 07	766	active
26989	Phường 05	766	active
26992	Phường 10	766	active
26995	Phường 06	766	active
26998	Phường 08	766	active
27001	Phường 09	766	active
27004	Phường 14	766	active
27007	Phường 15	766	active
27010	Phường Tân Sơn Nhì	767	active
27013	Phường Tây Thạnh	767	active
27016	Phường Sơn Kỳ	767	active
27019	Phường Tân Quý	767	active
27022	Phường Tân Thành	767	active
27025	Phường Phú Thọ Hòa	767	active
27028	Phường Phú Thạnh	767	active
27031	Phường Phú Trung	767	active
27034	Phường Hòa Thạnh	767	active
27037	Phường Hiệp Tân	767	active
27040	Phường Tân Thới Hòa	767	active
27043	Phường 04	768	active
27046	Phường 05	768	active
27049	Phường 09	768	active
27052	Phường 07	768	active
27055	Phường 03	768	active
27058	Phường 01	768	active
27061	Phường 02	768	active
27064	Phường 08	768	active
27067	Phường 15	768	active
27070	Phường 10	768	active
27076	Phường 17	768	active
27085	Phường 13	768	active
26794	Phường Linh Xuân	769	active
26797	Phường Bình Chiểu	769	active
26800	Phường Linh Trung	769	active
26803	Phường Tam Bình	769	active
26806	Phường Tam Phú	769	active
26809	Phường Hiệp Bình Phước	769	active
26812	Phường Hiệp Bình Chánh	769	active
26815	Phường Linh Chiểu	769	active
26818	Phường Linh Tây	769	active
26821	Phường Linh Đông	769	active
26824	Phường Bình Thọ	769	active
26827	Phường Trường Thọ	769	active
26830	Phường Long Bình	769	active
26833	Phường Long Thạnh Mỹ	769	active
26836	Phường Tân Phú	769	active
26839	Phường Hiệp Phú	769	active
26842	Phường Tăng Nhơn Phú A	769	active
26845	Phường Tăng Nhơn Phú B	769	active
26848	Phường Phước Long B	769	active
26851	Phường Phước Long A	769	active
26854	Phường Trường Thạnh	769	active
26857	Phường Long Phước	769	active
26860	Phường Long Trường	769	active
26863	Phường Phước Bình	769	active
26866	Phường Phú Hữu	769	active
27088	Phường Thảo Điền	769	active
27091	Phường An Phú	769	active
27094	Phường An Khánh	769	active
27097	Phường Bình Trưng Đông	769	active
27100	Phường Bình Trưng Tây	769	active
27109	Phường Cát Lái	769	active
27112	Phường Thạnh Mỹ Lợi	769	active
27115	Phường An Lợi Đông	769	active
27118	Phường Thủ Thiêm	769	active
27127	Phường 14	770	active
27130	Phường 12	770	active
27133	Phường 11	770	active
27136	Phường 13	770	active
27139	Phường Võ Thị Sáu	770	active
27142	Phường 09	770	active
27145	Phường 10	770	active
27148	Phường 04	770	active
27151	Phường 05	770	active
27154	Phường 03	770	active
27157	Phường 02	770	active
27160	Phường 01	770	active
27163	Phường 15	771	active
27166	Phường 13	771	active
27169	Phường 14	771	active
27172	Phường 12	771	active
27175	Phường 11	771	active
27178	Phường 10	771	active
27181	Phường 09	771	active
27184	Phường 01	771	active
27187	Phường 08	771	active
27190	Phường 02	771	active
27193	Phường 04	771	active
27196	Phường 07	771	active
27199	Phường 05	771	active
27202	Phường 06	771	active
27208	Phường 15	772	active
27211	Phường 05	772	active
27214	Phường 14	772	active
27217	Phường 11	772	active
27220	Phường 03	772	active
27223	Phường 10	772	active
27226	Phường 13	772	active
27229	Phường 08	772	active
27232	Phường 09	772	active
27235	Phường 12	772	active
27238	Phường 07	772	active
27241	Phường 06	772	active
27244	Phường 04	772	active
27247	Phường 01	772	active
27250	Phường 02	772	active
27253	Phường 16	772	active
27259	Phường 13	773	active
27262	Phường 09	773	active
27265	Phường 06	773	active
27268	Phường 08	773	active
27271	Phường 10	773	active
27277	Phường 18	773	active
27280	Phường 14	773	active
27283	Phường 04	773	active
27286	Phường 03	773	active
27289	Phường 16	773	active
27292	Phường 02	773	active
27295	Phường 15	773	active
27298	Phường 01	773	active
27301	Phường 04	774	active
27304	Phường 09	774	active
27307	Phường 03	774	active
27310	Phường 12	774	active
27313	Phường 02	774	active
27316	Phường 08	774	active
27322	Phường 07	774	active
27325	Phường 01	774	active
27328	Phường 11	774	active
27331	Phường 14	774	active
27334	Phường 05	774	active
27337	Phường 06	774	active
27340	Phường 10	774	active
27343	Phường 13	774	active
27346	Phường 14	775	active
27349	Phường 13	775	active
27352	Phường 09	775	active
27355	Phường 06	775	active
27358	Phường 12	775	active
27361	Phường 05	775	active
27364	Phường 11	775	active
27367	Phường 02	775	active
27370	Phường 01	775	active
27373	Phường 04	775	active
27376	Phường 08	775	active
27379	Phường 03	775	active
27382	Phường 07	775	active
27385	Phường 10	775	active
27388	Phường 08	776	active
27391	Phường 02	776	active
27394	Phường 01	776	active
27397	Phường 03	776	active
27400	Phường 11	776	active
27403	Phường 09	776	active
27406	Phường 10	776	active
27409	Phường 04	776	active
27412	Phường 13	776	active
27415	Phường 12	776	active
27418	Phường 05	776	active
27421	Phường 14	776	active
27424	Phường 06	776	active
27427	Phường 15	776	active
27430	Phường 16	776	active
27433	Phường 07	776	active
27436	Phường Bình Hưng Hòa	777	active
27439	Phường Bình Hưng Hoà A	777	active
27442	Phường Bình Hưng Hoà B	777	active
27445	Phường Bình Trị Đông	777	active
27448	Phường Bình Trị Đông A	777	active
27451	Phường Bình Trị Đông B	777	active
27454	Phường Tân Tạo	777	active
27457	Phường Tân Tạo A	777	active
27460	Phường An Lạc	777	active
27463	Phường An Lạc A	777	active
27466	Phường Tân Thuận Đông	778	active
27469	Phường Tân Thuận Tây	778	active
27472	Phường Tân Kiểng	778	active
27475	Phường Tân Hưng	778	active
27478	Phường Bình Thuận	778	active
27481	Phường Tân Quy	778	active
27484	Phường Phú Thuận	778	active
27487	Phường Tân Phú	778	active
27490	Phường Tân Phong	778	active
27493	Phường Phú Mỹ	778	active
27496	Thị trấn Củ Chi	783	active
27499	Xã Phú Mỹ Hưng	783	active
27502	Xã An Phú	783	active
27505	Xã Trung Lập Thượng	783	active
27508	Xã An Nhơn Tây	783	active
27511	Xã Nhuận Đức	783	active
27514	Xã Phạm Văn Cội	783	active
27517	Xã Phú Hòa Đông	783	active
27520	Xã Trung Lập Hạ	783	active
27523	Xã Trung An	783	active
27526	Xã Phước Thạnh	783	active
27529	Xã Phước Hiệp	783	active
27532	Xã Tân An Hội	783	active
27535	Xã Phước Vĩnh An	783	active
27538	Xã Thái Mỹ	783	active
27541	Xã Tân Thạnh Tây	783	active
27544	Xã Hòa Phú	783	active
27547	Xã Tân Thạnh Đông	783	active
27550	Xã Bình Mỹ	783	active
27553	Xã Tân Phú Trung	783	active
27556	Xã Tân Thông Hội	783	active
27559	Thị trấn Hóc Môn	784	active
27562	Xã Tân Hiệp	784	active
27565	Xã Nhị Bình	784	active
27568	Xã Đông Thạnh	784	active
27571	Xã Tân Thới Nhì	784	active
27574	Xã Thới Tam Thôn	784	active
27577	Xã Xuân Thới Sơn	784	active
27580	Xã Tân Xuân	784	active
27583	Xã Xuân Thới Đông	784	active
27586	Xã Trung Chánh	784	active
27589	Xã Xuân Thới Thượng	784	active
27592	Xã Bà Điểm	784	active
27595	Thị trấn Tân Túc	785	active
27598	Xã Phạm Văn Hai	785	active
27601	Xã Vĩnh Lộc A	785	active
27604	Xã Vĩnh Lộc B	785	active
27607	Xã Bình Lợi	785	active
27610	Xã Lê Minh Xuân	785	active
27613	Xã Tân Nhựt	785	active
27616	Xã Tân Kiên	785	active
27619	Xã Bình Hưng	785	active
27622	Xã Phong Phú	785	active
27625	Xã An Phú Tây	785	active
27628	Xã Hưng Long	785	active
27631	Xã Đa Phước	785	active
27634	Xã Tân Quý Tây	785	active
27637	Xã Bình Chánh	785	active
27640	Xã Quy Đức	785	active
27643	Thị trấn Nhà Bè	786	active
27646	Xã Phước Kiển	786	active
27649	Xã Phước Lộc	786	active
27652	Xã Nhơn Đức	786	active
27655	Xã Phú Xuân	786	active
27658	Xã Long Thới	786	active
27661	Xã Hiệp Phước	786	active
27664	Thị trấn Cần Thạnh	787	active
27667	Xã Bình Khánh	787	active
27670	Xã Tam Thôn Hiệp	787	active
27673	Xã An Thới Đông	787	active
27676	Xã Thạnh An	787	active
27679	Xã Long Hòa	787	active
27682	Xã Lý Nhơn	787	active
27685	Phường 5	794	active
27688	Phường 2	794	active
27691	Phường 4	794	active
27692	Phường Tân Khánh	794	active
27694	Phường 1	794	active
27697	Phường 3	794	active
27698	Phường 7	794	active
27700	Phường 6	794	active
27703	Xã Hướng Thọ Phú	794	active
27706	Xã Nhơn Thạnh Trung	794	active
27709	Xã Lợi Bình Nhơn	794	active
27712	Xã Bình Tâm	794	active
27715	Phường Khánh Hậu	794	active
27718	Xã An Vĩnh Ngãi	794	active
27787	Phường 1	795	active
27788	Phường 2	795	active
27790	Xã Thạnh Trị	795	active
27793	Xã Bình Hiệp	795	active
27799	Xã Bình Tân	795	active
27805	Xã Tuyên Thạnh	795	active
27806	Phường 3	795	active
27817	Xã Thạnh Hưng	795	active
27721	Thị trấn Tân Hưng	796	active
27724	Xã Hưng Hà	796	active
27727	Xã Hưng Điền B	796	active
27730	Xã Hưng Điền	796	active
27733	Xã Thạnh Hưng	796	active
27736	Xã Hưng Thạnh	796	active
27739	Xã Vĩnh Thạnh	796	active
27742	Xã Vĩnh Châu B	796	active
27745	Xã Vĩnh Lợi	796	active
27748	Xã Vĩnh Đại	796	active
27751	Xã Vĩnh Châu A	796	active
27754	Xã Vĩnh Bửu	796	active
27757	Thị trấn Vĩnh Hưng	797	active
27760	Xã Hưng Điền A	797	active
27763	Xã Khánh Hưng	797	active
27766	Xã Thái Trị	797	active
27769	Xã Vĩnh Trị	797	active
27772	Xã Thái Bình Trung	797	active
27775	Xã Vĩnh Bình	797	active
27778	Xã Vĩnh Thuận	797	active
27781	Xã Tuyên Bình	797	active
27784	Xã Tuyên Bình Tây	797	active
27796	Xã Bình Hòa Tây	798	active
27802	Xã Bình Thạnh	798	active
27808	Xã Bình Hòa Trung	798	active
27811	Xã Bình Hòa Đông	798	active
27814	Thị trấn Bình Phong Thạnh	798	active
27820	Xã Tân Lập	798	active
27823	Xã Tân Thành	798	active
27826	Thị trấn Tân Thạnh	799	active
27829	Xã Bắc Hòa	799	active
27832	Xã Hậu Thạnh Tây	799	active
27835	Xã Nhơn Hòa Lập	799	active
27838	Xã Tân Lập	799	active
27841	Xã Hậu Thạnh Đông	799	active
27844	Xã Nhơn Hoà	799	active
27847	Xã Kiến Bình	799	active
27850	Xã Tân Thành	799	active
27853	Xã Tân Bình	799	active
27856	Xã Tân Ninh	799	active
27859	Xã Nhơn Ninh	799	active
27862	Xã Tân Hòa	799	active
27865	Thị trấn Thạnh Hóa	800	active
27868	Xã Tân Hiệp	800	active
27871	Xã Thuận Bình	800	active
27874	Xã Thạnh Phước	800	active
27877	Xã Thạnh Phú	800	active
27880	Xã Thuận Nghĩa Hòa	800	active
27883	Xã Thủy Đông	800	active
27886	Xã Thủy Tây	800	active
27889	Xã Tân Tây	800	active
27892	Xã Tân Đông	800	active
27895	Xã Thạnh An	800	active
27898	Thị trấn Đông Thành	801	active
27901	Xã Mỹ Quý Đông	801	active
27904	Xã Mỹ Thạnh Bắc	801	active
27907	Xã Mỹ Quý Tây	801	active
27910	Xã Mỹ Thạnh Tây	801	active
27913	Xã Mỹ Thạnh Đông	801	active
27916	Xã Bình Thành	801	active
27919	Xã Bình Hòa Bắc	801	active
27922	Xã Bình Hòa Hưng	801	active
27925	Xã Bình Hòa Nam	801	active
27928	Xã Mỹ Bình	801	active
27931	Thị trấn Hậu Nghĩa	802	active
27934	Thị trấn Hiệp Hòa	802	active
27937	Thị trấn Đức Hòa	802	active
27940	Xã Lộc Giang	802	active
27943	Xã An Ninh Đông	802	active
27946	Xã An Ninh Tây	802	active
27949	Xã Tân Mỹ	802	active
27952	Xã Hiệp Hòa	802	active
27955	Xã Đức Lập Thượng	802	active
27958	Xã Đức Lập Hạ	802	active
27961	Xã Tân Phú	802	active
27964	Xã Mỹ Hạnh Bắc	802	active
27967	Xã Đức Hòa Thượng	802	active
27970	Xã Hòa Khánh Tây	802	active
27973	Xã Hòa Khánh Đông	802	active
27976	Xã Mỹ Hạnh Nam	802	active
27979	Xã Hòa Khánh Nam	802	active
27982	Xã Đức Hòa Đông	802	active
27985	Xã Đức Hòa Hạ	802	active
27988	Xã Hựu Thạnh	802	active
27991	Thị trấn Bến Lức	803	active
27994	Xã Thạnh Lợi	803	active
27997	Xã Lương Bình	803	active
28000	Xã Thạnh Hòa	803	active
28003	Xã Lương Hòa	803	active
28006	Xã Tân Hòa	803	active
28009	Xã Tân Bửu	803	active
28012	Xã An Thạnh	803	active
28015	Xã Bình Đức	803	active
28018	Xã Mỹ Yên	803	active
28021	Xã Thanh Phú	803	active
28024	Xã Long Hiệp	803	active
28027	Xã Thạnh Đức	803	active
28030	Xã Phước Lợi	803	active
28033	Xã Nhựt Chánh	803	active
28036	Thị trấn Thủ Thừa	804	active
28039	Xã Long Thạnh	804	active
28042	Xã Tân Thành	804	active
28045	Xã Long Thuận	804	active
28048	Xã Mỹ Lạc	804	active
28051	Xã Mỹ Thạnh	804	active
28054	Xã Bình An	804	active
28057	Xã Nhị Thành	804	active
28060	Xã Mỹ An	804	active
28063	Xã Bình Thạnh	804	active
28066	Xã Mỹ Phú	804	active
28072	Xã Tân Long	804	active
28075	Thị trấn Tân Trụ	805	active
28078	Xã Tân Bình	805	active
28084	Xã Quê Mỹ Thạnh	805	active
28087	Xã Lạc Tấn	805	active
28090	Xã Bình Trinh Đông	805	active
28093	Xã Tân Phước Tây	805	active
28096	Xã Bình Lãng	805	active
28099	Xã Bình Tịnh	805	active
28102	Xã Đức Tân	805	active
28105	Xã Nhựt Ninh	805	active
28108	Thị trấn Cần Đước	806	active
28111	Xã Long Trạch	806	active
28114	Xã Long Khê	806	active
28117	Xã Long Định	806	active
28120	Xã Phước Vân	806	active
28123	Xã Long Hòa	806	active
28126	Xã Long Cang	806	active
28129	Xã Long Sơn	806	active
28132	Xã Tân Trạch	806	active
28135	Xã Mỹ Lệ	806	active
28138	Xã Tân Lân	806	active
28141	Xã Phước Tuy	806	active
28144	Xã Long Hựu Đông	806	active
28147	Xã Tân Ân	806	active
28150	Xã Phước Đông	806	active
28153	Xã Long Hựu Tây	806	active
28156	Xã Tân Chánh	806	active
28159	Thị trấn Cần Giuộc	807	active
28162	Xã Phước Lý	807	active
28165	Xã Long Thượng	807	active
28168	Xã Long Hậu	807	active
28174	Xã Phước Hậu	807	active
28177	Xã Mỹ Lộc	807	active
28180	Xã Phước Lại	807	active
28183	Xã Phước Lâm	807	active
28189	Xã Thuận Thành	807	active
28192	Xã Phước Vĩnh Tây	807	active
28195	Xã Phước Vĩnh Đông	807	active
28198	Xã Long An	807	active
28201	Xã Long Phụng	807	active
28204	Xã Đông Thạnh	807	active
28207	Xã Tân Tập	807	active
28210	Thị trấn Tầm Vu	808	active
28213	Xã Bình Quới	808	active
28216	Xã Hòa Phú	808	active
28219	Xã Phú Ngãi Trị	808	active
28222	Xã Vĩnh Công	808	active
28225	Xã Thuận Mỹ	808	active
28228	Xã Hiệp Thạnh	808	active
28231	Xã Phước Tân Hưng	808	active
28234	Xã Thanh Phú Long	808	active
28237	Xã Dương Xuân Hội	808	active
28240	Xã An Lục Long	808	active
28243	Xã Long Trì	808	active
28246	Xã Thanh Vĩnh Đông	808	active
28249	Phường 5	815	active
28252	Phường 4	815	active
28255	Phường 7	815	active
28258	Phường 3	815	active
28261	Phường 1	815	active
28264	Phường 2	815	active
28267	Phường 8	815	active
28270	Phường 6	815	active
28273	Phường 9	815	active
28276	Phường 10	815	active
28279	Phường Tân Long	815	active
28282	Xã Đạo Thạnh	815	active
28285	Xã Trung An	815	active
28288	Xã Mỹ Phong	815	active
28291	Xã Tân Mỹ Chánh	815	active
28567	Xã Phước Thạnh	815	active
28591	Xã Thới Sơn	815	active
28294	Phường 3	816	active
28297	Phường 2	816	active
28300	Phường 4	816	active
28303	Phường 1	816	active
28306	Phường 5	816	active
28309	Xã Long Hưng	816	active
28312	Xã Long Thuận	816	active
28315	Xã Long Chánh	816	active
28318	Xã Long Hòa	816	active
28708	Xã Bình Đông	816	active
28717	Xã Bình Xuân	816	active
28729	Xã Tân Trung	816	active
28435	Phường 1	817	active
28436	Phường 2	817	active
28437	Phường 3	817	active
28439	Phường 4	817	active
28440	Phường 5	817	active
28447	Xã Mỹ Phước Tây	817	active
28450	Xã Mỹ Hạnh Đông	817	active
28453	Xã Mỹ Hạnh Trung	817	active
28459	Xã Tân Phú	817	active
28462	Xã Tân Bình	817	active
28468	Xã Tân Hội	817	active
28474	Phường Nhị Mỹ	817	active
28477	Xã Nhị Quý	817	active
28480	Xã Thanh Hòa	817	active
28483	Xã Phú Quý	817	active
28486	Xã Long Khánh	817	active
28321	Thị trấn Mỹ Phước	818	active
28324	Xã Tân Hòa Đông	818	active
28327	Xã Thạnh Tân	818	active
28330	Xã Thạnh Mỹ	818	active
28333	Xã Thạnh Hoà	818	active
28336	Xã Phú Mỹ	818	active
28339	Xã Tân Hòa Thành	818	active
28342	Xã Hưng Thạnh	818	active
28345	Xã Tân Lập 1	818	active
28348	Xã Tân Hòa Tây	818	active
28354	Xã Tân Lập 2	818	active
28357	Xã Phước Lập	818	active
28360	Thị trấn Cái Bè	819	active
28363	Xã Hậu Mỹ Bắc B	819	active
28366	Xã Hậu Mỹ Bắc A	819	active
28369	Xã Mỹ Trung	819	active
28372	Xã Hậu Mỹ Trinh	819	active
28375	Xã Hậu Mỹ Phú	819	active
28378	Xã Mỹ Tân	819	active
28381	Xã Mỹ Lợi B	819	active
28384	Xã Thiện Trung	819	active
28387	Xã Mỹ Hội	819	active
28390	Xã An Cư	819	active
28393	Xã Hậu Thành	819	active
28396	Xã Mỹ Lợi A	819	active
28399	Xã Hòa Khánh	819	active
28402	Xã Thiện Trí	819	active
28405	Xã Mỹ Đức Đông	819	active
28408	Xã Mỹ Đức Tây	819	active
28411	Xã Đông Hòa Hiệp	819	active
28414	Xã An Thái Đông	819	active
28417	Xã Tân Hưng	819	active
28420	Xã Mỹ Lương	819	active
28423	Xã Tân Thanh	819	active
28426	Xã An Thái Trung	819	active
28429	Xã An Hữu	819	active
28432	Xã Hòa Hưng	819	active
28438	Xã Thạnh Lộc	820	active
28441	Xã Mỹ Thành Bắc	820	active
28444	Xã Phú Cường	820	active
28456	Xã Mỹ Thành Nam	820	active
28465	Xã Phú Nhuận	820	active
28471	Xã Bình Phú	820	active
28489	Xã Cẩm Sơn	820	active
28492	Xã Phú An	820	active
28495	Xã Mỹ Long	820	active
28498	Xã Long Tiên	820	active
28501	Xã Hiệp Đức	820	active
28504	Xã Long Trung	820	active
28507	Xã Hội Xuân	820	active
28510	Xã Tân Phong	820	active
28513	Xã Tam Bình	820	active
28516	Xã Ngũ Hiệp	820	active
28519	Thị trấn Tân Hiệp	821	active
28522	Xã Tân Hội Đông	821	active
28525	Xã Tân Hương	821	active
28528	Xã Tân Lý Đông	821	active
28531	Xã Tân Lý Tây	821	active
28534	Xã Thân Cửu Nghĩa	821	active
28537	Xã Tam Hiệp	821	active
28540	Xã Điềm Hy	821	active
28543	Xã Nhị Bình	821	active
28546	Xã Dưỡng Điềm	821	active
28549	Xã Đông Hòa	821	active
28552	Xã Long Định	821	active
28555	Xã Hữu Đạo	821	active
28558	Xã Long An	821	active
28561	Xã Long Hưng	821	active
28564	Xã Bình Trưng	821	active
28570	Xã Thạnh Phú	821	active
28573	Xã Bàn Long	821	active
28576	Xã Vĩnh Kim	821	active
28579	Xã Bình Đức	821	active
28582	Xã Song Thuận	821	active
28585	Xã Kim Sơn	821	active
28588	Xã Phú Phong	821	active
28594	Thị trấn Chợ Gạo	822	active
28597	Xã Trung Hòa	822	active
28600	Xã Hòa Tịnh	822	active
28603	Xã Mỹ Tịnh An	822	active
28606	Xã Tân Bình Thạnh	822	active
28609	Xã Phú Kiết	822	active
28612	Xã Lương Hòa Lạc	822	active
28615	Xã Thanh Bình	822	active
28618	Xã Quơn Long	822	active
28621	Xã Bình Phục Nhứt	822	active
28624	Xã Đăng Hưng Phước	822	active
28627	Xã Tân Thuận Bình	822	active
28630	Xã Song Bình	822	active
28633	Xã Bình Phan	822	active
28636	Xã Long Bình Điền	822	active
28639	Xã An Thạnh Thủy	822	active
28642	Xã Xuân Đông	822	active
28645	Xã Hòa Định	822	active
28648	Xã Bình Ninh	822	active
28651	Thị trấn Vĩnh Bình	823	active
28654	Xã Đồng Sơn	823	active
28657	Xã Bình Phú	823	active
28660	Xã Đồng Thạnh	823	active
28663	Xã Thành Công	823	active
28666	Xã Bình Nhì	823	active
28669	Xã Yên Luông	823	active
28672	Xã Thạnh Trị	823	active
28675	Xã Thạnh Nhựt	823	active
28678	Xã Long Vĩnh	823	active
28681	Xã Bình Tân	823	active
28684	Xã Vĩnh Hựu	823	active
28687	Xã Long Bình	823	active
28702	Thị trấn Tân Hòa	824	active
28705	Xã Tăng Hoà	824	active
28711	Xã Tân Phước	824	active
28714	Xã Gia Thuận	824	active
28720	Thị trấn Vàm Láng	824	active
28723	Xã Tân Tây	824	active
28726	Xã Kiểng Phước	824	active
28732	Xã Tân Đông	824	active
28735	Xã Bình Ân	824	active
28738	Xã Tân Điền	824	active
28741	Xã Bình Nghị	824	active
28744	Xã Phước Trung	824	active
28747	Xã Tân Thành	824	active
28690	Xã Tân Thới	825	active
28693	Xã Tân Phú	825	active
28696	Xã Phú Thạnh	825	active
28699	Xã Tân Thạnh	825	active
28750	Xã Phú Đông	825	active
28753	Xã Phú Tân	825	active
28756	Phường Phú Khương	829	active
28757	Phường Phú Tân	829	active
28759	Phường 8	829	active
28762	Phường 6	829	active
28765	Phường 4	829	active
28768	Phường 5	829	active
28777	Phường An Hội	829	active
28780	Phường 7	829	active
28783	Xã Sơn Đông	829	active
28786	Xã Phú Hưng	829	active
28789	Xã Bình Phú	829	active
28792	Xã Mỹ Thạnh An	829	active
28795	Xã Nhơn Thạnh	829	active
28798	Xã Phú Nhuận	829	active
28801	Thị trấn Châu Thành	831	active
28804	Xã Tân Thạch	831	active
28807	Xã Qưới Sơn	831	active
28810	Xã An Khánh	831	active
28813	Xã Giao Long	831	active
28819	Xã Phú Túc	831	active
28822	Xã Phú Đức	831	active
28825	Xã Phú An Hòa	831	active
28828	Xã An Phước	831	active
28831	Xã Tam Phước	831	active
28834	Xã Thành Triệu	831	active
28837	Xã Tường Đa	831	active
28840	Xã Tân Phú	831	active
28843	Xã Quới Thành	831	active
28846	Xã Phước Thạnh	831	active
28849	Xã An Hóa	831	active
28852	Xã Tiên Long	831	active
28855	Xã An Hiệp	831	active
28858	Xã Hữu Định	831	active
28861	Xã Tiên Thủy	831	active
28864	Xã Sơn Hòa	831	active
28870	Thị trấn Chợ Lách	832	active
28873	Xã Phú Phụng	832	active
28876	Xã Sơn Định	832	active
28879	Xã Vĩnh Bình	832	active
28882	Xã Hòa Nghĩa	832	active
28885	Xã Long Thới	832	active
28888	Xã Phú Sơn	832	active
28891	Xã Tân Thiềng	832	active
28894	Xã Vĩnh Thành	832	active
28897	Xã Vĩnh Hòa	832	active
28900	Xã Hưng Khánh Trung B	832	active
28903	Thị trấn Mỏ Cày	833	active
28930	Xã Định Thủy	833	active
28939	Xã Đa Phước Hội	833	active
28940	Xã Tân Hội	833	active
28942	Xã Phước Hiệp	833	active
28945	Xã Bình Khánh	833	active
28951	Xã An Thạnh	833	active
28957	Xã An Định	833	active
28960	Xã Thành Thới B	833	active
28963	Xã Tân Trung	833	active
28966	Xã An Thới	833	active
28969	Xã Thành Thới A	833	active
28972	Xã Minh Đức	833	active
28975	Xã Ngãi Đăng	833	active
28978	Xã Cẩm Sơn	833	active
28981	Xã Hương Mỹ	833	active
28984	Thị trấn Giồng Trôm	834	active
28987	Xã Phong Nẫm	834	active
28993	Xã Mỹ Thạnh	834	active
28996	Xã Châu Hòa	834	active
28999	Xã Lương Hòa	834	active
29002	Xã Lương Quới	834	active
29005	Xã Lương Phú	834	active
29008	Xã Châu Bình	834	active
29011	Xã Thuận Điền	834	active
29014	Xã Sơn Phú	834	active
29017	Xã Bình Hoà	834	active
29020	Xã Phước Long	834	active
29023	Xã Hưng Phong	834	active
29026	Xã Long Mỹ	834	active
29029	Xã Tân Hào	834	active
29032	Xã Bình Thành	834	active
29035	Xã Tân Thanh	834	active
29038	Xã Tân Lợi Thạnh	834	active
29041	Xã Thạnh Phú Đông	834	active
29044	Xã Hưng Nhượng	834	active
29047	Xã Hưng Lễ	834	active
29050	Thị trấn Bình Đại	835	active
29053	Xã Tam Hiệp	835	active
29056	Xã Long Định	835	active
29059	Xã Long Hòa	835	active
29062	Xã Phú Thuận	835	active
29065	Xã Vang Quới Tây	835	active
29068	Xã Vang Quới Đông	835	active
29071	Xã Châu Hưng	835	active
29074	Xã Phú Vang	835	active
29077	Xã Lộc Thuận	835	active
29080	Xã Định Trung	835	active
29083	Xã Thới Lai	835	active
29086	Xã Bình Thới	835	active
29089	Xã Phú Long	835	active
29092	Xã Bình Thắng	835	active
29095	Xã Thạnh Trị	835	active
29098	Xã Đại Hòa Lộc	835	active
29101	Xã Thừa Đức	835	active
29104	Xã Thạnh Phước	835	active
29107	Xã Thới Thuận	835	active
29110	Thị trấn Ba Tri	836	active
29113	Xã Tân Mỹ	836	active
29116	Xã Mỹ Hòa	836	active
29119	Xã Tân Xuân	836	active
29122	Xã Mỹ Chánh	836	active
29125	Xã Bảo Thạnh	836	active
29128	Xã An Phú Trung	836	active
29131	Xã Mỹ Thạnh	836	active
29134	Xã Mỹ Nhơn	836	active
29137	Xã Phước Ngãi	836	active
29143	Xã An Ngãi Trung	836	active
29146	Xã Phú Lễ	836	active
29149	Xã An Bình Tây	836	active
29152	Xã Bảo Thuận	836	active
29155	Xã Tân Hưng	836	active
29158	Xã An Ngãi Tây	836	active
29161	Xã An Hiệp	836	active
29164	Xã Vĩnh Hòa	836	active
29167	Xã Tân Thủy	836	active
29170	Xã Vĩnh An	836	active
29173	Xã An Đức	836	active
29176	Xã An Hòa Tây	836	active
29179	Xã An Thủy	836	active
29182	Thị trấn Thạnh Phú	837	active
29185	Xã Phú Khánh	837	active
29188	Xã Đại Điền	837	active
29191	Xã Quới Điền	837	active
29194	Xã Tân Phong	837	active
29197	Xã Mỹ Hưng	837	active
29200	Xã An Thạnh	837	active
29203	Xã Thới Thạnh	837	active
29206	Xã Hòa Lợi	837	active
29209	Xã An Điền	837	active
29212	Xã Bình Thạnh	837	active
29215	Xã An Thuận	837	active
29218	Xã An Quy	837	active
29221	Xã Thạnh Hải	837	active
29224	Xã An Nhơn	837	active
29227	Xã Giao Thạnh	837	active
29230	Xã Thạnh Phong	837	active
29233	Xã Mỹ An	837	active
28889	Xã Phú Mỹ	838	active
28901	Xã Hưng Khánh Trung A	838	active
28906	Xã Thanh Tân	838	active
28909	Xã Thạnh Ngãi	838	active
28912	Xã Tân Phú Tây	838	active
28915	Xã Phước Mỹ Trung	838	active
28918	Xã Tân Thành Bình	838	active
28921	Xã Thành An	838	active
28924	Xã Hòa Lộc	838	active
28927	Xã Tân Thanh Tây	838	active
28933	Xã Tân Bình	838	active
28936	Xã Nhuận Phú Tân	838	active
28948	Xã Khánh Thạnh Tân	838	active
29236	Phường 4	842	active
29239	Phường 1	842	active
29242	Phường 3	842	active
29245	Phường 2	842	active
29248	Phường 5	842	active
29251	Phường 6	842	active
29254	Phường 7	842	active
29257	Phường 8	842	active
29260	Phường 9	842	active
29263	Xã Long Đức	842	active
29266	Thị trấn Càng Long	844	active
29269	Xã Mỹ Cẩm	844	active
29272	Xã An Trường A	844	active
29275	Xã An Trường	844	active
29278	Xã Huyền Hội	844	active
29281	Xã Tân An	844	active
29284	Xã Tân Bình	844	active
29287	Xã Bình Phú	844	active
29290	Xã Phương Thạnh	844	active
29293	Xã Đại Phúc	844	active
29296	Xã Đại Phước	844	active
29299	Xã Nhị Long Phú	844	active
29302	Xã Nhị Long	844	active
29305	Xã Đức Mỹ	844	active
29308	Thị trấn Cầu Kè	845	active
29311	Xã Hòa Ân	845	active
29314	Xã Châu Điền	845	active
29317	Xã An Phú Tân	845	active
29320	Xã Hoà Tân	845	active
29323	Xã Ninh Thới	845	active
29326	Xã Phong Phú	845	active
29329	Xã Phong Thạnh	845	active
29332	Xã Tam Ngãi	845	active
29335	Xã Thông Hòa	845	active
29338	Xã Thạnh Phú	845	active
29341	Thị trấn Tiểu Cần	846	active
29344	Thị trấn Cầu Quan	846	active
29347	Xã Phú Cần	846	active
29350	Xã Hiếu Tử	846	active
29353	Xã Hiếu Trung	846	active
29356	Xã Long Thới	846	active
29359	Xã Hùng Hòa	846	active
29362	Xã Tân Hùng	846	active
29365	Xã Tập Ngãi	846	active
29368	Xã Ngãi Hùng	846	active
29371	Xã Tân Hòa	846	active
29374	Thị trấn Châu Thành	847	active
29377	Xã Đa Lộc	847	active
29380	Xã Mỹ Chánh	847	active
29383	Xã Thanh Mỹ	847	active
29386	Xã Lương Hoà A	847	active
29389	Xã Lương Hòa	847	active
29392	Xã Song Lộc	847	active
29395	Xã Nguyệt Hóa	847	active
29398	Xã Hòa Thuận	847	active
29401	Xã Hòa Lợi	847	active
29404	Xã Phước Hảo	847	active
29407	Xã Hưng Mỹ	847	active
29410	Xã Hòa Minh	847	active
29413	Xã Long Hòa	847	active
29416	Thị trấn Cầu Ngang	848	active
29419	Thị trấn Mỹ Long	848	active
29422	Xã Mỹ Long Bắc	848	active
29425	Xã Mỹ Long Nam	848	active
29428	Xã Mỹ Hòa	848	active
29431	Xã Vĩnh Kim	848	active
29434	Xã Kim Hòa	848	active
29437	Xã Hiệp Hòa	848	active
29440	Xã Thuận Hòa	848	active
29443	Xã Long Sơn	848	active
29446	Xã Nhị Trường	848	active
29449	Xã Trường Thọ	848	active
29452	Xã Hiệp Mỹ Đông	848	active
29455	Xã Hiệp Mỹ Tây	848	active
29458	Xã Thạnh Hòa Sơn	848	active
29461	Thị trấn Trà Cú	849	active
29462	Thị trấn Định An	849	active
29464	Xã Phước Hưng	849	active
29467	Xã Tập Sơn	849	active
29470	Xã Tân Sơn	849	active
29473	Xã An Quảng Hữu	849	active
29476	Xã Lưu Nghiệp Anh	849	active
29479	Xã Ngãi Xuyên	849	active
29482	Xã Kim Sơn	849	active
29485	Xã Thanh Sơn	849	active
29488	Xã Hàm Giang	849	active
29489	Xã Hàm Tân	849	active
29491	Xã Đại An	849	active
29494	Xã Định An	849	active
29503	Xã Ngọc Biên	849	active
29506	Xã Long Hiệp	849	active
29509	Xã Tân Hiệp	849	active
29497	Xã Đôn Xuân	850	active
29500	Xã Đôn Châu	850	active
29513	Thị trấn Long Thành	850	active
29521	Xã Long Khánh	850	active
29530	Xã Ngũ Lạc	850	active
29533	Xã Long Vĩnh	850	active
29536	Xã Đông Hải	850	active
29512	Phường 1	851	active
29515	Xã Long Toàn	851	active
29516	Phường 2	851	active
29518	Xã Long Hữu	851	active
29524	Xã Dân Thành	851	active
29527	Xã Trường Long Hòa	851	active
29539	Xã Hiệp Thạnh	851	active
29542	Phường 9	855	active
29545	Phường 5	855	active
29548	Phường 1	855	active
29551	Phường 2	855	active
29554	Phường 4	855	active
29557	Phường 3	855	active
29560	Phường 8	855	active
29563	Phường Tân Ngãi	855	active
29566	Phường Tân Hòa	855	active
29569	Phường Tân Hội	855	active
29572	Phường Trường An	855	active
29575	Thị trấn Long Hồ	857	active
29578	Xã Đồng Phú	857	active
29581	Xã Bình Hòa Phước	857	active
29584	Xã Hòa Ninh	857	active
29587	Xã An Bình	857	active
29590	Xã Thanh Đức	857	active
29593	Xã Tân Hạnh	857	active
29596	Xã Phước Hậu	857	active
29599	Xã Long Phước	857	active
29602	Xã Phú Đức	857	active
29605	Xã Lộc Hòa	857	active
29608	Xã Long An	857	active
29611	Xã Phú Quới	857	active
29614	Xã Thạnh Quới	857	active
29617	Xã Hòa Phú	857	active
29623	Xã Mỹ An	858	active
29626	Xã Mỹ Phước	858	active
29629	Xã An Phước	858	active
29632	Xã Nhơn Phú	858	active
29635	Xã Long Mỹ	858	active
29638	Xã Hòa Tịnh	858	active
29641	Thị trấn Cái Nhum	858	active
29644	Xã Bình Phước	858	active
29647	Xã Chánh An	858	active
29650	Xã Tân An Hội	858	active
29653	Xã Tân Long	858	active
29656	Xã Tân Long Hội	858	active
29659	Thị trấn Vũng Liêm	859	active
29662	Xã Tân Quới Trung	859	active
29665	Xã Quới Thiện	859	active
29668	Xã Quới An	859	active
29671	Xã Trung Chánh	859	active
29674	Xã Tân An Luông	859	active
29677	Xã Thanh Bình	859	active
29680	Xã Trung Thành Tây	859	active
29683	Xã Trung Hiệp	859	active
29686	Xã Hiếu Phụng	859	active
29689	Xã Trung Thành Đông	859	active
29692	Xã Trung Thành	859	active
29695	Xã Trung Hiếu	859	active
29698	Xã Trung Ngãi	859	active
29701	Xã Hiếu Thuận	859	active
29704	Xã Trung Nghĩa	859	active
29707	Xã Trung An	859	active
29710	Xã Hiếu Nhơn	859	active
29713	Xã Hiếu Thành	859	active
29716	Xã Hiếu Nghĩa	859	active
29719	Thị trấn Tam Bình	860	active
29722	Xã Tân Lộc	860	active
29725	Xã Phú Thịnh	860	active
29728	Xã Hậu Lộc	860	active
29731	Xã Hòa Thạnh	860	active
29734	Xã Hoà Lộc	860	active
29737	Xã Phú Lộc	860	active
29740	Xã Song Phú	860	active
29743	Xã Hòa Hiệp	860	active
29746	Xã Mỹ Lộc	860	active
29749	Xã Tân Phú	860	active
29752	Xã Long Phú	860	active
29755	Xã Mỹ Thạnh Trung	860	active
29758	Xã Tường Lộc	860	active
29761	Xã Loan Mỹ	860	active
29764	Xã Ngãi Tứ	860	active
29767	Xã Bình Ninh	860	active
29770	Phường Cái Vồn	861	active
29771	Phường Thành Phước	861	active
29806	Xã Thuận An	861	active
29809	Xã Đông Thạnh	861	active
29812	Xã Đông Bình	861	active
29813	Phường Đông Thuận	861	active
29815	Xã Mỹ Hòa	861	active
29818	Xã Đông Thành	861	active
29821	Thị trấn Trà Ôn	862	active
29824	Xã Xuân Hiệp	862	active
29827	Xã Nhơn Bình	862	active
29830	Xã Hòa Bình	862	active
29833	Xã Thới Hòa	862	active
29836	Xã Trà Côn	862	active
29839	Xã Tân Mỹ	862	active
29842	Xã Hựu Thành	862	active
29845	Xã Vĩnh Xuân	862	active
29848	Xã Thuận Thới	862	active
29851	Xã Phú Thành	862	active
29854	Xã Thiện Mỹ	862	active
29857	Xã Lục Sỹ Thành	862	active
29860	Xã Tích Thiện	862	active
29773	Xã Tân Hưng	863	active
29776	Xã Tân Thành	863	active
29779	Xã Thành Trung	863	active
29782	Xã Tân An Thạnh	863	active
29785	Xã Tân Lược	863	active
29788	Xã Nguyễn Văn Thảnh	863	active
29791	Xã Thành Lợi	863	active
29794	Xã Mỹ Thuận	863	active
29797	Xã Tân Bình	863	active
29800	Thị trấn Tân Quới	863	active
29863	Phường 11	866	active
29866	Phường 1	866	active
29869	Phường 2	866	active
29872	Phường 4	866	active
29875	Phường 3	866	active
29878	Phường 6	866	active
29881	Xã Mỹ Ngãi	866	active
29884	Xã Mỹ Tân	866	active
29887	Xã Mỹ Trà	866	active
29888	Phường Mỹ Phú	866	active
29890	Xã Tân Thuận Tây	866	active
29892	Phường Hoà Thuận	866	active
29893	Xã Hòa An	866	active
29896	Xã Tân Thuận Đông	866	active
29899	Xã Tịnh Thới	866	active
29902	Phường 3	867	active
29905	Phường 1	867	active
29908	Phường 4	867	active
29911	Phường 2	867	active
29914	Xã Tân Khánh Đông	867	active
29917	Phường Tân Quy Đông	867	active
29919	Phường An Hoà	867	active
29920	Xã Tân Quy Tây	867	active
29923	Xã Tân Phú Đông	867	active
29954	Phường An Lộc	868	active
29955	Phường An Thạnh	868	active
29959	Xã Bình Thạnh	868	active
29965	Xã Tân Hội	868	active
29978	Phường An Lạc	868	active
29986	Phường An Bình B	868	active
29989	Phường An Bình A	868	active
29926	Thị trấn Sa Rài	869	active
29929	Xã Tân Hộ Cơ	869	active
29932	Xã Thông Bình	869	active
29935	Xã Bình Phú	869	active
29938	Xã Tân Thành A	869	active
29941	Xã Tân Thành B	869	active
29944	Xã Tân Phước	869	active
29947	Xã Tân Công Chí	869	active
29950	Xã An Phước	869	active
29956	Xã Thường Phước 1	870	active
29962	Xã Thường Thới Hậu A	870	active
29971	Thị trấn Thường Thới Tiền	870	active
29974	Xã Thường Phước 2	870	active
29977	Xã Thường Lạc	870	active
29980	Xã Long Khánh A	870	active
29983	Xã Long Khánh B	870	active
29992	Xã Long Thuận	870	active
29995	Xã Phú Thuận B	870	active
29998	Xã Phú Thuận A	870	active
30001	Thị trấn Tràm Chim	871	active
30004	Xã Hoà Bình	871	active
30007	Xã Tân Công Sính	871	active
30010	Xã Phú Hiệp	871	active
30013	Xã Phú Đức	871	active
30016	Xã Phú Thành B	871	active
30019	Xã An Hòa	871	active
30022	Xã An Long	871	active
30025	Xã Phú Cường	871	active
30028	Xã Phú Ninh	871	active
30031	Xã Phú Thọ	871	active
30034	Xã Phú Thành A	871	active
30037	Thị trấn Mỹ An	872	active
30040	Xã Thạnh Lợi	872	active
30043	Xã Hưng Thạnh	872	active
30046	Xã Trường Xuân	872	active
30049	Xã Tân Kiều	872	active
30052	Xã Mỹ Hòa	872	active
30055	Xã Mỹ Quý	872	active
30058	Xã Mỹ Đông	872	active
30061	Xã Đốc Binh Kiều	872	active
30064	Xã Mỹ An	872	active
30067	Xã Phú Điền	872	active
30070	Xã Láng Biển	872	active
30073	Xã Thanh Mỹ	872	active
30076	Thị trấn Mỹ Thọ	873	active
30079	Xã Gáo Giồng	873	active
30082	Xã Phương Thịnh	873	active
30085	Xã Ba Sao	873	active
30088	Xã Phong Mỹ	873	active
30091	Xã Tân Nghĩa	873	active
30094	Xã Phương Trà	873	active
30097	Xã Nhị Mỹ	873	active
30100	Xã Mỹ Thọ	873	active
30103	Xã Tân Hội Trung	873	active
30106	Xã An Bình	873	active
30109	Xã Mỹ Hội	873	active
30112	Xã Mỹ Hiệp	873	active
30115	Xã Mỹ Long	873	active
30118	Xã Bình Hàng Trung	873	active
30121	Xã Mỹ Xương	873	active
30124	Xã Bình Hàng Tây	873	active
30127	Xã Bình Thạnh	873	active
30130	Thị trấn Thanh Bình	874	active
30133	Xã Tân Quới	874	active
30136	Xã Tân Hòa	874	active
30139	Xã An Phong	874	active
30142	Xã Phú Lợi	874	active
30145	Xã Tân Mỹ	874	active
30148	Xã Bình Tấn	874	active
30151	Xã Tân Huề	874	active
30154	Xã Tân Bình	874	active
30157	Xã Tân Thạnh	874	active
30160	Xã Tân Phú	874	active
30163	Xã Bình Thành	874	active
30166	Xã Tân Long	874	active
30169	Thị trấn Lấp Vò	875	active
30172	Xã Mỹ An Hưng A	875	active
30175	Xã Tân Mỹ	875	active
30178	Xã Mỹ An Hưng B	875	active
30181	Xã Tân Khánh Trung	875	active
30184	Xã Long Hưng A	875	active
30187	Xã Vĩnh Thạnh	875	active
30190	Xã Long Hưng B	875	active
30193	Xã Bình Thành	875	active
30196	Xã Định An	875	active
30199	Xã Định Yên	875	active
30202	Xã Hội An Đông	875	active
30205	Xã Bình Thạnh Trung	875	active
30208	Thị trấn Lai Vung	876	active
30211	Xã Tân Dương	876	active
30214	Xã Hòa Thành	876	active
30217	Xã Long Hậu	876	active
30220	Xã Tân Phước	876	active
30223	Xã Hòa Long	876	active
30226	Xã Tân Thành	876	active
30229	Xã Long Thắng	876	active
30232	Xã Vĩnh Thới	876	active
30235	Xã Tân Hòa	876	active
30238	Xã Định Hòa	876	active
30241	Xã Phong Hòa	876	active
30244	Thị trấn Cái Tàu Hạ	877	active
30247	Xã An Hiệp	877	active
30250	Xã An Nhơn	877	active
30253	Xã Tân Nhuận Đông	877	active
30256	Xã Tân Bình	877	active
30259	Xã Tân Phú Trung	877	active
30262	Xã Phú Long	877	active
30265	Xã An Phú Thuận	877	active
30268	Xã Phú Hựu	877	active
30271	Xã An Khánh	877	active
30274	Xã Tân Phú	877	active
30277	Xã Hòa Tân	877	active
30280	Phường Mỹ Bình	883	active
30283	Phường Mỹ Long	883	active
30285	Phường Đông Xuyên	883	active
30286	Phường Mỹ Xuyên	883	active
30289	Phường Bình Đức	883	active
30292	Phường Bình Khánh	883	active
30295	Phường Mỹ Phước	883	active
30298	Phường Mỹ Quý	883	active
30301	Phường Mỹ Thới	883	active
30304	Phường Mỹ Thạnh	883	active
30307	Phường Mỹ Hòa	883	active
30310	Xã Mỹ Khánh	883	active
30313	Xã Mỹ Hoà Hưng	883	active
30316	Phường Châu Phú B	884	active
30319	Phường Châu Phú A	884	active
30322	Phường Vĩnh Mỹ	884	active
30325	Phường Núi Sam	884	active
30328	Phường Vĩnh Nguơn	884	active
30331	Xã Vĩnh Tế	884	active
30334	Xã Vĩnh Châu	884	active
30337	Thị trấn An Phú	886	active
30340	Xã Khánh An	886	active
30341	Thị Trấn Long Bình	886	active
30343	Xã Khánh Bình	886	active
30346	Xã Quốc Thái	886	active
30349	Xã Nhơn Hội	886	active
30352	Xã Phú Hữu	886	active
30355	Xã Phú Hội	886	active
30358	Xã Phước Hưng	886	active
30361	Xã Vĩnh Lộc	886	active
30364	Xã Vĩnh Hậu	886	active
30367	Xã Vĩnh Trường	886	active
30370	Xã Vĩnh Hội Đông	886	active
30373	Xã Đa Phước	886	active
30376	Phường Long Thạnh	887	active
30377	Phường Long Hưng	887	active
30378	Phường Long Châu	887	active
30379	Xã Phú Lộc	887	active
30382	Xã Vĩnh Xương	887	active
30385	Xã Vĩnh Hòa	887	active
30387	Xã Tân Thạnh	887	active
30388	Xã Tân An	887	active
30391	Xã Long An	887	active
30394	Phường Long Phú	887	active
30397	Xã Châu Phong	887	active
30400	Xã Phú Vĩnh	887	active
30403	Xã Lê Chánh	887	active
30412	Phường Long Sơn	887	active
30406	Thị trấn Phú Mỹ	888	active
30409	Thị trấn Chợ Vàm	888	active
30415	Xã Long Hoà	888	active
30418	Xã Phú Long	888	active
30421	Xã Phú Lâm	888	active
30424	Xã Phú Hiệp	888	active
30427	Xã Phú Thạnh	888	active
30430	Xã Hoà Lạc	888	active
30433	Xã Phú Thành	888	active
30436	Xã Phú An	888	active
30439	Xã Phú Xuân	888	active
30442	Xã Hiệp Xương	888	active
30445	Xã Phú Bình	888	active
30448	Xã Phú Thọ	888	active
30451	Xã Phú Hưng	888	active
30454	Xã Bình Thạnh Đông	888	active
30457	Xã Tân Hòa	888	active
30460	Xã Tân Trung	888	active
30463	Thị trấn Cái Dầu	889	active
30466	Xã Khánh Hòa	889	active
30469	Xã Mỹ Đức	889	active
30472	Xã Mỹ Phú	889	active
30475	Xã Ô Long Vỹ	889	active
30478	Thị trấn Vĩnh Thạnh Trung	889	active
30481	Xã Thạnh Mỹ Tây	889	active
30484	Xã Bình Long	889	active
30487	Xã Bình Mỹ	889	active
30490	Xã Bình Thủy	889	active
30493	Xã Đào Hữu Cảnh	889	active
30496	Xã Bình Phú	889	active
30499	Xã Bình Chánh	889	active
30502	Thị trấn Nhà Bàng	890	active
30505	Thị trấn Chi Lăng	890	active
30508	Xã Núi Voi	890	active
30511	Xã Nhơn Hưng	890	active
30514	Xã An Phú	890	active
30517	Xã Thới Sơn	890	active
30520	Thị trấn Tịnh Biên	890	active
30523	Xã Văn Giáo	890	active
30526	Xã An Cư	890	active
30529	Xã An Nông	890	active
30532	Xã Vĩnh Trung	890	active
30535	Xã Tân Lợi	890	active
30538	Xã An Hảo	890	active
30541	Xã Tân Lập	890	active
30544	Thị trấn Tri Tôn	891	active
30547	Thị trấn Ba Chúc	891	active
30550	Xã Lạc Quới	891	active
30553	Xã Lê Trì	891	active
30556	Xã Vĩnh Gia	891	active
30559	Xã Vĩnh Phước	891	active
30562	Xã Châu Lăng	891	active
30565	Xã Lương Phi	891	active
30568	Xã Lương An Trà	891	active
30571	Xã Tà Đảnh	891	active
30574	Xã Núi Tô	891	active
30577	Xã An Tức	891	active
30580	Thị trấn Cô Tô	891	active
30583	Xã Tân Tuyến	891	active
30586	Xã Ô Lâm	891	active
30589	Thị trấn An Châu	892	active
30592	Xã An Hòa	892	active
30595	Xã Cần Đăng	892	active
30598	Xã Vĩnh Hanh	892	active
30601	Xã Bình Thạnh	892	active
30604	Thị trấn Vĩnh Bình	892	active
30607	Xã Bình Hòa	892	active
30610	Xã Vĩnh An	892	active
30613	Xã Hòa Bình Thạnh	892	active
30616	Xã Vĩnh Lợi	892	active
30619	Xã Vĩnh Nhuận	892	active
30622	Xã Tân Phú	892	active
30625	Xã Vĩnh Thành	892	active
30628	Thị trấn Chợ Mới	893	active
30631	Thị trấn Mỹ Luông	893	active
30634	Xã Kiến An	893	active
30637	Xã Mỹ Hội Đông	893	active
30640	Xã Long Điền A	893	active
30643	Xã Tấn Mỹ	893	active
30646	Xã Long Điền B	893	active
30649	Xã Kiến Thành	893	active
30652	Xã Mỹ Hiệp	893	active
30655	Xã Mỹ An	893	active
30658	Xã Nhơn Mỹ	893	active
30661	Xã Long Giang	893	active
30664	Xã Long Kiến	893	active
30667	Xã Bình Phước Xuân	893	active
30670	Xã An Thạnh Trung	893	active
30673	Xã Hội An	893	active
30676	Xã Hòa Bình	893	active
30679	Xã Hòa An	893	active
30682	Thị trấn Núi Sập	894	active
30685	Thị trấn Phú Hoà	894	active
30688	Thị Trấn Óc Eo	894	active
30691	Xã Tây Phú	894	active
30692	Xã An Bình	894	active
30694	Xã Vĩnh Phú	894	active
30697	Xã Vĩnh Trạch	894	active
30700	Xã Phú Thuận	894	active
30703	Xã Vĩnh Chánh	894	active
30706	Xã Định Mỹ	894	active
30709	Xã Định Thành	894	active
30712	Xã Mỹ Phú Đông	894	active
30715	Xã Vọng Đông	894	active
30718	Xã Vĩnh Khánh	894	active
30721	Xã Thoại Giang	894	active
30724	Xã Bình Thành	894	active
30727	Xã Vọng Thê	894	active
30730	Phường Vĩnh Thanh Vân	899	active
30733	Phường Vĩnh Thanh	899	active
30736	Phường Vĩnh Quang	899	active
30739	Phường Vĩnh Hiệp	899	active
30742	Phường Vĩnh Bảo	899	active
30745	Phường Vĩnh Lạc	899	active
30748	Phường An Hòa	899	active
30751	Phường An Bình	899	active
30754	Phường Rạch Sỏi	899	active
30757	Phường Vĩnh Lợi	899	active
30760	Phường Vĩnh Thông	899	active
30763	Xã Phi Thông	899	active
30766	Phường Tô Châu	900	active
30769	Phường Đông Hồ	900	active
30772	Phường Bình San	900	active
30775	Phường Pháo Đài	900	active
30778	Phường Mỹ Đức	900	active
30781	Xã Tiên Hải	900	active
30784	Xã Thuận Yên	900	active
30787	Thị trấn Kiên Lương	902	active
30790	Xã Kiên Bình	902	active
30802	Xã Hòa Điền	902	active
30805	Xã Dương Hòa	902	active
30808	Xã Bình An	902	active
30809	Xã Bình Trị	902	active
30811	Xã Sơn Hải	902	active
30814	Xã Hòn Nghệ	902	active
30817	Thị trấn Hòn Đất	903	active
30820	Thị trấn Sóc Sơn	903	active
30823	Xã Bình Sơn	903	active
30826	Xã Bình Giang	903	active
30828	Xã Mỹ Thái	903	active
30829	Xã Nam Thái Sơn	903	active
30832	Xã Mỹ Hiệp Sơn	903	active
30835	Xã Sơn Kiên	903	active
30836	Xã Sơn Bình	903	active
30838	Xã Mỹ Thuận	903	active
30840	Xã Lình Huỳnh	903	active
30841	Xã Thổ Sơn	903	active
30844	Xã Mỹ Lâm	903	active
30847	Xã Mỹ Phước	903	active
30850	Thị trấn Tân Hiệp	904	active
30853	Xã Tân Hội	904	active
30856	Xã Tân Thành	904	active
30859	Xã Tân Hiệp B	904	active
30860	Xã Tân Hoà	904	active
30862	Xã Thạnh Đông B	904	active
30865	Xã Thạnh Đông	904	active
30868	Xã Tân Hiệp A	904	active
30871	Xã Tân An	904	active
30874	Xã Thạnh Đông A	904	active
30877	Xã Thạnh Trị	904	active
30880	Thị trấn Minh Lương	905	active
30883	Xã Mong Thọ A	905	active
30886	Xã Mong Thọ B	905	active
30887	Xã Mong Thọ	905	active
30889	Xã Giục Tượng	905	active
30892	Xã Vĩnh Hòa Hiệp	905	active
30893	Xã Vĩnh Hoà Phú	905	active
30895	Xã Minh Hòa	905	active
30898	Xã Bình An	905	active
30901	Xã Thạnh Lộc	905	active
30904	Thị Trấn Giồng Riềng	906	active
30907	Xã Thạnh Hưng	906	active
30910	Xã Thạnh Phước	906	active
30913	Xã Thạnh Lộc	906	active
30916	Xã Thạnh Hòa	906	active
30917	Xã Thạnh Bình	906	active
30919	Xã Bàn Thạch	906	active
30922	Xã Bàn Tân Định	906	active
30925	Xã Ngọc Thành	906	active
30928	Xã Ngọc Chúc	906	active
30931	Xã Ngọc Thuận	906	active
30934	Xã Hòa Hưng	906	active
30937	Xã Hoà Lợi	906	active
30940	Xã Hoà An	906	active
30943	Xã Long Thạnh	906	active
30946	Xã Vĩnh Thạnh	906	active
30947	Xã Vĩnh Phú	906	active
30949	Xã Hòa Thuận	906	active
30950	Xã Ngọc Hoà	906	active
30952	Thị trấn Gò Quao	907	active
30955	Xã Vĩnh Hòa Hưng Bắc	907	active
30958	Xã Định Hòa	907	active
30961	Xã Thới Quản	907	active
30964	Xã Định An	907	active
30967	Xã Thủy Liễu	907	active
30970	Xã Vĩnh Hòa Hưng Nam	907	active
30973	Xã Vĩnh Phước A	907	active
30976	Xã Vĩnh Phước B	907	active
30979	Xã Vĩnh Tuy	907	active
30982	Xã Vĩnh Thắng	907	active
30985	Thị trấn Thứ Ba	908	active
30988	Xã Tây Yên	908	active
30991	Xã Tây Yên A	908	active
30994	Xã Nam Yên	908	active
30997	Xã Hưng Yên	908	active
31000	Xã Nam Thái	908	active
31003	Xã Nam Thái A	908	active
31006	Xã Đông Thái	908	active
31009	Xã Đông Yên	908	active
31018	Thị trấn Thứ Mười Một	909	active
31021	Xã Thuận Hoà	909	active
31024	Xã Đông Hòa	909	active
31030	Xã Đông Thạnh	909	active
31031	Xã Tân Thạnh	909	active
31033	Xã Đông Hưng	909	active
31036	Xã Đông Hưng A	909	active
31039	Xã Đông Hưng B	909	active
31042	Xã Vân Khánh	909	active
31045	Xã Vân Khánh Đông	909	active
31048	Xã Vân Khánh Tây	909	active
31051	Thị trấn Vĩnh Thuận	910	active
31060	Xã Vĩnh Bình Bắc	910	active
31063	Xã Vĩnh Bình Nam	910	active
31064	Xã Bình Minh	910	active
31069	Xã Vĩnh Thuận	910	active
31072	Xã Tân Thuận	910	active
31074	Xã Phong Đông	910	active
31075	Xã Vĩnh Phong	910	active
31078	Phường Dương Đông	911	active
31081	Phường An Thới	911	active
31084	Xã Cửa Cạn	911	active
31087	Xã Gành Dầu	911	active
31090	Xã Cửa Dương	911	active
31093	Xã Hàm Ninh	911	active
31096	Xã Dương Tơ	911	active
31102	Xã Bãi Thơm	911	active
31105	Xã Thổ Châu	911	active
31108	Xã Hòn Tre	912	active
31111	Xã Lại Sơn	912	active
31114	Xã An Sơn	912	active
31115	Xã Nam Du	912	active
31012	Xã Thạnh Yên	913	active
31015	Xã Thạnh Yên A	913	active
31027	Xã An Minh Bắc	913	active
31054	Xã Vĩnh Hòa	913	active
31057	Xã Hoà Chánh	913	active
31066	Xã Minh Thuận	913	active
30791	Xã Vĩnh Phú	914	active
30793	Xã Vĩnh Điều	914	active
30796	Xã Tân Khánh Hòa	914	active
30797	Xã Phú Lợi	914	active
30799	Xã Phú Mỹ	914	active
31117	Phường Cái Khế	916	active
31120	Phường An Hòa	916	active
31123	Phường Thới Bình	916	active
31126	Phường An Nghiệp	916	active
31129	Phường An Cư	916	active
31135	Phường Tân An	916	active
31141	Phường An Phú	916	active
31144	Phường Xuân Khánh	916	active
31147	Phường Hưng Lợi	916	active
31149	Phường An Khánh	916	active
31150	Phường An Bình	916	active
31153	Phường Châu Văn Liêm	917	active
31154	Phường Thới Hòa	917	active
31156	Phường Thới Long	917	active
31157	Phường Long Hưng	917	active
31159	Phường Thới An	917	active
31162	Phường Phước Thới	917	active
31165	Phường Trường Lạc	917	active
31168	Phường Bình Thủy	918	active
31169	Phường Trà An	918	active
31171	Phường Trà Nóc	918	active
31174	Phường Thới An Đông	918	active
31177	Phường An Thới	918	active
31178	Phường Bùi Hữu Nghĩa	918	active
31180	Phường Long Hòa	918	active
31183	Phường Long Tuyền	918	active
31186	Phường Lê Bình	919	active
31189	Phường Hưng Phú	919	active
31192	Phường Hưng Thạnh	919	active
31195	Phường Ba Láng	919	active
31198	Phường Thường Thạnh	919	active
31201	Phường Phú Thứ	919	active
31204	Phường Tân Phú	919	active
31207	Phường Thốt Nốt	923	active
31210	Phường Thới Thuận	923	active
31212	Phường Thuận An	923	active
31213	Phường Tân Lộc	923	active
31216	Phường Trung Nhứt	923	active
31217	Phường Thạnh Hoà	923	active
31219	Phường Trung Kiên	923	active
31227	Phường Tân Hưng	923	active
31228	Phường Thuận Hưng	923	active
31211	Xã Vĩnh Bình	924	active
31231	Thị trấn Thanh An	924	active
31232	Thị trấn Vĩnh Thạnh	924	active
31234	Xã Thạnh Mỹ	924	active
31237	Xã Vĩnh Trinh	924	active
31240	Xã Thạnh An	924	active
31241	Xã Thạnh Tiến	924	active
31243	Xã Thạnh Thắng	924	active
31244	Xã Thạnh Lợi	924	active
31246	Xã Thạnh Qưới	924	active
31252	Xã Thạnh Lộc	924	active
31222	Xã Trung An	925	active
31225	Xã Trung Thạnh	925	active
31249	Xã Thạnh Phú	925	active
31255	Xã Trung Hưng	925	active
31261	Thị trấn Cờ Đỏ	925	active
31264	Xã Thới Hưng	925	active
31273	Xã Đông Hiệp	925	active
31274	Xã Đông Thắng	925	active
31276	Xã Thới Đông	925	active
31277	Xã Thới Xuân	925	active
31299	Thị trấn Phong Điền	926	active
31300	Xã Nhơn Ái	926	active
31303	Xã Giai Xuân	926	active
31306	Xã Tân Thới	926	active
31309	Xã Trường Long	926	active
31312	Xã Mỹ Khánh	926	active
31315	Xã Nhơn Nghĩa	926	active
31258	Thị trấn Thới Lai	927	active
31267	Xã Thới Thạnh	927	active
31268	Xã Tân Thạnh	927	active
31270	Xã Xuân Thắng	927	active
31279	Xã Đông Bình	927	active
31282	Xã Đông Thuận	927	active
31285	Xã Thới Tân	927	active
31286	Xã Trường Thắng	927	active
31288	Xã Định Môn	927	active
31291	Xã Trường Thành	927	active
31294	Xã Trường Xuân	927	active
31297	Xã Trường Xuân A	927	active
31298	Xã Trường Xuân B	927	active
31318	Phường I	930	active
31321	Phường III	930	active
31324	Phường IV	930	active
31327	Phường V	930	active
31330	Phường VII	930	active
31333	Xã Vị Tân	930	active
31336	Xã Hoả Lựu	930	active
31338	Xã Tân Tiến	930	active
31339	Xã Hoả Tiến	930	active
31340	Phường Ngã Bảy	931	active
31341	Phường Lái Hiếu	931	active
31343	Phường Hiệp Thành	931	active
31344	Phường Hiệp Lợi	931	active
31411	Xã Đại Thành	931	active
31414	Xã Tân Thành	931	active
31342	Thị trấn Một Ngàn	932	active
31345	Xã Tân Hoà	932	active
31346	Thị trấn Bảy Ngàn	932	active
31348	Xã Trường Long Tây	932	active
31351	Xã Trường Long A	932	active
31357	Xã Nhơn Nghĩa A	932	active
31359	Thị trấn Rạch Gòi	932	active
31360	Xã Thạnh Xuân	932	active
31362	Thị trấn Cái Tắc	932	active
31363	Xã Tân Phú Thạnh	932	active
31366	Thị Trấn Ngã Sáu	933	active
31369	Xã Đông Thạnh	933	active
31375	Xã Đông Phú	933	active
31378	Xã Phú Hữu	933	active
31379	Xã Phú Tân	933	active
31381	Thị trấn Mái Dầm	933	active
31384	Xã Đông Phước	933	active
31387	Xã Đông Phước A	933	active
31393	Thị trấn Kinh Cùng	934	active
31396	Thị trấn Cây Dương	934	active
31399	Xã Tân Bình	934	active
31402	Xã Bình Thành	934	active
31405	Xã Thạnh Hòa	934	active
31408	Xã Long Thạnh	934	active
31417	Xã Phụng Hiệp	934	active
31420	Xã Hòa Mỹ	934	active
31423	Xã Hòa An	934	active
31426	Xã Phương Bình	934	active
31429	Xã Hiệp Hưng	934	active
31432	Xã Tân Phước Hưng	934	active
31433	Thị trấn Búng Tàu	934	active
31435	Xã Phương Phú	934	active
31438	Xã Tân Long	934	active
31441	Thị trấn Nàng Mau	935	active
31444	Xã Vị Trung	935	active
31447	Xã Vị Thuỷ	935	active
31450	Xã Vị Thắng	935	active
31453	Xã Vĩnh Thuận Tây	935	active
31456	Xã Vĩnh Trung	935	active
31459	Xã Vĩnh Tường	935	active
31462	Xã Vị Đông	935	active
31465	Xã Vị Thanh	935	active
31468	Xã Vị Bình	935	active
31483	Xã Thuận Hưng	936	active
31484	Xã Thuận Hòa	936	active
31486	Xã Vĩnh Thuận Đông	936	active
31489	Thị trấn Vĩnh Viễn	936	active
31490	Xã Vĩnh Viễn A	936	active
31492	Xã Lương Tâm	936	active
31493	Xã Lương Nghĩa	936	active
31495	Xã Xà Phiên	936	active
31471	Phường Thuận An	937	active
31472	Phường Trà Lồng	937	active
31473	Phường Bình Thạnh	937	active
31474	Xã Long Bình	937	active
31475	Phường Vĩnh Tường	937	active
31477	Xã Long Trị	937	active
31478	Xã Long Trị A	937	active
31480	Xã Long Phú	937	active
31481	Xã Tân Phú	937	active
31498	Phường 5	941	active
31501	Phường 7	941	active
31504	Phường 8	941	active
31507	Phường 6	941	active
31510	Phường 2	941	active
31513	Phường 1	941	active
31516	Phường 4	941	active
31519	Phường 3	941	active
31522	Phường 9	941	active
31525	Phường 10	941	active
31569	Thị trấn Châu Thành	942	active
31570	Xã Hồ Đắc Kiện	942	active
31573	Xã Phú Tâm	942	active
31576	Xã Thuận Hòa	942	active
31582	Xã Phú Tân	942	active
31585	Xã Thiện Mỹ	942	active
31594	Xã An Hiệp	942	active
31600	Xã An Ninh	942	active
31528	Thị trấn Kế Sách	943	active
31531	Thị trấn An Lạc Thôn	943	active
31534	Xã Xuân Hòa	943	active
31537	Xã Phong Nẫm	943	active
31540	Xã An Lạc Tây	943	active
31543	Xã Trinh Phú	943	active
31546	Xã Ba Trinh	943	active
31549	Xã Thới An Hội	943	active
31552	Xã Nhơn Mỹ	943	active
31555	Xã Kế Thành	943	active
31558	Xã Kế An	943	active
31561	Xã Đại Hải	943	active
31564	Xã An Mỹ	943	active
31567	Thị trấn Huỳnh Hữu Nghĩa	944	active
31579	Xã Long Hưng	944	active
31588	Xã Hưng Phú	944	active
31591	Xã Mỹ Hương	944	active
31597	Xã Mỹ Tú	944	active
31603	Xã Mỹ Phước	944	active
31606	Xã Thuận Hưng	944	active
31609	Xã Mỹ Thuận	944	active
31612	Xã Phú Mỹ	944	active
31615	Thị trấn Cù Lao Dung	945	active
31618	Xã An Thạnh 1	945	active
31621	Xã An Thạnh Tây	945	active
31624	Xã An Thạnh Đông	945	active
31627	Xã Đại Ân 1	945	active
31630	Xã An Thạnh 2	945	active
31633	Xã An Thạnh 3	945	active
31636	Xã An Thạnh Nam	945	active
31639	Thị trấn Long Phú	946	active
31642	Xã Song Phụng	946	active
31645	Thị trấn Đại Ngãi	946	active
31648	Xã Hậu Thạnh	946	active
31651	Xã Long Đức	946	active
31654	Xã Trường Khánh	946	active
31657	Xã Phú Hữu	946	active
31660	Xã Tân Hưng	946	active
31663	Xã Châu Khánh	946	active
31666	Xã Tân Thạnh	946	active
31669	Xã Long Phú	946	active
31684	Thị trấn Mỹ Xuyên	947	active
31690	Xã Đại Tâm	947	active
31693	Xã Tham Đôn	947	active
31708	Xã Thạnh Phú	947	active
31711	Xã Ngọc Đông	947	active
31714	Xã Thạnh Quới	947	active
31717	Xã Hòa Tú 1	947	active
31720	Xã Gia Hòa 1	947	active
31723	Xã Ngọc Tố	947	active
31726	Xã Gia Hòa 2	947	active
31729	Xã Hòa Tú II	947	active
31732	Phường 1	948	active
31735	Phường 2	948	active
31738	Xã Vĩnh Quới	948	active
31741	Xã Tân Long	948	active
31744	Xã Long Bình	948	active
31747	Phường 3	948	active
31750	Xã Mỹ Bình	948	active
31753	Xã Mỹ Quới	948	active
31756	Thị trấn Phú Lộc	949	active
31757	Thị trấn Hưng Lợi	949	active
31759	Xã Lâm Tân	949	active
31762	Xã Thạnh Tân	949	active
31765	Xã Lâm Kiết	949	active
31768	Xã Tuân Tức	949	active
31771	Xã Vĩnh Thành	949	active
31774	Xã Thạnh Trị	949	active
31777	Xã Vĩnh Lợi	949	active
31780	Xã Châu Hưng	949	active
31783	Phường 1	950	active
31786	Xã Hòa Đông	950	active
31789	Phường Khánh Hòa	950	active
31792	Xã Vĩnh Hiệp	950	active
31795	Xã Vĩnh Hải	950	active
31798	Xã Lạc Hòa	950	active
31801	Phường 2	950	active
31804	Phường Vĩnh Phước	950	active
31807	Xã Vĩnh Tân	950	active
31810	Xã Lai Hòa	950	active
31672	Xã Đại Ân 2	951	active
31673	Thị trấn Trần Đề	951	active
31675	Xã Liêu Tú	951	active
31678	Xã Lịch Hội Thượng	951	active
31679	Thị trấn Lịch Hội Thượng	951	active
31681	Xã Trung Bình	951	active
31687	Xã Tài Văn	951	active
31696	Xã Viên An	951	active
31699	Xã Thạnh Thới An	951	active
31702	Xã Thạnh Thới Thuận	951	active
31705	Xã Viên Bình	951	active
31813	Phường 2	954	active
31816	Phường 3	954	active
31819	Phường 5	954	active
31822	Phường 7	954	active
31825	Phường 1	954	active
31828	Phường 8	954	active
31831	Phường Nhà Mát	954	active
31834	Xã Vĩnh Trạch	954	active
31837	Xã Vĩnh Trạch Đông	954	active
31840	Xã Hiệp Thành	954	active
31843	Thị trấn Ngan Dừa	956	active
31846	Xã Ninh Quới	956	active
31849	Xã Ninh Quới A	956	active
31852	Xã Ninh Hòa	956	active
31855	Xã Lộc Ninh	956	active
31858	Xã Vĩnh Lộc	956	active
31861	Xã Vĩnh Lộc A	956	active
31863	Xã Ninh Thạnh Lợi A	956	active
31864	Xã Ninh Thạnh Lợi	956	active
31867	Thị trấn Phước Long	957	active
31870	Xã Vĩnh Phú Đông	957	active
31873	Xã Vĩnh Phú Tây	957	active
31876	Xã Phước Long	957	active
31879	Xã Hưng Phú	957	active
31882	Xã Vĩnh Thanh	957	active
31885	Xã Phong Thạnh Tây A	957	active
31888	Xã Phong Thạnh Tây B	957	active
31894	Xã Vĩnh Hưng	958	active
31897	Xã Vĩnh Hưng A	958	active
31900	Thị trấn Châu Hưng	958	active
31903	Xã Châu Hưng A	958	active
31906	Xã Hưng Thành	958	active
31909	Xã Hưng Hội	958	active
31912	Xã Châu Thới	958	active
31921	Xã Long Thạnh	958	active
31942	Phường 1	959	active
31945	Phường Hộ Phòng	959	active
31948	Xã Phong Thạnh Đông	959	active
31951	Phường Láng Tròn	959	active
31954	Xã Phong Tân	959	active
31957	Xã Tân Phong	959	active
31960	Xã Phong Thạnh	959	active
31963	Xã Phong Thạnh A	959	active
31966	Xã Phong Thạnh Tây	959	active
31969	Xã Tân Thạnh	959	active
31972	Thị trấn Gành Hào	960	active
31975	Xã Long Điền Đông	960	active
31978	Xã Long Điền Đông A	960	active
31981	Xã Long Điền	960	active
31984	Xã Long Điền Tây	960	active
31985	Xã Điền Hải	960	active
31987	Xã An Trạch	960	active
31988	Xã An Trạch A	960	active
31990	Xã An Phúc	960	active
31993	Xã Định Thành	960	active
31996	Xã Định Thành A	960	active
31891	Thị trấn Hòa Bình	961	active
31915	Xã Minh Diệu	961	active
31918	Xã Vĩnh Bình	961	active
31924	Xã Vĩnh Mỹ B	961	active
31927	Xã Vĩnh Hậu	961	active
31930	Xã Vĩnh Hậu A	961	active
31933	Xã Vĩnh Mỹ A	961	active
31936	Xã Vĩnh Thịnh	961	active
31999	Phường 9	964	active
32002	Phường 4	964	active
32005	Phường 1	964	active
32008	Phường 5	964	active
32011	Phường 2	964	active
32014	Phường 8	964	active
32017	Phường 6	964	active
32020	Phường 7	964	active
32022	Phường Tân Xuyên	964	active
32023	Xã An Xuyên	964	active
32025	Phường Tân Thành	964	active
32026	Xã Tân Thành	964	active
32029	Xã Tắc Vân	964	active
32032	Xã Lý Văn Lâm	964	active
32035	Xã Định Bình	964	active
32038	Xã Hòa Thành	964	active
32041	Xã Hòa Tân	964	active
32044	Thị trấn U Minh	966	active
32047	Xã Khánh Hòa	966	active
32048	Xã Khánh Thuận	966	active
32050	Xã Khánh Tiến	966	active
32053	Xã Nguyễn Phích	966	active
32056	Xã Khánh Lâm	966	active
32059	Xã Khánh An	966	active
32062	Xã Khánh Hội	966	active
32065	Thị trấn Thới Bình	967	active
32068	Xã Biển Bạch	967	active
32069	Xã Tân Bằng	967	active
32071	Xã Trí Phải	967	active
32072	Xã Trí Lực	967	active
32074	Xã Biển Bạch Đông	967	active
32077	Xã Thới Bình	967	active
32080	Xã Tân Phú	967	active
32083	Xã Tân Lộc Bắc	967	active
32086	Xã Tân Lộc	967	active
32089	Xã Tân Lộc Đông	967	active
32092	Xã Hồ Thị Kỷ	967	active
32095	Thị trấn Trần Văn Thời	968	active
32098	Thị trấn Sông Đốc	968	active
32101	Xã Khánh Bình Tây Bắc	968	active
32104	Xã Khánh Bình Tây	968	active
32107	Xã Trần Hợi	968	active
32108	Xã Khánh Lộc	968	active
32110	Xã Khánh Bình	968	active
32113	Xã Khánh Hưng	968	active
32116	Xã Khánh Bình Đông	968	active
32119	Xã Khánh Hải	968	active
32122	Xã Lợi An	968	active
32124	Xã Phong Điền	968	active
32125	Xã Phong Lạc	968	active
32128	Thị trấn Cái Nước	969	active
32130	Xã Thạnh Phú	969	active
32131	Xã Lương Thế Trân	969	active
32134	Xã Phú Hưng	969	active
32137	Xã Tân Hưng	969	active
32140	Xã Hưng Mỹ	969	active
32141	Xã Hoà Mỹ	969	active
32142	Xã Đông Hưng	969	active
32143	Xã Đông Thới	969	active
32146	Xã Tân Hưng Đông	969	active
32149	Xã Trần Thới	969	active
32152	Thị trấn Đầm Dơi	970	active
32155	Xã Tạ An Khương	970	active
32158	Xã Tạ An Khương Đông	970	active
32161	Xã Trần Phán	970	active
32162	Xã Tân Trung	970	active
32164	Xã Tân Đức	970	active
32167	Xã Tân Thuận	970	active
32170	Xã Tạ An Khương Nam	970	active
32173	Xã Tân Duyệt	970	active
32174	Xã Tân Dân	970	active
32176	Xã Tân Tiến	970	active
32179	Xã Quách Phẩm Bắc	970	active
32182	Xã Quách Phẩm	970	active
32185	Xã Thanh Tùng	970	active
32186	Xã Ngọc Chánh	970	active
32188	Xã Nguyễn Huân	970	active
32191	Thị Trấn Năm Căn	971	active
32194	Xã Hàm Rồng	971	active
32197	Xã Hiệp Tùng	971	active
32200	Xã Đất Mới	971	active
32201	Xã Lâm Hải	971	active
32203	Xã Hàng Vịnh	971	active
32206	Xã Tam Giang	971	active
32209	Xã Tam Giang Đông	971	active
32212	Thị trấn Cái Đôi Vàm	972	active
32214	Xã Phú Thuận	972	active
32215	Xã Phú Mỹ	972	active
32218	Xã Phú Tân	972	active
32221	Xã Tân Hải	972	active
32224	Xã Việt Thắng	972	active
32227	Xã Tân Hưng Tây	972	active
32228	Xã Rạch Chèo	972	active
32230	Xã Nguyễn Việt Khái	972	active
32233	Xã Tam Giang Tây	973	active
32236	Xã Tân Ân Tây	973	active
32239	Xã Viên An Đông	973	active
32242	Xã Viên An	973	active
32244	Thị trấn Rạch Gốc	973	active
32245	Xã Tân Ân	973	active
32248	Xã Đất Mũi	973	active
32249	Xã Khác	\N	active
\.


--
-- Name: change_class_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sa
--

SELECT pg_catalog.setval('public.change_class_id_seq', 11, true);


--
-- Name: city_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sa
--

SELECT pg_catalog.setval('public.city_id_seq', 64, true);


--
-- Name: class_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sa
--

SELECT pg_catalog.setval('public.class_id_seq', 9, true);


--
-- Name: district_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sa
--

SELECT pg_catalog.setval('public.district_id_seq', 51, true);


--
-- Name: ethnic_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sa
--

SELECT pg_catalog.setval('public.ethnic_id_seq', 281, true);


--
-- Name: gender_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sa
--

SELECT pg_catalog.setval('public.gender_id_seq', 3, true);


--
-- Name: hibernate_sequence; Type: SEQUENCE SET; Schema: public; Owner: sa
--

SELECT pg_catalog.setval('public.hibernate_sequence', 10880, true);


--
-- Name: mark_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sa
--

SELECT pg_catalog.setval('public.mark_id_seq', 78, true);


--
-- Name: religion_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sa
--

SELECT pg_catalog.setval('public.religion_id_seq', 17, true);


--
-- Name: role_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sa
--

SELECT pg_catalog.setval('public.role_id_seq', 4, true);


--
-- Name: semester_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sa
--

SELECT pg_catalog.setval('public.semester_id_seq', 2, true);


--
-- Name: student_transcript_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sa
--

SELECT pg_catalog.setval('public.student_transcript_id_seq', 14, true);


--
-- Name: teacher_class_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sa
--

SELECT pg_catalog.setval('public.teacher_class_id_seq', 22, true);


--
-- Name: users_seq; Type: SEQUENCE SET; Schema: public; Owner: sa
--

SELECT pg_catalog.setval('public.users_seq', 1, false);


--
-- Name: ward_id_seq; Type: SEQUENCE SET; Schema: public; Owner: sa
--

SELECT pg_catalog.setval('public.ward_id_seq', 1, false);


--
-- Name: change_class change_class_pkey; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.change_class
    ADD CONSTRAINT change_class_pkey PRIMARY KEY (id);


--
-- Name: city city_pkey; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.city
    ADD CONSTRAINT city_pkey PRIMARY KEY (id);


--
-- Name: class class_pkey; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.class
    ADD CONSTRAINT class_pkey PRIMARY KEY (id);


--
-- Name: district district_pkey; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.district
    ADD CONSTRAINT district_pkey PRIMARY KEY (id);


--
-- Name: ethnic ethnic_pkey; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.ethnic
    ADD CONSTRAINT ethnic_pkey PRIMARY KEY (id);


--
-- Name: gender gender_pkey; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.gender
    ADD CONSTRAINT gender_pkey PRIMARY KEY (id);


--
-- Name: mark mark_pkey; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.mark
    ADD CONSTRAINT mark_pkey PRIMARY KEY (id);


--
-- Name: organization organization_pkey; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.organization
    ADD CONSTRAINT organization_pkey PRIMARY KEY (id);


--
-- Name: religion religion_pkey; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.religion
    ADD CONSTRAINT religion_pkey PRIMARY KEY (id);


--
-- Name: role role_pkey; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.role
    ADD CONSTRAINT role_pkey PRIMARY KEY (id);


--
-- Name: semester semester_pkey; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.semester
    ADD CONSTRAINT semester_pkey PRIMARY KEY (id);


--
-- Name: student_transcript student_transcript_pkey; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.student_transcript
    ADD CONSTRAINT student_transcript_pkey PRIMARY KEY (id);


--
-- Name: subject_organization subject_organization_pkey; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.subject_organization
    ADD CONSTRAINT subject_organization_pkey PRIMARY KEY (subjectcode, organizationid);


--
-- Name: subject subject_pkey; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.subject
    ADD CONSTRAINT subject_pkey PRIMARY KEY (subjectcode);


--
-- Name: teacher_class teacher_class_pkey; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.teacher_class
    ADD CONSTRAINT teacher_class_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (roll_number);


--
-- Name: ward ward_pkey; Type: CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.ward
    ADD CONSTRAINT ward_pkey PRIMARY KEY (id);


--
-- Name: change_class fk2ncoi9a6cmi7qayt33kpyis5; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.change_class
    ADD CONSTRAINT fk2ncoi9a6cmi7qayt33kpyis5 FOREIGN KEY (semester) REFERENCES public.semester(id);


--
-- Name: transcript_mark fk4co1xjkdybasu3ctxdhait4su; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.transcript_mark
    ADD CONSTRAINT fk4co1xjkdybasu3ctxdhait4su FOREIGN KEY (mark_id) REFERENCES public.mark(id);


--
-- Name: change_class fk56nhdf6iy7m4jw2bdukdttu4e; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.change_class
    ADD CONSTRAINT fk56nhdf6iy7m4jw2bdukdttu4e FOREIGN KEY (old_class_id) REFERENCES public.class(id);


--
-- Name: user_role fk69qmfb3hhk1lya3ulqik7a6wx; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT fk69qmfb3hhk1lya3ulqik7a6wx FOREIGN KEY (id) REFERENCES public.role(id);


--
-- Name: users fk82rnlsqtbjafy6jg55538b1q7; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fk82rnlsqtbjafy6jg55538b1q7 FOREIGN KEY (ethnic) REFERENCES public.ethnic(id);


--
-- Name: subject_organization fk87q1uvq2575qmujiu08fy3yn3; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.subject_organization
    ADD CONSTRAINT fk87q1uvq2575qmujiu08fy3yn3 FOREIGN KEY (organizationid) REFERENCES public.organization(id);


--
-- Name: organization fk98iwoy50h1x8mu2vvfg9p4g3h; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.organization
    ADD CONSTRAINT fk98iwoy50h1x8mu2vvfg9p4g3h FOREIGN KEY (wardorganization) REFERENCES public.organization(id);


--
-- Name: teacher_class fkc2yu0oy9xxnscvgv1a5re9eti; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.teacher_class
    ADD CONSTRAINT fkc2yu0oy9xxnscvgv1a5re9eti FOREIGN KEY (rollnumber) REFERENCES public.users(roll_number);


--
-- Name: users fkc6u6j4iwttht9lxjtdss58gr8; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fkc6u6j4iwttht9lxjtdss58gr8 FOREIGN KEY (religion) REFERENCES public.religion(id);


--
-- Name: class fkdil7lvy77u1isdxv2ya3bqxia; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.class
    ADD CONSTRAINT fkdil7lvy77u1isdxv2ya3bqxia FOREIGN KEY (class_organization) REFERENCES public.organization(id);


--
-- Name: student_transcript fkdoqxy0prlmxrejp2c1jbn55gt; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.student_transcript
    ADD CONSTRAINT fkdoqxy0prlmxrejp2c1jbn55gt FOREIGN KEY (student) REFERENCES public.users(roll_number);


--
-- Name: user_role fkdspswgxb34e17v0wwtuqj78e9; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.user_role
    ADD CONSTRAINT fkdspswgxb34e17v0wwtuqj78e9 FOREIGN KEY (rollnumber) REFERENCES public.users(roll_number);


--
-- Name: change_class fkej7e2um02413amrgw59s6m5ee; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.change_class
    ADD CONSTRAINT fkej7e2um02413amrgw59s6m5ee FOREIGN KEY (teacher) REFERENCES public.users(roll_number);


--
-- Name: users fkf63oiq2yfh7t2rxwt6khwo475; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fkf63oiq2yfh7t2rxwt6khwo475 FOREIGN KEY (gender) REFERENCES public.gender(id);


--
-- Name: teacher_class fkgdm5gxhbx3gnemp8em4v0mx6t; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.teacher_class
    ADD CONSTRAINT fkgdm5gxhbx3gnemp8em4v0mx6t FOREIGN KEY (subjectcode) REFERENCES public.subject(subjectcode);


--
-- Name: users fkhjeuf9berxdvj4iiptcix8bs4; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fkhjeuf9berxdvj4iiptcix8bs4 FOREIGN KEY (student_class) REFERENCES public.class(id);


--
-- Name: district fkhkcmy7sb24q6ywgmm1ena6knf; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.district
    ADD CONSTRAINT fkhkcmy7sb24q6ywgmm1ena6knf FOREIGN KEY (city) REFERENCES public.city(id);


--
-- Name: organization fkjf5v5uasauij3nxvcsocbriom; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.organization
    ADD CONSTRAINT fkjf5v5uasauij3nxvcsocbriom FOREIGN KEY (ward) REFERENCES public.ward(id);


--
-- Name: ward fkk0n5oviw75pta628jatfj7o1a; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.ward
    ADD CONSTRAINT fkk0n5oviw75pta628jatfj7o1a FOREIGN KEY (district) REFERENCES public.district(id);


--
-- Name: change_class fkm2kf85k7y0icc01yn89dlg84j; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.change_class
    ADD CONSTRAINT fkm2kf85k7y0icc01yn89dlg84j FOREIGN KEY (new_class_id) REFERENCES public.class(id);


--
-- Name: transcript_mark fkmboj9cbh2k0r25q90u5mfn85x; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.transcript_mark
    ADD CONSTRAINT fkmboj9cbh2k0r25q90u5mfn85x FOREIGN KEY (transcript_id) REFERENCES public.student_transcript(id);


--
-- Name: users fkmi9n4cn5puidoj26xske7qf6h; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fkmi9n4cn5puidoj26xske7qf6h FOREIGN KEY (teacher_roll_number) REFERENCES public.users(roll_number);


--
-- Name: student_transcript fknjtyak3fx6fas9no1w4cpjsx9; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.student_transcript
    ADD CONSTRAINT fknjtyak3fx6fas9no1w4cpjsx9 FOREIGN KEY (semester) REFERENCES public.semester(id);


--
-- Name: subject_organization fknt9jh085d6fd4esn8uyoq7tos; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.subject_organization
    ADD CONSTRAINT fknt9jh085d6fd4esn8uyoq7tos FOREIGN KEY (subjectcode) REFERENCES public.subject(subjectcode);


--
-- Name: users fkpp4kxcq4gdv5yduadn8j30k1q; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fkpp4kxcq4gdv5yduadn8j30k1q FOREIGN KEY (organization) REFERENCES public.organization(id);


--
-- Name: teacher_class fksassy91xtk5w54rerc413fri0; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.teacher_class
    ADD CONSTRAINT fksassy91xtk5w54rerc413fri0 FOREIGN KEY (classid) REFERENCES public.class(id);


--
-- Name: users fksv7mst697sn086p2qfbu2k8av; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT fksv7mst697sn086p2qfbu2k8av FOREIGN KEY (teacher_class) REFERENCES public.class(id);


--
-- Name: change_class fktd7i7gshoicpm90yk1tavmqh1; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.change_class
    ADD CONSTRAINT fktd7i7gshoicpm90yk1tavmqh1 FOREIGN KEY (student) REFERENCES public.users(roll_number);


--
-- Name: student_transcript fktegq45us731l1bnkbbfjmdj61; Type: FK CONSTRAINT; Schema: public; Owner: sa
--

ALTER TABLE ONLY public.student_transcript
    ADD CONSTRAINT fktegq45us731l1bnkbbfjmdj61 FOREIGN KEY (subject) REFERENCES public.subject(subjectcode);


--
-- PostgreSQL database dump complete
--

