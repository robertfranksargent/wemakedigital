package com.wemakedigital.ui 
{

	/**
	 * Container that distributes children vertically.
	 */
	public class VContainer extends DistributeContainer 
	{
		//----------------------------------------------------------------------
		//
		//  Constants
		//
		//----------------------------------------------------------------------
		
		/**
		 * Anchor top.
		 */
		public static const TOP : String = "TOP" ;

		/**
		 * Anchor vertical centre.
		 */
		public static const CENTRE : String = "CENTRE" ;
		
		/**
		 * Anchor bottom.
		 */
		public static const BOTTOM : String = "BOTTOM" ;

		//----------------------------------------------------------------------
		//
		//  Properties
		//
		//----------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override internal function get measuredHeight () : Number
		{
			return this._measuredHeight || 0 ;
		}

		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function VContainer () 
		{
			super( );
			
			this.anchor = VContainer.TOP ;
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
				var totalHeight : Number = 0 ;
				
				for each ( var childComponent : Component in this.components )
				{
					if ( !isNaN( childComponent.relativeWidth ) ) childComponent.explicitWidth = this.explicitWidth * childComponent.relativeWidth >> 0 ; 
					if ( !isNaN( childComponent.relativeHeight ) ) childComponent.explicitHeight = this.explicitHeight * childComponent.relativeHeight >> 0 ;
					if ( !isNaN( childComponent.left ) && !isNaN( childComponent.right ) ) childComponent.explicitWidth = this.explicitWidth - childComponent.left - childComponent.right ;
					totalHeight += childComponent.explicitHeight ;
				}
				
				if ( ! isNaN ( this.spaceFixed ) ) this.spaceSize = this.spaceFixed ;
				else if ( ! isNaN ( this.spaceRelative ) ) this.spaceSize = this.spaceRelative * this.explicitHeight ;
				else if ( this.anchor.toUpperCase() == VContainer.TOP || this.anchor.toUpperCase() == VContainer.CENTRE || this.anchor.toUpperCase() == VContainer.BOTTOM ) this.spaceSize = 0 ;
				else this.spaceSize = ( this.explicitHeight - totalHeight ) / ( this.children.length - 1 ) ;
				totalHeight += ( this.spaceSize * ( this.children.length - 1 ) ) ;
				this._measuredHeight = totalHeight ;
				
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
					case VContainer.CENTRE :
						this.position = ( this.explicitHeight - this.measuredHeight ) / 2 ;
						break ;
					case VContainer.BOTTOM :
						this.position = this.explicitHeight - this.measuredHeight ;
						break ;
					case VContainer.TOP :
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
		override protected function getChildY ( child : Component ) : Number
		{
			var childY : Number = this.position ;
			this.position += child.explicitHeight + this.spaceSize ;
			return childY ;
		}
	}
}
