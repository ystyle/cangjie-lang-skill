/**
 * 示例名称：集合使用
 * 语法模块：第2.12节 - 集合
 * 难度：beginner
 * ⚠️ 易错点：无
 *
 * 本示例演示：
 * - Array：固定大小数组
 * - ArrayList：动态数组
 * - HashSet：哈希集合
 * - HashMap：哈希映射
 * - 集合的增删改查操作
 */
import std.collection.ArrayList
import std.collection.HashSet
import std.collection.HashMap

main() {
    // ==================== Array ====================
    println("=== Array ===")
    // 创建 Array（字面量）
    let arr: Array<String> = ["A", "B", "C"]

    // 访问元素
    println("arr[0] = ${arr[0]}")  // 输出: A

    // 修改元素
    arr[0] = "X"
    println("After modification: arr[0] = ${arr[0]}")  // 输出: X

    // 获取大小
    println("Array size: ${arr.size}")  // 输出: 3

    // 遍历
    println("Array elements:")
    for (item in arr) {
        println("  ${item}")
    }

    // ==================== ArrayList ====================
    println("\n=== ArrayList ===")
    // 创建 ArrayList
    let list = ArrayList<Int64>()

    // 添加元素（使用 add 方法）
    list.add(1, at: 0)  // 在位置 0 添加 1
    list.add(2, at: 1)  // 在位置 1 添加 2
    list.add(3, at: 2)  // 在位置 2 添加 3

    // 或使用 add 添加整个数组
    let arr = [4, 5]
    list.add(all: arr)  // list: [1, 2, 3, 4, 5]

    println("ArrayList size: ${list.size}")  // 输出: 5

    // 访问元素（使用 get 方法，返回 Option）
    let value = list.get(0)
    match (value) {
        case Option<Int64>.Some(v) => println("list.get(0) = ${v}")
        case Option<Int64>.None => println("Not found")
    }

    // 或使用下标访问
    println("list[0] = ${list[0]}")  // 输出: 1

    // 修改元素
    list[0] = 10

    // 删除元素
    list.remove(at: 0)  // 移除第一个元素
    println("After removal, size: ${list.size}")  // 输出: 4

    // 遍历
    println("ArrayList elements:")
    for (item in list) {
        println("  ${item}")
    }

    // ==================== HashSet ====================
    println("\n=== HashSet ===")
    // 创建 HashSet
    let set = HashSet<Int64>()

    // 添加元素
    set.add(1)
    set.add(2)
    set.add(3)
    set.add(1)  // 重复元素不会被添加

    println("HashSet size: ${set.size}")  // 输出: 3（重复的 1 没有添加）

    // 检查是否包含
    if (set.contains(2)) {
        println("HashSet contains 2")
    }

    if (!set.contains(100)) {
        println("HashSet does not contain 100")
    }

    // 删除元素
    set.remove(2)
    println("After removal, size: ${set.size}")  // 输出: 2

    // 遍历
    println("HashSet elements:")
    for (item in set) {
        println("  ${item}")
    }

    // ==================== HashMap ====================
    println("\n=== HashMap ===")
    // 创建 HashMap（字面量）
    let map: HashMap<String, Int64> = HashMap(
        ("A", 1),
        ("B", 2),
        ("C", 3)
    )

    // 或者使用方括号形式
    let map2: HashMap<String, Int64> = HashMap([
        ("D", 4),
        ("E", 5)
    ])

    // 或者创建空 HashMap
    let emptyMap = HashMap<String, Int64>()

    // 添加元素（使用 add 方法）
    emptyMap.add("D", 4)
    emptyMap.add("E", 5)

    // 访问元素（使用 get 方法，返回 Option）
    let valueA = map.get("A")
    match (valueA) {
        case Option<Int64>.Some(v) => println("map.get('A') = ${v}")
        case Option<Int64>.None => println("map['A'] not found")
    }

    // 修改元素
    map["A"] = 10
    println("After modification: ${map["A"]}")

    // 检查是否包含键
    if (map.contains("B")) {
        println("Map contains key 'B'")
    }

    // 删除元素
    map.remove("C")
    println("After removal, size: ${map.size}")

    // 遍历
    println("HashMap elements:")
    for ((key, value) in map) {
        println("  ${key} => ${value}")
    }

    // ==================== 集合常用操作总结 ====================
    println("\n=== 集合操作总结 ===")
    println("Array:")
    println("  - 创建: [\"A\", \"B\", \"C\"]")
    println("  - 访问: arr[0]")
    println("  - 修改: arr[0] = \"X\"")
    println("  - 大小: arr.size")
    println("  - 不能添加或删除元素")

    println("\nArrayList:")
    println("  - 创建: ArrayList<T>()")
    println("  - 添加: add(element, at: index) 或 add(all: array)")
    println("  - 删除: remove(at: index)")
    println("  - 访问: list[index] 或 list.get(index)（返回 Option）")
    println("  - 修改: list[index] = value")

    println("\nHashSet:")
    println("  - 创建: HashSet<T>()")
    println("  - 添加: add(element)")
    println("  - 删除: remove(element)")
    println("  - 检查: contains(element)")
    println("  - 元素唯一")

    println("\nHashMap:")
    println("  - 创建: HashMap<K, V>() 或字面量")
    println("  - 添加: add(key, value)")
    println("  - 访问: map.get(key)（返回 Option）或 map[key]")
    println("  - 删除: remove(key)")
    println("  - 检查: contains(key)")
}
