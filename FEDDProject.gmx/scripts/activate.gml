if object_index = Button {
    instance_create(x, y, Firework);
} else if object_get_parent(object_index) = NPC {
    if instance_exists(dialog) {
        for (var i=0; i < array_length_1d(text); i += 1) {
            if dialog.text = text[i] {
                if (i != array_length_1d(text)-1) {
                    dialog = makeDialog(text[i+1]);
                } else {
                    room_goto(myRoom);
                }
                break;
            }
        }
    } else {
        dialog = makeDialog(text[0]);
    }
} else if object_get_parent(object_index) = PickUp {
    if instance_exists(Inventory) {
        var i;
        for (i = 0; i < Inventory.slots; i += 1) {
            if Inventory.slot[i] = noone {
                Inventory.slot[i] = object_index;
                break;
            }
        }
        if i != Inventory.slots {
            instance_destroy();
        }
    }
}
