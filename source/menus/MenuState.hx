package menus;

import menus.editors.EditorMenu;
import menus.options.OptionsMenuMain;

class MenuState extends FlxState
{
	public var menuText:FlxText = new FlxText(0, 0, 0, "Dreamland", #if MOBILE_BUILD 64 #else 32 #end);
	public var highscoreText:FlxText = new FlxText(0, 0, 0, "Highscore: 0", #if MOBILE_BUILD 32 #else 16 #end);

	public var btnGrp:FlxTypedGroup<FlxSprite> = new FlxTypedGroup<FlxSprite>();

	public var levelBtn:FlxSprite = new FlxSprite(0, 0).loadGraphic(FileManager.getImageFile('menus/menubutton-unknown'));
	public var modBtn:FlxSprite = new FlxSprite(0, 0).loadGraphic(FileManager.getImageFile('menus/menubutton-unknown'));
	public var optionBtn:FlxSprite = new FlxSprite(0, 0).loadGraphic(FileManager.getImageFile('menus/menubutton-unknown'));
	public var creditsBtn:FlxSprite = new FlxSprite(0, 0).loadGraphic(FileManager.getImageFile('menus/menubutton-unknown'));

	override public function create()
	{
		Save.flushData();
		add(menuText);

		highscoreText.text = 'Highscore: ${Global.HIGHSCORE}${(PlayState.HIGHSCORE) ? ' (NEW HIGHSCORE)' : ''}';
		highscoreText.color = (PlayState.HIGHSCORE) ? 0x00ff00 : 0xffffff;
		highscoreText.y = menuText.size;
		add(highscoreText);

		menuText.text += ' v${Global.APP_VERSION}';

		#if (discord_rpc && !hl)
		Discord.changePresence('In the menus', 'Navigating');
		#end

		add(btnGrp);

		var btnScaleStuff:Int = #if MOBILE_BUILD 2 #else 1 #end;

		levelBtn.loadGraphic(FileManager.getImageFile('menus/menubutton-levels'));
		levelBtn.screenCenter();
		levelBtn.scale.set(btnScaleStuff, btnScaleStuff);
		levelBtn.x -= levelBtn.width * btnScaleStuff;
		btnGrp.add(levelBtn);

		#if POLYMOD_MODDING
		modBtn.loadGraphic(FileManager.getImageFile('menus/menubutton-mods'));
		#end
		modBtn.scale.set(btnScaleStuff, btnScaleStuff);
		modBtn.screenCenter();
		btnGrp.add(modBtn);

		optionBtn.loadGraphic(FileManager.getImageFile('menus/menubutton-options'));
		optionBtn.screenCenter();
		optionBtn.scale.set(btnScaleStuff, btnScaleStuff);
		optionBtn.x += optionBtn.width * btnScaleStuff;
		btnGrp.add(optionBtn);

		creditsBtn.loadGraphic(FileManager.getImageFile('menus/menubutton-credits'));
		creditsBtn.screenCenter();
		creditsBtn.scale.set(btnScaleStuff, btnScaleStuff);
		creditsBtn.x = levelBtn.x;
		creditsBtn.y += creditsBtn.height * btnScaleStuff;
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
