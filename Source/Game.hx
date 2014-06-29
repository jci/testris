package;

import openfl.Assets;
import openfl.media.Sound;
import openfl.media.SoundTransform;
import SoundManager;





class Game
{
	// main game class

	private var gameState : Array<Int>;



	// tetris figurines

	public static inline var tetromino_I:Int = 0; 
	public static inline var tetromino_O:Int = 1;
	public static inline var tetromino_T:Int = 2;
	public static inline var tetromino_S:Int = 3;
	public static inline var tetromino_Z:Int = 4;
	public static inline var tetromino_J:Int = 5;
	public static inline var tetromino_L:Int = 6;

	// only 6 figures




	public function new()
	{
	}

	public function init()
	{
	}

	public function update()
	{
	}

	public function destroy()
	{
	}

	public function start()
	{
		 
		SoundManager.getInstance().loadMusic("assets/tetris.ogg");
		SoundManager.getInstance().playMusic();

	}


	public function initMatrix(rows:Int, cols:Int, value:Int=0)
	{
		var t1 : Int=0;
		var t2 : Int=0;
		var t3 =  new Array<Array<Int>>();

		for (t1 in 0...rows)
			for (t2 in 0...cols)
				t3[t1][t2] = value;
		return t3;

	}
}

