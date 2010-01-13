package com.wemakedigital.ui 
{
	import com.wemakedigital.ui.core.ShowHideComponent;

	import flash.events.Event;

	/**
	 * <p>The base component class for the ui framework.</p> 
	 * 
	 * <p>Extending the <code>flash.display.Sprite</code> class it provides 
	 * methods for the following:</p>
	 * 
	 * <ul>
	 * <li>Creation when added to the display list</li>
	 * <li>Destruction when removed from the display list</li>
	 * <li>Updating when a property changes</li>
	 * <li>Replaces the <code>width</code> and <code>height</code> properties 
	 * inherited from <code>flash.display.DisplayObject</code> which become read 
	 * only via <code>displayWidth</code> and <code>displayHeight</code> properties.
	 * <li>Invalidation when the component needs to be re-rendered</li>
	 * <li>Rendering the display</li>
	 * <li>Rendering as a bitmap</li>
	 * <li>Rendering a background colour with alpha channel</li>
	 * <li>Easily enabling and disabling mouse and keyboard interactivity</li>
	 * </ul>
	 */
	public class Component extends ShowHideComponent 
	{	
		//----------------------------------------------------------------------
		//
		//  Variables
		//
		//----------------------------------------------------------------------
		
		/**
	     *  @private
	     */
	    private var _id : String ;
				
		/**
	     *  @private
	     */
	    private var _container : Container ;
		
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected var _autoWidth : Boolean = false ;
		
		/**
		 * @private
		 */
		protected var _autoHeight : Boolean = false ;

		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected var _relativeWidth : Number = NaN ;
		
		/**
		 * @private
		 */
		protected var _relativeHeight : Number = NaN ;
		
		/**
		 * @private
		 */
		protected var _minRelativeWidth : Number = 0 ;
		
		/**
		 * @private
		 */
		protected var _minRelativeHeight : Number = 0 ;
		
		/**
		 * @private
		 */
		protected var _maxRelativeWidth : Number = NaN ;
		
		/**
		 * @private
		 */
		protected var _maxRelativeHeight : Number = NaN ;
		
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected var _spareWidth : Number = NaN ;
		
		/**
		 * @private
		 */
		protected var _spareHeight : Number = NaN ;
		
		/**
		 * @private
		 */
		protected var _minSpareWidth : Number = 0 ;
		
		/**
		 * @private
		 */
		protected var _minSpareHeight : Number = 0 ;
		
		/**
		 * @private
		 */
		protected var _maxSpareWidth : Number = NaN ;
		
		/**
		 * @private
		 */
		protected var _maxSpareHeight : Number = NaN ;
		
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected var _left : Number = NaN ;
		
		/**
		 * @private
		 */
		protected var _right : Number = NaN ;
		
		/**
		 * @private
		 */
		protected var _top : Number = NaN ;
		
		/**
		 * @private
		 */
		protected var _bottom : Number = NaN ;
		
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected var _horizontalCentre : Number = NaN ;
		
		/**
		 * @private
		 */
		protected var _verticalCentre : Number = NaN ;
		
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected var invalidated : Boolean = false ;
		
		//----------------------------------------------------------------------
		//
		//  Properties
		//
		//----------------------------------------------------------------------
		
	    /**
	     * ID of the component. This value becomes the instance name of the 
	     * object and should not contain any white space or special characters.
	     */
	    public function get id () : String
	    {
	        return this._id ;
	    }
	
	    /**
	     *  @private
	     */
	    public function set id ( value : String ) : void
	    {
	        this._id = value ;
	    }

	    /**
	     * The component's container in the display hierarchy.
	     */
	    public function get container () : Container
	    {
	        return this._container ;
	    }
		
	    /**
	     *  @private
	     */
	    public function set container ( value : Container ) : void
	    {
	        this._container = value ;
	    }
    
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		override public function set width (value : Number) : void
		{
			if ( !isNaN ( value ) )
			{
				value = Math.max ( this.minWidth, isNaN ( this.maxWidth ) ? value : Math.min ( this.maxWidth, value ) ) ;
				if ( value != this.width )
				{
					this._width = value ;
					this._autoWidth = false ;
					this._relativeWidth = NaN ;
					this._spareWidth = NaN ;
					this.update() ;
				}
			}
		}
		
		/**
		 * @private
		 */
		override public function set height (value : Number) : void
		{
			if ( !isNaN ( value ) )
			{
				value = Math.max ( this.minHeight, isNaN ( this.maxHeight ) ? value : Math.min ( this.maxHeight, value ) ) ;
				if ( value != this.height )
				{
					this._height = value ;
					this._autoHeight = false ;
					this._relativeHeight = NaN ;
					this._spareHeight = NaN ;
					this.update() ;
				}
			}
		}

		//----------------------------------------------------------------------

		/**
		 * @private
		 */
		override public function set explicitWidth (value : Number) : void
		{
			if ( this._explicitWidth != value ) 
			{
				this._explicitWidth = value ;
				this.invalidated = true ;
			}
		}
		
		/**
		 * @private
		 */
		override public function set explicitHeight (value : Number) : void
		{
			if ( this._explicitHeight != value ) 
			{
				this._explicitHeight = value ;
				this.invalidated = true ;
			}
		}

		//----------------------------------------------------------------------
		
		/**
		 * The auto width mode of the component.
		 */
		public function get autoWidth () : Boolean
		{
			return this._autoWidth ;
		}
		
		/**
		 * @private
		 */
		public function set autoWidth (value : Boolean) : void
		{
			if ( value != this.autoWidth )
			{
				this._autoWidth = value ;
				this._width = this.autoWidth ? NaN : 0 ;
				this._relativeWidth = NaN ;
				this._spareWidth = NaN ;
				this.update() ;
			}
		}
		
		/**
		 * The auto height mode of the component.
		 */
		public function get autoHeight () : Boolean
		{
			return this._autoHeight ;
		}
		
		/**
		 * @private
		 */
		public function set autoHeight (value : Boolean) : void
		{
			if ( value != this.autoHeight )
			{
				this._autoHeight = value ;
				this._height = this.autoHeight ? NaN : 0 ;
				this._relativeHeight = NaN ;
				this._spareHeight = NaN ;
				this.update() ;
			}
		}

		//----------------------------------------------------------------------
		
		/**
		 * The relative width of the component.
		 */
		public function get relativeWidth () : Number
		{
			return this._relativeWidth ;
		}
		
		/**
		 * @private
		 */
		public function set relativeWidth (value : Number) : void
		{
			value = Math.max ( this.minRelativeWidth, isNaN ( this.maxRelativeWidth ) ? value : Math.min ( this.maxRelativeWidth, value ) ) ;
			if ( value != this.relativeWidth )
			{
				this._relativeWidth = value ;
				this._width = NaN ;
				this._autoWidth = false ;
				this._spareWidth = NaN ;
				this.update() ;
			}
		}
		
		/**
		 * The relative height of the component.
		 */
		public function get relativeHeight () : Number
		{
			return this._relativeHeight ;
		}
		
		/**
		 * @private
		 */
		public function set relativeHeight (value : Number) : void
		{
			value = Math.max ( this.minRelativeHeight, isNaN ( this.maxRelativeHeight ) ? value : Math.min ( this.maxRelativeHeight, value ) ) ;
			if ( value != this.relativeHeight )
			{
				this._relativeHeight = value ;
				this._height = NaN ;
				this._autoHeight = false ;
				this._spareHeight = NaN ;
				this.update() ;
			}
		}
		
		/**
		 * The minumum relative width of the component.
		 */
		public function get minRelativeWidth () : Number
		{
			return this._minRelativeWidth ;
		}
		
		/**
		 * @private
		 */
		public function set minRelativeWidth (value : Number) : void
		{
			value = Math.max ( 0, value ) ;
			if ( value != this.minRelativeWidth )
			{
				this._minRelativeWidth = value ;
				this.relativeWidth = this.relativeWidth ;
			}
		}
		
		/**
		 * The minumum relative height of the component.
		 */
		public function get minRelativeHeight () : Number
		{
			return this._minRelativeHeight ;
		}
		
		/**
		 * @private
		 */
		public function set minRelativeHeight (value : Number) : void
		{
			value = Math.max ( 0, value ) ;
			if ( value != this.minRelativeHeight )
			{
				this._minRelativeHeight = value ;
				this.relativeHeight = this.relativeHeight ;
			}
		}
		
		/**
		 * The maximum relative width of the component.
		 */
		public function get maxRelativeWidth () : Number
		{
			return this._maxRelativeWidth ;
		}
		
		/**
		 * @private
		 */
		public function set maxRelativeWidth (value : Number) : void
		{
			value = Math.max ( 0, value ) ;
			if ( value != this.maxRelativeWidth )
			{
				this._maxRelativeWidth = value ;
				this.relativeWidth = this.relativeWidth ;
			}
		}
		
		/**
		 * The maximum relative height of the component
		 */
		public function get maxRelativeHeight () : Number
		{
			return this._maxRelativeHeight ;
		}
		
		/**
		 * @private
		 */
		public function set maxRelativeHeight (value : Number) : void
		{
			value = Math.max ( 0, value ) ;
			if ( value != this.maxRelativeHeight )
			{
				this._maxRelativeHeight = value ;
				this.relativeHeight = this.relativeHeight ;
			}
		}
		
		//----------------------------------------------------------------------
		
		/**
		 * The spare width of the component.
		 */
		public function get spareWidth () : Number
		{
			return this._spareWidth ;
		}
		
		/**
		 * @private
		 */
		public function set spareWidth (value : Number) : void
		{
			value = Math.max ( this.minSpareWidth, isNaN ( this.maxSpareWidth ) ? value : Math.min ( this.maxSpareWidth, value ) ) ;
			if ( value != this.spareWidth )
			{
				this._spareWidth = value ;
				this._width = NaN ;
				this._autoWidth = false ;
				this._relativeWidth = NaN ;
				this.update() ;
			}
		}
		
		/**
		 * The spare height of the component.
		 */
		public function get spareHeight () : Number
		{
			return this._spareHeight ;
		}
		
		/**
		 * @private
		 */
		public function set spareHeight (value : Number) : void
		{
			value = Math.max ( this.minSpareHeight, isNaN ( this.maxSpareHeight ) ? value : Math.min ( this.maxSpareHeight, value ) ) ;
			if ( value != this.spareHeight )
			{
				this._spareHeight = value ;
				this._height = NaN ;
				this._autoHeight = false ;
				this._relativeHeight = NaN ;
				this.update() ;
			}
		}
		
		/**
		 * The minumum spare width of the component.
		 */
		public function get minSpareWidth () : Number
		{
			return this._minSpareWidth ;
		}
		
		/**
		 * @private
		 */
		public function set minSpareWidth (value : Number) : void
		{
			value = Math.max ( 0, value ) ;
			if ( value != this.minSpareWidth )
			{
				this._minSpareWidth = value ;
				this.spareWidth = this.spareWidth ;
			}
		}
		
		/**
		 * The minumum spare height of the component.
		 */
		public function get minSpareHeight () : Number
		{
			return this._minSpareHeight ;
		}
		
		/**
		 * @private
		 */
		public function set minSpareHeight (value : Number) : void
		{
			value = Math.max ( 0, value ) ;
			if ( value != this.minSpareHeight )
			{
				this._minSpareHeight = value ;
				this.spareHeight = this.spareHeight ;
			}
		}
		
		/**
		 * The maximum spare width of the component.
		 */
		public function get maxSpareWidth () : Number
		{
			return this._maxSpareWidth ;
		}
		
		/**
		 * @private
		 */
		public function set maxSpareWidth (value : Number) : void
		{
			value = Math.max ( 0, value ) ;
			if ( value != this.maxSpareWidth )
			{
				this._maxSpareWidth = value ;
				this.spareWidth = this.spareWidth ;
			}
		}
		
		/**
		 * The maximum spare height of the component
		 */
		public function get maxSpareHeight () : Number
		{
			return this._maxSpareHeight ;
		}
		
		/**
		 * @private
		 */
		public function set maxSpareHeight (value : Number) : void
		{
			value = Math.max ( 0, value ) ;
			if ( value != this.maxSpareHeight )
			{
				this._maxSpareHeight = value ;
				this.spareHeight = this.spareHeight ;
			}
		}
		
		//----------------------------------------------------------------------
		
		/**
		 * Anchor padding from the left of the container.
		 */
		public function get left () : Number
		{
			return this._left ;
		}
		
		/**
		 * @private
		 */
		public function set left (value : Number) : void
		{
			this._left = Math.max ( 0, value ) ;
			if ( ! isNaN ( this._left ) && ! isNaN ( this._right ) ) 
			{
				this._width = NaN ;
				this._relativeWidth = NaN ;
				this._spareWidth = NaN ;
				this._autoWidth = false ;
			}
			this.update() ;
		}
		
		/**
		 * Anchor padding from the right of the container.
		 */
		public function get right () : Number
		{
			return this._right ;
		}
		
		/**
		 * @private
		 */
		public function set right (value : Number) : void
		{
			this._right = Math.max ( 0, value ) ;
			if ( ! isNaN ( this._left ) && ! isNaN ( this._right ) ) 
			{
				this._width = NaN ;
				this._relativeWidth = NaN ;
				this._spareWidth = NaN ;
				this._autoWidth = false ;
			}
			this.update() ;
		}
		
		/**
		 * Anchor padding from the top of the container.
		 */
		public function get top () : Number
		{
			return this._top ;
		}
		
		/**
		 * @private
		 */
		public function set top (value : Number) : void
		{
			this._top = Math.max ( 0, value ) ;
			if ( ! isNaN ( this._top ) && ! isNaN ( this._bottom ) ) 
			{
				this._height = NaN ;
				this._relativeHeight = NaN ;
				this._spareHeight = NaN ;
				this._autoHeight = false ;
			}
			this.update() ;
		}
		
		/**
		 * Anchor padding from the bottom of the container.
		 */
		public function get bottom () : Number
		{
			return this._bottom ;
		}
		
		/**
		 * @private
		 */
		public function set bottom (value : Number) : void
		{
			this._bottom = Math.max ( 0, value ) ;
			if ( ! isNaN ( this._top ) && ! isNaN ( this._bottom ) ) 
			{
				this._height = NaN ;
				this._relativeHeight = NaN ;
				this._spareHeight = NaN ;
				this._autoHeight = false ;
			}
			
			this.update() ;
		}
		
		//----------------------------------------------------------------------

		/**
		 * Anchor padding from the horizontal centre of the container.
		 */
		public function get horizontalCentre () : Number
		{
			return this._horizontalCentre ;
		}
		
		/**
		 * @private
		 */
		public function set horizontalCentre (value : Number) : void
		{
			this._horizontalCentre = value ;
			this._left = NaN ;
			this._right = NaN ;
			this.update() ;
		}

		/**
		 * Anchor padding from the vertical centre of the container.
		 */
		public function get verticalCentre () : Number
		{
			return this._verticalCentre ;
		}
		
		/**
		 * @private
		 */
		public function set verticalCentre (value : Number) : void
		{
			this._verticalCentre = value ;
			this._top = NaN ;
			this._bottom = NaN ;
			this.update() ;
		}
		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function Component ()
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
		override public function invalidate () : void
		{
			if ( this.created ) 
			{
				this.invalidated = true ;
				if ( this.container ) // TODO in future also consider if it is at all possible that the container or siblings will be affected.
				{
					this.stage.removeEventListener( Event.RENDER, this.onRender ) ;
					this.container.invalidatedChild() ;
				}
				else 
				{
					this.stage.addEventListener( Event.RENDER, this.onRender ) ;
					this.stage.invalidate() ;	
				}
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function render () : void
		{
			if ( this.created && this.invalidated )
			{
				super.render() ;
				this.invalidated = false ;
//				trace ( "render", this.id ? this.id : "root", this.x, this.y, this.explicitWidth, this.explicitHeight ) ; // TODO remove this, it's just to check things aren't rendering more than once.
			}
		}
		
		//----------------------------------------------------------------------
		
		/**
		 * Called by the container after the sizing and positioning in the 
		 * container hierarchy has completed just before all invalidated 
		 * components render themselves. This provides an opportunity for 
		 * components to force a re-evaluation of size and position by returning
		 * false. Default is true. 
		 */
		public function beforeRender () : Boolean
		{
			return true ;
		}
	}
}