extends Node

var settings = {}

const settingsSkeleton = {
	monoBinPath = "",
	binExtention = ""
}

func _ready():
	$"/root".gui_embed_subwindows = false
	settings = settingsSkeleton.duplicate()
	match OS.get_name():
		"macOS":
			set_setting("monoBinPath", "/Library/Frameworks/Mono.framework/Commands")
			# Binary Extention is empty string
		"windows":
			set_setting("monoBinPath", "C:/Program Files/Mono/bin")
			set_setting("binExtention", ".exe")
		"linux":
			set_setting("monoBinPath", "/usr/local/mono/bin")
			# Binary extention is empty string
		_:
			Core.warning("Unsuported OS")
			Core.alert("Unsupported OS", "You are using an unsupported OS to run Acslide. Configuration options will not be automaticly set.")
	
	if (not DirAccess.dir_exists_absolute(get_setting("monoBinPath"))) and get_setting("monoBinPath") != "":
		Core.alert("Mono SDK Not Found", "Acslide requires Mono SDK to run. Please configure the location of Mono SDK binaries in settings.")
		Core.warning("Unknown Mono installation path " + get_setting("monoBinPath"))

func get_setting(path:StringName):
	return settings[path]

func set_setting(path:StringName, value):
	settings[path] = value
