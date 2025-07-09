package polymod.fs;

#if sys
import polymod.Polymod.ModMetadata;
import polymod.fs.PolymodFileSystem;
import polymod.util.Util;
import polymod.util.VersionUtil;
import thx.semver.VersionRule;

/**
 * An implementation of IFileSystem which accesses files from folders in the local directory.
 * This is currently the default file system for native/Desktop platforms.
 */
class SysFileSystem implements IFileSystem
{
	public final modRoot:String;

	public function new(params:PolymodFileSystemParams)
	{
		this.modRoot = params.modRoot;
	}

	public function exists(path:String)
	{
		return sys.FileSystem.exists(path);
	}

	public function isDirectory(path:String)
	{
		return sys.FileSystem.isDirectory(path);
	}

	public function readDirectory(path:String):Array<String>
	{
		try
		{
			return sys.FileSystem.readDirectory(path);
		}
		catch (e)
		{
			Polymod.warning(DIRECTORY_MISSING, 'Could not find directory "${path}"');
			return [];
		}
	}

	public function getFileContent(path:String)
	{
		return getFileBytes(path).toString();
	}

	public function getFileBytes(path:String)
	{
		if (!exists(path))
			return null;
		return sys.io.File.getBytes(path);
	}

	public function scanMods(?apiVersionRule:VersionRule):Array<ModMetadata>
	{
		if (apiVersionRule == null)
			apiVersionRule = VersionUtil.DEFAULT_VERSION_RULE;

		var dirs = readDirectory(modRoot);
		var result:Array<ModMetadata> = [];
		for (dir in dirs)
		{
			var fullDir = Util.pathJoin(modRoot, dir);
			if (!isDirectory(fullDir))
				continue;

			var meta:ModMetadata = this.getMetadata(dir);

			if (meta == null)
				continue;

			if (!VersionUtil.match(meta.apiVersion, apiVersionRule))
			{
				Polymod.warning(MOD_API_VERSION_MISMATCH,
					'Mod "${dir}" is not compatible with API version "${apiVersionRule.toString()}", got "${meta.apiVersion.toString()}"');
				continue;
			}

			result.push(meta);
		}

		return result;
	}

	public function getMetadata(modId:String)
	{
		var modPath = Util.pathJoin(modRoot, modId);
		var test = readDirectory(modRoot);
		if (exists(modPath))
		{
			var meta:ModMetadata = null;

			var metaFile = Util.pathJoin(modPath, PolymodConfig.modMetadataFile);
			var iconFile = Util.pathJoin(modPath, PolymodConfig.modIconFile);

			if (!exists(metaFile))
			{
				Polymod.warning(MISSING_META, 'Could not find mod metadata file: $metaFile');
				return null;
			}
			else
			{
				var metaText = getFileContent(metaFile);
				meta = ModMetadata.fromJsonStr(metaText);
			}

			if (meta == null)
				return null;

			meta.id = modId;
			meta.modPath = modPath;

			if (!exists(iconFile))
			{
				Polymod.warning(MISSING_ICON, 'Could not find mod icon file: $iconFile');
			}
			else
			{
				var iconBytes = getFileBytes(iconFile);
				meta.icon = iconBytes;
				meta.iconPath = iconFile;
			}
			return meta;
		}
		else
		{
			Polymod.error(MISSING_MOD, 'Could not find mod directory: $modId');
		}
		return null;
	}

	public function readDirectoryRecursive(path:String):Array<String>
	{
		var all = _readDirectoryRecursive(path);
		for (i in 0...all.length)
		{
			var f = all[i];
			var stri = Util.uIndexOf(f, path + '/');
			if (stri == 0)
			{
				f = Util.uSubstr(f, Util.uLength(path + '/'), Util.uLength(f));
				all[i] = f;
			}
		}
		return all;
	}

	private function _readDirectoryRecursive(str:String):Array<String>
	{
		if (exists(str) && isDirectory(str))
		{
			var all = readDirectory(str);
			if (all == null)
				return [];
			var results = [];
			for (thing in all)
			{
				if (thing == null)
					continue;
				var pathToThing = Util.pathJoin(str, thing);
				if (isDirectory(pathToThing))
				{
					var subs = _readDirectoryRecursive(pathToThing);
					if (subs != null)
					{
						results = results.concat(subs);
					}
				}
				else
				{
					results.push(pathToThing);
				}
			}
			return results;
		}
		return [];
	}
}
#end
