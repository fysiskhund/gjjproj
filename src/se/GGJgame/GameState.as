package se.GGJgame
{
	
	import flash.geom.Point;
	
	import org.flixel.*;
	

	public class GameState extends FlxState
	{
		public var player1:Player;
		public var npcs:Array;
		public var ninjaNpcs:Array;
		private var king:Npc;
		private var cameraTarget:Npc;
		public var items:Array;
		public var text:FlxText;
		public var lives:int;
		private var _map:FlxTilemap;
		private var _BGmap:FlxTilemap;
		private var _leftInCutscene:Number;
		
		public var conflicts:ConflictTable;
		
		private var _poo_p1:Poo;

		//layers so we can overlap HUD ect.		
		private var _lyrStage:FlxLayer;
		private var _lyrStageBack:FlxLayer;

        private var _lyrSprites:FlxLayer;
        private var _lyrGUI:FlxLayer;

		[Embed(source = "../../../resources/tiles.png")] public static var mapTiles:Class;
		[Embed(source = "../../../resources/example_map.txt", mimeType = "application/octet-stream")] public static var mapData:Class;		
		
		//Just preparing for an eventual second player
		private var _player2:Player;
		
		public function GameState()
		{
			super();			
			
			_leftInCutscene = Number.NEGATIVE_INFINITY;
			FlxState.bgColor = 0xff107100;
			cameraTarget = new Npc();
			cameraTarget.visible = true;
			player1 = new Player(250,50);
			npcs = new Array();
			ninjaNpcs = new Array();
			items = new Array();
			_lyrStage = new FlxLayer;
	        _lyrSprites = new FlxLayer;
    	    
    	    _lyrGUI = new FlxLayer;
	        this.setupGUI();
    	    
    	    this.text = new FlxText( 0, FlxG.height/2-32, FlxG.width, "" );
    	    this.text.visible = false;
    	    text.scrollFactor = new Point(0,0);
			text.setFormat( null, 16, 0xFFFFFFFF, "center" );
			
			_lyrGUI.add(text);
			
			_map = new FlxTilemap();
			_map.loadMap( new mapData, mapTiles);
			_map.collideIndex = 30;
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
					else if(nr >=15 && nr <= 18) {
						var n:Npc = new Npc(x*16,y*16,null,nr-10);
						_lyrSprites.add(n);
						npcs.push(n);
					}
					else if(nr == 19) { // big king
						king = new Npc(x*16,y*16,null,nr-10);
						_lyrSprites.add(king);
						npcs.push(king);
					}
					else if(nr >= 20 && nr <= 23)
					{
						var n:Npc = new Npc(x*16,y*16,null,nr-19);
						_lyrSprites.add(n);
						npcs.push(n);
					}
					else if(nr >= 24 && nr <= 27)
					{
						var n:Npc = new Npc(x*16,y*16,null,nr-23);
						_lyrSprites.add(n);
						npcs.push(n);
					}
					else if(nr >= 7 && nr <= 9)
					{//BRP
						// Add the king's guards (blue, red, purple)
						var nj:Npc = new NinjaNpc(x*16,y*16,null, nr-6);
						_lyrSprites.add(nj);
						ninjaNpcs.push(nj);
						_lyrSprites.add(nj._hatSprite);
					} else if (nr == 28) 
					{// T
						// Last of the king's guards (Triangle)
						var nj:Npc = new NinjaNpc(x*16,y*16,null, 4);
						_lyrSprites.add(nj);
						ninjaNpcs.push(nj);
						_lyrSprites.add(nj._hatSprite);
					}
				}
			}
			
			lives = 1;
			conflicts = new ConflictTable(5);
			
			//npcs.push(new Npc(20,20,null,2));
			//npcs.push(new Npc(180,180,null,3));
			for each (var np:Npc in npcs) {
				_lyrSprites.add(np);
				_lyrSprites.add(np._hatSprite);
			}
		
			player1 = new Player(400,750);
			_lyrSprites.add( player1 );

			

			//camera tweaks 
			_poo_p1 = new Poo();
			
			FlxG.follow( player1 );
			
			//FlxG.followAdjust( 2, 2 );
			//FlxG.followBounds( 2, 2, 2, 2 );

			//add layers in order, stage  in bottom etc.			
			this.add(_lyrStage);
            this.add(_lyrSprites);
            this.add(_lyrGUI);

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
		public function win():void {
			FlxG.switchState(GameWinState);
		}
		
		public function doCutScene():void {
			_leftInCutscene = 10;
			cameraTarget.x = player1.x;
			cameraTarget.y = player1.y;
		}
		public function endCutScene():void {
			_leftInCutscene = Number.NEGATIVE_INFINITY;
			FlxG.follow( player1 );
		}
		
		override public function update():void 
		{
			
			if(_leftInCutscene == Number.NEGATIVE_INFINITY) {				
				guiUpdate();
				//text.text = lives.toString();
				
				player1.update();
				_map.collide( player1 );
				_map.collideArray(npcs);
				_map.collide(_poo_p1);
				FlxG.overlapArray(items, player1, player1.pickUp);
				FlxG.overlapArray(npcs, _poo_p1, _poo_p1.hit);

	
				
				if (FlxG.keys.SPACE)
				{
					if(player1.poo > 0)
					{
						_poo_p1.visible = true;
						_poo_p1.throwPoo(player1.x, player1.y,  player1.dirX, player1.dirY);
						player1.poo--;
					}
				
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
				for each (var nj:NinjaNpc in ninjaNpcs) {
					nj.update();
				}
				for each (var it:Item in items) {
					it.update();
				}
				conflicts.update();
			}
			else if(_leftInCutscene <= 0) {	
				text.visible = false;
				endCutScene();
			}
			else {
				_leftInCutscene -= FlxG.elapsed;
				var elapsed:Number = 10-_leftInCutscene;
				
				if(elapsed <=2) {
					cameraTarget.x =  lerp(player1.x,king.x,elapsed/2);
					cameraTarget.y =  lerp(player1.y,king.y,elapsed/2);
				} else if (elapsed >= 7) {
					cameraTarget.x =  player1.x;
					cameraTarget.y =  player1.y;
					var left:String = _leftInCutscene.toString().substr(0,1);
					if(left == "0")
						text.text = "Go!";
					else
						text.text = left;
					text.visible = true;
					//text.update();
				} else if (elapsed >= 5) {
					cameraTarget.x =  lerp(king.x,player1.x,(elapsed-5)/2);
					cameraTarget.y =  lerp(king.y,player1.y,(elapsed-5)/2);
				} else {
					
					cameraTarget.x =  king.x;
					cameraTarget.y =  king.y;
					for each (var nj:NinjaNpc in ninjaNpcs) {
						nj.update();
					}
				}
				
				FlxG.follow( cameraTarget );
				cameraTarget.update();	
			}
		}
		
		public function guiUpdate():void
		{
			
		}
		
		public function setupGUI():void
		{
			_lyrGUI.scrollFactor.x = 0;
	        _lyrGUI.scrollFactor.y = 0;
		}
		
		public function lerp(a:Number, b:Number, amt:Number):Number {
			amt = Math.min(Math.max(0,amt),1);
			return a*(1-amt) + b*(amt);
		}
		
	}
}