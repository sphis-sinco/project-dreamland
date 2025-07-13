package menus.editors;

import menus.options.OptionsMenuMain;

class EditorMenu extends OptionsMenuMain
{
	override public function new()
	{
		super();
		ScriptManager.callScript('editorMenuStart');

		texts = [];
		newOptionMenu('Level editor', LevelEditorMenu.new);
	}

	override function create()
	{
		super.create();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
