-- Verify schemas/units/schema  on pg

BEGIN;

SELECT verify_schema ('units');

ROLLBACK;
