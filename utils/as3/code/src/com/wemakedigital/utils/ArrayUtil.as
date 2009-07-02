package com.wemakedigital.utils {	public class ArrayUtil 	{		public static function clone ( array : Array ) : Array		{			return array.concat( ) ;		}		public static function contains ( items : Array , array : Array , strict : Boolean = false ) : Boolean		{			var score : uint = 0 ;			for ( var i : uint = 0 , n : uint = items.length ; i < n ; i ++ )			{				if ( array.indexOf( items[ i ] ) >= 0 ) score ++ ;			}			return score == ( strict ? array.length : items.length ) ;		}		public static function containsAny ( items : Array , array : Array ) : Boolean		{			var score : uint = 0 ;			for ( var i : uint = 0 , n : uint = items.length ; i < n ; i ++ )			{				if ( array.indexOf( items[ i ] ) >= 0 ) score ++ ;			}			return score > 0 ;		}		public static function difference ( array : Array , compare : Array ) : Array		{			var diff : Array = new Array( ) ;			var object : Object ;			for each ( object in array ) if ( compare.indexOf( object ) == - 1 ) diff.push( object ) ;			for each ( object in compare ) if ( array.indexOf( object ) == - 1 ) diff.push( object ) ;			return diff ;		}		public static function filterNullValues ( array : Array ) : Array		{			return array.filter( ArrayUtil.isNull ) ;		}		public static function getIndex ( object : * , array : Array , strict : Boolean = true ) : int		{			if ( strict )			{				return array.indexOf( object ) ;			}			else			{				for ( var i : uint = 0 , n : uint = array.length ; i < n ; i++ )				{					if ( object == array[ i ] ) return i ;				}			}						return -1 ;		}		public static function getRandomItem ( array : Array ) : *		{			return array[ Math.round( ( array.length - 1 ) * Math.random( ) ) ] ;		}		public static function getRandomItems ( array : Array , number : uint ) : Array		{			var items : Array = new Array( ) ;			items = ArrayUtil.randomise( array ).slice( 0 , number ) ;			return items ;		}		public static function isNull ( index : uint , array : Array ) : Boolean		{			return array[ index ] != null ;		}		public static function itemExists ( item : * , array : Array ) : Boolean		{			return array.indexOf( item ) > -1 ;		}		public static function randomise ( array : Array ) : Array		{			return array.sort( function ( ) : uint 			{ 				return ( Math.random( ) * 2 ) * 2 - 1 ; 			} ) ;		}		public static function remove ( item : * , array : Array ) : *		{			var i : int ;			while ( ( i = array.indexOf( item ) ) >= 0 ) array.splice( i , 1 ) ;			return item ;		}		public static function split ( array : Array , every : uint = 1 ) : Array		{			var copy : Array = array.concat( ) ;			var list : Array = new Array( ) ;						every = Math.max( every , 1 ) ;						for ( var i : uint = 0 , n : uint = Math.ceil( copy.length / every ) ; i < n ; i ++ )			{				var a : uint = i * every ;				var b : uint = Math.min( a + every , copy.length ) ;				var split : Array = copy.slice( a , b ) ;				list.push( split ) ;			}						return list ;		}		public static function swapExistingItems ( array : Array , item1 : * , item2 : * ) : void		{			var index1 : int = array.indexOf( item1 ) ;			var index2 : int = array.indexOf( item2 ) ;			if ( index1 && index2 )			{				array[ index1 ] = item2 ;				array[ index2 ] = item1 ;			}		}		public static function swapExistingItemRandom ( array : Array , item : * ) : int		{			var index : int = array.indexOf( item ) ;			if ( index )			{				var swapIndex : uint = Math.round( Math.random( ) ) * ( array.length - 1 ) ;				var swapItem : * = array[ swapIndex ] ;				array[ swapIndex ] = item ;				array[ index ] = swapItem ;				return swapIndex ;			}			return - 1 ;		}		public static function swapItem ( array : Array , oldItem : * , newItem : * ) : int		{			var index : uint = ArrayUtil.getIndex( oldItem , array ) ;			array[ index ] = newItem ;			return index ;		}		public static function swapRandomItem ( array : Array , newItem : * ) : int		{			var index : uint = ( Math.sqrt( Math.random( ) * Math.random( ) ) * array.length ) >> 0 ;			array[ index ] = newItem ;			return index ;		}	}}