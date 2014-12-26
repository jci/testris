import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;
import com.haxepunk.graphics.Animation;
import com.haxepunk.HXP;

class Tetrodemo extends Entity
{

	private var speed  : Float;
	private var selected : Bool;
	private var newimage : Image;
	private var rotangle : Float;
	private var direction : Int;

	public override function new()
	{
		super();
		init();

	

	}



	private function init()
	{
		var sp = Std.int(Math.random()*6);

		switch (sp)
		{
			case 0:
				speed = 0.15;
			case 1:
				speed = 0.3;
			case 2:
				speed = 0.5;
			case 3:
				speed = 1.5;
			case 4:
				speed = 3.5;
			case 5:
				speed = 5;

		}

		speed += Math.random()*1.2;
	

		var randtype = Std.int(Math.random() * 7 + 11);
		var randlayer = Std.int(Math.random() * 5 + 10);
		var randrot = Std.int(Math.random() * 4);

		x = Math.random() * 700;
		y = -120 - Math.random()*400;

		var string = "graphics/" + randtype + ".png";
		newimage = new Image(string);
		newimage.centerOrigin();
		newimage.scale *= speed/3.5;
		graphic=newimage;
		layer = Std.int(10-speed);
		rotangle = 0;

		


		switch (randrot)
		{
			case 0:
				newimage.angle = 90;
			case 1:
				newimage.angle = 180;
			case 2:
				newimage.angle = 270;
			case 3:
				newimage.angle = Math.random()*360;
		}

		var selected1 = Std.int(Math.random()*3);
		var selected2 = Std.int(Math.random()*3);

		if (selected1 == selected2)
		{
			// the rotation must go!
			selected = true;
			rotangle = Math.random()*0.8;
			direction = Std.int(Math.random()*2);
		}





	}

	public override function update()
	{
		super.update();

		y+= speed/2;
		if (y > HXP.height + 100)
		{
			init();
		}


	}
}
