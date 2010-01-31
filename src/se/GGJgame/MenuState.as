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
		[Embed(source = "../../../resources/banana.png")] public static var ImgBanana:Class;
		[Embed(source = "../../../resources/GUIpoo.png")] public static var ImgPoo:Class;
		[Embed(source = "../../../resources/hats.png")] public static var ImgHat:Class;
		private var player1:Player;
		private var e:FlxEmitter;
		private var _fx:FlxSprite;
		private var inSecond:Boolean;
		private var menu1:Array;
		private var menu2:Array;
		protected var titleImage:Class;
		public var inGame:Boolean;
		
		public function MenuState()
		{
			super();
			inGame = false;
			inSecond = false;
			
			var sfx:Sfx = new Sfx();
			sfx.menuMusic();
			
			menu1 = new Array();
			menu2 = new Array();
			
			player1 = new Player();
			FlxState.bgColor = 0xff262626;
				
			e = new FlxEmitter();
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
			var text1:FlxText = new FlxText( text.x, text.y +65, FlxG.width, "A game by:\nMarcus Antonsson, Andreas Karlsson and Alejandro Valenzuela" );
			text1.setFormat( null, 8, 0xFFFFFFFF, "center" );
			var text2:FlxText = new FlxText( text.x, text.y + 100, FlxG.width, "Press [Enter] to play" );
			text2.setFormat( null, 16, 0xFFFFFFFF, "center" );
			
			var text3:FlxText = new FlxText( text.x, text.y + 150, FlxG.width, "Global Game Jam 2010 - Chalmers/GU" );
			text3.setFormat( null, 8, 0xFFFFFFFF, "center" );
			this.add( text );
			this.add( text1);
			this.add( text2);
			this.add( text3);
			menu1.push(text);
			menu1.push(text1);
			menu1.push(text2);
			menu1.push(text3);
			
			initMenu2();
			for each (var s:FlxSprite in menu2) {
				s.visible = false;
			}
			
			
		}
		
		private function toggleMenu():void {
			if(inSecond) {
				FlxG.switchState(GameState);
			} else {
				for each (var s3:FlxSprite in menu1) {
					s3.visible = false;
				}
				for each (var s4:FlxSprite in menu2) {
					s4.visible = true;
				}
				e.gravity = +50;
			}
			inSecond = !inSecond;
		}
		
		private function initMenu2():void {
			var text1:FlxText = new FlxText( 10, 10, FlxG.width, "Instructions" );
			text1.setFormat( null, 16, 0xFFFFFFFF, "left" );
			this.add( text1 );
			menu2.push(text1);
			
			var text2:FlxText = new FlxText( 20, 35, FlxG.width, "1. Steer with [ARROW KEYS].\n\n" +
													 "2. Pick up       with [CTRL] to produce         .\n\n" +
													 "3. Pick up any of                    with [CTRL] to disguse as a tribe member.\n\n" +
													 "4. Throw         with [SPACE] at another monkey to cause a conflict\n     between the two tribes.\n\n" +
													 "5. Cause enough conflict to expose the       to         attack." );
			text2.setFormat( null, 8, 0xFFCCCCCC, "left" );
			this.add( text2 );
			menu2.push(text2);
			
			var text3:FlxText = new FlxText( 10, 150, FlxG.width, "Hints" );
			text3.setFormat( null, 16, 0xFFFFFFFF, "left" );
			this.add( text3 );
			menu2.push(text3);
			
			var text4:FlxText = new FlxText( 20, 175, FlxG.width, "Escape by swapping to a hat that the chasing tribe likes.\n\n" + 
																   "Throw at tribe leaders to cause longer conflicts." );
			text4.setFormat( null, 8, 0xFFCCCCCC, "left" );
			this.add( text4 );
			menu2.push(text4);
			
			var king:Monkey = new Monkey(215,126,null);
			king.team = 9;
			this.add(king);
			this.add(king._hatSprite);
			menu2.push(king);
			menu2.push(king._hatSprite);
			
			var ban1:FlxSprite = new FlxSprite(71,54);
			ban1.loadGraphic(ImgBanana);
			this.add(ban1);
			menu2.push(ban1);
			
			var poo1:FlxSprite = new FlxSprite(205,47);
			poo1.loadGraphic(ImgPoo,true);
			poo1.specificFrame(6);
			this.add(poo1);
			menu2.push(poo1);
			
			var poo2:FlxSprite = new FlxSprite(70,86.5);
			poo2.loadGraphic(ImgPoo,true);
			poo2.specificFrame(6);
			this.add(poo2);
			menu2.push(poo2);
			
			var poo3:FlxSprite = new FlxSprite(246,118);
			poo3.loadGraphic(ImgPoo,true);
			poo3.specificFrame(6);
			this.add(poo3);
			menu2.push(poo3);
			
			var hat1:FlxSprite = new FlxSprite(90,76);
			hat1.loadGraphic(ImgHat,true,false,71,9);
			hat1.specificFrame(0);
			this.add(hat1);
			menu2.push(hat1);
			
			var text:FlxText = new FlxText( 0, 220, FlxG.width, "Press [Enter] to play" );
			text.setFormat( null, 8, 0xFFFFFFFF, "center" );
			this.add( text );
			menu2.push(text);
		}
		
		
		//updates to be done in MenuState
		override public function update():void 
		{
			super.update();
			
  //FlxG.switchState(GameState);

			if (FlxG.keys.justReleased("ENTER"))
			{
				toggleMenu();
				//FlxG.switchState(InstructionsState);
			}
		}		
	}
}