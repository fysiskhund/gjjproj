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
			FlxG.follow( player1 );
			this.add( player1 );
			this.add( _poo_p1);
			this.add( player1._hatSprite);
		}
		
		override public function update():void 
		{
			super.update();
			player1.update();
			if (FlxG.keys.SPACE)
			{
				_poo_p1.throwPoo(player1.x, player1.y,  player1.dirX, player1.dirY);
			}
			if (FlxG.keys.ONE)
			{
				player1.currentHat++;
			}
			_poo_p1.update();
		}
		
	}
}