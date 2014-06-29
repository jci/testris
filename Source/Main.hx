package;

import openfl.Assets;
import openfl.media.Sound;
import openfl.display.Sprite;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;
import openfl.Lib;

import SoundManager;

class Main extends Sprite 
{
	
	
	public function new () 
	{
		super ();

		SoundManager.getInstance().loadMusic("assets/tetris.ogg");
		SoundManager.getInstance().playMusic();

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
	}
	
	
}
