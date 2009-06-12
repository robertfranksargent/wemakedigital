package com.wemakedigital.parallax.view {	import flash.events.Event;		import flash.display.Sprite;			public class ParallaxViewport extends Sprite 	{		private var explicitWidth : Number ;		private var explicitHeight : Number ;				public function ParallaxViewport ( width : Number = 0 , height : Number = 0 )		{			this.explicitWidth = width ;			this.explicitHeight = height ;			this.mouseEnabled = false ;			this.mouseChildren = true ;			this.onRemovedFromStage( null ) ;		}		override public function get width ( ) : Number		{			return this.explicitWidth ;		}		override public function set width ( value : Number ) : void		{			this.explicitWidth = value ;		}		override public function get height ( ) : Number		{			return this.explicitHeight ;		}		override public function set height ( value : Number ) : void		{			this.explicitHeight = value ;		}		private function onAddedToStage ( e : Event ) : void		{			this.addEventListener( Event.REMOVED_FROM_STAGE , this.onRemovedFromStage ) ;			this.removeEventListener( Event.ADDED_TO_STAGE , this.onAddedToStage ) ;			this.stage.addEventListener( Event.RESIZE , this.onResize ) ;			this.onResize( null ) ;		}		private function onRemovedFromStage ( e : Event ) : void		{			this.addEventListener( Event.ADDED_TO_STAGE , this.onAddedToStage ) ;			this.removeEventListener( Event.REMOVED_FROM_STAGE , this.onRemovedFromStage ) ;			if ( e ) this.stage.removeEventListener( Event.RESIZE , this.onResize ) ;		}				private function onResize ( e : Event ) : void		{			this.x = ( this.explicitWidth || this.stage.stageWidth ) >> 1 ;			this.y = ( this.explicitHeight || this.stage.stageHeight ) >> 1 ;		}	}}