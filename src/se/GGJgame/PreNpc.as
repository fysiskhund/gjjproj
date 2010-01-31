package se.GGJgame
{
	import flash.geom.Point;
	
	import org.flixel.FlxG;

	public class PreNpc extends Monkey
	{
		[Embed( source='../../../resources/monkey_angry.png' )] protected var AngryMonkey:Class;
		[Embed( source='../../../resources/fight.png' )] protected var FightImg:Class;
		
		public var dirX:int;
		public var dirY:int;
		
		
		protected var _oPos:Point;

		protected var _move_speed:int = 90; // just a tweak
		
		public const TEAM_NONE:int = 0;
		public const TEAM_BLUE:int = 1;
		public const TEAM_RED:int = 2;
		public const TEAM_PURPLE:int = 3;
		public const TEAM_TEAL:int = 4;
		public const TEAM_BLUE_BOSS:int = 5;
		public const TEAM_RED_BOSS:int = 6;
		public const TEAM_PURPLE_BOSS:int = 7;
		public const TEAM_TEAL_BOSS:int = 8;
		public const TEAM_KING:int = 9;
		
		public function PreNpc( X:int=0, Y:int=0, SimpleGraphic:Class=null, monkeyTeam:int=0 )
		{
			super( X, Y, SimpleGraphic );
			_oPos = new Point(X, Y);
			team = monkeyTeam;
		}
		
		public function restart():void
		{
			this.x = _oPos.x;
			this.y = _oPos.y;
			this.velocity = new Point(0,0);
		}
				
		override public function update():void 
		{
			

			super.update();
		}
		
		protected function dist(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			return Math.sqrt(Math.pow(x2-x1,2) + Math.pow(y2-y1,2));
		}
		
	}
}