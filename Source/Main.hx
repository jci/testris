package;

import openfl.Assets;
import openfl.media.Sound;
import openfl.display.Sprite;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;
import openfl.Lib;
import openfl.utils.Timer;
import openfl.display.Tilesheet;
import openfl.display.Sprite;


import SoundManager;

class Main extends Sprite 
{

	public var fullscr:Bool;

	var aheight : Int;
	var awidth : Int;
	
	public function new () 
	{
		super ();
		haxe.Timer.delay(init,1000);	

	}

	public function init()
	{
		// now, prepare the screen

		var game = new Game();

		aheight = stage.stageHeight;
		awidth = stage.stageWidth;


		addListeners();

		SoundManager.getInstance().loadMusic("assets/tetris.ogg");
		SoundManager.getInstance().playMusic();

	}

	function createScene()
	{

	}

	function mainLoop()
	{
	}

	function addListeners()
	{
		stage.addEventListener(KeyboardEvent.KEY_DOWN,onKeyPressed);
	}

	function onKeyPressed(event:KeyboardEvent)
	{





		switch (event.keyCode)
		{
			case Keyboard.DOWN:
				SoundManager.getInstance().volumeDown(0.1);
			case Keyboard.UP:
				SoundManager.getInstance().volumeUp(0.1);
			case Keyboard.M:
				SoundManager.getInstance().mute();
			case Keyboard.Q:
				{
					SoundManager.getInstance().stopMusic();
					Lib.exit();
				}

		}

		
		flash.Lib.trace("is this on" + aheight + " " + awidth);
	}
	
	
}
