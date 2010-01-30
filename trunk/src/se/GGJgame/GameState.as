package se.GGJgame
{
	
	import org.flixel.*;

	public class GameState extends FlxState
	{
		public var player1:Player;
		private var _poo_p1:Poo;
		
		//Just preparing for an eventual second player
		private var _player2:Player;
		
		public function GameState()
		{
			super();			
			player1 = new Player();
			_poo_p1 = new Poo();
			FlxG.follow( _player1 );
			this.add( _player1 );
			this.add( _poo_p1);
		}
		
		override public function update():void 
		{
			super.update();
			player1.update();
			if (FlxG.keys.SPACE)
			{
				_poo_p1.throwPoo(0, 0, true, true);
			}
			_poo_p1.updatePoo();
		}
		
	}
}