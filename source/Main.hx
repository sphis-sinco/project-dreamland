package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		FileManager.makeFile('', 'hello world');

		super();
		addChild(new FlxGame(0, 0, MenuState));
	}
}
