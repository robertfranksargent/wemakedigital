package com.wemakedigital.ui 
{
	import mx.utils.ObjectUtil;

	import flash.display.DisplayObject;
	import flash.display.Sprite;
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
		
		//----------------------------------------------------------------------

		/**
		 * @private
		 */
		protected var _children : Array ;
		
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
				if ( this[ property ] is Component ) Component( this[ property ] ).id = property ;
			var displayObjects : Array = value is Array ? value : [ value ] ;
			for each ( var child : DisplayObject in displayObjects )
				this.addChild( child ) ;
		}
		
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
			this.content = new Sprite() ;
			super.addChild( this.content ) ;
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
				// TODO invalidate?
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
				// TODO invalidate?
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
					// TODO invalidate?
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
				// TODO invalidate?
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
		 * @inheritDoc
		 */
		override public function render () : void
		{
			if ( this.children )
			{
				
			}
			super.render() ; 
		}
		
		//----------------------------------------------------------------------
		
		/**
		 * Container is Invalidated by one of its child components, forcing it 
		 * to render on the next <code>flash.events.Event.RENDER</code> event.
		 */
		internal function invalidatedChild () : void
		{
			if ( this.created && this.stage ) 
			{
				if ( this.container && ( isNaN( this.width ) || isNaN( this.height ) ) ) 
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
		override internal function removeRenderEventListeners() : void
		{
			for each ( var component : Component in this.components )
				component.removeRenderEventListeners() ;
			super.removeRenderEventListeners() ;
		}
	}
}
