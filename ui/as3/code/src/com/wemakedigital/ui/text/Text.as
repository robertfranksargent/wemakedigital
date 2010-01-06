package com.wemakedigital.ui.text
{
	import com.wemakedigital.ui.Container;

	import flash.display.BitmapData;
	import flash.text.AntiAliasType;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;

	public class Text extends Container
	{
		//----------------------------------------------------------------------
		//
		//  Static Variables
		//
		//----------------------------------------------------------------------

		public static var styleSheet : StyleSheet ;
		public static var embedFonts : Boolean = false ;
		
		//----------------------------------------------------------------------
		//
		//  Variables
		//
		//----------------------------------------------------------------------
		
		protected var textField : TextField ;
		protected var _type : String = TextFieldType.DYNAMIC ;
		protected var _antiAliasType : String = AntiAliasType.NORMAL ;
		protected var _selectable : Boolean = false ;
		protected var _style : String = "default" ;
		protected var _htmlText : String = "" ;
//		protected var _marginLeft : Number = 0 ;
//		protected var _marginRight : Number = 0 ;
//		protected var _marginTop : Number = 0 ;
//		protected var _marginBottom : Number = 0 ;
		
		protected var _sample : String ; 
		
		//----------------------------------------------------------------------
		//
		//  Properties
		//
		//----------------------------------------------------------------------
		
		public function get type ( ) : String
		{
			return this._type ;
		}
		
		public function set type ( value : String ) : void
		{
			this._type = value ;
			this.update() ;
		}
		
		public function get antiAliasType ( ) : String
		{
			return this._antiAliasType ;
		}
		
		public function set antiAliasType ( value : String ) : void
		{
			this._antiAliasType = value ;
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
		
		public function get style ( ) : String
		{
			return this._style ? this._style : "default" ;
		}
		
		public function set style ( value : String ) : void
		{
			this._style = value ;
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
		
//		public function get marginLeft ( ) : Number
//		{
//			return this._marginLeft ;
//		}
//		
//		public function set marginLeft ( value : Number ) : void
//		{
//			this._marginLeft = value ;
//			this.update() ;
//		}
//
//		public function get marginRight ( ) : Number
//		{
//			return this._marginRight ;
//		}
//		
//		public function set marginRight ( value : Number ) : void
//		{
//			this._marginRight = value ;
//			this.update() ;
//		}
//
//		public function get marginTop ( ) : Number
//		{
//			return this._marginTop ;
//		}
//		
//		public function set marginTop ( value : Number ) : void
//		{
//			this._marginTop = value ;
//			this.update() ;
//		}
//
//		public function get marginBottom ( ) : Number
//		{
//			return this._marginBottom + 2 ; // TODO Improve this hack
//		}
//		
//		public function set marginBottom ( value : Number ) : void
//		{
//			this._marginBottom = value ;
//			this.update() ;
//		}
		
		//----------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override public function get measuredWidth () : Number
		{
//			return this.marginLeft + ( this.textField ? this.textField.textWidth : 0 ) + this.marginRight ;
			return this._measuredWidth || ( this.textField ? this.textField.width : 0 ) ;
		}

		/**
		 * @inheritDoc
		 */
		override public function get measuredHeight () : Number
		{
//			return this.marginTop + ( this.textField ? this.textField.textHeight : 0 ) + this.marginBottom ;
			return this._measuredHeight || ( this.textField ? this.textField.height : 0 ) ;
		}
		
		//----------------------------------------------------------------------
		
		public function get sample ( ) : String
		{
			return this._sample ;
		}
		
		public function set sample ( value : String ) : void
		{
			if ( this._sample != value ) 
			{
				this._sample = value ;
				this.update() ;
			}
		}
		
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function Text ()
		{
			if( !Text.styleSheet ) Text.styleSheet = new StyleSheet();
			if( Text.styleSheet.styleNames.indexOf(".default") < 0 )
			{
				
				var defaultStyle : Object = { fontFamily : "_sans", 
											  fontSize : "18",
											  color : "#000000",
											  fontWeight : "regular",
											  letterSpacing : "0",
											  leading : "0" };
				Text.styleSheet.setStyle( ".default", defaultStyle ) ;
			}
			super() ;
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
//				if ( !this.autoWidth ) this.textField.width = this.explicitWidth - this.marginLeft - this.marginRight ;
//				if ( !this.autoHeight ) this.textField.height = this.explicitHeight - this.marginTop - this.marginBottom ;
				
				if ( !this.autoWidth ) this.textField.width = this.explicitWidth ;
				if ( !this.autoHeight ) this.textField.height = this.explicitHeight ;
				
				var cropLeft : uint = this.getCropLeft() ; 
				var cropRight : uint = 0 ; //this.getCropRight() ; 
				
				if ( this.sample && this.sample.length > 0 )
				{
					for ( var i : uint = 1, replace : String = this.sample ; i < this.textField.numLines ; i++ )
						replace += "<br/>" + this.sample ;
					this.textField.htmlText = "<span class='" + this.style + "'>" + replace + "</span>" ;
				}
				
				var cropTop : uint = this.getCropTop() ; 
				var cropBottom : uint = this.getCropBottom() ; 
	
				if ( this.sample && this.sample.length > 0 )
					this.textField.htmlText = "<span class='" + this.style + "'>" + this.htmlText + "</span>" ;
				
				this.textField.x = - cropLeft ;
				this.textField.y = - cropTop ;
				
				this._measuredWidth = this.textField.width - cropLeft - cropRight ;
				this._measuredHeight = this.textField.height - cropTop - cropBottom ;
	
				this.graphics.clear() ;
				this.graphics.beginFill( 0xFF0000, 0.1 );
				this.graphics.drawRect(0, 0, this.measuredWidth, this.measuredHeight ) ;
			}
			super.render() ;
		}
		
		//----------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override protected function create () : void
		{
			this.textField = new TextField( ) ;
			this.addChild( this.textField ) ;
			
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
				this.textField.x = 0 ; //this.marginLeft - Text.GUTTER_LEFT ;
				this.textField.y = 0 ; //this.marginTop - Text.GUTTER_TOP ;
				this.textField.width = this.explicitWidth ;
				this.textField.height = this.explicitHeight ;
				
				this.textField.type = this.type ;
				this.textField.embedFonts = Text.embedFonts;
				this.textField.antiAliasType = this.antiAliasType ;
				this.textField.selectable = this.selectable ;
				this.textField.mouseEnabled = this.selectable ;
				this.textField.styleSheet = Text.styleSheet ;
				this.textField.htmlText = "<span class='" + this.style + "'>" + this.htmlText + "</span>" ;
				this.textField.wordWrap = !this.autoWidth ;				
				this.textField.multiline = true ;				
				this.textField.autoSize = TextFieldAutoSize.LEFT ;
				this.textField.borderColor = 0xCCCCCC ;
				this.textField.border = true ;

				// TextField bug fix
				this.textField.width;
				this.textField.height;
				
				this.invalidate() ;		
			}
		}
		
		//----------------------------------------------------------------------

		protected function getCropLeft () : uint
		{
			var x : uint , y : uint, bitmapData : BitmapData ;
			this.textField.x = 0 ;
			this.textField.y = 0 ;
			for ( x = 0 ; x < this.textField.width ; x ++ )
			{
				bitmapData = new BitmapData( 1, this.textField.height, true, 0x00000000 ) ;
				bitmapData.draw( this ) ;
				for ( y = 0 ; y < this.textField.height ; y ++ ) 
				{
					if ( bitmapData.getPixel32( 0, y ) == 0xFF000000 ) // TODO 
					{
						bitmapData.dispose() ;
						return x ;
					}
				}
				this.textField.x -- ;
				bitmapData.dispose() ;
			}
			return 0 ;
		}
		
		protected function getCropRight () : uint
		{
			var x : uint , y : uint, bitmapData : BitmapData ;
			this.textField.x = 1 - this.textField.width ;
			this.textField.y = 0 ;
			for ( x = 0 ; x < this.textField.width ; x ++ )
			{
				bitmapData = new BitmapData( 1, this.textField.height, true, 0x00000000 ) ;
				bitmapData.draw( this ) ;
				for ( y = 0 ; y < this.textField.height ; y ++ ) 
				{
					if ( bitmapData.getPixel32( 0, y ) == 0xFF000000 ) // TODO 
					{
						bitmapData.dispose() ;
						return x ;
					}
				}
				this.textField.x ++ ;
				bitmapData.dispose() ;
			}
			return 0 ;
		}
		
		protected function getCropTop () : uint
		{
			var x : uint , y : uint, bitmapData : BitmapData ;
			this.textField.x = 0 ;
			this.textField.y = 0 ;
			for ( y = 0 ; y < this.textField.height ; y ++ )
			{
				bitmapData = new BitmapData( this.textField.width, 1, true, 0x00000000 ) ;
				bitmapData.draw( this ) ;
				for ( x = 0 ; x < this.textField.width ; x ++ )
				{
					if ( bitmapData.getPixel32( x, 0 ) == 0xFF000000 ) // TODO
					{
						bitmapData.dispose() ;
						return y ;
					}
				}
				this.textField.y -- ; 
				bitmapData.dispose() ;
			}
			return 1000 ;
		}
		
		protected function getCropBottom () : uint
		{
			var x : uint , y : uint, bitmapData : BitmapData ;
			this.textField.x = 0 ;
			this.textField.y = 1 - this.textField.height ;
			for ( y = 0 ; y < this.textField.height ; y ++ )
			{
				bitmapData = new BitmapData( this.textField.width, 1, true, 0x00000000 ) ;
				bitmapData.draw( this ) ;
				for ( x = 0 ; x < this.textField.width - 1 ; x ++ )
				{
					if ( bitmapData.getPixel32( x, 0 ) == 0xFF000000 ) // TODO
					{
						bitmapData.dispose() ;
						return y ;
					}
				}
				this.textField.y ++ ; 
				bitmapData.dispose() ;
			}
			return 0 ;
		}
	}
}
