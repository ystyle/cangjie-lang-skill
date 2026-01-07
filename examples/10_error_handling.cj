/**
 * 示例名称：错误处理
 * 语法模块：第2.10节 - 错误处理
 * 难度：intermediate
 * ⚠️ 易错点：无
 *
 * 本示例演示：
 * - 抛出异常（throw）
 * - 捕获异常（try-catch）
 * - 自定义异常类型
 * - Option 类型 vs 异常
 */
// 自定义异常类
class InvalidInputException extends Exception {
    public init(message: String) {
        super(message)
    }
}

// 示例1：安全除法（使用异常）
func safeDivide(a: Int64, b: Int64): Float64 {
    if (b == 0) {
        throw InvalidInputException("Divisor cannot be zero")
    }
    return (a as Float64) / (b as Float64)
}

// 示例2：验证年龄
func validateAge(age: Int64): Unit {
    if (age < 0) {
        throw InvalidInputException("Age cannot be negative")
    }
    if (age > 150) {
        throw InvalidInputException("Age seems unrealistic")
    }
}

// 示例3：数组访问（使用Option）
func safeGet(array: Array<Int64>, index: Int64): Option<Int64> {
    if (index < 0 || index >= array.size) {
        return Option<Int64>.None
    }
    return Option<Int64>.Some(array[index])
}

main() {
    // 测试异常处理
    println("=== 异常处理示例 ===")

    // 正常情况
    try {
        let result1 = safeDivide(10, 2)
        println("10 / 2 = ${result1}")
    } catch (e: InvalidInputException) {
        println("Error: ${e.message}")
    } catch (e: Exception) {
        println("Generic error: ${e.message}")
    }

    // 异常情况
    try {
        let result2 = safeDivide(10, 0)
        println("10 / 0 = ${result2}")
    } catch (e: InvalidInputException) {
        println("Error: ${e.message}")
    } catch (e: Exception) {
        println("Generic error: ${e.message}")
    }

    // 测试年龄验证
    println("\n=== 年龄验证示例 ===")
    try {
        validateAge(25)
        println("Age 25 is valid")
    } catch (e: InvalidInputException) {
        println("Error: ${e.message}")
    }

    try {
        validateAge(-5)
        println("Age -5 is valid")
    } catch (e: InvalidInputException) {
        println("Error: ${e.message}")
    }

    // 测试 Option 类型
    println("\n=== Option 类型示例 ===")
    let numbers = [10, 20, 30, 40, 50]

    let result1 = safeGet(numbers, 2)
    match (result1) {
        case Option<Int64>.Some(value) => println("Index 2: ${value}")
        case Option<Int64>.None => println("Index out of bounds")
    }

    let result2 = safeGet(numbers, 10)
    match (result2) {
        case Option<Int64>.Some(value) => println("Index 10: ${value}")
        case Option<Int64>.None => println("Index out of bounds")
    }
}
