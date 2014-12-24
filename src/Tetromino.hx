import com.haxepunk.Entity;

class Tetromino
{

	private var _shape : Array<Array<Int>>;
	private var _type : Int;
	private var _row : Int;
	private var _col : Int;

	public function new()
	{
		_shape = new Array();
		init();
		rotate();
	}

	private function init()
	{
		var shape = Math.random()*6;
		_type = Std.int(shape);
		switch (shape)
		{
			case 0:
				_shape.push([1,1]);
				_shape.push([1,1]);
			case 1:
				_shape.push([1,0]);
				_shape.push([1,0]);
				_shape.push([1,1]);
			case 2:
				_shape.push([1,0]);
				_shape.push([1,1]);
				_shape.push([0,1]);
			case 3:
				_shape.push([1,0]);
				_shape.push([1,1]);
				_shape.push([1,0]);
			case 4:
				_shape.push([1]);
				_shape.push([1]);
				_shape.push([1]);
				_shape.push([1]);
			case 5:
				_shape.push([0,1]);
				_shape.push([1,1]);
				_shape.push([1,0]);
		}
	}

	public function rotate()
	{
		// there should be a generic function 
		// but I am kinda in a hurry

		switch (_type)
		{
			case 1:
			case 2:
			case 3:
			case 4:
				draw();
				var length1 = _shape[0].length;
				trace(["length1 "+length1]);
				if (length1 == 1)
				{
					var temparr = new Array();
					temparr.push([1,1,1,1]);
					_shape = temparr;
				}
				else
				{
					var temparr = new Array<Array<Int>>();
					temparr.push([1]);
					temparr.push([1]);
					temparr.push([1]);
					temparr.push([1]);

					_shape = temparr;
				}
				draw();
			case 5:

		}
		draw();
		
	}

	private function draw()
	{

		trace(["Calling draw"]);
		for (i in 0..._shape.length  )
		{
			var string : String = "";
			for (j in 0..._shape[i].length)
			{
				string += "" + _shape[i][j];


			}

				trace(["" + string]);
		}

	}

	
}
