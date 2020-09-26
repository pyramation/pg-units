const fs = require('fs');

const createCsvWriter = require('csv-writer').createObjectCsvWriter;
const csvWriter = createCsvWriter({
  path: __dirname + '/output.csv',
  header: [
    { id: 'name', title: 'name' },
    { id: 'value', title: 'title' },
    { id: 'amount', title: 'amount' },
    { id: 'desc', title: 'desc' },
    { id: 'type', title: 'type' },
    { id: 'utf8', title: 'utf8' },
    { id: 'func', title: 'func' }
  ]
});

// logField('name');
// logField('value');
// logField('amount');
// logField('desc');
// logField('type');
// logField('utf8');
// logField('func');
// logField('\n');

const records = [];

// const fd = fs.createWriteStream(__dirname + '/out.csv');
// const logField = (str) => {
// fd.write(str || '');
// fd.write('@');
// };

const TYPES = {
  primitive: 'Primitive',
  prefix: 'Prefix',
  numbers: 'Numbers',
  us: 'US Units',
  geometric: 'Geometric',
  astronomical: 'Astronomical',
  fundamental: 'Fundamental',
  british: 'British',
  thermal: 'Thermal',
  photometric: 'Photometric',
  electrostatic: 'Electrostatic',
  human: 'Derived from Human',
  conductivity: 'Conductivity',
  constants: 'Constants',
  ph: 'pH',
  time: 'Time',
  derived: 'Named SI derived units',
  temperature: 'Temperature',
  angles: 'Angles',
  concentration: 'Concentration',
  cooking: 'Cooking',
  imperial: 'Imperial',
  energy: 'Energy',
  count: 'Count',
  paper: 'Paper',
  print: 'Print',
  information: 'Information',
  cloth: 'yarn and cloth measures',
  medical: 'Medical',
  currency: 'Currency',
  wood: 'Wood',
  misc: 'Misc',
  flow: 'Gas and Liquid flow units',
  abbrev: 'Abbreviations',
  radioactive: 'Radioactivity',
  air: 'Air',
  people: 'People',
  scots: 'Scots',
  swedish: 'Swedish',
  german: 'German',
  australian: 'Australian',
  english: 'English',
  roman: 'Roman',
  egyptian: 'Egyptian',
  greek: 'Greek',
  northern: 'Northern',
  arabic: 'Arabic',
  medieval: 'Medieval',
  ancient: 'Ancient',
  symbols: 'Symbols'
};

const read = (type) => {
  fs.createReadStream(__dirname + '/units/' + type)
    .on('data', (data) => {
      const lines = data
        .toString()
        .split('\n')
        .map((l) => l.trim())
        .filter((l) => l && l.length)
        .filter((l) => !l.startsWith('#'));

      const agg = [];
      let vvar;
      let utf8;
      let aggMode = false;
      let func = false;

      lines.forEach((line) => {
        if (line.endsWith('\\')) {
          console.log(line);
          if (aggMode) {
            agg.push(line.replace(/\\$/, '').trim());
          } else {
            aggMode = true;
          }
        } else if (aggMode) {
          agg.push(line.trim());
          console.log(agg);
          aggMode = false;
          return;
        }

        if (line.startsWith('!')) {
          console.log(line);
          if (line.startsWith('!var')) {
            vvar = true;
          } else if (line.startsWith('!endvar')) {
            vvar = false;
          } else if (line.startsWith('!utf8')) {
            utf8 = true;
          } else if (line.startsWith('!endutf8')) {
            utf8 = false;
          } else {
            console.log('dont know ', line);
          }
          return;
        }

        const [info, desc] = line.split('#');
        let base, value, amount;
        const args = info.split(' ').filter((c) => c && c.length);
        const name = args[0];
        if (/[()]+/.test(name)) {
          func = true;
        }

        if (args.length === 3) {
          value = args[2];
          amount = args[1];
        } else if (args.length === 2) {
          value = args[1];
        } else {
          //   console.log('what does that mean?' + args.length);
          //   console.log(args);
          return;
        }

        // why?????
        if (value === '\\') return;

        records.push({
          name,
          value,
          amount,
          desc: desc && desc.trim(),
          type,
          utf8: utf8 ? 'true' : null,
          func: func ? 'true' : null
        });
        // logField(name);
        // logField(value);
        // logField(amount);
        // logField(desc && desc.trim());
        // logField(type);
        // logField(utf8 ? 'true' : null);
        // logField(func ? 'true' : null);
        // fd.write('\n');
      });
    })
    .on('end', () => {
      // fd.end();
      csvWriter
        .writeRecords(records) // returns a promise
        .then(() => {
          console.log('...Done');
        });
    });
};

Object.entries(TYPES).forEach(([key, type]) => {
  read(key);
});
