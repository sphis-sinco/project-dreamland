package menus;

class MenuState extends FlxState
{
	var menuText:FlxText = new FlxText(0, 0, 0, "Dreamland", 32);
	var pressButton:FlxText = new FlxText(0, 0, 0, "Press enter to play", 32);
	var legacyHighScoreText:FlxText = new FlxText(0, 32, 0, "Legacy highscore: 0", 16);

	override public function create()
	{
		add(menuText);
		add(pressButton);

		if (Save.getSavedataInfo(legacyUser))
		{
			legacyHighScoreText.text = 'Legacy highscore: ${Save.getSavedataInfo(legacyHighScore)}';
			add(legacyHighScoreText);
		}

		pressButton.y = FlxG.height - pressButton.height + 8;
		pressButton.color = FlxColor.GREEN;

		menuText.text += ' v${Global.APP_VERSION}';

		#if (discord_rpc && !hl)
		Discord.changePresence('In the menus', 'Navigating');
		#end

		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.keys.justReleased.ENTER)
			FlxG.switchState(LevelSelect.new);

		super.update(elapsed);
	}
}
