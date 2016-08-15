vector get_size()
{
	list params = llGetLinkPrimitiveParams(0, [PRIM_SIZE]);
	vector size = llList2Vector(params, 0);
	return size;
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
		update_text();
	}

	touch_start(integer total_number)
	{
		vector size = get_size();
		vector position = llGetPos();
		llSay(PUBLIC_CHANNEL, "Size: " + (string)size);
		llSay(PUBLIC_CHANNEL, "X: " + (string)(position.x - size.x/2) + " to " + (string)(position.x + size.x/2));
		llSay(PUBLIC_CHANNEL, "Y: " + (string)(position.y - size.y/2) + " to " + (string)(position.y + size.y/2));
		llSay(PUBLIC_CHANNEL, "Z: " + (string)(position.z - size.z/2) + " to " + (string)(position.z + size.z/2));
	}
}
