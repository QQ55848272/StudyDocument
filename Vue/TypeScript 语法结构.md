# TypeScript 语法结构

TypeScript 语法结构与 JavaScript 相似，但在此基础上增加了类型系统、接口、泛型等特性，下面是 TypeScript 的基本语法结构：

------

## **1. 变量与类型**

TypeScript 支持显式类型声明和类型推导。

```typescript
// 基本类型
let num: number = 10;
let str: string = "Hello";
let isDone: boolean = true;

// 数组
let arr1: number[] = [1, 2, 3];
let arr2: Array<string> = ["a", "b", "c"];

// 元组 (Tuple)
let tuple: [string, number] = ["Alice", 25];

// 枚举 (Enum)
enum Color {
    Red,
    Green,
    Blue
}
let color: Color = Color.Green;

// 任意类型 (any)（尽量避免使用）
let anything: any = 42;
anything = "hello"; // ✅ 允许更改类型

// 空类型 (void)
function logMessage(): void {
    console.log("This is a message");
}

// `null` 和 `undefined`
let u: undefined = undefined;
let n: null = null;
```

------

## **2. 函数**

TypeScript 支持函数类型定义、可选参数、默认参数和剩余参数。

```typescript
// 函数的参数和返回值类型
function add(a: number, b: number): number {
    return a + b;
}

// 可选参数（`?` 表示可选）
function greet(name: string, age?: number): string {
    return age ? `Hello ${name}, age ${age}` : `Hello ${name}`;
}

// 默认参数
function greetDefault(name: string = "Guest"): string {
    return `Hello ${name}`;
}

// 剩余参数
function sum(...nums: number[]): number {
    return nums.reduce((prev, curr) => prev + curr, 0);
}

// 函数类型
let myFunc: (x: number, y: number) => number;
myFunc = add;
```

------

## **3. 接口 (Interface)**

接口用于定义对象的结构，约束对象的属性和方法。

```typescript
interface Person {
    name: string;
    age: number;
    sayHello(): void;
}

let user: Person = {
    name: "Alice",
    age: 25,
    sayHello() {
        console.log("Hello!");
    }
};

// 可选属性
interface Car {
    brand: string;
    model?: string; // `?` 表示可选属性
}
let myCar: Car = { brand: "Toyota" };

// 只读属性
interface Point {
    readonly x: number;
    readonly y: number;
}
let p1: Point = { x: 10, y: 20 };
// p1.x = 30; // ❌ 报错，`x` 是只读的
```

------

## **4. 类 (Class)**

TypeScript 支持面向对象编程，包括类、继承、访问修饰符等。

```typescript
class Animal {
    // 访问修饰符：public、private、protected
    public name: string;
    private age: number;
    protected type: string;

    constructor(name: string, age: number, type: string) {
        this.name = name;
        this.age = age;
        this.type = type;
    }

    speak(): void {
        console.log(`${this.name} makes a sound.`);
    }
}

// 继承
class Dog extends Animal {
    constructor(name: string, age: number) {
        super(name, age, "Dog");
    }

    speak(): void {
        console.log(`${this.name} barks.`);
    }
}

let myDog = new Dog("Buddy", 3);
myDog.speak(); // Buddy barks.
```

------

## **5. 泛型 (Generics)**

泛型提供了灵活的类型支持，适用于函数、接口、类等。

```typescript
// 泛型函数
function identity<T>(arg: T): T {
    return arg;
}
console.log(identity<number>(10)); // 10
console.log(identity<string>("Hello")); // Hello

// 泛型接口
interface Box<T> {
    value: T;
}
let box: Box<number> = { value: 100 };

// 泛型类
class DataStorage<T> {
    private data: T[] = [];

    addItem(item: T): void {
        this.data.push(item);
    }

    removeItem(item: T): void {
        this.data = this.data.filter(i => i !== item);
    }

    getItems(): T[] {
        return this.data;
    }
}
let storage = new DataStorage<string>();
storage.addItem("Apple");
storage.addItem("Banana");
console.log(storage.getItems()); // ["Apple", "Banana"]
```

------

## **6. 类型别名 & 交叉类型 & 联合类型**

```typescript
// 类型别名
type ID = number | string;
let userId: ID = 101;
userId = "abc"; // ✅ 允许

// 交叉类型（多个类型合并）
interface Person {
    name: string;
}
interface Employee {
    id: number;
}
type Worker = Person & Employee;
let worker: Worker = { name: "Bob", id: 1001 };

// 联合类型（多个类型取其一）
let value: number | string;
value = 42;
value = "Hello";
```

------

## **7. 类型断言**

类型断言用于手动指定变量类型，告诉编译器“我确定这个类型是对的”。

```typescript
let someValue: any = "This is a string";
let strLength: number = (someValue as string).length;
// 或者使用 <类型>
let strLength2: number = (<string>someValue).length;
```

------

## **8. 模块化**

TypeScript 支持 `import/export` 语法来组织代码模块。

```typescript
// 导出
export const pi = 3.14;
export function square(x: number): number {
    return x * x;
}

// 导入
import { pi, square } from "./math";
console.log(square(4)); // 16
```

------

## **9. 声明文件 (d.ts)**

当我们使用 JavaScript 库时，TypeScript 需要 `.d.ts` 文件来提供类型定义。
 例如，使用 `jQuery`：

```typescript
// 需要安装 @types/jquery
import * as $ from "jquery";
$("#id").text("Hello TypeScript");
```

------

### **总结**

| 特性         | TypeScript 语法                                   |
| ------------ | ------------------------------------------------- |
| **类型声明** | `let age: number = 25;`                           |
| **函数类型** | `function add(a: number, b: number): number {}`   |
| **接口**     | `interface Person { name: string; age: number; }` |
| **类**       | `class Animal { private name: string; }`          |
| **泛型**     | `function identity<T>(arg: T): T {}`              |
| **模块化**   | `import { func } from "./module";`                |
| **类型别名** | `type ID = number                                 |

TypeScript **增强了 JavaScript**，提供了更强的类型安全、代码可维护性和开发体验，是大型项目和团队开发的首选。🔥