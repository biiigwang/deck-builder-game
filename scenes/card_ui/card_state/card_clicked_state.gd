extends CardState

func enter() -> void:
	card_ui.color.color = Color.ORANGE
	# TODO:[本地化文本]根据设置语言自动翻译文本
	card_ui.state.text = "CLICKED"
	# 开启放置点监控器的监视
	card_ui.drop_point_detector.monitoring = true

func on_input(event: InputEvent) -> void:
	# 判断是否接收到鼠标移动事件
	if event is InputEventMouseMotion:
		# 检测到鼠标移动，发出状态转移信号，下一状态为拖拽状态
		transition_requested.emit(self, CardState.State.DRAGGING)
