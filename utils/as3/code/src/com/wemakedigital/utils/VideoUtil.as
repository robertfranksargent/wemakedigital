package com.wemakedigital.utils {	public class VideoUtil 	{		public static function getBufferTime ( duration : Number , bitrate : Number , bandwidth : Number , padding : Number = 3 ) : Number		{			var bufferTime : Number ;			if ( bitrate > bandwidth ) bufferTime = Math.ceil( duration - duration / ( bitrate / bandwidth ) ) ;			else bufferTime = 0 ;			bufferTime += padding ;			return Math.min( bufferTime , duration ) ;		}	}}