package;

import flixel.FlxGame;
import haxe.Json;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, MenuState));
		Global.set_HIGHSCORE();
		PlayState.SCORE = Json.parse(FileManager.readFile(FileManager.getPath('highscore.json'))).highscore;
	}
}
