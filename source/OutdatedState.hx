package;

import modding.scriptables.ScriptableFlxState;
import polymod.hscript.HScriptable;

class OutdatedState extends FlxState
{
	var script:ScriptableFlxState;

	override public function create()
	{
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		script.update(elapsed);
	}
}
