-- Verify schemas/units/tables/measurement/table on pg

BEGIN;

SELECT verify_table ('units.measurement');

ROLLBACK;
