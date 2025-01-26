package;

import flixel.FlxState;
import flixel.text.FlxText;

class MenuState extends FlxState
{
	var menuText:FlxText = new FlxText(0, 0, 0, "Main Menu", 16);
	var pressButton:FlxText = new FlxText(0, 0, 0, "Press enter to play", 16);

	override public function create()
	{
		add(menuText);
		add(pressButton);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}