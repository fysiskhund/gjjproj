package se.GGJgame
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	
	public class Poo extends FlxSprite
	{
		[Embed(source="../../../resources/poo.png")] private var ImgPoo:Class;
		var iDirX:int;
		var iDirY:int;
		var ttl:int;
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
   			y = posY;
   			ttl = 20;
		}
		override public function update():void 
		{
			
			if (ttl > 0)
			{
				x += iDirX;
				y += iDirY;
				ttl--;
			} else
			{
				super.update();
			}
			
			
		}
		
	}
	
	
}