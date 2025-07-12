package data;

typedef LevelData =
{
	var ?author:String;
	var ?assets:LevelDataAssetsInfo;
	var ?settings:LevelDataSettings;
}

typedef LevelDataAssetsInfo =
{
	var ?directory:String;

	var ?player:String;

	var ?enemy_rare:String;
	var ?enemy_easy:String;
	var ?enemy_common:String;
}

typedef LevelDataSettings =
{
	var ?ammo:Int;
	var ?scores:LDSScores;
	var ?chances:LDSChances;
	var ?speed_additions:LDSSpeeds;
}

typedef LDSScores =
{
	var ?enemy_rare:Int;
	var ?enemy_easy:Int;
	var ?enemy_common:Int;
}

typedef LDSChances =
{
	var ?enemy_rare:Float;
	var ?enemy_easy:Float;
}

typedef LDSSpeeds =
{
	var ?enemy_rare:Float;
	var ?enemy_easy:Float;
	var ?enemy_common:Float;
}

class LevelDataManager
{
	public static var defaultJSON:LevelData = {
		"author": "Sphis_Sinco",
		"assets": {
			"directory": "",
			"player": "player",
			"enemy_rare": "enemy-rare",
			"enemy_easy": "enemy-easy",
			"enemy_common": "enemy-common"
		},
		"settings": {
			"ammo": 2,
			"scores": {
				"enemy_rare": 125,
				"enemy_easy": 50,
				"enemy_common": 25
			},
			"chances": {
				"enemy_rare": 10,
				"enemy_easy": 85
			},
			"speed_additions": {
				"enemy_common": 0,
				"enemy_easy": -10,
				"enemy_rare": 10
			}
		}
	};
}
