import com.haxepunk.graphics.Image;
import com.haxepunk.Entity;
import com.haxepunk.Scene;


class Playfield extends Entity
{

	private var _playfield : Array<Array<Int>>;
	public var battlefield : Entity;
	private var _overlay : Entity;

	public override function new()
	{
		super();
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

		x = 100;
		y = 100;

		graphic = new Image("graphics/13.png");

		drawplayfield();

	}	

	public function checkcollision(tet : Tetromino)
	{
		// determine the position of the entity
	}

	public function drawplayfield()
	{
		renderPlayfield();
		return;
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

	public function renderPlayfield(tet : Tetromino = null)
	{
		// render the whole thing

		return;

		if (tet != null)
		{

			for (j in 0...20)
			{
				for (i in 0...10)
				{
					var valor = _playfield[i][j];
					var ypos = j*10;
					var xpos = i * 10;
					graphic = new Image("graphics/block.png");





				}
			}



		}

	}
}
