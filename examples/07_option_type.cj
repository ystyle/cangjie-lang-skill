/**
 * 示例名称：Option 类型使用
 * 语法模块：第2.7节 - Option类型
 * 难度：intermediate
 * ⚠️ 易错点：无
 *
 * 本示例演示：
 * - Option<T> 类型定义
 * - Some 和 None 的使用
 * - Option 类型的模式匹配
 * - 空合并运算符 ??
 * - isSome() 和 isNone() 方法
 * - if 模式匹配提取值
 * - 短路返回和短路抛出异常
 * - 使用 Option 处理可能的空值
 */
// Option 类型定义（标准库已提供，这里仅作说明）
/*
enum Option<T> {
    | Some(T)   // 有值
    | None      // 无值
}
*/

// 查找数组中的元素
func findElement(array: Array<Int64>, target: Int64): Option<Int64> {
    for (element in array) {
        if (element == target) {
            return Option<Int64>.Some(element)
        }
    }
    return Option<Int64>.None
}

// 安全的除法
func safeDivide(a: Int64, b: Int64): Option<Float64> {
    if (b == 0) {
        return Option<Float64>.None
    }
    return Option<Float64>.Some((a as Float64) / (b as Float64))
}

main() {
    // 示例1：查找元素
    let numbers = [1, 2, 3, 4, 5]
    let result1 = findElement(numbers, 3)
    let result2 = findElement(numbers, 10)

    println("=== 查找元素 ===")
    match (result1) {
        case Option<Int64>.Some(value) => println("找到元素: ${value}")
        case Option<Int64>.None => println("未找到元素")
    }

    match (result2) {
        case Option<Int64>.Some(value) => println("找到元素: ${value}")
        case Option<Int64>.None => println("未找到元素")
    }

    // 示例2：安全除法
    println("\n=== 安全除法 ===")
    let div1 = safeDivide(10, 2)
    let div2 = safeDivide(10, 0)

    match (div1) {
        case Option<Float64>.Some(value) => println("10 / 2 = ${value}")
        case Option<Float64>.None => println("除数不能为0")
    }

    match (div2) {
        case Option<Float64>.Some(value) => println("10 / 0 = ${value}")
        case Option<Float64>.None => println("除数不能为0")
    }

    // 示例3：Option 在 if 表达式中的模式匹配
    println("\n=== if 模式匹配 ===")
    let maybeValue = Option<Int64>.Some(42)
    if (let Option<Int64>.Some(v) <- maybeValue) {
        println("有值: ${v}")
    } else {
        println("无值")
    }

    // 示例4：空合并运算符 ??
    println("\n=== 空合并运算符 ?? ===")
    let optA: Option<Int64> = Option<Int64>.Some(42)
    let optB: Option<Int64> = Option<Int64>.None

    let a = optA ?? 0
    let b = optB ?? 0

    println("optA ?? 0 = ${a}")  // 输出: 42
    println("optB ?? 0 = ${b}")  // 输出: 0

    // 示例5：isSome() 和 isNone()
    println("\n=== isSome() 和 isNone() ===")
    if (optA.isSome()) {
        println("optA 有值")
    }

    if (optB.isNone()) {
        println("optB 无值")
    }

    // 示例6：短路返回
    println("\n=== 短路返回 ===")
    let result = processValue(Option<Int64>.None)
    println("processValue 结果: ${result}")

    // 示例7：短路抛出异常
    println("\n=== 短路抛出异常 ===")
    try {
        let value = processOrThrow(Option<Int64>.None)
        println("值: ${value}")
    } catch (e: Exception) {
        println("捕获异常: ${e.message}")
    }
}

// 短路返回示例
func processValue(opt: Option<Int64>): Int64 {
    let value = opt ?? return 0  // 如果是 None，直接返回 0
    value * 2  // 继续处理
}

// 短路抛出异常示例
func processOrThrow(opt: Option<Int64>): Int64 {
    let value = opt ?? throw Exception("值不存在")
    value  // 继续处理
}
