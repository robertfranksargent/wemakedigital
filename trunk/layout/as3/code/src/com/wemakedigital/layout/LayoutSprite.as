package com.wemakedigital.layout 
{
	import gs.TweenMax;

	import flash.display.Sprite;
	import flash.events.Event;

	public class LayoutSprite extends Sprite 
	{	
		//----------------------------------------------------------------------
		//
		//  Variables
		//
		//----------------------------------------------------------------------
		
		/**
		 * The length of the show tween in seconds.
		 */
		public var showTime : Number = 0.3 ;
		
		/**
		 * The length of the hide tween in seconds.
		 */
		public var hideTime : Number = 0.3 ;
		
		/**
		 * @private
		 */
		protected var showHideTween : TweenMax ;
		
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
			if ( this.showHideTween ) this.showHideTween.pause() ;
			
			this.removeEventListener( Event.ENTER_FRAME , this.onEnterFrameShow ) ;
			this.removeEventListener( Event.ENTER_FRAME , this.onEnterFrameHide ) ;
			
			this.visible = true ;
			
			if ( animate )
			{
				this.addEventListener( Event.ENTER_FRAME , this.onEnterFrameShow ) ;
			}
			else
			{
				this.alpha = 1 ;	
				this.onShowComplete() ;
			}
		}
		
		/**
		 * Hide the sprite.
		 * 
		 * @param animate	Animate the visibility change or do it instantly. 
		 */
		public function hide ( animate : Boolean = true ) : void
		{
			if ( this.showHideTween ) this.showHideTween.pause() ;
			
			this.removeEventListener( Event.ENTER_FRAME , this.onEnterFrameShow ) ;
			this.removeEventListener( Event.ENTER_FRAME , this.onEnterFrameHide ) ;
			
			if ( animate )
			{
				this.addEventListener( Event.ENTER_FRAME , this.onEnterFrameHide ) ;
			}
			else
			{
				this.alpha = 0 ;	
				this.onHideComplete() ;
			}
		}
		
		//----------------------------------------------------------------------
		//
		//  Event Handlers
		//
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected function onEnterFrameShow ( e : Event ) : void
		{
			this.removeEventListener( Event.ENTER_FRAME , this.onEnterFrameShow ) ;
			this.showHideTween = TweenMax.to( this, this.showTime, { alpha : 1, onComplete : this.onShowComplete } ) ;
		}
		
		/**
		 * @private
		 */
		protected function onEnterFrameHide ( e : Event ) : void
		{
			this.removeEventListener( Event.ENTER_FRAME , this.onEnterFrameHide ) ;
			this.showHideTween = TweenMax.to( this, this.hideTime, { alpha : 0, onComplete : this.onHideComplete } ) ;
		}
		
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
