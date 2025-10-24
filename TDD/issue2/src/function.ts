export function add(args: number[]): number | string {
  if(args.length === 0) {
    throw new Error("引数を指定してください");
  }  
  if(args.length >= 31) {
    throw new Error("引数は30個以下にしてください");
  }
  const total: number = args.reduce(
    (acc, cur) => acc + cur, 0
  );
  if (total > 1000) {
    return 'too big';
  }
  return total;
};

export function substract(args: number[]): number | string {
  if(args.length === 0) {
    throw new Error("引数を指定してください");
  }  
  if(args.length >= 31) {
    throw new Error("引数は30個以下にしてください");
  }
  const total = args.reduce((acc, cur) => acc - cur);
  if (total < 0) {
    return 'negative number'
  }
  return total;
};

export function multi(args: number[]): number | string {
  if(args.length === 0) {
    throw new Error("引数を指定してください");
  }  
  if(args.length >= 31) {
    throw new Error("引数は30個以下にしてください");
  }
  const total = args.reduce((acc, cur) => acc * cur);
  if (total > 1000) {
    return 'big big number';
  }
  return total;
};

export function divide(args: number[]): number | string {
  if(args.length === 0) {
    throw new Error("引数を指定してください");
  }  
  if(args.length >= 31) {
    throw new Error("引数は30個以下にしてください");
  }

  const result: number = args.reduce((acc, cur) => {
    if (cur === 0) throw new Error("0で割ることはできません");
    return acc / cur
  });
  const getNum = Number.isInteger(result) ? result : Math.round(result * 10) / 10;

  return getNum;
};