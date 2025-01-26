package;

typedef LevelData =
{
	var level_data_format:Int;
	var difficulty:String;
	var author:String;
	var assets:LevelDataAssetsInfo;
	var settings:LevelDataSettings;
}

typedef LevelDataAssetsInfo =
{
	var directory:String;

	var enemy_rare:String;
	var enemy_easy:String;
	var enemy_common:String;
}

typedef LevelDataSettings =
{
	var scores:LDSScores;
	var chances:LDSChances;
}

typedef LDSScores =
{
	var enemy_rare:Int;
	var enemy_easy:Int;
	var enemy_common:Int;
}

typedef LDSChances =
{
	var enemy_rare:Float;
	var enemy_easy:Float;
}