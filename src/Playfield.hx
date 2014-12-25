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
		init();
	}

	private function init()
	{

		_playfield = new Array<Array<Int>>();
		battlefield = new Array<Entity>();

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


		var tempshape = tet.getshape();
		var row = tet.getrow();
		//trace(row);
		var col = tet.getcol();
		tet.draw();

		for (i in 0...hei)
		{
			for (j in 0...wit)
			{

				if (tempshape[i][j] == 1)
				{
					var tempv = (row+i) * 10 + (col+j);
					battlefield[tempv].graphic = tempimage;

				}
				
			}
		}
	}

	public function addtetro(tetro : Tetromino)
	{
		var tetr = tetro.getrow();
		var tetc = tetro.getcol();

		var teth = tetro.getheight();
		var tetw = tetro.getwidth();

		for (i in 0...teth)
		{
			for (j in 0...tetw)
			{
				var temp1 = tetr + i;
				var temp2 = tetc + j;

				var value = tetro.getvalue(i,j);
				var string = "temp1 (r):" +  temp1 + " -- temp2 (c) :  " + temp2 + "value : $value " + value;
				//trace(["temp1 (r):" +  temp1 + " -- temp2 (c) :  " + temp2 + "value : " + value ]);
				//trace(string);
				var tetg = tetro.getvalue(i,j);
				if (tetg == 1)
				{
					_playfield[temp1][temp2] = tetro.getvalue(i,j);
				}
			}
		}

	}

	public function getfield()
	{
		return _playfield;
	}

	public function setfield(playfield : Array<Array<Int>>)
	{
		_playfield = playfield;
	}

	public function getvalue(row : Int, col : Int)
	{
		if (row >=20)
			return -1;
		return _playfield[row][col];
	}

}
