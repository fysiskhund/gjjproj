package se.GGJgame
{
	public class Puzzle
	{
		public var pa:Array;
		private var _changes:Array;
		private var _nr:int;
		private var _nc:int;
		
		public function Puzzle(numRows:int, numCols:int)
		{
			_pa = new Array(numRows);
			_nr = numRows;
			_nc = numCols;
			
			for (var i:int=0; i<_nr; i++)
			{
				_ct[i] = new Array(_nc);
				for (var j:int = 0; j < _nc; j++)
				{
					// The array needs to be filled with the actual values externally
					_ct[i][j] = 0;
					
				}
			}
		}
		public function resolve(team0:int, team1:int)
		{
			// Message travels from col 0 to last col, starting from the 1st row
			// The message can only reach the people "in the front"; disabled people
			// let the message true
			// Disabled guys become their negative value, i.e. team 3 -> team -3
			var keepGoing:Boolean=true;
			var row:int = 0;
			while(keepGoing)
			{
				keepGoing = false;
				for (var col:int = 0; col < _nc; col++)
				{
					if (_ct[row][col] < 1)
					{
						
					}
				}
			}
		}
		

	}
}