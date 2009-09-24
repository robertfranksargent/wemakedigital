package com.wemakedigital.layout 
{
	import com.wemakedigital.layout.LayoutDistribute;

	public class LayoutHorizontal extends LayoutDistribute 
	{
		//----------------------------------------------------------------------
		//
		//  Constants
		//
		//----------------------------------------------------------------------
		
		public static const LEFT : String = "LEFT" ;

		public static const CENTRE : String = "CENTRE" ;

		public static const RIGHT : String = "RIGHT" ;

		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Class contructor.
		 */
		public function LayoutHorizontal ()
		{
			super( );
			
			this.anchor = LayoutHorizontal.LEFT ;
		}
		
		//----------------------------------------------------------------------
		//
		//  Methods
		//
		//----------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override protected function updateDisplayChildren () : void
		{
			this.childrenSize = 0 ;
			for each ( var child : LayoutComponent in this.children )
			{
				child.explicitMinWidth = this.getChildMinWidth ( child ) ;
				child.explicitMinHeight = this.getChildMinHeight ( child ) ;
				child.explicitMaxWidth = this.getChildMaxWidth ( child ) ;
				child.explicitMaxHeight = this.getChildMaxHeight ( child ) ;
				child.explicitWidth = this.getChildWidth ( child ) ;
				child.explicitHeight = this.getChildHeight ( child ) ;
				this.childrenSize += child.explicitWidth ;
			}
			
			if ( ! isNaN ( this.spaceFixed ) ) this.spaceSize = this.spaceFixed ;
			else if ( ! isNaN ( this.spaceRelative ) ) this.spaceSize = this.spaceRelative * this.explicitWidth ;
			else if ( this.anchor.toUpperCase() == LayoutHorizontal.CENTRE || this.anchor.toUpperCase() == LayoutHorizontal.RIGHT || this.anchor.toUpperCase() == LayoutHorizontal.LEFT ) this.spaceSize = 0 ;
			else this.spaceSize = ( this.explicitWidth - this.childrenSize ) / ( this.children.length - 1 ) ; 
			
			var childrenWithSpacingSize : Number = this.childrenSize + ( this.spaceSize * ( this.children.length - 1 ) ) ;
			switch ( this.anchor.toUpperCase() )
			{
				case LayoutHorizontal.CENTRE :
					this.position = ( this.explicitWidth - childrenWithSpacingSize ) / 2 ;
					break ;
				case LayoutHorizontal.RIGHT :
					this.position = this.explicitWidth - childrenWithSpacingSize ;
					break ;
				case LayoutHorizontal.LEFT :
				default :
					this.position = 0 ;
					break ;
			}
			
			for each ( var childAgain : LayoutComponent in this.children )
			{
				childAgain.x = this.getChildX ( childAgain ) ;
				childAgain.y = this.getChildY ( childAgain ) ;
				childAgain.updateDisplay( ) ;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function getChildWidth ( child : LayoutComponent ) : Number
		{
			if ( ! isNaN ( child.fixedWidth ) ) return child.fixedWidth ;
			else if ( ! isNaN ( child.relativeWidth ) ) return child.relativeWidth * this.explicitWidth  ;
			return child.explicitWidth ;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function getChildX ( child : LayoutComponent ) : Number
		{
			var childX : Number = this.position ;
			this.position += child.explicitWidth + this.spaceSize ;
			return childX ;
		}
	}
}
