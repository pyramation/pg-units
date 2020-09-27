#!/bin/bash

psql units <<EOF
\copy units.quantity(name, unit, label, description, unit_desc) FROM'/Users/dlynch/code/pg/units/packages/unit/seed/quantity.csv' DELIMITER ',' CSV
EOF

pg_dump --column-inserts --data-only --table=units.quantity units
