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
		
		/**
		 * @private
		 */
		protected var _maskChildren : Boolean = true ;

		/**
		 * @private
		 */
		protected var _children : Array ;

		
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
			this._children = value is Array ? value : [ value ] ;
			
			for each ( var child : DisplayObject in this._children )
			{
				this.content.addChild( child ) ;
			}
			
			if ( this.created ) 
			{
				this.updateProperties( ) ;
				this.updateDisplay( ) ;
			}
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
			if ( child && ! this.contains( child ) )
			{
				if ( this.children ) this._children.push( child ) ;
				else this._children = [ child ] ;
				this.content.addChild( child ) ;
				if ( this.created ) 
				{
					this.updateProperties( ) ;
					this.updateDisplay( ) ;
				}
			}
			return child ;
		}

		/**
		 * @inheritDoc
		 */
		override public function removeChild ( child : DisplayObject ) : DisplayObject
		{
			if ( child && this.contains( child ) )
			{
				this.content.removeChild( child ) ;
				if ( this.children ) 
				{
					this._children = this._children.splice( this._children.indexOf( child ), 1 ) ;
					if ( this.created ) 
					{
						this.updateProperties( ) ;
						this.updateDisplay( ) ;
					}
				}
			}
			return child ;
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
			super.updateDisplay( ) ;
			this.updateDisplayChildren() ;
		}
		
		/**
		 * @private
		 */
		protected function updateDisplayChildren () : void
		{			
			for each ( var child : LayoutComponent in this.children )
			{
				child.explicitMinWidth = this.getChildMinWidth ( child ) ;
				child.explicitMinHeight = this.getChildMinHeight ( child ) ;
				child.explicitMaxWidth = this.getChildMaxWidth ( child ) ;
				child.explicitMaxHeight = this.getChildMaxHeight ( child ) ;
				child.explicitWidth = this.getChildWidth ( child ) ;
				child.explicitHeight = this.getChildHeight ( child ) ;
				child.x = this.getChildX ( child ) ;
				child.y = this.getChildY ( child ) ;
				child.updateDisplay( ) ;
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
			if ( ! isNaN ( child.fixedWidth ) ) return child.fixedWidth ;
			else if ( ! isNaN ( child.left ) && ! isNaN ( child.right ) ) return this.explicitWidth - child.left - child.right ;
			else if ( ! isNaN ( child.relativeWidth ) ) return child.relativeWidth * this.explicitWidth  ;
			return child.explicitWidth ;
		}

		/**
		 * @private
		 */
		protected function getChildHeight ( child : LayoutComponent ) : Number
		{
			if ( ! isNaN ( child.fixedHeight ) ) return child.fixedHeight ;
			else if ( ! isNaN ( child.top ) && ! isNaN ( child.bottom ) ) return this.explicitHeight - child.top - child.bottom ;
			else if ( ! isNaN ( child.relativeHeight ) ) return child.relativeHeight * this.explicitHeight ;
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