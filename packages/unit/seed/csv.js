const csv = require('csv-parser');
const fs = require('fs');
const results = [];

const write = fs.createWriteStream('out.csv');

fs.createReadStream('data.csv')
  .pipe(csv())
  .on('data', (data) => {
    const name = data[0];
    const desc = data[1];

    let labelDesc = desc.match('This interface represents ([^.]*).');
    if (labelDesc) {
      labelDesc = labelDesc[1];
    } else {
      labelDesc = desc.match('This class represents ([^.]*).');
      if (labelDesc) {
        labelDesc = labelDesc[1];
      } else {
        console.log('no description: ', name, desc);
      }
    }

    if (labelDesc) {
      labelDesc = labelDesc.trim();
      // .replace(/^an /, '')
      // .replace(/^a /, '')
      // .replace(/^the /, '');
    }

    let unitDesc = desc.match('The system unit for this quantity is ([^.]*).');
    if (unitDesc) {
      unitDesc = unitDesc[1];
    } else {
      unitDesc = desc.match('The system unit for this quantity ([^.]*).');
      if (unitDesc) {
        unitDesc = unitDesc[1];
      } else {
        console.log('no unit: ', name, desc);
      }
    }

    let unitSymbol;
    let unitText;
    if (unitDesc) {
      unitSymbol = desc.match('"(.*)"');
      if (unitSymbol) {
        unitSymbol = unitSymbol[0].replace(/"/g, '');
      }
      unitText = desc.match(/\((.*)\)/);
      if (unitText) {
        unitText = unitText[0].replace(/[()]/g, '');
      }
    }

    console.log({ unitSymbol });
    console.log({ unitText });
    console.log({ labelDesc });
    console.log({ unitDesc });

    const logField = (str) => {
      write.write(str || '');
      write.write('@');
    };

    logField(labelDesc);
    logField(name);
    logField(unitSymbol);
    logField(unitText);
    logField(unitDesc);
    logField(desc);

    write.write('\n');

    results.push(data);
  })
  .on('end', () => {
    write.end();
  });
