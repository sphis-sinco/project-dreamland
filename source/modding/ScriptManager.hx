package modding;

import crowplexus.iris.Iris;
import shaders.AdjustColorShader;
import shaders.MultiplyColorShader;

// THANK YOU FNF-Doido-Engine
class ScriptManager
{
	// hscript!!
	public static var LOADED_SCRIPTS:Array<Iris> = [];

	public static function loadScripts():Void
	{
		// NO DUPES
		for (instance in LOADED_SCRIPTS)
		{
			// fix multiple instances of similar scripts
			instance.destroy();
		}
		LOADED_SCRIPTS = [];

		// loading scripts
		var scriptPaths:Array<String> = FileManager.getScriptArray();

		for (path in scriptPaths)
		{
			TryCatch.tryCatch(function()
			{
				var newScript:Iris = new Iris(FileManager.readFile('$path'), {
					name: path,
					autoRun: true,
					autoPreset: true
				});
				#if EXCESS_TRACES
				trace('New script: $path');
				#end
				LOADED_SCRIPTS.push(newScript);
				newScript.call('onLoad');
			});
		}

		// import stuff
		#if DISCORDRPC
		setScript('DiscordClient', clients.DiscordClient);
		#end

		setScript('Global', Global);

		setScript('FileManager', FileManager);

		setScript('AdjustColorShader', AdjustColorShader);
		setScript('MultiplyColorShader', MultiplyColorShader);

		// init mod
		ScriptManager.callScript('onCreate');
	}

	public static function callScript(fun:String, ?args:Array<Dynamic>, ?pos:haxe.PosInfos):Void
	{
		for (script in LOADED_SCRIPTS)
		{
			@:privateAccess {
				var ny:Dynamic = script.interp.variables.get(fun);
				try
				{
					if (ny != null && Reflect.isFunction(ny))
					{
						script.call(fun, args);
						// trace('ran $fun with args $args', pos);
					}
				}
				catch (e)
				{
					trace('error parsing script: ' + e, pos);
				}
			}
		}
	}

	public static function setScript(name:String, value:Dynamic, allowOverride:Bool = true):Void
	{
		for (script in LOADED_SCRIPTS)
			script.set(name, value, allowOverride);
	}
}
