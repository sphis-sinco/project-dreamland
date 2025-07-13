package;

import flixel.FlxGame;
import lime.utils.Log;
import openfl.display.Sprite;

using StringTools;

class Main extends Sprite
{
	public static var oldTrace = haxe.Log.trace; // store old function

	public function new()
	{
		super();

		haxe.Log.trace = function(v:Dynamic, ?infos:PosInfos)
		{
			infos.className = 'source/' + infos.className.replace('.', '/') + '.hx:${infos.lineNumber}';

			Log.info(v, infos);
		}

		Application.current.window.title = 'Dreamland (${Application.current.meta.get('version')})';

		CheckOutdated.call();

		addChild(new FlxGame(0, 0, InitState, 60, 60, true));
	}
}
