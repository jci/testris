import com.haxepunk.graphics.Image;
import com.haxepunk.Entity;


class Playfield
{

	private var _playfield : Array<Array<Int>>;
	private var _battlefield : Entity;
	private var _overlay : Entity;

	public function new()
	{
		// initialize
		trace(["new playfield"]);
		init();
	}

	private function init()
	{

		_playfield = new Array<Array<Int>>();

		// for how much, you say?

		for (i in 0...20)
		{
			var	line = new Array<Int>();
			for (j in 0...10)
			{
				line.push(0);
			}
			_playfield.push(line);
		}

		_battlefield = new Entity();
		_overlay = new Entity();



	}	

	public function checkcollision(tet : Tetromino)
	{
		// determine the position of the entity
	}

	public function drawplayfield()
	{
		// 
		for (i in 0...20)
		{
			var mstring :String = "";
			for (j in 0...10)
			{
				mstring += _playfield[i][j] + " ";
			}
			trace([mstring]);
		}
	}
}
