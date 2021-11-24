extends Node

var port: int
var max_players: int
var handle: String

var _server: WebSocketServer
var _status: int
var _clients: Dictionary

func _init():
	port = 4464
	handle = "server-%s" % (randi() % 999)
	_clients = {}

func _ready():
	_server = WebSocketServer.new()
	_status = _server.listen(port)
	
	_server.connect("client_connected", self, "_on_connected")
	_server.connect("client_disconnected", self, "_on_disconnected")
	_server.connect("data_received", self, "_on_data")
	
	print("LISTEN %s:%s %s" % ["0.0.0.0", port, _status])

func _physics_process(delta):
	_server.poll()
	
	for key in _clients.keys():
		var copy = _clients.duplicate(true)
		copy.erase(key)
		var message = {}
		message['method'] = 'update_client'
		message['data'] = copy 
	
		_server.get_peer(key).put_packet(JSON.print(message).to_utf8())
	
func _on_connected(id, protocol):
	_clients[id] = {}
	print("JOIN %s %s" % [id, protocol])
	
func _on_disconnected(id, was_clean = false):
	_clients.erase(id)
	print("LEAVE %s %s" % [id, was_clean])
	
func _on_data(id):
	var pkt = _server.get_peer(id).get_packet()
	var dat = parse_json(pkt.get_string_from_utf8())
	
	if not 'method' in dat: return
	var method = dat['method']
	if method[0] == "_": return
	if 'data' in dat: call(method, id, dat['data'])
	else: call(method, id)

func init_client(id, data):
	_clients[id] = data
	_clients[id]['ready'] = false
	_clients[id]['id'] = id
	_server.get_peer(id).put_packet(str(OK).to_utf8())
	print('CLIENT %s' % _clients)
	
func ready_client(id):
	_clients[id]['ready'] = true
	
	var copy = _clients.duplicate(true)
	copy.erase(id)
	var message = {}
	message['method'] = 'ready_client'
	message['data'] = _clients[id]
	for key in copy.keys():
		_server.get_peer(key).put_packet(JSON.print(message).to_utf8())
		
	print('CLIENT %s' % _clients[id])
	
func update_client(id, data):
	_clients[id]['data'] = data

func push_client(id, data):
	var message = {}
	message['method'] = 'push_client'
	message['data'] = data
	_server.get_peer(int(data['id'])).put_packet(JSON.print(message).to_utf8())
