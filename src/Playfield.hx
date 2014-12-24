import com.haxepunk.graphics.Image;
import com.haxepunk.Entity;
import com.haxepunk.Scene;


class Playfield 
{

	private var _playfield : Array<Array<Int>>;
	public var battlefield : Array<Entity>;
	private var _overlay : Entity;

	public  function new()
	{
		// initialize
		trace(["new playfield"]);
		init();
	}

	private function init()
	{

		_playfield = new Array<Array<Int>>();
		battlefield = new Array<Entity>();

		// for how much, you say?

		for (i in 0...20)
		{
			var	line = new Array<Int>();
			for (j in 0...10)
			{
				line.push(0);
				var entitytemp = new Entity();
				var tempimage = new Image("graphics/blank.png");
				entitytemp.graphic =  tempimage;
				entitytemp.x = 100 + j*tempimage.height;
				entitytemp.y = 100 +  i*tempimage.width;
				battlefield.push(entitytemp);
			}
			_playfield.push(line);
		}


	}	

	public function checkcollision(tet : Tetromino)
	{
		// determine the position of the entity
	}

	public function drawplayfield(tet : Tetromino)
	{

		var wit = tet.getwidth();
		var hei = tet.getheight();

		var tempimage =  new Image("graphics/block.png");
		var tempblank = new Image("graphics/blank.png");

		for (i in 0...20)
		{
			var mstring :String = "";
			for (j in 0...10)
			{
				var value = _playfield[i][j];
				var posabs = i*10 + j;

				if (value==0)
				{
					battlefield[posabs].graphic = tempblank;
				}
				else
				{

					battlefield[posabs].graphic = tempimage;
				}

			}
		}

		// now the tetro

		var tempshape = tet.getshape();
		tet.draw();

		for (i in 0...hei)
		{
			for (j in 0...wit)
			{
				var row = tet.getrow();
				var col = tet.getcol();
				var value = tempshape[i][j];
				trace(["" + value + "value on" +""+i + " " + j ]);

			}
		}
	}

}
