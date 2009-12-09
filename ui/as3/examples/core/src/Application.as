package  
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;

	public class Application extends Sprite 
	{
		private var component : ExampleComponent ;
		
		public function Application ()
		{
			this.stage.scaleMode = StageScaleMode.NO_SCALE ;
			this.stage.align = StageAlign.TOP_LEFT ;
			
			trace ( this, "constructor:", "click anywhere to add the component to the display list and update some properties, click again to remove it." ) ;
			this.stage.addEventListener ( MouseEvent.CLICK, this.onClick ) ; 
			
			this.component = new ExampleComponent() ;
		}
		
		private function onClick ( e : MouseEvent ) : void
		{
			if ( !this.component.created )
			{
				this.addChild( this.component ) ;
				this.component.colour = 0xFF0000 ;
				this.component.width = 150 ;
				this.component.height = 150 ;
				this.component.maxWidth = 100 ;
				this.component.minHeight = 200 ;
			}
			else
			{
				this.removeChild( this.component ) ;
			}
		}
	}
}