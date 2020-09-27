#!/bin/bash

function initdb {
    cleardbs
    dropdb units
    lql deploy --createdb --yes --database units 
}

function createcsvs {
    echo units...
    node seed/units.js && ./seed/units.sh

    echo quantity...
    node seed/quantity.js && ./seed/quantity.sh
}

