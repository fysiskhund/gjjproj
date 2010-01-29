package se.GGJgame
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;

	public class Player extends FlxSprite
	{
		//[Embed(source='../../data/Player.png')] private var ImgPlayer:Class;
		private var _move_speed:int = 400; // just a tweak
		
		public function Player(X:int=0, Y:int=0, SimpleGraphic:Class=null)
		{
			super(X, Y, SimpleGraphic);
			//load basic sprite image
			//loadGraphic(ImgPlayer, true/* animated */, true, 16, 16);
		}
		
		override public function update():void 
		{
			
			if (FlxG.keys.UP)
			{
				facing = UP;
				y -= 1;
			}
			if (FlxG.keys.DOWN)
			{
				facing = DOWN;
				y += 1;
			}
			if (FlxG.keys.LEFT)
			{
				facing = LEFT;
				x -= 1;
			}
			if (FlxG.keys.RIGHT)
			{
				facing = RIGHT;
				x += 1;				
			}
			super.update();	
		}
		
	}
}