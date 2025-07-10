package;

import flixel.FlxGame;
import modding.scripts.events.CheckOutdated;
import openfl.display.Sprite;
import polymod.Polymod;

using StringTools;

class Main extends Sprite
{
	public static var updateVersion:String;

	public function new()
	{
		Save.initalize();
		#if polymod
		modding.PolymodHandler.loadMods();
		#end

		super();
		#if (discord_rpc && !hl)
		Discord.initialize();
		#end

		if (Save.getSavedataInfo(firsttime))
			Save.setSavedataInfo(firsttime, false);
		else if (Save.getSavedataInfo(firsttime) == null)
			Save.setSavedataInfo(firsttime, true);

		var needUpdate = false;
		needUpdate = CheckOutdated.call();

		addChild(new FlxGame(0, 0, (needUpdate) ? OutdatedState : Splash, 60, 60, true));
	}
}
