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
		Input.define("rotate", [Key.R]);
		Input.define("newtetro", [Key.N]);
		Input.define("quitgame", [Key.Q]);
		Input.define("pause", [Key.P]);

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

			renderPlayfield(tetro);	

			_clocktick += _clocktickamount;
			_spawntick += _clocktickamount;

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


			if (Input.pressed ("right"))
			{
				tetro.moveright();
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

			if (Input.pressed("newtetro"))
			{
				_gamestate = SPAWNTETRO;
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




	}

	private function renderPlayfield(tetro: Tetromino)
	{
		_playfield.drawplayfield(tetro);

		// here we should detect where's the tetro

		if (collision(_playfield, tetro))
		{
			trace("collision");
			_playfield.addtetro(tetro);
			_gamestate = SPAWNTETRO;
		}
	}

	private function collision(playfield : Playfield, tetro : Tetromino)
	{
		var tetr = tetro.getrow()+tetro.getheight();
		var tetc = tetro.getcol();

		//trace("tetr " + tetr + " " + "tetc : " + tetc + "  " + playfield.getvalue(tetr,tetc));
	
		var string :String = "";
		var iscol = false;

		for (i in 0...tetro.getwidth())
		{
			var tt = tetc + i;
			//trace("tt : " + tt);
			var th = tetro.getheight();
			var tettr = tetr-1;
			var plval = playfield.getvalue(tetr,tt);
			var trval = tetro.getvalue(tetro.getheight()-1, i);
			if (plval ==1 || plval == -1)			
			{
				trace("tettr " + tetr + " tt " + tt + " value " + plval + " tetro " + trval);
				iscol = true;
			}
			if (plval == trval && trval == 1)
			{

			}

		}

		///
		for (ccol in tetc...tetc + tetro.getwidth())
		{
		//	trace("lol");
			var tetr1 = tetr ;
			var plvalue = playfield.getvalue(tetr1,ccol);
			if (plvalue == -1)
				return true;
			if (plvalue == 1)
			{
			}
		
			string+= "row : " + tetr1 + " ccol : " + ccol + "  value : " + plvalue + "  -- ";	
		}

		//trace(string);

		return false;

	}


}
