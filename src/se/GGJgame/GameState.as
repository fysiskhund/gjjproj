package se.GGJgame
{
	
	import org.flixel.*;

	public class GameState extends FlxState
	{
		private var _player1:Player;
		
		//Just preparing for an eventual second player
		private var _player2:Player;
		
		public function GameState()
		{
			super();			
			_player1 = new Player();
				
		}
		
		override public function update():void 
		{
			super.update();			
		}
		
	}
}