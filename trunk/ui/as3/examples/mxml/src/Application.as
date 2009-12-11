package  
{
	import net.hires.debug.Stats;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	public class Application extends Sprite 
	{
		private var size : Number = 1 ;
		private var view : ApplicationView ;
		
		public function Application ()
		{
			this.stage.scaleMode = StageScaleMode.NO_SCALE ;
			this.stage.align = StageAlign.TOP_LEFT ;
			
			this.view = new ApplicationView() ;
			
			this.addChild( view ) ;
			
			this.addEventListener( Event.ENTER_FRAME, this.onEnterFrame ) ;
			
			this.addChild( new Stats() );
		}
		
		private function onEnterFrame( e : Event ) : void
		{
			this.view.width += this.size ;
			this.view.height += this.size ;
			if ( this.view.width > 300 ) this.size = -1 ;
			else if ( this.view.width < 100 ) this.size = 1 ;
		}
	}
}