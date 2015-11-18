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
} else if object_get_parent(object_index) = ItemUser {
    if item != noone and instance_exists(Inventory) {
        var i;
        for (i = 0; i < Inventory.slots; i += 1) {
            if Inventory.slot[i] = item {
                slot[i] = noone;
                //Codes for resulting actions go here (i.e. what object does when given item)
                break;
            }
        }
        if i = inventory.slots {
            makeDialog("You don't have the necessary item");
        }
    }
} else if object_index = Engine {
    if sprite_index != sFairing {
        sprite_index = sFairing;
    } else {
        with (EngineUIManager) {
            active = true;
        }
    }
} else if object_index = GearBox{
    if sprite_index != sFairing {
        sprite_index = sFairing;
    } else {
        //set Gearbox UI to active
    }
} else if object_index = UpStaircase {
    with (Player) {
        y -= 352;
    }
} else if object_index = DownStaircase {
    with (Player) {
        y += 352;
    }
} else if object_get_parent(object_index) = BridgeBoxer {
    if instance_exists(Inventory) {
        //check if there's space
        var freeSpace = 0;
        var i;
        for (i = 0; i < Inventory.slots; i += 1) {
            if Inventory.slot[i] = noone {
                freeSpace += 1;
            }
        }
        if freeSpace >= array_length_1d(bridgeParts) {
            //add to the inventory
            var i;
            for (i = 0; i < array_length_1d(bridgeParts); i += 1) {
                var j;
                for (j = 0; j < Inventory.slots; j += 1) {
                    if Inventory.slot[j] = noone and bridgeParts[i] != noone {
                        Inventory.slot[j] = bridgeParts[i];
                        break;
                    }
                }
            }
        } else {
            makeDialog("Insufficient Space");
        }
    }
} else if object_index = LeverUp {
    with (Display) {
        number = number+5;
        if number > 100 {
            number = 0;
        }
    }
} else if object_index = LeverDown {
    with (Display) {
        number = number - 5;
        if number < 0 {
            number = 100;
        }
    }
} else if object_index = TestButton {
    if Display.number > Display.targetNumber {
        //what to do if you're too high
        makeDialog("Too High");
    } else if Display.number < Display.targetNumber {
        //what to do if you're too low
        makeDialog("Too Low");
    } else {
        //what to do if you're right
        makeDialog("Hooray!");
    }
}
