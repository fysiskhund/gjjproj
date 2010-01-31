package se.GGJgame
{
	import flash.geom.Point;
	
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;

	public class GameWinState extends FlxState
	{
		//[Embed( Source = "../mypath")]
		
		protected var titleImage:Class;
		private var player1:Player;
		private var text1:FlxText;
		private var text2:FlxText;
		
		
		public function GameWinState()
		{
			super();
			FlxState.bgColor = 0xff107100;
			
			var sfx:Sfx = new Sfx();
			sfx.win();
			
			text1 = new FlxText( 0, (FlxG.height / 2)-30, FlxG.width, "Game Won!" );
			text1.setFormat( null, 16, 0xFFFFFFFF, "center" );
			this.add( text1 );
			
			
			text2 = new FlxText( 0, (FlxG.height / 2)+30, FlxG.width, "Press [Enter] to play again." );
			text2.setFormat( null, 8, 0xFFFFFFFF, "center" );
			this.add( text2 );
			
			player1 = new Player(FlxG.width/2 - 7,(FlxG.height / 2)+10);
			player1.team = 9;
			player1.scale = new Point(player1.scale.x * 2, player1.scale.y * 2);
			player1._hatSprite.scale = new Point(player1._hatSprite.scale.x * 2, player1._hatSprite.scale.y * 2);
			this.add(player1);
			this.add(player1._hatSprite);
			player1.hatOffset = -15;
			
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