package;

import flixel.FlxGame;
import haxe.Json;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		Global.set_HIGHSCORE();
		super();
		addChild(new FlxGame(0, 0, MenuState));
	}
}
