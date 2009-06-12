package com.wemakedigital.utils 
{	import flash.geom.Point;		
	/**
	 * This is a utility class for geometric calculations.
	 */	public class GeometryUtil 
	{
		/**
		 * This method gets the centroid of any shape with three or more sides.
		 * 
		 * @param	vertices	An array of vertices.
		 * @param	pNameX		An optional parameter which allows to set the name identifying the
		 * 						X-axis value of the vertices.
		 * @param	pNameY		An optional parameter which allows to set the name identifying the
		 * 						Y-axis value of the vertices.
		 * @return	A Point object representing the centroid.
		 */
		public static function getCentroid ( vertices : Array , pNameX : String = "x" , pNameY : String = "y" ) : Point
		{
			var centroid : Point = new Point( ) ;
			
			for each ( var vertex : Object in vertices )
			{
				centroid.x += vertex[ pNameX ] ;
				centroid.y += vertex[ pNameY ] ;
			}
			
			centroid.x /= vertices.length ;
			centroid.y /= vertices.length ;
			
			return centroid ;
		}

		/**
		 * This method the hypoteneuse of a triangle.
		 * 
		 * @param	a	The length of the adjacent side.
		 * @param	b	The length of the opposite side.
		 * 
		 * @return	The length of the hypoteneuse.
		 */		public static function getHypoteneuse ( a : Number , b : Number ) : Number
		{
			return Math.sqrt( Math.pow( a , 2 ) + Math.pow( b , 2 ) ) ;
		}

		/**
		 * This method gets the maximum distance within a rectangle from its centre.
		 * 
		 * @param	width	The width of the rectangle.
		 * @param	height	The height of the rectangle.
		 * 
		 * @return	The rectangular radius.
		 */		public static function rectangularRadius ( width : Number , height : Number ) : Number
		{
			return Math.sqrt( Math.pow( width , 2 ) + Math.pow( height , 2 ) ) / 2 ;
		}	}}