package se.GGJgame
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;

	public class InstructionsState extends FlxState
	{
		//[Embed( Source = "../mypath")]
		[Embed(source = "../../../resources/banana.png")] public static var ImgBanana:Class;
		[Embed(source = "../../../resources/GUIpoo.png")] public static var ImgPoo:Class;
		[Embed(source = "../../../resources/hats.png")] public static var ImgHat:Class;
		protected var titleImage:Class;
		private var king:Monkey;
		private var text1:FlxText;
		private var text2:FlxText;
		
		
		public function InstructionsState()
		{
			super();
			FlxState.bgColor = 0xff262626;
			
			text1 = new FlxText( 10, 10, FlxG.width, "Instructions" );
			text1.setFormat( null, 16, 0xFFFFFFFF, "left" );
			this.add( text1 );
			
			text2 = new FlxText( 20, 35, FlxG.width, "1. Steer with [ARROW KEYS].\n\n" +
													 "2. Pick up       with [CTRL] to produce         .\n\n" +
													 "3. Pick up any of                    with [CTRL] to disguse as a tribe member.\n\n" +
													 "4. Throw         with [SPACE] at another monkey to cause a conflict\n     between the two tribes.\n\n" +
													 "5. Cause enough conflict to expose the       to attack." );
			text2.setFormat( null, 8, 0xFFCCCCCC, "left" );
			this.add( text2 );
			
			var text3:FlxText = new FlxText( 10, 150, FlxG.width, "Hints" );
			text3.setFormat( null, 16, 0xFFFFFFFF, "left" );
			this.add( text3 );
			
			var text4:FlxText = new FlxText( 20, 175, FlxG.width, "Escape by swapping to a hat that the chasing tribe likes.\n\n" + 
																   "Throw at tribe leaders to cause longer conflicts." );
			text4.setFormat( null, 8, 0xFFCCCCCC, "left" );
			this.add( text4 );
			
			king = new Monkey(215,126,null);
			king.team = 9;
			this.add(king);
			this.add(king._hatSprite);
			
			var ban1:FlxSprite = new FlxSprite(71,54);
			ban1.loadGraphic(ImgBanana);
			this.add(ban1);
			
			var poo1:FlxSprite = new FlxSprite(205,47);
			poo1.loadGraphic(ImgPoo,true);
			poo1.specificFrame(6);
			this.add(poo1);
			
			var poo2:FlxSprite = new FlxSprite(70,86.5);
			poo2.loadGraphic(ImgPoo,true);
			poo2.specificFrame(6);
			this.add(poo2);
			
			var hat1:FlxSprite = new FlxSprite(90,76);
			hat1.loadGraphic(ImgHat,true,false,71,9);
			hat1.specificFrame(0);
			
			this.add(hat1);
			
			var text:FlxText = new FlxText( 0, 220, FlxG.width, "Press [Enter] to play" );
			text.setFormat( null, 8, 0xFFFFFFFF, "center" );
			this.add( text );
			
		}
		
		//updates to be done in MenuState
		override public function update():void 
		{		   
			super.update();
			king.update();
			if (FlxG.keys.ENTER)
			{
				FlxG.switchState(GameState);
			}
		}
		
	}
}