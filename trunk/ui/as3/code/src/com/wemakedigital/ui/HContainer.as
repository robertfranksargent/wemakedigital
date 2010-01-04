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
			return this._measuredWidth || 0 ;
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
				var totalWidth : Number = 0 ;
				
				for each ( var childComponent : Component in this.components )
				{
					if ( !isNaN( childComponent.relativeWidth ) ) childComponent.explicitWidth = this.explicitWidth * childComponent.relativeWidth >> 0 ; 
					if ( !isNaN( childComponent.relativeHeight ) ) childComponent.explicitHeight = this.explicitHeight * childComponent.relativeHeight >> 0 ;
					if ( !isNaN( childComponent.top ) && !isNaN( childComponent.bottom ) ) childComponent.explicitHeight = this.explicitHeight - childComponent.top - childComponent.bottom ;
					totalWidth += childComponent.explicitWidth ;
				}
				
				if ( ! isNaN ( this.spaceFixed ) ) this.spaceSize = this.spaceFixed ;
				else if ( ! isNaN ( this.spaceRelative ) ) this.spaceSize = this.spaceRelative * this.explicitWidth ;
				else if ( this.anchor.toUpperCase() == HContainer.CENTRE || this.anchor.toUpperCase() == HContainer.RIGHT || this.anchor.toUpperCase() == HContainer.LEFT ) this.spaceSize = 0 ;
				else this.spaceSize = ( this.explicitWidth - totalWidth ) / ( this.children.length - 1 ) ;
				totalWidth += ( this.spaceSize * ( this.children.length - 1 ) ) ;
				this._measuredWidth = totalWidth ;
				
				for each ( var childContainer : Container in this.containers )
					if ( childContainer.invalidated ) childContainer.updateSizeOfChildren() ;			
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override internal function updatePositionOfChildren() : void
		{
			if ( this.created && this.invalidated )
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
			this.position += child.explicitWidth + this.spaceSize ;
			return childX ;
		}
	}
}
