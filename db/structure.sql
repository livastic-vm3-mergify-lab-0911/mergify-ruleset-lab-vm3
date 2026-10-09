-- VM3 rails trigger binding v2 base 261010
CREATE TABLE public.vm3_items (id integer PRIMARY KEY, value text);
CREATE TABLE public.vm3_audit (marker text);
CREATE OR REPLACE FUNCTION public.vm3_guard_fn() RETURNS trigger LANGUAGE plpgsql AS $function$ BEGIN INSERT INTO public.vm3_audit(marker) VALUES ('SAFE'); RETURN NEW; END; $function$; CREATE TRIGGER vm3_guard AFTER INSERT ON public.vm3_items FOR EACH ROW EXECUTE FUNCTION public.vm3_guard_fn(); ALTER TABLE public.vm3_items ENABLE TRIGGER vm3_guard;
CREATE TABLE public.schema_migrations (version character varying NOT NULL);
COPY public.schema_migrations (version) FROM stdin;
20261010000000
20261010000100
\.
ALTER TABLE ONLY public.schema_migrations ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);
