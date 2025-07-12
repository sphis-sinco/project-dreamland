package shaders;

// https://github.com/FunkinCrew/funkin.assets/blob/b8d72a1c10cd84775761579f633bf4537aa61bbe/preload/scripts/shaders/MultiplyColorShader.hxc#L4
import flixel.addons.display.FlxRuntimeShader;
import flixel.system.FlxAssets.FlxShader;
import lime.utils.Assets;

class MultiplyColorShader extends FlxRuntimeShader
{
	// ARGB = FlxColor
	public var color:Int = 0xFFFFFFFF;

	public function new(color:Int = 0xFFFFFFFF)
	{
		var fragText:String = Assets.getText(FileManager.getAssetFile('shaders/multiplyColor.frag'));
		super(fragText);
		setColor(color);
	}

	function setColor(value:Int):Void
	{
		this.color = value;

		this.setFloat('colorAlpha', ((this.color >> 24) & 0xff) / 255.0);
		this.setFloat('colorRed', ((this.color >> 16) & 0xff) / 255.0);
		this.setFloat('colorGreen', ((this.color >> 8) & 0xff) / 255.0);
		this.setFloat('colorBlue', ((this.color) & 0xff) / 255.0);
	}
}
