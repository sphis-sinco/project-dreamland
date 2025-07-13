import menus.editors.LevelEditorMenu;

class InitState extends FlxState
{
	override function create()
	{
		super.create();

		Application.current.onExit.add(function(exitCode)
		{
			Global.set_HIGHSCORE();
			Save.setSavedataInfo(highscore, Global.HIGHSCORE);
			Save.flushData();
		}, false, 1000);

		Save.initalize();
		#if polymod
		modding.PolymodHandler.loadMods();
		#end

		#if DISCORDRPC
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
			var starting_state = haxe.macro.Compiler.getDefine('STARTING_STATE');
			trace(starting_state);

			switch (starting_state)
			{
				case 'LEVELEDITOR':
					FlxG.switchState(LevelEditorMenu.new);
				case null, '1':
					#if (html5)
					FlxG.switchState(OutdatedState.new);
					#else
					FlxG.switchState(Splash.new);
					#end
			}
		}
	}
}
