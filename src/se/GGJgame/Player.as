package se.GGJgame
{
	import flash.display.Sprite;
	
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;

	public class Player extends Monkey
	{


		// 
		public var dirX:int;
		public var dirY:int;

		private var _move_speed:int = 400; // just a tweak
		
		public function Player( X:int=0, Y:int=0, SimpleGraphic:Class=null )
		{
			super( X, Y, SimpleGraphic );
			
			
		}
		
		override public function update():void 
		{
			
			
			if (FlxG.keys.UP)
			{
				facing = UP;
				y -= 1;
				dirY = -1;
				if (! (FlxG.keys.LEFT || FlxG.keys.RIGHT))
				{
					dirX = 0;
				}
				this.play( "normal" );
			}
			if (FlxG.keys.DOWN)
			{
				facing = DOWN;
				y += 1;
				dirY = 1;
				if (! (FlxG.keys.LEFT || FlxG.keys.RIGHT))
				{
					dirX = 0;
				}
				this.play( "normal" );
			}
			if (FlxG.keys.LEFT)
			{
				facing = LEFT;
				x -= 1;
				dirX = -1;
				if (! (FlxG.keys.UP || FlxG.keys.DOWN))
				{
					dirY = 0;
				}
				this.play( "normal" );
			}
			if (FlxG.keys.RIGHT)
			{
				facing = RIGHT;
				x += 1;		
				dirX = 1;
				if (! (FlxG.keys.UP || FlxG.keys.DOWN))
				{
					dirY = 0;
				}
				this.play( "normal" );	
			}
			
			super.update();	
		}
		
	}
}