package com.wemakedigital.layout 
{
	import com.wemakedigital.layout.LayoutContainer;

	public class LayoutDistribute extends LayoutContainer 
	{
		//----------------------------------------------------------------------
		//
		//  Variables
		//
		//----------------------------------------------------------------------

		/**
		 * @private
		 */
		protected var spaceSize : Number ;
		
		/**
		 * @private
		 */
		protected var position : Number ;

		/**
		 * @private
		 */
		protected var _anchor : String ;

		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected var _spaceFixed : Number = NaN ;

		/**
		 * @private
		 */
		protected var _spaceFixedMin : Number = 0 ;

		/**
		 * @private
		 */
		protected var _spaceFixedMax : Number = NaN ;

		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected var _spaceRelative : Number = NaN ;

		/**
		 * @private
		 */
		protected var _spaceRelativeMin : Number = 0 ;

		/**
		 * @private
		 */
		protected var _spaceRelativeMax : Number = NaN ;

		//----------------------------------------------------------------------
		
//		TODO
//		/**
//		 * @private
//		 */
//		protected var _separator : Class ;
//
//		/**
//		 * @private
//		 */
//		protected var separators : Array ;
		
		//----------------------------------------------------------------------
		//
		//  Getters and Setters
		//
		//----------------------------------------------------------------------
		
		/**
		 * The anchor point for distribution.
		 */
		public function get anchor () : String
		{
			return this._anchor;
		}

		/**
		 * @private
		 */
		public function set anchor ( value : String ) : void
		{
			this._anchor = value ;
			this.updateProperties() ;
		}

		//----------------------------------------------------------------------
		
		/**
		 * The fixed space in pixels.
		 */
		public function get spaceFixed () : Number
		{
			return this._spaceFixed;
		}

		/**
		 * @private
		 */
		public function set spaceFixed ( value : Number ) : void
		{
			this._spaceFixed = value ;
			
			// If space is fixed, it can't be relative.
			if ( ! isNaN( this._spaceFixed ) ) this._spaceRelative = NaN ;
			
			this.updateProperties() ;
		}

		/**
		 * The minimum fixed space in pixels.
		 */
		public function get spaceFixedMin () : Number
		{
			return this._spaceFixedMin;
		}

		/**
		 * @private
		 */
		public function set spaceFixedMin ( value : Number ) : void
		{
			this._spaceFixedMin = value ;
		}

		/**
		 * The maximum fixed space in pixels.
		 */
		public function get spaceFixedMax () : Number
		{
			return this._spaceFixedMax;
		}

		/**
		 * @private
		 */
		public function set spaceFixedMax ( value : Number ) : void
		{
			this._spaceFixedMax = value ;
		}

		//----------------------------------------------------------------------
		
		/**
		 * The space relative to the container size.
		 */
		public function get spaceRelative () : Number
		{
			return this._spaceRelative;
		}

		/**
		 * @private
		 */
		public function set spaceRelative ( value : Number ) : void
		{
			this._spaceRelative = value ;
			
			// If the space is relative, it can't be fixed.
			if ( ! isNaN( this._spaceRelative ) ) this._spaceFixed = NaN ;
			
			this.updateProperties() ;
		}

		/**
		 * The minimum space relative to the container size.
		 */
		public function get spaceRelativeMin () : Number
		{
			return this._spaceRelativeMin;
		}

		/**
		 * @private
		 */
		public function set spaceRelativeMin ( value : Number ) : void
		{
			this._spaceRelativeMin = value ;
		}

		/**
		 * The maximum space relative to the container size.
		 */
		public function get spaceRelativeMax () : Number
		{
			return this._spaceRelativeMax;
		}

		/**
		 * @private
		 */
		public function set spaceRelativeMax ( value : Number ) : void
		{
			this._spaceRelativeMax = value ;
		}

		//----------------------------------------------------------------------
		
//		TODO
//		/**
//		 * A separator class to be intantiated and positioned between each distributed child.
//		 */
//		public function get separator () : Class
//		{
//			return this._separator;
//		}
//
//		/**
//		 * @private
//		 */
//		public function set separator ( value : Class ) : void
//		{
//			this._separator = value ;
//			
//			this.updateProperties() ;
//		}

		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Class contructor.
		 */
		public function LayoutDistribute ()
		{
			super( ) ;
		}
	}
}
