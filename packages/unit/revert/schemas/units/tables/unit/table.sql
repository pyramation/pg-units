-- Revert schemas/units/tables/unit/table from pg

BEGIN;

DROP TABLE units.unit;

COMMIT;
