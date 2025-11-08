export function validCountNumber(args: number[]) {
  if(args.length === 0) {
    throw new Error("引数を指定してください");
  }  
  if(args.length >= 31) {
    throw new Error("引数は30個以下にしてください");
  }
}

export function add(args: number[]): number | string {
  validCountNumber(args);

  const result: number = args.reduce(
    (acc, cur) => acc + cur, 0
  );
  if (result > 1000) {
    return 'too big';
  }
  return result;
};

export function substract(args: number[]): number | string {
  validCountNumber(args);

  const result: number = args.reduce((acc, cur) => acc - cur);
  if (result < 0) {
    return 'negative number'
  }
  return result;
};

export function multi(args: number[]): number | string {
  validCountNumber(args);

  const result: number = args.reduce((acc, cur) => acc * cur);
  if (result > 1000) {
    return 'big big number';
  }
  return result;
};

export function divide(args: number[]): number | string {
  validCountNumber(args);

  const result: number = args.reduce((acc, cur) => {
    if (cur === 0) throw new Error("0で割ることはできません");
    return acc / cur
  });
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

console.log(funcName, numbers, result);