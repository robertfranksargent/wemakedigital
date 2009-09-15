package com.wemakedigital.layout 
{
	import com.wemakedigital.layout.LayoutContainer;

	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	/**
	 * Layout container that auto sizes to the stage size. Use as a root level container.
	 */
	public class LayoutStage extends LayoutContainer 
	{
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Class constructor.
		 */
		public function LayoutStage ()
		{
			super( ) ;
		}
		
		//----------------------------------------------------------------------
		//
		//  Methods
		//
		//----------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override public function updateDisplay () : void
		{
			this.explicitWidth = this.stage.stageWidth ;
			this.explicitHeight = this.stage.stageHeight ;
			super.updateDisplay() ;
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
			if ( this.created ) this.updateDisplay( ) ;
		}
	}
}
