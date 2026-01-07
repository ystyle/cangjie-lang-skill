/**
 * 示例名称：单元测试
 * 语法模块：第2.9节 - 单元测试
 * 难度：beginner
 * ⚠️ 易错点：无
 *
 * 本示例演示：
 * - @Test 宏
 * - @TestCase 宏
 * - @Assert 断言（失败停止用例）
 * - @Expect 断言（失败继续执行）
 * - @Fail 标记测试失败
 */
// 导入测试宏（假设测试框架提供）
/*
import std.testing.*
*/

// 被测试的函数
func add(a: Int64, b: Int64): Int64 {
    a + b
}

func divide(a: Int64, b: Int64): Float64 {
    if (b == 0) {
        throw Exception("Division by zero")
    }
    return (a as Float64) / (b as Float64)
}

// 测试类1：基础测试
@Test
class MathTest {
    @TestCase
    func testAdd() {
        let a = 10
        let b = 20

        // 方式一：手动判断
        if (add(a, b) != 30) {
            @Fail("add(10, 20) should be 30")
        }

        // 方式二：Assert 条件
        @Assert(add(a, b) == 30)

        // 方式三：Assert 相等
        @Assert(add(a, b), 30)
    }

    @TestCase
    func testAddNegative() {
        let result = add(-5, -3)
        @Assert(result, -8)
    }
}

// 测试类2：使用 Expect 断言
@Test
class DivisionTest {
    @TestCase
    func testDivide() {
        // Expect 失败后继续执行
        @Expect(divide(10, 2), 5.0)
        @Expect(divide(20, 4), 5.0)
    }

    @TestCase
    func testDivideByZero() {
        // 测试异常处理
        try {
            let result = divide(10, 0)
            @Fail("Should throw exception")
        } catch (e: Exception) {
            @Assert(true)  // 预期捕获到异常
        }
    }
}

// 测试类3：字符串测试
@Test
class StringTest {
    @TestCase
    func testStringConcat() {
        let s1 = "Hello"
        let s2 = "World"
        let result = "${s1}, ${s2}"

        @Assert(result, "Hello, World")
    }

    @TestCase
    func testStringLength() {
        let s = "Cangjie"
        let len = s.size

        @Assert(len, 8)
    }
}

/* 注意：实际使用时需要根据仓颉测试框架的具体要求调整代码 */
/* 运行测试的方式取决于测试框架，通常使用编译器或测试工具 */
