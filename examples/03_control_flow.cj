/**
 * 示例名称：表达式与控制流
 * 语法模块：第2.3节 - 表达式与控制流
 * 难度：beginner
 * ⚠️ 易错点：⚠️易错点5（条件表达式必须有括号）
 *
 * 本示例演示：
 * - if-else 条件判断（必须有括号）
 * - if 作为表达式（返回值）
 * - while 循环
 * - do-while 循环
 * - for-in 区间遍历
 * - 元组遍历
 */
main() {
    // if-else 条件判断
    let x = 10
    if (x > 5) {  // ⚠️ 必须有括号
        println("x is greater than 5")
    } else {
        println("x is 5 or less")
    }

    // if 作为表达式（返回值）
    let result = if (x > 5) {
        "greater than 5"
    } else {
        "5 or less"
    }
    println("result: ${result}")  // 输出: result: greater than 5

    // while 循环
    var i = 0
    while (i < 3) {
        println("while: ${i}")
        i++
    }

    // do-while 循环
    var j = 0
    do {
        println("do-while: ${j}")
        j++
    } while (j < 3)

    // for-in 区间遍历
    var sum = 0
    for (k in 1..=5) {  // 1到5（包含）
        sum += k
    }
    println("Sum: ${sum}")

    // 元组遍历
    let tuples = [(1, 2), (3, 4), (5, 6)]
    for ((x, y) in tuples) {
        println("Tuple: (${x}, ${y})")
    }
}
