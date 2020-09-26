-- Revert schemas/units/schema from pg

BEGIN;

DROP SCHEMA units;

COMMIT;
