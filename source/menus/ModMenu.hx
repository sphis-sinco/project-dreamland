package menus;

import openfl.display.BitmapData;
import polymod.Polymod;
#if polymod
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import modding.ModList;
import modding.PolymodHandler;

class ModMenu extends FlxState
{
	public static var savedSelection:Int = 0;

	var curSelected:Int = 0;

	public var page:FlxTypedGroup<FlxText> = new FlxTypedGroup<FlxText>();

	public static var instance:ModMenu;

	var descriptionText:FlxText;
	var descBg:FlxSprite;
	var descIcon:FlxSprite;

	override function create()
	{
		instance = this;

		#if polymod
		modding.PolymodHandler.loadMods();
		#end

		curSelected = savedSelection;

		var menuBG:FlxSprite;

		menuBG = new FlxSprite().makeGraphic(1286, 730, FlxColor.fromString("#E1E1E1"), false, "optimizedMenuDesat");

		menuBG.color = 0xFFea71fd;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);

		super.create();

		add(page);

		PolymodHandler.loadModMetadata();

		loadMods();

		descBg = new FlxSprite(0, FlxG.height - 120).makeGraphic(FlxG.width, 90, 0xFF000000);
		descBg.alpha = 0.6;
		add(descBg);

		descIcon = new FlxSprite();
		descIcon.loadGraphic(FileManager.getImageFile('default-mod-icon'));
		descIcon.scale.set(0.5, 0.5);
		descIcon.setPosition(FlxG.width - descIcon.width, 325);
		add(descIcon);

		descriptionText = new FlxText(descBg.x, descBg.y + 4, FlxG.width, "Template Description", 16);
		descriptionText.scrollFactor.set();
		descriptionText.screenCenter(X);
		add(descriptionText);

		var leText:String = "Press ENTER to enable / disable the currently selected mod.";

		var text:FlxText = new FlxText(0, FlxG.height - 22, FlxG.width, leText, 16);
		text.scrollFactor.set();
		add(text);

		updateSel();
	}

	function loadMods()
	{
		page.forEachExists(function(option:FlxText)
		{
			page.remove(option);
			option.kill();
			option.destroy();
		});

		var optionLoopNum:Int = 0;

		for (modId in PolymodHandler.metadataArrays)
		{
			var modOption = new FlxText(10, 0, 0, ModList.modMetadatas.get(modId).title, 16);
			modOption.ID = optionLoopNum;
			page.add(modOption);
			optionLoopNum++;
		}
	}

	public var curModId = '';

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.justReleased.UP)
		{
			curSelected -= 1;
			Global.playSound('blip');
			updateSel();
		}

		if (FlxG.keys.justReleased.DOWN)
		{
			curSelected += 1;
			Global.playSound('blip');
			updateSel();
		}

		if (FlxG.keys.justReleased.ESCAPE)
		{
			PolymodHandler.loadMods();
			Global.playSound('select');
			savedSelection = 0;
			FlxG.switchState(MenuState.new);
		}

		if (FlxG.keys.justPressed.ENTER)
		{
			savedSelection = curSelected;
			ModList.setModEnabled(curModId, !ModList.getModEnabled(curModId));
			FlxG.resetState();
		}

		if (curSelected < 0)
		{
			curSelected = page.length - 1;
			updateSel();
		}

		if (curSelected >= page.length)
		{
			curSelected = 0;
			updateSel();
		}

		var bruh = 0;

		for (x in page.members)
		{
			x.y = 10 + (bruh * 32);
			x.alpha = ModList.getModEnabled(PolymodHandler.metadataArrays[x.ID]) ? 1.0 : 0.6;
			x.color = (curSelected == x.ID) ? FlxColor.YELLOW : FlxColor.WHITE;

			if (curSelected == x.ID)
			{
				@:privateAccess
				descriptionText.text = ModList.modMetadatas.get(curModId).description + "\nAuthor: " + ModList.modMetadatas.get(curModId).author
					+ "\nDreamland Version: " + ModList.modMetadatas.get(curModId).apiVersion + "\nMod Version: "
					+ ModList.modMetadatas.get(curModId).modVersion + "\n";
			}

			bruh++;
		}
	}

	function updateSel()
	{
		descIcon.loadGraphic(FileManager.getImageFile('default-mod-icon'));
		curModId = PolymodHandler.metadataArrays[curSelected];
		var modMeta = ModList.modMetadatas.get(curModId);

		TryCatch.tryCatch(() ->
		{
			if (modMeta.icon != null)
				descIcon.loadGraphic(BitmapData.fromBytes(modMeta.icon));
		});
	}
}
#end
