extends Sprite2D

@export var next_level: String = "Level2"

func _ready():
	await get_tree().create_timer(3.0).timeout
	change_to_next_level()

func change_to_next_level():
	get_tree().change_scene_to_file("res://scenes/" + next_level + ".tscn")
