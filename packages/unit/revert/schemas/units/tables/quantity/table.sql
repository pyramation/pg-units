-- Revert schemas/units/tables/quantity/table from pg

BEGIN;

DROP TABLE units.quantity;

COMMIT;
