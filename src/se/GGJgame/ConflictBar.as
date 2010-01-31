package se.GGJgame
{
	import org.flixel.FlxLayer;
	import org.flixel.FlxSprite;

	public class ConflictBar extends FlxLayer
	{
		[Embed( source='../../../resources/hats.png' )] private var ImgHats:Class;
		private var _noConflicts:int;
		private var _bar:FlxSprite;
		private var _inside:FlxSprite
		private var _frame:FlxSprite
		
		//between 0-4
		public var position:int;
		
		public function ConflictBar():void
		{
			super( );
			//loadGraphic( ImgHats, false/* animated */, true, 14, 14 );
		}		
		override public function update():void 
		{
			
		}	
		
		public function addConflict( team1:int, team2:int, value:int, x:int ) {
			_frame = new FlxSprite(4,4);
			_frame.createGraphic(value + 2,8); //White frame for the health bar
			_frame.scrollFactor.x = _frame.scrollFactor.y = 0;
			_frame.x = x;
			
			
			this.add(_frame);
			
			_inside = new FlxSprite(5,5);
			_inside.createGraphic(value,6,0xff000000); 
			_inside.scrollFactor.x = _inside.scrollFactor.y = 0;
			_inside.x = x + 1;
			
			this.add(_inside);
			
			_bar = new FlxSprite(5,5);
			_bar.createGraphic(1,6,0xffff0000);
			_bar.scrollFactor.x = _bar.scrollFactor.y = 0;
			_bar.origin.x = _bar.origin.y = 0; 
			_bar.scale.x = value;
			_bar.x = x + 1; 
			this.add(_bar);
		}
		public function setValue( value:int ) {
			_bar.scale.x = value;
		}
		public function offsetX( value:int ) {
			_bar.x = value;
			_inside.x = value;
			_frame.x = value;
		}
	}
}