/**
 * 示例名称：基础类型使用
 * 语法模块：第2.2节 - 基础类型
 * 难度：beginner
 * ⚠️ 易错点：⚠️易错点3（字符串插值使用${}）、⚠️易错点4（原始字符串转义）
 *
 * 本示例演示：
 * - 数值类型（Int64, Float64）
 * - 字符类型（Rune）
 * - 字符串插值
 * - 元组类型
 * - 数组类型
 */
main() {
    // 数值类型
    let integer: Int64 = 42
    let floating: Float64 = 3.14

    // 字符类型
    let char: Rune = r'A'
    let unicodeChar: Rune = r'\u{4f60}'  // 你

    // 字符串类型
    let name = "Cangjie"
    let count = 10
    let message = "Hello, ${name}! Count: ${count * count}"

    // 原始字符串（转义不生效）
    let rawString = ##"\n"##  // 这是 \ 和 n 两个字符，不是换行符

    // 元组类型
    let tuple: (Int64, String) = (1, "first")
    println("Tuple: ${tuple[0]}, ${tuple[1]}")

    // 数组类型
    let array: Array<Int64> = [1, 2, 3, 4, 5]

    println(message)
    println(rawString)
    println("Char: ${char}, Unicode: ${unicodeChar}")
}
