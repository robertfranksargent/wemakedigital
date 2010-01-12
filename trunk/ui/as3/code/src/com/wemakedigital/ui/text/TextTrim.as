package com.wemakedigital.ui.text 
{

	/**
	 * Text trimming value object.
	 */
	public class TextTrim 
	{
		//----------------------------------------------------------------------
		//
		//  Properties
		//
		//----------------------------------------------------------------------
		
		/**
		 * The css style name.
		 */
		public var style : String ;
		
		/**
		 * The sample text used for trimming.
		 */
		public var sample : String ;
		
		/**
		 * The pixels to trim from the top.
		 */
		public var trimTopHeight : Number ;
		
		/**
		 * The pixels to trim from the bottom.
		 */
		public var trimBottomHeight : Number ;
		
		/**
		 * The pixels to trim from the start of the line.
		 */
		public var trimStartWidth : Number ;

		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 * 
		 * @param style The css style name.
		 * @param antiAliasType The anti alias type of the text field.
		 * @param sample The sample text used for trimming.
		 */
		public function TextTrim ( style : String, sample : String ) 
		{
			this.style = style ;
			this.sample = sample ;
		}
	}
}
