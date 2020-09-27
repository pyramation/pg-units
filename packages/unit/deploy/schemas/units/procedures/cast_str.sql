-- Deploy schemas/units/procedures/cast_str to pg
-- requires: schemas/units/schema
-- requires: schemas/units/tables/unit/table 

BEGIN;
-- https://www.postgresql.org/docs/9.1/sql-createcast.html
-- CREATE CAST (bigint AS int4) WITH FUNCTION int4(bigint) AS ASSIGNMENT;

-- get it so you only reduce to base or simple types
-- any equations, just stop 

-- but then for quantities, you can just use those types that resolve
-- these are what we need!


CREATE FUNCTION units.cast_str (str text)
  RETURNS json
  AS $$
DECLARE
  p text;
  p1 text;
  num text;
  p2 text;
  u units.unit;
BEGIN
  p = trim(regexp_replace(str, '\s+', ' ', 'g'));
  p1 = split_part(p, ' ', 1);
  num = replace(p1, ',', '')::numeric;
  p2 = split_part(p, ' ', 2);

  SELECT * FROM units.unit 
    WHERE name = p2
  INTO u;
 
  IF (FOUND) THEN

      -- if it's simple, recursively look up
      -- soon as we have any equation, thats the base case

    RETURN json_build_object(
      'name', u.name,
      'type', u.type,
      'base', u.base,
      'amount', u.amount,
      'ival', u.value, -- TODO we need to simply combine ival and amount anyways...
      'value', num,
      'desc', u.description
    );
  END IF;

  RETURN json_build_object('type', p2, 'value', num);
END;
$$
LANGUAGE 'plpgsql'
STABLE;
COMMIT;

