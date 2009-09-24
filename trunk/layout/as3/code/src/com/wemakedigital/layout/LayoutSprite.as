package com.wemakedigital.layout 
{
	import flash.display.Sprite;

	public class LayoutSprite extends Sprite 
	{
		//----------------------------------------------------------------------
		//
		//  Variables
		//
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected var _locked : Boolean ;
		
		//----------------------------------------------------------------------
		//
		//  Getters and Setters
		//
		//----------------------------------------------------------------------
		
		/**
		 * Locks the component's mouse and keyboard input.
		 */
		public function get locked () : Boolean
		{
			return this._locked ;
		}
		
		/**
		 * @private
		 */
		public function set locked ( value : Boolean ) : void
		{
			if ( this._locked != value )
			{
				this._locked = value ;
				this.mouseEnabled = ! value ;
				this.mouseChildren = ! value ;
				this.tabEnabled = ! value ;
				this.tabChildren = ! value ;
			}
		}
		
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function LayoutSprite ()
		{
		}
		
		//----------------------------------------------------------------------
		//
		//  Methods
		//
		//----------------------------------------------------------------------
		
		/**
		 * Show the sprite.
		 * 
		 * @param animate	Animate the visibility change or do it instantly. 
		 */
		public function show ( animate : Boolean = true ) : void
		{
			this.onShowComplete() ;
		}
		
		/**
		 * Hide the sprite.
		 * 
		 * @param animate	Animate the visibility change or do it instantly. 
		 */
		public function hide ( animate : Boolean = true ) : void
		{
			this.onHideComplete() ;
		}
		
		//----------------------------------------------------------------------
		//
		//  Event Handlers
		//
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected function onShowComplete () : void
		{
			this.visible = true ;
			this.dispatchEvent( new LayoutSpriteEvent ( LayoutSpriteEvent.SHOW_COMPLETE ) ) ;
		}
		
		/**
		 * @private
		 */
		protected function onHideComplete () : void
		{
			this.visible = false ;
			this.dispatchEvent( new LayoutSpriteEvent ( LayoutSpriteEvent.HIDE_COMPLETE ) ) ;			
		}
	}
}
