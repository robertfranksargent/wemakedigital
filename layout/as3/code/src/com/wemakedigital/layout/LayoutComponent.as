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
		
		protected var _container : LayoutContainer ;
		protected var _created : Boolean = false ;
		
		//----------------------------------------------------------------------
		
		protected var _explicitWidth : Number = 0 ;
		protected var _explicitHeight : Number = 0 ;
		protected var _explicitMinWidth : Number = 0 ;
		protected var _explicitMinHeight : Number = 0 ;
		protected var _explicitMaxWidth : Number = NaN ;
		protected var _explicitMaxHeight : Number = NaN ;

		//----------------------------------------------------------------------
		
		protected var _fixedWidth : Number = NaN ;
		protected var _fixedHeight : Number = NaN ;
		protected var _fixedMinWidth : Number = 0 ;
		protected var _fixedMinHeight : Number = 0 ;
		protected var _fixedMaxWidth : Number = NaN ;
		protected var _fixedMaxHeight : Number = NaN ;
		
		//----------------------------------------------------------------------
		
		protected var _left : Number = NaN ;
		protected var _right : Number = NaN ;
		protected var _top : Number = NaN ;
		protected var _bottom : Number = NaN ;
		
		//----------------------------------------------------------------------
		
		protected var _horizontalCentre : Number = NaN ;
		protected var _verticalCentre : Number = NaN ;
		
		//----------------------------------------------------------------------
		
		protected var _relativeWidth : Number = NaN ;
		protected var _relativeHeight : Number = NaN ;
		protected var _relativeMinWidth : Number = 0 ;
		protected var _relativeMinHeight : Number = 0 ;
		protected var _relativeMaxWidth : Number = NaN ;
		protected var _relativeMaxHeight : Number = NaN ;
		
		//----------------------------------------------------------------------
		
		protected var _colour : Number = NaN ;
		protected var _colourAlpha : Number = 1 ;
		
		//----------------------------------------------------------------------
		//
		//  Getters and Setters
		//
		//----------------------------------------------------------------------

		/**
		 * The component's layout container.
		 */
		public function get container ( ) : LayoutContainer
		{
			return this._container ;
		}

		/**
		 * @private
		 */
		public function set container ( value : LayoutContainer ) : void
		{
			if ( value is LayoutContainer ) this._container = value ;
		}

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
		public function get explicitWidth () : Number
		{
			return this._explicitWidth ;
		}
		
		/**
		 * @private
		 */
		public function set explicitWidth (value : Number) : void
		{
			this._explicitWidth = Math.max ( this.explicitMinWidth, isNaN ( this.explicitMaxWidth ) ? value : Math.min ( this.explicitMaxWidth, value ) ) ;
		}
		
		/**
		 * The explicit height of the component.
		 */
		public function get explicitHeight () : Number
		{
			return this._explicitHeight ;
		}
		
		/**
		 * @private
		 */
		public function set explicitHeight (value : Number) : void
		{
			this._explicitHeight = Math.max ( this.explicitMinHeight, isNaN ( this.explicitMaxHeight ) ? value : Math.min ( this.explicitMaxHeight, value ) ) ;
		}
		
		/**
		 * The minumum explicit width of the component.
		 */
		public function get explicitMinWidth () : Number
		{
			return this._explicitMinWidth ;
		}
		
		/**
		 * @private
		 */
		public function set explicitMinWidth (value : Number) : void
		{
			this._explicitMinWidth = Math.max ( 0, value ) ;
		}
		
		/**
		 * The minumum explicit height of the component.
		 */
		public function get explicitMinHeight () : Number
		{
			return this._explicitMinHeight ;
		}
		
		/**
		 * @private
		 */
		public function set explicitMinHeight (value : Number) : void
		{
			this._explicitMinHeight = Math.max ( 0, value ) ;
		}
		
		/**
		 * The maximum explicit width of the component.
		 */
		public function get explicitMaxWidth () : Number
		{
			return this._explicitMaxWidth ;
		}
		
		/**
		 * @private
		 */
		public function set explicitMaxWidth (value : Number) : void
		{
			this._explicitMaxWidth = Math.max ( 0, value ) ;
		}
		
		/**
		 * The maximum explicit height of the component
		 */
		public function get explicitMaxHeight () : Number
		{
			return this._explicitMaxHeight ;
		}
		
		/**
		 * @private
		 */
		public function set explicitMaxHeight (value : Number) : void
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
			
			this.updateProperties() ;
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
			
			this.updateProperties() ;
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
			
			this.updateProperties() ;
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
			
			this.updateProperties() ;
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
			
			this.updateProperties() ;
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
			
			this.updateProperties() ;
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
			
			this.updateProperties() ;
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
			
			this.updateProperties() ;
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
			
			this.updateProperties() ;
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
			
			this.updateProperties() ;
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
			
			this.updateProperties() ;
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
			
			this.updateProperties() ;
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
			
			this.updateProperties() ;
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
			
			this.updateProperties() ;
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
			
			this.updateProperties() ;
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
			
			this.updateProperties() ;
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
			
			this.updateProperties() ;
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
			
			this.updateProperties() ;
		}
		
		//----------------------------------------------------------------------
		
		/**
		 * Optional background colour for component
		 */
		public function get colour () : Number
		{
			return this._colour ;
		}
		
		/**
		 * @private
		 */
		public function set colour (value : Number) : void
		{
			this._colour = value ;
			
			this.updateDisplayColour() ;
		}
		
		/**
		 * Background colour alpha for component
		 */
		public function get colourAlpha () : Number
		{
			return this._colourAlpha ;
		}
		
		/**
		 * @private
		 */
		public function set colourAlpha (value : Number) : void
		{
			this._colourAlpha = value ;
			
			this.updateDisplayColour() ;
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
		 * Called when the component is removedfrom the stage.
		 */
		public function removeChildren ( ) : void
		{
			this.created = false ;
			for ( var i : uint = 0 , n : uint = this.numChildren ; i < n ; i++ )
			{
				var child : DisplayObject = this.getChildAt( i ) ;
				if ( child is LayoutComponent ) ( child as LayoutComponent).removeChildren() ;
				this.removeChild( child ) ;
			}
		}
		
		/**
		 * Called when the component properties change.
		 */
		public function updateProperties ( ) : void
		{
			if ( this.container ) this.container.updateDisplay() ;
		}

		/**
		 * Called when the component display changes.
		 */
		public function updateDisplay () : void
		{
			this.updateDisplayColour() ;
		}
		
		/**
		 * Called when the component is added to the stage.
		 */
		protected function createChildren ( ) : void
		{
			this.created = true ; 
			this.updateProperties() ;
		}
		
		private function updateDisplayColour () : void
		{
			if ( ! isNaN ( this.colour ) ) 
			{
				this.graphics.clear() ;
				this.graphics.beginFill( this.colour, this.colourAlpha ) ;
				this.graphics.drawRect( 0, 0, this.explicitWidth, this.explicitHeight ) ;
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
