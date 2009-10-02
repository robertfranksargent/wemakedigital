package com.wemakedigital.layout 
{
	import flash.events.Event;

	public class LayoutComponentEvent extends Event 
	{
		//----------------------------------------------------------------------
		//
		//  Constants
		//
		//----------------------------------------------------------------------
		
		public static const UPDATE_PROPERTIES : String = "UPDATE_PROPERTIES" ;
		public static const UPDATE_DISPLAY : String = "UPDATE_DISPLAY" ;
		
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function LayoutComponentEvent (type : String, bubbles : Boolean = false, cancelable : Boolean = false)
		{
			super( type , bubbles , cancelable );
		}
	}
}
