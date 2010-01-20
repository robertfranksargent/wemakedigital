package com.wemakedigital.ui.text 
{
	import com.wemakedigital.ui.Container;
	import com.wemakedigital.ui.text.manager.TextManager;
	import com.wemakedigital.ui.text.manager.TextTrim;

	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextLineMetrics;
	
	/**
	 * Dynamic text component
	 */
	public class Text extends Container
	{
		//----------------------------------------------------------------------
		//
		//  Variables
		//
		//----------------------------------------------------------------------
		
		protected var textField : TextField ;
		
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
		
		protected var _trimSample : String = "bg" ; 
		protected var _trimTop : Boolean = true ;
		protected var _trimBottom : Boolean = true ;
		protected var _trimStart : Boolean = true ;
		protected var _trimEnd : Boolean = false ;
		
		protected var trimTopHeight : Number = 0 ; 
		protected var trimBottomHeight : Number = 0 ; 
		protected var trimStartWidth : Number = 0 ; 
		protected var trimEndWidth : Number = 0 ; 
		
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
			return ( !isNaN ( this._measuredWidth ) ? this._measuredWidth : ( this.textField ? this.textField.width : 0 ) ) + this.marginLeft + this.marginRight ;
		}

		/**
		 * @inheritDoc
		 */
		override public function get measuredHeight () : Number
		{
			return ( !isNaN ( this._measuredHeight ) ? this._measuredHeight : ( this.textField ? this.textField.height : 0 ) ) + this.marginTop + this.marginBottom ;
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
		
		/**
		 * A short sample of text to use when trimming top and bottom. Include 
		 * capitals or letters like "b" and "d" if you want to allow space for 
		 * ascenders and letters like "g" and "p" for descenders. The default 
		 * sample is "bg". 
		 */
		public function get trimSample ( ) : String
		{
			return this._trimSample ;
		}
		
		/**
		 * @private
		 */
		public function set trimSample ( value : String ) : void
		{
			if ( this._trimSample != value ) 
			{
				this._trimSample = value ;
				this.update() ;
			}
		}
		
		/**
		 * Trim white space from the bottom of the text field.
		 */
		public function get trimTop ( ) : Boolean
		{
			return this._trimTop ;
		}
		
		/**
		 * @private
		 */
		public function set trimTop ( value : Boolean ) : void
		{
			if ( this._trimTop != value ) 
			{
				this._trimTop = value ;
				this.update() ;
			}
		}
		
		/**
		 * Trim white space from the bottom of the text field, use when autoHeight is true.
		 */
		public function get trimBottom ( ) : Boolean
		{
			return this._trimBottom ;
		}
		
		/**
		 * @private
		 */
		public function set trimBottom ( value : Boolean ) : void
		{
			if ( this._trimBottom != value ) 
			{
				this._trimBottom = value ;
				this.update() ;
			}
		}
		
		/**
		 * Trim white space from the start of the text field.
		 */
		public function get trimStart ( ) : Boolean
		{
			return this._trimStart ;
		}
		
		/**
		 * @private
		 */
		public function set trimStart ( value : Boolean ) : void
		{
			if ( this._trimStart != value ) 
			{
				this._trimStart = value ;
				this.update() ;
			}
		}
		
		/**
		 * Trim white space from the end of the text field, use when autoWidth is true.
		 */
		public function get trimEnd ( ) : Boolean
		{
			return this._trimEnd ;
		}
		
		/**
		 * @private
		 */
		public function set trimEnd ( value : Boolean ) : void
		{
			if ( this._trimEnd != value ) 
			{
				this._trimEnd = value ;
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
		override public function beforeRender () : Boolean
		{
			if ( this.created && this.invalidated && !this.beforeRenderFlag )
			{
				this.textField.width = this.explicitWidth ; 
				this.textField.height = this.explicitHeight ;
				
				if ( this.htmlText.length > 0 )
				{
					this.trimHorizontal() ;
					this.trimVertical() ;
					
					this.textField.x = - this.trimStartWidth + marginLeft ; 
					this.textField.y = - this.trimTopHeight + marginTop ;

//					this.textField.x = marginLeft ; 
//					this.textField.y = marginTop ;
//
//					this._measuredWidth = NaN ;
//					this._measuredHeight = NaN ; 
				}
				else
				{	
					this._measuredWidth = 0 ;
					this._measuredHeight = 0 ;
				}
				
				this.beforeRenderFlag = true ;
				
				return false ;
			}
			return true ;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function render () : void
		{
			if ( this.created && this.invalidated )
			{
				this.beforeRenderFlag = false ;
			}
			super.render() ;
		}
		
		//----------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override protected function create () : void
		{
			this.mouseChildren = false ;
			
			this.textField = new TextField( ) ;
			this.textField.condenseWhite = true ;
			this.textField.type = TextFieldType.DYNAMIC ;
			this.textField.multiline = true ;		
			
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
//				this.textField.x = 0 ; 
//				this.textField.y = 0 ; 
//				this.textField.width = this.explicitWidth ;
//				this.textField.height = this.explicitHeight ;
				
				this.textField.embedFonts = this.textManager.embedFonts;
				this.textField.antiAliasType = this.antiAliasType || this.textManager.antiAliasType ;
				this.textField.gridFitType = this.gridFitType || this.textManager.gridFitType ;
				this.textField.thickness = this.thickness || this.textManager.thickness ;
				this.textField.sharpness = this.sharpness || this.textManager.sharpness ;
				this.textField.selectable = this.selectable ;
				this.textField.mouseEnabled = this.selectable ;
				this.textField.styleSheet = this.textManager.styleSheet ;
				this.textField.htmlText = "<span class='" + this.style + "'>" + this.htmlText + "</span>" ;
				this.textField.wordWrap = !this.autoWidth ;				
				this.textField.autoSize = TextFieldAutoSize.LEFT ;
				
				if ( !isNaN( this.width ) && this.explicitWidth != this.width ) this.explicitWidth = this.width ;
				if ( !isNaN( this.height ) && this.explicitHeight != this.height ) this.explicitHeight = this.height ;
				
				this.invalidate() ;
			}
		}
		
		//----------------------------------------------------------------------

		protected function trimHorizontal () : void
		{
			var textTrim : TextTrim = this.textManager.getTrimData( this.style, this.trimSample ) ; 
			
			if ( this.trimStart )
			{
				if ( !isNaN( textTrim.trimStartWidth ) ) this.trimStartWidth = textTrim.trimStartWidth ;
				else textTrim.trimStartWidth = this.trimStartWidth = this.getTrimStartWidth( this.getTrimStartRectangle() ) ; 
			}
			else this.trimStartWidth = 2 ;

			this.trimEndWidth = this.trimEnd ? this.getTrimEndWidth () : 0 ;
			
			this.textField.x = - this.trimStartWidth ; 
			this.textField.y = 0 ; 
			
			this._measuredWidth = Math.round( this.trimEnd ? this.textField.width - this.trimEndWidth - this.trimStartWidth : this.textField.textWidth ) ;
		}
		
		protected function getTrimStartRectangle () : Rectangle
		{
			var rectangle : Rectangle = new Rectangle( 0, 0, this.textField.textWidth, 0 ) ;
			var metrics : TextLineMetrics ;
			for ( var i : uint = 0, n : uint = this.textField.numLines; i < n; i ++ )
			{
				metrics = this.textField.getLineMetrics( i ) ; 
				if ( metrics.x > rectangle.x ) 
				{
					rectangle.x = metrics.x ;
					rectangle.y = metrics.height * i ;
					rectangle.height = metrics.height ;
				}
			}
			if ( !this.textField.embedFonts ) rectangle.x = Math.max ( 0, rectangle.x - this.textField.localToGlobal( new Point() ).x >> 0 ) ;
			return rectangle ;
		}
		
		protected function getTrimStartWidth ( rectangle : Rectangle ) : uint
		{
			var x : uint , y : uint ;
			var bitmapData : BitmapData = new BitmapData( 1, rectangle.height, true, 0x00000000 ) ;
			this.textField.x = - rectangle.x ;
			this.textField.y = - rectangle.y ;
			for ( x = 0 ; x < this.textField.width ; x ++ )
			{
				bitmapData.draw( this ) ;
				for ( y = 0 ; y < this.textField.height ; y ++ ) 
				{
					var pixel : uint = bitmapData.getPixel32( 0, y ) ;
					if ( pixel != 0x00000000 ) 
					{
						bitmapData.dispose() ;
						return x + rectangle.x ;
					}
				}
				this.textField.x -- ;
			}
			bitmapData.dispose() ;
			return 0 ;
		}
		
		protected function getTrimEndWidth () : uint
		{
			var x : uint , y : uint ;
			var bitmapData : BitmapData = new BitmapData( 1, this.textField.height, true, 0x00000000 ) ;
			this.textField.x = 1 - this.textField.width ;
			this.textField.y = 0 ;
			for ( x = 0 ; x < this.textField.width ; x ++ )
			{
				bitmapData.draw( this ) ;
				for ( y = 0 ; y < this.textField.height ; y ++ ) 
				{
					var pixel : uint = bitmapData.getPixel32( 0, y ) ;
					if ( pixel != 0x00000000 ) 
					{
						bitmapData.dispose() ;
						return x ;
					}
				}
				this.textField.x ++ ;
			}
			bitmapData.dispose() ;
			return 0 ;
		}
		
		//----------------------------------------------------------------------
		
		protected function trimVertical () : void
		{
			var textTrim : TextTrim = this.textManager.getTrimData( this.style, this.trimSample ) ;
			var cached : Boolean = !isNaN( textTrim.trimTopHeight ) && !isNaN( textTrim.trimBottomHeight ) ;
			
			if ( !cached ) 
			{
				if ( this.trimSample && this.trimSample.length > 0 )
				{
					for ( var i : uint = 1, replace : String = this.trimSample ; i < this.textField.numLines ; i++ )
						replace += "<br/>" + this.trimSample ;
					this.textField.htmlText = "<span class='" + this.style + "'>" + replace + "</span>" ;
				}
			}
			
			if ( this.trimTop )
			{
				if ( !isNaN( textTrim.trimTopHeight ) ) this.trimTopHeight = textTrim.trimTopHeight ;
				else textTrim.trimTopHeight = this.trimTopHeight = this.getTrimTopHeight() ; 
			}
			else this.trimTopHeight = 0 ;

			if ( this.trimBottom )
			{
				if ( !isNaN( textTrim.trimBottomHeight ) ) this.trimBottomHeight = textTrim.trimBottomHeight ;
				else textTrim.trimBottomHeight = this.trimBottomHeight = this.getTrimBottomHeight() ; 
			}
			else this.trimBottomHeight = 0 ;
			
			if ( !cached ) 
			{
				if ( this.trimSample && this.trimSample.length > 0 )
					this.textField.htmlText = "<span class='" + this.style + "'>" + this.htmlText + "</span>" ;
			}
				
			this.textField.x = - this.trimStartWidth ; 
			this.textField.y = - this.trimTopHeight ; 
			
			this._measuredHeight = Math.round( this.trimBottom ? this.textField.height - this.trimTopHeight - this.trimBottomHeight : this.textField.textHeight ) ;
			
//			this.content.graphics.clear() ;
//			this.content.graphics.beginFill( 0xFF0000, 0.2 );
//			this.content.graphics.drawRect( this.marginLeft, this.marginTop, this._measuredWidth, this._measuredHeight ) ;
		}

		protected function getTrimTopHeight () : uint
		{
			var x : uint , y : uint ;
			var bitmapData : BitmapData = new BitmapData( this.textField.textWidth, 1, true, 0x00000000 ) ;
			this.textField.y = 0 ;
			for ( y = 0 ; y < this.textField.height ; y ++ )
			{
				bitmapData.draw( this ) ;
				for ( x = 0 ; x < this.textField.textWidth ; x ++ )
				{
					var pixel : uint = bitmapData.getPixel32( x, 0 ) ;
					if ( pixel != 0x00000000 ) 
					{
						bitmapData.dispose() ;
						return y ;
					}
				}
				this.textField.y -- ; 
			}
			bitmapData.dispose() ;
			return 0 ;
		}
		
		protected function getTrimBottomHeight () : uint
		{
			var x : uint , y : uint ;
			var bitmapData : BitmapData = new BitmapData( this.textField.textWidth, 1, true, 0x00000000 ) ;
			this.textField.y = 1 - this.textField.height ;
			for ( y = 0 ; y < this.textField.height ; y ++ )
			{
				bitmapData.draw( this ) ;
				for ( x = 0 ; x < this.textField.textWidth - 1 ; x ++ )
				{
					var pixel : uint = bitmapData.getPixel32( x, 0 ) ;
					if ( pixel != 0x00000000 ) 
					{
						bitmapData.dispose() ;
						return y ;
					}
				}
				this.textField.y ++ ; 
			}
			bitmapData.dispose() ;
			return 0 ;
		}
	}
}
