class_name Card
extends Resource

# 定义卡牌类型
enum Type {ATTACK, DEFEND, POWER}
# 定义卡牌的释放目标类型
enum Target {SELF, SINGLE_ENEMY, ALL_ENEMIES, EVERYONE}

# 声明属性分组名称,在Godot编辑器中方便查看
@export_group("Card Attributes")
@export var id: String
@export var type: Type
@export var target: Target

# 判断自身是否为单体效果卡片
func is_single_targeted() -> bool:
    return target == Target.SINGLE_ENEMY
