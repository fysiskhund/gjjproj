package se.GGJgame
{

	
	import org.flixel.*;

	public class Sfx
	{
		private var _countStage:int;
		[Embed(source = "../../../resources/playMusic.mp3")] public static var playSong:Class;
		[Embed(source = "../../../resources/lose.mp3")] public static var loseFx:Class;
		[Embed(source = "../../../resources/win.mp3")] public static var winFx:Class;
		[Embed(source = "../../../resources/chatter.mp3")] public static var chatterFx:Class;
		[Embed(source = "../../../resources/bite.mp3")] public static var biteFx:Class;
		[Embed(source = "../../../resources/cloth.mp3")] public static var clothFx:Class;
		[Embed(source = "../../../resources/dink_c.mp3")] public static var dinkCFx:Class;
		[Embed(source = "../../../resources/throw.mp3")] public static var throwFx:Class;
		[Embed(source = "../../../resources/squash2.mp3")] public static var squashFx:Class;
		[Embed(source = "../../../resources/fly.mp3")] public static var flyFx:Class;
		[Embed(source = "../../../resources/beep.mp3")] public static var beepFx:Class;
		[Embed(source = "../../../resources/boop.mp3")] public static var boopFx:Class;
		[Embed(source = "../../../resources/bloop.mp3")] public static var bloopFx:Class;
		
		public function Sfx()
		{
			_countStage = 3;
			
			
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
		
		public function pooReady():void
		{
			FlxG.play(flyFx, 1, false);
		}
		public function misFire():void
		{
			FlxG.play(bloopFx, 1, false);
		}
		public function count3():void
		{
			if(_countStage < 3)
				return;
			_countStage--;
			FlxG.play(beepFx, 1, false);
			
		}
		public function count2():void
		{
			if(_countStage < 2)
				return;
			_countStage--;
			FlxG.play(beepFx, 1, false);
		}
		public function count1():void
		{
			if(_countStage < 1)
				return;
			_countStage--;
			FlxG.play(beepFx, 1, false);
		}
		public function countGo():void
		{
			if(_countStage < 0 || _countStage > 1)
				return;
			_countStage = 3;
			FlxG.play(boopFx, 1, false);
		}
		
	}
}