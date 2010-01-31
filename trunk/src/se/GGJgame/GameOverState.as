package se.GGJgame
{
	import flash.geom.Point;
	
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;


	public class GameOverState extends FlxState
	{
		//[Embed( Source = "../mypath")]
		[Embed(source = "../../../resources/caught.png")] public static var ImgCaught:Class;
		private var caught:FlxSprite;
		protected var titleImage:Class;
		
		public function GameOverState()
		{
			super();
			FlxState.bgColor = 0xff440000;
			
			caught = new FlxSprite();
			caught.loadGraphic(ImgCaught);
			caught.x = (FlxG.width/2) - 7;
			caught.y = (FlxG.height / 2)+40;
			caught.scale = new Point(caught.scale.x * 3.5, caught.scale.y * 3.5);
			
			var text:FlxText = new FlxText( 0, (FlxG.height / 2)-30, FlxG.width, "You were caught!" );
			text.setFormat( null, 16, 0xFFFFFFFF, "center" );
			this.add( text );
			this.add(caught);
			
			var text2:FlxText = new FlxText( 0, (FlxG.height / 2), FlxG.width, "Press [Enter] to try again." );
			text2.setFormat( null, 8, 0xFFFFFFFF, "center" );
			this.add( text2 );
			
		}
		
		//updates to be done in MenuState
		override public function update():void 
		{
			super.update();
			if (FlxG.keys.ENTER)
			{
				FlxG.switchState(InstructionsState);
			}
		}
		
	}
}