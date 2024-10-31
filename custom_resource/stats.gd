class_name Stats
extends Resource

signal stats_changed

@export var max_health := 1
@export var art: Texture

# 定义生命值变量，并定义setter方法
var health: int: set = set_health
# 定义护甲变量，并定义setter方法
var block: int: set = set_block

func set_health(value: int) -> void:
    health = clampi(value, 0, max_health)
    stats_changed.emit()

func set_block(value: int) -> void:
    block = clampi(value, 0, 999)
    stats_changed.emit()

func take_damage(damage: int) -> void:
    if damage <= 0:
        return
    var initial_damage = damage
    # 限制伤害为0与damage之间
    damage = clampi(damage - block, 0, damage)
    # 使用self.确保setter函数被调用
    self.block = clampi(block - initial_damage, 0, block)
    self.health -= damage

func heal(amount: int) -> void:
    self.health += amount

# 克隆新的资源实例
func create_instance() -> Resource:
    var instance: Stats = self.duplicate()
    instance.health = max_health
    instance.block = 0
    return instance