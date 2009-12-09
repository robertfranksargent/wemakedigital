package com.wemakedigital.ui.core
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
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
	public class CoreComponent extends Sprite 
	{	
		//----------------------------------------------------------------------
		//
		//  Variables
		//
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected var _created : Boolean = false ;
		
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected var _width : Number = 0 ;
		
		/**
		 * @private
		 */
		protected var _height : Number = 0 ;
		
		/**
		 * @private
		 */
		protected var _minWidth : Number = 0 ;
		
		/**
		 * @private
		 */
		protected var _minHeight : Number = 0 ;
		
		/**
		 * @private
		 */
		protected var _maxWidth : Number = NaN ;
		
		/**
		 * @private
		 */
		protected var _maxHeight : Number = NaN ;
		
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected var explicitWidth : Number ;
		
		/**
		 * @private
		 */
		protected var explicitHeight : Number ;
		
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected var _colour : Number = NaN ;
		
		/**
		 * @private
		 */
		protected var _colourAlpha : Number = 1 ;
		
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected var _interactive : Boolean ;
		
		//----------------------------------------------------------------------
		//
		//  Properties
		//
		//----------------------------------------------------------------------
		
		/**
		 * The <code>width</code> property inherited from 
		 * <code>flash.display.DisplayObject</code>.
		 */
		public function get displayWidth () : Number
		{
			return super.width ;
		}
		
		/**
		 * The <code>height</code> property inherited from 
		 * <code>flash.display.DisplayObject</code>.
		 */
		public function get displayHeight () : Number
		{
			return super.height ;
		}
		
		//----------------------------------------------------------------------
		
		/**
		 * The width of the component.
		 */
		override public function get width () : Number
		{
			return this._width ;
		}
		
		/**
		 * @private
		 */
		override public function set width (value : Number) : void
		{
			value = Math.max ( this.minWidth, isNaN ( this.maxWidth ) ? value : Math.min ( this.maxWidth, value ) ) ;
			if ( value != this.width )
			{
				this._width = value ;
				this.update() ;
			}
		}
		
		/**
		 * The height of the component.
		 */
		override public function get height () : Number
		{
			return this._height ;
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
				this.update() ;
			}
		}
		
		/**
		 * The minumum width of the component.
		 */
		public function get minWidth () : Number
		{
			return this._minWidth ;
		}
		
		/**
		 * @private
		 */
		public function set minWidth (value : Number) : void
		{
			value = Math.max ( 0, value ) ;
			if ( value != this.minWidth )
			{
				this._minWidth = value ;
				this.width = this.width ;
			}
		}
		
		/**
		 * The minumum height of the component.
		 */
		public function get minHeight () : Number
		{
			return this._minHeight ;
		}
		
		/**
		 * @private
		 */
		public function set minHeight (value : Number) : void
		{
			value = Math.max ( 0, value ) ;
			if ( value != this.minHeight )
			{
				this._minHeight = value ;
				this.height = this.height ;
			}
		}
		
		/**
		 * The maximum width of the component.
		 */
		public function get maxWidth () : Number
		{
			return this._maxWidth ;
		}
		
		/**
		 * @private
		 */
		public function set maxWidth (value : Number) : void
		{
			value = Math.max ( 0, value ) ;
			if ( value != this.maxWidth )
			{
				this._maxWidth = value ;
				this.width = this.width ;
			}
		}
		
		/**
		 * The maximum height of the component
		 */
		public function get maxHeight () : Number
		{
			return this._maxHeight ;
		}
		
		/**
		 * @private
		 */
		public function set maxHeight (value : Number) : void
		{
			value = Math.max ( 0, value ) ;
			if ( value != this.maxHeight )
			{
				this._maxHeight = value ;
				this.height = this.height ;
			}
		}
		
		//----------------------------------------------------------------------
		
		/**
		 * The created status of the component, default is <code>false</code>. 
		 * <code>true</code> after <code>create</code> method is called. Returns 
		 * to <code>false</code> when <code>destroy</code> method is called. 
		 */
		public function get created ( ) : Boolean
		{
			return this._created ;
		}

		/**
		 * @private
		 */
		public function set created ( value : Boolean ) : void
		{
			if ( this.created != value ) this._created = value ;
		}
		
		//----------------------------------------------------------------------
		
		/**
		 * Optional background colour. Hex colour values are valid e.g 
		 * <code>0x000000</code> (black). The default is <code>NaN</code> which 
		 * will not render a background.
		 */
		public function get colour () : Number
		{
			return this._colour ;
		}
		
		/**
		 * @private
		 */
		public function set colour (value : Number) : void
		{
			this._colour = value ;
			this.update() ;
		}
		
		/**
		 * The alpha transparency value of the background colour. Valid values 
		 * are 0 (transparent) to 1 (opaque). The default value is 1.
		 */
		public function get colourAlpha () : Number
		{
			return this._colourAlpha ;
		}
		
		/**
		 * @private
		 */
		public function set colourAlpha (value : Number) : void
		{
			this._colourAlpha = value ;
			this.update() ;
		}
		
		//----------------------------------------------------------------------
		
		/**
		 * Enables and disables mouse and keyboard interactivity with the 
		 * component. A shortcut that can be used instead of 
		 * <code>mouseEnabled</code>, <code>mouseChildren</code>, 
		 * <code>tabEnabled</code> and <code>tabChildren</code>.
		 */
		public function get interactive () : Boolean
		{
			return this._interactive ;
		}
		
		/**
		 * @private
		 */
		public function set interactive ( value : Boolean ) : void
		{
			if ( this._interactive != value )
			{
				this._interactive = value ;
				this.mouseEnabled = value ;
				this.mouseChildren = value ;
				this.tabEnabled = value && this.tabIndex != -1 ;
				this.tabChildren = value ;
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
		public function CoreComponent ()
		{
			this.addEventListener( Event.ADDED_TO_STAGE , this.onAddedToStage ) ;
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
			return child && ! this.contains( child ) ? super.addChild( child ) : child ;
		}

		/**
		 * @inheritDoc
		 */
		override public function removeChild ( child : DisplayObject ) : DisplayObject
		{
			return child && this.contains( child ) ? super.removeChild( child ) : child ;
		}
		
		/**
		 * Remove all children of this component from the display list.
		 */
		public function removeChildren ( ) : void
		{
			while( this.numChildren > 0 ) this.removeChildAt( this.numChildren - 1 ) ;
		}
		
		//----------------------------------------------------------------------
		
		/**
		 * Invalidates the component, forcing it to render on the next 
		 * <code>flash.events.Event.RENDER</code> event.
		 */
		public function invalidate () : void
		{
			if ( this.created && this.stage ) 
			{
				this.stage.addEventListener( Event.RENDER, this.onRender ) ;
				this.stage.invalidate() ;				
			}
		}
		
		/**
		 * Renders and re-renders the component display.
		 */
		public function render () : void
		{
			if ( this.created ) renderColour() ;
		}
		
		//----------------------------------------------------------------------
		
		/**
		 * Creates the component's children and adds event listeners when added 
		 * to the display list.
		 */
		protected function create () : void
		{
			this.created = true ; 
		}
		
		/**
		 * Removes the component's children and removes event listeners when 
		 * removed from the display list.
		 */
		protected function destroy () : void
		{
			this.removeChildren() ;
			this.created = false ; 
		}
		
		//----------------------------------------------------------------------
		
		/**
		 * Updates the component when a property changes.
		 */
		protected function update () : void
		{
			if ( this.created && !isNaN( this.width ) && !isNaN( this.height ) && ( this.explicitWidth != this.width || this.explicitHeight != this.height ) )
			{
				this.explicitWidth = this.width ;
				this.explicitHeight = this.height ;
				this.invalidate() ;		
			}
		}

		//----------------------------------------------------------------------
		
		/**
		 * Renders the coloured background.
		 */
		protected function renderColour() : void
		{
			if ( ! isNaN ( this.colour ) ) 
			{
				this.graphics.clear() ;
				this.graphics.beginFill( this.colour, this.colourAlpha ) ;
				this.graphics.drawRect( 0, 0, this.explicitWidth, this.explicitHeight ) ;
			}
		}
		
		//----------------------------------------------------------------------
		//
		//  Event Handlers
		//
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected function onAddedToStage ( e : Event ) : void
		{
			this.removeEventListener( Event.ADDED_TO_STAGE , this.onAddedToStage ) ;	
			this.addEventListener( Event.REMOVED_FROM_STAGE , this.onRemovedFromStage ) ;
			
			if ( ! this.created ) this.create() ;
			this.update() ;
			this.invalidate() ;
		}

		/**
		 * @private
		 */
		protected function onRemovedFromStage ( e : Event ) : void
		{
			this.removeEventListener( Event.REMOVED_FROM_STAGE , this.onRemovedFromStage ) ;		
			this.addEventListener( Event.ADDED_TO_STAGE , this.onAddedToStage ) ;
			
			if ( this.created ) this.destroy() ;
		}
		
		//----------------------------------------------------------------------

		/**
		 * @private
		 */
		protected function onRender ( e : Event ) : void
		{		
			this.stage.removeEventListener( Event.RENDER, this.onRender ) ;
			if ( this.created ) this.render() ;
		}
	}
}
