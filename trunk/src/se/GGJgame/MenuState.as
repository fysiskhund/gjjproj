package se.GGJgame
{
	import org.flixel.FlxEmitter;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;

	public class MenuState extends FlxState
	{
		//[Embed( Source = "../mypath")]
		private var player1:Player;
		private var _fx:FlxSprite;
		protected var titleImage:Class;
		public var inGame:Boolean;
		
		public function MenuState()
		{
			super();
			inGame = false;
			player1 = new Player();
			FlxState.bgColor = 0xff262626;
				
			var e:FlxEmitter = new FlxEmitter();
			e.width = FlxG.width;
			e.y = FlxG.height+8;
			e.gravity = -50;
			e.delay = 0.12;
			e.setXVelocity();
			e.setYVelocity(-50,0);
			var particles:uint = 50;
			var monkeys:Array = new Array();
			for( var i:uint = 0; i < particles; i++ ) {
				var monkey:Monkey = new Monkey();
				var scaleFactor:Number = Math.round( Math.random() * 5 );
				monkey.scale.x = scaleFactor;
				monkey.scale.y = scaleFactor;
				monkeys.push( add( monkey ) );
			}
			add( e.loadSprites( monkeys ) );
			
			var text:FlxText = new FlxText( 0, (FlxG.height / 2) - 40, FlxG.width, "Primate Diplomat!" );
			text.setFormat( null, 32, 0xFFFFFFFF, "center" );
			var text1:FlxText = new FlxText( text.x, text.y +65, FlxG.width, "A game by\nMarcus Antonsson, Andreas Karlsson and Alejandro Valenzuela" );
			text1.setFormat( null, 8, 0xFFFFFFFF, "center" );
			var text2:FlxText = new FlxText( text.x, text.y + 100, FlxG.width, "Press Enter to play" );
			text2.setFormat( null, 12, 0xFFFFFFFF, "center" );
			
			var text3:FlxText = new FlxText( text.x, text.y + 150, FlxG.width, "Global Game Jam 2010 - Chalmers/GU" );
			text3.setFormat( null, 8, 0xFFFFFFFF, "center" );
			this.add( text );
			this.add( text1);
			this.add( text2);
			this.add( text3);
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