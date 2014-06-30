package ; 

class Tetromino
{

	enum tetro
	{
		fig_I;
		fig_O;
		fig_T;
		fig_S;
		fig_Z;
		fig_J;
		fig_L;
	}


	public var cells:Array<Array<Int>>;
	public var x:Int;
	public var y:Int;
	public var size:Int;

	public var type : Int; // do we need this? just in case
	

	public function new()
	{
		cells = Game.initMatrix(4,4,Game.EMPTY_CELL);
	}


}
