# 仓颉语言 Claude Skill

> 仓颉（Cangjie）编程语言代码生成与分析工作手册 - 专为 Claude Code 设计

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)](https://github.com/ystyle/cangjie-lang-skill)

---

## 📖 项目简介

这是一个专为 Claude Code 设计的仓颉语言语法工作手册，采用 Claude Skills 格式，提供：

- ✅ **11个核心语法模块**：从变量声明到模式匹配的完整覆盖
- ✅ **39个代码示例**：按难度分级（初级/中级/高级）
- ✅ **19个⚠️易错点**：标注常见错误和注意事项
- ✅ **完整的代码生成流程**：6大场景的生成指导
- ✅ **系统的代码分析流程**：3大场景的分析方法
- ✅ **三层渐进式披露**：核心→示例/模板→深入参考

---

## 🚀 核心特性

### 1. 三层渐进式披露结构

```
第1层：SKILL.md（核心语法手册）
    ↓ 按需
第2层：examples/（39个具体示例） + templates/（代码模板）
    ↓ 按需
第3层：reference/（10个深入参考章节） + MCP（官方文档）
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
- 代码优化建议

### 3. 19个⚠️易错点检查清单

从变量声明到类型转换，涵盖所有常见的仓颉语言易错点：

1. ⚠️ `let` 不支持变量遮蔽
2. ⚠️ 函数参数默认是 `let` 不可变
3. ⚠️ 成员变量默认访问修饰符是 `internal`
4. ⚠️ 条件表达式必须有括号
5. ⚠️ 不支持 `goto`
6. ⚠️ `break`/`continue` 不支持标签跳转
...（共19个）

---

## 📂 项目结构

```
cangjie-lang-skill/
├── SKILL.md                  # 核心手册（主文件，约350KB）
├── README.md                 # 项目说明（本文件）
├── examples/                 # 39个代码示例
│   ├── 01_variable_declaration.cj
│   ├── 02_basic_types.cj
│   ├── ...
│   └── 39_advanced_example.cj
├── templates/                # 15-20个代码模板
│   ├── basic/               # 基础模板
│   ├── functions/           # 函数模板
│   ├── control_flow/        # 控制流模板
│   ├── data_structures/     # 数据结构模板
│   └── testing/             # 测试模板
├── reference/               # 详细参考手册
│   ├── 01_syntax_summary.md
│   ├── 02_type_system.md
│   ├── 03_pattern_matching.md
│   ├── 04_access_modifiers.md
│   ├── 05_common_pitfalls.md     # 重点：19个⚠️易错点详解
│   ├── 06_functional_features.md
│   ├── 07_collections.md
│   ├── 08_error_handling.md
│   ├── 09_testing_guide.md
│   └── 10_mcp_integration_guide.md
├── scripts/                 # 辅助脚本
│   ├── extract_examples.sh
│   ├── validate_syntax.sh
│   └── generate_reference.sh
└── tests/                   # 测试用例
    ├── skill_loading_test.md
    ├── example_validity_test.md
    └── reference_completeness_test.md
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
get_document_content(doc_id="manual_source_zh_cn_functions")
```

---

## 📊 内容概览

### SKILL.md - 核心手册

包含以下章节：

- **第1章**：语言基础定义（文件后缀、入口函数、注释）
- **第2章**：核心语法规则（11个模块）
  - 2.1 变量声明
  - 2.2 基础类型
  - 2.3 表达式与控制流
  - 2.4 函数
  - 2.5 枚举类型
  - 2.6 模式匹配
  - 2.7 Option类型
  - 2.8 class类型
  - 2.9 单元测试
  - 2.10 错误处理
  - 2.11 速查手册
- **第3章**：任务处理流程（代码生成6场景、代码分析3场景）
- **第4章**：19个⚠️易错点检查清单
- **第5章**：示例与模板参考
- **第6章**：质量控制标准
- **第7章**：MCP文档集成

### examples/ - 代码示例

**基础示例（01-15）**：
- 变量声明、基础类型、控制流、函数
- 枚举、模式匹配、Option类型
- class类型、单元测试、错误处理、速查手册

**中级示例（16-27）**：
- Lambda表达式和高阶函数
- 复杂模式匹配
- class继承和多态
- 集合操作
- 异常处理
- 测试用例编写

**高级示例（28-39）**：
- 综合应用案例
- 性能优化技巧
- 最佳实践展示

每个示例包含：
- 示例名称和语法模块
- 难度等级
- ⚠️易错点标注（如有）
- 详细的功能说明注释

---

## 🔧 开发路线图

### ✅ 已完成（v1.0.0）

- [x] 创建独立仓库
- [x] 编写 SKILL.md 核心手册
- [x] 提取前11个基础示例
- [x] 创建项目 README

### 🚧 进行中

- [ ] 提取剩余28个代码示例（12-39）
- [ ] 生成参考手册 reference/（10个章节）
- [ ] 创建15-20个代码模板 templates/

### 📅 计划中（v1.1.0）

- [ ] 编写测试用例 tests/
- [ ] 创建辅助脚本 scripts/
- [ ] Alpha 测试和语法验证
- [ ] 社区反馈收集

---

## 🤝 贡献指南

欢迎贡献新的示例、模板和改进建议！

**贡献方式**：
1. Fork 本仓库
2. 创建 feature 分支：`git checkout -b feature/amazing-feature`
3. 提交改动：`git commit -m 'Add amazing feature'`
4. 推送分支：`git push origin feature/amazing-feature`
5. 发起 Pull Request

**质量要求**：
- 代码必须符合仓颉语法规范
- 示例必须有清晰注释（功能、语法模块、难度、⚠️易错点）
- 模板必须有使用说明和可配置参数
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
