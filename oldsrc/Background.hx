package;

import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.Lib;
import openfl.events.Event;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.Assets;


import Game;


class Background extends Sprite
{
	// the falling blocks of the intro :D

	private var myparent : Game = null;
	public var stemp : Int; 
	public var gamestate : GameState = null;
	private var counter : Int;

	public function new(_parent:Dynamic)
	{
		super();
		myparent = _parent;
		addListeners();
		counter = 0;
	}

	public function init(event:Event)
	{

		/*
		switch(myparent.getGameState())
		{
			case gameInit:
				trace("init");
			case gamePlaying:
				trace("playing");
			case gameIntro:
			case gamePaused:
			case gameOver:
				trace("overhaul!");
		}
		*/

		this.addEventListener(Event.ENTER_FRAME,update);
		introfig();

		haxe.Timer.delay(spawn,100);
	}


	private function addListeners()
	{
		// all listeners go here
		this.addEventListener(Event.ADDED_TO_STAGE,init);
		this.addEventListener(Event.REMOVED_FROM_STAGE,destroy);
	}


	public function update(event:Event)
	{
			
	}
	
	private function introfig()
	{

	}

	function spawn()
	{
			var introTet = new IntroTet();
			addChild(introTet);
#if debug			
			trace("rise, my child" + counter);
#end
			haxe.Timer.delay(spawn,300);
	}

	private function destroy(event:Event)
	{
#if debug		
		trace("i no longer live");
#end
	}

}

class IntroTet extends Sprite
{

	private var fallspeed :Int;
	private var bitmap : Bitmap;


	public function new()
	{
		super();
		addEventListener(Event.ADDED_TO_STAGE,init);
	}

	public function init(event:Event)
	{
		addEventListener(Event.ENTER_FRAME,update);

		fallspeed = Std.random(5)+1;
		//taddChild(Assets.getBitmapData("assets/14.png",false));
		var string = "assets/1" + (Std.random(7)+1) + ".png";
		bitmap = new Bitmap(Assets.getBitmapData(string));

		y = -90;
		x = Std.random(stage.stageWidth);
		scaleX = Math.random()+0.1;
		scaleY = scaleX;
		alpha = Math.random();
		rotation = Std.random(180);
		addChild(bitmap);
		
		
	}

	public function update(event:Event)
	{
		y+=fallspeed;
		if (y > 320)
			destroy();
	}

	public function destroy()
	{
		removeChild(this);
	}

}
