# [使用 gettext 进行本地化](https://docs.godotengine.org/zh-cn/4.x/tutorials/i18n/localization_using_gettext.html#localization-using-gettext)

本文档参考godot官方文档[使用 gettext 进行本地化](https://docs.godotengine.org/zh-cn/4.x/tutorials/i18n/localization_using_gettext.html#localization-using-gettext)编写

为了支持多语言，因此需要进行游戏的国际化工作。

常用两种方法：

* KV模式：使用键值对进行文本的翻译匹配
* 使用特定的标识符

如果首先用英语发布游戏，后来以其他语言发布游戏，则第一种方法可能更易于开发；但是如果同时使用多种语言，则完全是一场噩梦。

一般来说, 游戏使用第二种方法, 并为每个字符串使用唯一的ID. 这允许你在翻译为其他语言时修改文本. 唯一ID可以是数字, 字符串, 或带有数字的字符串(无论如何, 它只是一个唯一的字符串).

# 翻译文件的载体

常见的文件载体为CSV文件，使用gettext可以更方便的进行版本管理

# 原理

## gettext介绍

相比于`CSV`文件，`gettext`文件有以下特点：

### 优势
gettext 是一种标准格式，可以使用任何文本编辑器或图形用户界面编辑器（如 Poedit）进行编辑。

Transifex 和 Weblate 等翻译平台也支持 gettext，让人们可以更方便地进行本地化协作。

与 CSV 相比，gettext 更适合 Git 这样的版本控制系统，因为每个语言环境都有自己的消息文件。

与 CSV 文件相比，在 gettext 文件中编辑多行字符串更方便。

### 缺点
gettext 是一种比 CSV 更复杂的格式，对于刚接触软件本地化的人来说可能更难理解。

维护本地化文件的人员必须在其系统上安装 gettext 工具。但是，由于 Godot 支持使用基于文本的消息文件（.po），翻译人员无需安装 gettext 工具即可测试他们的工作。

# Godot使用gettext的方法

## 生成`.pot`模板

在 `Project` -> `Project Setting` -> `Localization` -> `POT Generation`添加所有可能需要进行翻译的文件，点击`Generation POT`选择路径保存

此时生成出来的模板文件，带有`#, fuzzy`注释，该注释意味着含糊不清，godot不会使用带有该模板的翻译资源

## 安装gettext工具

略

## 生成`.po`文件

msginit 命令用于将 PO 模板转换为消息文件。例如，要创建简体汉语本地化文件，请在目录中使用以下命令：
```bash
msginit --no-translator --input=your.pot --locale=zh-cn
```

## 进行翻译
一个例子如下，`.po`文件中会标注在什么个资源中，某个唯一字符串，`msgid`代表着唯一字符串id，`msgstr`代表着该字符串在指定语言下的翻译。

以下是一个具体的例子

```gettext
# LANGUAGE translation for deck builder game for the following files:
# res://scenes/card_ui/card_ui.tscn
# res://scenes/card_ui/card_state/card_base_state.gd
# res://scenes/card_ui/card_state/card_clicked_state.gd
# res://scenes/card_ui/card_state/card_dragging_state.gd
# res://scenes/card_ui/card_state/card_released_state.gd
# res://scenes/battle/battle.tscn
#
# Automatically generated, 2024.
#
msgid ""
msgstr ""
"Project-Id-Version: deck builder game\n"
"MIME-Version: 1.0\n"
"Content-Type: text/plain; charset=UTF-8\n"
"Content-Transfer-Encoding: 8bit\n"
"Last-Translator: Automatically generated\n"
"Language-Team: none\n"
"Language: zh-cn\n"

#: scenes/card_ui/card_ui.tscn scenes/card_ui/card_state/card_base_state.gd
msgid "BASE"
msgstr "基础"

#: scenes/card_ui/card_state/card_clicked_state.gd
msgid "CLICKED"
msgstr "点击"

#: scenes/card_ui/card_state/card_dragging_state.gd
msgid "DRAGGING"
msgstr "拖拽"

#: scenes/card_ui/card_state/card_released_state.gd
msgid "RELEASED"
msgstr "释放"

```

## 更新`.po`文件
在更新`.pot`文件后需要同步更新资源文件`.po`文件，删除不复存在的文本，增加新的内容，命令如下：
```bash
# The order matters: specify the message file *then* the PO template!
msgmerge --update --backup=none your.po your.pot
```

## Godot加载`.po`文件
翻译完毕后就可以从godot中加载该翻译资源了
在 `Project` -> `Project Setting` -> `Localization` -> `Translations`点击`Add`，选择对应的`.po`翻译资源进行翻译

# 使用GDScript切换语言
可以通过调用`TranslationServer`的`set_locale`方法来切换语言。

如果你不确定要使用的语言代码，请参阅[区域代码列表](https://docs.godotengine.org/zh-cn/4.x/tutorials/i18n/locales.html#doc-locales)。
```gdscript
TranslationServer.set_locale("en")
```