# 仓颉语言 Claude Skill

> 仓颉（Cangjie）编程语言代码生成与分析专家手册 - 提供13个代码示例、19个易错点检查、完整的语法规则

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/ystyle/cangjie-lang-skill)

---

## 仓库说明
该skill实际使用不佳，待重构

## 📖 项目简介

这是一个专为 Claude Code 设计的仓颉语言语法工作手册，采用 Claude Skills 格式，提供：

- ✅ **13个核心语法模块**：从变量声明到包与导入的完整覆盖
- ✅ **13个代码示例**：从基础到高级的完整演示
- ✅ **19个⚠️易错点**：标注常见错误和注意事项
- ✅ **完整的代码生成流程**：识别需求→加载模板→应用规则→检查易错点
- ✅ **系统的代码分析流程**：解析代码→对照规则→检查易错点→提供修正
- ✅ **三层渐进式披露**：核心→示例→深入参考

---

## 🚀 核心特性

### 1. 三层渐进式披露结构

```
第1层：SKILL.md（核心语法手册）
    ↓ 按需
第2层：examples/（13个具体示例）
    ↓ 按需
第3层：reference/（深入参考） + MCP（官方文档查询）
```

### 2. 双核心场景支持

#### 场景A：代码生成
- 基础代码生成
- 函数定义生成
- 控制流生成
- class定义生成
- 模式匹配生成
- 单元测试生成

#### 场景B：代码分析
- 语法正确性分析
- 潜在错误检测
- 易错点对照检查
- 代码优化建议

### 3. 19个⚠️易错点检查清单

涵盖所有常见的仓颉语言易错点：

**变量相关（3个）**
1. ⚠️ `let` 不支持变量遮蔽
2. ⚠️ 函数参数默认是 `let` 不可变（不能显式使用`let`/`var`）
3. ⚠️ 成员变量默认访问修饰符是 `internal`

**控制流相关（3个）**
4. ⚠️ 条件表达式必须有括号
5. ⚠️ 不支持 `goto`
6. ⚠️ `break`/`continue` 不支持标签跳转

**类型转换相关（2个）**
7. ⚠️ Rune 转整数需确保在有效 Unicode 范围
8. ⚠️ 原始字符串字面量中转义字符不会被转义

**模式匹配相关（2个）**
9. ⚠️ match 表达式的 case 按顺序匹配
10. ⚠️ 常量模式不支持字符串插值

**字符串相关（1个）**
11. ⚠️ 插值字符串使用 `${}` 而非 `{}`，多行原始字符串不支持插值

**函数相关（1个）**
12. ⚠️ Lambda 表达式可以立即调用

**类型系统相关（1个）**
13. ⚠️ Unit 类型只支持赋值、判等、判不等操作

**其他（6个）**
14. ⚠️ 元组至少需要两个元素
15. ⚠️ 区间类型的 step 不能等于 0
16. ⚠️ enum 至少存在一个有名字的构造器
17. ⚠️ match 表达式的 case 不需要 `{}` 括号（多行直接换行）
18. ⚠️ Option 类型用于表示可能有值或无值
19. ⚠️ Duration 和 sleep 在 `std.core` 里不需导入

---

## 📂 项目结构

```
cangjie-lang-skill/
├── SKILL.md                  # 核心手册（主文件，约1600行）
├── README.md                 # 项目说明（本文件）
├── examples/                 # 13个代码示例
│   ├── 01_variable_declaration.cj    # 变量声明
│   ├── 02_basic_types.cj             # 基础类型（字符串字面量）
│   ├── 03_control_flow.cj            # 控制流
│   ├── 04_functions.cj               # 函数（参数不可变）
│   ├── 05_enum.cj                    # 枚举类型
│   ├── 06_pattern_matching.cj        # 模式匹配
│   ├── 07_option_type.cj             # Option类型（完整API）
│   ├── 08_class.cj                   # class类型
│   ├── 09_unit_test.cj               # 单元测试
│   ├── 10_error_handling.cj          # 错误处理（含Option高级用法）
│   ├── 11_quick_reference.cj         # 速查手册
│   ├── 12_collections.cj              # 集合（ArrayList/HashMap）
│   └── 13_package_import.cj          # 包与导入
├── reference/               # 详细参考手册
│   └── 05_common_pitfalls.md         # 19个⚠️易错点详解（1080行）
└── .git/
```

---

## 🎯 使用方法

### 方式1：在 Claude Code 中使用（推荐）

1. 将本项目添加到 Claude Code 的 Skills 目录
2. 在对话中直接提问：
   - "请生成一个仓颉语言的函数"
   - "分析这段仓颉代码有什么问题"
   - "仓颉语言的模式匹配怎么用？"

### 方式2：独立使用

直接阅读 `SKILL.md` 作为语法手册，参考 `examples/` 中的代码示例。

### 方式3：结合 MCP 使用

如果已安装 `cangje-docs-mcp` MCP 服务器，可以查询官方文档：

```python
# 查询 lambda 相关文档
search_documents(query="lambda closure")

# 获取文档内容
get_document_content(doc_id="manual_source_zh_cn_match")

# 列出文档
list_documents(category="manual", subcategory="source_zh_cn")
```

---

## 📊 内容概览

### SKILL.md - 核心手册

包含以下章节：

- **第1章**：语言基础定义（文件后缀、入口函数、注释）
- **第2章**：核心语法规则（13个模块）
  - 2.1 变量声明
  - 2.2 基础类型（三种字符串字面量）
  - 2.3 表达式与控制流
  - 2.4 函数（参数不可变）
  - 2.5 枚举类型
  - 2.6 模式匹配（pattern guard使用where）
  - 2.7 Option类型（完整API：??/isSome/isNone/getOrThrow/ifSome/ifNone）
  - 2.8 class类型
  - 2.9 单元测试
  - 2.10 错误处理
  - 2.11 速查手册
  - 2.12 集合（ArrayList/HashMap/add方法）
  - 2.13 包
- **第3章**：任务处理流程（代码生成+代码分析）
- **第4章**：19个⚠️易错点检查清单

### examples/ - 代码示例

**已完成13个示例**：

| 示例 | 内容 | 难度 |
|-----|------|------|
| 01_variable_declaration.cj | 变量声明（let/var） | beginner |
| 02_basic_types.cj | 基础类型（三种字符串字面量） | beginner |
| 03_control_flow.cj | 控制流（if/while/for） | beginner |
| 04_functions.cj | 函数（参数不可变） | intermediate |
| 05_enum.cj | 枚举类型 | intermediate |
| 06_pattern_matching.cj | 模式匹配（case多行语法） | intermediate |
| 07_option_type.cj | Option类型（完整API） | intermediate |
| 08_class.cj | class类型 | intermediate |
| 09_unit_test.cj | 单元测试 | intermediate |
| 10_error_handling.cj | 错误处理（Option高级用法） | intermediate |
| 11_quick_reference.cj | 速查手册 | advanced |
| 12_collections.cj | 集合（ArrayList/HashMap） | beginner |
| 13_package_import.cj | 包与导入 | intermediate |

每个示例包含：
- 示例名称和语法模块
- 难度等级（beginner/intermediate/advanced）
- ⚠️易错点标注（如有）
- 详细的功能说明注释
- 可运行的代码

### reference/ - 详细参考

- **05_common_pitfalls.md**（1080行）
  - 详细展开19个⚠️易错点
  - 错误原因分析
  - 修正方案对比
  - 正确示例展示

---

## 🔧 开发路线图

### ✅ 已完成（v1.0.0）

- [x] 创建独立仓库
- [x] 编写 SKILL.md 核心手册（1600+行）
- [x] 创建13个代码示例（全部可运行）
- [x] 创建19个易错点详解文档（1080行）
- [x] 10次质量修正（所有内容经过官方文档验证）
- [x] 创建项目 README

### 📅 计划中（v1.1.0+）

- [ ] 创建 templates/ 目录（代码模板）
- [ ] 扩充 reference/ 文档
- [ ] 编写测试用例 tests/
- [ ] 创建辅助脚本 scripts/
- [ ] 社区反馈收集

---

## 📈 质量保证

**所有内容经过官方文档验证**：
- ✅ 搜索 `manual` 分类（语法手册）
- ✅ 搜索 `libs` 分类（标准库API）
- ✅ 使用 `get_document_content()` 查询具体文档
- ✅ 10次修正提升准确性

**最近的质量修正**：
1. ✅ 修正 match case 多行语法（直接换行，不用`{}`）
2. ✅ 修正函数参数说明（不能显式使用`let`/`var`）
3. ✅ 修正字符串插值说明（多行原始字符串不支持）
4. ✅ 修正 pattern guard 语法（使用`where`非`if`）
5. ✅ 修正集合 API 方法名（`add`非`append`/`put`）
6. ✅ 补充 Option 在错误处理中的用法

---

## 🤝 贡献指南

欢迎贡献新的示例、改进建议和问题反馈！

**贡献方式**：
1. Fork 本仓库
2. 创建 feature 分支：`git checkout -b feature/amazing-feature`
3. 提交改动：`git commit -m 'Add amazing feature'`
4. 推送分支：`git push origin feature/amazing-feature`
5. 发起 Pull Request

**质量要求**：
- 代码必须符合仓颉语法规范
- 示例必须有清晰注释（功能、语法模块、难度、⚠️易错点）
- 修改必须经过官方文档验证
- 文档必须标注相关语法模块和易错点

---

## 📝 许可证

本项目采用 [MIT License](LICENSE) 开源许可证。

---

## 🔗 相关资源

- [仓颉编程语言官网](https://developer.huawei.com/consumer/cn/cangjie/)
- [仓颉文档 MCP 服务器](https://github.com/ystyle/cangje-docs-mcp)
- [Claude Code 官方文档](https://claude.ai/code)

---

## 📮 联系方式

- 项目地址：[github.com/ystyle/cangjie-lang-skill](https://github.com/ystyle/cangjie-lang-skill)
- 问题反馈：[GitHub Issues](https://github.com/ystyle/cangjie-lang-skill/issues)

---

**维护者**：仓颉语言社区
**最后更新**：2025-01-07
**版本**：v1.0.0
**总代码量**：4231行（SKILL.md + examples + reference）
