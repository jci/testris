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
		rotate();
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
		var temparray = new Array<Array<Int>>();
		for (cle in 0..._shape[0].length)
		{
			temparray[cle] = new Array<Int>();
		}

		var ver = _shape.length;
		var hor = _shape[0].length;

		for (i in 0...ver)
		{
			for (j in 0...hor)
			{
				temparray[j][ver-i-1] = _shape[i][j];
			}
		}

		_shape = temparray;
	}

	private function draw( )
	{

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

