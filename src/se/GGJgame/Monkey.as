package se.GGJgame
{

	import org.flixel.FlxSprite;

	public class Monkey extends FlxSprite
	{
		[Embed( source='../../../resources/monkey.png' )] private var ImgMonkey:Class;
		[Embed( source='../../../resources/hats.png' )] private var ImgHats:Class;
		
		public var _hatSprite:FlxSprite;
		public var currentHat:int;
		
		public function Monkey(X:int=0, Y:int=0, SimpleGraphic:Class=null)
		{
			//super( X, Y, ImgPlayer );
			
			//load basic sprite image
			loadGraphic( ImgMonkey, true/* animated */, true, 14, 12 );
			_hatSprite = new FlxSprite();
			_hatSprite.loadGraphic( ImgHats, true/* animated */, true, 14, 9 );
			_hatSprite.addAnimation("0",[0]);
			_hatSprite.addAnimation("1",[1]);
			_hatSprite.addAnimation("2",[2]);
			_hatSprite.addAnimation("3",[3]);
			_hatSprite.addAnimation("4",[4]);
			
			addAnimation( "normal", [0] ); 
			currentHat = 0;
			//this.add(_hatSprite);
			
			
		}
		
		override public function update():void 
		{	
			_hatSprite.x = x;
			_hatSprite.y = y-7;
			_hatSprite.play(currentHat.toString());
			_hatSprite.update();			
			super.update();	
		}
		
	}
}