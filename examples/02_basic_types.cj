/**
 * 示例名称：基础类型使用
 * 语法模块：第2.2节 - 基础类型
 * 难度：beginner
 * ⚠️ 易错点：⚠️易错点3（字符串插值使用${}）、⚠️易错点4（多行原始字符串转义不生效）
 *
 * 本示例演示：
 * - 数值类型（Int64, Float64）
 * - 字符类型（Rune）
 * - 三种字符串字面量
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

    // 字符串类型 - 仓颉支持三种字符串字面量

    // 1. 单行字符串字面量
    let s1: String = ""
    let s2 = 'Hello Cangjie Lang'
    let s3 = "\"Hello Cangjie Lang\""
    let s4 = 'Hello Cangjie Lang\n'  // \n 是转义字符，表示换行

    // 2. 多行字符串字面量
    let s5: String = """
        This is a multi-line
        string example
        """

    let s6: String = '''
        This uses single quotes
        for multi-line text
        '''

    // 3. 多行原始字符串字面量（转义规则不适用，不支持插值）
    let rawString1 = ##"\n"##  // \n 不是换行符，是 \ 和 n 两个字符
    let rawString2 = ###"
        Hello,
        Cangjie
        Lang"###  // 保留换行和缩进

    // 字符串插值（仅适用于单行和多行字符串字面量，不适用于多行原始字符串字面量）
    let name = "Cangjie"
    let count = 10
    let message = "Hello, ${name}! Count: ${count * count}"
    let multiLineMsg = """
        Welcome to ${name}!
        Total: ${count * count}
        """

    // 元组类型
    let tuple: (Int64, String) = (1, "first")
    println("Tuple: ${tuple[0]}, ${tuple[1]}")

    // 数组类型
    let array: Array<Int64> = [1, 2, 3, 4, 5]

    println("=== 单行字符串 ===")
    println(s2)
    println(s3)
    println(s4)

    println("\n=== 多行字符串 ===")
    println(s5)
    println(s6)

    println("\n=== 多行原始字符串 ===")
    println("rawString1 长度: ${rawString1.size}")  // 长度为 2（\ 和 n）
    println(rawString2)

    println("\n=== 字符串插值 ===")
    println(message)
    println(multiLineMsg)

    println("\n=== 其他类型 ===")
    println("Tuple: ${tuple[0]}, ${tuple[1]}")
    println("Char: ${char}, Unicode: ${unicodeChar}")
}
