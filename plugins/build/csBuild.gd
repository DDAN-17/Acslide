extends RefCounted

var path = ""

func _init(path:String):
	self.path = path

func compile(path:String):
	if path == "":
		Core.error("Compile failed, Empty path")
		return ERR_INVALID_PARAMETER
	if not FileAccess.file_exists(path):
		Core.error("Compile failed, File not found at path " + path)
		return ERR_FILE_NOT_FOUND
	var output = []
	var errorCode = OS.execute(Settings.get_setting("monoBinPath") + "/csc" + Settings.get_setting("binExtention"), [path], output)
	if errorCode != 0:
		Core.error("Error while compiling " + path + ", error code " + String.num(errorCode))
		return ERR_COMPILATION_FAILED

	print("Output of Visual C#: \n\n" + output[0])
	return OK

func run(path:String = self.path):
	var errorCode = compile(path)
	if errorCode == 0:
		errorCode = runCompiled(path)
	return errorCode

func runCompiled(path:String):
	if path == "":
		Core.error("Run failed, Empty path")
		return ERR_INVALID_PARAMETER
	path = path.split(".")[path.split(".").size() - 2]
	if not FileAccess.file_exists(path + ".exe"):
		Core.error("Run failed, File not found")
		return ERR_FILE_NOT_FOUND
	var output = []
	var errorCode = OS.execute(Settings.get_setting("monoBinPath") + "/mono" + Settings.get_setting("binExtention"), [path + ".exe"], output)
	if errorCode != 0:
		Core.error("Error while running " + path + ".exe" + ", error code " + String.num(errorCode))
		return FAILED
	print("Output of Mono: \n\n")
	Core.terminal_print(output[0])
	return OK
