package se.GGJgame
{

	
	import org.flixel.FlxSprite;
	import org.flixel.*;

	public class Sfx
	{
		[Embed(source = "../../../resources/playMusic.mp3")] public static var playSong:Class;
		[Embed(source = "../../../resources/lose.mp3")] public static var loseFx:Class;
		[Embed(source = "../../../resources/win.mp3")] public static var winFx:Class;
		[Embed(source = "../../../resources/chatter.mp3")] public static var chatterFx:Class;
		[Embed(source = "../../../resources/bite.mp3")] public static var biteFx:Class;
		[Embed(source = "../../../resources/cloth.mp3")] public static var clothFx:Class;
		[Embed(source = "../../../resources/dink_c.mp3")] public static var dinkCFx:Class;
		[Embed(source = "../../../resources/throw.mp3")] public static var throwFx:Class;
		[Embed(source = "../../../resources/squash2.mp3")] public static var squashFx:Class;
		
		public function Sfx()
		{
			
			
		}
		public function bgMusic():void
		{
			FlxG.play(playSong, 0.4, true);
		}
		
		public function lose():void
		{
			FlxG.play(loseFx, 1, false);
		}
		public function win():void
		{
			FlxG.play(winFx, 1, false);
		}
		
		public function bite():void
		{
			FlxG.play(biteFx, 1, false);
		}
		
		public function chatter():void
		{
			FlxG.play(chatterFx, 1, false);
		}
		
		public function swapHats():void
		{
			FlxG.play(dinkCFx, 1, false);
		}
		
		public function throwPoo():void
		{
			FlxG.play(throwFx, 1, false);
		}
		
		public function pooHit():void
		{
			FlxG.play(squashFx, 1, false);
		}
		
	}
}