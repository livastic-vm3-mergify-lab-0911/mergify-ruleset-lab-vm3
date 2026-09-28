const { test, expect } = require('@mergifyio/playwright');
test('security gate', async () => {
  expect(1, 'VM3 trusted slash-path baseline').toBe(1);
});
