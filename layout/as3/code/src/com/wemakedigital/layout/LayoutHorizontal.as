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
		//  Getters and Setters
		//
		//----------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override public function get widthMeasured () : Number
		{
			return this.widthTotal ;
		}
		
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
		override protected function updateDisplayChildrenDefinedSize () : void
		{
			super.updateDisplayChildrenDefinedSize() ;
			
			if ( ! isNaN ( this.spaceFixed ) ) this.spaceSize = this.spaceFixed ;
			else if ( ! isNaN ( this.spaceRelative ) ) this.spaceSize = this.spaceRelative * this.explicitWidth ;
			else if ( this.anchor.toUpperCase() == LayoutHorizontal.CENTRE || this.anchor.toUpperCase() == LayoutHorizontal.RIGHT || this.anchor.toUpperCase() == LayoutHorizontal.LEFT ) this.spaceSize = 0 ;
			else this.spaceSize = ( this.explicitWidth - this.definedWidthTotal ) / ( this.children.length - 1 ) ;
			this.definedWidthTotal += ( this.spaceSize * ( this.children.length - 1 ) ) ;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function updateDisplayChildrenPosition () : void
		{
			switch ( this.anchor.toUpperCase() )
			{
				case LayoutHorizontal.CENTRE :
					this.position = ( this.explicitWidth - this.widthTotal ) / 2 ;
					break ;
				case LayoutHorizontal.RIGHT :
					this.position = this.explicitWidth - this.widthTotal ;
					break ;
				case LayoutHorizontal.LEFT :
				default :
					this.position = 0 ;
					break ;
			}
			
			super.updateDisplayChildrenPosition() ;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function getChildWidth ( child : LayoutComponent ) : Number
		{
			if ( child.autoWidth ) return child.widthMeasured ;
			else if ( ! isNaN ( child.fixedWidth ) ) return child.fixedWidth ;
			else if ( ! isNaN ( child.relativeWidth ) ) return child.relativeWidth * this.explicitWidth  ;
			else if ( ! isNaN ( child.remainingWidth ) ) return 0 ;
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
