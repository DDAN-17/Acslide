extends Node

@onready var terminal = $"../Main/Topmenu_Bottom/Top_Terminal/Terminal/ScrollContainer/Label"

func _init():
	CS_Build.ready()
	TXT_Build.ready()
	
	print(DirAccess.get_files_at("res://plugins/edit"))
	print(DirAccess.get_directories_at("res://"))
	if not DirAccess.dir_exists_absolute("user://plugins"):
		DirAccess.open("user://").make_dir("plugins")

func error(string:String):
	push_error(string)

func warning(string:String):
	push_warning(string)

func alert(title:String, message:String):
	var popup = load("res://Core/closeable_popup.tscn").instantiate()
	popup.init(title, message)
	$"../Main".add_child(popup)
	popup.ready()

func terminal_print(string:String):
	print(string)
	terminal.text = terminal.text + "\n" + string

func load_plugin(pluginName):
	if FileAccess.file_exists("user://plugins/" + pluginName):
		return load("user://plugins/" + pluginName)
	elif FileAccess.file_exists("res://plugins/" + pluginName) or FileAccess.file_exists("res://plugins/" + pluginName + ".remap"):
		return load("res://plugins/" + pluginName)
	else:
		return FAILED

func create_shortcut(action, commandOrControl):
	var shortcut = Shortcut.new()
	var inputKey = InputEventKey.new()
	inputKey.command_or_control_autoremap = commandOrControl
	inputKey.keycode = action
	shortcut.events.append(inputKey)
	return shortcut
