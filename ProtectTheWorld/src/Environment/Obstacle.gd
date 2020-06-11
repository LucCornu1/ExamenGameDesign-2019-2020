tool
extends StaticBody2D

enum Items {fenceRed, fenceYellow, sandbagBeige}

var regions = {
	Items.fenceRed: Rect2(243, 336, 96, 32),
	Items.fenceYellow: Rect2(128, 216, 104, 32),
	Items.sandbagBeige: Rect2(436, 164, 64, 44)
}

export (Items) var type setget _update


func _update(_type):
	type = _type
	if !Engine.editor_hint:
		yield(self, 'tree_entered')
	$Sprite.region_rect = regions[type]
	var rect = RectangleShape2D.new()
	rect.extents = $Sprite.region_rect.size / 2
	$CollisionShape2D.shape = rect
