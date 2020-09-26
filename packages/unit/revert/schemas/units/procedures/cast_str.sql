-- Revert schemas/units/procedures/cast_str from pg

BEGIN;

DROP FUNCTION units.cast_str;

COMMIT;
