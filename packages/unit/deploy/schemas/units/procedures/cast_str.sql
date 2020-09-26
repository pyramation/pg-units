-- Deploy schemas/units/procedures/cast_str to pg
-- requires: schemas/units/schema

BEGIN;
-- https://www.postgresql.org/docs/9.1/sql-createcast.html
-- CREATE CAST (bigint AS int4) WITH FUNCTION int4(bigint) AS ASSIGNMENT;

CREATE FUNCTION units.cast_str (str text)
  RETURNS json
  AS $$
DECLARE
  p text;
  p1 text;
  num text;
  p2 text;
BEGIN
  p = trim(regexp_replace(str, '\s+', ' ', 'g'));
  p1 = split_part(p, ' ', 1);
  num = replace(p1, ',', '')::numeric;
  p2 = split_part(p, ' ', 2);
  RETURN json_build_object('type', p2, 'value', num);
END;
$$
LANGUAGE 'plpgsql'
STABLE;
COMMIT;

