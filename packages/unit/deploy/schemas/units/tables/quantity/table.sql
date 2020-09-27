-- Deploy schemas/units/tables/quantity/table to pg

-- requires: schemas/units/schema

BEGIN;

CREATE TABLE units.quantity (
    id serial PRIMARY KEY,
    name text,
    label text,
    unit text,
    unit_desc text,
    description text
);

-- maybe a list of potential units?

COMMENT ON TABLE units.quantity IS 'A property that is measured, e.g. mass, length, time, volume, pressure';

COMMIT;
