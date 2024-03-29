package com.wemakedigital.ui.core 
{
	import com.wemakedigital.ui.core.CoreComponent;
	import com.wemakedigital.ui.core.events.ShowHideEvent;

	import flash.events.Event;

	/**
	 * Adds hide and show functionality to the core component.
	 */
	public class ShowHideComponent extends CoreComponent 
	{
		//----------------------------------------------------------------------
		//
		//  Properties
		//
		//----------------------------------------------------------------------
		
		/**
		 * The length of the show tween in seconds.
		 */
		public var showTime : Number = .2 ;

		/**
		 * The length of the hide tween in seconds.
		 */
		public var hideTime : Number = .2 ;

		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function ShowHideComponent ( )
		{
			super( ) ;
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
			this.onShowStart( ) ;
			this.removeEventListener( Event.ENTER_FRAME , this.onEnterFrameHide ) ;
			
			this.visible = true ;
			
			if ( animate )
			{
				this.addEventListener( Event.ENTER_FRAME , this.onEnterFrameShow ) ;
			}
			else
			{
				this.alpha = 1 ;	
				this.onShowComplete( ) ;
			}
		}

		/**
		 * Hide the sprite.
		 * 
		 * @param animate	Animate the visibility change or do it instantly. 
		 */
		public function hide ( animate : Boolean = true ) : void
		{
			this.onHideStart( ) ;
			this.removeEventListener( Event.ENTER_FRAME , this.onEnterFrameShow ) ;
			
			if ( animate )
			{
				this.addEventListener( Event.ENTER_FRAME , this.onEnterFrameHide ) ;
			}
			else
			{
				this.alpha = 0 ;	
				this.onHideComplete( ) ;
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
			if ( this.stage )
			{
				if ( this.alpha >= 1 )
				{
					this.alpha = 1 ;
					this.onShowComplete( ) ;
				}
				else
				{
					this.alpha += 1 / ( this.stage.frameRate * this.showTime ) ; 
				}
			}
			else
			{
				this.alpha = 1 ;
				this.onShowComplete( ) ;
			}
		}

		/**
		 * @private
		 */
		protected function onEnterFrameHide ( e : Event ) : void
		{
			if ( this.stage )
			{
				if ( this.alpha <= 0 )
				{
					this.alpha = 0 ;
					this.onHideComplete( ) ;
				}
				else
				{
					this.alpha -= 1 / ( this.stage.frameRate * this.hideTime ) ; 
				}
			}
			else
			{
				this.alpha = 0 ;
				this.onHideComplete( ) ;
			}
		}
		
		/**
		 * @private
		 */
		protected function onShowStart ( ) : void
		{
			this.dispatchEvent( new ShowHideEvent( ShowHideEvent.SHOW_START ) ) ;
		}

		/**
		 * @private
		 */
		protected function onHideStart ( ) : void
		{
			this.dispatchEvent( new ShowHideEvent( ShowHideEvent.HIDE_START ) ) ;			
		}

		/**
		 * @private
		 */
		protected function onShowComplete ( ) : void
		{
			this.removeEventListener( Event.ENTER_FRAME , this.onEnterFrameShow ) ;
			this.visible = true ;
			this.dispatchEvent( new ShowHideEvent( ShowHideEvent.SHOW_COMPLETE ) ) ;
		}

		/**
		 * @private
		 */
		protected function onHideComplete ( ) : void
		{
			this.removeEventListener( Event.ENTER_FRAME , this.onEnterFrameHide ) ;
			this.visible = false ;
			this.dispatchEvent( new ShowHideEvent( ShowHideEvent.HIDE_COMPLETE ) ) ;			
		}
	}
}
