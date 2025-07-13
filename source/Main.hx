package;

import flixel.FlxGame;
import openfl.display.Sprite;

using StringTools;

class Main extends Sprite
{
	public function new()
	{
		super();

		Application.current.window.title = 'Dreamland (${Application.current.meta.get('version')})';

		CheckOutdated.call();

		addChild(new FlxGame(0, 0, InitState, 60, 60, true));
	}
}
