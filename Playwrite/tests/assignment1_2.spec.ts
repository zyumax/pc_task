import { test, expect } from '@playwright/test';

test('トップページにアクセス', async({ page }) => {
  await page.goto('https://hotel-example-site.takeyaqa.dev/ja/');

  await expect(page).toHaveTitle(/HOTEL/);
});