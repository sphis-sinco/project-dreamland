package;

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
		trace(player.getPosition());
		add(player);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
