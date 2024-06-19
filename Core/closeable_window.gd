extends Window

var windowTitle
var message

# Called when the node enters the scene tree for the first time.
func init(windowTitle, message):
	connect("close_requested", close_window)
	name = windowTitle
	self.windowTitle = windowTitle
	self.message = message

func ready():
	title = windowTitle
	$"Message".text = message

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func close_window():
	queue_free()


func _on_file_selected(path):
	print("Open File " + path)
	$"../".open_file(path)
