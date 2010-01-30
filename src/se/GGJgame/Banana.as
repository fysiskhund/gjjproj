package se.GGJgame
{

	import com.fefranca.*;
	
	import org.flixel.FlxSprite;

	public class Banana extends Item
	{
		[Embed( source='../../../resources/banana.png' )] private var ImgBanana:Class;
		public function Banana(X:int=0, Y:int=0, SimpleGraphic:Class=null)
		{
			//load basic sprite image
			//addAnimation( "normal", [0] );
			super(X,Y,SimpleGraphic);
			loadGraphic( ImgBanana, true/* animated */, true, 16, 12 );
			
			type = 0;
			
		}
		
		override public function update():void 
		{	
			super.update();

		}
		
	}
}