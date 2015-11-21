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
        } else {
            instance_create(x, y, Inventory.slot[array_length_1d(Inventory.slot)-1]);
            Inventory.slot[array_length_1d(Inventory.slot)-1] = object_index;
            instance_destroy();
        }
    }
} else if object_get_parent(object_index) = ItemUser {
    if item != noone and instance_exists(Inventory) {
        var i;
        for (i = 0; i < Inventory.slots; i += 1) {
            if Inventory.slot[i] = item {
                Inventory.slot[i] = noone;
                //Codes for resulting actions go here (i.e. what object does when given item)
                if object_index = MissingBeam {
                    beam = instance_create(x, y, BridgeBeam);
                    beam.image_angle = image_angle;
                    beam.image_xscale = image_xscale;
                    beam.image_yscale = image_yscale;
                    instance_destroy();
                } else if object_index = MissingAngleBeam {
                    beam = instance_create(x, y, AngledBeam);
                    beam.image_angle = image_angle;
                    beam.image_xscale = image_xscale;
                    beam.image_yscale = image_yscale;
                    instance_destroy();
                }
                break;
            }
        }
        if i = Inventory.slots {
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
        Player.paused = true;
    }
} else if object_index = GearBox{
    if sprite_index != sFairing {
        sprite_index = sFairing;
    } else {
        //set Gearbox UI to active
    }
} else if object_index = UpStaircase or (object_index = InactiveStairsUp and active = true) {
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
} else if object_index = TestButton {
    var wrongSteps = 0;
    var rightSpots = 0;
    var noneEmpty = true;
    if Slot1.operation = steps[0] {
        rightSpots += 1;
    } else {
        if not(Slot1.operation = noone) {
            for (var i = 0; i < array_length_1d(otherSteps); i += 1) {
                if otherSteps[i] = Slot1.operation {
                    wrongSteps += 1;
                    break;
                }
            }
        } else {
            noneEmpty = false;
        }
    }
    if Slot2.operation = steps[1] {
        rightSpots += 1;
    } else {
        if not(Slot2.operation = noone) {
            for (var i = 0; i < array_length_1d(otherSteps); i += 1) {
                if otherSteps[i] = Slot2.operation {
                    wrongSteps += 1;
                    break;
                }
            }
        } else {
            noneEmpty = false;
        }
    }
    if Slot3.operation = steps[2] {
       rightSpots += 1;
    } else {
        if not(Slot3.operation = noone) {
            for (var i = 0; i < array_length_1d(otherSteps); i += 1) {
                if otherSteps[i] = Slot3.operation {
                    wrongSteps += 1;
                    break;
                }
            }
        } else {
            noneEmpty = false;
        }
    }
    if rightSpots != 3 and noneEmpty{
        if wrongSteps != 0 {
            dialog = string(wrongSteps);
        } else {
            dialog = "None";
        }
        dialog += " of those steps ";
        if wrongSteps = 1 {
            dialog += "is";
        } else {
            dialog += "are";
        }
        dialog += " unnecessary, "
        if rightSpots != 0 {
            dialog += "but " + string(rightSpots);
        } else {
            if wrongSteps != 0 {
                dialog += "and none";
            } else {
                dialog += "but none";
            }
        }
        dialog += " of them ";
        if rightSpots = 1 {
            dialog += "is";
        } else {
            dialog += "are";
        }
        dialog += " in the right spot.";
        makeDialog(dialog);
    } else {
        if noneEmpty {
            makeDialog("Yes! I think that will work marvelously!");
        } else {
            makeDialog("You need to add more steps.");
        }
    }
} else if object_get_parent(object_index) = Slot {
    var temp = Inventory.slot[0];
    Inventory.slot[0] = operation;
    operation = temp;
} else if object_index = BrokenWires {
    instance_create(x, y, FixedWires);
    var wires = instance_number(BrokenWires);
    if wires = 1 {
        stairs = instance_find(InactiveStairsUp, 0);
        stairs.active = true;
    }
    instance_destroy();
} else if object_index = InfoSign {
    dialog = makeDialog(info);
} else if object_index = Mainframe {
    Player.paused = true;
    instance_create(x, y, TerminalScreen);
}

if object_index = Blueprint {
instance_destroy();
}
