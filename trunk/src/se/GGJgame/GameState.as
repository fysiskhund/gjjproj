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
			FlxG.follow( _player1 );
			this.add( _player1 );
		}
		
		override public function update():void 
		{
			super.update();
			_player1.update();
		}
		
	}
}