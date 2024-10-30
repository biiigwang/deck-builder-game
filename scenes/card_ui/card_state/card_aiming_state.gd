extends CardState

# 定义Y轴阈值，小于该阈值后取消瞄准
const MOUSE_Y_SNAPBACK_THRESHOLD := 138

func enter() -> void:
    card_ui.color.color = Color.WEB_PURPLE
    card_ui.state.text = "AIMING"
    # 进入瞄准模式后，只关心瞄准对象了，因此需要清除
    card_ui.targets.clear()
    # 计算卡片偏移量
    var offset := Vector2(card_ui.parent.size.x / 2, -card_ui.size.y / 2)
    offset.x -= card_ui.size.x / 2
    # 缓动到卡牌中心
    card_ui.animate_to_position(card_ui.parent.global_position + offset, 0.2)
    # 设置落点检测监控属性为false
    card_ui.drop_point_detector.monitoring = false
    # 通过事件总线发射开始瞄准信号
    Events.card_aim_started.emit(card_ui)

func exit() -> void:
    # 通过事件总线发射结束瞄准信号
    Events.card_aim_ended.emit(card_ui)

func on_input(event: InputEvent) -> void:
    # 鼠标移动标志
    var mouse_motion := event is InputEventMouseMotion
    # 判断鼠标是否大于阈值
    var mouse_at_bottom := card_ui.get_global_mouse_position().y > MOUSE_Y_SNAPBACK_THRESHOLD

    # 加入鼠标移动到底部，或者按下了鼠标右键则认为取消瞄准，回到基础状态
    if (mouse_motion and mouse_at_bottom) or event.is_action_pressed("right_mouse"):
        transition_requested.emit(self, CardState.State.BASE)
    elif event.is_action_released("left_mouse") or event.is_action_pressed("left_mouse"):
        # 标记输入为已处理
        get_viewport().set_input_as_handled()
        transition_requested.emit(self, CardState.State.RELEASED)
