package com.wemakedigital.ui 
{
	import mx.utils.ObjectUtil;

	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;

	[ DefaultProperty ( "children" ) ]
	
	/**
	 * TODO
	 */
	public class Container extends Component 
	{
		//----------------------------------------------------------------------
		//
		//  Variables
		//
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected var content : Sprite ;
		
		/**
		 * @private
		 */
		protected var contentMask : Shape ;
		
		/**
		 * @private
		 */
		protected var _scrollHorizontal : Number = 0 ;
		
		/**
		 * @private
		 */
		protected var _scrollVertical : Number = 0 ;
		
		//----------------------------------------------------------------------

		/**
		 * @private
		 */
		protected var _children : Array = [] ;
		
		/**
		 * @private
		 */
		protected var _maskChildren : Boolean = true ;
		
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected var _measuredWidth : Number ;

		/**
		 * @private
		 */
		protected var _measuredHeight : Number ;
		
		//----------------------------------------------------------------------
		//
		//  Properties
		//
		//----------------------------------------------------------------------

		/**
		 * The DisplayObjects children of this container.
		 */
		public function get children () : Array
		{
			return this._children;
		}
		
		/**
		 * @private
		 */
		public function set children ( value : * ) : void
		{
			for each ( var property : String in ObjectUtil.getClassInfo( this )["properties"] ) 
			{
				if ( this[ property ] is Component ) 
				{
					if ( property != "container" ) Component( this[ property ] ).id = property ;
					else throw new Error( "The component id 'container' cannot be used." ) ;
				}
			}
			var displayObjects : Array = value is Array ? value : [ value ] ;
			for each ( var child : DisplayObject in displayObjects )
				this.addChild( child ) ;
		}
		
		/**
		 * Mask children to the container size (default is false).
		 */
		public function get maskChildren () : Boolean
		{
			return this._maskChildren;
		}
		
		/**
		 * @private
		 */
		public function set maskChildren ( value : Boolean ) : void
		{
			if ( this._maskChildren != value ) 
			{
				this._maskChildren = value ;
				this.update() ;
			}
		}
		
		//----------------------------------------------------------------------
		
		/**
		 * The horizontal scroll ratio between 0 (scrolled to left) and 1 (scrolled to right).
		 */
		public function get scrollHorizontal () : Number
		{
			return this._scrollHorizontal;
		}
		
		/**
		 * @private
		 */
		public function set scrollHorizontal ( value : Number ) : void
		{
			this._scrollHorizontal = Math.max ( 0 , Math.min ( 1, value ) ) ;
			this.scroll() ;
		}
		
		/**
		 * The vertical scroll ratio between 0 (scrolled to top) and 1 (scrolled to bottom).
		 */
		public function get scrollVertical () : Number
		{
			return this._scrollVertical;
		}
		
		/**
		 * @private
		 */
		public function set scrollVertical ( value : Number ) : void
		{
			this._scrollVertical = Math.max ( 0 , Math.min ( 1, value ) ) ;
			this.scroll() ;
		}
		
		//----------------------------------------------------------------------
		
		/**
		 * The Component children of this container.
		 */
		public function get components () : Array
		{
			var _components : Array = [] ;
			for each ( var child : DisplayObject in this.children )
				if ( child is Component ) _components.push( child ) ;
			return _components ;
		}
		
		/**
		 * The Container children of this container.
		 */
		public function get containers () : Array
		{
			var _containers : Array = [] ;
			for each ( var child : DisplayObject in this.children )
				if ( child is Container ) _containers.push( child ) ;
			return _containers ;
		}
		
		//----------------------------------------------------------------------

		/**
		 * The width of all the children in position of this component.
		 */
		public function get measuredWidth () : Number
		{
			this._measuredWidth = 0 ;
			for each ( var child : Component in this.components )
			{
				if ( ( child.x + child.explicitWidth ) > this._measuredWidth ) this._measuredWidth = ( child.x + child.explicitWidth ) ;  
			}
			return this._measuredWidth ;
		}

		/**
		 * The overall height of all the children in position of this component.
		 */
		public function get measuredHeight () : Number
		{
			this._measuredHeight = 0 ;
			for each ( var child : Component in this.components )
			{
				if ( ( child.y + child.explicitHeight ) > this._measuredHeight ) this._measuredHeight = (child.y + child.explicitHeight ) ;  
			}
			return this._measuredHeight ;
		}
		
		/**
		 * The total width of all the children of this component regardless of their position, overlapping etc.
		 */
		public function get totalWidth () : Number
		{
			var totalWidth : Number = 0 ;
			for each ( var child : Component in this.components )
				if ( isNaN( child.spareWidth ) ) totalWidth += child.explicitWidth ; 
			return totalWidth ;
		}

		/**
		 * The total height of all the children of this component regardless of their position, overlapping etc..
		 */
		public function get totalHeight () : Number
		{
			var totalHeight : Number = 0 ; 
			for each ( var child : Component in this.components )
				if ( isNaN( child.spareHeight ) ) totalHeight += child.explicitHeight ; 
			return totalHeight ;
		}

		//----------------------------------------------------------------------
		//
		//  Constructor
		//
		//----------------------------------------------------------------------
		
		/**
		 * Constructor.
		 */
		public function Container ()
		{
			super() ;
			
			this._autoWidth = true ;
			this._autoHeight = true ;
			this._width = NaN ;
			this._height = NaN ;
			
			this.content = new Sprite() ;
			this.contentMask = new Shape() ;
			super.addChild( this.content ) ;
			super.addChild( this.contentMask ) ;
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
			if ( child && !this.content.contains( child ) )
			{
				if ( child is Component ) 
				{
					var component : Component = child as Component ;
					if ( component.container ) component.container.removeChild( component ) ;
					component.container = this;
				}
				if ( !this.children ) this._children = [] ;
				this._children.push( child ) ;
				this.content.addChild( child ) ;
				this.update() ;
			}
			return child ;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function addChildAt (child : DisplayObject, index : int) : DisplayObject
		{
			this.addChild( child ) ;
			this.setChildIndex ( child, index ) ;
			return child ; 
		}
		
		/**
		 * @inheritDoc
		 */
		override public function contains (child : DisplayObject) : Boolean
		{
			return child && this.children && this.children.indexOf( child ) > -1 ;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function getChildAt (index : int) : DisplayObject
		{
			return this.children[ index ] as DisplayObject ;
		}

		/**
		 * @inheritDoc
		 */
		override public function getChildByName ( name : String ) : DisplayObject
		{
			return this.content.getChildByName( name ) ;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function getChildIndex (child : DisplayObject) : int
		{
			return this.children.indexOf( child ) ;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function get numChildren () : int
		{
			return this.children.length ;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeChild (child : DisplayObject) : DisplayObject
		{
			if ( child && this.contains( child ) )
			{
				if ( child is Component ) ( child as Component ).container = null ;
				this._children.splice( this.children.indexOf( child ), 1 ) ;
				this.content.removeChild( child ) ;
				this.update() ;
			}
			return child ;
		}
		
		/**
		 * @inheritDoc
		 */
		override public function removeChildAt (index : int) : DisplayObject
		{
			return this.removeChild( this.getChildAt( index ) ) ;
		}
		
		/**
		 * @inheritDoc TODO
		 */
		override public function setChildIndex (child : DisplayObject, index : int) : void
		{
			if ( this.contains( child ) )
			{
				index = Math.min( index, this.children.length - 1 ) ;
				this.swapChildren( child, this.getChildAt( index ) ) ;
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function swapChildren (child1 : DisplayObject, child2 : DisplayObject) : void
		{
			if ( this.contains( child2 ) && this.contains( child2 ) )
			{
				var index1 : int = this.getChildIndex( child1 ) ;
				var index2 : int = this.getChildIndex( child2 ) ;
				if ( index1 && index2 )
				{
					this.children[ index1 ] = child2 ;
					this.children[ index2 ] = child1 ;
					this.content.swapChildren ( child1, child2 ) ;
					this.update() ;
				}
			}
		}
		
		/**
		 * @inheritDoc
		 */
		override public function swapChildrenAt (index1 : int, index2 : int) : void
		{
			var child1 : DisplayObject = this.getChildAt( index1 ) ;
			var child2 : DisplayObject = this.getChildAt( index2 ) ;
			if ( child1 && child2 )
			{
				this.children[ index1 ] = child2 ;
				this.children[ index2 ] = child1 ;
				this.content.swapChildren ( child1, child2 ) ;
				this.update() ;
			}
		}
		
		//----------------------------------------------------------------------
		
		/**
		 * Brings a child to the highest depth.
		 */
		public function bringToFront ( child : DisplayObject ) : void
		{
			this.setChildIndex( child, this.children.length -1 ) ;
		}
		
		/**
		 * Brings a child to the next highest depth.
		 */
		public function bringForward ( child : DisplayObject ) : void
		{
			this.setChildIndex( child, this.getChildIndex( child ) + 1 ) ;
		}
		
		/**
		 * Sends a child to the lowest depth.
		 */
		public function sendToBack ( child : DisplayObject ) : void
		{
			this.setChildIndex( child, 0 ) ;
		}
		
		/**
		 * Sends a child to the next lowest depth.
		 */
		public function sendBackward ( child : DisplayObject ) : void
		{
			this.setChildIndex( child, this.getChildIndex( child ) - 1 ) ;
		}
		
		//----------------------------------------------------------------------
		
		/**
		 * Called by one of the container's child components, forcing it to 
		 * render on the next <code>flash.events.Event.RENDER</code> event.
		 */
		internal function invalidatedChild () : void
		{
			if ( this.created ) 
			{
				if ( this.container ) this.container.invalidatedChild() ; 
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
			if ( this.created )
			{
				this.contentMask.graphics.clear() ;
				if ( this.maskChildren )
				{
					this.contentMask.graphics.beginFill( 0x000000, 0 ) ;
					this.contentMask.graphics.drawRect(0, 0, this.explicitWidth, this.explicitHeight ) ;
				}
			}
			this.scroll() ;
			super.render() ;
			for each ( var childComponent : Component in this.components )
				childComponent.render() ;
		}
		
		/**
		 * @inheritDoc
		 */
		override protected function update () : void
		{
			if ( this.created )
			{
				this.content.mask = this.maskChildren ? this.contentMask : null ;
			}
			super.update() ;
		}
		
		/**
		 * @private
		 */
		protected function scroll () : void
		{
			this.content.x = ( this.measuredWidth <= this.explicitWidth ? 0 : this.scrollHorizontal ) * ( this.explicitWidth - this.measuredWidth ) ;
			this.content.y = ( this.measuredHeight <= this.explicitHeight ? 0 : this.scrollVertical ) * ( this.explicitHeight - this.measuredHeight ) ;
		}
		
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		internal function updateSizeOfContainers () : void
		{
			if ( this.created )
			{
				for each ( var childContainer : Container in this.containers )
					childContainer.updateSizeOfContainers() ;
				
				if ( this.autoWidth ) this.explicitWidth = Math.min ( Math.max ( this.measuredWidth, this.minWidth ), isNaN ( this.maxWidth ) ? Number.MAX_VALUE : this.maxWidth ) ;
				if ( this.autoHeight ) this.explicitHeight = Math.min ( Math.max ( this.measuredHeight, this.minHeight ), isNaN ( this.maxHeight ) ? Number.MAX_VALUE : this.maxHeight ) ;
			}
		}
		
		/**
		 * @private
		 */
		internal function updateSizeOfChildren () : void
		{
			if ( this.created )
			{
				for each ( var childComponent : Component in this.components )
				{
					if ( !isNaN( childComponent.relativeWidth ) ) childComponent.explicitWidth = Math.min ( Math.max ( this.explicitWidth * childComponent.relativeWidth >> 0, childComponent.minWidth ), isNaN ( childComponent.maxWidth ) ? Number.MAX_VALUE : childComponent.maxWidth ) ; 
					if ( !isNaN( childComponent.relativeHeight ) ) childComponent.explicitHeight = Math.min ( Math.max ( this.explicitHeight * childComponent.relativeHeight >> 0, childComponent.minHeight ), isNaN ( childComponent.maxHeight ) ? Number.MAX_VALUE : childComponent.maxHeight ) ;
					if ( !isNaN( childComponent.left ) && !isNaN( childComponent.right ) ) childComponent.explicitWidth = this.explicitWidth - childComponent.left - childComponent.right ;
					if ( !isNaN( childComponent.top ) && !isNaN( childComponent.bottom ) ) childComponent.explicitHeight = this.explicitHeight - childComponent.top - childComponent.bottom ;
				}
				
				for each ( var childContainer : Container in this.containers )
					childContainer.updateSizeOfChildren() ;			
			}
		}
		
		/**
		 * @private
		 */
		internal function updateSizeOfSiblings () : void
		{
			if ( this.created )
			{
				for each ( var childComponent : Component in this.components )
				{
					if ( !isNaN( childComponent.spareWidth ) ) childComponent.explicitWidth = Math.min ( Math.max ( ( this.explicitWidth - this.totalWidth ) * childComponent.spareWidth >> 0, childComponent.minWidth ), isNaN ( childComponent.maxWidth ) ? Number.MAX_VALUE : childComponent.maxWidth ) ; 
					if ( !isNaN( childComponent.spareHeight ) ) childComponent.explicitHeight = Math.min ( Math.max ( ( this.explicitHeight - this.totalHeight ) * childComponent.spareHeight >> 0, childComponent.minHeight ), isNaN ( childComponent.maxHeight ) ? Number.MAX_VALUE : childComponent.maxHeight ) ; 
				}
				
				for each ( var childContainer : Container in this.containers )
					childContainer.updateSizeOfSiblings() ;
			}
		}
		
		/**
		 * @private
		 */
		internal function updatePositionOfChildren() : void
		{
			if ( this.created )
			{
				for each ( var childComponent : Component in this.components )
				{
					 var x : int = this.getChildX( childComponent ) >> 0 ;
					 var y : int = this.getChildY( childComponent ) >> 0 ;
					 if ( childComponent.x != x ) childComponent.x = x ;
					 if ( childComponent.y != y ) childComponent.y = y ;
				}
				
				for each ( var childContainer : Container in this.containers )
					childContainer.updatePositionOfChildren() ;
			}
		}
		
		//----------------------------------------------------------------------
		
		/**
		 * @private
		 */
		protected function getChildX ( child : Component ) : Number
		{
			if ( ! isNaN ( child.left ) ) return child.left ;
			else if ( ! isNaN ( child.right ) ) return this.explicitWidth - child.explicitWidth - child.right ;
			else if ( ! isNaN ( child.horizontalCentre ) ) return ( ( this.explicitWidth - child.explicitWidth ) / 2 ) + child.horizontalCentre ;
			return child.x ;
		}
		
		/**
		 * @private
		 */
		protected function getChildY ( child : Component ) : Number
		{
			if ( ! isNaN ( child.top ) ) return child.top ;
			else if ( ! isNaN ( child.bottom ) ) return this.explicitHeight - child.explicitHeight - child.bottom ;
			else if ( ! isNaN ( child.verticalCentre ) ) return ( ( this.explicitHeight - child.explicitHeight ) / 2 ) + child.verticalCentre ;
			return child.y ;
		}
		
		//----------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override public function beforeRender () : Boolean
		{
			var success : Boolean = true ;
			for each ( var childComponent : Component in this.components )
				if ( ! childComponent.beforeRender() ) success = false ;
			return success ;
		}
		
		//----------------------------------------------------------------------
		//
		//  Event Handlers
		//
		//----------------------------------------------------------------------
		
		/**
		 * @inheritDoc
		 */
		override protected function onRender ( e : Event ) : void
		{		
			if ( e ) ( e.target as Stage ).removeEventListener( Event.RENDER, this.onRender ) ;
			if ( this.created ) 
			{
				this.updateSizeOfContainers() ;
				this.updateSizeOfChildren() ;
				this.updateSizeOfSiblings() ;
				this.updateSizeOfChildren() ;
				this.updatePositionOfChildren() ;
				if ( this.beforeRender() ) this.render() ;
				else this.onRender( null ) ;
			}
		}
	}
}
