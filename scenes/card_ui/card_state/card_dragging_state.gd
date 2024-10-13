extends CardState

func enter() -> void:
	var ui_layer := get_tree().get_first_node_in_group("ui_layer")
	if ui_layer:
		card_ui.reparent(ui_layer)

	card_ui.color.color = Color.NAVY_BLUE
	# TODO:[本地化文本]根据设置语言自动翻译文本
	card_ui.state.text = "DRAGGING"

func on_input(event: InputEvent) -> void:
	var mouse_motion := event is InputEventMouseMotion
	var cancel := event.is_action_pressed("right_mouse")
	var confirm := event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse")

	if mouse_motion:
		card_ui.global_position = card_ui.get_global_mouse_position() - card_ui.pivot_offset
		# card_ui.global_position = card_ui.get_global_mouse_position() - card_ui.size / 2

	if cancel:
		transition_requested.emit(self, CardState.State.BASE)
	
	if confirm:
		# 标记输入为已处理，以免意外
		get_viewport().set_input_as_handled()
		transition_requested.emit(self, CardState.State.RELEASED)