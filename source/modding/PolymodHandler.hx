package modding;

#if polymod
import polymod.Polymod;

class PolymodHandler
{
	public static var metadataArrays:Array<String> = [];

	public static function loadMods()
	{
		ModList.load();
		loadModMetadata();

		Polymod.init({
			modRoot: "mods/",
			dirs: ModList.getActiveMods(metadataArrays),
			framework: OPENFL,
			errorCallback: function(error:PolymodError)
			{
				#if debug
				#if BLOCK_SOME_POLYMOD_TRACES
				var I_dont_wanna_see_that_shit:Array<PolymodErrorCode> = [
					PARSE_MOD_META,
					PARSE_MOD_VERSION,
					PARSE_MOD_API_VERSION,
					FILE_MISSING,
					MISSING_ICON,
					MOD_LOAD_PREPARE,
					MOD_LOAD_DONE
				];

				if (I_dont_wanna_see_that_shit.contains(error.code))
					return;
				#end
				#end

				#if debug
				trace(error.message.replace('mod mods/', 'mod: '));
				#end
			},
			apiVersionRule: ">=0.6.0 <0.7.0"
		});
	}

	public static function loadModMetadata()
	{
		metadataArrays = [];

		var tempArray:Array<ModMetadata> = Polymod.scan({
			modRoot: "mods/",
			apiVersionRule: "*.*.*",
			errorCallback: function(error:PolymodError)
			{
				#if debug
				trace(error.message.replace('mod mods/', 'mod '));
				#end
			}
		});

		for (metadata in tempArray)
		{
			if (metadata.title == null)
				return;
			metadataArrays.push(metadata.id);
			ModList.modMetadatas.set(metadata.id, metadata);
		}
	}
}
#end
