extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	print("hi")
	OS.execute("csc", ["test.cs"])
	OS.execute("mono", ["test.exe"])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
