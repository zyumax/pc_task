import { test, expect } from '@playwright/test';

// ユーザー情報
const user = {
  email: 'test@example.com',
  password: 'password',
  name: 'userName'
};

test('情報入力後、マイページに移動', async ({page}) => {
  await page.goto('https://hotel-example-site.takeyaqa.dev/ja/signup.html');

  // 会員情報入力
  await page.getByLabel('メールアドレス').fill(user.email);
  await page.locator('input[name="password"]').fill(user.password);
  await page.locator('input[name="password-confirmation"]').fill(user.password);
  await page.getByLabel('氏名').fill(user.name);
  await page.getByLabel('プレミアム会員').check();
  await page.locator('input[type="date"][name="birthday"]').fill('2025-12-31');

  await Promise.all([
    page.waitForURL('**/mypage.html'),
    page.getByRole('button', {name: '登録'}).click(),
  ]);

  // 入力情報の確認
  await expect(page.getByRole('heading', { name: 'マイページ' })).toBeVisible();

  await expect(page.getByRole('listitem').filter({ hasText: user.email})).toBeVisible();
  await expect(page.getByRole('listitem').filter({ hasText: user.name})).toBeVisible();
  await expect(page.getByRole('listitem').filter({ hasText: 'プレミアム会員'})).toBeVisible();
  await expect(page.getByRole('listitem').filter({ hasText: '2025年12月31日'})).toBeVisible();
  await expect(page.getByRole('listitem').filter({ hasText: '受け取らない'})).toBeVisible();

  await expect(page.getByRole('listitem').filter({ hasText: '住所'})).toContainText('未登録');
  await expect(page.getByRole('listitem').filter({ hasText: '電話番号'})).toContainText('未登録');
  await expect(page.getByRole('listitem').filter({ hasText: '性別'})).toContainText('未登録');
  await expect(page.getByRole('listitem').filter({ hasText: 'お知らせ'})).toContainText('受け取らない');
});