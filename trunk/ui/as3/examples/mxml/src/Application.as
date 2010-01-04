package  
{
	import com.wemakedigital.ui.VContainer;
	import com.wemakedigital.ui.Component;

	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.MouseEvent;

	public class Application extends Sprite 
	{
		private var view : ApplicationView ;
		
		public function Application ()
		{
			this.stage.scaleMode = StageScaleMode.NO_SCALE ;
			this.stage.align = StageAlign.TOP_LEFT ;
			
			this.view = new ApplicationView() ;
			
			this.view.addEventListener( MouseEvent.CLICK, this.onClick ) ;
			
			this.addChild( this.view ) ;
		}
		
		private function onClick ( e : MouseEvent ) : void
		{
			this.view.component3.visible ? this.view.component3.hide() : this.view.component3.show() ;
			if ( e.target == this.view.component1 ) 
			{
				var component : Component = new Component() ;
				component.width = 100 ;
				component.height = 100 ;
				component.colour = 0x999999 ;
				this.view.container1.addChild( component ) ;
			}
			
			else if ( e.target == this.view.component2 ) 
			{
				this.view.container1.removeChild( this.view.container1.getChildAt( this.view.container1.numChildren -1 ) ) ;
			}
		}
	}
}