tool
extends StaticBody2D

enum Items {
	fenceRed, fenceYellow, sandbagBeige, wireCrooked, 
	wireStraight, treeBrown_large, treeGreen_large, 
	barricadeMetal
}

var regions = {
	Items.fenceRed: Rect2(243, 336, 96, 32),
	Items.fenceYellow: Rect2(128, 216, 104, 32),
	Items.sandbagBeige: Rect2(436, 164, 64, 44),
	Items.wireCrooked: Rect2(346, 0, 88, 95),
	Items.wireStraight: Rect2(688, 0, 33, 139),
	Items.treeBrown_large: Rect2(0, 0, 128, 128),
	Items.treeGreen_large: Rect2(0, 128, 128, 128),
	Items.barricadeMetal: Rect2(596, 532, 56, 56)
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
