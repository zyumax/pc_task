interface Purchase {
  userId: string
  productId: string
  transaction: {
    succeeded: true
    completedAt: Date
  }
}

interface PaymentRecordRepo {
  getPurchasesBy: (userId: string) => Purchase[]
}

interface Pay {
  pay(): void
}

class PurchaseService {
  public constructor(private payment: Pay, private validatePurchase: ValidatePurchase) {}

  public purchase(userId: string, productId: string) {
    this.validatePurchase.canPurchase(userId, productId)

    // 購入手続きに進む
    this.payment.pay();
  }
}

// バリデーションクラスを作成
class ValidatePurchase {
  public constructor(
    private paymentRecordRepo: PaymentRecordRepo,
    private OneYearPeriodRule: OneYearPeriodRule
  ) {}

  public canPurchase(userId: string, productId: string) {
    const allPurchases = this.paymentRecordRepo.getPurchasesBy(userId)
    this.OneYearPeriodRule.valid(allPurchases, productId);
  }
}

// 年間一つまでのバリデーション(他の条件が増えればクラスを増やしていく)
class OneYearPeriodRule {
  public valid(allPurchases: Purchase[], productId: string) {
    const oneYearAgo = new Date();
    oneYearAgo.setFullYear(oneYearAgo.getFullYear() - 1);
    const recentPurchase = allPurchases.find(
      (p) => p.productId === productId && p.transaction.succeeded && (p.transaction.completedAt > oneYearAgo)
    )
    if (recentPurchase) {
      throw new Error('この商品は前回の購入日から一年たつまで買えません！')
    }
  }
}

// クレジットカードで支払うと想定
class CreditCardPayment implements Pay {
  public pay() :void{
    // ****
  }
}