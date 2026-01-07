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
 * - Option 在错误处理中的高级用法
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

    // 示例4：Option ?? throw 短路抛出异常
    println("\n=== Option ?? throw 示例 ===")
    let opt1: Option<Int64> = Option<Int64>.Some(100)
    let opt2: Option<Int64> = Option<Int64>.None

    try {
        let value1 = opt1 ?? throw InvalidInputException("opt1 为空")
        println("opt1 值: ${value1}")
    } catch (e: InvalidInputException) {
        println("Error: ${e.message}")
    }

    try {
        let value2 = opt2 ?? throw InvalidInputException("opt2 为空")
        println("opt2 值: ${value2}")
    } catch (e: InvalidInputException) {
        println("Error: ${e.message}")  // 会执行这里
    }

    // 示例5：getOrThrow() 方法
    println("\n=== getOrThrow() 示例 ===")
    let opt3: Option<Int64> = Option<Int64>.Some(200)
    let opt4: Option<Int64> = Option<Int64>.None

    try {
        let value3 = opt3.getOrThrow()  // 有值，直接返回
        println("opt3 值: ${value3}")
    } catch (e: NoneValueException) {
        println("Error: opt3 为空")
    }

    try {
        let value4 = opt4.getOrThrow()  // None，抛出 NoneValueException
        println("opt4 值: ${value4}")
    } catch (e: NoneValueException) {
        println("Error: opt4 为空")  // 会执行这里
    }

    // 示例6：getOrThrow() 自定义异常
    println("\n=== getOrThrow(自定义异常) 示例 ===")
    try {
        let value5 = opt4.getOrThrow({=> InvalidInputException("自定义错误")})
        println("value5: ${value5}")
    } catch (e: InvalidInputException) {
        println("Error: ${e.message}")  // 会执行这里
    }

    // 示例7：ifSome 和 ifNone
    println("\n=== ifSome 和 ifNone 示例 ===")
    let opt5: Option<Int64> = Option<Int64>.Some(300)

    ifSome(opt5) { value =>
        println("opt5 有值: ${value}")
    }

    ifNone(opt5) {
        println("opt5 为空")
    }

    let opt6: Option<Int64> = Option<Int64>.None
    ifNone(opt6) {
        println("opt6 为空")  // 会执行这里
    }
}
