package se.GGJgame
{
	public class ConflictTable
	{
		private var _ct:Array;
		public function ConflictTable(numTeams:int=4)
		{
			_ct = new Array(numTeams);
			for (i=0; i<numTeams; i++)
			{
				_ct[i] = new Array(numTeams);
				for (j = 0; j < numTeams; j++)
				{
					_ct[i][j] = false;
				}
			}
			
		}
		public function setAtWar(team0:int, team1:int):void
		{
			_ct[i][j] = true;
			// Perhaps do some other stuff i.e. send guards to fight with each other
		}
		public function getAtWar(team0:int, team1:int):Boolean
		{
			return _ct[i][j];
		}

	}
}