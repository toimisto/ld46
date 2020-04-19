
extends Node2D
export(PackedScene) var Block
export(PackedScene) var Spike
export(PackedScene) var Bottom
export(PackedScene) var Gold
var lvlrng = RandomNumberGenerator.new()
var lvlseed

signal init_level

    
func _ready():
    lvlrng.randomize()
    lvlseed = lvlrng.randi()
    emit_signal("init_level")


func generate_level(x):
    while x > ($Landscape.col - 600) * 40:
        $Landscape.create_col(1)
    
    while x < ($Landscapeleft.col + 600) * 40:
        $Landscapeleft.create_col(-1)
    
func add_tile(x,y,type):
    var tile
    match type:
        "block": 
            tile = Block.instance()
        "spike": 
            tile = Spike.instance()
        "gold": 
            tile = Gold.instance()
        "bottom": 
            tile = Bottom.instance()
        _:
            return
    tile.position.y = y
    tile.position.x = x
    add_child(tile)


func get_next(sumofweights, choices, rnf):
    var next = 0
    var sw = sumofweights * rnf
    for c in choices.keys():
        sw -= float(choices[c])
        if sw <= 0:
            next = c
            break
    return next
