import com.haxepunk.Scene;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Gesture;
import com.haxepunk.utils.Key;
import com.haxepunk.Sfx;
import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Touch;


class Introscene extends Scene
{

	// this is the holding place for the intro :D
	var newmusic : Sfx;
	var playentity : Entity;

	public override function new()
	{
		super();
		init();
	}

	private function init()
	{
		var tetrodemo = new Array<Tetrodemo>();

		for (i in 0...200)
		{
			var demoentity = new Tetrodemo();
			tetrodemo.push(demoentity);

		}

		newmusic = new Sfx("audio/koro.ogg");
		newmusic.loop(0.3);


		addList(tetrodemo);

		var newimage = new Image("graphics/play.png");
		newimage.centerOrigin();
		newimage.scale = 2.5;
		
		playentity = new Entity();
		playentity.graphic = newimage;


		playentity.x = HXP.halfWidth - playentity.width/2;
		playentity.y = HXP.halfHeight - playentity.height/2;
		playentity.layer = 0;

		add(playentity);

	}

	public override function begin()
	{
		//HXP.scene = new Gamescene();
	}

	public override function update()
	{
		super.update();

		if (Input.pressed(Key.DIGIT_3))
		{
			newmusic.stop();
			HXP.scene = new Gamescene();
		}

		if (Input.mousePressed)
		{
			if (Input.mouseX > 235 && Input.mouseX < 486 && Input.mouseY > 204 && Input.mouseY < 297)
			{
				newmusic.stop();
				HXP.scene = new Gamescene();
			}
		}
	}
}
