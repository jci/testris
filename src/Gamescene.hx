import com.haxepunk.Scene;
import com.haxepunk.utils.Input;
import com.haxepunk.utils.Gesture;
import com.haxepunk.utils.Key;
import com.haxepunk.Sfx;
import com.haxepunk.HXP;
import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.utils.Touch;

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
	private static var _maxspeed : Float = 30;
	private var tetro : Tetromino;
	private var nexttetro : Tetromino;
	private var score : Int = 0;
	private var music : Sfx;

	public var twidth : Float;
	public var theight : Float;

	private var nexttetroent : Array<Entity>;
	private var mygesture : GestureType;
	
	public override function new()
	{
		super();
		Input.define("right", [Key.E, Key.RIGHT]);
		Input.define("down", [Key.D, Key.DOWN]);
		Input.define("left", [Key.W, Key.LEFT]);
		Input.define("rotate", [Key.R,Key.UP]);
		Input.define("newtetro", [Key.N]);
		Input.define("quitgame", [Key.Q]);
		Input.define("pause", [Key.P]);
		Input.define("drop", [Key.SPACE]);

#if flash
		music = new Sfx("audio/ozma-koro.mp3");
#else
		music = new Sfx("audio/ozma-koro.ogg");
#end

		twidth = HXP.width/2;
		theight = HXP.height/2;

		nexttetroent = new Array<Entity>();

		createnexttetro();



	}

	public override function begin()
	{

		_playfield = new Playfield();
		_clocktick = 0;
		_clocktickamount = 1;
		addList(_playfield.battlefield);

		_gamestate = SPAWNTETRO;
		score = 0;
		music.play();
		// 
		nexttetro = new Tetromino();
		rendernexttetro(nexttetro);



	}

	public override function update()
	{


		if (Input.multiTouchSupported) 	
		{
			Input.touchPoints(onTouch);
		}
		else
		{
			trace("not multitouch!");
		}



		super.update();

		if (_gamestate == SPAWNTETRO)
		{

			trace("Next tetro is " + nexttetro.gettype());
			tetro = nexttetro;
			nexttetro = new Tetromino();
			trace("Next tetro is " + nexttetro.gettype());
			rendernexttetro(nexttetro);
			_gamestate = PLAYLOOP;

			return;

		}

		if (_gamestate == PLAYLOOP)
		{
			if (!music.playing)
			{
				music.play();
			}

			_clocktick += _clocktickamount;

			if (_clocktick > _maxspeed)
			{
				tetro.movedown();
				_clocktick = 0;
			}


			if (Input.pressed ("right"))
			{
				tetro.moveright();
			}

			if (Input.pressed("drop"))
			{
				droptetro();
			}

			if (Input.pressed(Key.LEFT))
			{
				tetro.moveleft();
			}

			if (Input.pressed (Key.DOWN))
			{
				tetro.movedown();
				return;
			}


			if (Input.pressed("rotate"))
			{
				tetro.rotate();
			}

			if (Input.pressed("quitgame"))
			{
#if desktop
				Sys.exit(0);
#end
			}


			renderPlayfield(tetro);	


			//
			//experimental gesture type
			mygesture = new GestureType();

			if (Gesture.check(Gesture.MOVE))
			{
				trace("this is a gesture");
			}





		}

		if (_gamestate == GAMEOVER)
		{
			music.stop();
			if (Input.pressed("newtetro"))
			{
				begin();
			}
		}


		if (Input.pressed(Key.P))
		{
			if (_gamestate == PLAYLOOP)
			{
				_gamestate = GAMEPAUSE;
				music.stop();
				var newsfx = new Sfx("audio/test2.ogg");
				newsfx.play();
				return;
			}

			if (_gamestate == GAMEPAUSE)
			{
				_gamestate = PLAYLOOP;
				music.resume();
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
			_playfield.addtetro(tetro);
			checkforlines(_playfield);
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
			}

		}

		if (iscol)
		{
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

	function checkforlines(playfield : Playfield)
	{
		var lines = playfield.checkforlines();
		if (lines!=0)
		{
			// yes, I know...
			trace("Lines " + lines);
			playfield.clearlines();
			score += lines;
			trace("Score : " + score);
			_playfield.drawplayfield(tetro);

			//
#if flash
			var mysfx = new Sfx("audio/test2.mp3");
#else
			var mysfx = new Sfx("audio/test2.ogg");
#end
			mysfx.play();

			
		}
	}

	private function createnexttetro()
	{
		//
		for (i in 0...16)
		{
			var entity = new Entity();
			var witd = new Image("graphics/blank.png");
			entity.graphic = witd;
			entity.x = 400 + i*witd.width;
			entity.y = 10;
			entity.visible = false;
			entity.type = "blank";
			nexttetroent.push(entity);
		}
		addList(nexttetroent);
	}

	private function rendernexttetro(tetro : Tetromino)
	{
		// first, let's get all to "blank"

		for (i in 0...nexttetroent.length)
		{
			var entt = nexttetroent[i];
			entt.type="blank";
		}

		// now the type

		var howpaint = new Array<Array<Int>>();
		switch(tetro.gettype())
		{
			case 0:
				// square
				howpaint=[[0],[0],[0],[0],
						  [0],[1],[1],[0],
						  [0],[1],[1],[0],
						  [0],[0],[0],[0]];
				
			case 1:
				howpaint=[[0],[1],[0],[0],
						  [0],[1],[0],[0],
						  [0],[1],[1],[0],
						  [0],[0],[0],[0]];


			case 2:
				howpaint=[[0],[1],[0],[0],
						  [0],[1],[0],[0],
						  [0],[1],[1],[0],
						  [0],[0],[0],[0]];


			case 3:		
				howpaint=[[0],[1],[0],[0],
						  [0],[1],[1],[0],
						  [0],[1],[0],[0],
						  [0],[0],[0],[0]];

			case 4:
				howpaint=[[0],[1],[0],[0],
						  [0],[1],[0],[0],
						  [0],[1],[0],[0],
						  [0],[1],[0],[0]];


			case 5:
				howpaint=[[0],[0],[1],[0],
						  [0],[1],[1],[0],
						  [0],[1],[0],[0],
						  [0],[0],[0],[0]];


			case 6:
				howpaint=[[0],[0],[1],[0],
						  [0],[0],[1],[0],
						  [0],[1],[1],[0],
						  [0],[0],[0],[0]];

		}

		trace(howpaint.length);

	}

	private function onTouch( touch : Touch)
	{


		var touched : Bool = false;
		var touch1 : Float = 0;
		

			if(touch.pressed && !touched)
			{
				touch1 = touch.x;
				touched = true;
			}

			trace(diference(touch1,touch.x));

			if ( diference(touch1, touch.x) > (HXP.width / 12) && touched && touch1 > touch.x ) {
				trace("left");
				touched = false;
			}
			if ( diference(touch1, touch.x) > (HXP.width / 12) && touched && touch1 < touch.x ) {
				trace("right");
				touched = false;
			}

	}

	private function diference(val1:Float, val2: Float)
	{
		return Math.abs(val1-val2);
	}



}
