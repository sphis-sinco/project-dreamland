package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import lime.app.Application;

class GameOver extends FlxState
{
	override public function create()
	{
		var diedtext:FlxText = new FlxText(0, 0, 0, "You died.", 16);

		Global.set_HIGHSCORE();
		if (Global.NEW_HIGHSCORE)
			diedtext.text += "\n\nbut you got a highscore so it's all good";

		diedtext.alignment = CENTER;
		diedtext.screenCenter();
		add(diedtext);

		#if (discord_rpc && !hl)
		Discord.DiscordClient.changePresence('Died.', 'Died.');
		#end

		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.justReleased.ENTER)
		{
			FlxG.switchState(new MenuState());
		}

		super.update(elapsed);
	}
}