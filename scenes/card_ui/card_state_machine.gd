class_name CardStateMachine
extends Node

# 指定初始状态
@export var initial_state: CardState

var current_state: CardState
# :=代表在初始化时赋值，并根据该值推断出变量类型
var states := {}

func init(card: CardUI) -> void:
	# 注册状态，并传递CardUI对象到具体的状态
	for child in get_children():
		if child is CardState:
			states[child.state] = child
			child.transition_requested.connect(_on_transition_requested)
			child.card_ui = card
	
	# 判断是否有初始状态，如果又初始状态则执行状态进入函数enter()，并更新current_state
	if initial_state:
		initial_state.enter()
		current_state = initial_state

# 输入事件回调函数
func on_input(event: InputEvent) -> void:
	if current_state:
		current_state.on_input(event)

# Gui输入事件回调函数
func on_gui_input(event: InputEvent) -> void:
	if current_state:
		current_state.on_gui_input(event)

# 鼠标进入回调函数
func on_mouse_entered() -> void:
	if current_state:
		current_state.on_mouse_entered()

# 鼠标退出回调函数
func on_mouse_exited() -> void:
	if current_state:
		current_state.on_mouse_exited()

# 状态转移请求回调函数
func _on_transition_requested(from: CardState, to: CardState.State):
	# 校验当前状态一致性
	if current_state != from:
		return
	
	# 校验新状态有效性
	var new_state: CardState = states[to]
	if not new_state:
		return

	if current_state:
		current_state.exit()

	new_state.enter()
	current_state = new_state
