package com.wemakedigital.layout 
{
	import com.wemakedigital.layout.LayoutComponent;

	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;

	public class LayoutScrollbarVertical extends LayoutContainer 
	{
		//----------------------------------------------------------------------
		//
		//  Variables
		//
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected var mainContainer : LayoutVertical ;
		
		/**
		 * @private
		 */
		protected var barContainer : LayoutContainer ;
		
		/**
		 * @private
		 */
		protected var _scrollTarget : LayoutContainer ;
		
		/**
		 * @private
		 */
		protected var _background : LayoutComponent ;
		
		/**
		 * @private
		 */
		protected var _track : LayoutComponent ;
		
		/**
		 * @private
		 */
		protected var _barButton : LayoutComponent ;
		
		/**
		 * @private
		 */
		protected var _upButton : LayoutComponent ;

		/**
		 * @private
		 */
		protected var _downButton : LayoutComponent ;
		
		/**
		 * @private
		 */
		protected var dragging : Boolean = false ;
		
		//----------------------------------------------------------------------
		//
		//  Getters and Setters
		//
		//----------------------------------------------------------------------
		
		/**
		 * The layout controlled to scroll
		 */
		public function get scrollTarget () : LayoutContainer
		{
			return this._scrollTarget;
		}
		
		/**
		 * @private
		 */
		public function set scrollTarget ( value : LayoutContainer ) : void
		{
			if ( this._scrollTarget is LayoutContainer ) this.removeEventListener( LayoutComponentEvent.UPDATE_PROPERTIES , this.onTargetUpdateProperties ) ;
			this._scrollTarget = value ;
			if ( this._scrollTarget is LayoutContainer ) {
				this.addEventListener( LayoutComponentEvent.UPDATE_PROPERTIES , this.onTargetUpdateProperties ) ;
				this.onTargetUpdateProperties( null ) ;
			}
		}
		
		/**
		 * The default fixed width in pixels.
		 */
		public function get defaultWidth () : Number
		{
			return 16 ;
		}

		/**
		 * The scrollbar background component.
		 */
		public function get background () : LayoutComponent
		{
			if ( ! this._background )
			{ 
				this._background = new LayoutComponent() ;
				this._background.relativeWidth = 1 ;
				this._background.relativeHeight = 1 ;
			}
			return this._background ;
		}
		
		/**
		 * The scrollbar track component.
		 */
		public function get track () : LayoutComponent
		{
			if ( ! this._track )
			{ 
				this._track = new LayoutComponent() ;
				this._track.colour = 0x333333 ;
				this._track.relativeWidth = 1 ;
				this._track.relativeHeight = 1 ;
			} 
			return this._track ;
		}
		
		/**
		 * The scrollbar bar button component.
		 */
		public function get barButton () : LayoutComponent
		{
			if ( ! this._barButton )
			{ 
				this._barButton = new LayoutComponent() ;
				this._barButton.colour = 0x999999 ;
				this._barButton.relativeWidth = 1 ;
				this._barButton.relativeHeight = 0.5 ;
			} 
			return this._barButton ;
		}

		/**
		 * The scrollbar up button component.
		 */
		public function get upButton () : LayoutComponent
		{
			if ( ! this._upButton )
			{ 
				this._upButton = new LayoutComponent() ;
				this._upButton.colour = 0x666666 ;
				this._upButton.relativeWidth = 1 ;
				this._upButton.fixedHeight = this.defaultWidth ;
			} 
			return this._upButton ;
		}
		
		/**
		 * The scrollbar down button component.
		 */
		public function get downButton () : LayoutComponent
		{
			if ( ! this._downButton )
			{ 
				this._downButton = new LayoutComponent() ;
				this._downButton.colour = 0x666666 ;
				this._downButton.relativeWidth = 1 ;
				this._downButton.fixedHeight = this.defaultWidth ;
			} 
			return this._downButton ;
		}
		
		//----------------------------------------------------------------------
		
		protected function get dragArea () : Rectangle
		{
			return new Rectangle( 0, 0, 0, this.created && this.scrollTarget ? Math.ceil( this.barContainer.explicitHeight - this.barButton.explicitHeight ) : 0 ) ;
		}
		
		//----------------------------------------------------------------------
		//
		//  Getters and Setters
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function LayoutScrollbarVertical ()
		{
			super( );
		}
		
		//----------------------------------------------------------------------
		//
		//  Methods
		//
		//----------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override public function removeChildren ( ) : void
		{
			super.removeChildren() ;
			
			this._background = null ;
			this._track = null ;
			this._barButton = null ;
			this._upButton = null ;
			this._downButton = null ;
			
			this.upButton.removeEventListener( MouseEvent.MOUSE_DOWN , this.onUpButtonPress ) ;
			this.downButton.removeEventListener( MouseEvent.MOUSE_DOWN , this.onDownButtonPress ) ;
			this.barButton.removeEventListener( MouseEvent.MOUSE_DOWN , this.onBarButtonPress ) ;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function createChildren ( ) : void
		{
			this.mainContainer = new LayoutVertical () ;
			this.mainContainer.anchor = LayoutVertical.TOP ;
			this.mainContainer.relativeWidth = 1 ;
			this.mainContainer.relativeHeight = 1 ;
			
			this.barContainer = new LayoutContainer () ;
			this.barContainer.relativeWidth = 1 ;
			this.barContainer.remainingHeight = 1 ;	
					
			this.addChild( this.background ) ;			
			this.addChild( this.mainContainer ) ;
			this.mainContainer.addChild( this.upButton ) ;
			this.barContainer.addChild( track ) ;
			this.barContainer.addChild( barButton ) ;
			this.mainContainer.addChild( this.barContainer ) ;			
			this.mainContainer.addChild( this.downButton ) ;
			
			this.upButton.buttonMode = true ;
			this.downButton.buttonMode = true ;
			this.barButton.buttonMode = true ;
			
			this.upButton.addEventListener( MouseEvent.MOUSE_DOWN , this.onUpButtonPress ) ;
			this.downButton.addEventListener( MouseEvent.MOUSE_DOWN , this.onDownButtonPress ) ;
			this.barButton.addEventListener( MouseEvent.MOUSE_DOWN , this.onBarButtonPress ) ;
			
			super.createChildren() ;
		}
		
		//----------------------------------------------------------------------
		//
		//  Event Handlers
		//
		//----------------------------------------------------------------------

		protected function onTargetUpdateProperties ( e : LayoutComponentEvent ) : void
		{
			if ( this.created && this.scrollTarget )
			{ 
				this.barButton.relativeHeight = this.scrollTarget.explicitHeight / this.scrollTarget.heightOfChildren ;
				this.barButton.top = ( this.barContainer.explicitHeight - this.barButton.explicitHeight ) * this.scrollTarget.scrollVertical ;
				this.visible = this.barButton.relativeHeight < 1 ;
			}
		}
		
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected function onUpButtonPress ( e : MouseEvent ) : void
		{
			this.stage.addEventListener( Event.ENTER_FRAME, this.onEnterFrameUpButtonPressed ) ;
			this.stage.addEventListener( MouseEvent.MOUSE_UP, onUpButtonRelease ) ;
		}
		
		/**
		 * @private
		 */
		protected function onUpButtonRelease ( e : MouseEvent ) : void
		{
			this.stage.removeEventListener( Event.ENTER_FRAME, this.onEnterFrameUpButtonPressed ) ;
			this.stage.removeEventListener( MouseEvent.MOUSE_UP, onUpButtonRelease ) ;
		}

		/**
		 * @private
		 */
		protected function onDownButtonPress ( e : MouseEvent ) : void
		{
			this.stage.addEventListener( Event.ENTER_FRAME, this.onEnterFrameDownButtonPressed ) ;
			this.stage.addEventListener( MouseEvent.MOUSE_UP, onDownButtonRelease ) ;
		}
		
		/**
		 * @private
		 */
		protected function onDownButtonRelease ( e : MouseEvent ) : void
		{
			this.stage.removeEventListener( Event.ENTER_FRAME, this.onEnterFrameDownButtonPressed ) ;
			this.stage.removeEventListener( MouseEvent.MOUSE_UP, onDownButtonRelease ) ;
		}
		
		/**
		 * @private
		 */
		protected function onBarButtonPress ( e : MouseEvent ) : void
		{
			this.barButton.startDrag( false, this.dragArea ) ;
			this.dragging = true ;
			this.stage.addEventListener( Event.ENTER_FRAME, this.onEnterFrameDragBarButton ) ;
			this.stage.addEventListener( MouseEvent.MOUSE_UP, onBarButtonRelease ) ;
		}
		
		/**
		 * @private
		 */
		protected function onBarButtonRelease ( e : MouseEvent ) : void
		{
			this.barButton.stopDrag() ;
			this.dragging = false ;
			this.stage.removeEventListener( MouseEvent.MOUSE_UP, onBarButtonRelease ) ;
		}
		
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected function onEnterFrameDragBarButton ( e : Event ) : void
		{
			this.barButton.top = this.barButton.y ;
			var scroll : Number = this.barButton.top / ( this.barContainer.explicitHeight - this.barButton.explicitHeight ) ;
			this.scrollTarget.scrollVertical = scroll - ( scroll - this.scrollTarget.scrollVertical ) / 1.4 ;
			if ( this.scrollTarget.scrollVertical == scroll && !dragging ) this.stage.removeEventListener( Event.ENTER_FRAME, this.onEnterFrameDragBarButton ) ;
		}
		
		/**
		 * @private
		 */
		protected function onEnterFrameUpButtonPressed ( e : Event ) : void
		{
			this.scrollTarget.scrollVertical -= 0.04 ;
			this.barButton.top = ( this.barContainer.explicitHeight - this.barButton.explicitHeight ) * this.scrollTarget.scrollVertical ;
		}
		
		/**
		 * @private
		 */
		protected function onEnterFrameDownButtonPressed ( e : Event ) : void
		{
			this.scrollTarget.scrollVertical += 0.04 ;
			this.barButton.top = ( this.barContainer.explicitHeight - this.barButton.explicitHeight ) * this.scrollTarget.scrollVertical ;
		}
	}
}
