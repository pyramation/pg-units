-- Deploy schemas/units/tables/unit/table to pg
-- requires: schemas/units/schema

BEGIN;
CREATE TABLE units.unit (
  id serial PRIMARY KEY,
  name text, -- make this primary, why do we have dups???
  base bool DEFAULT FALSE,
  value text,
  amount text,
  description text,
  type text,
  utf8 text,
  func text
);
COMMIT;

