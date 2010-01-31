package se.GGJgame
{
	import flash.geom.Point;
	
	import org.flixel.FlxG;
	
	public class NinjaNpc extends PreNpc
	{
		[Embed( source='../../../resources/monkey_ninja.png' )] private var ImgNinja:Class;
		public var ignorePlayer:Boolean;
		var gs:GameState = (FlxG.state as GameState);
		
		
		public function NinjaNpc(X:int=0, Y:int=0, SimpleGraphic:Class=null, monkeyTeam:int=0)
		{
			super(X, Y, SimpleGraphic, monkeyTeam);
			loadGraphic(ImgNinja, true, false,14,12);
		}
		override public function update():void 
		{
			
			var d:Number = 10000;
			var p:Monkey = null;
			var d_o:Number = this.dist(this.x,this.y,_oPos.x,_oPos.y);
			//Testing for enemy monkeys
			for each (var monkey:Monkey in gs.ninjaNpcs)
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
			if (p)
			{
				
				if (d < 10) {
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
				
			}
			super.update();
			
		}
		
	}
}