import { test, expect } from '@playwright/test';

test('会員登録をする', async({page}) => {
  await page.goto('https://hotel-example-site.takeyaqa.dev/ja/signup.html');

  // 会員情報入力
  await page.getByLabel('メールアドレス').fill('exa1@example.com');
  await page.locator('input[name="password"]').fill('password');
  await page.locator('input[name="password-confirmation"]').fill('password');
  await page.getByLabel('氏名').fill('exa1User');
  await page.getByLabel('プレミアム会員').check();
  await page.getByLabel('住所').fill('テスト県テスト市');
  await page.getByLabel('電話番号').fill('01133995577');
  await page.getByLabel('性別').selectOption('1'); 
  await page.locator('input[type="date"][name="birthday"]').fill('2025-12-31');
  await page.getByLabel('お知らせを受け取る').check();

  await Promise.all([
    page.waitForURL('**/mypage.html'),
    page.getByRole('button', {name: '登録'}).click(),
  ]);

  await expect(page).toHaveTitle(/マイページ\s\|\sHOTEL\sPLANISPHERE/);
});