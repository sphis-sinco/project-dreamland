package;

import flixel.FlxSprite;
import flixel.FlxState;

class PlayState extends FlxState
{
	var player:Player = new Player();

	override public function create()
	{
		player.screenCenter();
		add(player);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}

class Player extends FlxSprite
{
	override public function new(X:Float = 0, Y:Float = 0)
	{
		super(X,Y);
		makeGraphic(32,32, 0x00ff00);
	}
}
