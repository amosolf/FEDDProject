if object_index = Button {
    instance_create(x, y, Firework);
} else if object_index = MattGlass and MattGlass.KOed = true {
    if Inventory.slot[0] = MedKit {
        KOed = false;
        Inventory.slot[0] = noone;
        y -= 8;
        defx = 1248;
        dialog = makeDialog("Thanks for the help. Come with me to talk to Steve, the Chemical Engineer.");
    } else {
        dialog = makeDialog("Ugh. Go get help. From the doctor.");
        dialog.shouldDestroy = false;
    }
} else if object_get_parent(object_index) = NPC {
    if instance_exists(dialog) {
        for (var i=0; i < array_length_1d(text); i += 1) {
            if dialog.text = text[i] {
                if (i != array_length_1d(text)-1) {
                    if i != array_length_1d(text)-2 or not(cleared) {
                        dialog = makeDialog(text[i+1]);
                        dialog.shouldDestroy = false;
                    }
                } else {
                    if myRoom != noone {
                        room_goto(myRoom);
                    } else if item != noone {
                        Inventory.slot[0] = item;
                        with(dialog) {
                            instance_destroy();
                        }
                    }
                }
                break;
            }
        }
    } else {
        dialog = makeDialog(text[0]);
        dialog.shouldDestroy = false;
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
                    beam.depth = depth;
                    instance_destroy();
                } else if object_index = MissingAngleBeam {
                    beam = instance_create(x, y, AngledBeam);
                    beam.image_angle = image_angle;
                    beam.image_xscale = image_xscale;
                    beam.image_yscale = image_yscale;
                    beam.depth = depth;
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
            textBox = makeDialog("Yes! I think that will work marvelously!");
            global.matCleared = true;
            textBox.isEnding = true;
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
} else if object_index = Blueprint {
    instance_destroy();
} else if object_index = LeverUpHeat {
    Furnace.heat += 5;
    if Furnace.heat > 300 {
        Furnace.heat = 200;
    }
} else if object_index = LeverDownHeat {
    Furnace.heat -= 5;
    if Furnace.heat < 200 {
        Furnace.heat = 300;
    }
} else if object_index = LeverUpPress {
    Furnace.pressure += 1;
    if Furnace.pressure > 10 {
        Furnace.pressure = 0;
    }
} else if object_index = LeverDownPress {
    Furnace.pressure -= 1;
    if Furnace.pressure < 0 {
        Furnace.pressure = 10;
    }
} else if object_index = TestButtonChem {
    var correct = 0;
    var tooHigh = 0;
    var tooLow = 0;
    
    if Furnace.heat = Furnace.targetHeat {
        correct += 1;
    } else if Furnace.heat < Furnace.targetHeat {
        tooLow += 1;    
    } else {
        tooHigh += 1;
    }
    if Furnace.pressure = Furnace.targetPressure {
        correct += 1;
    } else if Furnace.pressure < Furnace.targetPressure {
        tooLow += 1;
    } else {
        tooHigh += 1;
    }
    
    if correct != 2 {
        text = "";
        if tooHigh = 2 {
            text = "Both of those are too high.";
        } else if tooLow = 2 {
            text = "Both of those are too low.";
        } else if tooHigh = 1 {
            text = "One of those is too high, and the other is ";
            if tooLow = 1 {
                text += "too low.";
            } else {
                text += "just right.";
            }
        } else {
            text = "One of those is too low, and the other is just right";
        }
        makeDialog(text);
    } else {
        dialog = makeDialog("Great job that should make great nylon!");
        global.chemCleared = true;
        dialog.isEnding = true;
    }
} else if object_index = LightSwitch {
    for (var i = 0; i < array_length_1d(doors); i += 1) {
        instance_activate_object(doors[i]);
    }
    JaneBlond.dying = false;
    JaneBlond.y -= 8;
    MattGlass.dying = false;
    BridgeBridgington.dying = false;
    BridgeBridgington.y -= 8;
    SteveNylon.dying = false;
    SteveNylon.y -= 8;
    MayCanical.dying = false;
    MayCanical.y -= 8;
    MayCanical.defx = 805;
    PerryWinkle.dying = false;
    PerryWinkle.y -= 8;
    instance_deactivate_object(Darkness);
    textBox = makeDialog("Alright, come to my medlab, we need to get something for Matt");
    textBox.shouldDestroy = false;
}

