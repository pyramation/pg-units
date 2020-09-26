-- Verify schemas/units/procedures/cast_str  on pg

BEGIN;

SELECT verify_function ('units.cast_str');

ROLLBACK;
