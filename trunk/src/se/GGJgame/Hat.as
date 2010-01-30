package se.GGJgame
{

	import com.fefranca.*;
	
	import org.flixel.FlxSprite;

	public class Hat extends Item
	{
		[Embed( source='../../../resources/hats.png' )] private var ImgHats:Class;
		
		public function Hat(X:int=0, Y:int=0, SimpleGraphic:Class=null, hatType:int=1)
		{
			//load basic sprite image
			//addAnimation( "normal", [0] );
			super(X,Y,SimpleGraphic);
			loadGraphic( ImgHats, true/* animated */, false, 14, 9 );
			this.specificFrame(hatType);
			type = hatType;
			
		}
		override public function setType(i:int):void
		{
			type = i;
		
		}
		override public function update():void 
		{	
			super.update();
			this.specificFrame(type);
		}
		
	}
}