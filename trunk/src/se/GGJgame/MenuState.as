package se.GGJgame
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxText;

	public class MenuState extends FlxState
	{
		//[Embed( Source = "../mypath")]
		[Embed(source='../../../resources/monkey.png')] private var ImgPlayer:Class;
		protected var titleImage:Class;
		var text:FlxText = new FlxText( 0, (FlxG.width / 2), FlxG.width, "HAISAN!" );
		var p:Player = new Player(0,0,ImgPlayer);
		
		public function MenuState()
		{
			super();
			//var text:FlxText = new FlxText( 0, (FlxG.width / 2), FlxG.width, "HAISAN!" );
			text.setFormat( null, 16, 0xFFFFFFFF, "center" );
			this.add( text );
			this.add(p);
			
		}
		
		//updates to be done in MenuState
		override public function update():void 
		{
			super.update();
			p.update();
		}
		
	}
}