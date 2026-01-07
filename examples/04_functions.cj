/**
 * 示例名称：函数定义与使用
 * 语法模块：第2.4节 - 函数
 * 难度：intermediate
 * ⚠️ 易错点：⚠️易错点2（函数参数默认是let不可变，不支持var修饰）、⚠️易错点12（Lambda可立即调用）
 *
 * 本示例演示：
 * - 函数定义
 * - 返回值简写
 * - 函数参数不可变（let）
 * - 使用局部变量修改参数值
 * - Lambda表达式
 * - 高阶函数
 * - 函数类型
 * - 命名参数（Named Parameters）
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
    // a = a + 1  // ❌ 编译错误：不能修改let参数
    return a
}

// ❌ 编译错误：函数参数不能显式使用 let 或 var 修饰符
// func wrong1(let a: Int64): Int64 {  // ❌ 编译错误
//     return a
// }
//
// func wrong2(var a: Int64): Int64 {  // ❌ 编译错误
//     a = a + 1
//     return a
// }
//
// class Example {
//     public func method(var a: Int64): Int64 {  // ❌ 编译错误
//         a = a + 1
//         return a
//     }
// }

// ✅ 正确做法：使用局部变量
func modify(a: Int64): Int64 {
    var result = a
    result = result + 1  // ✅ 修改局部变量
    return result
}

// ⚠️ 重要：函数参数不能显式使用 let 或 var 修饰符
// （包括顶层函数、class成员方法、struct成员方法等所有函数，参数默认就是 let 不可变的）

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

// 命名参数示例
func namedParameterExamples() {
    // 带默认值的命名参数
    func greet(name!: String, age!: Int64 = 25, city!: String = "北京") {
        println("姓名: ${name}, 年龄: ${age}, 城市: ${city}")
    }

    println("\n=== 命名参数示例 ===")

    // 1. 使用命名参数（可以不按顺序）
    greet(name: "张三", age: 30, city: "上海")

    // 2. 使用默认值（省略 age 和 city）
    greet(name: "李四")  // 输出: 姓名: 李四, 年龄: 25, 城市: 北京

    // 3. 部分使用默认值
    greet(name: "王五", city: "深圳")  // 输出: 姓名: 王五, 年龄: 25, 城市: 深圳

    // 4. 命名参数可以不按顺序
    greet(age: 35, name: "赵六", city: "广州")
}

main() {
    println("add(10, 20): ${add(10, 20)}")
    println("multiply(10, 20): ${multiply(10, 20)}")
    println("tryModify(10): ${tryModify(10)}")
    println("modify(10): ${modify(10)}")

    lambdaExamples()
    namedParameterExamples()
}
