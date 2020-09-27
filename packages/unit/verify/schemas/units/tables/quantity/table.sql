-- Verify schemas/units/tables/quantity/table on pg

BEGIN;

SELECT verify_table ('units.quantity');

ROLLBACK;
