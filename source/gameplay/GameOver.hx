package gameplay;

class GameOver extends FlxState
{
	public var interact:MobileButton = new MobileButton(A_BUTTON);

	override public function create()
	{
		interact.x = FlxG.width - interact.width * (MobileButton.scaleVal);

		var diedtext:FlxText = new FlxText(0, 0, 0, "You died.", 16);

		Global.set_HIGHSCORE();
		if (Global.NEW_HIGHSCORE)
			diedtext.text += "\n\nbut you got a highscore so it's all good";

		diedtext.alignment = CENTER;
		diedtext.screenCenter();
		add(diedtext);

		#if DISCORDRPC
		Discord.changePresence('Died.', 'Died.');
		#end

		super.create();

		#if MOBILE_BUILD
		add(interact);
		#end
	}

	override public function update(elapsed:Float)
	{
		if (Controls.UI_SELECT || interact.justReleased)
		{
			interact.destroy();

			openSubState(new ResultsSubState());
		}

		super.update(elapsed);
	}
}
