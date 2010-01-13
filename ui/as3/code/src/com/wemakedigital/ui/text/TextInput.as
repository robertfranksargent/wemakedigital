package com.wemakedigital.ui.text 
{
	import com.wemakedigital.log.Log;
	import com.wemakedigital.ui.Container;
	import com.wemakedigital.ui.text.manager.TextManager;

	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;

	/**
	 * Input text component
	 */
	public class TextInput extends Container
	{
		//----------------------------------------------------------------------
		//
		//  Variables
		//
		//----------------------------------------------------------------------
		
		protected var textField : TextField ;
		protected var textFormat : TextFormat ;
		protected var textHeightWhenEmpty : Number = 0 ;
		
		//----------------------------------------------------------------------
		
		protected var _key : String = TextManager.DEFAULT_KEY ;
		protected var _antiAliasType : String ;
		protected var _gridFitType : String ;
		protected var _thickness : Number ;
		protected var _sharpness : Number ;
		protected var _style : String = "default" ;
		protected var _selectable : Boolean = false ;
		protected var _htmlText : String = "" ;

		//----------------------------------------------------------------------
		
		protected var _marginLeft : Number = 0 ;
		protected var _marginRight : Number = 0 ;
		protected var _marginTop : Number = 0 ;
		protected var _marginBottom : Number = 0 ;
		
		//----------------------------------------------------------------------
		
		protected var beforeRenderFlag : Boolean = false ;
		
		//----------------------------------------------------------------------
		//
		//  Properties
		//
		//----------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override public function get measuredWidth () : Number
		{
			return ( this.textField ? this.textField.width : 0 ) + this.marginLeft + this.marginRight ;
		}

		/**
		 * @inheritDoc
		 */
		override public function get measuredHeight () : Number
		{
			return ( this.textField && this.textField.text.length > 0 ? this.textField.height : this.textHeightWhenEmpty ) + this.marginTop + this.marginBottom ;
		}
		
		//----------------------------------------------------------------------
		
		/**
		 * The key of the TextManager associated with this Text.
		 */
		public function get key ( ) : String
		{
			return this._key ;
		}
		
		/**
		 * @private
		 */
		public function set key ( value : String ) : void
		{
			this._key = value ;
			this.update() ;
		}
		
		/**
		 * The TextManager associated with this Text.
		 */
		public function get textManager ( ) : TextManager
		{
			return TextManager.getInstance( this.key ) ;
		}
		
		//----------------------------------------------------------------------
		
		public function get antiAliasType ( ) : String
		{
			return this._antiAliasType ;
		}
		
		public function set antiAliasType ( value : String ) : void
		{
			this._antiAliasType = value ;
			this.update() ;
		}

		public function get gridFitType ( ) : String
		{
			return this._gridFitType ;
		}

		public function set gridFitType ( value : String ) : void
		{
			this._gridFitType = value ;
			this.update() ;
		}

		public function get thickness ( ) : Number
		{
			return this._thickness ;
		}

		public function set thickness ( value : Number ) : void
		{
			this._thickness = value ;
			this.update() ;
		}

		public function get sharpness ( ) : Number
		{
			return this._sharpness ;
		}

		public function set sharpness ( value : Number ) : void
		{
			this._sharpness = value ;
			this.update() ;
		}
		
		//----------------------------------------------------------------------
		
		public function get style ( ) : String
		{
			return this._style ? this._style : "default" ;
		}
		
		public function set style ( value : String ) : void
		{
			this._style = value ;
			if ( this.created ) this.updateStyle() ;
			this.update() ;
		}
		
		public function get selectable ( ) : Boolean
		{
			return this._selectable ;
		}
		
		public function set selectable ( value : Boolean ) : void
		{
			this._selectable = value ;
			this.update() ;
		}
		
		public function get htmlText ( ) : String
		{
			return this._htmlText ;
		}
		
		public function set htmlText ( value : String ) : void
		{
			this._htmlText = value ;
			this.update() ;
		}
		
		//----------------------------------------------------------------------
		
		public function get marginLeft ( ) : Number
		{
			return this._marginLeft ;
		}
		
		public function set marginLeft ( value : Number ) : void
		{
			this._marginLeft = value ;
			this.update() ;
		}

		public function get marginRight ( ) : Number
		{
			return this._marginRight ;
		}
		
		public function set marginRight ( value : Number ) : void
		{
			this._marginRight = value ;
			this.update() ;
		}

		public function get marginTop ( ) : Number
		{
			return this._marginTop ;
		}
		
		public function set marginTop ( value : Number ) : void
		{
			this._marginTop = value ;
			this.update() ;
		}

		public function get marginBottom ( ) : Number
		{
			return this._marginBottom ;
		}
		
		public function set marginBottom ( value : Number ) : void
		{
			this._marginBottom = value ;
			this.update() ;
		}
		
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function TextInput ()
		{
			super() ;
			
			this._autoWidth = false ;
			this._autoHeight = true ;
			this._width = 100 ;
			this._height = NaN ;
		}
		
		//----------------------------------------------------------------------
		//
		//  Methods
		//
		//----------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override public function render () : void
		{
			if ( this.created && this.invalidated )
			{
				this.textField.width = this.explicitWidth ; 
				this.textField.height = this.explicitHeight ;
				
				this.textField.x = marginLeft ; 
				this.textField.y = marginTop ; 
			}
			super.render() ;
		}
		
		//----------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override protected function create () : void
		{
//			TODO this.mouseChildren = false ;
			
			this.textField = new TextField( ) ;
			this.textField.condenseWhite = true ;
			this.textField.type = TextFieldType.INPUT ;
			this.textField.multiline = true ;		
			
			this.addChild( this.textField ) ;
			
			this.updateStyle() ;
			
			super.create() ;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function destroy () : void
		{
			super.destroy() ;
			
			this.textField = null ;
		}
		
		//----------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override protected function update () : void
		{
			if ( this.created )
			{	
				this.textField.embedFonts = this.textManager.embedFonts;
				this.textField.antiAliasType = this.antiAliasType || this.textManager.antiAliasType ;
				this.textField.gridFitType = this.gridFitType || this.textManager.gridFitType ;
				this.textField.thickness = this.thickness || this.textManager.thickness ;
				this.textField.sharpness = this.sharpness || this.textManager.sharpness ;
//				TODO this.textField.selectable = this.selectable ;
//				this.textField.mouseEnabled = this.selectable ;
				this.textField.defaultTextFormat = this.textFormat ;
//				this.textField.styleSheet = this.textManager.styleSheet ;
				this.textField.wordWrap = !this.autoWidth ;				
				this.textField.autoSize = TextFieldAutoSize.LEFT ;
				
				if ( !isNaN( this.width ) && this.explicitWidth != this.width ) this.explicitWidth = this.width ;
				if ( !isNaN( this.height ) && this.explicitHeight != this.height ) this.explicitHeight = this.height ;
				else if ( this.autoHeight ) this.explicitHeight = this.textHeightWhenEmpty ;
				 
				this.invalidate() ;
			}
		}
		
		protected function updateStyle() : void
		{
			var styleTextField : TextField = new TextField() ;
			styleTextField.type = TextFieldType.DYNAMIC ;
			styleTextField.styleSheet = this.textManager.styleSheet ;
			styleTextField.htmlText = "<span class='" + style + "'>X</span>" ;
			styleTextField.autoSize = TextFieldAutoSize.LEFT ;
			this.textHeightWhenEmpty = styleTextField.height ;
			this.textFormat = styleTextField.getTextFormat( 0, 1 ) ;
		}
	}
}
