import com.haxepunk.Entity;
import com.haxepunk.graphics.Image;

class Tetromino
{

	private var _shape : Array<Array<Int>>;
	private var _type : Int;
	private var _row : Int;
	private var _col : Int;

	private static var MAX_SHAPES = 7;


	public function new()
	{

		init();
	}

	private function init()
	{

		_shape = new Array();
		var shape = Math.random()*MAX_SHAPES;
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
			case 6:
				_shape.push([0,1]);
				_shape.push([0,1]);
				_shape.push([1,1]);

		}

		_row = 0;
		_col = 0;

		if (getwidth()==1)
		{
			_col=5;
		}
		else
		{
		var g = cast(getwidth()/2, Int);
		_col = 5 - g;
		}



	}

	public function rotate()
	{

		// first, let's check if the rotation is possible

		var hei = getwidth();

		if (hei + _row >= 20)
		{
			return;
		}
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
//		trace(_col + getwidth());
		if (_col + getwidth() > 10)
		{
			trace("tetro out of bounds!");
			_col--;
		}

	}

	public  function draw( )
	{

		for (i in 0..._shape.length  )
		{
			var string : String = "";
			for (j in 0..._shape[i].length)
			{
				string += "" + _shape[i][j];
			}

			//trace(["" + string]);
		}

	}

	public function movedown()
	{
		if ((_row + getheight()) >=20) 	return false;
		_row++;
		return true;
	}

	public function getrow()
	{
		return _row;
	}

	public function getcol()
	{
		return _col;
	}

	public function getwidth()
	{

#if html5
		// really?! 

		var valor : Int = 0;
		for (i in 0..._shape.length)
		{
			for (j in 0..._shape[i].length)
			{
				if (j==0)
				{
					valor = _shape[i].length;

				}
			}
		}
		//

		return valor;
#else
		return _shape[0].length;
#end	
			
	}

	public function getheight()
	{
		return _shape.length;
	}

	public function getshape()
	{
		return _shape;
	}

	public function moveleft()
	{
		if (_col<=0)
		{
			return false;
		}
		_col--;
		return true;
	}

	public function moveright()
	{
		if (_col+getwidth()>=10)
			return false;
		_col++;
		return true;
	}

	public function setcol(col : Int)
	{
		_col = col;
	}

	public function getvalue(row : Int, col: Int)
	{
		return _shape[row][col];
	}

	public function gettype()
	{
		return _type;
	}



}

