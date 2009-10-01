package com.wemakedigital.utils 
{
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;	

	{
		public static function drawColourFillRect ( graphics : Graphics , rect : Rectangle , colour : Number , alpha : Number = 1 , clear : Boolean = false ) : void
		{
			if ( clear ) graphics.clear( ) ;
			graphics.beginFill( colour , alpha ) ;
			graphics.drawRect( rect.x , rect.y , rect.width , rect.height ) ;
		}

		{
			if ( clear ) graphics.clear( ) ;
			graphics.beginBitmapFill( bitmapData , matrix , repeat , smooth ) ;
			graphics.drawRect( rect.x , rect.y , rect.width , rect.height ) ;
		}

		{
			ShapeUtil.drawColourFillRect( shape.graphics , new Rectangle( 0 , 0 , shape.width , shape.height ) , colour ) ;
		}

		{
			ShapeUtil.drawBitmapFillRect( shape.graphics , new Rectangle( 0 , 0 , shape.width , shape.height ) , bitmapData , matrix , repeat , smooth , true ) ;
		}