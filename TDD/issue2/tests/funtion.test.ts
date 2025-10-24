import {add} from '../src/function';
import {substract} from '../src/function';
import {multi} from '../src/function';
import {divide} from '../src/function';

describe('足し算のテスト', () => {
  test('2つの数字を足す', () => {
    // Act & Assert
    expect(add([2,3])).toBe(5);
  });

  test('3つの数字を足す', () => {
    // Act & Assert
    expect(add([2,3,4])).toBe(9);
  });

  test('足し算の結果が1000を超える場合、too bigを返す', () => {
    // Act & Assert
    expect(add([1000,3,4])).toBe('too big');
  });

  test('引数が31個以上の場合、エラーを返す', () => {
    // Act & Assert
    expect(() => add([1,2,3,4,5,6,7,8,9,10,1,2,3,4,5,6,7,8,9,10,1,2,3,4,5,6,7,8,9,10,1]))
    .toThrow(new Error('引数は30個以下にしてください'));
  });

  test('引数が0個の場合、エラーを返す', () => {
    // Act & Assert
    expect(() => add([])).toThrow(new Error('引数を指定してください'));
  });
});

describe('引き算のテスト', () => {
  test('2つの数字を引く', () => {
    expect(substract([5,3])).toBe(2)
  });

  test('3つの数字を引く', () => {
    expect(substract([5,3,1])).toBe(1);
  });

  test('計算結果がマイナスの場合、negative numberを返す', () => {
    expect(substract([1, 3])).toBe('negative number')
  });

  test('引数が31個以上の場合、エラーを返す', () => {
    // Act & Assert
    expect(() => substract([1,2,3,4,5,6,7,8,9,10,1,2,3,4,5,6,7,8,9,10,1,2,3,4,5,6,7,8,9,10,1]))
    .toThrow(new Error('引数は30個以下にしてください'));
  });

  test('引数が0個の場合、エラーを返す', () => {
    // Act & Assert
    expect(() => substract([])).toThrow(new Error('引数を指定してください'));
  });
});

describe('掛け算のテスト', () => {
  test('2つの数字をかける', () => {
    // Act & Assert
    expect(multi([2,3])).toBe(6);
  });

  test('3つの数字をかける', () => {
    // Act & Assert
    expect(multi([2,3,4])).toBe(24);
  });

  test('1000以上の計算結果の場合、big big numberを返す', () => {
    expect(multi([100, 20])).toBe('big big number');
  });

  test('引数が31個以上の場合、エラーを返す', () => {
    // Act & Assert
  expect(() => multi([1,2,3,4,5,6,7,8,9,10,1,2,3,4,5,6,7,8,9,10,1,2,3,4,5,6,7,8,9,10,1]))
  .toThrow(new Error('引数は30個以下にしてください'));
  });

  test('引数が0個の場合、エラーを返す', () => {
    // Act & Assert
    expect(() => multi([])).toThrow(new Error('引数を指定してください'));
  });
});


describe('割り算のテスト', () => {
  test('2つの数字の割り算', () => {
    expect(divide([4,2])).toBe(2);
  });

  test('3つの数字の割り算', () => {
    expect(divide([4,2,1])).toBe(2);
  });

  test('割り切れない場合の割り算', () => {
    expect(divide([10,3])).toBe(3.3);
  });

  test('0で除算した場合にエラーを返す', () => {
    expect(() => divide([10,0])).toThrow(new Error("0で割ることはできません"))
    expect(() => divide([10,0])).toThrow('0で割ることはできません');
  });

  test('引数が31個以上の場合、エラーを返す', () => {
    // Act & Assert
    expect(() => divide([1,2,3,4,5,6,7,8,9,10,1,2,3,4,5,6,7,8,9,10,1,2,3,4,5,6,7,8,9,10,1]))
    .toThrow(new Error('引数は30個以下にしてください'));
  });

  test('引数が0個の場合、エラーを返す', () => {
      // Act & Assert
      expect(() => divide([])).toThrow(new Error('引数を指定してください'));
      expect(() => divide([])).toThrow('引数を指定してください');
  });
});