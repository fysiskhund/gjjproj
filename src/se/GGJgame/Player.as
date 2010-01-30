package se.GGJgame
{
	import org.flixel.FlxG;

	public class Player extends Monkey
	{

		public var dirX:int;
		public var dirY:int;
		
		public var bananas:int;
		public var poo:int;
		
		private var _lastPickup:Date;
		private var _timeToPoo:Number;

		private var _move_speed:int = 100; // just a tweak
		
		[Embed( source='../../../resources/monkey_player.png' )] private var ImgPlayer:Class;
		
		public function Player( X:int=0, Y:int=0, SimpleGraphic:Class=null )
		{
			super( X, Y, SimpleGraphic );
			loadGraphic( ImgPlayer, true/* animated */, true, 14, 12 );
			//Bounding box tweaks
			this.team = 0;
			this._lastPickup = new Date();
			this._timeToPoo = Number.POSITIVE_INFINITY;
		}
		
		public function pickUp(item:Item, p:Player):void
        {
        	
        	if(FlxG.keys.CONTROL) {
        		var now:Date = new Date();
	        	if(now.getTime() - _lastPickup.getTime() < 500)
	        		return;
	        	_lastPickup = new Date();
        		
        		if(item.visible) {
	        		
	        		if(item.type == 0) {
	        			if(item.visible)
	        			{
	        				var gs:GameState = (FlxG.state as GameState);
	        				for each (var it:Item in gs.items) {
	        					if(it.type == 0)
									it.visible = true;
							}
		        			bananas++;
		        			item.visible = false;
	        			}
	        		}
	        		else if(item.type >= 1 && item.type <= 4) {
	        			var newHat:int = item.type;
	        			
	        			if(team > 0)
	        				item.type = team;
	        			else
	        				item.visible = false;
	        			
	        			team = newHat;
	        			
	        			
	        		}
	        		
        		}
        		
        	}
        	
        }
		
		override public function update():void 
		{
			if(bananas > 0 && poo == 0)
			{
				if(_timeToPoo == Number.POSITIVE_INFINITY)
				{
					_timeToPoo = 3;
				}
				else if(_timeToPoo <= 0)
				{
					bananas--;
					poo++;
					_timeToPoo = Number.POSITIVE_INFINITY;
				}
				else 
				{
					_timeToPoo -= FlxG.elapsed;
				}
			}

			if (FlxG.keys.UP)
			{
				facing = UP;
				velocity.y = -1;
				dirY = -1;
				if (! (FlxG.keys.LEFT || FlxG.keys.RIGHT))
				{
					dirX = 0;
				}
				this.play( "normal" );
			} else if (FlxG.keys.DOWN)
			{
				facing = DOWN;
				velocity.y = 1;
				dirY = 1;
				if (! (FlxG.keys.LEFT || FlxG.keys.RIGHT))
				{
					dirX = 0;
				}
				this.play( "normal" );
			} else
			{
				velocity.y = 0;
			}
			
			
			if (FlxG.keys.LEFT)
			{
				facing = LEFT;
				velocity.x = -1;
				dirX = -1;
				if (! (FlxG.keys.UP || FlxG.keys.DOWN))
				{
					dirY = 0;
				}
				this.play( "normal" );
			} else if (FlxG.keys.RIGHT)
			{
				facing = RIGHT;
				velocity.x = 1;		
				dirX = 1;
				if (! (FlxG.keys.UP || FlxG.keys.DOWN))
				{
					dirY = 0;
				}
				this.play( "normal" );	
			} else
			{
				velocity.x = 0;
			}
			velocity.normalize(_move_speed);
			
			super.update();	
		}
		
	}
}