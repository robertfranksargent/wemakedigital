package com.wemakedigital.net.events {	import flash.events.Event;		public class LazyNetConnectionEvent extends Event 	{		public static const BW_DONE : String = "BW_DONE" ;				public function LazyNetConnectionEvent ( type : String , bubbles : Boolean = false , cancelable : Boolean = false )		{			super( type , bubbles , cancelable ) ;		}	}}