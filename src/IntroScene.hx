import com.haxepunk.Scene;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Gesture;
import com.haxepunk.utils.Key;
import com.haxepunk.Sfx;
import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Touch;


class IntroScene extends Scene
{

	// this is the holding place for the intro :D

	public override function new()
	{
		super();

		HXP.scene = new Gamescene();
	}



}
