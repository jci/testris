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


	// only 6 figures

	public function new(_platform:Dynamic)
	{
		super();
		addListeners();

		gamecounter = 0;
		gamespeed = 200;


		
		cleangamefield();

	}

	public function initgame(event:Event)
	{
		Lib.trace("Here I am, on init");
		start();
	}

	public  function update(event:Event)
	{
		if (state == gamePaused)
		{
		}

		if (state == gamePlaying)
		{
			// main game loop

			gamecounter++;
			if (gamecounter > gamespeed)
			{
				gamespeed = 0;
#if debug
				trace("spawn tetromino");
#end

			}
		
			drawfield();

		}

		if (state == gameIntro)
		{

		}

		//	trace("on update");
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
#if debug
		trace("drawing the playfield");
#end

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
				gamefield[yc][xr] = EMPTY_CELL;

			}
		}

	}

}

