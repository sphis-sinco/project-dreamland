import gameplay.PlayState;
import shaders.AdjustColorShader;

var shader:AdjustColorShader = new AdjustColorShader();

function stateCreate()
{
	trace(PlayState.CURRENT_LEVEL);

	if (Global.CurrentState == 'PlayState' && PlayState.CURRENT_LEVEL == 'hell-overdrive')
	{
		shader.hue = 238;
		shader.saturation = 37;
		shader.brightness = 81;
		shader.contrast = 0;

		PlayState.instance.player.shader = shader;
	}
}
