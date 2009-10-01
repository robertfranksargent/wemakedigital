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
		protected var separators : Array ;
		
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
				this.clearSeparators() ;
				this._separator = value ;			
				this.addSeparators() ;
				this.updateProperties() ;
				this.updateDisplay() ;
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
			if ( child && ! this.content.contains( child ) )
			{
				if ( this.children ) this._children.push( child ) ;
				else this._children = [ child ] ;
				if ( child is LayoutComponent ) ( child as LayoutComponent ).container = this;
				this.content.addChild( child ) ;
				if ( this.created ) 
				{
					this.clearSeparators() ;			
					this.addSeparators() ;
					this.updateProperties( ) ;
					this.updateDisplay( ) ;
				}
			}
			return child ;
		}

		/**
		 * @inheritDoc
		 */
		override public function removeChild ( child : DisplayObject ) : DisplayObject
		{
			if ( child && this.content.contains( child ) )
			{
				this.content.removeChild( child ) ;
				if ( this.children ) 
				{
					this._children = this._children.splice( this._children.indexOf( child ), 1 ) ;
					if ( this.created ) 
					{
						this.clearSeparators() ;			
						this.addSeparators() ;
						this.updateProperties( ) ;
						this.updateDisplay( ) ;
					}
				}
			}
			return child ;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function createChildren ( ) : void
		{
			this.clearSeparators() ;			
			this.addSeparators() ;
			super.createChildren() ;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeChildren ( ) : void
		{
			this.clearSeparators() ;			
			super.removeChildren() ;
		}
		
		/**
		 * @private
		 */
		protected function clearSeparators () : void
		{
			for each ( var child : LayoutComponent in this.separators )
			{
				if ( child is this.separator ) 
				{
					if ( this.content.contains( child ) ) this.content.removeChild( child ) ;
					if ( this._children ) this._children = this._children.splice( this._children.indexOf( child ), 1 ) ;
				}
			}
			this.separators = [] ;
		}

		/**
		 * @private
		 */
		protected function addSeparators () : void
		{
			if ( this._children && this.separator ) 
			{
				var childrenSeparated : Array = [] ;
				
				for ( var i : uint = 0, n : uint = this._children.length; i < n; i++ )
				{
					if ( this._children[ i ] is LayoutComponent && ! ( this._children[ i ] is this.separator ) )
					{
						var child : LayoutComponent = this._children[ i ] as LayoutComponent ;
						childrenSeparated.push ( child ) ;
						if ( i < ( n -1 ) )
						{
							var SeparatorClass : Class = this.separator ;
							var separatorInstance : LayoutComponent = new SeparatorClass() as LayoutComponent ;
							separatorInstance.container = this ;
							childrenSeparated.push ( separatorInstance ) ;
							this.content.addChild( separatorInstance ) ;
						}
					}
				}
				this._children = childrenSeparated ;
			}
		}
	}
}
