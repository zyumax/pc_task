import { test, expect } from '@playwright/test';

test('会員登録ページに移動', async({ page }) => {
  await page.goto('https://hotel-example-site.takeyaqa.dev/ja/');

  await Promise.all([
    page.waitForURL('**/signup.html'),
    page.locator('a[href$="/signup.html"]').click(),
  ]);
  
  await expect(page).toHaveTitle(/会員登録/);
});