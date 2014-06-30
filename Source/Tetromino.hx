package ;

import Game;

enum Tetro
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
	EMPTY_CELL;
	FULL_CELL;
}



class Tetromino
{


	public var cells:Array<Array<Int>>;
	public var x:Int;
	public var y:Int;
	public var size:Int;

	public var type : Int; // do we need this? just in case
	

	public function new()
	{
		cells = initMatrix(4,4,EMPTY_CELL);
	}

	private  function initMatrix(rows:Int, cols:Int, value:Cell)
	{
		var t1 : Int=0;
		var t2 : Int=0;
		var t3 =  new Array<Array<Int>>();

		for (t1 in 0...rows)
			for (t2 in 0...cols)
				t3[t1][t2] = Type.enumIndex(value);
		return t3;

	}


}
