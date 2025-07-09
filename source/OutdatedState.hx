package;

class OutdatedState extends FlxState
{
	override public function create()
	{
		var outdatedText:FlxText = new FlxText(0, 0, 0, "blah", 16);
		add(outdatedText);

		outdatedText.text = 'YOUR BUILD OF THE GAME (v${Global.APP_VERSION}) IS OUTDATED!\n'
			+ 'THE CURRENT PUBLIC RELEASE IS v${Main.updateVersion},\n AND IS AVAILIABLE FOR DOWNLOAD.\n\n'
			+ 'You can press ENTER to go to the github to update\n'
			+ 'or you can press BACKSPACE or ESCAPE to continue.';
		outdatedText.text = outdatedText.text.toUpperCase();
		outdatedText.alignment = CENTER;
		outdatedText.screenCenter();

		#if (discord_rpc && !hl)
		Discord.changePresence('Playing an outdated Version (v${Global.APP_VERSION})', 'Needs to update to v${Main.updateVersion}');
		#end

		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.justReleased.ENTER)
		{
			FlxG.openURL('https://github.com/sphis-Sinco/project-dreamland/releases/latest');
			#if sys
			Sys.exit(0);
			#end
		}
		else if (FlxG.keys.justReleased.BACKSPACE || FlxG.keys.justReleased.ESCAPE)
		{
			FlxG.switchState(MenuState.new);
		}

		super.update(elapsed);
	}
}