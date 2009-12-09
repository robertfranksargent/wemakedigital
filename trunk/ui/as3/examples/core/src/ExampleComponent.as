package  
{
	import com.wemakedigital.ui.core.CoreComponent;

	import flash.display.Shape;

	public class ExampleComponent extends CoreComponent 
	{
		private var elipse : Shape ;
		
		public function ExampleComponent ()
		{
			trace ( this, "constructor:", "you should see this when the component is instantiated.") ;
			super( );
		}
		
		override public function render() : void
		{
			trace ( this, "render:", "you should see this only once after any display property changes.") ;
			this.elipse.graphics.clear() ;
    		this.elipse.graphics.beginFill( 0x000000 ) ;
    		this.elipse.graphics.drawEllipse( 0, 0, this.explicitWidth, this.explicitHeight ) ; 
			super.render() ;
		}
		
		override public function invalidate() : void
		{
			trace ( this, "invalidate:", "you should see this every time a display property changes.") ; 
			super.invalidate() ;
		}
		
		override protected function create() : void
		{
			trace ( this, "create:", "you should see this when the component is added to the display list.") ; 
			this.elipse = new Shape() ;
			this.addChild( this.elipse ) ; 
			super.create() ;
		}
		
		override protected function destroy() : void
		{
			trace ( this, "destroy:", "you should see this when the component is removed from the display list.") ;
			super.destroy() ; // Call super first to remove all children from the display list.
			this.elipse = null ;
		}
	}
}
