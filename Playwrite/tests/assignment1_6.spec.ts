import { test, expect } from '@playwright/test';

// ユーザー情報
const stayInfo = {
  days: '2',
  people: '3',
  name: 'テストユーザー'
};

// チェックインとチェックアウトの日付を作成
const checkinDate = (() => {
  const d = new Date();
  d.setDate(d.getDate() + 1);
  const y = d.getFullYear();
  const m = d.getMonth() + 1;
  const dd = String(d.getDate()).padStart(2, '0');
  return `${y}年${m}月${dd}日`;
})();

const checkoutDate = (() => {
  const d = new Date();
  d.setDate(d.getDate() + 1 + Number(stayInfo.days));
  const y = d.getFullYear();
  const m = d.getMonth() + 1;
  const dd = String(d.getDate()).padStart(2, '0');
  return `${y}年${m}月${dd}日`;
})();

test('宿泊予約', async({page}) => {
  await page.goto('https://hotel-example-site.takeyaqa.dev/ja/plans.html');

  const [reservePage] = await Promise.all([
    page.waitForEvent('popup'),
    page.locator('a[href$="/reserve.html?plan-id=0"]').click(),
  ]);
  await reservePage.waitForLoadState('domcontentloaded');

  await expect(reservePage.getByRole('heading', { name: '宿泊予約' })).toBeVisible();

  // 宿泊数の入力
  await reservePage.getByLabel('宿泊数').fill(stayInfo.days);

  // 人数の入力
  await reservePage.getByLabel('人数').fill(stayInfo.people);

  // 指名の入力
  await reservePage.getByLabel('氏名').fill(stayInfo.name);

  // 確認のご連絡の選択
  await reservePage.getByLabel('確認のご連絡').selectOption('no');

  await reservePage.getByRole('button', {name: '予約内容を確認する'}).click(),

  // 宿泊予約確認
  await expect(reservePage.getByRole('heading', { name: '宿泊予約確認' })).toBeVisible();
  await expect(reservePage.locator('#term')).toContainText(`${checkinDate} 〜 ${checkoutDate} ${stayInfo.days}泊`);
  await expect(reservePage.locator('#head-count')).toContainText(`${stayInfo.people}名様`);
  await expect(reservePage.locator('#plans')).toContainText('なし');
  await expect(reservePage.locator('#username')).toContainText(stayInfo.name);
  await expect(reservePage.locator('#contact')).toContainText('希望しない');
  await expect(reservePage.locator('#comment')).toContainText('なし');

  // 予約完了処理
  await reservePage.getByRole('button', { name: 'この内容で予約する' }).click();
  await expect(reservePage.getByRole('heading', { name: '予約を完了しました' })).toBeVisible();
});