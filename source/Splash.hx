package;

import modding.HScript;
import polymod.hscript.HScriptedClass;

class Splash extends FlxState implements HScriptedClass
{
	public var hi:FlxText;
	public var chilling:FlxSprite;

	public var script:HScript;

	override function create()
	{
		super.create();

		script = new HScript('Splash.hxc');
		script.start();

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

		script.update(elapsed);
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
