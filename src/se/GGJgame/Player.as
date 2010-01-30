package se.GGJgame
{
	import flash.display.Sprite;
	
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;

	public class Player extends FlxSprite
	{
		[Embed( source='../../../resources/monkey.png' )] private var ImgPlayer:Class;
		[Embed( source='../../../resources/hats.png' )] private var ImgHats:Class;
		
		public var _hatSprite:FlxSprite;
		
		// 
		public var dirX:int;
		public var dirY:int;
		public var currentHat:int;
		private var _move_speed:int = 400; // just a tweak
		
		public function Player( X:int=0, Y:int=0, SimpleGraphic:Class=null )
		{
			super( X, Y, SimpleGraphic );
			//super( X, Y, ImgPlayer );
			
			//load basic sprite image
			loadGraphic( ImgPlayer, true/* animated */, true, 14, 12 );
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
			
			
			if (FlxG.keys.UP)
			{
				facing = UP;
				y -= 1;
				dirY = -1;
				if (! (FlxG.keys.LEFT || FlxG.keys.RIGHT))
				{
					dirX = 0;
				}
				this.play( "normal" );
			}
			if (FlxG.keys.DOWN)
			{
				facing = DOWN;
				y += 1;
				dirY = 1;
				if (! (FlxG.keys.LEFT || FlxG.keys.RIGHT))
				{
					dirX = 0;
				}
				this.play( "normal" );
			}
			if (FlxG.keys.LEFT)
			{
				facing = LEFT;
				x -= 1;
				dirX = -1;
				if (! (FlxG.keys.UP || FlxG.keys.DOWN))
				{
					dirY = 0;
				}
				this.play( "normal" );
			}
			if (FlxG.keys.RIGHT)
			{
				facing = RIGHT;
				x += 1;		
				dirX = 1;
				if (! (FlxG.keys.UP || FlxG.keys.DOWN))
				{
					dirY = 0;
				}
				this.play( "normal" );	
			}

			_hatSprite.play(currentHat.toString());
			_hatSprite.update();
			
			super.update();	
		}
		
	}
}