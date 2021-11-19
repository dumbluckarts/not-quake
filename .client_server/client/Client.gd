extends Node

signal connected
signal disconnected
signal failed
signal message

var port: int
var address: String
var client: WebSocketClient

var _status: int
var _client_info: Dictionary

#
# CONSTRUCT
#

func _init():
	port = 4464
	address = "localhost"
	client = WebSocketClient.new()

func _ready():
	client.connect("connection_established", self, "_on_connected")
	client.connect("connection_closed", self, "_on_connection_closed")
	client.connect("connection_error", self, "_on_connection_fail")
	client.connect("data_received", self, "_on_data")
	
func _process(_delta):
	client.poll()

#
# EVENTS
#

func _on_connection_fail(was_clean = false):
	print("FAIL %s:%s" % [address, port])
	
func _on_connection_closed(was_clean = false):
	print("CLOSE %s:%s" % [address, port])
	
func _on_connected(proto = ""):
	print("SUCCESS %s:%s" % [address, port])
	send('init_client', _client_info)
	
func _on_data():
	var pkt = _client.get_peer(1).get_packet()
	print("DATA %s:" % [1, pkt.get_string_from_utf8()])

#
# METHODS
#

func start(client_info: Dictionary):
	_status = _client.connect_to_url("ws://%s:%s" % [address, port])
	_client_info = client_info
	print("TRY %s:%s %s" % [address, port, _status])

func send(method, data = null):
	var message = {}
	
	message['method'] = method
	if data: message['data'] = data
	
	_client.get_peer(1).put_packet(JSON.print(message).to_utf8())
	print("SENT %s" % JSON.print(message))
