package cursor;

import cursor.config.CursorConfig;

import openfl.display.BitmapData;

/**
 * Stores the cached bitmap, configuration, and cache callback for a cursor style.
 */
typedef CursorData =
{
	/**
	 * The cached bitmap for this cursor, or `null` if it has not been loaded.
	 */
	var cache:Null<BitmapData>;
	
	/**
	 * The graphic path and display settings for this cursor style.
	 */
	var config:CursorConfig;
	
	/**
	 * Stores a newly loaded bitmap in the cache for this cursor style.
	 */
	var set:(BitmapData) -> Void;
}
