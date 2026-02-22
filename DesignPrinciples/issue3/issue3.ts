// privateで、外部からアクセスできないように変更
class Person {
    private name: string
    private starWorkingAt: Date
    constructor(name: string, startWorkingAt: Date) {
        this.name = name
        this.starWorkingAt = startWorkingAt
    }
}

class Company {
    private people: Person[]
    constructor(people: Person[]) {
        this.people = [...people];
    }

    get getPeople(): readonly Person[] {
        return this.people;
    }

    // personが増えたとき用のメソッドを追加
    addPerson(person: Person) {
        this.people.push(person);
    }
}