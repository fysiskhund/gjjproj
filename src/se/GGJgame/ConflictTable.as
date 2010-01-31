package se.GGJgame
{
	
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	public class ConflictTable
	{
		[Embed( source='../../../resources/monkey.png' )] private var ImgMonkey:Class;
		[Embed( source='../../../resources/monkey_ninja.png' )] private var ImgNinja:Class;
		
		public var ct:Array;
		private var _numTeams:int;
		
		// The amount of time a conflict will rage on (in seconds)
		private var conflictTimeShort:Number = 10;
		private var conflictTimeLong:Number = 25;
		private var _gs:GameState = (FlxG.state as GameState);
		
		public function ConflictTable(numTeams:int=5)
		{
			ct = new Array(numTeams);
			_numTeams = numTeams;
			
			for (var i:int=0; i<numTeams; i++)
			{
				ct[i] = new Array(numTeams);
				for (var j:int = 0; j < numTeams; j++)
				{
					ct[i][j] = -1;		
				}
			}			
		}
		public function setAtWar(team0:int, team1:int):void
		{
			var conflictTime:Number;
			conflictTime = conflictTimeShort;
			
			
			
			if(team0 > 4)
			{
				team0 -= 4;
				conflictTime = conflictTimeLong;
			}
			if(team1 > 4)
			{
				team1 -= 4;
				conflictTime = conflictTimeLong;
			}
			
			if(team0 == team1)
				return;
			
			// Prevent from extending time by repeatedly pestering someone
			if (ct[team0][team1] < 0) 
			{
				ct[team0][team1] = conflictTime;
			}
		}
		public function getAtWar(team0:int, team1:int):Boolean
		{
			if(team0 == 9 || team1 == 9)
				return false;
			if(team0 > 4)
				team0 -= 4;
			if(team1 > 4)
				team1 -= 4;
				
			return (ct[team0][team1] > 0);
		}
		public function update():void
		{
			for (var i:int = 0; i < _numTeams; i++)
			{
				for (var j:int = 0; j < _numTeams; j++)
				{
					if (ct[i][j] > 0)
					{
						ct[i][j] -= FlxG.elapsed;
						
						// Restore guards' sprites once conflict is over
						// in case they were fighting..
						if (ct[i][j] < 0)
						{
							for each (var monkey:Monkey in _gs.npcs)
							{
								if (monkey.team == i)
								{
									monkey.loadGraphic( ImgMonkey, true/* animated */, true, 14, 12 );
								}
							} 
							for each (var monkey:Monkey in _gs.ninjaNpcs)
							{
								if (monkey.team == i)
								{
									monkey.loadGraphic( ImgNinja, true/* animated */, true, 14, 12 );
								}
							}
						}
					}
				}
			} 
		}

	}
}