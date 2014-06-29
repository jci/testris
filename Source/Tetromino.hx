package ; 

class Tetromino
{

	public static inline var fig_I:Int = 0; 
	public static inline var fig_O:Int = 1;
	public static inline var fig_T:Int = 2;
	public static inline var fig_S:Int = 3;
	public static inline var fig_Z:Int = 4;
	public static inline var fig_J:Int = 5;
	public static inline var fig_L:Int = 6;

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
