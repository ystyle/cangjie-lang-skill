/**
 * 示例名称：模式匹配
 * 语法模块：第2.6节 - 模式匹配
 * 难度：intermediate
 * ⚠️ 易错点：⚠️易错点9（case按顺序匹配，通配符在最后）、⚠️易错点10（常量模式不支持字符串插值）
 *
 * 本示例演示：
 * - 常量模式
 * - 通配符模式
 * - 绑定模式
 * - Tuple 模式
 * - 类型模式
 * - enum 模式
 * - 模式嵌套
 * - case 多行语句（不需要{}）
 */
// 基础类型示例
class Base {
    let name: String = "Base"
}

class Derived extends Base {
    let age: Int64 = 100
}

// 时间单位枚举
enum TimeUnit {
    | Year(UInt64)
    | Month(UInt64)
}

// 命令枚举
enum Command {
    | SetTimeUnit(TimeUnit)
    | GetTimeUnit
    | Quit
}

func patternMatchingExamples() {
    // 1. 常量模式
    println("=== 常量模式 ===")
    let x = 0
    let result1 = match (x) {
        case 1 => "x = 1"
        case 0 => "x = 0"
        case 2 | 3 | 4 => "x is 2, 3, or 4"
        case _ => "other"
    }
    println(result1)

    // 1.5 case 多行语句示例
    println("\n=== case 多行语句 ===")
    let y = 10
    match (y) {
        case 1 => {
            println("one")
            println("first number")  // ✅ 可以使用代码块
        }
        case 10 => {
            println("ten")
            println("lucky number")
            println("perfect score")
        }
        case _ => println("other")
    }

    // 2. 绑定模式
    println("\n=== 绑定模式 ===")
    let y = -10
    let result2 = match (y) {
        case 0 => "zero"
        case n => "x is not zero and x = ${n}"  // n 绑定匹配的值
    }
    println(result2)

    // 3. Tuple 模式
    println("\n=== Tuple 模式 ===")
    let tv = ("Alice", 24)
    let result3 = match (tv) {
        case ("Bob", age) => "Bob is ${age} years old"
        case ("Alice", age) => "Alice is ${age} years old"
        case (name, 100) => "${name} is 100 years old"
        case (_, _) => "someone"
    }
    println(result3)

    // 4. 类型模式
    println("\n=== 类型模式 ===")
    var d = Derived()
    var r = match (d) {
        case b: Base => b.name
        case _ => "unknown"
    }
    println("Type pattern result: ${r}")

    // 5. enum 模式
    println("\n=== enum 模式 ===")
    let time = TimeUnit.Year(2)
    let result4 = match (time) {
        case TimeUnit.Year(n) => "x has ${n * 12} months"
        case TimeUnit.Month(n) => "x has ${n} months"
    }
    println(result4)

    // 6. 模式嵌套
    println("\n=== 模式嵌套 ===")
    let command = (Command.SetTimeUnit(TimeUnit.Year(2022)), Command.SetTimeUnit(TimeUnit.Year(2024)))
    match (command) {
        case (Command.SetTimeUnit(TimeUnit.Year(year)), _) => println("Set year ${year}")
        case (_, Command.SetTimeUnit(TimeUnit.Month(month))) => println("Set month ${month}")
        case _ => println("Other command")
    }
}

main() {
    patternMatchingExamples()
}
