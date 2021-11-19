extends Node

var port: int
var address: String
var handle: String

var _client: WebSocketClient
var _status: int

func _init():
	port = 4464
	address = "localhost"
	handle = "client-%s" % (randi() % 999)

func _ready():
	_client = WebSocketClient.new()
	_status = _client.connect_to_url("ws://%s:%s" % [address, port])
	
	_client.connect("connection_established", self, "_on_connected")
	_client.connect("connection_closed", self, "_on_connection_closed")
	_client.connect("connection_error", self, "_on_connection_fail")
	_client.connect("data_received", self, "_on_data")
	
	print("TRY %s:%s %s" % [address, port, _status])
	
func _process(_delta):
	_client.poll()
	
func _on_connection_fail(was_clean = false):
	print("FAIL %s:%s" % [address, port])
	
func _on_connection_closed(was_clean = false):
	print("CLOSE %s:%s" % [address, port])
	
func _on_connected(proto = ""):
	print("SUCCESS %s:%s" % [address, port])
	
func _on_data():
	var pkt = _client.get_peer(1).get_packet()
	print("DATA %s:" % [1, pkt.get_string_from_utf8()])

func send(data):
	_client.get_peer(1).put_packet(str(data).to_utf8())
	print("SENT %s" % str(data))
