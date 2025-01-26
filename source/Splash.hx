package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxTimer;

class Splash extends FlxState
{
	override function create()
	{
		super.create();

		var hi:FlxText = new FlxText(0, 0, 0, "Thank you\nfor playing Dreamland!", 32);
		hi.alignment = CENTER;
		hi.screenCenter();
		add(hi);

		FlxTimer.wait(1, () ->
		{
			FlxG.switchState(new MenuState());
		});
	}
}