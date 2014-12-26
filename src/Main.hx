import com.haxepunk.Engine;
import com.haxepunk.HXP;
import com.haxepunk.RenderMode;


class Main extends Engine
{

	override public function init()
	{
//		HXP.console.enable();
		HXP.scene = new IntroScene();
//		HXP.scene = new Gamescene();
	}

	public static function main() { new Main(); }


#if android
	override public function new(width:Int=0, height:Int=0, frameRate:Float=60, fixed:Bool=false, ?renderMode:RenderMode) 
	{
	        super(720,500, frameRate, fixed, RenderMode.BUFFER);
	}
#end




}
