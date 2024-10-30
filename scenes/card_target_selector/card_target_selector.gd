extends Node2D

# 弧线点数
const ARC_POINT := 8

@onready var area_2d: Area2D = $Area2D
@onready var card_arc: Line2D = $CanvasLayer/CardArc

# 当前CardUI引用
var current_card: CardUI
# 是否瞄准标志
var targeting := false

func _ready() -> void:
	Events.card_aim_started.connect(_on_card_aim_started)
	Events.card_aim_ended.connect(_on_card_aim_ended)

func _process(_delta: float) -> void:
	if not targeting:
		return

	area_2d.position = get_local_mouse_position()
	card_arc.points = _get_points()

func _get_points() -> Array:
	var points := []
	var start := current_card.global_position
	# 设置起始点为卡牌顶部中间
	start.x += current_card.size.x / 2
	var target := get_local_mouse_position()
	var distance := target - start
	
	for i in range(ARC_POINT):
		var t := (1.0 / ARC_POINT) * i
		var x := start.x + (distance.x / ARC_POINT) * i
		var y := start.y + ease_out_cubic(t) * distance.y
		points.append(Vector2(x, y))
		
	points.append(target)

	return points

# 定义缓动曲线，起点与重点保持不变
func ease_out_cubic(x: float) -> float:
	return 1.0 - pow(1.0 - x, 3.0)

func _on_card_aim_started(card: CardUI) -> void:
	if not card.card.is_single_targeted():
		return
	targeting = true
	area_2d.monitoring = true
	area_2d.monitorable = true
	current_card = card

func _on_card_aim_ended(_card: CardUI) -> void:
	targeting = false
	card_arc.clear_points()
	area_2d.position = Vector2.ZERO
	area_2d.monitoring = false
	area_2d.monitorable = false
	current_card = null

func _on_area_2d_area_entered(area: Area2D) -> void:
	if not current_card or not targeting:
		return
	
	if not current_card.targets.has(area):
		current_card.targets.append(area)

func _on_area_2d_area_exited(area: Area2D) -> void:
	if not current_card or not targeting:
		return
	
	current_card.targets.erase(area)
