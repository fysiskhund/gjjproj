package se.GGJgame
{

	
	import org.flixel.FlxSprite;
	import org.flixel.*;

	public class Sfx
	{
		[Embed(source = "../../../resources/playMusic.mp3")] public static var playSong:Class;
		
		public function Sfx()
		{
			
			
		}
		public function bgMusic():void
		{
			FlxG.play(playSong, 0.5, true);
		}
		
	}
}