#if cpp
import discord_rpc.DiscordRpc;

class Discord
{
	static function main()
	{
		DiscordRpc.start({
			clientID: "1333139063263330375",
			onReady: onReady,
			onError: onError,
			onDisconnected: onDisconnected
		});

		while (true)
		{
			DiscordRpc.process();
		}

		DiscordRpc.shutdown();
	}

	static function onReady()
	{
		DiscordRpc.presence({
			details: 'Chilling',
			state: 'Chilling',
			largeImageKey: 'logo_haxe',
			largeImageText: 'Haxe'
		});
	}

	static function onError(_code:Int, _message:String)
	{
		trace('Error! $_code : $_message');
	}

	static function onDisconnected(_code:Int, _message:String)
	{
		trace('Disconnected! $_code : $_message');
	}
}
#else
class Discord
{
	static function main() {}

	static function onReady() {}

	static function onError(_code:Int, _message:String) {}

	static function onDisconnected(_code:Int, _message:String) {}
}
#end