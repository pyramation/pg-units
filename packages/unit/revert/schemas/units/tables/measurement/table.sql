-- Revert schemas/units/tables/measurement/table from pg

BEGIN;

DROP TABLE units.measurement;

COMMIT;
