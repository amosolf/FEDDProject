//Takes 1 argument: message

dbox = instance_create(0,100,DialogBox);
with(dbox)
{
    width = view_wview[0];
    height = 100;
    padding = 10;
    font = fSmall;
    message = argument0;
    messageLength = string_length(message);
    messageWidth = string_width_ext(message,16,width);
    messageHeight = string_height_ext(message,16,width);
    
    boxWidth = messageWidth + (padding*2);
    boxHeight = messageHeight + (padding*2);    
}
