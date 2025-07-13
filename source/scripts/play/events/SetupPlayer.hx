package scripts.play.events;

import data.PlayerData;

class SetupPlayer
{
	public static function call(player_json:PlayerData)
	{
		ScriptManager.callScript('setupPlayer', [player_json]);
	}
}
