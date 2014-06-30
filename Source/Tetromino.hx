package ;

import Game;
import openfl.Lib;

enum Shape
{
		fig_I;
		fig_O;
		fig_T;
		fig_S;
		fig_Z;
		fig_J;
		fig_L;
}

enum Cell
{
	cell_empty;
	cell_full;
}


class Tetromino
{


	public var cells:Array<Array<Int>>;
	public var x:Int;
	public var y:Int;
	public var size:Int;
	public var type : Int; // do we need this? just in case
	public var shape : Shape;
	

	public function new()
	{
		cells = initMatrix(4,4,0);
		shape = randomizeshape();
	}

	private  function initMatrix(rows:Int, cols:Int, value:Int)
	{
		var t1 : Int=0;
		var t2 : Int=0;
		var t3 : Array<Array<Int>> = new Array();

		for (t1 in 0...rows)
		{
			t3.push(new Array());
			for (t2 in 0...cols)
				t3[t1][t2] = value;
		}
		return t3;

	}

	private function randomizeshape()
	{
		var myshape = Type.allEnums(Shape);
		var llength = Std.random(myshape.length);
		return Type.createEnumIndex(Shape,llength);


		
	}


}
