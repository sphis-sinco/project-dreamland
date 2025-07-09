package splashes;

class Splash extends FlxState
{
	override function create()
	{
		super.create();

		var hi:FlxText = new FlxText(0, 0, 0, "Thank you\nfor playing Dreamland!", 32);
		hi.alignment = CENTER;
		hi.screenCenter();
		hi.y = 32;
		add(hi);

		var chilling:FlxSprite = new FlxSprite(0, 0);
		chilling.frames = FileManager.getSparrowAtlas('splash/player');
		chilling.animation.addByPrefix('chill', 'Player chill', 24);
		chilling.animation.play('chill');
		chilling.scale.set(0.5, 0.5);
		chilling.screenCenter();
		add(chilling);

		FlxTimer.wait(1, () ->
		{
			if (!Save.getSavedataInfo(legacyUser) && Save.getSavedataInfo(legacyHighScore) != null)
			{
				FlxG.switchState(SeperateHighscores.new);
				return;
			}

			FlxG.switchState(MenuState.new);
		});
	}
}
