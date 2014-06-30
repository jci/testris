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
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.display.StageAlign;
import flash.Lib.current;
import openfl.events.Event;

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
		resize(null);
	
		// how to add something?


		var textf = new TextFormat(font.fontName,10);
		textf.align = TextFormatAlign.LEFT;

		var blackbackground = new BitmapData(stage.stageWidth, stage.stageHeight,true,0x000000);
		addChild(new Bitmap(blackbackground));

		introtext.defaultTextFormat = textf;
		introtext.y = stage.stageHeight/2;
		introtext.x = stage.stageWidth/2;
		introtext.embedFonts = true;
		introtext.textColor=0xffffff;
		introtext.text = "jci gaems presents";

		addChild(introtext);


		//addChild(new Bitmap(Assets.getBitmapData("assets/play.png",false)));	

		haxe.Timer.delay(init,2000);	

	}

	public function init()
	{

		current.stage.align = StageAlign.TOP_LEFT;
		current.stage.scaleMode = StageScaleMode.NO_SCALE;

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
			case Keyboard.Q:
				{
					SoundManager.getInstance().stopMusic();
					Lib.exit();
				}
		}
		
	}

	public function cleartext()
	{
		introtext.text="";
		introtext=null;

		var game = new Game(this);
		stage.addChild(game);
	}

	private function resize(event:Event):Void
    {
        var sx:Float = this.stage.stageWidth / 480;
        var sy:Float = this.stage.stageHeight / 320;
        if (sx > sy)
        {
            this.scaleX = this.scaleY = sy;
            this.x = (this.stage.stageWidth - sy * 480) / 2;
        }
        else
        {
            this.scaleX = this.scaleY = sx;
        }
	}


	
}
