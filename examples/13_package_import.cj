/**
 * 示例名称：包与导入
 * 语法模块：第2.13节 - 包
 * 难度：intermediate
 * ⚠️ 易错点：无
 *
 * 本示例演示：
 * - package 声明
 * - import 导入
 * - 导入方式（通配符、特定项、多个项、重命名）
 * - 访问修饰符与包的关系
 *
 * 注意：这是一个单文件示例，实际项目中应该按目录结构组织
 */

// 包声明（当前文件的包）
package demo

// 导入标准库
import std.io.*
import std.math.*

main() {
    println("=== 包与导入示例 ===")

    // 使用导入的标准库函数
    println("sqrt(16) = ${sqrt(16.0)}")
    println("pow(2, 3) = ${pow(2.0, 3.0)}")

    // ==================== 导入方式 ====================
    println("\n=== 导入方式 ===")

    // 方式1：通配符导入（导入所有）
    // import std.math.*
    // 可以直接使用 std.math 中的所有内容
    println("PI = ${pi}")

    // 方式2：导入特定项
    // import std.math.sin
    // 只能使用 sin
    // let value = sin(1.0)

    // 方式3：导入多个项
    // import {std.math.sin, std.math.cos}
    // 可以使用 sin 和 cos

    // 方式4：重命名导入
    // import std.math as math
    // let value = math.sqrt(16.0)

    // ==================== 访问修饰符 ====================
    println("\n=== 访问修饰符与包 ===")

    /*
    访问修饰符的可见性：

    1. private - 仅当前文件可见
    2. internal - 当前包及子包可见（默认）
    3. public - 模块内外均可见

    示例：
    */

    // internal 函数（默认）
    // 仅在 demo 包及子包中可见
    internalFunc()

    // public 函数
    // 任何地方都可以访问
    publicFunc()

    // private 函数
    // 仅当前文件可见
    privateFunc()

    // ==================== 包的使用场景 ====================
    println("\n=== 包的使用场景 ===")

    /*
    目录结构与包声明对应：

    src/
    └── demo/
        ├── math/
        │   ├── calculator.cj    // package demo.math
        │   └── utils.cj         // package demo.math
        └── main.cj              // package demo

    // calculator.cj
    package demo.math
    public func add(a: Int64, b: Int64): Int64 {
        a + b
    }

    // main.cj
    package demo
    import demo.math.add

    main() {
        let result = add(1, 2)  // 调用 demo.math.add
    }
    */

    println("包的最佳实践：")
    println("1. 按功能模块组织包结构")
    println("2. 使用 public 导出需要对外提供的 API")
    println("3. 使用 internal 限制包内部实现")
    println("4. 使用 private 隐藏文件内部细节")
    println("5. 包名与目录结构保持一致")

    // ==================== 导入建议 ====================
    println("\n=== 导入建议 ===")

    println("推荐做法：")
    println("✅ 明确导入需要的内容")
    println("   import std.math.sin")
    println()
    println("✅ 使用花括号导入多个")
    println("   import {std.math.sin, std.math.cos}")
    println()
    println("✅ 避免通配符导入（除非确实需要）")
    println("   import std.math.*  // 谨慎使用")
    println()
    println("❌ 不推荐：")
    println("   - 过度使用通配符导入可能导致命名冲突")
    println("   - 不清楚的导入来源影响代码可读性")
}

// internal 函数（默认）
func internalFunc() {
    println("调用 internal 函数")
}

// public 函数
public func publicFunc() {
    println("调用 public 函数")
}

// private 函数
private func privateFunc() {
    println("调用 private 函数")
}

// ==================== 模拟包结构 ====================
/*
// 文件：demo/math/calculator.cj
package demo.math

public func add(a: Int64, b: Int64): Int64 {
    a + b
}

public func subtract(a: Int64, b: Int64): Int64 {
    a - b
}

internal func multiply(a: Int64, b: Int64): Int64 {
    a * b
}

private func divideHelper(a: Int64, b: Int64): Float64 {
    (a as Float64) / (b as Float64)
}

public func divide(a: Int64, b: Int64): Option<Float64> {
    if (b == 0) {
        return Option<Float64>.None
    }
    return Option<Float64>.Some(divideHelper(a, b))
}

// 文件：demo/main.cj
package demo

import demo.math.{add, subtract, divide}

main() {
    let sum = add(10, 20)
    let diff = subtract(10, 5)

    let result = divide(10, 2)
    match (result) {
        case Option<Float64>.Some(value) => println("10 / 2 = ${value}")
        case Option<Float64>.None => println("除数不能为0")
    }

    // 以下调用会报错，因为 multiply 是 internal
    // let product = multiply(10, 5)

    // 以下调用会报错，因为 divideHelper 是 private
    // let value = divideHelper(10, 2)
}
*/
