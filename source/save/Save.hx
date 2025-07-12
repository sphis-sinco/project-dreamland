package save;

import flixel.input.keyboard.FlxKey;
import modding.ModList;
import modding.PolymodHandler;

class Save
{
	public static final SAVEDATA_VERSION:Int = 6;

	public static function initalize()
	{
		FlxG.save.bind('dreamland', Application.current.meta.get('company'));

		if (FlxG.save.data.savedata == null)
		{
			trace('SAVEDATA IS NULL. SETTING TO A COMPLETELY NEW SAVE.');
			FlxG.save.data.savedata = {
				saveVer: SAVEDATA_VERSION,
				firstTime: true,
				highscore: 0,
				controls: Controls.defaultControls,
				shaders: true,
			};
		}
		else
		{
			FlxG.save.data.savedata.saveVer ??= SAVEDATA_VERSION;
			FlxG.save.data.savedata.firstTime ??= true;
			FlxG.save.data.savedata.highscore ??= 0;
			FlxG.save.data.savedata.controls ??= Controls.defaultControls;
			FlxG.save.data.savedata.shaders ??= true;
		}

		trace(FlxG.save.data.savedata);
		Controls.loadControlSave();

		#if polymod
		if (FlxG.save.data.modList != null)
		{
			trace(FlxG.save.data.modList);
			for (mod in PolymodHandler.metadataArrays)
			{
				TryCatch.tryCatch(() ->
				{
					trace(mod);

					if (FlxG.save.data.modlist.exists(mod))
						ModList.setModEnabled(mod, true);
				});
			}
		}
		#end

		FlxG.save.flush();
		flushData();
	}

	public static function getSavedataInfo(field:SaveKeys):Dynamic
	{
		var saveD:SaveData = FlxG.save.data.savedata;

		switch (field)
		{
			case savever:
				return saveD.saveVer;
			case firsttime, firstTime:
				return saveD.firstTime;
			case highscore:
				return saveD.highscore;
			case controls:
				return saveD.controls;
			case shaders:
				return saveD.shaders;
		}

		return null;
	}

	public static function setSavedataInfo(field:SaveKeys, newval:Dynamic, ?flush:Bool = true)
	{
		switch (field)
		{
			case savever:
				FlxG.save.data.savedata.saveVer = newval;
			case firsttime, firstTime:
				FlxG.save.data.savedata.firstTime = newval;
			case highscore:
				FlxG.save.data.savedata.highscore = newval;
			case controls:
				FlxG.save.data.savedata.controls = newval;
			case shaders:
				FlxG.save.data.savedata.shaders = newval;
		}

		if (flush)
			flushData();
	}

	public static function flushData()
	{
		setSavedataInfo(savever, SAVEDATA_VERSION, false);
		setSavedataInfo(highscore, getSavedataInfo(highscore), false);
		setSavedataInfo(controls, getSavedataInfo(controls), false);
		setSavedataInfo(shaders, getSavedataInfo(shaders), false);

		trace('SAVE PLEASE');
		FlxG.save.flush();
	}
}

typedef SaveData =
{
	var saveVer:Int;

	var firstTime:Bool;
	var highscore:Int;

	var controls:Map<String, FlxKey>;
	var shaders:Bool;
}

enum SaveKeys
{
	savever;
	firsttime;
	firstTime;
	highscore;
	// settings
	controls;
	shaders;
}
