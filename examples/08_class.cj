/**
 * 示例名称：class 类型定义与使用
 * 语法模块：第2.8节 - class类型
 * 难度：intermediate
 * ⚠️ 易错点：⚠️易错点11（成员默认访问修饰符是internal，不是private）
 *
 * 本示例演示：
 * - class 定义
 * - 构造函数（init）
 * - 成员变量
 * - 成员函数
 * - 访问修饰符
 * - 创建实例
 */
// 矩形类
class Rectangle {
    // ⚠️ 成员变量默认访问修饰符是 internal
    let width: Int64
    let height: Int64

    // 构造函数（public）
    public init(width: Int64, height: Int64) {
        this.width = width
        this.height = height
    }

    // 成员函数（public）
    public func area(): Int64 {
        width * height
    }

    public func perimeter(): Int64 {
        2 * (width + height)
    }

    // private 函数
    private func internalHelper(): String {
        "internal helper"
    }
}

// 点类（演示访问修饰符）
class Point {
    private var x: Int64       // 仅class内可见
    internal var y: Int64      // 当前包及子包可见（默认）
    public var z: Int64        // 模块内外均可见

    public init(x: Int64, y: Int64, z: Int64) {
        this.x = x
        this.y = y
        this.z = z
    }

    public func getX(): Int64 {
        x  // 可以访问private成员
    }

    public func toString(): String {
        "Point(${x}, ${y}, ${z})"
    }
}

main() {
    // 使用 Rectangle
    let rect = Rectangle(10, 20)
    println("矩形宽度: ${rect.width}")
    println("矩形高度: ${rect.height}")
    println("矩形面积: ${rect.area()}")
    println("矩形周长: ${rect.perimeter()}")

    // 使用 Point
    let p = Point(1, 2, 3)
    println(p.toString())
    println("p.x = ${p.getX()}")   // 通过public函数访问private成员
    println("p.y = ${p.y}")        // internal成员（同包可访问）
    println("p.z = ${p.z}")        // public成员
}
