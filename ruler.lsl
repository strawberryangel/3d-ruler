float TIMER_INTERVAL = 2.0;
vector last_position;

vector get_size()
{
	list params = llGetLinkPrimitiveParams(0, [PRIM_SIZE]);
	vector size = llList2Vector(params, 0);
	return size;
}

// This makes it easier to copy/paste values, 
// rather than copying them manually by hand.
spew_to_local()
{
		vector size = get_size();
		vector position = llGetPos();
		llOwnerSay("Size: " + (string)size);
		llOwnerSay("X: " + (string)(position.x - size.x/2) + " to " + (string)(position.x + size.x/2));
		llOwnerSay("Y: " + (string)(position.y - size.y/2) + " to " + (string)(position.y + size.y/2));
		llOwnerSay("Z: " + (string)(position.z - size.z/2) + " to " + (string)(position.z + size.z/2));
}

update_text()
{
	vector size = get_size();
	vector position = llGetPos();
	string text = "Size: " + (string)size + "\n" +
		"X: " + (string)(position.x - size.x/2) + " to " + (string)(position.x + size.x/2) + "\n" +
		"Y: " + (string)(position.y - size.y/2) + " to " + (string)(position.y + size.y/2) + "\n" +
		"Z: " + (string)(position.z - size.z/2) + " to " + (string)(position.z + size.z/2);

	llSetText(text, <0, 1, 0>, 1);
}

default
{
	changed(integer change)
	{
		update_text();
	}

	state_entry()
	{
		llSetTimerEvent(TIMER_INTERVAL);
		update_text();
	}
	
	timer()
	{
		vector position = llGetPos();
		if(position == last_position) return;
		
		last_position = position;
		update_text();
	}

	touch_start(integer total_number)
	{
		spew_to_local();
	}
}
