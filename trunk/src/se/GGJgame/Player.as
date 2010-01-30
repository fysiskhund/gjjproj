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

		private var _move_speed:int = 50; // just a tweak
		
		[Embed( source='../../../resources/monkey_player.png' )] private var ImgPlayer:Class;
		
		public function Player( X:int=0, Y:int=0, SimpleGraphic:Class=null )
		{
			
			super( X, Y, SimpleGraphic );
			loadGraphic( ImgPlayer, true/* animated */, true, 14, 12 );
			
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