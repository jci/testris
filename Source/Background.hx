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

		this.addEventListener(Event.ENTER_FRAME,update);
		haxe.Timer.delay(spawn,100);
	}


	private function addListeners()
	{
		// all listeners go here
		this.addEventListener(Event.ADDED_TO_STAGE,init);
	}


	public function update(event:Event)
	{
			
	}
	
	private function introfig()
	{

	}

	// this is the most horrid hack I've even done ... :(

	function spawn()
	{	
		counter++;
		if(counter<100)
		{
			addChild(new IntroTet());
			haxe.Timer.delay(spawn,100);
			trace("spawn : " + counter);
		}
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

	private var fallspeed :Float;
	private var bitmap : Bitmap;
	private var rotationspeed : Float;
	private var rotater : Bool;
	

	public function new()
	{
		super();
		addEventListener(Event.ADDED_TO_STAGE,init);
	}

	public function init(event:Event)
	{
		addEventListener(Event.ENTER_FRAME,update);

		//taddChild(Assets.getBitmapData("assets/14.png",false));
		var string = "assets/1" + (Std.random(7)+1) + ".png";
		bitmap = new Bitmap(Assets.getBitmapData(string));
		addChild(bitmap);
		randomize();
	}

	private function randomize()
	{

		y = -90;
		x = Std.random(480);

	
		var string = "assets/1" + (Std.random(7)+1) + ".png";
		bitmap = new Bitmap(Assets.getBitmapData(string));

		var sorter = Std.random(5);
		switch(sorter)
		{
			case 0:
				{
					// farthest
					fallspeed=0.4;
					scaleX=0.3;
					scaleY=0.3;
				}
			case 1:
				{
					fallspeed=0.7;
					scaleX=0.6;
					scaleY=0.6;
				}
			case 2:
				{
					// closest
					fallspeed=1;
				}
			case 3:
				{
					fallspeed=1.5;
					scaleX=1.2;
					scaleY=1.2;
					y=-200;
				}
			case 4:
				{
					fallspeed=2.5;
					scaleX=1.5;
					scaleY=1.5;
					y=-300;
				}
		}

		var sorter = Std.random(4)*90;
		rotation = sorter;
		
		
	}

	public function update(event:Event)
	{
		y+=fallspeed;
		if (y > 480)
		{
			y=-90;
			randomize();
		}
		

		
	}

	public function destroy()
	{
		
		removeEventListener(Event.ENTER_FRAME,update);
		removeEventListener(Event.ADDED_TO_STAGE,init);
		bitmap = null;
		this.parent.removeChild(this);
			
	}

}
