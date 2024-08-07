PGDMP      1                |           MangaArchive    15.7    16.3     �           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            �           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            �           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            �           1262    16887    MangaArchive    DATABASE     �   CREATE DATABASE "MangaArchive" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'German_Germany.1252';
    DROP DATABASE "MangaArchive";
                postgres    false            �            1259    16916    book    TABLE     (  CREATE TABLE public.book (
    id integer NOT NULL,
    title character varying(255) NOT NULL,
    author character varying(255),
    genre character varying(255),
    rating integer,
    review text,
    cover_url character varying(255),
    status character varying(50),
    chapter integer
);
    DROP TABLE public.book;
       public         heap    postgres    false            �            1259    16915    book_id_seq    SEQUENCE     �   CREATE SEQUENCE public.book_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.book_id_seq;
       public          postgres    false    215            �           0    0    book_id_seq    SEQUENCE OWNED BY     ;   ALTER SEQUENCE public.book_id_seq OWNED BY public.book.id;
          public          postgres    false    214            e           2604    16919    book id    DEFAULT     b   ALTER TABLE ONLY public.book ALTER COLUMN id SET DEFAULT nextval('public.book_id_seq'::regclass);
 6   ALTER TABLE public.book ALTER COLUMN id DROP DEFAULT;
       public          postgres    false    214    215    215            �          0    16916    book 
   TABLE DATA           d   COPY public.book (id, title, author, genre, rating, review, cover_url, status, chapter) FROM stdin;
    public          postgres    false    215          �           0    0    book_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.book_id_seq', 6, true);
          public          postgres    false    214            g           2606    16923    book book_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.book
    ADD CONSTRAINT book_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.book DROP CONSTRAINT book_pkey;
       public            postgres    false    215            �   S  x��V�n�H<�_ѷ\����:y�.�	� ��ɦ8�p�;)�����DŻ�H򰧺���7���G�!�J��G�2�٥�F]��Y��P}�~=H��[E:����Ӥ햔�H��60�g)��(*R�8ȥH��c��^�*2M�Śl�ˎ�l������C������7�xp~�"A��Gj��A��%�+���[T��uG[ƅ8��(P1��������o��J(�&p8L�oM�U' ���^s����:�w��=�I����?Y��������p�v��'c��(�l�гv���y/g�!��q�n�3EVy���s��E��Łxt򴒊z�P�s��PTZ(,ԝ	���g�TC��L3�Z*�vX���n@Qm���e�_р�Ԏ'<��t�d���� ��S@������+�g�h��ą'�԰JQ�dn�	OA��V);3�B��@�[�}�L�˞=(���|�D�E���v}���;㢇Q�E�4��
JP�ذpNNiT��ge��V��q�NJ��#�z)�d���)/�l�z^U�������~}}���E��ӟW����ԁ>+[}S�l��́]�fڧYh�D�d��X�[7rw�6�tY����� 
���6J�(�_��u5Gz~�
�|n�wl�!����KQ�|Ƕ�踉��#�-�g]�3qkC_];�D�c*���:& ��6��(@Qè�qw�d'ϝn�jLi�W�*� ��i3l ��%�l�ӠOn�
{Z�l�ՙ��M�=�.`A��x��tG��>������r';��9����/�ט���uF��
����-�Sc��r��X:��Zg-�&W��+�d8�#�q���E�j˾�60����Y.�Ct/È�:�_�O�J��d��?�o���fs���ĺ�b��jn�z�!��K��7�Ԯ<�Z��>��]��^.�L%�K�����0���X�	�n(K�e����d��]֞��8g�4(��y���"��ڧ��C���
�ϲ����'H�h��I�j��P4@�|X9���P,��(a(���j[�R T�S6�)-m�'	�#�}�
e�.^9 O�qg{,#�{�D�L�ղ�P\F� H�!���6=-�2��<T���{����e��ۊ�)�u�q�i�^'��JL�G�>�7�x���}�7It
����ϲ���n}{��^W�؀V����W��7Xs��h+EM�8n�.�%�/�[B�,b�w)����q~E3}tɏ��OI�����<�ϻ��)��[7 C�V�1�vQ�D1f��2�2+zd9Z��!*r��r�M~�o�@��?� ���D�7��o_��n�7��l^_=�������/     