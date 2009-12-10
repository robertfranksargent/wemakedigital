package  
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	public class Application extends Sprite 
	{
		public function Application ()
		{
			this.stage.scaleMode = StageScaleMode.NO_SCALE ;
			this.stage.align = StageAlign.TOP_LEFT ;
			
			var view : ApplicationView = new ApplicationView() ;
//			view.component1.height = 50 ;
			this.addChild( view ) ;
		}
	}
}