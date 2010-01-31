package se.GGJgame
{
	
	import flash.geom.Point;
	
	import org.flixel.*;
	

	public class GameState extends FlxState
	{
		
		public var inGame:Boolean;
		public var player1:Player;
		public var npcs:Array;
		public var ninjaNpcs:Array;
		public var sfx:Sfx;
		public var king:Npc;
		private var cameraTarget:Npc;
		private var startPoint:Point;
		public var items:Array;
		public var text:FlxText;
		public var lives:int;
		private var _map:FlxTilemap;
		private var _BGmap:FlxTilemap;
		private var _leftInCutscene:Number;
		private var _doneCutscene:Boolean;
		
		public var conflicts:ConflictTable;
		
		private var _poo_p1:Poo;

		//layers so we can overlap HUD ect.		
		private var _lyrStage:FlxLayer;
		private var _lyrStageBack:FlxLayer;

        private var _lyrSprites:FlxLayer;
        private var _lyrGUI:FlxLayer;

		[Embed(source = "../../../resources/tiles.png")] public static var mapTiles:Class;
		[Embed(source = "../../../resources/level0.txt", mimeType = "application/octet-stream")] public static var map0:Class;		
		[Embed(source = "../../../resources/level1.txt", mimeType = "application/octet-stream")] public static var map1:Class;		
		[Embed(source = "../../../resources/level2.txt", mimeType = "application/octet-stream")] public static var map2:Class;		

		
		
		//GUI resource 
		[Embed(source = "../../../resources/GUIpoo.png")] public static var pooCount:Class;
		[Embed(source = "../../../resources/GUIbg.png")] public static var GUIbg:Class;
		[Embed(source = "../../../resources/GUIbanana.png")] public static var GUIbanana:Class;
		private var _guiText:FlxText;
		private var _guiPooSprite:FlxSprite;
		private var _guiBananaSprite:FlxSprite;
		private var _guiMain:FlxSprite;
		private var _coolingDown:Boolean;
		private var _guiConflictPositions:Array;
		private var _maplist:Array;
		private var _oldConflicts:Array;
		private var _guiConflicts:Array;


		//Just preparing for an eventual second player
		//private var _player2:Player;
		public function GameState()
		{
			super();
			inGame = true;
			sfx = new Sfx();			
			
			_leftInCutscene = Number.NEGATIVE_INFINITY;
			_doneCutscene = false;
			FlxState.bgColor = 0xff107100;
			
			
			npcs = new Array();
			ninjaNpcs = new Array();
			items = new Array();
			_lyrStage = new FlxLayer;
	        _lyrSprites = new FlxLayer;
    	    
    	    _lyrGUI = new FlxLayer;
	        
    	    
    	    this.text = new FlxText( 0, FlxG.height/2-32, FlxG.width, "" );
    	    this.text.visible = false;
    	    text.scrollFactor = new Point(0,0);
			text.setFormat( null, 16, 0xFFFFFFFF, "center" );
			
			_lyrGUI.add(text);
			
			// Map loading
			_maplist = new Array(map0, map1, map2);
			
			_map = new FlxTilemap();
			_map.loadMap( new _maplist[FlxG.level], mapTiles);
			_map.collideIndex = 30;
			_map.follow();
			_map.x = 0;
			_map.y = 0; 
			_lyrStage.add( _map );
			startPoint = new Point();
		
			for ( x=0; x < _map.widthInTiles; x++) 
			{
				for ( y=0; y < _map.heightInTiles; y++) 
				{
					var nr:int = _map.getTile(x,y);
					if (nr == 29) //player
					{
						startPoint = new Point(x*16,y*16);
					}
				}	
			}
			player1 = new Player(startPoint.x,startPoint.y);
			
			
			cameraTarget = new Npc();
			cameraTarget.visible = false;
			
			this.setupGUI();
			
			
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
						var nj:NinjaNpc = new NinjaNpc(x*16,y*16,null, nr-6);
						_lyrSprites.add(nj);
						ninjaNpcs.push(nj);
						_lyrSprites.add(nj._hatSprite);
					} else if (nr == 28) 
					{
						// Last of the king's guards (Triangle)
						var nj:NinjaNpc = new NinjaNpc(x*16,y*16,null, 4);
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
		
			
			

			_lyrSprites.add( player1 );
			

			//camera tweaks 
			_poo_p1 = new Poo();
			
			FlxG.follow( player1 );
			
			sfx.bgMusic();
			
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
			//for each (var np:Npc in npcs) {
			//	np.restart();
			//}
			//player1.x = startPoint.x;
			//player1.y = startPoint.y;
			if(lives == 0)
				FlxG.switchState(GameOverState);
		}
		public function win():void {
			
			// Switch to next level
			FlxG.level++;
			if (FlxG.level < _maplist.length)
			{
				FlxG.switchState(GameState);
			} else
			{
				FlxG.switchState(GameWinState);
			}
		}
		
		public function doCutScene():void {
			sfx.chatter();
			if(_doneCutscene)
				return;
			_leftInCutscene = 10;
			//_doneCutscene = true;
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
				//player1.collideArray(ninjaNpcs);
				
				
				FlxG.overlapArray(items, player1, player1.pickUp);
				FlxG.overlapArray(npcs, _poo_p1, _poo_p1.hit);

	
				
				if (FlxG.keys.SPACE)
				{
					if(player1.poo > 0)
					{
						_poo_p1.visible = true;
						_poo_p1.throwPoo(player1.x, player1.y,  player1.dirX, player1.dirY);
						player1.poo--;
						sfx.throwPoo();
					}
				
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
					if(left == "3")
						sfx.count3();
					else if(left == "2")
						sfx.count2();
					else if(left == "1")
						sfx.count1();
					else if(left == "0")
						sfx.countGo();
					
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
			var infinity:Boolean = (player1._timeToPoo == Number.POSITIVE_INFINITY);
			if( player1._timeToPoo > 4 && !infinity ) {
				_guiPooSprite.play( "not ready" );
			} else if ( player1._timeToPoo > 3 && !infinity ) {
				_guiPooSprite.play( "cooldown2" );
			} else if ( player1._timeToPoo > 2 && !infinity) {
				_guiPooSprite.play( "cooldown3" );
			} else if ( player1._timeToPoo > 1 && !infinity) {
				_guiPooSprite.play( "cooldown4" );
			} else if ( player1._timeToPoo > 0 && !infinity) {
				_guiPooSprite.play( "cooldown5" );
			} else if ( player1.poo == 1 ) {
				_guiPooSprite.play( "ready" );
			} else if ( player1.poo == 0 ) {
				_guiPooSprite.play( "not ready" );
			}
			this._guiText.text = "x" + (player1.bananas).toString();
			
			//for conflicts in gui
			//HACK HACK HACK, the structure is properly fucked!
			for ( var i:int = 0; i < 5; i++ ) {
	        	for ( var j:int = 0; j < 5; j++ ) {
	        		if ( conflicts.ct[i][j] > 0 ) {
	        			if ( _oldConflicts[i][j] == false ) {
	        				var maxTime:int = _oldConflicts[i][j] 
	        				var k:int;
	        				var newConflict:ConflictBar = new ConflictBar();
	        				for ( k = 0; k < _guiConflictPositions.length; k++ ) {
	        					if ( _guiConflictPositions[k] ) {
	        						newConflict.position = k;
	        						_guiConflictPositions[k] = false;	        						
	        						break;
	        					}
	        				}
	        				newConflict.addConflict( i, j, conflicts.ct[i][j], k * 40 + 4 );
	        				
	        				//newConflict.offsetX( k * 40 );
	        				_lyrGUI.add( newConflict )
	        				_oldConflicts[i][j] = newConflict;
	        				_oldConflicts[j][i] = newConflict;

	        			} else {
	        				var conflict:ConflictBar = _oldConflicts[i][j];
	        				conflict.setValue( conflicts.ct[i][j] );
	        			}
	        		} else if ( _oldConflicts[i][j] != false ) {
	        				var oldConflict:ConflictBar = _oldConflicts[i][j];
	        				_guiConflictPositions[ oldConflict.position ] = true;
	        				oldConflict.destroy();
	        				_oldConflicts[i][j] = false; 
	        		}
	        	}
	        }
			
		}
		
		public function setupGUI():void
		{
			_lyrGUI.scrollFactor.x = 0;
	        _lyrGUI.scrollFactor.y = 0;
	        _guiPooSprite = new FlxSprite();
	        _guiMain = new FlxSprite();
	        _guiBananaSprite = new FlxSprite();
	        _guiConflicts = new Array();
	        
	        _guiText = new FlxText( 20, FlxG.height - 20, 50, "x" + (player1.bananas).toString() );
			_guiText.setFormat( null, 16, 0x00000000, "left" );
	        
	        /*
	        _guiPooSprite.y = FlxG.height - _guiPooSprite.height * 2;
	        _guiPooSprite.x = _guiMain.width;
	        _guiMain.y = FlxG.height - _guiMain.height * 2;
	        */
	        
	        _guiPooSprite.y = FlxG.height - 20;
	        _guiPooSprite.x = 77;
	        _guiBananaSprite.y = FlxG.height - 17;
	        _guiBananaSprite.x = 2;
	        _guiMain.y = FlxG.height - 20;
	        
	        _guiPooSprite.scrollFactor.x = 0;
	        _guiPooSprite.scrollFactor.y = 0;
	        _guiMain.scrollFactor.x = 0;
	        _guiMain.scrollFactor.y = 0;
	        _guiBananaSprite.scrollFactor.x = 0;
	        _guiBananaSprite.scrollFactor.y = 0;
	        _guiText.scrollFactor.x = 0;
	        _guiText.scrollFactor.y = 0;
	        
	        _oldConflicts = new Array( teams );
			
			var teams:int = 5;
			for ( var i:int = 0; i < teams; i++ ) {
				_oldConflicts[i] = new Array( teams );
				for ( var j:int = 0; j < teams; j++ ) {
					_oldConflicts[i][j] = false;
				}
			}
	        	        	       
	        _guiPooSprite.loadGraphic( pooCount, true, false, 20, 20 );
   			//_guiPooSprite.addAnimation( "cooldown",[0, 1, 2, 3, 4, 5], 3);
   			//_guiPooSprite.addAnimation( "ready",[5], 3 );
   			//_guiPooSprite.addAnimation( "not ready",[0], 3 );
   			//_guiPooSprite.play( "not ready" );
   			_guiPooSprite.addAnimation( "not ready",[0]);
   			_guiPooSprite.addAnimation( "cooldown1",[1]);
   			_guiPooSprite.addAnimation( "cooldown2",[2]);
   			_guiPooSprite.addAnimation( "cooldown3",[3]);
   			_guiPooSprite.addAnimation( "cooldown4",[4]);
   			_guiPooSprite.addAnimation( "cooldown5",[5]);
   			_guiPooSprite.addAnimation( "ready",[6]);
   			
   			_coolingDown = false;
   			
   			_guiBananaSprite.loadGraphic( GUIbanana, false, false, 20, 20 );
   			
   			_guiMain.loadGraphic( GUIbg, false, false, 100, 20 );

			_guiConflictPositions = new Array(6);
			for ( var k:int = 0; k < 6; k++ ) {
				_guiConflictPositions[k] = true;   			
			}
   			_lyrGUI.add( _guiMain );
   			_lyrGUI.add( _guiPooSprite );
   			_lyrGUI.add( _guiBananaSprite );
			_lyrGUI.add( _guiText );

		}
		
		public function lerp(a:Number, b:Number, amt:Number):Number {
			amt = Math.min(Math.max(0,amt),1);
			return a*(1-amt) + b*(amt);
		}
		
	}
}