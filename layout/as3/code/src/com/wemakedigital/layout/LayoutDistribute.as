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
		protected var childrenSize : Number ;

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
		private var _anchor : String ;

		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private var _spaceFixed : Number = NaN ;

		/**
		 * @private
		 */
		private var _spaceFixedMin : Number = 0 ;

		/**
		 * @private
		 */
		private var _spaceFixedMax : Number = NaN ;

		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		private var _spaceRelative : Number = NaN ;

		/**
		 * @private
		 */
		private var _spaceRelativeMin : Number = 0 ;

		/**
		 * @private
		 */
		private var _spaceRelativeMax : Number = NaN ;

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
