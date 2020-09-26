-- Verify schemas/units/tables/unit/table on pg

BEGIN;

SELECT verify_table ('units.unit');

ROLLBACK;
