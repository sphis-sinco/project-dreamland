package data;

typedef PlayerData =
{
	var path:String;
	var dimensions:Array<Int>;
	var scale:Array<Float>;
	var default_animation:String;
	var animations:Array<
		{
			var name:String;
			var frames:Array<Int>;
			var fps:Int;
			var looping:Bool;
		}>;
	var bullet:
		{
			var color:Array<Int>;
			var size:Array<Int>;
		}
}

class PlayerDataManager
{
	public static var defaultJSON:PlayerData = {
		"path": "player",
		"dimensions": [32, 32],
		"scale": [2, 2],
		"default_animation": "idle",
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
		],
		"bullet": {
			"color": [255, 255, 0],
			"size": [24, 24]
		}
	};
}
