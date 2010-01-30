package se.GGJgame
{
	
	import org.flixel.*;
	

	public class GameState extends FlxState
	{
		public var player1:Player;
		public var npcs:Array;
		public var items:Array;
		public var text:FlxText;
		public var lives:int;
		private var _map:FlxTilemap;
		private var _BGmap:FlxTilemap;
		
		public var conflicts:ConflictTable;
		
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
			player1 = new Player(250,50);
			npcs = new Array();
			items = new Array();
			_lyrStage = new FlxLayer;
	        _lyrSprites = new FlxLayer;
    	    _lyrHUD = new FlxLayer;
    	    
    	    this.text = new FlxText( 0, 0, FlxG.width, "ABC" );
			text.setFormat( null, 16, 0xFFFFFFFF, "center" );
			_lyrHUD.add(text);
			
			_map = new FlxTilemap();
			_map.loadMap( new mapData, mapTiles);
			_map.collideIndex = 20;
			_map.follow();
			_map.x = 0;
			_map.y = 0; 
			_lyrStage.add( _map );
			
			
			for ( x=0; x < _map.widthInTiles; x++) 
			{
				for ( y=0; y < _map.heightInTiles; y++) 
				{
					var nr:int = _map.getTile(x,y);
					if(nr == 10)
					{
						var it:Item = new Banana(x*16,y*16)
						_lyrSprites.add(it);
						items.push(it);
					}
					else if(nr >=11 && nr <= 14) {
						var it:Item = new Hat(x*16,y*16,null, nr-10)
						_lyrSprites.add(it);
						items.push(it);
					}
				}
			}
			
			lives = 3;
			conflicts = new ConflictTable(5);
			
			npcs.push(new Npc(20,20,null,2));
			npcs.push(new Npc(180,180,null,3));
			for each (var np:Npc in npcs) {
				_lyrSprites.add(np);
				_lyrSprites.add(np._hatSprite);
			}
		
			player1 = new Player();
			player1.team = 1;
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
		public function die():void {
			lives--;
			for each (var np:Npc in npcs) {
				np.restart();
			}
			player1.x = 120;
			player1.y = 120;
			if(lives == 0)
				FlxG.switchState(GameOverState);
		}
		
		override public function update():void 
		{
			
			//text.text = lives.toString();
			
			player1.update();
			_map.collide( player1 );
			_map.collideArray(npcs);
			FlxG.overlapArray(items, player1, player1.pickUp);
			
			this.text.text = player1.bananas.toString();


			
			if (FlxG.keys.SPACE)
			{
				_poo_p1.throwPoo(player1.x, player1.y,  player1.dirX, player1.dirY);
			}
			if (FlxG.keys.ONE)
			{
				player1.team++;
			}
			if (FlxG.keys.TWO)
			{
				conflicts.setAtWar(3,2);
				conflicts.setAtWar(2,3);
			}
			_poo_p1.update();
			
			for each (var np:Npc in npcs) {
				np.update();
			}
			for each (var it:Item in items) {
				it.update();
			}
			conflicts.update();
		}
		
	}
}