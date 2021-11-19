extends Node

var port: int
var max_players: int
var handle: String

var _server: WebSocketServer
var _status: int

func _init():
	port = 4464
	handle = "server-%s" % (randi() % 999)

func _ready():
	_server = WebSocketServer.new()
	_status = _server.listen(port)
	
	_server.connect("client_connected", self, "_on_connected")
	_server.connect("client_disconnected", self, "_on_disconnected")
	_server.connect("data_received", self, "_on_data")
	
	print("LISTEN %s:%s %s" % ["0.0.0.0", port, _status])

func _process(_delta):
	_server.poll()
	
func _on_connected(id, protocol):
	print("JOIN %s %s" % [id, protocol])
	
func _on_disconnected(id, was_clean = false):
	print("LEAVE %s %s" % [id, was_clean])
	
func _on_data(id):
	var pkt = _server.get_peer(id).get_packet()
	print("DATA %s:%s" % [id, pkt.get_string_from_utf8()])
