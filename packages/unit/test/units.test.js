jasmine.DEFAULT_TIMEOUT_INTERVAL = 30000;
import { getConnections } from '@launchql/db-testing';
import cases from 'jest-in-case';
import { snapshot } from './utils/clean';

const objs = {};
let db, client, teardown;

beforeAll(async () => {
  ({ db, teardown } = await getConnections());
  client = db.helper('units');
});
afterAll(async () => {
  await teardown();
});
beforeEach(async () => {
  await db.beforeEach();
});
afterEach(async () => {
  await db.afterEach();
});

cases(
  'unit',
  async ({ name }) => {
    const second = await client.selectOne('unit', ['*'], {
      name
    });
    expect(snapshot(second)).toMatchSnapshot();
  },
  [{ name: 's' }, { name: 'second' }, { name: 'kg' }]
);

cases(
  'units',
  async (opts) => {
    const [{ cast_str: a }] = await client.callAny('cast_str', {
      str: opts.name
    });
    expect(snapshot(a)).toMatchSnapshot();
  },
  [
    { name: '1' },
    { name: ' 1 mi ' },
    { name: '1 km' },
    { name: '10,000 foot' },
    { name: '10,000 feet' },
    { name: '1 s' },
    { name: '1 second' },
    { name: '20,000 gigaton' },
    { name: '1 gigaton' },
    { name: '1 ml' }
  ]
);

cases(
  'quantities',
  async (opts) => {
    const a = await client.select('quantity', ['*'], {
      name: opts.name
    });
    expect(snapshot(a)).toMatchSnapshot();
  },
  [
    { name: 'Volume' },
    { name: 'Power' },
    { name: 'Money' },
    { name: 'Energy' },
    { name: 'Duration' }
  ]
);
