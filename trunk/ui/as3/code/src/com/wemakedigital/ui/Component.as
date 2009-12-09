package com.wemakedigital.ui 
{
	import com.wemakedigital.ui.core.CoreComponent;

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
	public class Component extends CoreComponent 
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
			value = Math.max ( this.minWidth, isNaN ( this.maxWidth ) ? value : Math.min ( this.maxWidth, value ) ) ;
			if ( value != this.width )
			{
				this._width = value ;
				this._relativeWidth = NaN ;
				this.update() ;
			}
		}
		
		/**
		 * @private
		 */
		override public function set height (value : Number) : void
		{
			value = Math.max ( this.minHeight, isNaN ( this.maxHeight ) ? value : Math.min ( this.maxHeight, value ) ) ;
			if ( value != this.height )
			{
				this._height = value ;
				this._relativeHeight = NaN ;
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
			if ( this.created && this.stage ) 
			{
				if ( this.container ) 
				{
					this.removeRenderEventListeners() ;
					this.container.invalidatedChild() ;
				}
				else
				{
					this.stage.addEventListener( Event.RENDER, this.onRender ) ;
					this.stage.invalidate() ;				
				}
			}
		}
		
		//----------------------------------------------------------------------	
		
		/**
		 * @inheritDoc
		 */
		override protected function update () : void
		{
			if ( this.container ) this.invalidate() ;
			else super.update() ;
		}
		
		//----------------------------------------------------------------------	
		
		/**
		 * Removes any <code>flash.events.Event.RENDER</code> event listeners 
		 * added due to invalidation. 
		 */
		internal function removeRenderEventListeners() : void
		{
			this.stage.removeEventListener( Event.RENDER, this.onRender ) ;
		}
	}
}