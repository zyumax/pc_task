export function validCountNumber(args: number[]): string | null {
  const isString = args.some(arg => Number.isNaN(arg));
  if(isString) {
    return '引数は数字にしてください';
  }
  if(args.length === 0) {
    return '引数を指定してください';
  }  
  if(args.length >= 31) {
    return '引数は30個以下にしてください';
  }
  return null;
}

export function add(args: number[]): number | string {
  const error = validCountNumber(args);
  if (error) {
    return error;
  }

  const result: number = args.reduce((acc, cur) => acc + cur, 0);
  if (result > 1000) {
    return 'too big';
  }
  return result;
};

export function substract(args: number[]): number | string {
  const error = validCountNumber(args);
  if (error) {
    return error;
  }

  const initialValue = args[0];
  const result: number = args.slice(1).reduce((acc, cur) => acc - cur, initialValue);
  if (result < 0) {
    return 'negative number'
  }
  return result;
};

export function multi(args: number[]): number | string {
  const error = validCountNumber(args);
  if (error) {
    return error;
  }

  const result: number = args.reduce((acc, cur) => acc * cur, 1);
  if (result > 1000) {
    return 'big big number';
  }
  return result;
};

export function divide(args: number[]): number | string {
  const error = validCountNumber(args);
  if (error) {
    return error;
  }

  const hasZero = args.slice(1).some(arg => arg === 0);
  if (hasZero) {
    return '0で割ることはできません';
  }

  const initialValue = args[0];
  const result: number = args.slice(1).reduce((acc, cur) => acc / cur, initialValue);
  // resultが整数の場合はそのまま表示、そうでない場合は小数点一桁までを表示
  const round1dp = Number.isInteger(result) ? result : Math.round(result * 10) / 10;

  return round1dp;
};

const funcName = process.argv[2];
const numbers = process.argv.slice(3).map(Number);

let result
if (funcName === 'add') {
  result = add(numbers);
} else if (funcName === 'substract') {
  result = substract(numbers);
} else if (funcName === 'multi') {
  result = multi(numbers);
} else if (funcName === 'divide') {
  result = divide(numbers);
} else {
  result = '関数を定義してください'
}

// node function.js add 1 2 3
// npx ts-node function.ts add 1 2 3
// console.log(funcName, numbers, result);