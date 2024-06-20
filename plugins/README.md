
# Plugins

Acslide Plugins extend the functionality of Acslide.

## Edit Plugins

Acslide Edit Plugins are in the form of a Godot scene and must have a CodeEdit node as the root and must have an exported string variable called path. This CodeEdit node is where users will edit code for the language. To name the scene file, name it <extention>Edit.tscn.

## Build Plugins

Acslide Build Plugins allow users to run code. They are in the form of a GDScript file and must extend the RefCounted class, and have a non-static function called run() that takes an optional path to a program and runs the program. In the constructor of the object, it must take a string to use as the path if one is not given when calling run().

## Output

To output to the Acslide terminal, use the method Core.terminal_print(output).
