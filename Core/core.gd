extends Object
class_name Core

func compile(path:String):
	OS.execute("csc", [path])
