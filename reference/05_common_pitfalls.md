# 仓颉语言19个⚠️易错点详解

> 本文档详细展开 SKILL.md 中标注的19个易错点，包括错误原因、修正建议和正确示例对比。

---

## 目录

- [变量相关（1-3）](#变量相关)
- [控制流相关（4-6）](#控制流相关)
- [类型转换相关（7-8）](#类型转换相关)
- [模式匹配相关（9-10）](#模式匹配相关)
- [字符串相关（11）](#字符串相关)
- [函数相关（12）](#函数相关)
- [类型系统相关（13）](#类型系统相关)
- [其他（14-19）](#其他)

---

## 变量相关

### ⚠️ 易错点1：`let` 不支持变量遮蔽（shadowing）

**问题描述**：
在 Rust 等语言中，允许在同一作用域内用 `let` 重新定义同名变量（变量遮蔽）。但仓颉的 `let` **不支持**这一特性。

**错误示例**：
```cj
main() {
    let x = 10
    println(x)  // 输出: 10

    let x = 20  // ❌ 编译错误：不能重新定义变量 x
    println(x)
}
```

**错误原因**：
仓颉语言设计选择不允许变量遮蔽，避免代码可读性问题和潜在的错误。

**修正方案1：使用 `var`**
```cj
main() {
    var x = 10
    println(x)  // 输出: 10

    x = 20      // ✅ 修改 var 变量
    println(x)  // 输出: 20
}
```

**修正方案2：使用不同变量名**
```cj
main() {
    let x = 10
    println(x)  // 输出: 10

    let y = 20  // ✅ 使用不同的变量名
    println(y)  // 输出: 20
}
```

⚠️ **注意**：仓颉不支持使用内部作用域 `{ }` 来重新定义同名变量，因为 `{ }` 语法已经被 Lambda 表达式占用。

**参考章节**：SKILL.md 第2.1节

---

### ⚠️ 易错点2：函数参数默认是 `let` 不可变

**问题描述**：
仓颉函数的参数默认使用 `let` 定义，是**不可变的**。如果在函数内部尝试修改参数值，会导致编译错误。

**错误示例**：
```cj
func increment(a: Int64): Int64 {
    a = a + 1  // ❌ 编译错误：不能修改 let 参数
    return a
}
```

**错误原因**：
函数参数默认是 `let` 不可变变量，这是仓颉的默认设计，保证函数的纯净性和可预测性。

**修正方案1：不修改参数（推荐）**
```cj
func increment(a: Int64): Int64 {
    return a + 1  // ✅ 不修改原参数
}
```

**修正方案2：使用局部变量**
```cj
func increment(a: Int64): Int64 {
    var result = a
    result = result + 1
    return result
}
```

**注意事项**：
- 函数参数默认是 `let` 不可变的（**不能显式写 `let` 或 `var`**）
- ⚠️ **仓颉完全不支持在函数参数上使用 `let` 或 `var` 修饰符**（包括顶层函数、class成员方法、struct成员方法等所有函数）
- 如果需要修改值，应该使用局部变量
- 在 class/struct 中，应该直接修改字段值，而不是修改参数

**class 中如何修改字段值？**

```cj
class Counter {
    private var value: Int64 = 0

    public func increment(): Unit {
        this.value = this.value + 1  // ✅ 修改字段值
    }

    public func add(delta: Int64): Unit {
        this.value = this.value + delta  // ✅ 使用参数计算，修改字段
    }
}
```

**参考章节**：SKILL.md 第2.4节

---

### ⚠️ 易错点3：成员变量默认访问修饰符是 `internal`

**问题描述**：
class 的成员（变量、属性、函数）的默认访问修饰符是 `internal`，不是 `private` 或 `public`。

**错误理解**：
```cj
class Example {
    let value: Int64  // ❌ 误认为默认是 private

    func getValue(): Int64 {
        return value
    }
}
```

**实际情况**：
```cj
class Example {
    let value: Int64  // ✅ 实际是 internal（当前包及子包可见）

    func getValue(): Int64 {
        return value
    }
}

// 同一个包内
main() {
    let e = Example()
    println(e.value)  // ✅ 可以访问（因为是 internal）
}
```

**访问修饰符对比**：

| 修饰符 | 范围 | 是否默认 |
|--------|------|---------|
| `private` | 仅 class 定义内可见 | ❌ |
| `internal` | 当前包及子包内可见 | ✅ **默认** |
| `protected` | 当前模块及当前类的子类可见 | ❌ |
| `public` | 模块内外均可见 | ❌ |

**修正建议**：
根据实际需求显式声明访问修饰符：

```cj
class Example {
    private let secret: Int64 = 42       // 仅class内可见
    internal let internalValue: Int64 = 10  // 包内可见（可省略）
    protected let protectedValue: Int64 = 20 // 模块及子类可见
    public let publicValue: Int64 = 30       // 完全公开
}
```

**参考章节**：SKILL.md 第2.8节

---

## 控制流相关

### ⚠️ 易错点4：所有条件表达式必须有括号

**问题描述**：
仓颉语言要求 `if`、`while`、`for-in` 等控制结构的条件表达式**必须使用括号**，不能省略。

**错误示例**：
```cj
let x = 10

if x > 5 {              // ❌ 编译错误：缺少括号
    println("x > 5")
}

while x > 0 {           // ❌ 编译错误：缺少括号
    x--
}
```

**正确写法**：
```cj
let x = 10

if (x > 5) {            // ✅ 必须有括号
    println("x > 5")
}

while (x > 0) {         // ✅ 必须有括号
    x--
}
```

**易错原因**：
很多现代编程语言（如 Go、Rust）允许省略条件表达式的括号，但仓颉要求必须保留。

**对比其他语言**：
```go
// Go 语言（可以省略括号）
if x > 5 {
    println("x > 5")
}
```

```cj
// 仓颉（必须保留括号）
if (x > 5) {
    println("x > 5")
}
```

**参考章节**：SKILL.md 第2.3节

---

### ⚠️ 易错点5：不支持 `goto`

**问题描述**：
仓颉语言**完全不支持** `goto` 语句。

**错误示例**：
```cj
main() {
    let x = 0

start:
    println(x)
    x++

    if (x < 10) {
        goto start  // ❌ 编译错误：不支持 goto
    }
}
```

**错误原因**：
`goto` 语句容易导致"意大利面条式代码"，降低代码可读性和可维护性。仓颉选择不支持 `goto`，鼓励使用结构化编程。

**修正方案1：使用 while 循环**
```cj
main() {
    var x = 0

    while (x < 10) {
        println(x)
        x++
    }
}
```

**修正方案2：使用 for-in 循环**
```cj
main() {
    for (x in 0..9) {
        println(x)
    }
}
```

**修正方案3：使用函数**
```cj
func process(value: Int64): Unit {
    println(value)

    if (value < 9) {
        process(value + 1)  // 递归调用
    }
}

main() {
    process(0)
}
```

**参考章节**：SKILL.md 第2.3节

---

### ⚠️ 易错点6 & 7：`break`/`continue` 不支持标签跳转

**问题描述**：
仓颉支持 `break` 和 `continue`，但**不支持标签跳转**。在嵌套循环中，不能使用标签跳出多层循环。

**错误示例**：
```cj
main() {
    outerLoop:
    for (i in 0..5) {
        for (j in 0..5) {
            if (i == 2 && j == 2) {
                break outerLoop  // ❌ 编译错误：不支持标签跳转
            }
            println("(${i}, ${j})")
        }
    }
}
```

**错误原因**：
标签跳转会增加控制流的复杂性，仓颉选择不支持这一特性。

**修正方案1：使用布尔标志**
```cj
main() {
    var shouldBreak = false

    for (i in 0..5) {
        for (j in 0..5) {
            if (i == 2 && j == 2) {
                shouldBreak = true
                break  // 只跳出内层循环
            }
            println("(${i}, ${j})")
        }
        if (shouldBreak) {
            break  // 跳出外层循环
        }
    }
}
```

**修正方案2：使用函数**
```cj
func processNested(): Unit {
    for (i in 0..5) {
        for (j in 0..5) {
            if (i == 2 && j == 2) {
                return  // 直接返回，跳出所有循环
            }
            println("(${i}, ${j})")
        }
    }
}

main() {
    processNested()
}
```

**修正方案3：重构为单层循环**
```cj
main() {
    for (index in 0..29) {  // 6 * 5 = 30
        let i = index / 6
        let j = index % 6

        if (i == 2 && j == 2) {
            break
        }
        println("(${i}, ${j})")
    }
}
```

**参考章节**：SKILL.md 第2.3节

---

## 类型转换相关

### ⚠️ 易错点7：Rune 转整数需确保在有效 Unicode 范围

**问题描述**：
将整数转换为 `Rune` 类型时，必须确保值在有效的 Unicode 范围内，否则会编译错误（编译时可确定值）或运行时抛异常（运行时确定值）。

**有效 Unicode 范围**：
- `[0x0000, 0xD7FF]` 或
- `[0xE000, 0x10FFFF]`

**错误示例**：
```cj
main() {
    let invalid1 = Rune(0xD800)  // ❌ 编译错误：在代理区
    let invalid2 = Rune(0xDBFF)  // ❌ 编译错误：在代理区
    let invalid3 = Rune(0x110000) // ❌ 编译错误：超出范围
}
```

**错误原因**：
Unicode 标准中，`0xD800` 到 `0xDFFF` 是代理区（Surrogate Area），用于 UTF-16 编码，不是有效的 Unicode 字符。

**修正方案1：使用有效范围内的值**
```cj
main() {
    let valid1 = Rune(0x0041)      // ✅ 'A'
    let valid2 = Rune(0x4F60)      // ✅ '你'
    let valid3 = Rune(0x10FFFF)    // ✅ 最大的有效 Unicode 值
}
```

**修正方案2：添加范围检查**
```cj
func safeToRune(value: UInt32): Option<Rune> {
    if ((value >= 0x0000 && value <= 0xD7FF) ||
        (value >= 0xE000 && value <= 0x10FFFF)) {
        return Option<Rune>.Some(Rune(value))
    }
    return Option<Rune>.None
}

main() {
    let result1 = safeToRune(0x0041)
    match (result1) {
        case Option<Rune>.Some(r) => println("Valid rune: ${r}")
        case Option<Rune>.None => println("Invalid Unicode value")
    }
}
```

**修正方案3：使用字符字面量**
```cj
main() {
    let char1 = r'A'           // ✅ 直接使用字符字面量
    let char2 = r'\u{4f60}'    // ✅ 使用 Unicode 转义
}
```

**参考章节**：SKILL.md 第2.2节

---

### ⚠️ 易错点8：原始字符串字面量中转义字符不会被转义

**问题描述**：
以井号（`#`）开头和结尾的原始字符串字面量中，转义字符（如 `\n`、`\t`）**不会被转义**，而是作为普通字符处理。

**错误理解**：
```cj
main() {
    let s = ##"\n"##

    // ❌ 错误理解：认为 s 是一个换行符
    // ✅ 实际情况：s 是两个字符 - '\' 和 'n'
    println(s.size)  // 输出: 2（不是 1）
}
```

**示例对比**：

| 写法 | 值 | 长度 |
|------|-----|------|
| `"\n"` | 换行符 | 1 |
| `##"\n"##` | `\` 和 `n` 两个字符 | 2 |
| `###"\n"###` | `\` 和 `n` 两个字符 | 2 |
| `"\\n"` | `\` 和 `n` 两个字符 | 2 |

**使用场景**：

**场景1：需要换行符时使用普通字符串**
```cj
main() {
    let s1 = "Hello\nWorld"  // ✅ 包含换行符
    println(s1)  // 输出两行
}
```

**场景2：需要表示字面量 `\` 和 `n` 时使用原始字符串**
```cj
main() {
    let s2 = ##"\n"##  // ✅ 两个字符：\ 和 n
    println(s2)  // 输出：\n
    println(s2.size)  // 输出：2
}
```

**场景3：多行文本使用原始字符串**
```cj
main() {
    let text = ###"
        Hello,
        Cangjie
        Lang"###

    println(text)
    // 输出：
    //
    //    Hello,
    //    Cangjie
    //    Lang
}
```

**参考章节**：SKILL.md 第2.2节

---

## 模式匹配相关

### ⚠️ 易错点9：match 表达式的 case 按顺序匹配

**问题描述**：
match 表达式的 case 按照从上到下的顺序匹配，**不会自动优化或重排**。通配符模式 `_` 应该放在最后，否则会阻止后续的 case 匹配。

**错误示例**：
```cj
main() {
    let x = 10

    match (x) {
        case _ => println("other")     // ❌ 匹配所有值
        case 10 => println("ten")      // 永远不会执行
        case _ => println("default")   // 永远不会执行
    }
}
```

**错误原因**：
第一个 `_` 匹配所有值，匹配后就不再继续检查后续的 case。

**修正方案：将具体 case 放在前面，通配符放在最后**
```cj
main() {
    let x = 10

    match (x) {
        case 1 => println("one")
        case 10 => println("ten")      // ✅ 会匹配
        case 100 => println("hundred")
        case _ => println("other")     // ✅ 放在最后
    }
}
```

**最佳实践**：
```cj
main() {
    let value = Some(42)

    match (value) {
        case Option<Int64>.Some(v) where v > 100 => println("Large: ${v}")
        case Option<Int64>.Some(v) where v > 0 => println("Positive: ${v}")
        case Option<Int64>.Some(0) => println("Zero")
        case Option<Int64>.Some(v) => println("Negative: ${v}")
        case Option<Int64>.None => println("None")
    }
}
```

**参考章节**：SKILL.md 第2.6节

---

### ⚠️ 易错点10：常量模式不支持字符串插值

**问题描述**：
match 表达式的 case 中使用常量模式时，**不能使用字符串插值**。字符串插值是运行时计算，而常量模式需要编译时确定的值。

**错误示例**：
```cj
main() {
    let name = "Alice"

    match (name) {
        case "Hello ${name}" => println("greeting")  // ❌ 编译错误
        case "Alice" => println("Alice")
        case _ => println("other")
    }
}
```

**错误原因**：
`"Hello ${name}"` 是字符串插值，需要在运行时计算，不能作为常量模式。

**修正方案1：使用绑定模式**
```cj
main() {
    let name = "Alice"

    match (name) {
        case n => if (n.startsWith("Hello")) {
                println("greeting: ${n}")
            } else {
                println("name: ${n}")
            }
    }
}
```

**修正方案2：使用守卫（pattern guard）**
```cj
main() {
    let name = "Alice"

    match (name) {
        case n where n.startsWith("Hello") => println("greeting: ${n}")
        case "Alice" => println("Alice")
        case _ => println("other")
    }
}
```

**修正方案3：使用常量字符串**
```cj
main() {
    let name = "Alice"

    match (name) {
        case "Hello" => println("greeting: Hello")
        case "Alice" => println("Alice")
        case _ => println("other")
    }
}
```

**参考章节**：SKILL.md 第2.6节

---

## 字符串相关

### ⚠️ 易错点11：插值字符串使用 `${}` 而非 `{}`

**问题描述**：
仓颉的字符串插值使用 `${}` 语法，不是 `{}`。这是与其他语言（如 Python f-string、JavaScript 模板字符串）的重要区别。

**错误示例**：
```cj
main() {
    let name = "Alice"
    let age = 25

    // ❌ 编译错误
    let message1 = "Name: {name}, Age: {age}"

    // ❌ 编译错误
    let message2 = "Name: {name}, Age: {age}"
}
```

**正确写法**：
```cj
main() {
    let name = "Alice"
    let age = 25

    // ✅ 使用 ${}
    let message = "Name: ${name}, Age: ${age}"
    println(message)  // 输出：Name: Alice, Age: 25

    // ✅ 支持表达式
    let info = "Next year age: ${age + 1}"
    println(info)  // 输出：Next year age: 26
}
```

**对比其他语言**：
```python
# Python f-string
name = "Alice"
message = f"Name: {name}"  # 使用 {}
```

```cj
// 仓颉
let name = "Alice"
let message = "Name: ${name}"  // 使用 ${}
```

**参考章节**：SKILL.md 第2.2节

---

## 函数相关

### ⚠️ 易错点12：Lambda 表达式可以立即调用

**问题描述**：
Lambda 表达式可以在定义后立即调用，这是合法语法，但容易被误解。

**示例**：
```cj
main() {
    // Lambda 立即调用
    let result = { => 42 }()  // ✅ 定义并立即执行

    println(result)  // 输出：42

    // 等价于
    func temp(): Int64 {
        42
    }
    let result2 = temp()
}
```

**使用场景**：

**场景1：创建作用域**
```cj
main() {
    let value = {
        var temp = 10
        temp = temp + 5
        temp
    }()

    println(value)  // 输出：15
}
```

**场景2：计算复杂表达式**
```cj
main() {
    let result = {
        let a = 10
        let b = 20
        let c = 30
        a + b + c
    }()

    println(result)  // 输出：60
}
```

**注意事项**：
- Lambda 立即调用会创建新的作用域
- 过度使用可能降低代码可读性
- 建议仅在需要隔离作用域或计算复杂表达式时使用

**参考章节**：SKILL.md 第2.4节

---

## 类型系统相关

### ⚠️ 易错点13：Unit 类型只支持赋值、判等、判不等操作

**问题描述**：
`Unit` 类型（唯一值是 `()` ）只支持有限的操作：
- ✅ 赋值：`let u: Unit = ()`
- ✅ 判等：`u == ()`
- ✅ 判不等：`u != ()`
- ❌ 其他所有操作（如算术运算、函数调用等）

**错误示例**：
```cj
main() {
    let u: Unit = ()

    // ❌ 编译错误：Unit 类型不支持这些操作
    let sum = u + u
    println(u)
    let array = [u, u]
}
```

**正确用法**：
```cj
main() {
    // ✅ 赋值
    let u1: Unit = ()

    // ✅ 判等
    let u2: Unit = ()
    if (u1 == u2) {
        println("u1 equals u2")
    }

    // ✅ 判不等
    let u3: Unit = ()
    if (u1 != u3) {
        println("not equal")
    }
}
```

**使用场景**：
`Unit` 类型通常用于不返回值的函数：

```cj
func printMessage(): Unit {
    println("Hello")
    // 隐式返回 ()
}

main() {
    let result: Unit = printMessage()
    if (result == ()) {
        println("Function returned Unit")
    }
}
```

**参考章节**：SKILL.md 第2.2节

---

## 其他

### ⚠️ 易错点14：元组至少需要两个元素

**问题描述**：
仓颉的元组类型**至少需要两个元素**，不支持单元素元组。

**错误示例**：
```cj
main() {
    let single = (42,)  // ❌ 编译错误：不支持单元素元组
}
```

**正确用法**：
```cj
main() {
    // ✅ 两个元素
    let pair = (42, "hello")

    // ✅ 三个元素
    let triple = (42, "hello", 3.14)

    // ✅ 使用具体类型代替单元素元组
    let single: Int64 = 42
}
```

**参考章节**：SKILL.md 第2.2节

---

### ⚠️ 易错点15：区间类型的 step 不能等于 0

**问题描述**：
`Range<T>` 类型的 `step` 值不能等于 0，否则会导致无限循环或运行时错误。

**错误示例**：
```cj
main() {
    // ❌ 编译错误或运行时错误
    let range = Range(1, 10, 0)

    for (i in range) {
        println(i)  // 可能无限循环
    }
}
```

**正确用法**：
```cj
main() {
    // ✅ step 为正数
    let range1 = Range(1, 10, 2)  // 1, 3, 5, 7, 9

    // ✅ step 为负数
    let range2 = Range(10, 1, -1)  // 10, 9, 8, ..., 1

    for (i in range1) {
        println(i)
    }
}
```

**参考章节**：SKILL.md 第2.2节

---

### ⚠️ 易错点16：enum 至少存在一个有名字的构造器

**问题描述**：
定义 enum 类型时，**至少需要存在一个有名字的构造器**，不能定义空枚举。

**错误示例**：
```cj
// ❌ 编译错误：空枚举
enum EmptyEnum {
}

// ❌ 编译错误：所有构造器都是无名字的
enum InvalidEnum {
    | (Int64)
    | (String)
}
```

**正确用法**：
```cj
// ✅ 至少一个有名字的构造器
enum TimeUnit {
    | Year(UInt64)
    | Month(UInt64)
}

// ✅ 无参构造器也需要名字
enum Direction {
    | North
    | South
    | East
    | West
}
```

**参考章节**：SKILL.md 第2.5节

---

### ⚠️ 易错点17：match 表达式的 case 不需要 `{}` 括号

**问题描述**：
match 表达式的 case 分支不需要使用 `{}` 括号，使用 `=>` 后直接跟表达式或语句。

**错误示例**：
```cj
main() {
    let x = 10

    match (x) {
        case 1 => { println("one") }  // ❌ 编译错误：case 不能使用 {}
        case _ => println("other")
    }
}
```

**正确用法**：
```cj
main() {
    let x = 10

    match (x) {
        case 1 => println("one")        // ✅ 单行直接写
        case 10 => println("ten")
                   println("lucky number")  // ✅ 多行直接换行，不用 {}
        case _ => println("other")
    }
}
```

**参考章节**：SKILL.md 第2.6节

---

### ⚠️ 易错点18：Option 类型用于表示可能有值或无值

**问题描述**：
`Option<T>` 类型用于明确表示某个值可能存在或不存在，但**不是所有情况都需要使用 Option**。

**过度使用示例**：
```cj
// ❌ 不必要：固定长度的数组访问不需要 Option
func getFirst(array: Array<Int64>): Option<Int64> {
    if (array.size > 0) {
        return Option<Int64>.Some(array[0])
    }
    return Option<Int64>.None
}

// ✅ 更好：固定长度的数组直接访问
func getFirst(array: Array<Int64>): Int64 {
    array[0]  // 如果数组为空，自然会抛异常
}
```

**正确使用场景**：

**场景1：查找可能不存在的元素**
```cj
func findElement(array: Array<Int64>, target: Int64): Option<Int64> {
    for (element in array) {
        if (element == target) {
            return Option<Int64>.Some(element)
        }
    }
    return Option<Int64>.None
}
```

**场景2：可能失败的操作**
```cj
func safeDivide(a: Int64, b: Int64): Option<Float64> {
    if (b == 0) {
        return Option<Float64>.None
    }
    return Option<Float64>.Some((a as Float64) / (b as Float64))
}
```

**场景3：可选配置**
```cj
class Config {
    public let timeout: Option<Int64>
    public let retryCount: Option<Int64>
}
```

**参考章节**：SKILL.md 第2.7节

---

### ⚠️ 易错点19：Duration 和 sleep 在 `std.core` 里不需导入

**问题描述**：
`Duration` 类型和 `sleep` 函数在 `std.core` 包中，**不需要显式导入**，可以直接使用。

**正确用法**：
```cj
main() {
    // ✅ 不需要导入，直接使用
    sleep(Duration.Second)

    println("After 1 second")

    sleep(Duration.Millisecond * 500)

    println("After 0.5 seconds")
}
```

**错误理解**：
```cj
// ❌ 不需要手动导入
// import std.time.sleep  // 不需要
// import std.time.Duration  // 不需要

main() {
    sleep(Duration.Second)
}
```

**说明**：
- `std.core` 是核心包，自动导入
- 常用的类型和函数（如 `Duration`、`sleep`）在核心包中
- 其他标准库（如 `std.io`、`std.collection`）可能需要显式导入

**参考章节**：SKILL.md 第2.10节

---

## 总结

这19个易错点涵盖了仓颉语言的主要语法特性和常见陷阱：

1. **变量相关**（3个）：let 不可变性、函数参数默认 let、访问修饰符默认 internal
2. **控制流相关**（3个）：条件表达式括号、不支持 goto、break/continue 无标签
3. **类型转换相关**（2个）：Rune 转换范围、原始字符串转义
4. **模式匹配相关**（2个）：case 顺序、常量模式限制
5. **字符串相关**（1个）：插值使用 `${}`
6. **函数相关**（1个）：Lambda 立即调用
7. **类型系统相关**（1个）：Unit 类型限制
8. **其他**（6个）：元组、区间 step、enum、match case、Option、Duration/sleep

**建议**：
- 在编写代码时，对照本清单检查
- 在代码分析时，优先检查这些易错点
- 使用代码模板时，确保模板遵循这些规则

---

**文档维护**：仓颉语言社区
**最后更新**：2025-01-07
**版本**：v1.0.0
