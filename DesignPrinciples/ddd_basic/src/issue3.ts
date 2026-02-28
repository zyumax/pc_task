// 「ドメイン知識が漏れている」とは、ドメインロジックが他の層(リポジトリやアプリケーション)で使われてしまっている状態

class Delivery {
  public recipient: string
  public deliveryDate: Date
  public price: number

  constructor(recipient: string, deliveryDate: Date, price: number) {
    this.recipient = recipient;
    this.deliveryDate = deliveryDate;
    this.price = price;
  }
}

// 以下はアプリケーション層に属するクラスと想定
// Deliveryクラスのpriceを使ってドメインロジックを記述
class Commission1 {
  check(d: Delivery) {
    if(d.price < 3000) {
      console.log('手数料が1000円かかります');
    }
  }
}

class Commission2 {
  check(d: Delivery) {
    if(d.price < 10000 && d.price >= 3000) {
      console.log('手数料が500円かかります');
    }
  }
}

class Commission3 {
  check(d: Delivery) {
    if(d.price >= 10000) {
      console.log('手数料はかかりません');
    }
  }
}

// 参考文献
// https://zenn.dev/praha/articles/92c6494570a4dc