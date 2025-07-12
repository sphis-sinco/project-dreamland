package gameplay;

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
		Discord.changePresence('Died.', 'Died.');
		#end

		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (Controls.UI_SELECT)
		{
			openSubState(new ResultsSubState());
		}

		super.update(elapsed);
	}
}
