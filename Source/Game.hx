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
	private var gameSpeed :Float = 0.0;
	private var platform :Sprite;
	private var titleText : TextField;
	private var titleFormat : TextFormat;


	// only 6 figures

	public function new(_platform:Dynamic)
	{
		super();
		addListeners();
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
		}

		if (state == gameIntro)
		{
			// there should be no listeners here
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


}

