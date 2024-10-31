class_name CardPile
extends Resource

# 牌组数目变化信息
signal card_pile_size_changed(cards_amount: int)

# 卡组变量
@export var cards: Array[Card] = []

func empty() -> bool:
    return cards.is_empty()

func draw_card() -> Card:
    # 返回牌组前端值
    var card = cards.pop_front()
    card_pile_size_changed.emit(cards.size())
    return card

func add_card(card: Card) -> void:
    cards.append(card)
    card_pile_size_changed.emit(cards.size())

# 切洗牌组
func shuffle() -> void:
    cards.shuffle()

func clear() -> void:
    cards.clear()
    card_pile_size_changed.emit(cards.size())

func _to_string() -> String:
    var _card_string: PackedStringArray = []
    for i in cards:
        _card_string.append("%s: %s" % [i, cards[i].id])
    # 使用换行符链接卡牌字符串
    return "\n".join(_card_string)