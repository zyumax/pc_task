### 課題2

#### 課題2-1
境界づけられたコンテキストの実例を一つ挙げてください。
「宅配」の概念。日付というプロパティを持っているが、下記のような意味を持つ
宅配会社：出荷日
受取人(ユーザー)：受取日

#### 課題2-2
```typescript
type BloodType = 'A' | 'B' | 'O' | 'AB'

class Human {
  private readonly id: string;
  private bloodType: BloodType;
  private birthday: Date;
  private name: string;

  constructor(id: string, bloodType: BloodType, birthday: Date, name: string) {
    this.id = id;
    this.bloodType = bloodType;
    this.birthday = birthday;
    this.name = name;
  }

  getId(): string {
    return this.id;
  }

  getBloodType(): BloodType {
    return this.bloodType;
  }

  getBirthday(): Date {
    return new Date(this.birthday.getTime());
  }

  getName(): string {
    return this.name;
  }
}
```

#### 課題2-3
- バリデーションもクラス内で行っているので責務の範囲が大きくなっている

#### 課題2-4
```typescript
class Human {
    constructor(
      public readonly id: validId,
      public readonly bloodtype: validBloodtype,
      public readonly birthdate: validBirthdate,
      public readonly name: validName) {}
}

class validId {
  private readonly id: string

  constructor(id: string) {
    if (! this.confirmId(id)) {
      throw new Error("IDは英数字のみです")
    }
    this.id = id;
  }

  private confirmId(id: string) {
    const regex = /^[0-9a-zA-Z]+$/;

    if (regex.test(id)) {
      return true;
    }
    return false
  }
}

class validBloodtype {
  private readonly bloodtype: string;

  constructor(bloodtype: string) {
    if (! this.confirmBloodtype(bloodtype)) {
      throw new Error("血液型は指定のもの以外選択できません");
    }
    this.bloodtype = bloodtype
  }


  private confirmBloodtype(bloodtype: string): boolean {
    const bloodType: string[] = ['A', 'B', 'O', 'AB'];

    if (bloodType.includes(bloodtype)) {
      return true;
    }
    return false;
  }
}

class validBirthdate {
  private readonly birthdate: Date; 

  constructor(birthdate: Date) {
    if (!this.confirmDate(birthdate)) {
      throw new Error("20歳以上の生年月日しか設定できません");
    }
    this.birthdate = birthdate;
  }

  private confirmDate(birthdate: Date): boolean {
    const now = new Date();
    const twenty_years = 20;
    now.setFullYear(now.getFullYear() - twenty_years);
    if (birthdate.getTime() <= now.getTime()) {
      return true;
    }
    return false;
  }
}

class validName {
  private readonly name: string

  constructor(name: string) {
    if (! this.confirmName(name)) {
      throw new Error("名前は20文字未満でにしてください");
    }
    this.name = name;
  }

  private confirmName(name: string): boolean {
    const maxNumber = 20;
    if (name.length < maxNumber) {
      return true;
    }
    return false;
  }
}


// humanオブジェクト生成
const human = new Human(new validId('1'), new validBloodtype('A'), new validBirthdate(new Date('2000-01-01')), new validName('test'));
console.log(human);
```