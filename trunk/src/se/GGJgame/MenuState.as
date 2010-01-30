package se.GGJgame
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;

	public class MenuState extends FlxState
	{
		//[Embed( Source = "../mypath")]
		
		protected var titleImage:Class;
		
		public function MenuState()
		{
			super();
			var text:FlxText = new FlxText( 0, (FlxG.width / 2), FlxG.width, "HAISAN! Press Enter to play" );
			text.setFormat( null, 16, 0xFFFFFFFF, "center" );
			this.add( text );
			
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