extends CardState

func enter() -> void:
	card_ui.color.color = Color.DARK_VIOLET
	# TODO:[本地化文本]根据设置语言自动翻译文本
	card_ui.state.text = "RELEASED"