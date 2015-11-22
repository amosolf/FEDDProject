//Takes 1 argument: message
if(instance_exists(DialogBox))
{
    with(DialogBox)
        instance_destroy();
}
dbox = instance_create(0,400,DialogBox);
with(dbox)
{
    height = 100;
    padding = 16;
    maxLength = window_get_width()-2-padding*2;
    font = fDialog;
    draw_set_font(font);
    text = argument0;
    
    font_size = font_get_size(font);
    textLength = string_length(text);
    textWidth = string_width_ext(text,font_size+(font_size/2),maxLength);
    textHeight = string_height_ext(text,font_size+(font_size/2),maxLength);
    
    boxWidth = textWidth + (padding*3);
    boxHeight = textHeight + (padding*3);
    
    alarm[0] = string_length(text)*2 + 50
}

return dbox;
