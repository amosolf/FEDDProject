switch argument0 {
    case "Button":
        instance_create(x, y, Firework);
        break;
    case "BioDoor":
        global.door = "BioDoor";
        if room_get_name(room) = "room0" {
            room_goto(bioRoom);
        } else {
            room_goto(room0);
        }
    default: break;
}
