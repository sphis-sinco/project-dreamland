package scripts.events;

class CheckOutdated
{
	public static var updateVersion:String;

	public static function call()
	{
		#if !hl
		onInit();

		trace('checking for update');
		var http = new haxe.Http('https://raw.githubusercontent.com/$gitUser/$gitRepo/refs/heads/master/version.txt');

		http.onData = function(data:String)
		{
			updateVersion = data.split('\n')[0].trim();
			var curVersion:String = Global.APP_VERSION.trim();
			trace('CheckOutdated.onData(curVersion: $curVersion, updateVersion: $updateVersion)');
			if (updateVersion != curVersion)
			{
				return true;
			}

			return false;
		}

		http.onError = function(error)
		{
			trace('CheckOutdated.onError("$error")');
			return false;
		}

		http.request();
		#end

		return false;
	}

	static function onInit()
	{
		trace('CheckOutdated.onInit(user: $gitUser, repo: $gitRepo)');
	}

	static var gitUser = 'sphis-sinco';
	static var gitRepo = 'project-dreamland';
}
