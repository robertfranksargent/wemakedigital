package com.wemakedigital.layout 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;

	public class LayoutComponent extends Sprite
	{ 
		//----------------------------------------------------------------------
		//
		//  Variables
		//
		//----------------------------------------------------------------------
		
		private var _created : Boolean = false ;
		
		//----------------------------------------------------------------------
		
		private var _explicitWidth : Number = 0 ;
		private var _explicitHeight : Number = 0 ;
		private var _explicitMinWidth : Number = 0 ;
		private var _explicitMinHeight : Number = 0 ;
		private var _explicitMaxWidth : Number = NaN ;
		private var _explicitMaxHeight : Number = NaN ;

		//----------------------------------------------------------------------
		
		private var _fixedWidth : Number = NaN ;
		private var _fixedHeight : Number = NaN ;
		private var _fixedMinWidth : Number = 0 ;
		private var _fixedMinHeight : Number = 0 ;
		private var _fixedMaxWidth : Number = NaN ;
		private var _fixedMaxHeight : Number = NaN ;
		
		//----------------------------------------------------------------------
		
		private var _left : Number = NaN ;
		private var _right : Number = NaN ;
		private var _top : Number = NaN ;
		private var _bottom : Number = NaN ;
		
		//----------------------------------------------------------------------
		
		private var _horizontalCentre : Number = NaN ;
		private var _verticalCentre : Number = NaN ;
		
		//----------------------------------------------------------------------
		
		private var _relativeWidth : Number = NaN ;
		private var _relativeHeight : Number = NaN ;
		private var _relativeMinWidth : Number = 0 ;
		private var _relativeMinHeight : Number = 0 ;
		private var _relativeMaxWidth : Number = NaN ;
		private var _relativeMaxHeight : Number = NaN ;
		
		//----------------------------------------------------------------------
		//
		//  Getters and Setters
		//
		//----------------------------------------------------------------------
		
		/**
		 * The created status of the component, true after createChildren is called after being added to the stage.
		 */
		public function get created ( ) : Boolean
		{
			return this._created ;
		}

		/**
		 * @private
		 */
		public function set created ( value : Boolean ) : void
		{
			if ( this.created != value ) this._created = value ;
		}
		
		//----------------------------------------------------------------------
		
		/**
		 * The explicit width of the component.
		 */
		internal function get explicitWidth () : Number
		{
			return this._explicitWidth ;
		}
		
		/**
		 * @private
		 */
		internal function set explicitWidth (value : Number) : void
		{
			this._explicitWidth = Math.max ( this.explicitMinWidth, isNaN ( this.explicitMaxWidth ) ? value : Math.min ( this.explicitMaxWidth, value ) ) ;
		}
		
		/**
		 * The explicit height of the component.
		 */
		internal function get explicitHeight () : Number
		{
			return this._explicitHeight ;
		}
		
		/**
		 * @private
		 */
		internal function set explicitHeight (value : Number) : void
		{
			this._explicitHeight = Math.max ( this.explicitMinHeight, isNaN ( this.explicitMaxHeight ) ? value : Math.min ( this.explicitMaxHeight, value ) ) ;
		}
		
		/**
		 * The minumum explicit width of the component.
		 */
		internal function get explicitMinWidth () : Number
		{
			return this._explicitMinWidth ;
		}
		
		/**
		 * @private
		 */
		internal function set explicitMinWidth (value : Number) : void
		{
			this._explicitMinWidth = Math.max ( 0, value ) ;
		}
		
		/**
		 * The minumum explicit height of the component.
		 */
		internal function get explicitMinHeight () : Number
		{
			return this._explicitMinHeight ;
		}
		
		/**
		 * @private
		 */
		internal function set explicitMinHeight (value : Number) : void
		{
			this._explicitMinHeight = Math.max ( 0, value ) ;
		}
		
		/**
		 * The maximum explicit width of the component.
		 */
		internal function get explicitMaxWidth () : Number
		{
			return this._explicitMaxWidth ;
		}
		
		/**
		 * @private
		 */
		internal function set explicitMaxWidth (value : Number) : void
		{
			this._explicitMaxWidth = Math.max ( 0, value ) ;
		}
		
		/**
		 * The maximum explicit height of the component
		 */
		internal function get explicitMaxHeight () : Number
		{
			return this._explicitMaxHeight ;
		}
		
		/**
		 * @private
		 */
		internal function set explicitMaxHeight (value : Number) : void
		{
			this._explicitMaxHeight = Math.max ( 0, value ) ;
		}
		
		//----------------------------------------------------------------------
		
		/**
		 * The fixed width of the component.
		 */
		public function get fixedWidth () : Number
		{
			return this._fixedWidth ;
		}
		
		/**
		 * @private
		 */
		public function set fixedWidth (value : Number) : void
		{
			this._fixedWidth = Math.max ( this.fixedMinWidth, isNaN ( this.fixedMaxWidth ) ? value : Math.min ( this.fixedMaxWidth, value ) ) ;
			
			// If the component has a fixed width it can't have a relative width.
			this._relativeWidth = NaN ;
		}
		
		/**
		 * The fixed height of the component.
		 */
		public function get fixedHeight () : Number
		{
			return this._fixedHeight ;
		}
		
		/**
		 * @private
		 */
		public function set fixedHeight (value : Number) : void
		{
			this._fixedHeight = Math.max ( this.fixedMinHeight, isNaN ( this.fixedMaxHeight ) ? value : Math.min ( this.fixedMaxHeight, value ) ) ;
			
			// If the component has a fixed height it can't have a relative height.
			this._relativeHeight = NaN ;
		}
		
		/**
		 * The minumum fixed width of the component.
		 */
		public function get fixedMinWidth () : Number
		{
			return this._fixedMinWidth ;
		}
		
		/**
		 * @private
		 */
		public function set fixedMinWidth (value : Number) : void
		{
			this._fixedMinWidth = Math.max ( 0, value ) ;
		}
		
		/**
		 * The minumum fixed height of the component.
		 */
		public function get fixedMinHeight () : Number
		{
			return this._fixedMinHeight ;
		}
		
		/**
		 * @private
		 */
		public function set fixedMinHeight (value : Number) : void
		{
			this._fixedMinHeight = Math.max ( 0, value ) ;
		}
		
		/**
		 * The maximum fixed width of the component.
		 */
		public function get fixedMaxWidth () : Number
		{
			return this._fixedMaxWidth ;
		}
		
		/**
		 * @private
		 */
		public function set fixedMaxWidth (value : Number) : void
		{
			this._fixedMaxWidth = Math.max ( 0, value ) ;
		}
		
		/**
		 * The maximum fixed height of the component
		 */
		public function get fixedMaxHeight () : Number
		{
			return this._fixedMaxHeight ;
		}
		
		/**
		 * @private
		 */
		public function set fixedMaxHeight (value : Number) : void
		{
			this._fixedMaxHeight = Math.max ( 0, value ) ;
		}
		
		//----------------------------------------------------------------------
		
		/**
		 * Anchor padding from the left of the container.
		 */
		public function get left () : Number
		{
			return this._left ;
		}
		
		/**
		 * @private
		 */
		public function set left (value : Number) : void
		{
			this._left = Math.max ( 0, value ) ;
			
			// If the component has left and right anchors it can't have a fixed or relative width.
			if ( ! isNaN ( this._top ) && ! isNaN ( this._bottom ) ) 
			{
				this._fixedWidth = NaN ;
				this._relativeWidth = NaN ;
			}
		}
		
		/**
		 * Anchor padding from the right of the container.
		 */
		public function get right () : Number
		{
			return this._right ;
		}
		
		/**
		 * @private
		 */
		public function set right (value : Number) : void
		{
			this._right = Math.max ( 0, value ) ;
			
			// If the component has left and right anchors it can't have a fixed or relative width.
			if ( ! isNaN ( this._top ) && ! isNaN ( this._bottom ) ) 
			{
				this._fixedWidth = NaN ;
				this._relativeWidth = NaN ;
			}
		}
		
		/**
		 * Anchor padding from the top of the container.
		 */
		public function get top () : Number
		{
			return this._top ;
		}
		
		/**
		 * @private
		 */
		public function set top (value : Number) : void
		{
			this._top = Math.max ( 0, value ) ;
			
			// If the component has top and bottom anchors it can't have a fixed or relative height.
			if ( ! isNaN ( this._top ) && ! isNaN ( this._bottom ) ) 
			{
				this._fixedHeight = NaN ;
				this._relativeHeight = NaN ;
			}
		}
		
		/**
		 * Anchor padding from the bottom of the container.
		 */
		public function get bottom () : Number
		{
			return this._bottom ;
		}
		
		/**
		 * @private
		 */
		public function set bottom (value : Number) : void
		{
			this._bottom = Math.max ( 0, value ) ;
			
			// If the component has top and bottom anchors it can't have a fixed or relative height.
			if ( ! isNaN ( this._top ) && ! isNaN ( this._bottom ) ) 
			{
				this._fixedHeight = NaN ;
				this._relativeHeight = NaN ;
			}
		}
		
		//----------------------------------------------------------------------

		/**
		 * Anchor padding from the horizontal centre of the container.
		 */
		public function get horizontalCentre () : Number
		{
			return this._horizontalCentre ;
		}
		
		/**
		 * @private
		 */
		public function set horizontalCentre (value : Number) : void
		{
			this._horizontalCentre = value ;
			
			// If the component has a horizontal centre anchor it can't have a left or right anchor.
			this._left = NaN ;
			this._right = NaN ;
		}

		/**
		 * Anchor padding from the vertical centre of the container.
		 */
		public function get verticalCentre () : Number
		{
			return this._verticalCentre ;
		}
		
		/**
		 * @private
		 */
		public function set verticalCentre (value : Number) : void
		{
			this._verticalCentre = value ;
			
			// If the component has a vertical centre anchor it can't have a top or bottom anchor.
			this._top = NaN ;
			this._bottom = NaN ;
		}
		
		//----------------------------------------------------------------------
		
		/**
		 * The relative width of the component.
		 */
		public function get relativeWidth () : Number
		{
			return this._relativeWidth ;
		}
		
		/**
		 * @private
		 */
		public function set relativeWidth (value : Number) : void
		{
			this._relativeWidth = Math.max ( this.relativeMinWidth, isNaN ( this.relativeMaxWidth ) ? value : Math.min ( this.relativeMaxWidth, value ) ) ;
			
			// If the component has a relative width it can't have a fixed width.
			this._fixedWidth = NaN ;
		}
		
		/**
		 * The relative height of the component.
		 */
		public function get relativeHeight () : Number
		{
			return this._relativeHeight ;
		}
		
		/**
		 * @private
		 */
		public function set relativeHeight (value : Number) : void
		{
			this._relativeHeight = Math.max ( this.relativeMinHeight, isNaN ( this.relativeMaxHeight ) ? value : Math.min ( this.relativeMaxHeight, value ) ) ;
			
			// If the component has a relative height it can't have a fixed height.
			this._fixedHeight = NaN ;
		}
		
		/**
		 * The minumum relative width of the component.
		 */
		public function get relativeMinWidth () : Number
		{
			return this._relativeMinWidth ;
		}
		
		/**
		 * @private
		 */
		public function set relativeMinWidth (value : Number) : void
		{
			this._relativeMinWidth = Math.max ( 0, value ) ;
		}
		
		/**
		 * The minumum relative height of the component.
		 */
		public function get relativeMinHeight () : Number
		{
			return this._relativeMinHeight ;
		}
		
		/**
		 * @private
		 */
		public function set relativeMinHeight (value : Number) : void
		{
			this._relativeMinHeight = Math.max ( 0, value ) ;
		}
		
		/**
		 * The maximum relative width of the component.
		 */
		public function get relativeMaxWidth () : Number
		{
			return this._relativeMaxWidth ;
		}
		
		/**
		 * @private
		 */
		public function set relativeMaxWidth (value : Number) : void
		{
			this._relativeMaxWidth = Math.max ( 0, value ) ;
		}
		
		/**
		 * The maximum relative height of the component
		 */
		public function get relativeMaxHeight () : Number
		{
			return this._relativeMaxHeight ;
		}
		
		/**
		 * @private
		 */
		public function set relativeMaxHeight (value : Number) : void
		{
			this._relativeMaxHeight = Math.max ( 0, value ) ;
		}
		
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function LayoutComponent ()
		{
			this.addEventListener( Event.ADDED_TO_STAGE , this.onAddedToStage ) ;
		}
		
		//----------------------------------------------------------------------
		//
		//  Methods
		//
		//----------------------------------------------------------------------

		/**
		 * @inheritDoc
		 */
		override public function addChild ( child : DisplayObject ) : DisplayObject
		{
			return child && ! this.contains( child ) ? super.addChild( child ) : child ;
		}

		/**
		 * @inheritDoc
		 */
		override public function removeChild ( child : DisplayObject ) : DisplayObject
		{
			return child && this.contains( child ) ? super.removeChild( child ) : child ;
		}
		
		/**
		 * Called when the component is added to the stage.
		 */
		protected function createChildren ( ) : void
		{
			this.created = true ; 
		}

		/**
		 * Called when the component is removedfrom the stage.
		 */
		protected function removeChildren ( ) : void
		{
			this.created = false ;
		}
		
		/**
		 * Called when the component properties change.
		 */
		public function updateProperties ( ) : void
		{
		}

		/**
		 * Called when the component display changes.
		 */
		public function updateDisplay () : void
		{
			// TODO temp code
			this.graphics.clear() ;
			this.graphics.beginFill( 0x000000, 0.2 ) ;
			this.graphics.drawRect( 0, 0, this.explicitWidth, this.explicitHeight ) ;
		}
		
		//----------------------------------------------------------------------
		//
		//  Event Handlers
		//
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected function onAddedToStage ( e : Event ) : void
		{
			this.removeEventListener( Event.ADDED_TO_STAGE , this.onAddedToStage ) ;	
			this.addEventListener( Event.REMOVED_FROM_STAGE , this.onRemovedFromStage ) ;
			
			if ( ! this.created ) this.createChildren( ) ;
			
			if ( this.created ) 
			{
				this.updateProperties( ) ;
				this.updateDisplay( ) ;
			}
		}

		/**
		 * @private
		 */
		protected function onRemovedFromStage ( e : Event ) : void
		{
			this.removeEventListener( Event.REMOVED_FROM_STAGE , this.onRemovedFromStage ) ;		
			this.addEventListener( Event.ADDED_TO_STAGE , this.onAddedToStage ) ;
			
			if ( this.created ) this.removeChildren( ) ;
		}
	}
}
