/**
 * 示例名称：函数定义与使用
 * 语法模块：第2.4节 - 函数
 * 难度：intermediate
 * ⚠️ 易错点：⚠️易错点8（函数参数默认是let不可变，方法不能使用var）、⚠️易错点9（Lambda可立即调用）
 *
 * 本示例演示：
 * - 函数定义
 * - 返回值简写
 * - 函数参数不可变（let）
 * - Lambda表达式
 * - 高阶函数
 * - 函数类型
 */
import std.io.println

// 基本函数定义
func add(a: Int64, b: Int64): Int64 {
    return a + b
}

// 返回值简写（最后一个表达式自动作为返回值）
func multiply(a: Int64, b: Int64): Int64 {
    a * b
}

// ⚠️ 函数参数默认是let不可变
func tryModify(a: Int64): Int64 {
    // a = a + 1  // 编译错误：不能修改let参数
    return a
}

// 顶层函数可以使用var声明可变参数
func modify(var a: Int64): Int64 {
    a = a + 1  // 现在可以修改了
    return a
}

// ⚠️ 重要：class 方法的参数不能使用 var
class Example {
    public func method(var a: Int64): Int64 {  // ❌ 编译错误
        a = a + 1
        return a
    }
}

// 高阶函数（函数作为参数）
func applyFunction(a: Int64, b: Int64, f: (Int64, Int64) -> Int64): Int64 {
    f(a, b)
}

// Lambda表达式示例
func lambdaExamples() {
    // 完整类型声明
    let f1 = { a: Int64, b: Int64 => a + b }

    // 无参Lambda
    var display = { =>
        println("Hello from Lambda")
    }

    // 类型推断
    var sum1: (Int64, Int64) -> Int64 = { a, b => a + b }

    // ⚠️ Lambda立即调用
    let r2 = { => 123 }()  // r2 = 123，立即执行

    println("Lambda f1(10, 20): ${f1(10, 20)}")
    println("Lambda sum1(5, 3): ${sum1(5, 3)}")
    println("Lambda immediate: ${r2}")

    display()

    // Lambda作为参数
    let result = applyFunction(10, 20, { x, y => x * y })
    println("Lambda as parameter: ${result}")
}

main() {
    println("add(10, 20): ${add(10, 20)}")
    println("multiply(10, 20): ${multiply(10, 20)}")
    println("tryModify(10): ${tryModify(10)}")
    println("modify(10): ${modify(10)}")

    lambdaExamples()
}
