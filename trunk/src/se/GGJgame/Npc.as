package se.GGJgame
{
	import flash.geom.Point;
	
	import org.flixel.FlxG;

	public class Npc extends PreNpc
	{
		public function Npc( X:int=0, Y:int=0, SimpleGraphic:Class=null, monkeyTeam:int=0 )
		{
			super( X, Y, SimpleGraphic );
			_oPos = new Point(X, Y);
			team = monkeyTeam;
		}

		override public function update():void 
		{
			var gs:GameState = (FlxG.state as GameState);
			if(!gs.inGame)
				return;
			var p:Monkey = gs.player1;
			var d:Number;
			var d_o:Number = this.dist(this.x,this.y,_oPos.x,_oPos.y);
			
			d = this.dist(this.x,this.y,p.x,p.y);
			//Testing for enemy monkeys
			for each (var monkey:PreNpc in gs.ninjaNpcs)
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
			for each (var monkey:PreNpc in gs.npcs)
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
					this.velocity = new Point(0,0);
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
					loadGraphic(ImgMonkey,true,false, 14, 12 );
				}
			}

			super.update();
		}
		
	}
}