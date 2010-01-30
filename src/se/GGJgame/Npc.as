package se.GGJgame
{
	import flash.geom.Point;
	
	import org.flixel.FlxG;

	public class Npc extends Monkey
	{
		[Embed( source='../../../resources/monkey_angry.png' )] private var AngryMonkey:Class;
		[Embed( source='../../../resources/fight.png' )] private var FightImg:Class;
		
		public var dirX:int;
		public var dirY:int;
		
		
		private var _oPos:Point;

		private var _move_speed:int = 90; // just a tweak
		
		public function Npc( X:int=0, Y:int=0, SimpleGraphic:Class=null, monkeyTeam:int=0 )
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
			var gs:GameState = (FlxG.state as GameState);
			var p:Monkey = gs.player1;
			var d:Number;
			var d_o:Number = this.dist(this.x,this.y,_oPos.x,_oPos.y);
			
			d = this.dist(this.x,this.y,p.x,p.y);
			//Testing for enemy monkeys
			for each (var monkey:Npc in gs.npcs)
			{
				if (gs.conflicts.getAtWar(team, monkey.team))
				{
					var dNpc:Number;
					dNpc = dist(x, y, monkey.x, monkey.y);
					
					if (dNpc < d) // Found a hostile closer
					{
						p = monkey; // Switch objective to that monkey
						d = dNpc; // Register new distance value
					}
				}
			}
			
			if(gs.conflicts.getAtWar(team, p.team))
			{
				if (d < 10) {
					//
					if (p == gs.player1)
						gs.die();
					loadGraphic(FightImg,true,false,19,19);
				} else if (d < 100) {
					// Stalk
					this.velocity.x = p.x - this.x;
					this.velocity.y = p.y - this.y;
					this.velocity.normalize(_move_speed);
				}
				else if (d_o < 1) {
					this.velocity = new Point(0,0);
					
				} else
				{
					var dir:Point = new Point(_oPos.x - this.x, _oPos.y - this.y);
					dir.normalize(_move_speed);
					this.velocity = dir;
				}	
			} else {
				if (d_o < 1) {
					this.velocity = new Point(0,0);
				} else
				{
					var dir:Point = new Point(_oPos.x - this.x, _oPos.y - this.y);
					dir.normalize(_move_speed);
					this.velocity = dir;
				}
			}

			super.update();
		}
		
		private function dist(x1:Number, y1:Number, x2:Number, y2:Number):Number
		{
			return Math.sqrt(Math.pow(x2-x1,2) + Math.pow(y2-y1,2));
		}
		
	}
}