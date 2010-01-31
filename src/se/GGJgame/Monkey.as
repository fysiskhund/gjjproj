package se.GGJgame
{

	
	import org.flixel.FlxSprite;

	public class Monkey extends FlxSprite
	{
		[Embed( source='../../../resources/monkey.png' )] protected var ImgMonkey:Class;
		[Embed( source='../../../resources/hats.png' )] protected var ImgHats:Class;
		
		public var _hatSprite:FlxSprite;
		public var team:int;
		public var hatOffset:int;
		
		public function Monkey(X:int=0, Y:int=0, SimpleGraphic:Class=null)
		{
			//add for debug
			super(X,Y,SimpleGraphic);
			//this.showCollisionRects = true;
			//super( X, Y, ImgPlayer );
			hatOffset = -7;
			//load basic sprite image
			loadGraphic( ImgMonkey, true/* animated */, true, 14, 12 );
			_hatSprite = new FlxSprite();
			_hatSprite.loadGraphic( ImgHats, true/* animated */, true, 14, 9 );
			_hatSprite.addAnimation("0",[0]);
			_hatSprite.addAnimation("1",[1]);
			_hatSprite.addAnimation("2",[2]);
			_hatSprite.addAnimation("3",[3]);
			_hatSprite.addAnimation("4",[4]);
			_hatSprite.addAnimation("5",[5]);
			_hatSprite.addAnimation("6",[6]);
			_hatSprite.addAnimation("7",[7]);
			_hatSprite.addAnimation("8",[8]);
			_hatSprite.addAnimation("9",[9]);
			
			addAnimation( "normal", [0] ); 
			team = 0;
			//this.add(_hatSprite);
			
			this.acceleration.x = 0;
			this.acceleration.y = 0;
			
			
			
			
		}
		
		override public function update():void 
		{	
			_hatSprite.x = x;
			_hatSprite.y = y + hatOffset;
			_hatSprite.play(team.toString());
			_hatSprite.update();			
			super.update();	
		}
		
	}
}