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

		if (CheckOutdated.updateNeeded)
		{
			trace('GO TO OUTDATED');
			FlxG.switchState(OutdatedState.new);
		}
		else
		{
			#if (html5)
			FlxG.switchState(OutdatedState.new);
			#else
			FlxG.switchState(Splash.new);
			#end
		}
	}
}
