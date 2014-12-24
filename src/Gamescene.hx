import com.haxepunk.Scene;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Gesture;

class Gamescene extends Scene
{


	private var _playfield  : Playfield;
	private var _gamestate : Int;
	private var _clocktick : Float;
	private var _clocktickamount : Float;
	private static var _maxspeed : Float = 100;

	public override function begin()
	{

		_clocktick = 0;
		_clocktickamount = 0.5;


		_gamestate = 0;

		if (_gamestate == 0)
		{
			_playfield = new Playfield();
		}

	}

	public override function update()
	{

		super.update();

		_clocktick += _clocktickamount;

		if (_clocktick > _maxspeed)
		{
			_clocktick = 0;
		}

		renderPlayfield(_playfield);
	}

	private function renderPlayfield(playfield : Playfield)
	{
		// render the whole stuff
	}
}
