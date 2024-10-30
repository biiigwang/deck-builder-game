extends CardState
const DRAG_MINIMUM_THRESHOLD := 0.05
var minimum_drag_time_elapsed := false


func enter() -> void:
	var ui_layer := get_tree().get_first_node_in_group("ui_layer")
	if ui_layer:
		card_ui.reparent(ui_layer)

	card_ui.color.color = Color.NAVY_BLUE
	card_ui.state.text = "DRAGGING"

	# 添加状态转移判断死区处理
	minimum_drag_time_elapsed = false
	# 定时DRAG_MINIMUM_THRESHOLD秒，并在scene_tree暂停时暂停计时
	var threshold_timer = get_tree().create_timer(DRAG_MINIMUM_THRESHOLD, false)
	threshold_timer.timeout.connect(func(): minimum_drag_time_elapsed = true)

func on_input(event: InputEvent) -> void:
	var mouse_motion := event is InputEventMouseMotion
	var cancel := event.is_action_pressed("right_mouse")
	var confirm := event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse")

	if mouse_motion:
		card_ui.global_position = card_ui.get_global_mouse_position() - card_ui.pivot_offset
		# 下列实现为卡片中心对齐鼠标
		# card_ui.global_position = card_ui.get_global_mouse_position() - card_ui.size / 2

	if cancel:
		transition_requested.emit(self, CardState.State.BASE)
	
	elif minimum_drag_time_elapsed and confirm:
		# 标记输入为已处理，以免意外
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.State.RELEASED)