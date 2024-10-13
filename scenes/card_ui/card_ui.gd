class_name CardUI
extends Control

# 状态转换后可能需要更新位置，比如进入点击状态需要脱离原来父级HBOX，因此需要重新指定父级
signal reparent_requested(which_card_ui: CardUI)

@onready var color: ColorRect = $Color
@onready var state: Label = $State
@onready var drop_point_detecter: Area2D = $DropPointDetecter
# as用于类型转换，例如把子类转为父类来保证安全
@onready var card_state_machine: CardStateMachine = $CardStateMachine as CardStateMachine

func _ready() -> void:
	card_state_machine.init(self)

func _input(event: InputEvent) -> void:
	card_state_machine.on_input(event)

func _on_gui_input(event: InputEvent) -> void:
	card_state_machine.on_gui_input(event)

func _on_mouse_entered() -> void:
	card_state_machine.on_mouse_entered()

func _on_mouse_exited() -> void:
	card_state_machine.on_mouse_exited()