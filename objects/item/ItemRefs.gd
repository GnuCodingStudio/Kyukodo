extends Node

var REF_APPLE = ItemRef.new(
	"APPLE",
	"ITEM_APPLE",
	preload("res://objects/item/apple/StaticApple.tres")
)

var REF_PUMPKIN = ItemRef.new(
	"PUMPKIN",
	"Pumpkin",
	preload("res://objects/pumpkin/pumpkin.png")
)

// TODO Créer un StaticStone.tres comme pour les pommes
var REF_STONE = ItemRef.new(
	"STONE",
	"ITEM_STONE",
	preload("res://objects/pumpkin/pumpkin.png")
)
