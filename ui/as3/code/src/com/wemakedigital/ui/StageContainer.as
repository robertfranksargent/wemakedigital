package com.wemakedigital.ui 
{
	import com.wemakedigital.ui.Container;

	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	/**
	 * Container that auto sizes to the stage size. Use as a root level container.
	 */
	public class StageContainer extends Container 
	{
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function StageContainer () 
		{
			super( );
			
			this.autoWidth = false ;
			this.autoHeight = false ;
		}
		
		//----------------------------------------------------------------------
		//
		//  Methods
		//
		//----------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override protected function update () : void
		{
			if ( this.created )
			{
				if ( this.explicitWidth != this.stage.stageWidth || this.explicitHeight != this.stage.stageHeight ) 
				{
					this.explicitWidth = Math.min ( Math.max ( this.stage.stageWidth, this.minWidth ), isNaN ( this.maxWidth ) ? Number.MAX_VALUE : this.maxWidth ) ;
					this.explicitHeight = Math.min ( Math.max ( this.stage.stageHeight, this.minHeight ), isNaN ( this.maxHeight ) ? Number.MAX_VALUE : this.maxHeight ) ;
					this.invalidate() ;
				}
			}
		}
		
		//----------------------------------------------------------------------
		//
		//  Event Handlers
		//
		//----------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override protected function onAddedToStage ( e : Event ) : void
		{
			this.stage.scaleMode = StageScaleMode.NO_SCALE ;
			this.stage.align = StageAlign.TOP_LEFT ;
			this.stage.addEventListener( Event.RESIZE , this.onResize ) ;			
			super.onAddedToStage( e ) ;
		}

		/**
		 * @inheritDoc
		 */
		override protected function onRemovedFromStage ( e : Event ) : void
		{
			this.stage.removeEventListener( Event.RESIZE , this.onResize ) ;
			super.onRemovedFromStage( e ) ;
		}

		/**
		 * @private
		 */
		protected function onResize ( e : Event ) : void
		{
			if ( this.created ) this.update( ) ;
		}
	}
}
