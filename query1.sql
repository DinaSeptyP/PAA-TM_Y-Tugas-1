PGDMP         +        
        {            query1    14.4    14.4                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    58952    query1    DATABASE     j   CREATE DATABASE query1 WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'English_United States.1252';
    DROP DATABASE query1;
                postgres    false                        2615    58976    users    SCHEMA        CREATE SCHEMA users;
    DROP SCHEMA users;
                postgres    false            �            1259    58978    peran_id_peran_seq    SEQUENCE     z   CREATE SEQUENCE users.peran_id_peran_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE users.peran_id_peran_seq;
       users          postgres    false    4            �            1259    58990    peran    TABLE     >  CREATE TABLE users.peran (
    id_peran integer DEFAULT nextval('users.peran_id_peran_seq'::regclass) NOT NULL,
    nama_peran text NOT NULL,
    kd_sts_aktif character(1) NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE users.peran;
       users         heap    postgres    false    211    4            �            1259    58979    peran_user_id_peran_user_seq    SEQUENCE     �   CREATE SEQUENCE users.peran_user_id_peran_user_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE users.peran_user_id_peran_user_seq;
       users          postgres    false    4            �            1259    59000 
   peran_user    TABLE     �  CREATE TABLE users.peran_user (
    id_peran_user integer DEFAULT nextval('users.peran_user_id_peran_user_seq'::regclass) NOT NULL,
    id_person integer NOT NULL,
    id_peran integer NOT NULL,
    nama_user text NOT NULL,
    password text NOT NULL,
    kd_sts_aktif character(1) DEFAULT 1 NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE users.peran_user;
       users         heap    postgres    false    212    4            �            1259    58977    person_id_person_seq    SEQUENCE     |   CREATE SEQUENCE users.person_id_person_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE users.person_id_person_seq;
       users          postgres    false    4            �            1259    58980    person    TABLE     v  CREATE TABLE users.person (
    id_person integer DEFAULT nextval('users.person_id_person_seq'::regclass) NOT NULL,
    nama text NOT NULL,
    email text NOT NULL,
    no_hp text NOT NULL,
    alamat text,
    kd_sts_aktif character(1),
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL
);
    DROP TABLE users.person;
       users         heap    postgres    false    210    4            �            1259    67175    produk    TABLE     �   CREATE TABLE users.produk (
    id integer NOT NULL,
    nama_barang character varying(255) DEFAULT NULL::character varying,
    deskripsi text,
    harga bigint,
    stok integer,
    url_gambar character varying(255) DEFAULT NULL::character varying
);
    DROP TABLE users.produk;
       users         heap    postgres    false    4            �            1259    67174    produk_id_seq    SEQUENCE     �   CREATE SEQUENCE users.produk_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 #   DROP SEQUENCE users.produk_id_seq;
       users          postgres    false    217    4                       0    0    produk_id_seq    SEQUENCE OWNED BY     =   ALTER SEQUENCE users.produk_id_seq OWNED BY users.produk.id;
          users          postgres    false    216            v           2604    67178 	   produk id    DEFAULT     d   ALTER TABLE ONLY users.produk ALTER COLUMN id SET DEFAULT nextval('users.produk_id_seq'::regclass);
 7   ALTER TABLE users.produk ALTER COLUMN id DROP DEFAULT;
       users          postgres    false    217    216    217                      0    58990    peran 
   TABLE DATA           Z   COPY users.peran (id_peran, nama_peran, kd_sts_aktif, created_at, updated_at) FROM stdin;
    users          postgres    false    214   H                  0    59000 
   peran_user 
   TABLE DATA           �   COPY users.peran_user (id_peran_user, id_person, id_peran, nama_user, password, kd_sts_aktif, created_at, updated_at) FROM stdin;
    users          postgres    false    215   �                  0    58980    person 
   TABLE DATA           l   COPY users.person (id_person, nama, email, no_hp, alamat, kd_sts_aktif, created_at, updated_at) FROM stdin;
    users          postgres    false    213   �                  0    67175    produk 
   TABLE DATA           T   COPY users.produk (id, nama_barang, deskripsi, harga, stok, url_gambar) FROM stdin;
    users          postgres    false    217   ~!                  0    0    peran_id_peran_seq    SEQUENCE SET     @   SELECT pg_catalog.setval('users.peran_id_peran_seq', 1, false);
          users          postgres    false    211                       0    0    peran_user_id_peran_user_seq    SEQUENCE SET     J   SELECT pg_catalog.setval('users.peran_user_id_peran_user_seq', 1, false);
          users          postgres    false    212                       0    0    person_id_person_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('users.person_id_person_seq', 1, false);
          users          postgres    false    210                       0    0    produk_id_seq    SEQUENCE SET     ;   SELECT pg_catalog.setval('users.produk_id_seq', 10, true);
          users          postgres    false    216            |           2606    58999    peran peran_pk 
   CONSTRAINT     Q   ALTER TABLE ONLY users.peran
    ADD CONSTRAINT peran_pk PRIMARY KEY (id_peran);
 7   ALTER TABLE ONLY users.peran DROP CONSTRAINT peran_pk;
       users            postgres    false    214            z           2606    58989    person person_pk 
   CONSTRAINT     T   ALTER TABLE ONLY users.person
    ADD CONSTRAINT person_pk PRIMARY KEY (id_person);
 9   ALTER TABLE ONLY users.person DROP CONSTRAINT person_pk;
       users            postgres    false    213            ~           2606    67184    produk produk_pkey 
   CONSTRAINT     O   ALTER TABLE ONLY users.produk
    ADD CONSTRAINT produk_pkey PRIMARY KEY (id);
 ;   ALTER TABLE ONLY users.produk DROP CONSTRAINT produk_pkey;
       users            postgres    false    217                       2606    59009    peran_user peran_user_fk    FK CONSTRAINT        ALTER TABLE ONLY users.peran_user
    ADD CONSTRAINT peran_user_fk FOREIGN KEY (id_person) REFERENCES users.person(id_person);
 A   ALTER TABLE ONLY users.peran_user DROP CONSTRAINT peran_user_fk;
       users          postgres    false    213    3194    215            �           2606    59014    peran_user peran_user_fk_1    FK CONSTRAINT     ~   ALTER TABLE ONLY users.peran_user
    ADD CONSTRAINT peran_user_fk_1 FOREIGN KEY (id_peran) REFERENCES users.peran(id_peran);
 C   ALTER TABLE ONLY users.peran_user DROP CONSTRAINT peran_user_fk_1;
       users          postgres    false    215    3196    214               4   x�3�LL�����4202�50�50V04�20�25�374673�#�����  5�         ^   x�}�1
�@��~�#�\�6�Z��G�<��aFI�Ӻlt��>��VK��*�����y���/��������qܲxh$���}`��X!;         t   x�}�K
�@�ݧ��3�U�p3DQ�V��I���Yբ��`��o���eu�݀2��S.����=���hG�#�p�+'3E=7(G����y���)�N���'/���!�*"0b         .  x�M�[o�0�����/�D�Kb'A�-�*�(/H��%���y��_O6�V�kf���|�@� ���0[|7���A
f���;�ǳO�VA�xI!NQ�ҴO��fOR���+u��0�6�ro�fEFk	�Б)3�D��%�U��R�P�Pnd�r�kUYV�mK�k����㐱�a�6%:��.&���g������;X��w���p�#�����+�6>�{��>�hsFR��*[��-��Vb�TZBQ2Q7D/��>��ϫ�����~�7��y�BJ�ݍ��gLF�|���;|�b�q�-����C�_�)�S�es����!���Ӹ"��t��M� ���!�SA�Evޚ�[�o0��n�48�]����ʶ���@_�=��0���@?�0����b�e��2��l 5�&{�t"?�0BL+�~E�}$��m���*)���2��gu�%u�����6�az	�7e!@SURQX	N���C0�ں�O��K�ۙԿ4����UF 8i9x���]>9��n��>��.H+���V��fU��n�1����QJMŚٟ|���l��     