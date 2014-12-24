import com.haxepunk.Entity;

class Tetromino
{

	private var _shape : Array<Array<Int>>;
	private var _type : Int;

	public function new()
	{
		_shape = new Array<Array<Int>>();
		init();
		//draw();
	}

	private function init()
	{
		var shape = Math.random()*6;
		_type = Std.int(shape);
		switch (shape)
		{
			case 0:
				_shape.push([0,0,0,0]);
				_shape.push([0,1,1,0]);
				_shape.push([0,1,1,0]);
				_shape.push([0,0,0,0]);
			case 1:
				_shape.push([0,1,0,0]);
				_shape.push([0,1,0,0]);
				_shape.push([0,1,1,0]);
				_shape.push([0,0,0,0]);
			case 2:
				_shape.push([0,1,0,0]);
				_shape.push([0,1,1,0]);
				_shape.push([0,0,1,0]);
				_shape.push([0,0,0,0]);
			case 3:
				_shape.push([0,1,0,0]);
				_shape.push([0,1,1,0]);
				_shape.push([0,1,0,0]);
				_shape.push([0,0,0,0]);
			case 4:
				_shape.push([0,1,0,0]);
				_shape.push([0,1,0,0]);
				_shape.push([0,1,0,0]);
				_shape.push([0,1,0,0]);
			case 5:
				_shape.push([0,0,1,0]);
				_shape.push([0,1,1,0]);
				_shape.push([0,1,0,0]);
				_shape.push([0,0,0,0]);

		}
	}

	public function rotate()
	{
		// check the direction
		
	}

	private function draw()
	{


		trace(["new tetromino"]);
		// draw the stuff

		for (i in 0...4)
		{
			var string :String = "";
			for (j in 0...4)
			{

				string += _shape[i][j];
			}
			trace([string]);
		}


		trace(["\n"]);
	}

	
}
