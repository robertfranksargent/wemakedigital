package com.wemakedigital.layout 
{
	import com.wemakedigital.layout.LayoutComponent;

	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;

	[ DefaultProperty ( "children" ) ]

	public class LayoutContainer extends LayoutComponent 
	{
		//----------------------------------------------------------------------
		//
		//  Variables
		//
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected var content : Sprite ;
		
		/**
		 * @private
		 */
		protected var contentMask : Shape ;
		
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected var _maskChildren : Boolean = true ;

		/**
		 * @private
		 */
		protected var _children : Array ;
		
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected var definedWidthTotal : Number = 0 ;
		
		/**
		 * @private
		 */
		protected var definedHeightTotal : Number = 0 ;

		/**
		 * @private
		 */
		protected var widthTotal : Number = 0 ;
		
		/**
		 * @private
		 */
		protected var heightTotal : Number = 0 ;
		
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected var _scrollHorizontal : Number = 0 ;
		
		/**
		 * @private
		 */
		protected var _scrollVertical : Number = 0 ;

		//----------------------------------------------------------------------
		
		protected var _snapToPixels : Boolean = true ;
		
		//----------------------------------------------------------------------
		//
		//  Getters and Setters
		//
		//----------------------------------------------------------------------
		
		/**
		 * Mask children to the container size (default is true).
		 */
		public function get maskChildren () : Boolean
		{
			return this._maskChildren;
		}
		
		/**
		 * @private
		 */
		public function set maskChildren ( value : Boolean ) : void
		{
			if ( this._maskChildren != value ) 
			{
				this._maskChildren = value ;
				this.updateProperties() ;
			}
		}

		/**
		 * The children display objects held within
		 */
		public function get children () : Array
		{
			return this._children;
		}
		
		/**
		 * @private
		 */
		public function set children ( value : * ) : void
		{
			var valueArray : Array = value is Array ? value : [ value ] ;
			
			for each ( var child : DisplayObject in valueArray )
			{
				this.addChild( child ) ;
			}
		}
		
		//----------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override public function get widthMeasured () : Number
		{
			var max : Number = 0 ;
			for each ( var child : LayoutComponent in this.children )
			{
				if ( ( child.x + child.explicitWidth ) > max ) max = ( child.x + child.explicitWidth ) ;  
			}
			return max ;
		}

		/**
		 * @inheritDoc
		 */
		override public function get heightMeasured () : Number
		{
			var max : Number = 0 ;
			for each ( var child : LayoutComponent in this.children )
			{
				if ( (child.y + child.explicitHeight ) > max ) max = (child.y + child.explicitHeight ) ;  
			}
			return max ;
		}
		
		//----------------------------------------------------------------------
		
		/**
		 * The total remaining width for children with a remainingWidth property to fill.
		 */
		protected function get remainingWidthTotal () : Number
		{
			return this.explicitWidth - this.definedWidthTotal ;
		}
		
		/**
		 * The total remaining height for children with a remainingHeight property to fill.
		 */
		protected function get remainingHeightTotal () : Number
		{
			return this.explicitHeight - this.definedHeightTotal ;
		}
		
		//----------------------------------------------------------------------
		
		/**
		 * The horizontal scroll ratio between 0 (scrolled to left) and 1 (scrolled to right).
		 */
		public function get scrollHorizontal () : Number
		{
			return this._scrollHorizontal;
		}
		
		/**
		 * @private
		 */
		public function set scrollHorizontal ( value : Number ) : void
		{
			this._scrollHorizontal = Math.max ( 0 , Math.min ( 1, value ) ) ;
			this.updateScrolling() ;
		}
		
		/**
		 * The vertical scroll ratio between 0 (scrolled to top) and 1 (scrolled to bottom).
		 */
		public function get scrollVertical () : Number
		{
			return this._scrollVertical;
		}
		
		/**
		 * @private
		 */
		public function set scrollVertical ( value : Number ) : void
		{
			this._scrollVertical = Math.max ( 0 , Math.min ( 1, value ) ) ;
			this.updateScrolling() ;
		}

		//----------------------------------------------------------------------
		
		/**
		 * Snap children to pixels.
		 */
		public function get snapToPixels () : Boolean
		{
			return this._snapToPixels;
		}
		
		/**
		 * @private
		 */
		public function set snapToPixels ( value : Boolean ) : void
		{
			this._snapToPixels = value ;
			this.updateProperties() ;
		}

		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Class contructor.
		 */
		public function LayoutContainer ()
		{
			this.content = new Sprite() ;
			this.contentMask = new Shape() ;
			super.addChild( this.content ) ;
			super.addChild( this.contentMask ) ;
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
			if ( child && ! this.content.contains( child ) )
			{
				if ( this.children ) this._children.push( child ) ;
				else this._children = [ child ] ;
				if ( child is LayoutComponent ) ( child as LayoutComponent ).container = this;
				this.content.addChild( child ) ;
				if ( this.created ) 
				{
					this.updateProperties( ) ;
					// TODO don't think this is needed: this.updateDisplay( ) ;
				}
			}
			return child ;
		}

		/**
		 * @inheritDoc
		 */
		override public function removeChild ( child : DisplayObject ) : DisplayObject
		{
			if ( child && this.content.contains( child ) )
			{
				this.content.removeChild( child ) ;
				if ( this.children ) 
				{
					this._children.splice( this._children.indexOf( child ), 1 ) ;
					if ( this.created ) 
					{
						this.updateProperties( ) ;
						// TODO don't think this is needed: this.updateDisplay( ) ;
					}
				}
			}
			return child ;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeChildren ( ) : void
		{
			this.created = false ;
			if( this._children ) while( this._children.length > 0 ) this.removeChild( this._children[ 0 ] as DisplayObject ) ;
		}
		
		public function getScrollHorizontalToChild ( child : DisplayObject ) : Number
		{
			if ( this.content.contains( child ) )
			{
				return child.x / Math.abs( this.explicitWidth - this.widthTotal ) ;
			}
			return 0 ;
		}
		
		public function getScrollVerticalToChild ( child : DisplayObject ) : Number
		{
			if ( this.content.contains( child ) )
			{
				return child.y / Math.abs( this.explicitHeight - this.heightTotal ) ;
			}
			return 0 ;
		}
		
		/**
		 * @private
		 */
		protected function updateScrolling () : void
		{
			this.content.x = ( this.widthTotal <= this.explicitWidth ? 0 : this.scrollHorizontal ) * ( this.explicitWidth - this.widthTotal ) ;
			this.content.y = ( this.heightTotal <= this.explicitHeight ? 0 : this.scrollVertical ) * ( this.explicitHeight - this.heightTotal ) ;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function updateProperties () : void
		{
			if ( this.created )
			{
				this.content.mask = this.maskChildren ? this.contentMask : null ;
			}
			super.updateProperties() ;
		}
		
		public function childUpdatedProperties() : void
		{
			if ( this.autoWidth || this.autoHeight ) 
			{
				this.updateDisplay() ;
				this.updateProperties() ;
			}
			else this.updateDisplay() ;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function updateDisplay () : void
		{
			if ( this.created )
			{
				this.contentMask.graphics.clear() ;
				if ( this.maskChildren )
				{
					this.contentMask.graphics.beginFill( 0x000000, 0 ) ;
					this.contentMask.graphics.drawRect(0, 0, this.explicitWidth, this.explicitHeight ) ;
				}
			}
			if ( this.children ) this.updateDisplayChildren() ;
			this.updateScrolling() ;
			super.updateDisplay( ) ;
		}
		
		/**
		 * @private
		 */
		protected function updateDisplayChildren () : void
		{			
			this.updateDisplayChildrenDefinedSize() ;
			this.updateDisplayChildrenRemainingSize() ;
			this.updateDisplayChildrenPosition() ;
			
			for each ( var child : LayoutComponent in this.children )
			{
				child.updateDisplay( ) ;
			}
		}
		
		protected function updateDisplayChildrenDefinedSize () : void
		{
			this.definedWidthTotal = 0 ;
			this.definedHeightTotal = 0 ;
			
			for each ( var child : LayoutComponent in this.children )
			{
				child.explicitMinWidth = this.getChildMinWidth ( child ) ;
				child.explicitMinHeight = this.getChildMinHeight ( child ) ;
				child.explicitMaxWidth = this.getChildMaxWidth ( child ) ;
				child.explicitMaxHeight = this.getChildMaxHeight ( child ) ;
				
				child.explicitWidth = this.getChildWidth ( child ) ;
				this.definedWidthTotal += child.explicitWidth ;
				child.explicitHeight = this.getChildHeight ( child ) ;
				this.definedHeightTotal += child.explicitHeight ;
			}
		}
		
		protected function updateDisplayChildrenRemainingSize () : void
		{
			this.widthTotal = this.definedWidthTotal ;
			this.heightTotal = this.definedHeightTotal ;
			
			for each ( var child : LayoutComponent in this.children )
			{
				if ( ! isNaN ( child.remainingWidth ) ) 
				{
					child.explicitWidth = child.remainingWidth * this.remainingWidthTotal ;
					this.widthTotal += child.explicitWidth ;
				}
				if ( ! isNaN ( child.remainingHeight ) ) 
				{
					child.explicitHeight = child.remainingHeight * this.remainingHeightTotal ;
					this.heightTotal += child.explicitHeight ;
				}
			}
		}
		
		protected function updateDisplayChildrenPosition () : void
		{
			for each ( var child : LayoutComponent in this.children )
			{
				var x : Number = this.getChildX ( child ) ;
				var y : Number = this.getChildY ( child ) ;
				child.x = this.snapToPixels ? ( x >> 0 ) : x ;
				child.y = this.snapToPixels ? ( y >> 0 ) : y ;
			}
		}
		
		/**
		 * @private
		 */
		protected function getChildMinWidth ( child : LayoutComponent ) : Number
		{
			if ( ! isNaN ( child.fixedMinWidth ) && ! isNaN ( child.relativeMinWidth ) ) return Math.max( child.fixedMinWidth, child.relativeMinWidth * this.explicitWidth ) ;
			else if ( ! isNaN ( child.fixedMinWidth ) ) return child.fixedMinWidth ;
			else if ( ! isNaN ( child.relativeMinWidth ) ) return child.relativeMinWidth * this.explicitWidth ;
			return NaN ;
		}
		
		/**
		 * @private
		 */
		protected function getChildMinHeight ( child : LayoutComponent ) : Number
		{
			if ( ! isNaN ( child.fixedMinHeight ) && ! isNaN ( child.relativeMinHeight ) ) return Math.max( child.fixedMinHeight, child.relativeMinHeight * this.explicitHeight ) ;
			else if ( ! isNaN ( child.fixedMinHeight ) ) return child.fixedMinHeight ;
			else if ( ! isNaN ( child.relativeMinHeight ) ) return child.relativeMinHeight * this.explicitHeight ;
			return NaN ;
		}

		/**
		 * @private
		 */
		protected function getChildMaxWidth ( child : LayoutComponent ) : Number
		{
			if ( ! isNaN ( child.fixedMaxWidth ) && ! isNaN ( child.relativeMaxWidth ) ) return Math.min( child.fixedMaxWidth, child.relativeMaxWidth * this.explicitWidth ) ;
			else if ( ! isNaN ( child.fixedMaxWidth ) ) return child.fixedMaxWidth ;
			else if ( ! isNaN ( child.relativeMaxWidth ) ) return child.relativeMaxWidth * this.explicitWidth ;
			return NaN ;
		}

		/**
		 * @private
		 */
		protected function getChildMaxHeight ( child : LayoutComponent ) : Number
		{
			if ( ! isNaN ( child.fixedMaxHeight ) && ! isNaN ( child.relativeMaxHeight ) ) return Math.min( child.fixedMaxHeight, child.relativeMaxHeight * this.explicitHeight ) ;
			else if ( ! isNaN ( child.fixedMaxHeight ) ) return child.fixedMaxHeight ;
			else if ( ! isNaN ( child.relativeMaxHeight ) ) return child.relativeMaxHeight * this.explicitHeight ;
			return NaN ;
		}
		
		/**
		 * @private
		 */
		protected function getChildWidth ( child : LayoutComponent ) : Number
		{
			if ( child.autoWidth ) return child.widthMeasured ;
			else if ( ! isNaN ( child.fixedWidth ) ) return child.fixedWidth ;
			else if ( ! isNaN ( child.left ) && ! isNaN ( child.right ) ) return this.explicitWidth - child.left - child.right ;
			else if ( ! isNaN ( child.relativeWidth ) ) return child.relativeWidth * this.explicitWidth  ;
			else if ( ! isNaN ( child.remainingWidth ) ) return 0 ;
			return child.explicitWidth ;
		}

		/**
		 * @private
		 */
		protected function getChildHeight ( child : LayoutComponent ) : Number
		{
			if ( child.autoHeight ) return child.heightMeasured ;
			else if ( ! isNaN ( child.fixedHeight ) ) return child.fixedHeight ;
			else if ( ! isNaN ( child.top ) && ! isNaN ( child.bottom ) ) return this.explicitHeight - child.top - child.bottom ;
			else if ( ! isNaN ( child.relativeHeight ) ) return child.relativeHeight * this.explicitHeight ;
			else if ( ! isNaN ( child.remainingHeight ) ) return 0 ;
			return child.explicitHeight ;
		}
		
		/**
		 * @private
		 */
		protected function getChildX ( child : LayoutComponent ) : Number
		{
			if ( ! isNaN ( child.left ) ) return child.left ;
			else if ( ! isNaN ( child.right ) ) return this.explicitWidth - child.explicitWidth - child.right ;
			else if ( ! isNaN ( child.horizontalCentre ) ) return ( ( this.explicitWidth - child.explicitWidth ) / 2 ) + child.horizontalCentre ;
			return child.x ;
		}
		
		/**
		 * @private
		 */
		protected function getChildY ( child : LayoutComponent ) : Number
		{
			if ( ! isNaN ( child.top ) ) return child.top ;
			else if ( ! isNaN ( child.bottom ) ) return this.explicitHeight - child.explicitHeight - child.bottom ;
			else if ( ! isNaN ( child.verticalCentre ) ) return ( ( this.explicitHeight - child.explicitHeight ) / 2 ) + child.verticalCentre ;
			return child.y ;
		}
	}
}