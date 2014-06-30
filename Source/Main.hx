package;

import openfl.Assets;
import openfl.media.Sound;
import openfl.display.Sprite;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;
import openfl.Lib;
import openfl.utils.Timer;
import openfl.display.Tilesheet;
import openfl.display.Stage;
import openfl.display.StageScaleMode;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.text.Font;


import SoundManager;

class Main extends Sprite 
{

	public var fullscr:Bool;

	var aheight : Int;
	var awidth : Int;
	public var font = Assets.getFont("assets/04B_03__.ttf");
	public var introtext = new TextField();


	public function new () 
	{
		super ();
		Lib.current.stage.color = 0x000000;
#if !android		
		Lib.current.stage.scaleMode = StageScaleMode.SHOW_ALL;
#end

		// how to add something?


		var textf = new TextFormat(font.fontName,10);
		textf.align = TextFormatAlign.LEFT;

		introtext.defaultTextFormat = textf;
		introtext.y = stage.stageHeight/2;
		introtext.x = stage.stageWidth/2;
		introtext.embedFonts = true;
		introtext.textColor=0xffffff;
		introtext.text = "jci gaems presents";
		addChild(introtext);
		haxe.Timer.delay(init,2000);	

	}

	public function init()
	{
		aheight = stage.stageHeight;
		awidth = stage.stageWidth;
		addListeners();
		introtext.text="testris";
		haxe.Timer.delay(cleartext,1500);
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
		
	//	flash.Lib.trace("is this on" + aheight + " " + awidth);
	}

	public function cleartext()
	{
		introtext.text="";
		introtext=null;

		var game = new Game();
		game.start();
	}
	
	
}
