package;

import flixel.FlxG;
import flixel.FlxGame;
import haxe.Json;
import lime.app.Application;
import openfl.display.Sprite;

class Main extends Sprite
{
	public function new()
	{
		FlxG.save.bind('dreamland', Application.current.meta.get('company'));
		super();
		addChild(new FlxGame(0, 0, (FlxG.save.data.version != Application.current.meta.get('version')) ? OutdatedState : MenuState));
	}
}
