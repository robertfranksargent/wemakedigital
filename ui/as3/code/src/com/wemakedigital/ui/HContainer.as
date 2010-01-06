package com.wemakedigital.ui 
{

	/**
	 * Container that distributes children horizontally.
	 */
	public class HContainer extends DistributeContainer 
	{
		//----------------------------------------------------------------------
		//
		//  Constants
		//
		//----------------------------------------------------------------------
		
		/**
		 * Anchor left.
		 */
		public static const LEFT : String = "LEFT" ;

		/**
		 * Anchor centre.
		 */
		public static const CENTRE : String = "CENTRE" ;
		
		/**
		 * Anchor right.
		 */
		public static const RIGHT : String = "RIGHT" ;

		//----------------------------------------------------------------------
		//
		//  Properties
		//
		//----------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override internal function get measuredWidth () : Number
		{
			return this.totalWidth + this.totalSpace ;
		}

		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function HContainer () 
		{
			super( );
			
			this.anchor = HContainer.LEFT ;
		}
		
		//----------------------------------------------------------------------
		//
		//  Methods
		//
		//----------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override internal function updateSizeOfChildren () : void
		{
			if ( this.created )
			{
				for each ( var childComponent : Component in this.components )
				{
					if ( !isNaN( childComponent.relativeWidth ) ) childComponent.explicitWidth = this.explicitWidth * childComponent.relativeWidth >> 0 ; 
					if ( !isNaN( childComponent.relativeHeight ) ) childComponent.explicitHeight = this.explicitHeight * childComponent.relativeHeight >> 0 ;
					if ( !isNaN( childComponent.top ) && !isNaN( childComponent.bottom ) ) childComponent.explicitHeight = this.explicitHeight - childComponent.top - childComponent.bottom ;
				}
				
				if ( this.children && this.children.length > 0 )
				{
					if ( ! isNaN ( this.space ) ) this.explicitSpace = this.space ;
					else if ( ! isNaN ( this.relativeSpace ) ) this.explicitSpace = this.relativeSpace * this.explicitHeight ;
					else if ( this.anchor.toUpperCase() == VContainer.TOP || this.anchor.toUpperCase() == VContainer.CENTRE || this.anchor.toUpperCase() == VContainer.BOTTOM ) this.explicitSpace = 0 ;
					else this.explicitSpace = ( this.explicitHeight - totalHeight ) / ( this.children.length - 1 ) ;
					this.totalSpace = this.explicitSpace * ( this.children.length - 1 ) ;
				}
				else this.totalSpace = 0 ;
				
				for each ( var childContainer : Container in this.containers )
					childContainer.updateSizeOfChildren() ;			
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override internal function updatePositionOfChildren() : void
		{
			if ( this.created )
			{
				switch ( this.anchor.toUpperCase() )
				{
					case HContainer.CENTRE :
						this.position = ( this.explicitWidth - this.measuredWidth ) / 2 ;
						break ;
					case HContainer.RIGHT :
						this.position = this.explicitWidth - this.measuredWidth ;
						break ;
					case HContainer.LEFT :
					default :
						this.position = 0 ;
						break ;
				}
			}
			
			super.updatePositionOfChildren() ;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function getChildX ( child : Component ) : Number
		{
			var childX : Number = this.position ;
			this.position += child.explicitWidth + this.explicitSpace ;
			return childX ;
		}
	}
}
