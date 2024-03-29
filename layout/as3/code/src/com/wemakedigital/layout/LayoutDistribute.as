package com.wemakedigital.layout 
{
	import com.wemakedigital.layout.LayoutContainer;

	import flash.display.DisplayObject;

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
		
		/**
		 * @private
		 */
		protected var _separator : Class ;

		/**
		 * @private
		 */
		protected var separators : Array = [] ;
		
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
		
		/**
		 * A separator class to be intantiated and positioned between each distributed child.
		 */
		public function get separator () : Class
		{
			return this._separator;
		}

		/**
		 * @private
		 */
		public function set separator ( value : Class ) : void
		{
			if ( this._separator != value )
			{
				this.removeSeparators() ;			
				this._separator = value ;
				this.createSeparators() ;			
				this.updateProperties() ;
			}
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
		
		//----------------------------------------------------------------------
		//
		//  Methods
		//
		//----------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override public function addChild ( child : DisplayObject ) : DisplayObject
		{
			if ( child && ! this.content.contains( child ) && this.children && this.separator )
			{
				if ( this.children.length > 0 )
				{
					var instance : LayoutComponent = this.createSeparator() ;
					if ( instance ) this._children.push( instance ) ;
				}
			}
			return super.addChild ( child ) ;
		}

		/**
		 * @inheritDoc
		 */
		override public function removeChild ( child : DisplayObject ) : DisplayObject
		{
			if ( child && this.content.contains( child ) && this.children )
			{
				if ( this._children.indexOf( child ) > 0 )
				{
					var instance : DisplayObject = this._children[ this._children.indexOf( child ) - 1 ] as DisplayObject ;
					if( this.separator ) if ( instance is this.separator ) this.removeSeparator( instance as LayoutComponent ) ;
				}
			}
			return super.removeChild ( child ) ;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function createChildren ( ) : void
		{			
			this.createSeparators() ;
			super.createChildren() ;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeChildren ( ) : void
		{
			this.removeSeparators() ;
			super.removeChildren() ;
		}

		/**
		 * @private
		 */
		protected function createSeparator () : LayoutComponent
		{
			if ( this.separator )
			{
				var SeparatorClass : Class = this.separator ;
				var instance : LayoutComponent = new SeparatorClass() as LayoutComponent ;
				instance.container = this ;
				this.separators.push( instance ) ;
				this.content.addChild( instance ) ;
				return instance ; 
			}
			return null ;
		}
		
		/**
		 * @private
		 */
		protected function removeSeparator ( instance : LayoutComponent ) : void
		{
			if ( this._children.indexOf( instance ) > -1 ) 
			{
				this._children.splice( this._children.indexOf( instance ), 1 ) ;
				if ( this.separators.indexOf( instance ) > -1 ) this.separators.splice( this.separators.indexOf( instance ), 1 ) ;
				if ( this.content.contains( instance ) ) this.content.removeChild( instance ) ;
			}
		}
		
		/**
		 * @private
		 */
		protected function createSeparators () : void
		{
			if ( this._children && this.separator ) 
			{
				var separatedChildren : Array = [] ;
				
				for ( var i : uint = 0, n : uint = this._children.length; i < n; i++ )
				{
					if ( this._children[ i ] is LayoutComponent && ! ( this._children[ i ] is this.separator ) )
					{
						var child : LayoutComponent = this._children[ i ] as LayoutComponent ;
						separatedChildren.push ( child ) ;
						if ( i < ( n -1 ) )
						{
							separatedChildren.push ( this.createSeparator() ) ;
						}
					}
				}
				this._children = separatedChildren ;
			}
		}
		
		/**
		 * @private
		 */
		protected function removeSeparators () : void
		{
			for each ( var child : LayoutComponent in this.separators )
			{
				this.removeSeparator( child ) ;
			}
		}
	}
}
