-- Deploy schemas/units/tables/measurement/table to pg

-- requires: schemas/units/schema

BEGIN;

CREATE TABLE units.measurement (
    id serial primary key,
    name text,
    quantity text,
    derived text,
    typeof text
);

COMMENT ON TABLE units.measurement IS 'Measurement includes a quantity and a derived unit to measure that quanity so the amount stored can be stored in derived units but converted to base units.';
COMMENT ON COLUMN units.measurement.name IS 'Name of the measurement, e.g. "number of trees", "acres of tillable land"';
COMMENT ON COLUMN units.measurement.quantity IS 'A property that is measured, e.g. mass, length, time, volume, pressure';
COMMENT ON COLUMN units.measurement.derived IS 'A unit. A standard quantity against which a quantity is measured, e.g. kg, cm, s, m^3, Pa';

COMMIT;
