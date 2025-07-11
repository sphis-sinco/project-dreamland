package menus;

import menus.editors.EditorMenu;
import menus.options.OptionsMenuMain;

class MenuState extends FlxState
{
	public var menuText:FlxText = new FlxText(0, 0, 0, "Dreamland", 32);
	public var highscoreText:FlxText = new FlxText(0, 32, 0, "Highscore: 0", 16);

	public var levelBtn:FlxSprite = new FlxSprite(0, 0).loadGraphic(FileManager.getImageFile('menus/menubutton-unknown'));
	public var modBtn:FlxSprite = new FlxSprite(0, 0).loadGraphic(FileManager.getImageFile('menus/menubutton-unknown'));
	public var optionBtn:FlxSprite = new FlxSprite(0, 0).loadGraphic(FileManager.getImageFile('menus/menubutton-unknown'));

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

		levelBtn.loadGraphic(FileManager.getImageFile('menus/menubutton-levels'));
		levelBtn.screenCenter();
		levelBtn.x -= levelBtn.width;
		add(levelBtn);

		#if POLYMOD_MODDING
		modBtn.loadGraphic(FileManager.getImageFile('menus/menubutton-mods'));
		#end
		modBtn.screenCenter();
		add(modBtn);

		optionBtn.loadGraphic(FileManager.getImageFile('menus/menubutton-options'));
		optionBtn.screenCenter();
		optionBtn.x += optionBtn.width;
		add(optionBtn);

		super.create();
	}

	override public function update(elapsed:Float)
	{
		if (FlxG.mouse.justReleased)
		{
			if (FlxG.mouse.overlaps(levelBtn))
			{
				Global.playSound('select');
				FlxG.switchState(LevelSelect.new);
			}
			if (FlxG.mouse.overlaps(modBtn))
			{
				#if POLYMOD_MODDING
				Global.playSound('select');
				FlxG.switchState(ModMenu.new);
				#end
			}
			if (FlxG.mouse.overlaps(optionBtn))
			{
				Global.playSound('select');
				FlxG.switchState(OptionsMenuMain.new);
			}
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
