package com.wemakedigital.ui.text 
{
	import com.wemakedigital.ui.Container;
	import com.wemakedigital.ui.text.manager.TextManager;

	import flash.display.Shape;
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
		protected var borderShape : Shape ;
		protected var textHeightWhenEmpty : Number = 0 ;

		//----------------------------------------------------------------------

		/**
		 * @private
		 */
		protected var _key : String = TextManager.DEFAULT_KEY ;

		/**
		 * @private
		 */
		protected var _antiAliasType : String ;

		/**
		 * @private
		 */
		protected var _gridFitType : String ;

		/**
		 * @private
		 */
		protected var _thickness : Number ;

		/**
		 * @private
		 */
		protected var _sharpness : Number ;

		/**
		 * @private
		 */
		protected var _style : String = "default" ;

		/**
		 * @private
		 */
		protected var _selectable : Boolean = true ;

		/**
		 * @private
		 */
		protected var _wordWrap : Boolean = true ;

		/**
		 * @private
		 */
		protected var _autoSize : String = TextFieldAutoSize.LEFT ;

		/**
		 * @private
		 */
		protected var _maxChars : uint = 0 ;

		//----------------------------------------------------------------------

		/**
		 * @private
		 */
		protected var _marginLeft : Number = 0 ;

		/**
		 * @private
		 */
		protected var _marginRight : Number = 0 ;

		/**
		 * @private
		 */
		protected var _marginTop : Number = 0 ;

		/**
		 * @private
		 */
		protected var _marginBottom : Number = 0 ;

		//----------------------------------------------------------------------

		/**
		 * @private
		 */
		protected var _border : Boolean = false ;

		/**
		 * @private
		 */
		protected var _borderColour : uint = 0xFF0000 ;

		/**
		 * @private
		 */
		protected var _borderThickness : uint = 1 ;

		//----------------------------------------------------------------------

		/**
		 * @private
		 */
		protected var _text : String = "" ;

		/**
		 * @private
		 */
		protected var _textFormat : TextFormat ;

		//----------------------------------------------------------------------

		/**
		 * @private
		 */
		protected var beforeRenderFlag : Boolean = false ;

		//----------------------------------------------------------------------
		//
		//  Properties
		//
		//----------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override public function get measuredWidth ( ) : Number
		{
			return ( this.textField ? this.textField.width : 0 ) + this.marginLeft + this.marginRight ;
		}

		/**
		 * @inheritDoc
		 */
		override public function get measuredHeight ( ) : Number
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
			this.update( ) ;
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
			this.update( ) ;
		}

		public function get gridFitType ( ) : String
		{
			return this._gridFitType ;
		}

		public function set gridFitType ( value : String ) : void
		{
			this._gridFitType = value ;
			this.update( ) ;
		}

		public function get thickness ( ) : Number
		{
			return this._thickness ;
		}

		public function set thickness ( value : Number ) : void
		{
			this._thickness = value ;
			this.update( ) ;
		}

		public function get sharpness ( ) : Number
		{
			return this._sharpness ;
		}

		public function set sharpness ( value : Number ) : void
		{
			this._sharpness = value ;
			this.update( ) ;
		}

		//----------------------------------------------------------------------

		public function get style ( ) : String
		{
			return this._style ? this._style : "default" ;
		}

		public function set style ( value : String ) : void
		{
			this._style = value ;
			if ( this.created ) this.updateStyle( ) ;
			this.update( ) ;
		}

		public function get selectable ( ) : Boolean
		{
			return this._selectable ;
		}

		public function set selectable ( value : Boolean ) : void
		{
			this._selectable = value ;
			this.update( ) ;
		}

		public function get text ( ) : String
		{
			return this._text ;
		}

		public function set text ( value : String ) : void
		{
			this._text = value ;
			this.update( ) ;
		}

		public function get textFormat ( ) : TextFormat
		{
			return this._textFormat ;
		}

		public function set textFormat ( value : TextFormat ) : void
		{
			this._textFormat = value ;
			this.update( ) ;
		}

		//----------------------------------------------------------------------

		public function get marginLeft ( ) : Number
		{
			return this._marginLeft ;
		}

		public function set marginLeft ( value : Number ) : void
		{
			this._marginLeft = value ;
			this.update( ) ;
		}

		public function get marginRight ( ) : Number
		{
			return this._marginRight ;
		}

		public function set marginRight ( value : Number ) : void
		{
			this._marginRight = value ;
			this.update( ) ;
		}

		public function get marginTop ( ) : Number
		{
			return this._marginTop ;
		}

		public function set marginTop ( value : Number ) : void
		{
			this._marginTop = value ;
			this.update( ) ;
		}

		public function get marginBottom ( ) : Number
		{
			return this._marginBottom ;
		}

		public function set marginBottom ( value : Number ) : void
		{
			this._marginBottom = value ;
			this.update( ) ;
		}

		//----------------------------------------------------------------------

		public function get border ( ) : Boolean
		{
			return this._border ;
		}

		public function set border ( value : Boolean ) : void
		{
			this._border = value ;
			this.update( ) ;
		}

		public function get borderColour ( ) : uint
		{
			return this._borderColour ;
		}

		public function set borderColour ( value : uint ) : void
		{
			this._borderColour = value ;
			this.update( ) ;
		}

		public function get borderThickness ( ) : uint
		{
			return this._borderThickness ;
		}

		public function set borderThickness ( value : uint ) : void
		{
			this._borderThickness = value ;
			this.update( ) ;
		}

		/**
		 * @private
		 */
		public function set wordWrap ( value : Boolean ) : void
		{
			this._wordWrap = value ;
			this.update( ) ;
		}

		/**
		 * A value of <code>true</code> if the text field's content should wrap.
		 */
		public function get wordWrap ( ) : Boolean
		{
			return this._wordWrap ;
		}

		/**
		 * The text field alignment.
		 */
		public function get autoSize ( ) : String
		{
			return this._autoSize ;
		}

		/**
		 * @private
		 */
		public function set autoSize ( value : String ) : void
		{
			this._autoSize = value ;
			this.update( ) ;
		}

		/**
		 * The maximum number of characters allowed in the text input field.
		 */
		public function get maxChars ( ) : uint 
		{
			return this._maxChars ;
		}

		/**
		 * @private
		 */
		public function set maxChars ( value : uint ) : void
		{
			this._maxChars = value ;
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
		public function TextInput ( )
		{
			super( ) ;
			
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
		override public function render ( ) : void
		{
			if ( this.created && this.invalidated )
			{
				if ( this.textField.multiline )
				{
					this.textField.width = this.explicitWidth ;
				}
				else if ( ! isNaN( this.explicitHeight ) )
				{
					this.textField.height = this.explicitHeight ;
				}
				
				this.textField.x = marginLeft ; 
				this.textField.y = marginTop ; 
				
				this.borderShape.graphics.clear( ) ;
				if ( this.border )
				{
					this.borderShape.graphics.beginFill( this.borderColour ) ;
					this.borderShape.graphics.drawRect( 0 , 0 , this.explicitWidth , this.borderThickness ) ;
					this.borderShape.graphics.drawRect( 0 , this.explicitHeight - this.borderThickness , this.explicitWidth , this.borderThickness ) ;
					this.borderShape.graphics.drawRect( 0 , this.borderThickness , this.borderThickness , this.explicitHeight - ( 2 * this.borderThickness ) ) ;
					this.borderShape.graphics.drawRect( this.explicitWidth - this.borderThickness , this.borderThickness , this.borderThickness , this.explicitHeight - ( 2 * this.borderThickness ) ) ;
				}
			}
			super.render( ) ;
		}

		//----------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override protected function create ( ) : void
		{
			this.textField = new TextField( ) ;
			this.textField.condenseWhite = true ;
			this.textField.type = TextFieldType.INPUT ;
			this.textField.multiline = true ;		
			this.textField.text = this._text ;
			this.addChild( this.textField ) ;
			
			this.borderShape = new Shape( ) ;
			this.addChild( this.borderShape ) ;
			
			this.updateStyle( ) ;
			super.create( ) ;
		}

		/**
		 * @inheritDoc
		 */
		override protected function destroy ( ) : void
		{
			super.destroy( ) ;
			
			this.textField = null ;
		}

		//----------------------------------------------------------------------

		/**
		 * @inheritDoc
		 */
		override protected function update ( ) : void
		{
			if ( this.created )
			{	
				this.textField.text = this.text ;
				this.textField.embedFonts = this.textManager.embedFonts;
				this.textField.antiAliasType = this.antiAliasType || this.textManager.antiAliasType ;
				this.textField.gridFitType = this.gridFitType || this.textManager.gridFitType ;
				this.textField.thickness = this.thickness || this.textManager.thickness ;
				this.textField.sharpness = this.sharpness || this.textManager.sharpness ;
				this.textField.selectable = this.selectable ;
				this.textField.mouseEnabled = this.selectable ;
				this.textField.defaultTextFormat = this.textFormat ;
				this.textField.wordWrap = this.wordWrap ;				
				this.textField.multiline = this.wordWrap ;				
				this.textField.autoSize = this.autoSize ;
				this.textField.maxChars = this.maxChars ;
				
				if ( this.textFormat && ! this.textField.styleSheet )
				{
					this.textField.setTextFormat( this.textFormat ) ;
				}
				
				if ( ! isNaN( this.width ) && this.explicitWidth != this.width ) this.explicitWidth = this.width ;
				if ( ! isNaN( this.height ) && this.explicitHeight != this.height ) this.explicitHeight = this.height ;
				
				this.invalidate( ) ;
			}
		}

		protected function updateStyle ( ) : void
		{
			var styleTextField : TextField = new TextField( ) ;
			styleTextField.type = TextFieldType.DYNAMIC ;
			styleTextField.styleSheet = this.textManager.styleSheet ;
			styleTextField.htmlText = "<span class='" + this.style + "'>X</span>" ;
			styleTextField.autoSize = TextFieldAutoSize.LEFT ;
			this.textHeightWhenEmpty = styleTextField.height ;
			this.textFormat = styleTextField.getTextFormat( 0 , 1 ) ;
		}
	}
}
