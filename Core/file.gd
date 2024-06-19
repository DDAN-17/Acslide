extends FileDialog

# Called when the node enters the scene tree for the first time.
func init():
	connect("close_requested", close_window)

func close_window():
	queue_free()


func _on_file_selected(path):
	$"../".open_file(path)
	close_window()
