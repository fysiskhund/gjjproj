package se.GGJgame
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	
	public class Poo extends FlxSprite
	{
		[Embed(source="../../../resources/poo.png")] private var ImgPoo:Class;
		var iDirX:Boolean;
		var iDirY:Boolean;
		var ttl:int;
		public function Poo(X:int=0, Y:int=0, SimpleGraphic:Class=null)
		{
			super(X, Y, ImgPoo);
   			//addAnimation("throw",[0]);
   			//addAnimation("splat",[1], 150, false);

		}
		public function throwPoo(posX:int, posY:int, dirX:Boolean, dirY:Boolean):void
		{
			iDirX = dirX;
   			iDirY = dirY;
   			x = posX;
   			y = posY;
   			ttl = 20;
		}
		public function updatePoo():void 
		{
			
			if (ttl > 0)
			{
				if (iDirX)
				{
					x += 1;
				} else
				{
					x -= 1;
				}
				if (iDirY)
				{
					y += 1;
				} else
				{
					y -= 1;
				}
				ttl--;
			} 
			
			
		}
		
	}
	
	
}