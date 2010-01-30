package se.GGJgame
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	
	public class Poo extends FlxSprite
	{
		[Embed(source="../../../resources/poo.png")] private var ImgPoo:Class;
		var iDirX:int;
		var iDirY:int;
		var ttl:Number;
		private var _move_speed:int = 120;
		
		public function Poo(X:int=0, Y:int=0, SimpleGraphic:Class=null)
		{
			super(X, Y, ImgPoo);
   			//addAnimation("throw",[0]);
   			//addAnimation("splat",[1], 150, false);

		}
		public function throwPoo(posX:int, posY:int, dirX:int, dirY:int):void
		{
			iDirX = dirX;
   			iDirY = dirY;
   			x = posX;
   			y = posY+6;
   			ttl = 0.5;
		}
		override public function update():void 
		{
			
			if (ttl > 0)
			{
				velocity.x = iDirX;
				velocity.y = iDirY;
				velocity.normalize(_move_speed);
				ttl -= FlxG.elapsed;
				
			} else {
				velocity.x = 0;
				velocity.y = 0;
			}
			super.update();
			
			
		}
		
	}
	
	
}