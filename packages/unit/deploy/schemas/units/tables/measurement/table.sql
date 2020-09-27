-- Deploy schemas/units/tables/measurement/table to pg

-- requires: schemas/units/schema

BEGIN;

CREATE TABLE units.derived_unit (
    id serial primary key,
    name text,
    -- type text -- nominal, ordinal, interval, and ratio... eh, do we need this? 
    quantity text, -- quantity which provides base unit, volume, duration, etc. (DOES THIS GO NOW? since quantity will b)
    derived text, -- unit to measure the quantity. optional. If not specified, store in the quantity units.
    -- we could name derived unit, and make unit optional.
    typeof text -- water, trees, etc.
);

COMMENT ON TABLE units.derived_unit IS 'Measurement includes a quantity and a derived unit to measure that quanity so the amount stored can be stored in derived units but converted to base units.';
COMMENT ON COLUMN units.derived_unit.name IS 'Name of the measurement, e.g. "number of trees", "acres of tillable land"';
COMMENT ON COLUMN units.derived_unit.quantity IS 'A property that is measured, e.g. mass, length, time, volume, pressure';
COMMENT ON COLUMN units.derived_unit.derived IS 'A unit. A standard quantity against which a quantity is measured, e.g. kg, cm, s, m^3, Pa';
-- COMMENT ON COLUMN units.derived_unit.type IS 'Level of measurement or scale of measure is a classification that describes the nature of information within the values assigned to variables.';


CREATE TYPE units.measurement_type as (
    unit int,
    value numeric
);

CREATE TYPE units.measurement_type_text as (
    unit text,
    value numeric
);

CREATE TABLE units.measurement (
    id serial primary key, -- probably NOT serial! UUID
    unit int, -- now we could reference
    value numeric
);


CREATE TABLE mymeasurements (
    id integer,
    value units.measurement
);

COMMIT;

