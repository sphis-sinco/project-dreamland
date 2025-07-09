package splashes;

class SeperateHighscores extends FlxState
{
	override function create()
	{
		super.create();

		var message:FlxText = new FlxText(0, 0, 0,
			'Wait!\nImportant information...\n\nInstead of there just being one high score,' +
			'\nyour high scores are split off for each different level\n\nIf you had like a REALLY high score...\nsorry.',
			16);
		message.alignment = CENTER;
		message.screenCenter();
		add(message);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justReleased.ANY)
		{
			FlxG.save.data.savedata.highscore = null;
			FlxG.switchState(MenuState.new);
		}
	}
}
