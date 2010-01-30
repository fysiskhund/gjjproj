package se.GGJgame
{
	import org.flixel.FlxG;
	
	public class ConflictTable
	{
		private var _ct:Array;
		private var _numTeams:int;
		
		// The amount of time a conflict will rage on (in seconds)
		private var conflictTimeShort:Number = 25;
		private var conflictTimeLong:Number = 10;
		
		public function ConflictTable(numTeams:int=5)
		{
			_ct = new Array(numTeams);
			_numTeams = numTeams;
			
			for (var i:int=0; i<numTeams; i++)
			{
				_ct[i] = new Array(numTeams);
				for (var j:int = 0; j < numTeams; j++)
				{
					_ct[i][j] = -1;
					
				}
			}
			
		}
		public function setAtWar(team0:int, team1:int):void
		{
			var conflictTime:Number;
			conflictTime = conflictTimeShort;
			
			if(team0 == team1)
				return;
			
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

			// Prevent from extending time by repeatedly pestering someone
			if (_ct[team0][team1] < 0) 
			{
				_ct[team0][team1] = conflictTime;
			}
		}
		public function getAtWar(team0:int, team1:int):Boolean
		{
			if(team0 > 4)
				team0 -= 4;
			if(team1 > 4)
				team1 -= 4;
				
			return (_ct[team0][team1] > 0);
		}
		public function update():void
		{
			for (var i:int = 0; i < _numTeams; i++)
			{
				for (var j:int = 0; j < _numTeams; j++)
				{
					if (_ct[i][j] > 0)
					{
						_ct[i][j] -= FlxG.elapsed;
					}
				}
			} 
		}

	}
}