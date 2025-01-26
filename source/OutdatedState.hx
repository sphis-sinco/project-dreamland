package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import lime.app.Application;

class OutdatedState extends FlxState
{
	override public function create()
	{
		var outdatedText:FlxText = new FlxText(0, 0, 0, "blah", 16);
		add(outdatedText);

		outdatedText.text = 'YOUR BUILD OF THE GAME (v${Application.current.meta.get('version')}) IS OUTDATED!\n'
			+ 'THE CURRENT PUBLIC RELEASE IS v${Main.updateVersion},\n AND IS AVAILIABLE FOR DOWNLOAD.\n\n'
			+ 'You can press ENTER to go to the github to update\n'
			+ 'or you can press BACKSPACE or ESCAPE to continue.';
		outdatedText.text = outdatedText.text.toUpperCase();
		outdatedText.alignment = CENTER;
		outdatedText.screenCenter();

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
			FlxG.switchState(new MenuState());
		}

		super.update(elapsed);
	}
}