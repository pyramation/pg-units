const Units = (text) => {
  let buf = [];
  const lines = text
    .split('\n')
    .map((line) => {
      if (!line.startsWith('#') && line.trim().endsWith('\\')) {
        buf.push(line.replace(/\\$/, '').trim());
        return null;
      }
      if (buf.length) {
        buf.push(line);
        buf = [];
        return buf;
      }
      if (line.startsWith('#')) return null;
      return line;
    })
    .filter((i) => i);

  const tokens = [];
  const state = {
    set: false,
    utf8: false
  };

  const parseFn = (obj) => {
    const params = obj.params;
    const units = obj.params.match(/units=([^\s]*)/);
    if (units) {
      obj.units = units[1];
      obj.params = obj.params.replace(units[0], '');
    }
    const range = obj.params.match(/range=([^\s]*)/);
    if (range) {
      obj.range = range[1];
      obj.params = obj.params.replace(range[0], '');
    }
    const domain = obj.params.match(/domain=([^\s]*)/);
    if (domain) {
      obj.domain = domain[1];
      obj.params = obj.params.replace(domain[0], '');
    }

    const noerror = obj.params.match(/noerror/);
    if (noerror) {
      obj.noerror = true;
      obj.params = obj.params.replace(noerror[0], '');
    }

    const parameters = obj.def.match(/.*\((.*)\)/);
    obj.parameters = parameters[1]
      .split(',')
      .map((a) => a.trim())
      .filter((a) => a);

    obj.def = obj.def.split('(')[0];

    obj.fns = obj.params.split(';').map((a) => a.trim());

    if (obj.units) {
      obj.units = obj.units
        .split(';')
        .map((u) => u.replace('[', '').replace(']', ''))
        .filter((a) => a);
    }
    if (obj.units && !obj.units.length) delete obj.units;
    delete obj.params;
    return obj;
  };

  for (let i = 0; i < lines.length; i++) {
    // TODO handle multiline definitions
    let line = lines[i];
    if (typeof line === 'string') {
      line = line.replace(/\t/g, ' ');
      if (line.startsWith('!')) {
        state.set = true;
        if (/^!utf8/.test(line)) {
          state.utf8 = true;
        }
        if (/^!endutf8/.test(line)) {
          state.utf8 = false;
        }
      } else {
        state.set = false;
      }
      if (line.startsWith(' ')) {
        // will lose comments here
        continue;
      }
      if (!state.set) {
        let [name, ...params] = line.split(' ');
        params = params
          .map((a) => a.trim())
          .join(' ')
          .trim();
        let comment;
        if (/#/.test(params)) {
          const parts = params.split('#');
          params = parts[0].trim();
          comment = parts[1].trim();
        }

        const obj = {};
        if (comment) {
          obj.comment = comment;
        }
        if (name.includes('[')) {
          throw new Error('should not happen');
        } else if (name.includes('(')) {
          tokens.push({
            Function: parseFn({
              def: name,
              params: params,
              ...obj
            })
          });
        } else {
          tokens.push({
            Definition: {
              def: name,
              params: params,
              ...obj
            }
          });
        }
      }
    } else if (Array.isArray(line) && line.length) {
      let [first, ...rest] = line;
      first = first.replace(/\t/g, ' ');
      if (first.startsWith('!')) {
        state.set = true;
        if (/^!utf8/.test(line)) {
          state.utf8 = true;
        }
        if (/^!endutf8/.test(line)) {
          state.utf8 = false;
        }
      } else {
        state.set = false;
      }

      let [name, ...params] = first.split(' ');
      params = params
        .concat(rest)
        .map((a) => a.trim())
        .join(' ')
        .trim();
      let comment;
      if (/#/.test(params)) {
        const parts = params.split('#');
        params = parts[0].trim();
        comment = parts[1].trim();
      }

      const obj = {};
      if (comment) {
        obj.comment = comment;
      }

      if (!state.set) {
        if (name.includes('[')) {
          tokens.push({
            Matrix: {
              def: name,
              params: rest.map((a) =>
                a
                  .trim()
                  .replace(/\t/g, ' ')
                  .replace(/\s+/g, ' ')
                  .split(/[\t\s]/)
                  .map((a) => Number(a.trim()))
              ),
              ...obj
            }
          });
        } else if (name.includes('(')) {
          tokens.push({
            Function: parseFn({
              def: name,
              params: params,
              ...obj
            })
          });
        } else {
          tokens.push({
            Definition: {
              def: name,
              params: params,
              ...obj
            }
          });
        }
      }
    }
  }

  return tokens;
};

const str = require('fs')
  .readFileSync(__dirname + '/src/definitions.units.patched')
  .toString();

const toks = JSON.stringify(Units(str), null, 2);
require('fs').writeFileSync(__dirname + '/units.json', toks);
