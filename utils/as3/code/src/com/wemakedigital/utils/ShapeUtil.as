package com.wemakedigital.utils 
{	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;	
	public class ShapeUtil 
	{
		public static function drawColourFillRect ( graphics : Graphics , rect : Rectangle , colour : Number , alpha : Number = 1 , clear : Boolean = false ) : void
		{
			if ( clear ) graphics.clear( ) ;
			graphics.beginFill( colour , alpha ) ;
			graphics.drawRect( rect.x , rect.y , rect.width , rect.height ) ;
		}
		public static function drawBitmapFillRect ( graphics : Graphics , rect : Rectangle , bitmapData : BitmapData , matrix : Matrix = null , repeat : Boolean = true , smooth : Boolean = false , clear : Boolean = false ) : void
		{
			if ( clear ) graphics.clear( ) ;
			graphics.beginBitmapFill( bitmapData , matrix , repeat , smooth ) ;
			graphics.drawRect( rect.x , rect.y , rect.width , rect.height ) ;
		}
		public static function colourFill ( shape : Shape , colour : Number ) : void
		{
			ShapeUtil.drawColourFillRect( shape.graphics , new Rectangle( 0 , 0 , shape.width , shape.height ) , colour ) ;
		}
		public static function bitmapFill ( shape : Shape , bitmapData : BitmapData , matrix : Matrix = null , repeat : Boolean = true , smooth : Boolean = false ) : void
		{
			ShapeUtil.drawBitmapFillRect( shape.graphics , new Rectangle( 0 , 0 , shape.width , shape.height ) , bitmapData , matrix , repeat , smooth , true ) ;
		}	}}