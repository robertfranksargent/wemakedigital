package com.wemakedigital.layout 
{
	import flash.events.Event;
	
	public class LayoutSpriteEvent extends Event 
	{
		//----------------------------------------------------------------------
		//
		//  Constants
		//
		//----------------------------------------------------------------------
		
		public static const SHOW_COMPLETE : String = "SHOW_COMPLETE" ;
		public static const HIDE_COMPLETE : String = "HIDE_COMPLETE" ;
		
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function LayoutSpriteEvent (type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super( type , bubbles , cancelable );
		}
	}
}
