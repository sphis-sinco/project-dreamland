I recommend adding `cls;` to the start of the command.

To run windows: `haxe -main Compiler --interp -D PLATFORM=windows`
To run mac: `haxe -main Compiler --interp -D PLATFORM=mac`
To run linux: `haxe -main Compiler --interp -D PLATFORM=linux`
To run hashlink: `haxe -main Compiler --interp -D PLATFORM=hashlink`
To run html5: `haxe -main Compiler --interp -D PLATFORM=html5`
To run neko: `haxe -main Compiler --interp -D PLATFORM=neko`

To run in "debug" mode add `-D debug`
To run in "watch" mode add `-D watch`
To have comments add `-D comments`

Or you can just run the `.bat` files. But those are release builds only