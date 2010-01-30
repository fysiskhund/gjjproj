package se.GGJgame
{
	
	import org.flixel.*;

	public class GameState extends FlxState
	{
		public var player1:Player;
		private var _map:FlxTilemap;
		private var _poo_p1:Poo;

		//layers so we can overlap HUD ect.		
		private var _lyrStage:FlxLayer;
        private var _lyrSprites:FlxLayer;
        private var _lyrHUD:FlxLayer;

		
		[Embed(source = "../../../resources/example_chip.png")] public static var mapTiles:Class;
		[Embed(source = "../../../resources/example_map.txt", mimeType = "application/octet-stream")] public static var mapData:Class;
		
		//Just preparing for an eventual second player
		private var _player2:Player;
		
		public function GameState()
		{
			super();			
			player1 = new Player();
			_lyrStage = new FlxLayer;
	        _lyrSprites = new FlxLayer;
    	    _lyrHUD = new FlxLayer;
			
			_map = new FlxTilemap();
			_map.loadMap( new mapData, mapTiles, 16);
			_lyrStage.add( _map );
		
			player1 = new Player( 34, 10 );
			_lyrSprites.add( player1 );


			//camera tweaks 
			_poo_p1 = new Poo();
			
			FlxG.follow( player1 );
			//FlxG.followAdjust( 2, 2 );
			//FlxG.followBounds( 2, 2, 2, 2 );

			//add layers in order, stage  in bottom etc.			
			this.add(_lyrStage);
            this.add(_lyrSprites);
            this.add(_lyrHUD);

			this.add( _poo_p1);
			this.add( player1._hatSprite);
		}
		
		override public function update():void 
		{
			super.update();
			player1.update();
			_map.collide( player1 );
			
			if (FlxG.keys.SPACE)
			{
				_poo_p1.throwPoo(player1.x, player1.y,  player1.dirX, player1.dirY);
			}
			if (FlxG.keys.ONE)
			{
				player1.currentHat++;
			}
			_poo_p1.update();
		}
		
	}
}