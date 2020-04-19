extends Node

var lvlrng = RandomNumberGenerator.new()

var col = 3
var row = 10
var rowchange = 0
var current_col = []
var jumplace
var choices = {
    "b": 10,
    "s": 5,
    " ": 3,
    "g": 0.2,
    "up": 2,
    "down": 2,
    "skip": 0
    }
var choices2 = {
    "b": 10,
    "s": 5,
    " ": 3,
    "g": 0.3,
    "up": 1,
    "down": 2,
    "skip": 0
    }
const jumpables = ["b"]
const nonjump = ["bu", " ", "g"]
var sumofweights = 0.0



func _ready():
    for weight in choices.values():
        sumofweights += weight

func make_jump(y=0):
    var h = (lvlrng.randi()%4) +1.0
    var w = (lvlrng.randi()%int(h)) +1.0
    jumplace = {
            "x": col,
            "y": -(row-y),
            "h": h,
            "w": w
            }

func create_col(dir):
    

    if col == 3:
        make_jump()
    get_parent().add_tile(col*40, row*40, "block")
    get_parent().add_tile(col*40, (row+1)*40, "bottom")
    current_col = ["b"]
    create_tile()
    col += dir


func create_tile(h=1):
    var next = get_parent().get_next(sumofweights, choices, lvlrng.randf())
    var difx = col - jumplace["x"]
    var dify = -(row-h) - jumplace["y"]
    var jump = -((float(jumplace["h"])/jumplace["w"])/jumplace["w"])*pow(difx - jumplace["w"], 2) +jumplace["h"]
    var jumpnext = -((float(jumplace["h"])/jumplace["w"])/jumplace["w"])*pow(difx - jumplace["w"]+1, 2) +jumplace["h"]
    match next:
        "b":
            if dify+1.5 < jump:
                get_parent().add_tile(col*40, (row-h)*40, "block")
                current_col.push_back("b")
                create_tile(h+1)
            elif dify-1.8 > jump and dify-1.8 > jumpnext and difx < jumplace["w"]*2 -1:
                get_parent().add_tile(col*40, (row-h)*40, "block")
                current_col.push_back("bu")
                create_tile(h+1)
            else:
                current_col.push_back(" ")
                create_tile(h+1)
        "s":
            if current_col[-1] == "b" and ((dify+0.8 < jump and difx < jumplace["w"]*2) or dify+2 < jump):
                get_parent().add_tile(col*40, (row-h)*40, "spike")
                current_col.push_back("s")
                current_col.push_back(" ")
                create_tile(h+2)
            elif current_col[-1] == "bu":
                get_parent().add_tile(col*40, (row-h)*40, "spike")
        " ":
            current_col.push_back(" ")
            create_tile(h+1)
        "g":
            get_parent().add_tile(col*40, (row-h)*40, "gold")
            current_col.push_back("g")
            create_tile(h+1)
        "up":
            if dify+0.8 < jump:
                rowchange = -1
        "down":
            rowchange = 1
        "skip":
            pass
            
    if h == 1:
        while current_col[-1] in nonjump:
            current_col.pop_back()        
        
        if difx >= jumplace["w"]*2 and current_col[-1] in jumpables:
           make_jump(current_col.size())
        elif lvlrng.randi()%10 == 0 and current_col[-1] in jumpables:
           make_jump(current_col.size())
        row += rowchange
        rowchange = 0
        


func _on_LevelGenerator_init_level():
    lvlrng.seed = get_parent().lvlseed
