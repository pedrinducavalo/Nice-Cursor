package cursor.config;

import flixel.util.FlxColor;
import flixel.system.FlxAssets.FlxGraphicAsset;

/**
 * Defines the graphic and display settings used to render a cursor.
 */
typedef CursorConfig =
{
	/**
	 * Path to the cursor image asset. An invalid path or missing asset can cause
	 * cursor loading to fail.
	 */
	var graphic:String;
	
	/**
	 * Tint applied to the image; defaults to white if omitted or `null`.
	 */
	@:optional var color:Null<FlxColor>;
	
	/**
	 * Image scale; defaults to `1` if omitted or `null`. Zero or negative values
	 * can hide the cursor or render it unexpectedly.
	 */
	@:optional var scale:Null<Float>;
	
	/**
	 * Horizontal hotspot offset in pixels; defaults to `0`.
	 */
	@:optional var xOffset:Null<Int>;
	
	/**
	 * Vertical hotspot offset in pixels; defaults to `0`.
	 */
	@:optional var yOffset:Null<Int>;
}
