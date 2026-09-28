const { test, expect } = require('@mergifyio/playwright');
test('security gate', async () => {
  expect(1, 'VM3 attacker literal-backslash deterministic failure').toBe(2);
});
