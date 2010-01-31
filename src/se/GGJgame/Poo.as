package se.GGJgame
{
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	
	public class Poo extends FlxSprite
	{
		[Embed(source="../../../resources/poo.png")] private var ImgPoo:Class;
		var iDirX:int;
		var iDirY:int;
		var ttl:Number;
		private var _move_speed:int = 120;
		
		public function Poo(X:int=0, Y:int=0, SimpleGraphic:Class=null)
		{
			super(X, Y, ImgPoo);
   			//addAnimation("throw",[0]);
   			//addAnimation("splat",[1], 150, false);
   			ttl = 0;

		}
		public function throwPoo(posX:int, posY:int, dirX:int, dirY:int):void
		{
			iDirX = dirX;
   			iDirY = dirY;
   			x = posX;
   			y = posY+6;
   			ttl = 0.5;
		}

		public function hit(n:Npc, p:Poo):void
		{
			if(ttl > 0)
			{
				ttl = 0;
				var gs:GameState = (FlxG.state as GameState);
				var playerTeam:int = gs.player1.team;
				var targetTeam:int = n.team;
				gs.sfx.pooHit();
				if(targetTeam == 9)
				{
					gs.win();
				}
				if(playerTeam != targetTeam && playerTeam > 0) {
					gs.conflicts.setAtWar(playerTeam,targetTeam);
					gs.conflicts.setAtWar(targetTeam,playerTeam);
					gs.doCutScene();
				}
				
			}
			
		}
		override public function update():void 
		{
			ttl -= FlxG.elapsed;
			if (ttl > 0)
			{
				velocity.x = iDirX;
				velocity.y = iDirY;
				velocity.normalize(_move_speed);
			} else {
				velocity.x = 0;
				velocity.y = 0;
			}
			if (ttl > -5 && ttl < -1 ) {
				ttl = -10;
				visible = false;
			}
			super.update();
			
			
		}
		
	}
	
	
}