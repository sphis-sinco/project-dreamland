package modding.scripts.events;

class CheckOutdated extends EventClass implements IScriptable
{
	override function new()
	{
		super('CheckOutdated');
	}

	override function toString()
	{
		trace('CheckOutdated(user: $gitUser, repo: $gitRepo)');
	}

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
				return true;
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

	function buildPathName()
	{
		return 'events/CheckOutdated';
	}

	@:hscript({
		pathName: buildPathName,
		optional: false,
	})
	public function onInit()
	{
		var gitUserFunc = script_variables.get('getGitUser');
		var gitRepoFunc = script_variables.get('getGitRepo');
		gitUser = gitUserFunc();
		gitRepo = gitRepoFunc();

		trace('CheckOutdated.onInit(user: $gitUser, repo: $gitRepo)');
	}

	var gitUser = 'sphis-sinco';
	var gitRepo = 'project-dreamland';
}
