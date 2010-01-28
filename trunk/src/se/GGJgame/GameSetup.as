package se.GGJgame
{
	import org.flixel.FlxGame;

	public class GameSetup extends FlxGame
	{
		public function GameSetup()
		{
			super( 400, 300, MenuState, 2 );
			//help( "Jump", "Shoot", "Nothing" );
		}
		
	}
}