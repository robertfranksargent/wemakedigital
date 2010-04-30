package com.wemakedigital.ui.core.events 
{
	import flash.events.Event;
	
	/**
	 * Show and Hide events.
	 * 
	 * @see com.wemakedigital.ui.core.ShowHideComponent.
	 */
	public class ShowHideEvent extends Event 
	{	
		//----------------------------------------------------------------------
		//
		//  Constants
		//
		//----------------------------------------------------------------------
		
		/**
		 * Show complete event type.
		 */
		public static const SHOW_COMPLETE : String = "SHOW_COMPLETE" ;
		
		/**
		 * Hide complete event type.
		 */
		public static const HIDE_COMPLETE : String = "HIDE_COMPLETE" ;
		
		/**
		 * Show start event type.
		 */
		public static const SHOW_START : String = "SHOW_START" ;
		
		/**
		 * Hide start event type.
		 */
		public static const HIDE_START : String = "HIDE_START" ;
		
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function ShowHideEvent ( type : String, bubbles : Boolean = true, cancelable : Boolean = false )
		{
			super( type , bubbles , cancelable ) ;
		}
	}
}
