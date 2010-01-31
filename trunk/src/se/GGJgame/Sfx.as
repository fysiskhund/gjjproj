package se.GGJgame
{

	
	import org.flixel.FlxSprite;
	import org.flixel.*;

	public class Sfx
	{
		[Embed(source = "../../../resources/playMusic.mp3")] public static var playSong:Class;
		[Embed(source = "../../../resources/lose.mp3")] public static var loseFx:Class;
		[Embed(source = "../../../resources/win.mp3")] public static var winFx:Class;
		
		public function Sfx()
		{
			
			
		}
		public function bgMusic():void
		{
			FlxG.play(playSong, 0.5, true);
		}
		
		public function lose():void
		{
			FlxG.play(loseFx, 1, false);
		}
		public function win():void
		{
			FlxG.play(winFx, 1, false);
		}
		
	}
}