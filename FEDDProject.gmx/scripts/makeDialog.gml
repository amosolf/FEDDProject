//Takes 1 argument: message

dbox = instance_create(0,400,DialogBox);
with(dbox)
{
    maxLength = view_wview[0];
    height = 100;
    padding = 16;
    font = fSmall;
    draw_set_font(font);
    text = argument0;
    
    font_size = font_get_size(font);
    textLength = string_length(text);
    textWidth = string_width_ext(text,font_size+(font_size/2),maxLength);
    textHeight = string_height_ext(text,font_size+(font_size/2),maxLength);
    
    boxWidth = textWidth + (padding*2);
    boxHeight = textHeight + (padding*2);    
}
