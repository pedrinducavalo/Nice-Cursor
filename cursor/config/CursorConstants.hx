package cursor.config;

import flixel.util.FlxColor;

/**
 * Provides the default cursor configurations and library asset paths.
 */
@:keep
final class CursorConstants
{
	/**
	 * Configuration for the default cursor image, tinted white.
	 */
	public static final CURSOR_DEFAULT_CONFIG:CursorConfig =
		{
			graphic: '$IMAGES_PATH/cursor/default.png',
			color: FlxColor.WHITE
		};
		
	/**
	 * Configuration for the pointer cursor image, tinted green.
	 */
	public static final CURSOR_POINTER_CONFIG:CursorConfig =
		{
			graphic: '$IMAGES_PATH/cursor/pointer.png',
			color: 0xFF429654
		};
		
	/**
	 * Configuration for the grab cursor image, tinted green.
	 */
	public static final CURSOR_GRAB_CONFIG:CursorConfig =
		{
			graphic: '$IMAGES_PATH/cursor/grabbing.png',
			color: 0xFF429654,
			yOffset: -5
		};
		
	/**
	 * Configuration for the crosshair cursor image, tinted white.
	 */
	public static final CURSOR_CROSS_CONFIG:CursorConfig =
		{
			graphic: '$IMAGES_PATH/cursor/cross.png',
			color: FlxColor.WHITE,
			xOffset: -3,
			yOffset: -3
		};
		
	/**
	 * Configuration for the text cursor image, tinted gray.
	 */
	public static final CURSOR_TEXT_CONFIG:CursorConfig =
		{
			graphic: '$IMAGES_PATH/cursor/text-field.png',
			color: FlxColor.GRAY
		};
		
	/**
	 * Configuration for the loading cursor image, tinted blue.
	 */
	public static final CURSOR_LOADING_CONFIG:CursorConfig =
		{
			graphic: '$IMAGES_PATH/cursor/loading.png',
			color: FlxColor.BLUE,
			xOffset: -3,
			yOffset: -3
		};
		
	// DO NOT CHANGE ANYTHING BELOW THIS LINE
	
	/**
	 * Name used as the root directory for this library's assets.
	 */
	public static inline var LIB_NAME:String = 'nice-cursor';
	
	/**
	 * Relative path to this library's asset directory.
	 */
	public static inline var ASSETS_PATH:String = 'assets/$LIB_NAME';
	
	/**
	 * Relative path to this library's image assets.
	 */
	public static inline var IMAGES_PATH:String = '$ASSETS_PATH/images';
}
