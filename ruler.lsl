float TIMER_INTERVAL = 0.5;
vector last_position;

vector get_size()
{
	list params = llGetLinkPrimitiveParams(0, [PRIM_SIZE]);
	vector size = llList2Vector(params, 0);
	return size;
}

vector size;
vector position;
vector corner1;
vector corner2;
calculate()
{
	size = get_size();
	position = llGetPos();

    corner1 = <position.x - size.x/2, position.y - size.y/2, position.z - size.z/2>;
    corner2 = <position.x + size.x/2, position.y + size.y/2, position.z + size.z/2>;
}

// This makes it easier to copy/paste values,
// rather than copying them manually by hand.
spew_to_local()
{
		llOwnerSay("Size: " + (string)size);
		llOwnerSay("X: " + (string)(corner1.x) + " to " + (string)(corner2.x));
		llOwnerSay("Y: " + (string)(corner1.y) + " to " + (string)(corner2.y));
		llOwnerSay("Z: " + (string)(corner1.z) + " to " + (string)(corner2.z));
		llOwnerSay(" \n");
		llOwnerSay("Corners: " + string(corner1) + " to " + string(corner2));
}

update_text()
{
	string text = "Size: " + (string)size + "\n" +
		"X: " + (string)(corner1.x) + " to " + (string)(corner2.x) + "\n" +
		"Y: " + (string)(corner1.y) + " to " + (string)(corner2.y) + "\n" +
		"Z: " + (string)(corner1.z) + " to " + (string)(corner2.z);

	llSetText(text, <0, 1, 0>, 1);
}

default
{
	changed(integer change)
	{
        calculate();
		update_text();
	}

	state_entry()
	{
		llSetTimerEvent(TIMER_INTERVAL);
        calculate();
		update_text();
	}

	timer()
	{
        calculate();
		if(position == last_position) return;

		last_position = position;
		update_text();
	}

	touch_start(integer total_number)
	{
        calculate();
		spew_to_local();
	}
}
