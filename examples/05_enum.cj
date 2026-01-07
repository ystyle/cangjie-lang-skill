/**
 * 示例名称：枚举类型定义与使用
 * 语法模块：第2.5节 - 枚举类型
 * 难度：beginner
 * ⚠️ 易错点：⚠️易错点16（enum至少存在一个有名字的构造器）
 *
 * 本示例演示：
 * - 无参构造器
 * - 有参构造器
 * - enum 模式匹配
 */
// 定义 RGB 颜色枚举
enum RGBColor {
    | Red(UInt8)
    | Green(UInt8)
    | Blue(UInt8)
}

// 定义简单枚举（无参构造器）
enum Direction {
    | North
    | South
    | East
    | West
}

func describeColor(color: RGBColor): String {
    match (color) {
        case Red(v) => "Red: ${v}"
        case Green(v) => "Green: ${v}"
        case Blue(v) => "Blue: ${v}"
    }
}

func getDirectionName(dir: Direction): String {
    match (dir) {
        case North => "北"
        case South => "南"
        case East => "东"
        case West => "西"
    }
}

main() {
    let red = RGBColor.Red(255)
    let green = RGBColor.Green(128)
    let blue = RGBColor.Blue(64)

    println(describeColor(red))
    println(describeColor(green))
    println(describeColor(blue))

    let dir = Direction.North
    println("方向: ${getDirectionName(dir)}")
}
