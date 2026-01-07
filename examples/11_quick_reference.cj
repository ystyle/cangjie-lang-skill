/**
 * 示例名称：速查参考
 * 语法模块：第2.11节 - 速查手册
 * 难度：beginner
 * ⚠️ 易错点：⚠️易错点5（条件表达式必须有括号）
 *
 * 本示例演示：
 * - 所有常用控制结构
 * - 常用类型和操作
 * - 快速语法参考
 */
main() {
    // ========== 控制结构 ==========

    // 1. if-else（必须有括号）
    if (true) {
        println("if branch")
    } else {
        println("else branch")
    }

    // 2. while 循环
    var i = 0
    while (i < 3) {
        println("while: ${i}")
        i++
    }

    // 3. do-while 循环
    var j = 0
    do {
        println("do-while: ${j}")
        j++
    } while (j < 3)

    // 4. for-in 循环
    for (k in 1..=3) {  // 1到3（包含）
        println("for-in: ${k}")
    }

    // 5. match 表达式
    let value = 2
    match (value) {
        case 1 => println("one")
        case 2 => println("two")
        case _ => println("other")
    }

    // ========== 常用类型 ==========

    // 整数
    let intVal: Int64 = 42
    let uintVal: UInt64 = 42

    // 浮点
    let floatVal: Float64 = 3.14

    // 布尔
    let boolVal: Bool = true

    // 字符
    let charVal: Rune = r'A'

    // 字符串
    let strVal: String = "Hello"
    let interpolated = "Value: ${intVal}"  // 字符串插值

    // 元组
    let tupleVal: (Int64, String) = (1, "first")

    // 数组
    let arrayVal: Array<Int64> = [1, 2, 3]

    // 区间
    let rangeVal: Range<Int64> = 1..10

    // ========== 函数 ==========

    // Lambda
    let lambda = { x: Int64, y: Int64 => x + y }
    println("Lambda(10, 20): ${lambda(10, 20)}")

    // Lambda 立即调用
    let immediate = { => 123 }()
    println("Immediate Lambda: ${immediate}")

    // ========== 输出 ==========
    println("\n=== 类型输出 ===")
    println("Int: ${intVal}")
    println("UInt: ${uintVal}")
    println("Float: ${floatVal}")
    println("Bool: ${boolVal}")
    println("Char: ${charVal}")
    println("String: ${strVal}")
    println("Interpolated: ${interpolated}")
    println("Tuple: ${tupleVal[0]}, ${tupleVal[1]}")
    println("Array: ${arrayVal[0]}, ${arrayVal[1]}, ${arrayVal[2]}")
}
