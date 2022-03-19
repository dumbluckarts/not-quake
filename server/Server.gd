extends MainLoop

var config
var socket
var status
var connections

func _initialize():
    # Load configuration
    config = ConfigFile.new()
    config.load('user://server/server.cfg')

	# Initialize server
    socket = WebSocketServer.new()
    status = socket.listen(config.get_value('startup', 'port'))

    # Register all events
    socket.connect('client_connected', self, 'on_connected')
    socket.connect('client_disconnected', self, 'on_disconnected')
    socket.connect('data_received', self, 'on_message')

    connections = {}

    print('LISTEN %s:%s %s' % ['localhost', config.get_value('startup', 'port'), status])

func _idle(delta):
    socket.poll()

# Events
func on_connected(id, protocol):
    connections[id] = { 'ready': false }

func on_disconnected(id, was_clean):
    connections.erase(id)

func on_message(id):
    print('herro')

# Methods
