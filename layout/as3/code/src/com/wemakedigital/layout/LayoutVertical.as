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
		//  Getters and Setters
		//
		//----------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override public function get heightOfChildren () : Number
		{
			return this.heightTotal ;
		}
		
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
		override protected function updateDisplayChildrenDefinedSize () : void
		{
			super.updateDisplayChildrenDefinedSize() ;
			
			if ( ! isNaN ( this.spaceFixed ) ) this.spaceSize = this.spaceFixed ;
			else if ( ! isNaN ( this.spaceRelative ) ) this.spaceSize = this.spaceRelative * this.explicitHeight ;
			else if ( this.anchor.toUpperCase() == LayoutVertical.CENTRE || this.anchor.toUpperCase() == LayoutVertical.BOTTOM || this.anchor.toUpperCase() == LayoutVertical.TOP ) this.spaceSize = 0 ;
			else this.spaceSize = ( this.explicitHeight - this.definedHeightTotal ) / ( this.children.length - 1 ) ; 
			this.definedHeightTotal += ( this.spaceSize * ( this.children.length - 1 ) ) ;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function updateDisplayChildrenPosition () : void
		{
			switch ( this.anchor.toUpperCase() )
			{
				case LayoutVertical.CENTRE :
					this.position = ( this.explicitHeight - this.heightTotal ) / 2 ;
					break ;
				case LayoutVertical.BOTTOM :
					this.position = this.explicitHeight - this.heightTotal ;
					break ;
				case LayoutVertical.TOP :
				default :
					this.position = 0 ;
					break ;
			}
			
			super.updateDisplayChildrenPosition() ;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function getChildHeight ( child : LayoutComponent ) : Number
		{
			if ( ! isNaN ( child.fixedHeight ) ) return child.fixedHeight ;
			else if ( ! isNaN ( child.relativeHeight ) ) return child.relativeHeight * this.explicitHeight ;
			else if ( ! isNaN ( child.remainingHeight ) ) return 0 ;
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
