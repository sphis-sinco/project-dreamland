package menus;

import menus.editors.EditorMenu;
import menus.options.OptionsMenuMain;

class MenuState extends FlxState
{
	public var menuText:FlxText = new FlxText(0, 0, 0, "Dreamland", 32);
	public var highscoreText:FlxText = new FlxText(0, 32, 0, "Highscore: 0", 16);

	public var btnGrp:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();

	public var levelBtn:FlxSprite = new FlxSprite(0, 0).loadGraphic(FileManager.getImageFile('menus/menubutton-unknown'));
	public var modBtn:FlxSprite = new FlxSprite(0, 0).loadGraphic(FileManager.getImageFile('menus/menubutton-unknown'));
	public var optionBtn:FlxSprite = new FlxSprite(0, 0).loadGraphic(FileManager.getImageFile('menus/menubutton-unknown'));
	public var creditsBtn:FlxSprite = new FlxSprite(0, 0).loadGraphic(FileManager.getImageFile('menus/menubutton-unknown'));

	override public function create()
	{
		Save.flushData();
		add(menuText);

		Global.set_HIGHSCORE();
		highscoreText.text = 'Highscore: ${Global.HIGHSCORE}${(Global.NEW_HIGHSCORE) ? ' (NEW HIGHSCORE)' : ''}';
		highscoreText.color = (Global.NEW_HIGHSCORE) ? 0x00ff00 : 0xffffff;
		add(highscoreText);

		menuText.text += ' v${Global.APP_VERSION}';

		#if (discord_rpc && !hl)
		Discord.changePresence('In the menus', 'Navigating');
		#end

		add(btnGrp);

		levelBtn.loadGraphic(FileManager.getImageFile('menus/menubutton-levels'));
		levelBtn.screenCenter();
		levelBtn.x -= levelBtn.width;
		btnGrp.add(levelBtn);

		#if POLYMOD_MODDING
		modBtn.loadGraphic(FileManager.getImageFile('menus/menubutton-mods'));
		#end
		modBtn.screenCenter();
		btnGrp.add(modBtn);

		optionBtn.loadGraphic(FileManager.getImageFile('menus/menubutton-options'));
		optionBtn.screenCenter();
		optionBtn.x += optionBtn.width;
		btnGrp.add(optionBtn);

		creditsBtn.loadGraphic(FileManager.getImageFile('menus/menubutton-credits'));
		creditsBtn.screenCenter();
		creditsBtn.x -= creditsBtn.width;
		creditsBtn.y += creditsBtn.height;
		btnGrp.add(creditsBtn);

		for (member in btnGrp.members)
		{
			member.y -= member.height / 2;
		}

		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.mouse.justReleased)
		{
			for (member in btnGrp.members)
			{
				if (member != modBtn && FlxG.mouse.overlaps(member))
				{
					Global.playSound('select');
					break;
				}
			}

			if (FlxG.mouse.overlaps(levelBtn))
				FlxG.switchState(LevelSelect.new);
			if (FlxG.mouse.overlaps(modBtn))
			{
				#if POLYMOD_MODDING
				Global.playSound('select');
				FlxG.switchState(ModMenu.new);
				#end
			}
			if (FlxG.mouse.overlaps(optionBtn))
				FlxG.switchState(OptionsMenuMain.new);
			if (FlxG.mouse.overlaps(creditsBtn))
				FlxG.switchState(CreditsMenu.new);
		}
		else if (FlxG.keys.justReleased.SEVEN)
		{
			#if !html5
			// FlxG.switchState(EditorMenu.new);
			#end
		}

		super.update(elapsed);
	}
}
