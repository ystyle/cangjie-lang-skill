# 仓颉语言函数式特性详解

> 本文档详细说明仓颉语言的函数式编程特性，包括 Lambda 表达式、高阶函数、闭包、命名参数等。

---

## 目录

- [函数是一等公民](#函数是一等公民)
- [Lambda 表达式](#lambda-表达式)
- [高阶函数](#高阶函数)
- [闭包](#闭包)
- [命名参数](#命名参数)
- [常见使用场景](#常见使用场景)
- [⚠️ 易错点](#易错点)

---

## 函数是一等公民

在仓颉中，函数具有"一等公民"（First-Class）特性，这意味着：

1. **可以作为参数传递**：函数可以作为其他函数的参数
2. **可以作为返回值**：函数可以返回另一个函数
3. **可以赋值给变量**：函数可以存储在变量中
4. **有类型**：函数本身也有类型

### 函数类型

**语法**：`(参数类型) -> 返回类型`

```cj
// 函数类型定义
type IntFunc = (Int64) -> Int64
type BinaryOp = (Int64, Int64) -> Int64
type Predicate = (Int64) -> Bool
```

### 示例

```cj
// 定义一个函数
func add(a: Int64, b: Int64): Int64 {
    a + b
}

// 函数类型变量
let f: (Int64, Int64) -> Int64 = add
let result = f(10, 20)  // result = 30

// 函数作为参数
func apply(x: Int64, y: Int64, operation: (Int64, Int64) -> Int64): Int64 {
    operation(x, y)
}

let sum = apply(5, 3, add)  // sum = 8

// 函数作为返回值
func getOperation(op: String): (Int64, Int64) -> Int64 {
    if (op == "add") {
        { a, b => a + b }
    } else {
        { a, b => a - b }
    }
}

let operation = getOperation("add")
let result2 = operation(10, 5)  // result2 = 15
```

---

## Lambda 表达式

Lambda 表达式（匿名函数）是函数式编程的核心特性。

### 语法

```cj
{ 参数列表 => 表达式或语句列表 }
```

**完整语法**：
```cj
{ p1: T1, p2: T2, ..., pn: Tn => 表达式 | 声明 }
```

### 基本示例

```cj
// 1. 完整类型声明
let f1 = { a: Int64, b: Int64 => a + b }

// 2. 类型推断
let f2: (Int64, Int64) -> Int64 = { a, b => a + b }
let f3: (Int64, Int64) -> Int64 = { a: Int64, b => a + b }

// 3. 无参 Lambda
let display = { =>
    println("Hello from Lambda")
}

// 4. 多行 Lambda
let calculate = { a: Int64, b: Int64 =>
    let sum = a + b
    let product = a * b
    sum + product
}
```

### ⚠️ Lambda 立即调用

Lambda 表达式可以在定义后立即调用：

```cj
// Lambda 立即调用
let result = { => 42 }()  // result = 42

// 等价于
func temp(): Int64 {
    42
}
let result2 = temp()

// 带参数的 Lambda 立即调用
let sum = { a: Int64, b: Int64 => a + b }(10, 20)  // sum = 30
```

**使用场景**：
- 创建作用域
- 计算复杂表达式
- 初始化复杂变量

```cj
// 使用 Lambda 创建作用域
let value = {
    var temp = 10
    temp = temp + 5
    temp
}()
```

---

## 高阶函数

高阶函数（Higher-Order Function）是指：
- 接受函数作为参数的函数
- 返回函数的函数

### 常见高阶函数模式

#### 1. map - 转换集合元素

```cj
func map<T, R>(array: Array<T>, f: (T) -> R): Array<R> {
    var result = Array<R>()
    for (item in array) {
        result.append(f(item))
    }
    result
}

// 使用
let numbers = [1, 2, 3, 4, 5]
let doubled = map(numbers, { x => x * 2 })  // [2, 4, 6, 8, 10]
```

#### 2. filter - 过滤集合元素

```cj
func filter<T>(array: Array<T>, predicate: (T) -> Bool): Array<T> {
    var result = Array<T>()
    for (item in array) {
        if (predicate(item)) {
            result.append(item)
        }
    }
    result
}

// 使用
let numbers = [1, 2, 3, 4, 5, 6]
let evens = filter(numbers, { x => x % 2 == 0 })  // [2, 4, 6]
```

#### 3. reduce - 归约集合

```cj
func reduce<T>(array: Array<T>, initial: T, f: (T, T) -> T): T {
    var result = initial
    for (item in array) {
        result = f(result, item)
    }
    result
}

// 使用
let numbers = [1, 2, 3, 4, 5]
let sum = reduce(numbers, 0, { acc, x => acc + x })  // 15
let product = reduce(numbers, 1, { acc, x => acc * x })  // 120
```

### 自定义高阶函数

```cj
// 函数作为参数
func applyOperation(a: Int64, b: Int64, op: (Int64, Int64) -> Int64): Int64 {
    op(a, b)
}

func compare(a: Int64, b: Int64, comparator: (Int64, Int64) -> Bool): Bool {
    comparator(a, b)
}

// 使用
let addResult = applyOperation(10, 20, { x, y => x + y })
let maxResult = applyOperation(10, 20, { x, y => if (x > y) x else y })

let isGreater = compare(10, 20, { a, b => a > b })
```

---

## 闭包

闭包（Closure）是指函数可以访问其定义作用域外的变量。

### 基本闭包

```cj
func makeCounter(): () -> Int64 {
    var count = 0

    // 返回的 Lambda 捕获了 count 变量
    return {
        count = count + 1
        count
    }
}

main() {
    let counter1 = makeCounter()
    println(counter1())  // 输出: 1
    println(counter1())  // 输出: 2
    println(counter1())  // 输出: 3

    let counter2 = makeCounter()
    println(counter2())  // 输出: 1（counter2 有独立的 count）
}
```

### 捕获外部变量

```cj
func makeAdder(n: Int64): (Int64) -> Int64 {
    // Lambda 捕获了参数 n
    return { x => x + n }
}

main() {
    let add5 = makeAdder(5)
    let add10 = makeAdder(10)

    println(add5(3))   // 输出: 8
    println(add10(3))  // 输出: 13
}
```

### 闭包修改变量

```cj
func accumulate(): (Int64) -> Int64 {
    var sum = 0

    return { x =>
        sum = sum + x
        sum
    }
}

main() {
    let acc = accumulate()
    println(acc(10))  // 输出: 10
    println(acc(20))  // 输出: 30
    println(acc(30))  // 输出: 60
}
```

---

## 命名参数

仓颉支持命名参数（Named Parameters），允许在调用函数时指定参数名称。

### 语法

使用 `!` 标记命名参数：

```cj
func 函数名(参数名!: 类型, 参数名!: 类型 = 默认值) {
    // 函数体
}
```

### 基本用法

```cj
func greet(name!: String, age!: Int64 = 25, city!: String = "北京") {
    println("姓名: ${name}, 年龄: ${age}, 城市: ${city}")
}

main() {
    // 1. 使用命名参数（可以不按顺序）
    greet(name: "张三", age: 30, city: "上海")

    // 2. 使用默认值（省略 age 和 city）
    greet(name: "李四")  // 输出: 姓名: 李四, 年龄: 25, 城市: 北京

    // 3. 部分使用默认值
    greet(name: "王五", city: "深圳")  // 输出: 姓名: 王五, 年龄: 25, 城市: 深圳

    // 4. 命名参数可以不按顺序
    greet(age: 35, name: "赵六", city: "广州")
}
```

### 优势

1. **可读性强**：调用时明确参数含义
2. **灵活顺序**：可以不按声明顺序传递参数
3. **默认值**：可以省略有默认值的参数
4. **自文档化**：函数调用更清晰

---

## 常见使用场景

### 1. 回调函数

```cj
func fetchData(url: String, callback: (String) -> Unit): Unit {
    // 模拟异步操作
    let data = "Data from ${url}"
    callback(data)
}

main() {
    fetchData("https://example.com", { data =>
        println("Received: ${data}")
    })
}
```

### 2. 策略模式

```cj
func calculateStrategy(a: Int64, b: Int64, strategy: (Int64, Int64) -> Int64): Int64 {
    strategy(a, b)
}

main() {
    let add = { x, y => x + y }
    let multiply = { x, y => x * y }
    let max = { x, y => if (x > y) x else y }

    println(calculateStrategy(10, 20, add))      // 30
    println(calculateStrategy(10, 20, multiply)) // 200
    println(calculateStrategy(10, 20, max))      // 20
}
```

### 3. 延迟执行

```cj
func delayExecution(seconds: Int64, action: () -> Unit): Unit {
    // 模拟延迟
    println("Waiting ${seconds} seconds...")
    action()
}

main() {
    delayExecution(2, { =>
        println("Action executed!")
    })
}
```

### 4. 函数组合

```cj
func compose<T>(f: (T) -> T, g: (T) -> T): (T) -> T {
    return { x => g(f(x)) }
}

main() {
    let addOne = { x: Int64 => x + 1 }
    let multiplyTwo = { x: Int64 => x * 2 }

    // 组合函数：先加1，再乘2
    let addThenMultiply = compose(addOne, multiplyTwo)

    println(addThenMultiply(5))  // 输出: 12 (5 + 1 = 6, 6 * 2 = 12)
}
```

---

## ⚠️ 易错点

### 1. 函数参数不可变

⚠️ **易错点2**：函数参数默认是 `let` 不可变的，不能在函数内部修改。

```cj
// ❌ 错误
func increment(a: Int64): Int64 {
    a = a + 1  // 编译错误
    return a
}

// ✅ 正确
func increment(a: Int64): Int64 {
    return a + 1  // 不修改原参数
}

// ✅ 正确：使用局部变量
func increment(a: Int64): Int64 {
    var result = a
    result = result + 1
    return result
}
```

### 2. Lambda 立即调用

⚠️ **易错点12**：Lambda 表达式可以立即调用，这可能让初学者困惑。

```cj
let result = { => 42 }()  // 注意最后的 ()，表示立即调用

// 等价于
func temp(): Int64 {
    42
}
let result2 = temp()
```

### 3. 闭包变量捕获

⚠️ **注意**：闭包捕获的是变量的引用，不是值的副本。

```cj
func createCounters(): Array<() -> Int64> {
    var counters = Array<() -> Int64>()

    for (i in 1..=3) {
        // 每次循环都捕获同一个 i 变量
        counters.append({ => i })
    }

    return counters
}

main() {
    let counters = createCounters()
    for (counter in counters) {
        println(counter())  // 所有 counter 都输出 4（循环结束后的值）
    }
}
```

**正确做法**：使用参数捕获当前值

```cj
func createCounters(): Array<() -> Int64> {
    var counters = Array<() -> Int64>()

    for (i in 1..=3) {
        // 使用参数捕获当前值
        let makeCounter = { (n: Int64) => { => n } }(i)
        counters.append(makeCounter)
    }

    return counters
}
```

---

## 参考章节

- **SKILL.md 第2.4节**：函数定义与使用
- **examples/04_functions.cj**：函数示例代码
- **reference/05_common_pitfalls.md**：易错点详解（易错点2、12）

---

**文档维护**：仓颉语言社区
**最后更新**：2025-01-07
**版本**：v1.0.0
