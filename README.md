# Project Dreamland
A game born from meditation.

## Description
This video game project was created by Sphis_Sinco in January 25th, 2025. After attempting meditation for the first time. Now the project has risen from the grave in July of 2025. After 6 months of a hiatus. He returned to the project after noting that it had gathered more interest then the rest of his projects. And now here it stands. Old plans risen from the grave and being put into fruition.

## Modding
As of version 0.6.0 and onwards the game supports modding via `polymod` and `hscript-iris`. This allows for mods to be loaded by `polmod` in the "mods" folder, and for scripts to be loaded from the mods *and game's* "scripts" folder by the file manager, which will allow `hscript-iris` to parse it as it's own script.

In order to be recognized by Polymod, a mod folder must contain a metadata file. This file is located at `_polymod_meta.json` within the root of the mods folder. A mod’s metadata contains all the information needed for the game to not only recognize a mod and validate its compatibility, but also display it to other players in the mod menu. It includes a title, description, contributors list, and even optionally an icon you can display through `_polymod_icon.png`.

Recommended you read more on `_polymod_meta.json` [here on the official Polymod Website](https://polymod.io/docs/mod-metadata/), there are also some [best practices](https://polymod.io/docs/best-practices/#for-modders) for modders, so you can check that out too.

Right now the game allows for mods to perform asset replacements, adding levels to the game, and lets you use script files that can change the code of other parts of the game.

# Project Dreamland: Source code
## Compiling: Libraries
When it comes to compiling the game, **YOU NEED THE RIGHT LIBRARIES**. Polymod is a bit weird and the latest version doesn't have the proper library versions linked in the haxelib, so in order to fix this, you have 2 options.

### Option 1: The Haxe Module Manager
The `hmm.json` file in this repository can allow for you to quickly download libraries and/or add new ones to the project easily without having to worry about everyone else needing to install them.

These are the commands to install "HMM":
```
> haxelib --global install hmm
> haxelib --global run hmm setup
```

After that you run `hmm install` to install all the libraries.

### Option 2: The actions files
Previously there were attempts for auto-compiling for desktop platforms (linux, windows, and OSX/Mac specifically). But it wasn't working out well and was agony to maintain, so it was discontinued, but the files still live.

If you go to the `libs-installer` folder inside the `actions` folder you can run `haxe -main Main --interp -D NOT_GITHUB`, it will install all the HMM libraries automatically. Though when it comes to interactive prompts, that's where it got stuck, you can't input anything so all you can do is press `Ctrl+C` to skip it.

But if you wanna do compiling. Go to the `run` folder inside the `actions` folder and there is a README there on it. This wasn't really for the auto-compiling, mainly just a quality of life internal tool to assist others. But getting ontopic. This compiler file allows you to compile for multiple platforms, debug or not, and it also adds the `--times` argument to the compile command automatically, so you get the time reports on how long the build took. And if you don't have the `-D HMM_SKIP` argument added to your command, it installs the libraries for you automatically! I don't recommend it though, it'd be pretty annoying trying to compile for one change and then you're reinstalling all your libraries. So just add the `-D HMM_SKIP` argument and then you can compile as quickly as possible, depending on your platform.

## Compiling: Recommended compiling platform
When it comes to compiling I recommend using the "Hashlink" compiling platform it's the fastest, but it doesn't allow for C++ functions, so no Discord_RPC or http requests for version checking (for some reason...).

You can also compile to "Windows" for the C++ functions, so Discord_RPC and version checking http requests.

I don't recommend HTML5, it's pretty limited, no C++, no Polymod, no scripting, pretty much just **no Modding**.

I am unfamiliar with Neko and other platforms, but I know Neko doesn't suport C++ functions after making the game compilable for neko, so no Discord_RPC. As for other desktop platforms, I am unaware.