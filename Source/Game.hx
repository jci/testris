package;

import openfl.Assets;
import openfl.media.Sound;
import openfl.media.SoundTransform;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Lib;
import openfl.events.KeyboardEvent;
import openfl.events.Event;
import openfl.events.EventDispatcher;
import openfl.events.EventPhase;
import SoundManager;
import Tetromino;
import openfl.ui.Keyboard;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.display.Stage;
import openfl.events.MouseEvent;
import openfl.events.TouchEvent;
import openfl.events.AccelerometerEvent;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.Tilesheet;

enum GameState 
{
		gameInit;         	// entering game
		gameIntro;			// showing the intro name 
		gamePlaying;		// real game
		gamePaused;			// game paused
		gameOver;			// game over man
}


class Game extends Sprite
{
	// main game class


	private var state : GameState = gameInit;
	private var gamestage = Lib.current.stage;
	private var gamespeed :Int;
	private var platform :Sprite;
	private var titleText : TextField;
	private var titleFormat : TextFormat;
	private var gamecounter : Int;

	private var gamefield : Array<Array<Cell>> = new Array();
	private var gameTetro : Bool;

	private var playfield : BitmapData;
	private var playblock : BitmapData;
	private var textblock : BitmapData;
	private var tileblock : Tilesheet;


	private var playbutton : Bitmap;

	private static inline var EMPTY_CELL=0;


	// only 6 figures

	public function new(_platform:Dynamic)
	{
		super();
		addListeners();

		gamecounter = 0;
		gamespeed = 200;
		gameTetro = false;



	}

	public function initgame(event:Event)
	{
		//addChild(new Bitmap(Assets.getBitmapData("assets/block.png",false)));
		// adding the rest of the resources
	
		playblock = new BitmapData(stage.stageWidth,stage.stageHeight,true,0x5a5a5a);
		addChild(new Bitmap(playblock));

		textblock = new BitmapData(stage.stageWidth,stage.stageHeight,true,0xfafafa);
		addChild(new Bitmap(textblock));

		tileblock = new Tilesheet(Assets.getBitmapData("assets/block.png",false));	

		playbutton = new Bitmap(Assets.getBitmapData("assets/play.png"));
		playbutton.x = stage.stageWidth/2 - playbutton.get_width()/2;
		playbutton.y = stage.stageHeight/2 - playbutton.get_height()/2;
		addChild(playbutton);
		start();
	}

	public  function update(event:Event)
	{
		if (state == gamePaused)
		{

		}

		if (state == gamePlaying)
		{
			playbutton.visible = false;


			gamecounter++;

			if (gamecounter > gamespeed)
			{
				gamecounter = 0;
#if debug
				if (!gameTetro)
				{
					trace("spawn tetromino");
					var newtetro = new Tetromino();
					gameTetro = true;
				}
#end

			}
	


			drawfield();

		}

		if (state == gameIntro)
		{
			playbutton.visible = true;

		}

	}


	public function addListeners()
	{

		// this
		this.addEventListener(Event.ADDED_TO_STAGE,initgame);
		this.addEventListener(Event.ENTER_FRAME, update);

		// stage 
		gamestage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyPressed);		
		gamestage.addEventListener(MouseEvent.CLICK,onMouseEvent);
		gamestage.addEventListener(TouchEvent.TOUCH_TAP,onTouchEvent);
	}

	public function onTouchEvent(event:Event)
	{

#if debug		
		trace("onTouchEvent");
#end

		if (state == gamePlaying)
		{
		}

		
	}

	public function onMouseEvent(event:MouseEvent)
	{

#if debug		
		trace("onMouseEvent");
#end 

		if (state == gameInit || state == gameIntro)
		{	
			var xpos = event.stageX;
			var ypos = event.stageY;

			if ( xpos > stage.stageWidth/2 - 50 && xpos < stage.stageWidth/2 + 50 && ypos > stage.stageHeight/2 - 50 && ypos < stage.stageHeight/2 + 50)
			{
				startgame();
			}
		}

	}

	public function onKeyPressed(event:KeyboardEvent)
	{

#if debug
		trace("onKeyPressed");
#end

		if ( state == gamePlaying)
		{
			// obey orders only when playing
			switch(event.keyCode)
			{
				case Keyboard.A:
					{
						state = gamePaused;
#if debug						
						trace("gamepaused");
#end
					}
				case Keyboard.LEFT:
					{
#if debug
						trace("move tetromino left");
#end

					}

				case Keyboard.RIGHT:
					{
#if debug						
						trace("move tetromino right");
#end						
					}

				case Keyboard.UP:
					{
#if debug
						trace("rotate tetromino");
						// should I do cw or ccw? :B
#end

					}
				case Keyboard.DOWN:
					{
#if debug
						// shhh...no tears, only dreams
						// that's due to the amount of if debug
						trace("drop tetromino");
#end

					}
			}
		}

	}


	public function startmusic()
	{

		SoundManager.getInstance().stopMusic();

		if (state == gameInit)
		{

			SoundManager.getInstance().loadMusic("assets/koro.ogg");
			SoundManager.getInstance().playMusic();
		}

		if (state == gamePlaying)
		{
			SoundManager.getInstance().loadMusic("assets/ozma-koro.ogg");
			SoundManager.getInstance().playMusic();
		}
	}

	
	public function start()
	{
		if (state == gameInit)
		{
			haxe.Timer.delay(startmusic,200); 
		}
		cleangamefield();
	
		
	}
	

	public function startgame()
	{
		state = gamePlaying;

		#if debug
		trace("start game");
		#end
		startmusic();

	}

	
	public function drawfield()
	{

	}

	public function cleangamefield()
	{
		// this is according to wikipedia

		var xr:Int = 0;
		var yc:Int = 0;

		for (yc in 0...20)
		{
			gamefield.push(new Array());
			for (xr in 0...10)
			{
				gamefield[yc][xr] = Cell.cell_empty;

			}
		}

	}

}

