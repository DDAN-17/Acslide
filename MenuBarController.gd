extends MenuBar

var fileItems = {
	"Open File" = [KEY_O, true],
	"Close File" = [KEY_W, true],
	"Run File" = [KEY_R, true],
	"New File" = [KEY_N, true]
}

# Called when the node enters the scene tree for the first time.
func _ready():
	var iterate = 0
	for i in fileItems.keys():
		$"File".add_item(i)
		$"File".set_item_shortcut(iterate, Core.create_shortcut(fileItems[i][0], fileItems[i][1]))
		iterate += 1


func _on_file_index_pressed(index):
	print(index)
