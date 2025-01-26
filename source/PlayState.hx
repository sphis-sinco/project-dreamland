package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.util.FlxColor;

class PlayState extends FlxState
{
	var player:FlxSprite = new FlxSprite();

	override public function create()
	{
		player.makeGraphic(32,32, FlxColor.LIME); 
		player.screenCenter();
		add(player);

		super.create();
	}

	var key_up:Bool;
	var key_down:Bool;
	var key_shoot:Bool;

	override public function update(elapsed:Float)
	{
		key_up = FlxG.keys.justReleased.UP;
		key_down = FlxG.keys.justReleased.DOWN;
		key_shoot = FlxG.keys.justReleased.SPACE;

		if (key_up)
			player.y -= 10;
		if (key_down)
			player.y += 10;

		super.update(elapsed);
	}
}
