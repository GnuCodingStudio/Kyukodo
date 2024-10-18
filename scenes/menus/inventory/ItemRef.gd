class_name ItemRef
extends Node


var code: String
var title: String
var texture: Texture2D


func _init(code: String, title: String, texture: Texture2D) -> void:
	self.code = code
	self.title = title
	self.texture = texture
