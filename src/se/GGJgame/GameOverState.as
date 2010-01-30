package se.GGJgame
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;

	public class GameOverState extends FlxState
	{
		//[Embed( Source = "../mypath")]
		
		protected var titleImage:Class;
		
		public function GameOverState()
		{
			super();
			FlxState.bgColor = 0xff000000;
			var text:FlxText = new FlxText( 0, (FlxG.height / 2)-26, FlxG.width, "Game Over" );
			text.setFormat( null, 16, 0xFFFFFFFF, "center" );
			this.add( text );
			
			var text2:FlxText = new FlxText( 0, (FlxG.height / 2), FlxG.width, "Press [Enter] to play again." );
			text2.setFormat( null, 10, 0xFFFFFFFF, "center" );
			this.add( text2 );
			
		}
		
		//updates to be done in MenuState
		override public function update():void 
		{
			super.update();
			if (FlxG.keys.ENTER)
			{
				FlxG.switchState(GameState);
			}
		}
		
	}
}