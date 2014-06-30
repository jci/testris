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


enum GameState 
{
		gameInit;
		gameIntro;
		gamePlaying;
		gamePaused;
		gameOver;
}


class Game extends Sprite
{
	// main game class


	private var state : GameState = gameInit;
	private var gamestage = Lib.current.stage;
	private var gameSpeed :Float = 0.0;
	private var platform :Sprite;
	private var titletext : TextField;


	// only 6 figures

	public override function new(_platform:Dynamic)
	{
		super();
		platform = _platform;

		this.addEventListener(Event.ADDED_TO_STAGE,initgame);
	}

	public function initgame(event:Event)
	{
		Lib.trace("Here I am, on init");
		start();

		// this is the most gruesome hack I've seen lately
		// thanks, gamedev.cs.washington.edu :D
		stage.addEventListener(Event.ENTER_FRAME,
				function(e:Event)
				{
					update();
				});
	}

	public  function update()
	{
		if (state == gamePaused)
		{
		}
		if (state == gamePlaying)
		{
			// playing the game
		}

		if (state == gameIntro)
		{
			// there should be no listeners here
		}
	}

	public function destroy()
	{
	}

	public function addListeners()
	{
		
		Lib.trace("Here I am, on addeventlistener");
		gamestage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyPressed);		
	}

	public function onKeyPressed(event:KeyboardEvent)
	{

		Lib.trace("Here I am, on onkeypressed");

		if ( state == gamePlaying)
		{
			// obey orders only when playing
			switch(event.keyCode)
			{
				case Keyboard.A:
					state = gamePaused;
			}
		}
	}


	public function startmusic()
	{
		if (state == gameInit)
		{
			SoundManager.getInstance().loadMusic("assets/koro.ogg");
			SoundManager.getInstance().playMusic();
		}

		if (state == gamePlaying)
		{
			// diferrent music! :D
			SoundManager.getInstance().loadMusic("assets/tetris.ogg");
			SoundManager.getInstance().playMusic();
		}
	}

	
	public function start()
	{
		if (state == gameInit)
		{
			haxe.Timer.delay(startmusic,200); 
		}

		var myvar : Int;


	}


}

