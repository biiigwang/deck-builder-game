extends CardState

func enter() -> void:
	# 等待CardUI节点初始完毕
	# Godot初始顺序：先初始化子节点，等所有子节点都初始化结束再初始化父节点
	if not card_ui.is_node_ready():
		# await会将控制权交还给调用方，当接收到card_ui的ready信号时继续运行
		await card_ui.ready

	# 发送重新父化信号
	card_ui.reparent_requested.emit(card_ui)
	card_ui.color.color = Color.WEB_GREEN
	# TODO:[本地化文本]根据设置语言自动翻译文本
	card_ui.state.text = "BASE"
	# 调整卡片旋转中心偏移量，不希望卡片左上角紧贴鼠标指针，希望卡片中心跟随指针
	# 在基础状态将其初始化为0
	card_ui.pivot_offset = Vector2.ZERO

func on_gui_input(event: InputEvent) -> void:
	if event.is_action_pressed("left_mouse"):
		# 计算旋转中心偏移量
		card_ui.pivot_offset = card_ui.get_global_mouse_position() - card_ui.global_position
		# 发送状态转移信号
		transition_requested.emit(self, CardState.State.CLICKED)
