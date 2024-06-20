extends Control

var files
# Called when the node enters the scene tree for the first time.
func _ready():
	files = $"Topmenu_Bottom/Top_Terminal/Sidebar_Files/Files"

func open_file(filePath):
	var fileData = FileAccess.open(filePath, FileAccess.READ_WRITE)
	var extention = filePath.split(".")
	extention = extention[extention.size() - 1]
	
	var file = Core.load_plugin("edit/" + extention + "Edit.tscn")
	if file is int:
		if file == 1:
			Core.warning("Extention " + extention + " not found; Using .txt as Fallback")
			file = Core.load_plugin("edit/txtEdit.tscn")
			file = file.instantiate()
	elif file is PackedScene:
		file = file.instantiate()
		
	file.name = filePath.split("/")[filePath.split("/").size() - 1]
	files.add_child(file)
	file.text = fileData.get_as_text()
	file.path = filePath
	file.connect("text_changed", _save_current)
	files.set_tab_title(files.get_tab_count() - 1, filePath.split("/")[filePath.split("/").size() - 1])

func _save_current():
	var fileEdit = files.get_child(files.get_current_tab())
	var fileData = FileAccess.open(fileEdit.path, FileAccess.WRITE)
	fileData.store_string(fileEdit.text)
	fileData.close()
	


func _on_file_index_pressed(index):
	match index:
		0:
			print("Open File Dialog")
			var fileDialog = load("res://Core/file.tscn").instantiate()
			fileDialog.init()
			add_child(fileDialog)
		1:
			print("Close Tab")
			files.get_child(files.get_current_tab()).queue_free()
		2:
			if files.get_tab_count() != 0:
				var path = files.get_child(files.get_current_tab()).path
				var extention = path.split(".")[path.split(".").size() - 1]
				var buildClass = Core.load_plugin("build/" + extention + "Build.gd")
				if buildClass is Script:
					buildClass.new(path).run()
				else:
					Core.alert("Unconfigured Run", "There are no runs configured for the extention ." + extention)
			else:
				Core.terminal_print("Cannot run an empty file.")
		3:
			var currentPath = OS.get_system_dir(OS.SYSTEM_DIR_DOCUMENTS) + "/text0"
			var iterate = 0
			while (FileAccess.file_exists(currentPath + ".txt")):
				currentPath = currentPath.rstrip(String.num(iterate)) + String.num(iterate + 1)
				iterate += 1
			FileAccess.open(currentPath + ".txt", FileAccess.WRITE)
			open_file(currentPath + ".txt")
