package se.GGJgame
{
	import org.flixel.FlxG;

	public class Player extends Monkey
	{


		// 
		public var dirX:int;
		public var dirY:int;
		
		public var bananas:int;

		private var _move_speed:int = 100; // just a tweak
		
		[Embed( source='../../../resources/monkey_player.png' )] private var ImgPlayer:Class;
		
		public function Player( X:int=0, Y:int=0, SimpleGraphic:Class=null )
		{
			
			super( X, Y, SimpleGraphic );
			loadGraphic( ImgPlayer, true/* animated */, true, 14, 12 );
			//Bounding box tweaks
			this.currentHat = 0;
		}
		
		public function pickUp(item:Item, p:Player):void
        {
        	if(FlxG.keys.CONTROL) {
        		if(item.visible) {
	        		
	        		if(item.type == 0) {
	        			bananas++;
	        		}
	        		else if(item.type >= 1 && item.type <= 4) {
	        			currentHat = item.type;
	        			var gs:GameState = (FlxG.state as GameState);
	        			for each (var it:Item in gs.items) {
	        				if(it.type > 0)
	        					it.visible = true;
	        			}
	        		}
	        		item.visible = false;
        		}
        		
        	}
        	
        }
		
		override public function update():void 
		{
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