extends CardState

# 卡片是否被使用标志位
var played: bool

func enter() -> void:
	card_ui.color.color = Color.DARK_VIOLET
	card_ui.state.text = "RELEASED"

	played = false

	if not card_ui.targets.is_empty():
		played = true
		print_debug("Play card for target", card_ui.targets)

func on_input(_event: InputEvent) -> void:
	if played:
		return
	transition_requested.emit(self, CardState.State.BASE)