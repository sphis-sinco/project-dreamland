package modding;

#if polymod
class ModList
{
	public static var modList:Map<String, Bool> = new Map<String, Bool>();

	public static var modMetadatas:Map<String, ModMetadata> = new Map();

	public static function setModEnabled(mod:String, enabled:Bool):Void
	{
		modList.set(mod, enabled);
		Global.MOD_LIST.set(mod, enabled);
	}

	public static function getModEnabled(mod:String):Bool
	{
		if (!modList.exists(mod))
			setModEnabled(mod, modMetadatas.get(mod).metadata.get('auto_enable').toLowerCase() != 'false');

		return modList.get(mod);
	}

	public static function getActiveMods(modsToCheck:Array<String>):Array<String>
	{
		var activeMods:Array<String> = [];

		for (modName in modsToCheck)
		{
			if (getModEnabled(modName))
				activeMods.push(modName);
		}

		return activeMods;
	}

	public static function load():Void
	{
		if (Global.MOD_LIST != null && Global.MOD_LIST != [])
			modList = Global.MOD_LIST;
	}
}
#end