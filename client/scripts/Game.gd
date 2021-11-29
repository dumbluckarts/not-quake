extends Node

export var GAME: NodePath
export var PLAYER: NodePath
export var MAP: NodePath
export var CANVAS: NodePath

func _ready():
	GAME = "/root/Spatial"
	PLAYER = "%s/Player" % GAME
	MAP = "%s/Map/Map Organized" % GAME
	CANVAS = "%s/CanvasLayer" % GAME

func get_player(): return get_node(PLAYER) as Player
func get_player_node(nodePath: NodePath): return get_player().get_node(nodePath)
func get_camera(): return get_player_node("Mouse/Camera") as Camera
func get_interface(): return get_node(CANVAS) as Interface
func get_interface_node(nodePath: NodePath): return get_interface().get_node(nodePath)
func get_map(): return get_node(MAP) as Map
