package com.wemakedigital.ui.text.manager 
{
	import flash.text.GridFitType;
	import flash.text.AntiAliasType;
	import flash.events.EventDispatcher;
	import flash.text.StyleSheet;
	import flash.utils.Dictionary;

	/**
	 * Multiton manager class for text and styles.
	 */
	public class TextManager extends EventDispatcher 
	{
		//----------------------------------------------------------------------
		//
		//  Multiton
		//
		//----------------------------------------------------------------------
		
		/**
		 * The default Multiton key.
		 */
		public static const DEFAULT_KEY : String = "default" ;
		
		/**
		 * The Multiton instance map.
		 */
		protected static var instances : Dictionary = new Dictionary(); 
		
		/**
		 * The Multiton Key for this app
		 */
		protected var key : String;
		
		/**
		 * Multiton Factory method.
		 * 
		 * @param key The Multiton instance key.
		 * @return The Multiton instance of the Facade.
		 */            
		public static function getInstance ( key : String = "default" ) : TextManager 
		{
			if ( !instances ) instances = new Dictionary() ;
			if ( !instances[ key ] ) instances[ key ] = new TextManager( key );
			return instances[ key ] as TextManager ;
		}
		
		//----------------------------------------------------------------------
		//
		//  Variables
		//
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected var _styleSheet : StyleSheet ;
				
		/**
		 * @private
		 */
		protected var trimData : Array = [] ;

		//----------------------------------------------------------------------
		//
		//  Properties
		//
		//----------------------------------------------------------------------
		
		/**
		 * The stylesheet assigned to this manager instance.
		 */
		public function get styleSheet () : StyleSheet
		{
			if ( ! this._styleSheet ) this._styleSheet = new StyleSheet() ;
			if ( this._styleSheet.styleNames.indexOf( ".default" ) < 0 )
				this._styleSheet.setStyle( ".default", { fontFamily : "_serif", 
														 fontSize : "10",
														 color : "#000000",
														 fontWeight : "regular",
														 letterSpacing : "0",
														 leading : "0" } ) ;
			if ( this._styleSheet.styleNames.indexOf( ".defaultbuttonover" ) < 0 )
				this._styleSheet.setStyle( ".defaultbuttonover", { color : "#00FF00" } ) ;
			return this._styleSheet ;
		}
		
		/**
		 * @private
		 */
		public function set styleSheet ( value : StyleSheet ) : void
		{
			this._styleSheet = value ;
		}

		/**
		 * Embed fonts in text components linked to this manager instance.
		 */
		public var embedFonts : Boolean = false ;
		
		/**
		 * Default antiAliasType.
		 */
		public var antiAliasType : String = AntiAliasType.ADVANCED ;
		
		/**
		 * Default gridFitType.
		 */
		public var gridFitType : String = GridFitType.NONE ;
		
		/**
		 * Default thickness.
		 */
		public var thickness : Number = 0 ;
		
		/**
		 * Default sharpness.
		 */
		public var sharpness : Number = 0 ;
		
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 * 
		 * @param key The Multiton instance key.
		 */
		public function TextManager ( key : String )
		{
			this.key = key ;
			super( );
		}
		
		//----------------------------------------------------------------------
		//
		//  Methods
		//
		//----------------------------------------------------------------------
		
		/**
		 * Gets existing trim data for the given parameters and creates a new 
		 * TextTrim object if one does not exist.
		 * 
		 * @param style The css style name.
		 * @param antiAliasType The anti alias type of the text field.
		 * @param sample The sample text used for trimming.
		 * @return A TextTrim object.
		 */
		public function getTrimData ( style : String, sample : String ) : TextTrim
		{
			for each ( var textTrim : TextTrim in this.trimData )
				if ( textTrim.style == style && textTrim.sample == sample ) 
					return textTrim ;
			return new TextTrim ( style, sample ) ;
		}
	}
}
