package menus.editors;

class EditorMenu extends FlxState
{
	override function create()
	{
		super.create();

		ScriptManager.callScript('editorMenuStart');
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
