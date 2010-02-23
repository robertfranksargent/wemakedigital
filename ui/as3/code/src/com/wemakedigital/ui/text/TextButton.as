package com.wemakedigital.ui.text 
{
	import gs.TweenMax;

	import com.wemakedigital.ui.text.Text;

	import flash.events.MouseEvent;

	/**
	 * Simple text button component.
	 */
	public class TextButton extends Text 
	{
		//----------------------------------------------------------------------
		//
		//  Variables
		//
		//----------------------------------------------------------------------

		protected var _styleOver : String ;
		protected var _toggle : Boolean = false ;
		protected var _selected : Boolean = false ;
		protected var tween : TweenMax ;

		//----------------------------------------------------------------------
		//
		//  Properties
		//
		//----------------------------------------------------------------------

		public function get styleOver ( ) : String
		{
			return this._styleOver ? this._styleOver : "defaultbuttonover" ;
		}

		public function set styleOver ( value : String ) : void
		{
			this._styleOver = value ;
			this.update( ) ;
		}

		//----------------------------------------------------------------------

		public function get toggle ( ) : Boolean
		{
			return this._toggle ;
		}

		public function set toggle ( value : Boolean ) : void
		{
			this._toggle = value ;
			if ( !value ) this._selected = false ;
			this.update( ) ;
		}

		//----------------------------------------------------------------------

		public function get selected ( ) : Boolean
		{
			return this._selected ;
		}

		public function set selected ( value : Boolean ) : void
		{
			this._selected = value ;
			this.update( ) ;
		}

		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function TextButton ( ) 
		{
			super( );
			this.tabEnabled = false ;
			this.tabChildren = false ;
		}

		//----------------------------------------------------------------------
		//
		//  Methods
		//
		//----------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override protected function create () : void
		{
			this.addEventListener( MouseEvent.ROLL_OVER , this.onRollOver ) ;
			this.addEventListener( MouseEvent.ROLL_OUT , this.onRollOut ) ;
			this.addEventListener( MouseEvent.CLICK , this.onClick ) ;
			
			this.buttonMode = true ;
			this.useHandCursor = true ;
			
			super.create( ) ;
			
			if ( this.selected ) this.onRollOver( null ) ; 
		}

		/**
		 * @inheritDoc
		 */
		override protected function destroy () : void
		{
			super.destroy( ) ;
			
			this.removeEventListener( MouseEvent.ROLL_OVER , this.onRollOver ) ;
			this.removeEventListener( MouseEvent.ROLL_OUT , this.onRollOut ) ;
			this.removeEventListener( MouseEvent.CLICK , this.onClick ) ;
			
			if ( this.tween ) this.tween.pause( ) ;
			this.tween = null ;
		}

		/**
		 * @inheritDoc
		 */
		override protected function update () : void
		{
			if ( this.created )
			{
				this._selectable = false ; 
				
				this.selected ? this.onRollOver( null ) : this.onRollOut( null ); 
				
				// Give the button an invisible background as its hit area.
				if ( this._colour < 0 )
				{
					this._colour = 0x000000 ;
					this._colourAlpha = 0 ;
				}
			}
			super.update( ) ;
		}

		//----------------------------------------------------------------------
		//
		//  Event Handlers
		//
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected function onRollOver ( e : MouseEvent ) : void
		{
			var styleOver : Object = this.textManager.styleSheet.getStyle( "." + this.styleOver ) ;
			var color : Number = Number( "0x" + String( styleOver[ "color" ] ).substring( 1 ) ) ;
			var textDecoration : String = styleOver[ "textDecoration" ] ;
			
			if ( textDecoration == "underline" )
			{
				this.textField.htmlText = "<span class='" + this.style + "'><u>" + this.htmlText + "</u></span>" ;
			}
			
			if ( this.tween ) this.tween.pause( ) ;
			this.tween = TweenMax.to( this.textField , .15 , { tint : color } ) ;
		}

		/**
		 * @private
		 */
		protected function onRollOut ( e : MouseEvent ) : void
		{
			if ( ! this.selected )
			{
				this.textField.htmlText = "<span class='" + this.style + "'>" + this.htmlText + "</span>" ;
				
				if ( this.tween ) this.tween.pause( ) ;
				this.tween = TweenMax.to( this.textField , .15 , { removeTint : true } ) ;
			}
		}

		/**
		 * @private
		 */
		protected function onClick ( e : MouseEvent ) : void
		{
			if ( this.toggle )
			{ 
				this.selected = !this.selected ;
				this.selected ? this.onRollOver( null ) : this.onRollOut( null );
			}
		}
	}
}
