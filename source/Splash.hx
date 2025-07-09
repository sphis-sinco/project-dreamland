package;

class Splash extends FlxState
{
	public var hi:FlxText;
	public var chilling:FlxSprite;

	override function create()
	{
		super.create();

		hi = initMessage();
		add(hi);

		chilling = initDoodle();
		add(chilling);

		FlxTimer.wait(1, () ->
		{
			FlxG.switchState(MenuState.new);
		});
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	public function initMessage()
	{
		var newText:FlxText = new FlxText(0, 0, 0, "Thank you\nfor playing Dreamland!", 32);
		newText.alignment = CENTER;
		newText.screenCenter();
		newText.y = 32;

		return newText;
	}

	public function initDoodle()
	{
		var doodle:FlxSprite = new FlxSprite(0, 0);
		doodle.frames = FileManager.getSparrowAtlas('splash/player');
		doodle.animation.addByPrefix('chill', 'Player chill', 24);
		doodle.animation.play('chill');
		doodle.scale.set(0.5, 0.5);
		doodle.screenCenter();
		add(doodle);

		return doodle;
	}
}
