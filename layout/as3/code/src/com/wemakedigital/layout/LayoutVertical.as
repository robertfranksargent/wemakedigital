package com.wemakedigital.layout 
{
	import com.wemakedigital.layout.LayoutDistribute;

	public class LayoutVertical extends LayoutDistribute 
	{
		//----------------------------------------------------------------------
		//
		//  Constants
		//
		//----------------------------------------------------------------------
		
		public static const TOP : String = "TOP" ;

		public static const CENTRE : String = "CENTRE" ;

		public static const BOTTOM : String = "BOTTOM" ;

		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Class contructor.
		 */
		public function LayoutVertical ()
		{
			super( );
			
			this.anchor = LayoutVertical.TOP ;
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
				this.childrenSize += child.explicitHeight ;
			}
			
			if ( ! isNaN ( this.spaceFixed ) ) this.spaceSize = this.spaceFixed ;
			else if ( ! isNaN ( this.spaceRelative ) ) this.spaceSize = this.spaceRelative * this.explicitHeight ;
			else this.spaceSize = ( this.explicitHeight - this.childrenSize ) / ( this.children.length - 1 ) ; 
			
			var childrenWithSpacingSize : Number = this.childrenSize + ( this.spaceSize * ( this.children.length - 1 ) ) ;
			switch ( this.anchor.toUpperCase() )
			{
				case LayoutVertical.CENTRE :
					this.position = ( this.explicitHeight - childrenWithSpacingSize ) / 2 ;
					break ;
				case LayoutVertical.BOTTOM :
					this.position = this.explicitHeight - childrenWithSpacingSize ;
					break ;
				case LayoutVertical.TOP :
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
		override protected function getChildHeight ( child : LayoutComponent ) : Number
		{
			if ( ! isNaN ( child.fixedHeight ) ) return child.fixedHeight ;
			else if ( ! isNaN ( child.relativeHeight ) ) return child.relativeHeight * this.explicitHeight ;
			return child.explicitHeight ;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function getChildY ( child : LayoutComponent ) : Number
		{
			var childY : Number = this.position ;
			this.position += child.explicitHeight + this.spaceSize ;
			return childY ;
		}
	}
}
