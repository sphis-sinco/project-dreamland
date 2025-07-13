package save;

import flixel.input.keyboard.FlxKey;
import modding.ModList;
import modding.PolymodHandler;

class Save
{
	public static var save:FlxSave;

	public static final SAVEDATA_VERSION:Int = 6;

	public static function initalize()
	{
		save = new FlxSave();
		save.bind('dreamland', Application.current.meta.get('company'));

		if (save.data.savedata == null)
		{
			trace('SAVEDATA IS NULL. SETTING TO A COMPLETELY NEW SAVE.');
			save.data.savedata = {
				saveVer: SAVEDATA_VERSION,
				firstTime: true,
				highscore: 0,
				controls: Controls.defaultControls,
				shaders: true
			};
		}
		else
		{
			save.data.savedata.saveVer ??= SAVEDATA_VERSION;
			save.data.savedata.firstTime ??= true;
			save.data.savedata.highscore ??= 0;
			save.data.savedata.controls ??= Controls.defaultControls;
			save.data.savedata.shaders ??= true;
		}

		trace("Loaded Save Data:");
		trace(save.data.savedata);

		Controls.loadControlSave();

		#if polymod
		if (save.data.modList != null)
		{
			trace(save.data.modList);
			for (mod in PolymodHandler.metadataArrays)
			{
				TryCatch.tryCatch(() -> {
					trace(mod);
					if (save.data.modList.exists(mod))
						ModList.setModEnabled(mod, true);
				});
			}
		}
		#end

		flushData();
	}

	public static function getSavedataInfo(field:SaveKeys):Dynamic
	{
		var saveD:SaveData = save.data.savedata;

		return switch (field)
		{
			case savever: saveD.saveVer;
			case firsttime, firstTime: saveD.firstTime;
			case highscore: saveD.highscore;
			case controls: saveD.controls;
			case shaders: saveD.shaders;
		}
	}

	public static function setSavedataInfo(field:SaveKeys, newval:Dynamic)
	{
		switch (field)
		{
			case savever: save.data.savedata.saveVer = newval;
			case firsttime, firstTime: save.data.savedata.firstTime = newval;
			case highscore: save.data.savedata.highscore = newval;
			case controls: save.data.savedata.controls = newval;
			case shaders: save.data.savedata.shaders = newval;
		}
	}

	public static function flushData()
	{
		save.flush();
		trace("Save flushed!");
		trace(save.data.savedata);
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
	// settings
	highscore;
	controls;
	shaders;
}
