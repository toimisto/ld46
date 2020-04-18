extends Node2D
export (PackedScene) var PathBlock


var level

# Called when the node enters the scene tree for the first time.
func _ready():
    open_level(1)
    pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass



func open_level(lvl):
    var level_resource = load("res://scenes/TowerDefence/Level" + str(lvl).pad_zeros(3) + ".tscn")
    level = level_resource.instance()
    add_child(level)
    var path = level.get_node("MobPath")
    var level_length = path.get_curve().get_baked_length()
    for i in range(level_length):
        print(i)
