import com.haxepunk.Scene;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Gesture;
import com.haxepunk.utils.Key;

class Gamescene extends Scene
{


	private var _playfield  : Playfield;
	private var _gamestate : Int;
	private var _clocktick : Float;
	private var _clocktickamount : Float;
	private var _spawntick : Float;
	private static var _maxspeed : Float = 10;
	private var tetro : Tetromino;

	public override function begin()
	{

		_playfield = new Playfield();
		_clocktick = 0;
		_clocktickamount = 0.5;
		addList(_playfield.battlefield);

		_gamestate = 0;

		if (_gamestate == 0)
		{
			_gamestate == 1;
			tetro = new Tetromino();

		}

		if (_gamestate == 1)
		{

		}

		Input.define("right", [Key.E]);
		Input.define("rotate", [Key.R]);

	}

	public override function update()
	{

		super.update();

		

		_clocktick += _clocktickamount;
		_spawntick += _clocktickamount;


		renderPlayfield(tetro);	
		if (_clocktick > _maxspeed)
		{
			_clocktick = 0;
			if (tetro != null)
			{
				if (tetro.movedown())
				{

				}
			}

		}

		if (_spawntick > 300)
		{
			tetro = new Tetromino();
			_spawntick = 0 ;
		}


		if (Input.pressed ("right"))
		{
			tetro.moveright();
		}

		if (Input.pressed("rotate"))
		{
			tetro.rotate();
		}


	}

	private function renderPlayfield(tetro: Tetromino)
	{
		_playfield.drawplayfield(tetro);
	}
}
