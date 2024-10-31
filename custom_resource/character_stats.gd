class_name CharacterStats
extends Stats

# 初始牌组
@export var starting_deck: CardPile
# 每回合抽卡的张数
@export var cards_per_turn: int
# 最大法力值
@export var max_mana: int

var mana: int: set = set_mana
# 牌组
var deck: CardPile
# 弃牌堆
var discard: CardPile
# 抽牌堆
var draw_pile: CardPile

func set_mana(value: int) -> void:
    # 法力值可能会短暂的超过最大值
    mana = value
    stats_changed.emit()

func reset_mana() -> void:
    self.mana = max_mana

func can_play_card(card: Card) -> bool:
    return mana > card.cost

func create_instance() -> Resource:
    var instance: CharacterStats = self.duplicate()
    instance.health = max_health
    instance.block = 0
    instance.reset_mana()
    deck = starting_deck.duplicate()
    discard = CardPile.new()
    draw_pile = CardPile.new()
    return instance
