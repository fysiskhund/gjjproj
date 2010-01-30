package se.GGJgame
{
	import flash.geom.Point;
	
	import org.flixel.FlxG;

	public class Npc extends Monkey
	{
		[Embed( source='../../../resources/monkey_angry.png' )] private var AngryMonkey:Class;
		
		public var dirX:int;
		public var dirY:int;
		
		public var team:int;
		
		private var _oPos:Point;

		private var _move_speed:int = 40; // just a tweak
		
		public function Npc( X:int=0, Y:int=0, SimpleGraphic:Class=null, team:int=0 )
		{
			super( X, Y, SimpleGraphic );
			_oPos = new Point(X, Y);
			currentHat = team;
		}
		
		public function restart():void
		{
			this.x = _oPos.x;
			this.y = _oPos.y;
			this.velocity = new Point(0,0);
		}
				
		override public function update():void 
		{
			var gs:GameState = (FlxG.state as GameState);
			var p:Player = gs.player1;
			var d:Number = this.dist(this.x,this.y,p.x,p.y);
			var d_o:Number = this.dist(this.x,this.y,_oPos.x,_oPos.y);
			
			if(d < 10) {
				gs.die();
			}
			else if (d < 60) {
				this.velocity.x = p.x - this.x;
				this.velocity.y = p.y - this.y;
				this.velocity.normalize(_move_speed);
			}
			else if (d_o < 1) {
				this.velocity = new Point(0,0);
				
			}
			else
			{
				var dir:Point = new Point(_oPos.x - this.x, _oPos.y - this.y);
				dir.normalize(_move_speed);
				this.velocity = dir;
			}

			super.update();
		}
		
		private function dist(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			return Math.sqrt(Math.pow(x2-x1,2) + Math.pow(y2-y1,2));
		}
		
	}
}