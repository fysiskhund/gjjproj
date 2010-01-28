package se.GGJgame
{	
	import flash.display.DisplayObject;
	
	import mx.core.UIComponent;
	
	//workaround class for the bitch of working with mxml and the fact that flixl uses flash.sprite
	public class DisplayObjectUIComponent extends UIComponent
	{
	 	public function DisplayObjectUIComponent( sprite:DisplayObject )
	  	{
			super();		 
			explicitHeight = sprite.height;
			explicitWidth = sprite.width;
						  
			addChild (sprite);
		}
	}
}