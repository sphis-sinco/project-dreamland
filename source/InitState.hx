class InitState extends FlxState
{
	override function create()
	{
		super.create();

		Save.initalize();
		#if polymod
		modding.PolymodHandler.loadMods();
		#end

		#if (discord_rpc && !hl)
		Discord.initialize();
		#end

		if (Save.getSavedataInfo(firsttime))
			Save.setSavedataInfo(firsttime, false);
		else if (Save.getSavedataInfo(firsttime) == null)
			Save.setSavedataInfo(firsttime, true);

		var needUpdate = false;
		needUpdate = CheckOutdated.call();

		Global.HIGHSCORE = Save.getSavedataInfo(highscore);

		FlxG.switchState((needUpdate) ? OutdatedState.new : Splash.new);
	}
}
