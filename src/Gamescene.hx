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

enum Buttons {
	BUTTONNONE;
	BUTTONLEFT;
	BUTTONRIGHT;
	BUTTONROTATELEFT;
	BUTTONROTATERIGHT;
	BUTTONDOWN;
	BUTTONSINK;
	BUTTONPAUSE;
	BUTTONQUIT;
	BUTTONMUTE;
	BUTTONNEWGAEM; //yeah, it's a NEWGAEM!
}

/*

   TODO : 

   - Move all the code from the other classes here.
   - Yes, it's a pain, but it is how it should be handled as
   	a) rotation of tetro needs to check collision and cannot be checked inside the tetro code
			//
			// fixed by checking the bounds of the tetro:D
			//

	b) collision needs to be checked inside the scene and not on the playfield (or can it?)

	c) draw next tetromino. 
	
			//
			// Solution was kinda simple : spawn 2 tetros instead of one 
			// and using just one on the playfield. I could not be happier :D
			//

   */
class Gamescene extends Scene
{


	private var _playfield  : Playfield;
	private var _gamestate : GameLoop;
	private var _clocktick : Float;
	private var _clocktickamount : Float;
	private var _spawntick : Float;
	private static var _maxspeed : Float = 40;
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
	}

	private function init()
	{

#if flash
		music = new Sfx("audio/ozma-koro.mp3");
#else
		music = new Sfx("audio/ozma-koro.ogg");
#end

		twidth = HXP.width/2;
		theight = HXP.height/2;

		nexttetroent = new Array<Entity>();

		createnexttetro();


		// creating the overlay

		var myimage = new Image("graphics/overlay.png");
		myimage.x=0;
		myimage.y=0;
		myimage.alpha = 0.5;
		var myoverlayentity = new Entity();
		myoverlayentity.layer = 10;
		myoverlayentity.addGraphic(myimage);
		this.add(myoverlayentity);

		_playfield = new Playfield();
		_clocktick = 0;
		_clocktickamount = 1;
		addList(_playfield.battlefield);

		_gamestate = SPAWNTETRO;
		score = 0;
		music.play();

		nexttetro = new Tetromino();
		rendernexttetro(nexttetro);
		Gesture.enable();



	}

	public override function begin()
	{
		init();
	}

	public override function update()
	{
		super.update();



		if (_gamestate == SPAWNTETRO)
		{
			spawntetro();
			return;
		}

		if (_gamestate == PLAYLOOP)
		{

			renderPlayfield(tetro);	
			processinput();
		}
		

		if (_gamestate == GAMEOVER)
		{
			music.stop();
			var gesture =  BUTTONNONE;

			if (Input.mousePressed)
			{
				gesture = checkgesture();
			}

			if (Input.pressed("newtetro") || gesture == BUTTONNEWGAEM)
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

		//trace(howpaint.length);

	}


	private function dogesture(gesture : GestureType)
	{
		var startx = gesture.x;
		var endx = gesture.x2;

		if (startx>HXP.halfHeight && startx < HXP.halfHeight + 200)
		{
			if (endx<startx && startx-endx > 30)
			{
				tetro.moveleft();
				return;
			}

			if (endx>startx && endx-startx > 30)
			{
				tetro.moveright();
				return;
			}



		}

	}

	private function checkgesture(gesture :GestureType = null) : Buttons
	{
		// mouseinput
		if (Input.mouseX > 40 && Input.mouseX < 130 && Input.mouseY > 180 && Input.mouseY<260)
			return BUTTONLEFT;

		if (Input.mouseX > 580 && Input.mouseX < 670 && Input.mouseY > 180 && Input.mouseY<260)
			return BUTTONRIGHT;

		if (Input.mouseX > 170 && Input.mouseX < 250 && Input.mouseY > 180 && Input.mouseY< 260)
			return BUTTONROTATELEFT;

		if (Input.mouseX > 460 && Input.mouseX < 550 && Input.mouseY > 180 && Input.mouseY < 260)
			return BUTTONROTATERIGHT;

		if (Input.mouseX > 315 && Input.mouseX < 405 && Input.mouseY > 410 && Input.mouseY < 500)
			return BUTTONSINK;

		if (Input.mouseX > 40 && Input.mouseX < 130 && Input.mouseY > 340 && Input.mouseY < 430)
			return BUTTONDOWN;

		if (Input.mouseX > 580 && Input.mouseX < 670 && Input.mouseY > 340 && Input.mouseY < 430)
			return BUTTONDOWN;

		if (Input.mouseX > 280 && Input.mouseX < 430 && Input.mouseY > 100 && Input.mouseY < 400)
			return BUTTONNEWGAEM;

		return BUTTONNONE;
	}

	private function spawntetro()
	{
			tetro = nexttetro;
			nexttetro = new Tetromino();
			rendernexttetro(nexttetro);
			_gamestate = PLAYLOOP;
	}

	private function processinput()
	{
		var gesture1 = BUTTONNONE;
		var mousegesture1 = BUTTONNONE;

		if (Input.mousePressed)
		{
			gesture1 = checkgesture();
		}


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


		if (Input.pressed (Key.RIGHT) || gesture1 == BUTTONRIGHT)
		{
			tetro.moveright();
			return;
		}

		if (Input.pressed(Key.SPACE) || gesture1 == BUTTONSINK)
		{
			droptetro();
		}

		if (Input.pressed(Key.LEFT) || gesture1 == BUTTONLEFT)
		{
			tetro.moveleft();
			return;
		}

		if (Input.pressed (Key.DOWN) || gesture1 == BUTTONDOWN)
		{
			tetro.movedown();
			return;
		}


		if (Input.pressed(Key.UP) || gesture1 == BUTTONROTATELEFT)
		{
			tetro.rotate();
			return;
		}

		if (gesture1 == BUTTONROTATERIGHT)
		{
			// :D
			tetro.rotate();
			tetro.rotate();
			tetro.rotate();
		}

		if (Input.pressed("quitgame"))
		{
#if desktop
			Sys.exit(0);
#end
		}




	}

}
