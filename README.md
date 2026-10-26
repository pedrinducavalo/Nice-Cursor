# nice-cursor

A lightweight custom cursor library for HaxeFlixel and OpenFL games. It provides
several built-in cursor styles and optional HaxeUI support.

![Built-in cursor styles](./_art/cursores.png)

## Installation

Install the library with Haxelib:

```sh
haxelib git nice-cursor https://github.com/pedrinducavalo/Nice-Cursor.git
```

Then add `-lib nice-cursor` to your HXML build file, or configure the library
using your project's build setup.

## Usage

Import `Cursor` and `CursorStyle`, then show the custom cursor when your game
starts:

```haxe
import cursor.Cursor;
import cursor.config.CursorStyle;

// Call when setting up your game.
Cursor.show();
```

Change the cursor style by assigning a `CursorStyle` value:

```haxe
Cursor.cursorStyle = CursorStyle.Pointer;
```

The built-in styles are `Default`, `Pointer`, `Grab`, `Cross`, `Text`, and
`Loading`. For example:

```haxe
Cursor.cursorStyle = CursorStyle.Loading;
```

## HaxeUI support

The library also supports HaxeUI. When using HaxeUI, initialize it with
`Cursor.init()` before showing the cursor:

```haxe
Cursor.init();
Cursor.show();
```

These functions are available only when HaxeUI is included in your project.
