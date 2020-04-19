extends ColorRect

var mouse_button_pressed = false

func _ready():
    pass 

func _process(delta):
    if mouse_button_pressed:
        var m_pos = get_viewport().get_mouse_position()
        if m_pos.x <= get_position().x + get_size().x and m_pos.x >= get_position().x:
            if m_pos.y <= get_position().y + get_size().y and m_pos.y >= get_position().y:
                color = Color(1, 0, 0, 1) 

func _input(event):
    if event is InputEventMouseButton:
        if event.is_pressed():  # Mouse button down.
            mouse_button_pressed = true
        elif not event.is_pressed():  # Mouse button released.
            mouse_button_pressed = false
                
