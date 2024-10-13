class_name CardState
extends Node

# 枚举card_ui的所有状态
enum State {BASE, CLICKED, DRAGGING, AIMING, RELEASED}

# 状态转换信号
signal transition_requested(from: CardState, to: State)

# 为节点分配状态
@export var state: State

# CardUI操作对象
var card_ui: CardUI

# 进入状态后执行的操作
func enter() -> void:
    pass

# 退出状态后执行的操作
func exit() -> void:
    pass

# 输出回调函数
func on_input(_event: InputEvent) -> void:
    pass

# Gui输入回调函数
func on_gui_input(_event: InputEvent) -> void:
    pass

# 鼠标进入后回调函数
func on_mouse_entered() -> void:
    pass

# 鼠标退出后回调函数
func on_mouse_exited() -> void:
    pass
