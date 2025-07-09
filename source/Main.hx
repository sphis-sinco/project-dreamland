package;

import flixel.FlxGame;
import openfl.display.Sprite;

using StringTools;

class Main extends Sprite
{
	public static var updateVersion:String;

	public function new()
	{
		Save.initalize();
		var needUpdate = false;
		#if !hl
		trace('checking for update');
		var http = new haxe.Http("https://raw.githubusercontent.com/sphis-Sinco/project-dreamland/refs/heads/master/version.txt");

		http.onData = function(data:String)
		{
			updateVersion = data.split('\n')[0].trim();
			var curVersion:String = Global.APP_VERSION.trim();
			trace('version online: ' + updateVersion + ', your version: ' + curVersion);
			if (updateVersion != curVersion)
			{
				trace('versions arent matching!');
				needUpdate = true;
			}
		}

		http.onError = function(error)
		{
			trace('error: $error');
		}

		http.request();
		#end

		super();
		#if (discord_rpc && !hl)
		Discord.initialize();
		#end

		if (Save.getSavedataInfo(firsttime))
			Save.setSavedataInfo(firsttime, false);
		else if (Save.getSavedataInfo(firsttime) == null)
			Save.setSavedataInfo(firsttime, true);

		addChild(new FlxGame(0, 0, (needUpdate) ? OutdatedState : splashes.Splash, 60, 60, true));
	}
}
