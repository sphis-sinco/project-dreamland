package data;

typedef PlayerData =
{
	var path:String;
	var dimensions:Array<Int>;
	var scale:Array<Float>;
	var animations:Array<
		{
			var name:String;
			var frames:Array<Int>;
			var fps:Int;
			var looping:Bool;
		}>;
}

class PlayerDataManager
{
	public static var defaultJSON:PlayerData = {
		"path": "player",
		"dimensions": [32, 32],
		"scale": [2, 2],
		"animations": [
			{
				"name": "idle",
				"frames": [0],
				"fps": 4,
				"looping": false
			},
			{
				"name": "shoot-a2",
				"frames": [1, 2],
				"fps": 4,
				"looping": false
			},
			{
				"name": "shoot-a1",
				"frames": [2, 3],
				"fps": 4,
				"looping": false
			},
			{
				"name": "shoot-a0",
				"frames": [3, 3],
				"fps": 4,
				"looping": false
			}
		]
	}
}
