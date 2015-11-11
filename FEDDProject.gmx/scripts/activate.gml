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
    case "CompSciNPC":
        makeDialog("Hi! I'm a computer scientist.");
        break;
    case "ChemNPC":
        makeDialog("Hi! I'm a chemical engineer.");
        break;
    case "BioNPC":
        makeDialog("Hi! I'm a biomedical engineer.");
        break;
    case "MechNPC":
        makeDialog("Hi! I'm a mechanical engineer.");
        break;
    case "MaterialNPC":
        makeDialog("Hi! I'm a material engineer.");
        break;
    case "CivilNPC":
        makeDialog("Hi! I'm a civil engineer.");
        break;
    default: break;
}
