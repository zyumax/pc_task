import {add, substract, multi, divide, validCountNumber} from '../src/function';

describe('四則演算のテスト', () => {
  describe('共通部分', () => {
    test('引数が数字でない場合のエラー', () => {
      expect(validCountNumber([1,2,NaN])).toBe('引数は数字にしてください');
    });
    test('引数なしのエラー', () => {
      expect(validCountNumber([])).toBe('引数を指定してください');
    });
    test('引数が31個以上はエラー', () => {
      const arr = new Array(31).fill(1);
      expect(validCountNumber(arr)).toBe('引数は30個以下にしてください');
    });
    test('引数が30個まではOK', () => {
      const arr = new Array(30).fill(1);
      expect(validCountNumber(arr)).toBeNull();
    });
  });
  describe('addの部分', () => {
    test('2つの数字を足す', () => {
      expect(add([2,3])).toBe(5);
    });
    test('3つの数字を足す', () => {
      expect(add([2,3,4])).toBe(9);
    });
    test('結果が1000の場合', () => {
      expect(add([600,400])).toBe(1000);
    });
    test('足し算の結果が1000を超える場合、too bigを返す', () => {
      expect(add([1000,3,4])).toBe('too big');
    });
    test('addで引数が31個以上はエラー', () => {
      const arr = new Array(31).fill(1);
      expect(add(arr)).toBe('引数は30個以下にしてください');
    });
    test('addで引数なしのエラー', () => {
      expect(add([])).toBe('引数を指定してください');
    });
    test('引数が数字でない場合のエラー', () => {
      expect(add([1,2,NaN])).toBe('引数は数字にしてください');
    });
  });
  describe('substractの部分', () => {
    test('2つの数字を引く', () => {
      expect(substract([5,3])).toBe(2)
    });
    test('3つの数字を引く', () => {
      expect(substract([5,3,1])).toBe(1);
    });
    test('結果が0の場合', () => {
      expect(substract([5,5])).toBe(0);
    });
    test('計算結果がマイナスの場合、negative numberを返す', () => {
      expect(substract([1, 3])).toBe('negative number')
    });
    test('substractで引数が31個以上はエラー', () => {
      const arr = new Array(31).fill(1);
      expect(substract(arr)).toBe('引数は30個以下にしてください');
    });
    test('substractで引数なしのエラー', () => {
      expect(substract([])).toBe('引数を指定してください');
    });
    test('引数が数字でない場合のエラー', () => {
      expect(substract([5,2,NaN])).toBe('引数は数字にしてください');
    });
  });
  describe('multipleの部分', () => {
    test('2つの数字をかける', () => {
      expect(multi([5,3])).toBe(15)
    });
    test('3つの数字をかける', () => {
      expect(multi([5,3,2])).toBe(30);
    });
    test('結果が1000の場合', () => {
      expect(multi([100,10])).toBe(1000);
    });
    test('1000以上の計算結果の場合、big big numberを返す', () => {
      expect(multi([100, 20])).toBe('big big number');
    });
    test('multiで引数が31個以上はエラー', () => {
      const arr = new Array(31).fill(1);
      expect(multi(arr)).toBe('引数は30個以下にしてください');
    });
    test('multiで引数なしのエラー', () => {
      expect(multi([])).toBe('引数を指定してください');
    });
    test('multiで引数が数字でない場合のエラー', () => {
      expect(multi([5,2,NaN])).toBe('引数は数字にしてください');
    });
  });
  describe('divideの部分', () => {
    test('2つの数字の割り算', () => {
      expect(divide([10,5])).toBe(2);
    });
    test('3つの数字の割り算', () => {
      expect(divide([30,5,2])).toBe(3);
    });
    test('0が先頭の場合', () => {
      expect(divide([0,3,1])).toBe(0);
    });
    test('割り切れない場合の割り算', () => {
      expect(divide([10,3])).toBe(3.3);
    });
    test('0で除算した場合にエラーを返す', () => {
      expect(divide([10,2,0])).toBe('0で割ることはできません');
    });
    test('divideで引数が31個以上はエラー', () => {
      const arr = new Array(31).fill(1);
      expect(divide(arr)).toBe('引数は30個以下にしてください');
    });
    test('divideで引数なしのエラー', () => {
      expect(divide([])).toBe('引数を指定してください');
    });
    test('divideで引数が数字でない場合のエラー', () => {
      expect(divide([5,2,NaN])).toBe('引数は数字にしてください');
    });
  });
});