ALTER SYSTEM SET pljava.libjvm_location = '/usr/lib/jvm/java-17-openjdk/lib/server/libjvm.so';
SELECT pg_reload_conf();

CREATE EXTENSION IF NOT EXISTS pljava;
GRANT USAGE ON LANGUAGE java TO PUBLIC;