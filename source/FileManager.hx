package;

import flixel.graphics.frames.FlxAtlasFrames;
import haxe.Json;
import haxe.PosInfos;
import lime.utils.Assets;
import modding.ModList;
import modding.PolymodHandler;

using StringTools;

#if sys
import sys.FileSystem;
import sys.io.File;
#end

class FileManager
{
	public static var SOUND_EXT:String = 'wav';

	public static var UNLOCALIZED_ASSETS:Array<String> = [];
	public static var UNFOUND_ASSETS:Array<String> = [];

	public static var LOCALIZED_ASSET_SUFFIX:String = '';

	/**
	 * Returns a path
	 * @param pathprefix Prefix which most likely is `assets/`
	 * @param path File
	 * @param PATH_TYPE Assets folder
	 * @return String
	 */
	public static function getPath(pathprefix:String, path:String, ?PATH_TYPE:PathTypes = DEFAULT, ?posinfo:PosInfos):String
	{
		var ogreturnpath:String = '${pathprefix}${PATH_TYPE}${path}';
		var returnpath:String = ogreturnpath;

		#if !DISABLE_LOCALIZED_ASSETS
		var asset_suffix:String = LOCALIZED_ASSET_SUFFIX;
		final suffix:String = (asset_suffix.length > 0) ? '-${LOCALIZED_ASSET_SUFFIX}' : '';
		var localizedreturnpath:String = '${ogreturnpath.split('.')[0]}${suffix}.${ogreturnpath.split('.')[1]}';

		if (localizedreturnpath != returnpath)
		{
			if (exists(localizedreturnpath))
			{
				returnpath = localizedreturnpath;
			}
			else
			{
				if (!UNLOCALIZED_ASSETS.contains(localizedreturnpath))
				{
					#if CNGLA_TRACES trace('Could not get localized asset: $localizedreturnpath'); #end
					UNLOCALIZED_ASSETS.push(localizedreturnpath);
				}
			}
		}
		#end

		if (exists(returnpath))
		{
			#if EXCESS_TRACES trace('Existing asset return path: ${returnpath}'); #end
		}
		else
		{
			unfoundAsset(returnpath, posinfo);
		}

		return returnpath;
	}

	public static inline function unfoundAsset(asset:String, ?posinfo:PosInfos):Void
	{
		if (!UNFOUND_ASSETS.contains(asset))
		{
			if (asset.contains('mods/'))
			{
				#if EXCESS_TRACES
				trace('Could not get asset: $asset'); // , posinfo);
				#end
			}
			else
			{
				trace('Could not get asset: $asset'); // , posinfo);
			}
			UNFOUND_ASSETS.push(asset);
		}
	}

	/**
	 * Returns an `assets/$file`
	 * @param file File
	 * @param PATH_TYPE Assets folder
	 * @return String
	 */
	public static function getAssetFile(file:String, ?PATH_TYPE:PathTypes = DEFAULT, ?posinfo:PosInfos):String
	{
		var returnPath:String = '';

		/**

			Change this to use your mod system shit

			for (mod in ModFolderManager.ENABLED_MODS)
			{
				// What if I was evil and made it so that 0.1.0 api mods couldnt do this >:)
				var dir_meta:ModMetaData = FileManager.getJSON('${ModFolderManager.MODS_FOLDER}${mod}/meta.json', posinfo);

				if (returnPath == '') // first come first serve
				{
					returnPath = getPath('mods/$mod/', '$file', PATH_TYPE, posinfo); // 'mods/$mod/$file'
				}
			}
		 */

		if (returnPath == '')
		{
			returnPath = getPath('assets/', '$file', PATH_TYPE, posinfo); // 'assets/$file'
		}

		return returnPath;
	}

	public static function getTypeArray(type:String, type_folder:String, ext:Array<String>, paths:Array<String>):Array<String>
	{
		var arr:Array<String> = [];
		#if sys
		var typePaths:Array<String> = paths;
		var typeExtensions:Array<String> = ext;

		var readFolder:Dynamic = function(folder:String, ogdir:String) {};

		var readFileFolder:Dynamic = function(folder:String, ogdir:String)
		{
			#if EXCESS_TRACES
			trace('${ogdir}${folder}');
			#end

			for (file in readDirectory('${ogdir}${folder}'))
			{
				final endsplitter:String = '${!folder.endsWith('/') && !file.startsWith('/') ? '/' : ''}';
				for (extension in typeExtensions)
				{
					if (file.endsWith(extension))
					{
						final path:String = '${ogdir}${folder}${endsplitter}${file}';

						if (!arr.contains(path))
						{
							arr.push('${path}');
						}
					}
				}

				if (!file.contains('.'))
				{
					readFolder('${file}', '${ogdir}${folder}${endsplitter}');
				}
			}
		}

		readFolder = function(folder:String, ogdir:String)
		{
			#if EXCESS_TRACES
			trace('reading ${ogdir}${folder}');
			#end

			TryCatch.tryCatch(function()
			{
				if (!folder.contains('.'))
				{
					readFileFolder(folder, '${ogdir}');
				}
				else
				{
					readFileFolder(ogdir, '');
				}
			}, {
					traceErr: true
			});
		}
		var readDir:Dynamic = function(directory:String)
		{
			#if EXCESS_TRACES
			trace('reading ${directory}');
			#end
			TryCatch.tryCatch(() ->
			{
				for (folder in FileSystem.readDirectory(directory))
				{
					readFolder(folder, directory);
				}
			}, {
					traceErr: true
			});
		}

		for (folder in ModList.getActiveMods(PolymodHandler.metadataArrays))
		{
			// trace('Checking $folder for a $type_folder folder');

			TryCatch.tryCatch(() ->
			{
				var prefix:String = 'mods/';
				var modDir:Array<String> = readDirectory('$prefix${folder}/');
				if (modDir.contains('$type_folder'))
				{
					trace('$folder has a $type_folder folder');
					typePaths.push('$prefix${folder}/$type_folder/');
				}
			}, {
					traceErr: true
			});
		}
		for (path in typePaths)
		{
			#if EXCESS_TRACES
			trace('reading $type path: $path');
			#end
			readDir(path);
		}

		var prevPath:String = '';
		var assetReplcements_replacement:Array<String> = [];
		var assetReplcements_replaced:Array<String> = [];
		// asset replacement
		#if ASSET_REPLACEMENT
		for (path in arr)
		{
			if (prevPath.length > 0)
			{
				// trace('$path | $prevPath');

				var pathSplit = path.split('/');
				var prevPathSplit = prevPath.split('/');

				var psv = pathSplit[0];
				var ppsv = prevPathSplit[0];

				var pi = 1;
				var ppi = 1;

				if (psv == 'mods')
				{
					pi = 2;
					psv = pathSplit[2];
				}
				else
					psv = prevPathSplit[1];
				if (ppsv == 'mods')
				{
					ppi = 2;
					ppsv = prevPathSplit[2];
				}
				else
					ppsv = prevPathSplit[1];

				while (pi != pathSplit.length - 1)
				{
					pi++;
					psv += '/' + pathSplit[pi];
				}
				while (ppi != prevPathSplit.length - 1)
				{
					ppi++;
					ppsv += '/' + prevPathSplit[ppi];
				}

				// trace('$psv | $ppsv');

				if (psv == ppsv)
				{
					if (pi > ppi)
					{
						// trace('Replacing "$prevPath" with "$path"');
						arr.remove(prevPath);

						assetReplcements_replaced.push(prevPath);
						assetReplcements_replacement.push(path);
					}
					else if (ppi > pi)
					{
						// trace('Replacing "$path" with "$prevPath"');
						arr.remove(path);

						assetReplcements_replaced.push(path);
						assetReplcements_replacement.push(prevPath);
					}
				}
			}

			prevPath = path;
		}
		#end

		var traceArr:Array<String> = [];
		for (path in arr)
		{
			var split = path.split('/');
			traceArr.push(split[split.length - 1]);
		}

		var spacing = '    |    ';
		trace('Loaded ${traceArr.length} $type file(s)');
		for (file in arr)
		{
			trace('$spacing"$file"');
		}
		trace('Replaced ${assetReplcements_replaced.length} $type file(s)');
		var i = 0;
		for (file in assetReplcements_replaced)
		{
			trace('$spacing"$file" with "${assetReplcements_replacement[i]}"');
			i++;
		}
		#end
		return arr;
	}

	#if SCRIPT_FILES
	/**
	 * File extension for scripts
	 */
	public static var SCRIPT_EXT:String = 'hx';

	/**
	 * Returns `assets/data/scripts/$file` if `SCRIPT_FILES_IN_DATA_FOLDER` otherwise returns `assets/scripts/$file` only if `SCRIPT_FILES` is enabled
	 * @param file File
	 * @param PATH_TYPE Assets folder
	 * @return String
	 */
	public static function getScriptFile(file:String, ?PATH_TYPE:PathTypes = DEFAULT, ?posinfo:PosInfos):String
	{
		var finalPath:Dynamic = 'scripts/$file'; // .$SCRIPT_EXT';

		#if SCRIPT_FILES_IN_DATA_FOLDER
		return getDataFile(finalPath, PATH_TYPE, posinfo);
		#end

		return getAssetFile(finalPath, PATH_TYPE, posinfo);
	}

	#if sys
	public static function getScriptArray():Array<String>
	{
		var typePaths:Array<String> = ['assets/scripts/'];
		var typeExtensions:Array<String> = ['.hx', '.hxc'];

		return getTypeArray('script', 'scripts', typeExtensions, typePaths);
	}
	#else
	public static function getScriptArray():Array<String>
	{
		trace('Not Sys!');
		return [];
	}
	#end
	#else

	/**
	 * Dummy var for if not `SCRIPT_FILES`
	 */
	public static var SCRIPT_EXT:String = '';

	/**
	 * Dummy function for if not `SCRIPT_FILES`
	 */
	public static function getScriptFile(?file:String = '', ?PATH_TYPE:PathTypes = DEFAULT, ?posinfo:PosInfos):String
	{
		return '';
	}

	/**
	 * Dummy function for if not `SCRIPT_FILES`
	 */
	public static function getScriptArray():Array<String>
	{
		return [];
	}
	#end

	/**
	 * Returns `assets/data/$file`
	 * @param file File
	 * @param PATH_TYPE Assets folder
	 * @return String
	 */
	public static function getDataFile(file:String, ?PATH_TYPE:PathTypes = DEFAULT, ?posinfo:PosInfos):String
		return getAssetFile('data/$file', PATH_TYPE, posinfo);

	/**
	 * Returns `assets/images/$file.png`
	 * @param file File
	 * @param PATH_TYPE Assets folder
	 * @return String
	 */
	public static function getImageFile(file:String, ?PATH_TYPE:PathTypes = DEFAULT, ?posinfo:PosInfos):String
		return getAssetFile('images/$file.png', PATH_TYPE, posinfo);

	/**
	 * Returns `assets/$file.$SOUND_EXT`
	 * @param file File
	 * @param PATH_TYPE Assets folder
	 * @return String
	 */
	public static function getSoundFile(file:String, ?PATH_TYPE:PathTypes = DEFAULT, ?posinfo:PosInfos):String
	{
		return getAssetFile('$file.$SOUND_EXT', PATH_TYPE, posinfo);
	}

	/**
	 * Writes to a file or path using `sys`
	 * @param path File path
	 * @param content File content
	 */
	public static function writeToPath(path:String, content:String):Void
	{
		#if sys
		if (path.length > 0)
		{
			var prevDir:String = '';

			for (dir in path.split('/'))
			{
				if (!readDirectory('').contains(prevDir) && prevDir != '')
				{
					FileSystem.createDirectory(prevDir);
					#if EXCESS_TRACES
					trace('creating $prevDir');
					#end
				}

				if (!readDirectory(prevDir).contains(dir) && !dir.contains('.'))
				{
					FileSystem.createDirectory(dir);
					#if EXCESS_TRACES
					trace('creating $dir');
					#end
				}

				prevDir += dir + '/';
			}

			if (!exists(path))
			{
				File.write(path, false);
				#if EXCESS_TRACES
				trace('generating $path');
				#end
			}

			File.saveContent(path, content);
			#if EXCESS_TRACES
			trace('writing to $path');
			#end
		}
		else
		{
			throw 'A path is required.';
		}
		#else
		trace('NOT SYS!');
		#end
	}

	/**
	 * Read a file using `lime.utils.Assets` and a try catch function
	 * @param path the path of the file your trying to read
	 */
	public static function readFile(path:String, ?posinfo:PosInfos):String
	{
		if (!exists(path))
		{
			unfoundAsset(path, posinfo);
			return '';
		}

		#if sys
		return TryCatch.tryCatch(function()
		{
			return File.getContent(path);
		}, {
				traceErr: true
		});
		#end

		return TryCatch.tryCatch(function()
		{
			return Assets.getText(path);
		}, {
				traceErr: true
		});

		return '';
	}

	/**
	 * Reads a file that SHOULD BE A JSON, using `readFile`
	 * @param path the path of the json your trying to get
	 */
	public static function getJSON(path:String, ?posinfo:PosInfos):Dynamic
	{
		var json:Dynamic = null;
		var file:String = readFile(path, posinfo);

		TryCatch.tryCatch(function()
		{
			json = Json.parse(file);
		}, {
				errFunc: function()
				{
					json = file;
				}
		});

		return json;
	}

	/**
	 * Reads a directory if `sys` via `FileSystem.readDirectory`
	 * @param dir This is the directory being read
	 */
	public static function readDirectory(dir:String, ?typeArr:Array<String>):Array<String>
	{
		var finalList:Array<String> = [];
		var rawList:Array<String> = [];

		#if sys
		rawList = FileSystem.readDirectory(dir);
		for (i in 0...rawList.length)
		{
			if (typeArr?.length > 0)
			{
				for (type in typeArr)
				{
					if (rawList[i].endsWith(type))
					{
						finalList.push(rawList[i]);
					}
				}
			}
			else
				finalList.push(rawList[i]);
		}

		return finalList;
		#end

		return null;
	}

	/**
	 * Returns a bool value if `path` exists
	 * @param path the path your checking
	 * @return Bool
	 */
	public static function exists(path:String):Bool
	{
		return openfl.utils.Assets.exists(path);
	}

	public static function getPackerAtlas(path:String, ?path_type:PathTypes, ?posinfo:PosInfos):FlxAtlasFrames
	{
		return FlxAtlasFrames.fromSpriteSheetPacker(getImageFile(path, path_type, posinfo), getImageFile('$path', path_type, posinfo).replace('.png', '.txt'));
	}

	public static function getSparrowAtlas(path:String, ?path_type:PathTypes, ?posinfo:PosInfos)
	{
		return FlxAtlasFrames.fromSparrow(getImageFile(path, path_type, posinfo), getImageFile('$path', path_type, posinfo).replace('.png', '.xml'));
	}
}

/**
 * This would hold Asset folders, for example `assets/default` or `assets/gameplay`
 */
enum abstract PathTypes(String) from String to String
{
	public var DEFAULT:String = '';
}
