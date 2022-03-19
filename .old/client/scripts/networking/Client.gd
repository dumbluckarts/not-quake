extends Node

signal connection_established
signal connection_closed
signal connection_error
signal data_received(data)
signal update_client(data)
signal push_client(data)
signal ready_client(data)

var port: int
var address: String

var _client: WebSocketClient
var _status: int
var _client_info: Dictionary
var _connected: bool
var _connecting: bool

#
# CONSTRUCT
#

func _init():
	port = 4464
	address = "localhost"
	_client = WebSocketClient.new()

func _ready():
	_client.connect("connection_established", self, "_on_connected")
	_client.connect("connection_closed", self, "_on_connection_closed")
	_client.connect("connection_error", self, "_on_connection_fail")
	_client.connect("data_received", self, "_on_data")
	
func _process(_delta):
	_client.poll()

#
# EVENTS
#

func _on_connection_fail(was_clean = false):
	emit_signal("connection_error")
	_connected = false
	_connecting = false
	
func _on_connection_closed(was_clean = false):
	emit_signal("connection_closed")
	_connected = false
	_connecting = false
	
func _on_connected(proto = ""):
	_connected = true
	_connecting = false
	send('init_client', _client_info)
	emit_signal("connection_established")
	
func _on_data():
	var pkt = _client.get_peer(1).get_packet()
	var dat = parse_json(pkt.get_string_from_utf8())
	
	if dat is Dictionary and 'method' in dat:
		var method = dat['method']
		if method == "update_client": emit_signal(method, dat['data'])
		if method == "ready_client": emit_signal(method, dat['data'])
		if method == "push_client": 
			print('??')
			emit_signal(method, dat['data'])
	else:
		emit_signal("data_received", [ dat ])
	
#
# METHODS
#

func start(client_info: Dictionary):
	_status = _client.connect_to_url("ws://%s:%s" % [address, port])
	_client_info = client_info
	_connecting = true

func send(method, data = null):
	if not _connected: return
	var message = {}
	message['method'] = method
	if data != null: message['data'] = data
	_client.get_peer(1).put_packet(JSON.print(message).to_utf8())

func send_to(id, data = null):
	if not _connected: return
	var message = {}
	message['method'] = 'push_client'
	if data != null: message['data'] = data
	message['data']['id'] = id
	_client.get_peer(1).put_packet(JSON.print(message).to_utf8())
