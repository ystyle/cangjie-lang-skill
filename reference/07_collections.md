# 仓颉语言集合详解

> 本文档详细说明仓颉语言的集合类型，包括 ArrayList、HashMap、HashSet 和 Array 的使用方法和 API。

---

## 目录

- [集合类型概览](#集合类型概览)
- [ArrayList](#arraylist)
- [HashMap](#hashmap)
- [HashSet](#hashset)
- [Array](#array)
- [选择合适的集合类型](#选择合适的集合类型)
- [⚠️ 易错点](#易错点)

---

## 集合类型概览

仓颉提供了四种主要的集合类型：

| 集合类型 | 特点 | 使用场景 |
|---------|------|---------|
| **Array** | 固定大小，元素可变 | 不需要增删，只修改元素 |
| **ArrayList** | 动态大小，可增删改 | 需要频繁操作元素 |
| **HashMap** | 键值对存储 | 需要存储映射关系 |
| **HashSet** | 唯一元素集合 | 需要确保元素唯一性 |

**导入语句**：
```cj
import std.collection.*  // 导入 ArrayList、HashMap、HashSet
// Array 在 std.core 中，不需要导入
```

---

## ArrayList

ArrayList 是动态数组，支持元素的增删改查。

### 创建 ArrayList

```cj
import std.collection.*

// 空列表
var list1 = ArrayList<Int64>()

// 从数组创建
var list2 = ArrayList<Int64>([1, 2, 3])

// 从字面量创建（可变长度参数语法糖）
var list3 = ArrayList<Int64>(1, 2, 3, 4, 5)
```

### 添加元素

#### 1. 添加单个元素到末尾

```cj
var list = ArrayList<Int64>()
list.add(10)      // list: [10]
list.add(20)      // list: [10, 20]
```

**函数签名**：
```cj
public func add(element: T): Unit
```

#### 2. 在指定位置插入元素

```cj
var list = ArrayList<Int64>([1, 2, 3])
list.add(99, at: 1)  // list: [1, 99, 2, 3]
```

**函数签名**：
```cj
public func add(element: T, at!: Int64): Unit
```

#### 3. 添加集合到末尾

```cj
var list = ArrayList<Int64>([1, 2, 3])
var arr = [4, 5, 6]
list.add(all: arr)  // list: [1, 2, 3, 4, 5, 6]
```

**函数签名**：
```cj
public func add(all!: Collection<T>): Unit
```

#### 4. 从指定位置插入集合

```cj
var list = ArrayList<Int64>([1, 2, 3])
var arr = [4, 5]
list.add(all: arr, at: 1)  // list: [1, 4, 5, 2, 3]
```

**函数签名**：
```cj
public func add(all!: Collection<T>, at!: Int64): Unit
```

### 访问元素

```cj
var list = ArrayList<Int64>([10, 20, 30])

// get 返回 Option<T>
let value1 = list.get(1)  // Option<Int64>.Some(20)
let value2 = list.get(10) // Option<Int64>.None

// 使用 getOrThrow
let result1 = list.get(1).getOrThrow()  // 20

// 使用 getOrThrow 会抛出 NoneValueException
try {
    let result2 = list.get(10).getOrThrow()  // 抛异常
} catch (e: NoneValueException) {
    println("Index out of bounds")
}

// 使用 ?? 提供默认值
let result3 = list.get(10) ?? 0  // 0
```

**函数签名**：
```cj
public func get(index: Int64): Option<T>
```

### 修改元素

```cj
var list = ArrayList<Int64>([10, 20, 30])
list[0] = 99  // list: [99, 20, 30]
```

### 删除元素

#### 1. 删除指定位置的元素

```cj
var list = ArrayList<Int64>([10, 20, 30, 40])
list.remove(at: 1)  // list: [10, 30, 40]
```

**函数签名**：
```cj
public func remove(at: Int64): Unit
```

#### 2. 清空列表

```cj
var list = ArrayList<Int64>([10, 20, 30])
list.clear()  // list: []
```

**函数签名**：
```cj
public func clear(): Unit
```

### 其他操作

#### 1. 获取大小

```cj
var list = ArrayList<Int64>([1, 2, 3])
let size = list.size  // 3
```

#### 2. 切片

```cj
var list = ArrayList<Int64>([1, 2, 3, 4, 5])
let range = 1..=3  // Range<Int64>
var sublist = list.slice(range)  // [2, 3, 4]
```

**函数签名**：
```cj
public func slice(range: Range<Int64>): ArrayList<T>
```

---

## HashMap

HashMap 是键值对存储结构，键必须唯一。

### 创建 HashMap

```cj
import std.collection.*

// 空 HashMap
var map1 = HashMap<String, Int64>()

// 从字面量创建
var map2 = HashMap<String, Int64>(("a", 1), ("b", 2), ("c", 3))
```

### 添加元素

#### 1. 添加单个键值对

```cj
var map = HashMap<String, Int64>()
map.add("a", 13)  // map: {"a": 13}
map.add("b", 20)  // map: {"a": 13, "b": 20}
```

**函数签名**：
```cj
public func add(key: K, value: V): Unit
```

#### 2. 添加多个键值对

```cj
var map = HashMap<String, Int64>()
var arr: Array<(String, Int64)> = [("d", 11), ("e", 12)]
map.add(all: arr)  // map: {"d": 11, "e": 12}
```

**函数签名**：
```cj
public func add(all!: Collection<(K, V)>): Unit
```

### 访问元素

```cj
var map = HashMap<String, Int64>()
map.add("a", 13)

// get 返回 Option<V>
let value1 = map.get("a")  // Option<Int64>.Some(13)
let value2 = map.get("x")  // Option<Int64>.None

// 使用 getOrThrow
let result1 = map.get("a").getOrThrow()  // 13

// 使用 ?? 提供默认值
let result2 = map.get("x") ?? 0  // 0
```

**函数签名**：
```cj
public func get(key: K): Option<V>
```

### 修改元素

```cj
var map = HashMap<String, Int64>()
map.add("a", 13)
map.add("a", 20)  // 覆盖原来的值，map: {"a": 20}
```

### 删除元素

#### 1. 删除指定键

```cj
var map = HashMap<String, Int64>()
map.add("a", 13)
map.add("b", 20)

let removed = map.remove("b")  // Option<Int64>.Some(20)
// removed: 20
// map: {"a": 13}
```

**函数签名**：
```cj
public func remove(key: K): Option<V>
```

#### 2. 清空 Map

```cj
var map = HashMap<String, Int64>()
map.add("a", 13)
map.clear()  // map: {}
```

**函数签名**：
```cj
public func clear(): Unit
```

### 检查键是否存在

```cj
var map = HashMap<String, Int64>()
map.add("a", 13)

let hasKey = map.contains("a")  // true
let noKey = map.contains("b")   // false
```

**函数签名**：
```cj
public func contains(key: K): Bool
```

### 其他操作

#### 1. 获取大小

```cj
var map = HashMap<String, Int64>()
map.add("a", 13)
map.add("b", 20)
let size = map.size  // 2
```

---

## HashSet

HashSet 是唯一元素集合，不允许重复值。

### 创建 HashSet

```cj
import std.collection.*

// 空 HashSet
var set1 = HashSet<String>()

// 从数组创建
var set2 = HashSet<String>(["apple", "banana"])
```

### 添加元素

```cj
var set = HashSet<String>()
set.add("apple")   // true，添加成功
set.add("banana")  // true，添加成功
set.add("apple")   // false，已存在，添加失败
```

**函数签名**：
```cj
public func add(element: T): Bool  // 返回是否成功添加
```

### 删除元素

```cj
var set = HashSet<String>()
set.add("apple")
set.add("banana")

let removed1 = set.remove("apple")  // true，删除成功
let removed2 = set.remove("orange") // false，元素不存在
```

**函数签名**：
```cj
public func remove(element: T): Bool  // 返回是否成功删除
```

### 检查元素是否存在

```cj
var set = HashSet<String>()
set.add("apple")

let exists = set.contains("apple")  // true
let notExists = set.contains("orange")  // false
```

**函数签名**：
```cj
public func contains(element: T): Bool
```

### 迭代器

```cj
var set = HashSet<String>()
set.add("apple")
set.add("banana")
set.add("orange")

var it = set.iterator()
while (true) {
    let value = it.next()
    match (value) {
        case Some(v) => println(v)
        case None => break
    }
}
```

**注意**：HashSet 中的元素顺序是不固定的。

### 其他操作

#### 1. 清空集合

```cj
var set = HashSet<String>()
set.add("apple")
set.clear()  // set: {}
```

**函数签名**：
```cj
public func clear(): Unit
```

#### 2. 获取大小

```cj
var set = HashSet<String>()
set.add("apple")
set.add("banana")
let size = set.size  // 2
```

---

## Array

Array 是固定大小的数组，元素可以修改，但不能增删。

⚠️ **注意**：Array 在 `std.core` 包中，**不需要导入**。

### 创建 Array

```cj
// 字面量创建
let arr1 = [1, 2, 3, 4, 5]

// 指定类型
let arr2: Array<Int64> = [1, 2, 3]

// 空数组
let arr3: Array<String> = []
```

### 访问元素

```cj
let arr = [10, 20, 30]
let first = arr[0]  // 10
let second = arr[1] // 20
```

### 修改元素

```cj
var arr = [1, 2, 3]
arr[0] = 99  // arr: [99, 2, 3]
```

### 获取大小

```cj
let arr = [1, 2, 3, 4, 5]
let size = arr.size  // 5
```

### 转换方法

```cj
// String 转 Rune 数组
let runes = "Hello".toRuneArray()

// Array 转 ArrayList
let arr = [1, 2, 3]
let list = ArrayList<Int64>(arr)
```

---

## 选择合适的集合类型

### 使用场景对比

#### 1. Array vs ArrayList

| 特性 | Array | ArrayList |
|------|-------|-----------|
| 大小 | 固定 | 动态 |
| 性能 | 更快 | 稍慢 |
| 使用场景 | 大小固定，频繁修改 | 频繁增删 |

**选择建议**：
- ✅ 使用 Array：大小固定，主要操作是修改元素
- ✅ 使用 ArrayList：需要频繁增删元素

#### 2. HashMap vs HashSet

| 特性 | HashMap | HashSet |
|------|---------|---------|
| 存储内容 | 键值对 | 单个元素 |
| 唯一性 | 键唯一 | 元素唯一 |
| 使用场景 | 存储映射关系 | 确保元素唯一性，快速查找 |

**选择建议**：
- ✅ 使用 HashMap：需要通过键查找值
- ✅ 使用 HashSet：需要确保元素唯一，快速判断存在性

### 性能考虑

#### 操作复杂度

| 集合类型 | 访问 | 添加 | 删除 | 查找 |
|---------|------|------|------|------|
| Array | O(1) | - | - | O(n) |
| ArrayList | O(1) | O(1)* | O(n) | O(n) |
| HashMap | - | O(1)* | O(1)* | O(1)* |
| HashSet | - | O(1)* | O(1)* | O(1)* |

\* 平均情况，最坏情况可能不同

---

## ⚠️ 易错点

### 1. ⚠️ 集合 API 方法名

仓颉的集合使用 `add()` 方法，**不是** `append()` 或 `put()`。

```cj
// ❌ 错误（这些方法不存在）
list.append(10)
map.put("key", "value")

// ✅ 正确
list.add(10)
map.add("key", "value")
```

### 2. ⚠️ ArrayList 没有 `append()`

```cj
var list = ArrayList<Int64>()

// ❌ 错误
list.append(10)

// ✅ 正确
list.add(10)
```

### 3. ⚠️ HashMap 没有 `put()`

```cj
var map = HashMap<String, Int64>()

// ❌ 错误
map.put("key", 10)

// ✅ 正确
map.add("key", 10)
```

### 4. ⚠️ 访问越界返回 Option

集合的 `get()` 方法返回 `Option<T>`，不会直接抛异常。

```cj
var list = ArrayList<Int64>([1, 2, 3])

// ✅ 使用 Option
let value = list.get(10)
match (value) {
    case Some(v) => println("Value: ${v}")
    case None => println("Index out of bounds")
}

// ✅ 使用 getOrThrow
try {
    let result = list.get(10).getOrThrow()  // 抛 NoneValueException
} catch (e: NoneValueException) {
    println("Error: ${e.message}")
}

// ✅ 使用 ?? 提供默认值
let result = list.get(10) ?? 0
```

### 5. ⚠️ HashSet 顺序不固定

HashSet 中的元素顺序是不确定的，不要依赖顺序。

```cj
var set = HashSet<String>()
set.add("apple")
set.add("banana")
set.add("orange")

// ⚠️ 不要假设顺序
for (item in set) {
    println(item)  // 每次运行顺序可能不同
}
```

### 6. ⚠️ HashMap 键的类型约束

HashMap 的键类型必须实现 `Hashable` 和 `Equatable` 接口。

```cj
// ✅ 正确：String 实现了 Hashable 和 Equatable
var map1 = HashMap<String, Int64>()

// ✅ 正确：Int64 实现了 Hashable 和 Equatable
var map2 = HashMap<Int64, String>()

// ❌ 错误：自定义类需要实现 Hashable 和 Equatable
class MyClass {
    let value: Int64
}
var map3 = HashMap<MyClass, String>()  // 编译错误
```

---

## 完整示例

```cj
import std.collection.*

main() {
    // ArrayList 示例
    println("=== ArrayList 示例 ===")
    var list = ArrayList<Int64>()
    list.add(10)
    list.add(20)
    list.add(30)
    println("List: ${list}")

    list.add(99, at: 1)
    println("After insert at 1: ${list}")

    list.remove(at: 2)
    println("After remove at 2: ${list}")

    // HashMap 示例
    println("\n=== HashMap 示例 ===")
    var map = HashMap<String, Int64>()
    map.add("apple", 10)
    map.add("banana", 20)
    println("Map: ${map}")

    let value = map.get("apple")
    println("Value of 'apple': ${value.getOrThrow()}")

    map.remove("banana")
    println("After remove 'banana': ${map}")

    // HashSet 示例
    println("\n=== HashSet 示例 ===")
    var set = HashSet<String>()
    set.add("apple")
    set.add("banana")
    set.add("apple")  // 重复，不会被添加
    println("Set: ${set}")

    let hasApple = set.contains("apple")
    println("Contains 'apple': ${hasApple}")

    // Array 示例
    println("\n=== Array 示例 ===")
    var arr = [1, 2, 3, 4, 5]
    arr[0] = 99
    println("Array: ${arr}")
    println("Size: ${arr.size}")
}
```

---

## 参考章节

- **SKILL.md 第2.12节**：集合基础
- **examples/12_collections.cj**：集合示例代码
- **reference/05_common_pitfalls.md**：易错点详解

---

**文档维护**：仓颉语言社区
**最后更新**：2025-01-07
**版本**：v1.0.0
