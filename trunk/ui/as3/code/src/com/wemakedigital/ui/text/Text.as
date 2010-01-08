package com.wemakedigital.ui.text 
{
	import com.wemakedigital.log.Log;
	import com.wemakedigital.ui.Container;

	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.text.AntiAliasType;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextLineMetrics;

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
		
		//----------------------------------------------------------------------
		
		protected var _type : String = TextFieldType.DYNAMIC ;
		protected var _antiAliasType : String = AntiAliasType.NORMAL ;
		protected var _selectable : Boolean = false ;
		protected var _style : String = "default" ;
		protected var _htmlText : String = "" ;

		//----------------------------------------------------------------------
		
//		protected var _marginLeft : Number = 0 ;
//		protected var _marginRight : Number = 0 ;
//		protected var _marginTop : Number = 0 ;
//		protected var _marginBottom : Number = 0 ;
		
		//----------------------------------------------------------------------
		
		protected var _trimSample : String ; 
		protected var _trimSmoothingFontSize : Number ;
		protected var _trimTop : Boolean = true ;
		protected var _trimBottom : Boolean = true ;
		protected var _trimLineStart : Boolean = true ;
		protected var _trimLineEnd : Boolean = false ;
		
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
		
		/**
		 * TODO
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
		 * TODO
		 */
		public function get textManager ( ) : TextManager
		{
			return TextManager.getInstance( this.key ) ;
		}
		
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
		 * TODO
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
		 * TODO
		 */
		public function get trimSmoothingFontSize ( ) : Number
		{
			return this._trimSmoothingFontSize ;
		}
		
		/**
		 * @private
		 */
		public function set trimSmoothingFontSize ( value : Number ) : void
		{
			if ( this._trimSmoothingFontSize != value ) 
			{
				this._trimSmoothingFontSize = value ;
				this.update() ;
			}
		}
		
		/**
		 * TODO
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
		 * TODO
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
		 * TODO
		 */
		public function get trimLineStart ( ) : Boolean
		{
			return this._trimLineStart ;
		}
		
		/**
		 * @private
		 */
		public function set trimLineStart ( value : Boolean ) : void
		{
			if ( this._trimLineStart != value ) 
			{
				this._trimLineStart = value ;
				this.update() ;
			}
		}
		
		/**
		 * TODO
		 */
		public function get trimLineEnd ( ) : Boolean
		{
			return this._trimLineEnd ;
		}
		
		/**
		 * @private
		 */
		public function set trimLineEnd ( value : Boolean ) : void
		{
			if ( this._trimLineEnd != value ) 
			{
				this._trimLineEnd = value ;
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
			
			if ( this.autoWidth ) 
			{
				this.textField.width = this.explicitWidth ;
				this.trimHorizontal() ;
			}
			else if ( this.autoHeight ) 
			{
				this.textField.height = this.explicitHeight ;
				this.trimVertical() ;
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
				if ( !this.autoWidth ) 
				{
					this.textField.width = this.explicitWidth ;
					this.trimHorizontal() ;
				}
				
				if ( !this.autoHeight ) 
				{
					this.textField.height = this.explicitHeight ;
					this.trimVertical() ;
				}
				
				
				
				
//				// TODO reverse for right aligned text, just use textWidth for centered text.
//				var cropLeft : uint = this.getCropLeft() ; 
//				var cropRight : uint = this.textField.width - cropLeft - this.textField.textWidth >> 0 ;
//				this.textField.x = - cropLeft ;
//				
//				if ( this.sample && this.sample.length > 0 )
//				{
//					for ( var i : uint = 1, replace : String = this.sample ; i < this.textField.numLines ; i++ )
//						replace += "<br/>" + this.sample ;
//					this.textField.htmlText = "<span class='" + this.style + "'>" + replace + "</span>" ;
//				}
//				
//				var cropTop : uint = this.getCropTop() ; 
//				var cropBottom : uint = this.getCropBottom() ; 
//	
//				if ( this.sample && this.sample.length > 0 )
//					this.textField.htmlText = "<span class='" + this.style + "'>" + this.htmlText + "</span>" ;
//				
//				
//				this.textField.y = - cropTop ;
//				
//				this._measuredWidth = this.textField.width - cropLeft - cropRight >> 0 ;
//				this._measuredHeight = this.textField.height - cropTop - cropBottom >> 0 ;
//	
//				this.graphics.clear() ;
//				this.graphics.beginFill( 0xCCCCCC );
//				this.graphics.drawRect(0, 0, this.measuredWidth, this.measuredHeight ) ;
//				
//				Log.debug( this, "render", this.textField.textWidth ) ;
//				Log.debug( this, "render", this.pixelCount, cropLeft, cropRight, cropTop, cropTop ) ;
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
				this.textField.condenseWhite = true ;
				
				this.textField.x = 0 ; //this.marginLeft - Text.GUTTER_LEFT ;
				this.textField.y = 0 ; //this.marginTop - Text.GUTTER_TOP ;
				this.textField.width = this.explicitWidth ;
				this.textField.height = this.explicitHeight ;
				
				this.textField.type = this.type ;
				this.textField.embedFonts = this.textManager.embedFonts;
				this.textField.antiAliasType = this.antiAliasType ;
				this.textField.selectable = this.selectable ;
				this.textField.mouseEnabled = this.selectable ;
				this.textField.styleSheet = this.textManager.styleSheet ;
				this.textField.htmlText = "<span class='" + this.style + "'>" + this.htmlText + "</span>" ;
				this.textField.wordWrap = !this.autoWidth ;				
				this.textField.multiline = true ;				
				this.textField.autoSize = TextFieldAutoSize.LEFT ;
//				this.textField.borderColor = 0xCCCCCC ;
//				this.textField.border = true ;

				// TextField bug fix
				this.textField.width;
				this.textField.height;
				
				// var textTrim : TextTrim = this.textManager.getTrimData( this.style, this.antiAliasType, this.trimSample ) ;
				
				if ( this.autoWidth )
				{
					
				}
				
				if ( this.autoHeight )
				{
					
				}
				
				this.invalidate() ;		
			}
		}
		
		//----------------------------------------------------------------------

		protected function trimHorizontal () : void
		{
			
		}
		
		protected function trimVertical () : void
		{
			
		}
	
//		protected function getWidestLineIndex () : uint
//		{
//			var i : uint, index : uint, w : uint = 0 ;
//			for ( i = 0 ; i < this.textField.numLines ; i ++ )
//			{
//				var metrics : TextLineMetrics = this.textField.getLineMetrics( i ) ;
//				if ( metrics.width > w ) 
//				{
//					w = metrics.width ;
//					index = i ;
//				}
//			}
//			return index ;
//		}
//
//
//		protected function getTextWidth () : uint
//		{
//			var index : uint = this.getWidestLineIndex() ;
//			
//			var i : uint, w : uint = 0 ;
//			for ( i = 0 ; i < this.textField.numLines ; i ++ )
//			{
//				var metrics : TextLineMetrics = this.textField.getLineMetrics( i ) ;
//				if ( metrics.width > w ) w = metrics.width ;
//			}
//			return w >> 0 ;	
//		}

		protected function getCropLeft () : uint
		{	
			var point : Point = this.textField.localToGlobal( new Point() ) ;
			var i : uint, cropLeft : uint = 0 ;
			for ( i = 0 ; i < this.textField.numLines ; i ++ )
			{
				var metrics : TextLineMetrics = this.textField.getLineMetrics( i ) ;
				if ( metrics.x > cropLeft ) cropLeft = metrics.x ;
			}
			return cropLeft ? ( cropLeft - point.x >> 0 ) : 0 ;	
//			var x : uint , y : uint ;
//			var bitmapData : BitmapData = new BitmapData( 1, this.textField.getLineMetrics(0).height, true, 0x00000000 ) ;
//			this.textField.x = 0 ;
//			this.textField.y = 0 ;
//			for ( x = 0 ; x < this.textField.width ; x ++ )
//			{
//				bitmapData.draw( this ) ;
//				for ( y = 0 ; y < this.textField.height ; y ++ ) 
//				{
//					this.pixelCount ++ ;
//					if ( bitmapData.getPixel32( 0, y ) == 0xFF000000 ) // TODO 
//					{
//						bitmapData.dispose() ;
//						return x ;
//					}
//				}
//				this.textField.x -- ;
//			}
//			bitmapData.dispose() ;
//			return 0 ;
		}
		
//		protected function getCropRight () : uint
//		{
//			var x : uint , y : uint ;
//			var bitmapData : BitmapData = new BitmapData( 1, this.textField.height, true, 0x00000000 ) ;
//			this.textField.x = 1 - this.textField.width ;
//			this.textField.y = 0 ;
//			for ( x = 0 ; x < this.textField.width ; x ++ )
//			{
//				this.pixelCount ++ ;
//				for ( y = 0 ; y < this.textField.height ; y ++ ) 
//				{
//					bitmapData.draw( this ) ;
//					if ( bitmapData.getPixel32( 0, y ) == 0xFF000000 ) // TODO 
//					{
//						bitmapData.dispose() ;
//						return x ;
//					}
//				}
//				this.textField.x ++ ;
//			}
//			bitmapData.dispose() ;
//			return 0 ;
//		}
		
		protected function getCropTop () : uint
		{
			var x : uint , y : uint ;
			var bitmapData : BitmapData = new BitmapData( this.textField.textWidth, 1, true, 0x00000000 ) ;
			this.textField.y = 0 ;
			for ( y = 0 ; y < this.textField.height ; y ++ )
			{
				bitmapData.draw( this ) ;
				for ( x = 0 ; x < this.textField.textWidth ; x ++ )
				{
					if ( bitmapData.getPixel32( x, 0 ) == 0xFF000000 ) // TODO
					{
						bitmapData.dispose() ;
						return y ;
					}
				}
				this.textField.y -- ; 
			}
			bitmapData.dispose() ;
			return 1000 ;
		}
		
		protected function getCropBottom () : uint
		{
			var x : uint , y : uint ;
			var bitmapData : BitmapData = new BitmapData( this.textField.textWidth, 1, true, 0x00000000 ) ;
			this.textField.y = 1 - this.textField.height ;
			for ( y = 0 ; y < this.textField.height ; y ++ )
			{
				bitmapData.draw( this ) ;
				for ( x = 0 ; x < this.textField.textWidth - 1 ; x ++ )
				{
					if ( bitmapData.getPixel32( x, 0 ) == 0xFF000000 ) // TODO
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
