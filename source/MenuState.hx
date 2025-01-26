package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.app.Application;

class MenuState extends FlxState
{
	var menuText:FlxText = new FlxText(0, 0, 0, "Dreamland", 32);
	var pressButton:FlxText = new FlxText(0, 0, 0, "Press enter to play", 32);
	var highscoreText:FlxText = new FlxText(0, 32, 0, "Highscore: 0", 16);

	override public function create()
	{
		add(menuText);
		add(pressButton);

		Global.set_HIGHSCORE();
		highscoreText.text = 'Highscore: ${Global.HIGHSCORE}${(Global.NEW_HIGHSCORE) ? ' (NEW HIGHSCORE)' : ''}';
		highscoreText.color = (Global.NEW_HIGHSCORE) ? 0x00ff00 : 0xffffff;
		add(highscoreText);

		pressButton.y = FlxG.height - pressButton.height + 8;
		pressButton.color = FlxColor.GREEN;

		menuText.text += ' v${Application.current.meta.get('version')}';

		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.justReleased.ENTER)
			FlxG.switchState(new PlayState());

		super.update(elapsed);
	}
}