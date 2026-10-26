package cursor;

import openfl.geom.ColorTransform;

#if haxeui
import haxe.ui.Toolkit;
import haxe.ui.backend.flixel.CursorHelper;
#end

import lime.app.Future;

import openfl.Assets;
import openfl.display.BitmapData;

import flixel.FlxG;
import flixel.util.FlxColor;

import cursor.config.*;

/**
 * Provides static controls for showing, hiding, and styling the custom mouse cursor.
 * 
 * Supports built-in styles and optional HaxeUI cursor registration.
 */
@:nullSafety
class Cursor
{
	/**
	 * The current custom cursor style. Assigning a style loads its graphic synchronously.
	 * Assigning `null` leaves the current style unchanged; use `unload()` to unload the graphic.
	 */
	public static var cursorStyle(default, set):Null<CursorStyle> = null;
	
	@:noCompletion
	static inline function set_cursorStyle(value:Null<CursorStyle>):Null<CursorStyle>
	{
		if (value != null && cursorStyle != value)
		{
			cursorStyle = value;
			loadCursorGraphicSync(cursorStyle);
		}
		
		return cursorStyle;
	}
	
	/**
	 * Indicates whether the mouse cursor is visible.
	 */
	@:isVar
	public static var visible(get, set):Bool = false;
	
	@:noCompletion
	static inline function get_visible():Bool
	{
		return FlxG.mouse.visible;
	}
	
	@:noCompletion
	static inline function set_visible(value:Bool):Bool
	{
		FlxG.mouse.visible = value;
		cursorStyle = (value) ? Default : null;
		
		return visible = value;
	}
	
	/**
	 * Cached bitmap for the default cursor style.
	 */
	static var cacheCursorDefault:Null<BitmapData> = null;
	
	/**
	 * Cached bitmap for the pointer cursor style.
	 */
	static var cacheCursorPointer:Null<BitmapData> = null;
	
	/**
	 * Cached bitmap for the grab cursor style.
	 */
	static var cacheCursorGrab:Null<BitmapData> = null;
	
	/**
	 * Cached bitmap for the crosshair cursor style.
	 */
	static var cacheCursorCross:Null<BitmapData> = null;
	
	/**
	 * Cached bitmap for the text cursor style.
	 */
	static var cacheCursorText:Null<BitmapData> = null;
	
	/**
	 * Cached bitmap for the loading cursor style.
	 */
	static var cacheCursorLoading:Null<BitmapData> = null;
	
	/**
	 * Shows the custom cursor and selects the default style.
	 */
	public static inline function show():Void
	{
		visible = true;
	}
	
	/**
	 * Hides the cursor without unloading its custom graphic.
	 */
	public static inline function hide():Void
	{
		visible = false;
	}
	
	/**
	 * Toggles the cursor's visibility.
	 */
	public static inline function toggle():Void
	{
		if (!visible)
		{
			show();
		}
		else
		{
			hide();
		}
	}
	
	/**
	 * Loads a cursor style's graphic synchronously.
	 */
	static inline function loadCursorGraphicSync(style:Null<CursorStyle>):Void
	{
		loadCursorGraphic(style, false);
	}
	
	/**
	 * Loads a cursor style's graphic asynchronously.
	 */
	static inline function loadCursorGraphicAsync(style:Null<CursorStyle>):Void
	{
		loadCursorGraphic(style, true);
	}
	
	/**
	 * Loads and caches the graphic for a style, then applies its configuration.
	 * A `null` or unsupported style unloads the current cursor graphic.
	 */
	@:noCompletion
	static function loadCursorGraphic(style:Null<CursorStyle>, async:Bool = false):Void
	{
		if (style == null)
		{
			unload();
			return;
		}
		
		var data:Null<CursorData> = switch (style)
		{
			case Default:
				{
					cache: cacheCursorDefault,
					config: CursorConstants.CURSOR_DEFAULT_CONFIG,
					set: (bmp) -> cacheCursorDefault = bmp
				};
			case Pointer:
				{
					cache: cacheCursorPointer,
					config: CursorConstants.CURSOR_POINTER_CONFIG,
					set: (bmp) -> cacheCursorPointer = bmp
				};
			case Grab:
				{
					cache: cacheCursorGrab,
					config: CursorConstants.CURSOR_GRAB_CONFIG,
					set: (bmp) -> cacheCursorGrab = bmp
				};
			case Cross:
				{
					cache: cacheCursorCross,
					config: CursorConstants.CURSOR_CROSS_CONFIG,
					set: (bmp) -> cacheCursorCross = bmp
				};
			case Text:
				{
					cache: cacheCursorText,
					config: CursorConstants.CURSOR_TEXT_CONFIG,
					set: (bmp) -> cacheCursorText = bmp
				};
			case Loading:
				{
					cache: cacheCursorLoading,
					config: CursorConstants.CURSOR_LOADING_CONFIG,
					set: (bmp) -> cacheCursorLoading = bmp
				};
			default:
				null;
		};
		
		if (data == null)
		{
			unload();
			return;
		}
		
		if (data.cache != null)
		{
			loadGraphic(data.cache, data.config);
			return;
		}
		
		if (async)
		{
			var future:Future<BitmapData> = Assets.loadBitmapData(data.config.graphic);
			future.onComplete((bmp:BitmapData) -> {
				data.set(bmp);
				
				var color:Null<FlxColor> = data.config.color;
				if (color != null)
				{
					// Não posso 'setar' a cor diretamente porque muda a cor do contorno.
					var colorTransform:ColorTransform = new ColorTransform(color.redFloat, color.greenFloat, color.blueFloat);
					bmp.colorTransform(bmp.rect, colorTransform);
				}
				
				loadGraphic(bmp, data.config);
			});
			// future.onError((seila));
		}
		else
		{
			var bitmapData:BitmapData = Assets.getBitmapData(data.config.graphic);
			data.set(bitmapData);
			
			var color:Null<FlxColor> = data.config.color;
			if (color != null)
			{
				// Não posso 'setar' a cor diretamente porque muda a cor do contorno.
				var colorTransform:ColorTransform = new ColorTransform(color.redFloat, color.greenFloat, color.blueFloat);
				bitmapData.colorTransform(bitmapData.rect, colorTransform);
			}
			
			loadGraphic(bitmapData, data.config);
		}
	}
	
	/**
	 * Applies the configured tint, scale, and hotspot offsets to a cursor bitmap.
	 * A zero or negative scale can make the cursor unusable; incorrect offsets can
	 * place its hotspot incorrectly.
	 */
	static function loadGraphic(graphic:BitmapData, config:CursorConfig):Void
	{
		config.color ??= FlxColor.WHITE;
		config.scale ??= 1;
		config.xOffset ??= 0;
		config.yOffset ??= 0;
		
		FlxG.mouse.load(graphic, config.scale, config.xOffset, config.yOffset);
	}
	
	/**
	 * Unloads the custom cursor graphic.
	 */
	public static inline function unload():Void
	{
		FlxG.mouse.unload();
	}
	
	#if haxeui
	/**
	 * Initializes HaxeUI and applies the bundled Window stylesheet from the library assets.
	 */
	public static function init():Void
	{
		Toolkit.init();
		registerHaxeUICursors();
		Toolkit.styleSheet.parse(Assets.getText('${CursorConstants.ASSETS_PATH}/styles/window.css'));
	}
	
	/**
	 * Registers all built-in cursor styles with HaxeUI and enables custom cursors.
	 */
	public static function registerHaxeUICursors():Void
	{
		CursorHelper.useCustomCursors = true;
		
		registerHaxeUICursor('default', CursorConstants.CURSOR_DEFAULT_CONFIG);
		registerHaxeUICursor('pointer', CursorConstants.CURSOR_POINTER_CONFIG);
		registerHaxeUICursor('grab', CursorConstants.CURSOR_GRAB_CONFIG);
		registerHaxeUICursor('cross', CursorConstants.CURSOR_CROSS_CONFIG);
		registerHaxeUICursor('text', CursorConstants.CURSOR_TEXT_CONFIG);
		registerHaxeUICursor('loading', CursorConstants.CURSOR_LOADING_CONFIG);
		
		registerHaxeUICursor('ew-resize', CursorConstants.CURSOR_DEFAULT_CONFIG);
		registerHaxeUICursor('ns-resize', CursorConstants.CURSOR_DEFAULT_CONFIG);
		registerHaxeUICursor('nesw-resize', CursorConstants.CURSOR_DEFAULT_CONFIG);
		registerHaxeUICursor('nwse-resize', CursorConstants.CURSOR_DEFAULT_CONFIG);
		registerHaxeUICursor('move', CursorConstants.CURSOR_DEFAULT_CONFIG);
	}
	
	/**
	 * Registers one cursor graphic with HaxeUI under the given identifier.
	 * An unknown identifier may not be selectable by HaxeUI; an invalid graphic
	 * path can prevent the cursor from loading.
	 */
	public static function registerHaxeUICursor(id:String, config:CursorConfig):Void
	{
		config.color ??= FlxColor.WHITE;
		config.scale ??= 1;
		config.xOffset ??= 0;
		config.yOffset ??= 0;
		
		CursorHelper.registerCursor(id, config.graphic, config.scale, config.xOffset, config.yOffset);
	}
	#end
}
