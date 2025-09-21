package menus;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import modding.ModList;
import modding.PolymodHandler;
import openfl.display.BitmapData;
import thx.semver.Version;

class ModMenu extends FlxState
{
	public static var savedSelection:Int = 0;

	public var curSelected:Int = 0;

	public var modText:FlxText;
	public var modIcon:FlxSprite;

	override function create()
	{
		curSelected = savedSelection;

		var menuBG:FlxSprite;

		menuBG = new FlxSprite().makeGraphic(FlxG.width, FlxG.height);
		menuBG.color = 0xfff0b368;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = true;
		add(menuBG);

		super.create();

		modIcon = new FlxSprite();
		modIcon.loadGraphic(FileManager.getAssetFile('images/default-mod-icon.png'));
		modIcon.scale.set(0.5, 0.5);
		modIcon.setPosition(FlxG.width - modIcon.width, 325);
		add(modIcon);

		modText = new FlxText(0, 0, FlxG.width, 'Template Description', 16);
		modText.scrollFactor.set();
		add(modText);

		if (PolymodHandler.metadataArrays.length < 1)
		{
			modText.text = 'No mods';
			modText.alignment = CENTER;
		}

		var leText:String = 'Press ' + Controls.getKey('ui_select') + ' to enable / disable the currently selected mod.\nPress [R] to reload mods';

		var text:FlxText = new FlxText(0, FlxG.height - 42, FlxG.width, leText, 16);
		text.scrollFactor.set();
		add(text);

		updateSel();
	}

	public var curModId = '';

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (Controls.UI_MOVE_LEFT)
		{
			curSelected -= 1;
			updateSel();
		}

		if (Controls.UI_MOVE_RIGHT)
		{
			curSelected += 1;
			updateSel();
		}

		if (Controls.UI_LEAVE)
		{
			if (FlxG.save != null)
				FlxG.save.flush();
			PolymodHandler.loadMods();
			FlxG.switchState(() -> new MenuState());
		}

		if (FlxG.keys.justReleased.R)
		{
			PolymodHandler.loadMods();
		}

		if (Controls.UI_SELECT)
		{
			savedSelection = curSelected;
			ModList.setModEnabled(curModId, !ModList.getModEnabled(curModId));
		}

		var leftTxt = '< ';
		var rightTxt = ' >';

		if (curSelected <= 0)
		{
			curSelected = 0;
			leftTxt = '| ';
			updateSel();
		}

		if (curSelected >= PolymodHandler.metadataArrays.length - 1)
		{
			curSelected = PolymodHandler.metadataArrays.length - 1;
			rightTxt = ' |';
			updateSel();
		}

		if (PolymodHandler.metadataArrays.length >= 1)
		{
			modText.alpha = ModList.getModEnabled(curModId) ? 1.0 : 0.6;

			var outdatedText:String = '';
			modText.color = FlxColor.WHITE;

			if (PolymodHandler.outdatedMods.contains(curModId))
			{
				var debugMod = ModList.modMetadatas.get(curModId).apiVersion.major == 0;
				var higherVersion = ModList.modMetadatas.get(curModId).apiVersion.greaterThan(PolymodHandler.MAXIMUM_MOD_VERSION);

				var old_level_system_version = ModList.modMetadatas.get(curModId).apiVersion.lessThan(Version.arrayToVersion([0, 9, 0]));
				var old_player_results_version = !ModList.modMetadatas.get(curModId).apiVersion.lessThan(Version.arrayToVersion([1, 0, 0]));
				var old_stages = ModList.modMetadatas.get(curModId).apiVersion.lessThan(Version.arrayToVersion([2, 0, 0]));

				outdatedText = ' \n@Outdated@';

				if (debugMod)
					outdatedText += '\n^* Debug Mod (0.x.x)^';
				if (higherVersion)
					outdatedText += '\n@* Troll@';

				if (old_player_results_version)
					outdatedText += '\n$* Custom player results assets won\'t work$';
				if (old_level_system_version)
					outdatedText += '\n$* Any new levels added won\'t work$';
				if (old_stages)
					outdatedText += '\n$* Level backgrounds won\'t work$';
			}

			// #region mod text stuff
			modText.text = '@' + leftTxt + '@' + ModList.modMetadatas.get(curModId).title + '@' + rightTxt + '@' + '\nid (folder): '
				+ ModList.modMetadatas.get(curModId).id + '\n\n' + ModList.modMetadatas.get(curModId).description + '\n\nContributors:\n';

			var len = ModList.modMetadatas.get(curModId).contributors.length - 1;
			for (contributor in ModList.modMetadatas.get(curModId).contributors)
				modText.text += '  *  ' + contributor.name + ' (' + contributor.role + ')\n';

			modText.text += '\n\nAPI Version: ' + ModList.modMetadatas.get(curModId).apiVersion + outdatedText + '\nMod Version: '
				+ ModList.modMetadatas.get(curModId).modVersion + '\n';
			modText.applyMarkup(modText.text, [
				new FlxTextFormatMarkerPair(new FlxTextFormat(FlxColor.BLACK, true, true), '@'),
				new FlxTextFormatMarkerPair(new FlxTextFormat(FlxColor.YELLOW, true, true), '%'),
				new FlxTextFormatMarkerPair(new FlxTextFormat(FlxColor.ORANGE, true, true), '$'),
				new FlxTextFormatMarkerPair(new FlxTextFormat(FlxColor.RED, true, true), '^')
			]);
			// #endregion
		}
		else
		{
			modText.alpha = 1.0;
			modText.text = 'No mods';
		}
	}

	function updateSel()
	{
		modIcon.loadGraphic(FileManager.getAssetFile('images/default-mod-icon.png'));
		if (PolymodHandler.metadataArrays.length < 1)
			return;

		curModId = PolymodHandler.metadataArrays[curSelected];
		var modMeta = ModList.modMetadatas.get(curModId);

		try
		{
			if (modMeta.icon != null)
				modIcon.loadGraphic(BitmapData.fromBytes(modMeta.icon));
		}
		catch (e)
		{
			modIcon.loadGraphic(FileManager.getAssetFile('images/default-mod-icon.png'));
		}
	}
}
