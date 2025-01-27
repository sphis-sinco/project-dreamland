package modding;

#if polymod
class PolymodHandler
{
	public static var metadataArrays:Array<String> = [];

	public static function loadMods()
	{
		loadModMetadata();

		Polymod.scan({
			modRoot: 'mods/',
			errorCallback: function(error:PolymodError)
			{
				#if debug
				trace(error.message);
				#end
			}
		});

		trace(ModList.modList);
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
				trace(error.message);
				#end
			},
		});

		for (metadata in tempArray)
		{
			metadataArrays.push(metadata.id);
			ModList.modMetadatas.set(metadata.id, metadata);
		}
	}
}
#end