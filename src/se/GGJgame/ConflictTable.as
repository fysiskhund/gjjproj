package se.GGJgame
{
	import org.flixel.FlxG;
	
	public class ConflictTable
	{
		private var _ct:Array;
		
		// The amount of time a conflict will rage on (in seconds)
		private var conflictTime:Number = 30;
		
		public function ConflictTable(numTeams:int=5)
		{
			_ct = new Array(numTeams);
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
			_ct[team0][team1] = conflictTime;
			// Perhaps do some other stuff i.e. send guards to fight with each other
		}
		public function getAtWar(team0:int, team1:int):Boolean
		{
			return (_ct[team0][team1] > 0);
		}
		public function update():void
		{
			
		}

	}
}