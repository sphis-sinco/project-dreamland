package data;

typedef LevelSelectEntryData =
{
	var name:String;
	var filenames:Array<String>;
	var difficulties:Array<String>;
	var variations:Array<String>;
	var fileSuffixes:Array<String>;
	var filePrefixes:Array<String>;
}

class LevelSelectEntryDataManager
{
	public static var defaultJSON:LevelSelectEntryData = {
		"name": "Earth",
		"filenames": ["earth", "earth"],
		"difficulties": ["easy-ish", "hard"],
		"variations": ["Default", "Overdrive"],
		"fileSuffixes": [null, "-overdrive"],
		"filePrefixes": [null, null]
	};

	public static function getJsonFileName(json:LevelSelectEntryData, index:Int = 0)
	{
		var prefix = json.filePrefixes[index] ?? '';
		var suffix = json.fileSuffixes[index] ?? '';

		return prefix + json.filenames[index] + suffix;
	}
}
