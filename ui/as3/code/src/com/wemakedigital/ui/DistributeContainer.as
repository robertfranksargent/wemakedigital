package com.wemakedigital.ui 
{
	import com.wemakedigital.ui.Container;

	import flash.display.DisplayObject;

	/**
	 * Super class for HContainer and VContainer.
	 */
	public class DistributeContainer extends Container 
	{
		//----------------------------------------------------------------------
		//
		//  Variables
		//
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected var explicitSpace : Number ;

		/**
		 * @private
		 */
		protected var totalSpace : Number ;
		
		/**
		 * @private
		 */
		protected var position : Number ;

		/**
		 * @private
		 */
		protected var _anchor : String ;

		//----------------------------------------------------------------------
		
		// TODO rename to space
		/**
		 * @private
		 */
		protected var _space : Number = NaN ;

		/**
		 * @private
		 */
		protected var _minSpace : Number = 0 ;

		/**
		 * @private
		 */
		protected var _maxSpace : Number = NaN ;

		//----------------------------------------------------------------------
		
		// TODO rename to relativeSpace
		/**
		 * @private
		 */
		protected var _relativeSpace : Number = NaN ;

		/**
		 * @private
		 */
		protected var _minRelativeSpace : Number = 0 ;

		/**
		 * @private
		 */
		protected var _maxRelativeSpace : Number = NaN ;

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
		//  Properties
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
			this.update() ;
		}

		//----------------------------------------------------------------------
		
		/**
		 * The fixed space in pixels.
		 */
		public function get space () : Number
		{
			return this._space;
		}

		/**
		 * @private
		 */
		public function set space ( value : Number ) : void
		{
			this._space = value ;
			
			// If space is fixed, it can't be relative.
			if ( ! isNaN( this._space ) ) this._relativeSpace = NaN ;
			
			this.update() ;
		}

		/**
		 * The minimum fixed space in pixels.
		 */
		public function get minSpace () : Number
		{
			return this._minSpace;
		}

		/**
		 * @private
		 */
		public function set minSpace ( value : Number ) : void
		{
			this._minSpace = value ;
		}

		/**
		 * The maximum fixed space in pixels.
		 */
		public function get maxSpace () : Number
		{
			return this._maxSpace;
		}

		/**
		 * @private
		 */
		public function set maxSpace ( value : Number ) : void
		{
			this._maxSpace = value ;
		}

		//----------------------------------------------------------------------
		
		/**
		 * The space relative to the container size.
		 */
		public function get relativeSpace () : Number
		{
			return this._relativeSpace;
		}

		/**
		 * @private
		 */
		public function set relativeSpace ( value : Number ) : void
		{
			this._relativeSpace = value ;
			
			// If the space is relative, it can't be fixed.
			if ( ! isNaN( this._relativeSpace ) ) this._space = NaN ;
			
			this.update() ;
		}

		/**
		 * The minimum space relative to the container size.
		 */
		public function get minRelativeSpace () : Number
		{
			return this._minRelativeSpace;
		}

		/**
		 * @private
		 */
		public function set minRelativeSpace ( value : Number ) : void
		{
			this._minRelativeSpace = value ;
		}

		/**
		 * The maximum space relative to the container size.
		 */
		public function get maxRelativeSpace () : Number
		{
			return this._maxRelativeSpace;
		}

		/**
		 * @private
		 */
		public function set maxRelativeSpace ( value : Number ) : void
		{
			this._maxRelativeSpace = value ;
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
		public function DistributeContainer () 
		{
			super( );
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
			if ( child && ! this.content.contains( child ) && this.separator && this.children && this.children.length > 0 )
			{
				var instance : Component = this.createSeparator() ;
				if ( instance ) this._children.push( instance ) ;
			}
			return super.addChild ( child ) ;
		}

		/**
		 * @inheritDoc
		 */
		override public function removeChild ( child : DisplayObject ) : DisplayObject
		{
			if ( child && this.content.contains( child ) && this.children && this._children.indexOf( child ) > 0 )
			{
				var instance : DisplayObject = this._children[ this._children.indexOf( child ) - 1 ] as DisplayObject ;
				if( this.separator ) if ( instance is this.separator ) this.removeSeparator( instance as Component ) ;
			}
			return super.removeChild ( child ) ;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function create ( ) : void
		{			
			this.createSeparators() ;
			super.create() ;
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
		 * @inheritDoc
		 */
		override internal function updateSizeOfSiblings () : void
		{
			if ( this.created )
			{
				for each ( var childComponent : Component in this.components )
				{
					if ( ! isNaN( childComponent.spareWidth ) ) childComponent.explicitWidth = Math.min( Math.max( Math.round( ( this.explicitWidth - this.measuredWidth ) * childComponent.spareWidth ) , childComponent.minWidth ) , isNaN( childComponent.maxWidth ) ? Number.MAX_VALUE : childComponent.maxWidth ) ; 
					if ( ! isNaN( childComponent.spareHeight ) ) childComponent.explicitHeight = Math.min( Math.max( Math.round( ( this.explicitHeight - this.measuredHeight ) * childComponent.spareHeight ) , childComponent.minHeight ) , isNaN( childComponent.maxHeight ) ? Number.MAX_VALUE : childComponent.maxHeight ) ; 
				}
				
				for each ( var childContainer : Container in this.containers )
					childContainer.updateSizeOfSiblings() ;
			}
		}

		/**
		 * @private
		 */
		protected function createSeparator () : Component
		{
			if ( this.separator )
			{
				var SeparatorClass : Class = this.separator ;
				var instance : Component = new SeparatorClass() as Component ;
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
		protected function removeSeparator ( instance : Component ) : void
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
					if ( this._children[ i ] is Component && ! ( this._children[ i ] is this.separator ) )
					{
						var child : Component = this._children[ i ] as Component ;
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
			for each ( var child : Component in this.separators )
			{
				this.removeSeparator( child ) ;
			}
		}
	}
}
