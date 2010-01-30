package se.GGJgame
{

	import com.fefranca.*;
	
	import org.flixel.FlxSprite;

	public class Item extends FlxSprite
	{
		//[Embed( source='../../../resources/banana.png' )] private var ImgBanana:Class;
		public var type:int;
		public function Item(X:int=0, Y:int=0, SimpleGraphic:Class=null)
		{
			//load basic sprite image
			//loadGraphic( ImgBanana, true/* animated */, true, 16, 12 );
			//addAnimation( "normal", [0] );
			super(X,Y,SimpleGraphic);
			type = -1;
			this.acceleration.x = 0;
			this.acceleration.y = 0;
			
		}
		
		public function setType(i:int):void
		{
			type = i;
		
		}
		
		override public function update():void 
		{	
			super.update();

		}
		
	}
}