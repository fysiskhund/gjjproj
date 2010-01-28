import flash.events.Event;

import org.flixel.*;
import se.GGJgame.*;

public function creationComplete():void {
	this.addChild( new DisplayObjectUIComponent( new GameSetup() ) );
}
public function enterFrame( e:Event ):void {
	undefined;
}
