package se.GGJgame
{
	
	import org.flixel.*;
	import org.flixel.data.FlxAnim;
	

	public class GameState extends FlxState
	{
		public var player1:Player;
		public var npcs:Array;
		public var text:FlxText;
		public var lives:int;
		private var _map:FlxTilemap;
		private var _BGmap:FlxTilemap;
		
		private var _poo_p1:Poo;

		//layers so we can overlap HUD ect.		
		private var _lyrStage:FlxLayer;
		private var _lyrStageBack:FlxLayer;

        private var _lyrSprites:FlxLayer;
        private var _lyrHUD:FlxLayer;

		[Embed(source = "../../../resources/tiles.png")] public static var mapTiles:Class;
		[Embed(source = "../../../resources/example_map.txt", mimeType = "application/octet-stream")] public static var mapData:Class;		
		
		//Just preparing for an eventual second player
		private var _player2:Player;
		
		public function GameState()
		{
			super();			
			
			FlxState.bgColor = 0xff107100;
			player1 = new Player();
			npcs = new Array();
			_lyrStage = new FlxLayer;
	        _lyrSprites = new FlxLayer;
    	    _lyrHUD = new FlxLayer;
			
			_map = new FlxTilemap();
			_map.loadMap( new mapData, mapTiles);
			_map.collideIndex = 19;
			_map.follow();
			_map.x = 0;
			_map.y = 0; 
			_lyrStage.add( _map );
			
			lives = 3;
			
			npcs.push(new Npc(40,10,null,2));
			for each (var np:Npc in npcs) {
				_lyrSprites.add(np);
				_lyrSprites.add(np._hatSprite);
			}
		
			player1 = new Player();
			_lyrSprites.add( player1 );

			this.text = new FlxText( 0, 0, FlxG.width, "ABC" );
			text.setFormat( null, 16, 0xFFFFFFFF, "center" );
			_lyrHUD.add(text);

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
		public function die():void {
			lives--;
			for each (var np:Npc in npcs) {
				np.restart();
			}
			player1.x = 100;
			player1.y = 100;
			if(lives == 0)
				FlxG.switchState(GameOverState);
		}
		
		override public function update():void 
		{
			
			text.text = lives.toString();
			
			player1.update();
			_map.collide( player1 );
			_map.collideArray(npcs);


			
			if (FlxG.keys.SPACE)
			{
				_poo_p1.throwPoo(player1.x, player1.y,  player1.dirX, player1.dirY);
			}
			if (FlxG.keys.ONE)
			{
				player1.currentHat++;
			}
			_poo_p1.update();
			
			for each (var np:Npc in npcs) {
				np.update();
			}
		}
		
	}
}