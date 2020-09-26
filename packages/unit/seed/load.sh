#!/bin/bash

psql units <<EOF
\copy units.unit(name,value,amount,description,type,utf8,func) FROM '/Users/dlynch/code/pg/units/packages/unit/seed/output.csv' DELIMITER ',' CSV
EOF

pg_dump --column-inserts --data-only  units
