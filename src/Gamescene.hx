import com.haxepunk.Scene;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Gesture;
import com.haxepunk.utils.Key;

enum GameLoop {
	GAMEPAUSE;
	GAMEOVER;
	PLAYLOOP;
	SPAWNTETRO;
	

}

/*

   TODO : 

   - Move all the code from the other classes here.
   - Yes, it's a pain, but it is how it should be handled as
   	a) rotation of tetro needs to check collision and cannot be checked inside the tetro code
	b) collision needs to be checked inside the scene and not on the playfield (or can it?)


   */
class Gamescene extends Scene
{


	private var _playfield  : Playfield;
	private var _gamestate : GameLoop;
	private var _clocktick : Float;
	private var _clocktickamount : Float;
	private var _spawntick : Float;
	private static var _maxspeed : Float = 10;
	private var tetro : Tetromino;
	
	public override function new()
	{
		super();
	}

	public override function begin()
	{

		_playfield = new Playfield();
		_clocktick = 0;
		_clocktickamount = 1;
		addList(_playfield.battlefield);

		_gamestate = SPAWNTETRO;

		Input.define("right", [Key.E, Key.RIGHT]);
		Input.define("down", [Key.D, Key.DOWN]);
		Input.define("left", [Key.W, Key.LEFT]);
		Input.define("rotate", [Key.R,Key.UP]);
		Input.define("newtetro", [Key.N]);
		Input.define("quitgame", [Key.Q]);
		Input.define("pause", [Key.P]);
		Input.define("drop", [Key.SPACE]);

	}

	public override function update()
	{

		super.update();

		if (_gamestate == SPAWNTETRO)
		{
			tetro = new Tetromino();
			_gamestate = PLAYLOOP;
			return;

		}

		if (_gamestate == PLAYLOOP)
		{

			_clocktick += _clocktickamount;
			_spawntick += _clocktickamount;

			renderPlayfield(tetro);	

			if (_clocktick > _maxspeed)
			{
				_clocktick = 0;

				tetro.movedown();
				return;

			}


			if (Input.pressed ("right"))
			{
				tetro.moveright();
				return;
			}

			if (Input.pressed("drop"))
			{
				droptetro();
				return;
			}



			if (Input.pressed ("left"))
			{
				tetro.moveleft();
				return;
			}

			if (Input.pressed ("down"))
			{
				tetro.movedown();
				return;
			}


			if (Input.pressed("rotate"))
			{
				tetro.rotate();
				return;
			}



			if (Input.pressed("quitgame"))
			{
				Sys.exit(0);
			}
		}

			if (Input.pressed("pause"))
			{
				if (_gamestate == PLAYLOOP)
				{
					_gamestate = GAMEPAUSE;
					return;
				}

				if (_gamestate == GAMEPAUSE)
				{
					_gamestate = PLAYLOOP;
					return;
				}

			}

		if (_gamestate == GAMEOVER)
		{
			if (Input.pressed("newtetro"))
			{
				begin();
			}
		}

	}

	private function renderPlayfield(tetro: Tetromino)
	{
		_playfield.drawplayfield(tetro);

		// here we should detect where's the tetro

		if (collision(_playfield, tetro))
		{
			_playfield.addtetro(tetro);
			_gamestate = SPAWNTETRO;
			if (tetro.getrow()==0)
			{
				_gamestate = GAMEOVER;
			}
		}


	}

	private function collision(playfield : Playfield, tetro : Tetromino)
	{
		var tetr = tetro.getrow()+tetro.getheight();
		var tetc = tetro.getcol();
		var iscol = false;
		var string : String = "";

		for (i in 0...tetro.getwidth())
		{
			var tt = tetc + i;
			var th = tetro.getheight();
			var tettr = tetr-1;
			for (y in 0...tetro.getheight())
			{
				var plval = playfield.getvalue(tetro.getrow()+y+1,tt);
				
				var trval = tetro.getvalue(y, i);
	
				if (plval == -1)		// out of bounds!
					return true;
	
				if (plval == trval && plval == 1)
				{
					iscol = true;
				}
				trace(y);
			}
			//string += "tetr : " + tetr + " tt : " + tt + " trval: " + trval + " plval: " + plval;

		}

		if (iscol)
		{
			// dump the contents
			//trace(string);
			return true;
		}
		return false;


	}

	function droptetro()
	{
		while(tetro.movedown())
		{
			if (collision(_playfield,tetro))
				return;
		}
	}


}
