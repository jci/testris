package;

import openfl.Assets;
import openfl.media.Sound;
import openfl.media.SoundTransform;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Lib;
import openfl.events.KeyboardEvent;
import openfl.events.Event;
import SoundManager;
import openfl.ui.Keyboard;

enum GameState 
{
		gameInit;
		gameIntro;
		gamePlaying;
		gamePaused;
		gameOver;
}





class Game
{
	// main game class


	private var state : GameState = gameInit;

	// only 6 figures

	public function new()
	{
		if (state == gameInit)
		{
			addListeners();
		}
	}

	public function init()
	{
	}

	public function update()
	{
		if (state == gamePaused)
		{
		}
		else
		{
			if (state == gamePlaying)
			{
				// playing the game
			}

			if (state == gameIntro)
			{
				// there should be no listeners here
			}
		}
	}

	public function destroy()
	{
	}

	public function addListeners()
	{
		
	}

	public function onKeyPressed(event:KeyboardEvent)
	{
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
		SoundManager.getInstance().loadMusic("assets/tetris.ogg");
		SoundManager.getInstance().playMusic();
	}

	
	public function start()
	{
		haxe.Timer.delay(startmusic,200); 
	}


	public function initMatrix(rows:Int, cols:Int, value:Int=0)
	{
		var t1 : Int=0;
		var t2 : Int=0;
		var t3 =  new Array<Array<Int>>();

		for (t1 in 0...rows)
			for (t2 in 0...cols)
				t3[t1][t2] = value;
		return t3;

	}
}

