import {add, substract, multi, divide, validCountNumber} from '../src/function';

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

describe('共通化のテスト', () => {
  describe('共通部分', () => {
    test('引数なしのエラー', () => {
      expect(() => validCountNumber([])).toThrow(new Error('引数を指定してください'));
    });
    test('引数が31個以上はエラー', () => {
      const arr = new Array(31).fill(1);
      expect(() => validCountNumber(arr)).toThrow('引数は30個以下にしてください');
    });
    test('引数が30個まではOK', () => {
      const arr = new Array(30).fill(1);
      expect(() => validCountNumber(arr)).not.toThrow();
    });
  });
  describe('addの部分', () => {
    test('addの確認', () => {
      expect(add([2,3])).toBe(5);
    });
    test('addが1000の場合は1000を返す', () => {
      expect(add([600,400])).toBe(1000);
    });
    test('足し算の結果が1000を超える場合、too bigを返す', () => {
      // Act & Assert
      expect(add([1000,3,4])).toBe('too big');
    });
    test('addで引数が31個以上はエラー', () => {
      const arr = new Array(31).fill(1);
      expect(() => add(arr)).toThrow('引数は30個以下にしてください');
    });
    test('addで引数なしのエラー', () => {
      expect(() => add([])).toThrow(new Error('引数を指定してください'));
    });
  });
  describe('substractの部分', () => {
    test('2つの数字を引く', () => {
      expect(substract([5,3])).toBe(2)
    });
    test('3つの数字を引く', () => {
      expect(substract([5,3,1])).toBe(1);
    });
    test('計算結果がマイナスの場合、negative numberを返す', () => {
      expect(substract([1, 3])).toBe('negative number')
    });
    test('substractで引数が31個以上はエラー', () => {
      const arr = new Array(31).fill(1);
      expect(() => substract(arr)).toThrow('引数は30個以下にしてください');
    });
    test('substractで引数なしのエラー', () => {
      expect(() => substract([])).toThrow(new Error('引数を指定してください'));
    });
  });
  describe('multipleの部分', () => {
    test('2つの数字をかける', () => {
      expect(multi([5,3])).toBe(15)
    });
    test('3つの数字をかける', () => {
      expect(multi([5,3,2])).toBe(30);
    });
    test('1000以上の計算結果の場合、big big numberを返す', () => {
      expect(multi([100, 20])).toBe('big big number');
    });
    test('multiで引数が31個以上はエラー', () => {
      const arr = new Array(31).fill(1);
      expect(() => multi(arr)).toThrow('引数は30個以下にしてください');
    });
    test('multiで引数なしのエラー', () => {
      expect(() => multi([])).toThrow(new Error('引数を指定してください'));
    });
  });
  describe('divideの部分', () => {
    test('2つの数字の割り算', () => {
      expect(divide([4,2])).toBe(2);
    });
    test('3つの数字の割り算', () => {
      expect(divide([30,5,2])).toBe(3);
    });
    test('割り切れない場合の割り算', () => {
      expect(divide([10,3])).toBe(3.3);
    });
    test('0で除算した場合にエラーを返す', () => {
      expect(() => divide([10,0])).toThrow(new Error("0で割ることはできません"))
      expect(() => divide([10,0])).toThrow('0で割ることはできません');
    });
    test('multiで引数が31個以上はエラー', () => {
      const arr = new Array(31).fill(1);
      expect(() => divide(arr)).toThrow('引数は30個以下にしてください');
    });
    test('multiで引数なしのエラー', () => {
      expect(() => divide([])).toThrow(new Error('引数を指定してください'));
    });
  });
});