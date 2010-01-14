package com.wemakedigital.ui.core.events 
{
	import flash.events.Event;
	
	/**
	 * Render event.
	 * 
	 * @see com.wemakedigital.ui.core.CoreComponent.
	 */
	public class RenderEvent extends Event 
	{	
		//----------------------------------------------------------------------
		//
		//  Constants
		//
		//----------------------------------------------------------------------
		
		/**
		 * Dispatched when the component renders.
		 */
		public static const RENDER : String = "RENDER" ;
		
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function RenderEvent (type : String, bubbles : Boolean = true, cancelable : Boolean = false)
		{
			super( type , bubbles , cancelable );
		}
	}
}
