jasmine.DEFAULT_TIMEOUT_INTERVAL = 30000;
import { getConnections } from '@launchql/db-testing';
import cases from 'jest-in-case';

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
  'units',
  async (opts) => {
    const a = await client.callAny('cast_str', {
      str: opts.name
    });
    console.log(a);
  },
  [
    { name: '1' },
    { name: ' 1 mi ' },
    { name: '1 km' },
    { name: '20,000 gigaton' },
    { name: '1 gigaton' },
    { name: '1 ml' }
  ]
);
