# 1.0.0 (7/13/2025)
## Level Select
- The level name, variation, and difficulty text has been moved up
- Level sprite's scale has been set to 1 for the x and y
## Gameplay
- All backgrounds have been extended
- Level 1 easy enemies are 3 integers faster
## Application
- Added custom icon for the mobile app
- Added support for mobile platforms (Ios prob wouldn't work)
- The icon for the application has been updated. no more transparent background
## Options
- Controls menu is blocked on Android Builds
## Global
- Global now has a `goToUrl` **public static** function so you can rickroll people to your hearts content with scripts
## Outdated screen
- Linux can now properly go to the github now thanks to Global's new `goToUrl` function
## Modding
- The mod menu now gives message(s) for versions below 1.0.0
  - "Custom player results assets won't work"
## Results
- Added bad and new highscore player animations
- The player now appears after the score counts up
- The score is formated like this / money: "18,000" <!-- ITS OVER NINE THOUSAND! -->
- The player JSON fields `resultsAssetName` and `resultsFrameArray` are `resultsAssetNames` and `resultsFrameArrays` and require a format like this:
```json
{
    "bad": value,
    "good": value,
    "new_highscore": value,
}
```

# 0.11.0 (7/12/2025)
This is the last web-compatable version

## Added
- Outdated HTML5 builds special message
- "Save clear" option
- **RESULTS SCREEN**
  - `resultsAssetName` field to player JSONS
  - `HIGHSCORE` variable to PlayState for scripts and for the results screen
- **JUJIN (OVERDRIVE)**
- **HIKU (OVERDRIVE)**
- `InitState` (this allows for compiler flags!)
## Fixed
- Outdated state not appearing
- Saving: It now works properly and saves between sessions
- Highscore not being tracked as new by `Global`
## Changed
- Playstate variables `level_data` and `player_json` are public static variables, allowing for them to be easily used by scripts without needed to reference playstate's `instance` variable / singleton
## Removed
- ":" from Outdated text in the mod menu (properly)

# 0.10.0 (7/12/2025)
## Added
- **HEAVEN (OVERDRIVE)**
- `getSavedataInfo` function to scripts
- Shaders option to the Preferences menu
- Preferences menu to the options menu
## Removed
- ":" from Outdated text in the mod menu
## Fixed
- Mod menu not properly detecting of a mod's api version is less then 0.9.0
## Changed
- Re-exported earth enemies
- Re-exported hell enemies
- Re-exported heaven enemies

# 0.9.0 (7/12/2025)
## Added
- `Ctrl+Shift+R` keybind to reset the state, reload scripts, and reload mods
- New PlayState functions for scripts:
  - `onNewEnemy(enemy:FlxSprite)`
  - `onNewBullet(bullet:FlxSprite)`
- **OVERDRIVE VARIATIONS**
  - **EARTH (OVERDRIVE)**
  - **HELL (OVERDRIVE)**
- Multiply Color Shader
- Adjust Color Shader
- Display to the credits if the email or url are availible
- Instruction text to the credits
- Warning for outdated modds using the old level select level entry system
- `bullet` field to player JSON's
## Removed
- `name` and `difficulty` fields from ".dream" files
## Fixed
- Template script no longer has `stateCreate` and `stateUpdate` as functions returning a string
- [Title texts on the controls menu are no longer selectable (#1)](https://github.com/sphis-sinco/project-dreamland/commit/789a2d443e676e029eb0c3bdba7b8b0bb1c093ca)
- Crashes when the level data is blank
## Changed
- The flags `IRIS_DEBUG` and `hscriptPos` are enabled
- Main player assets (removed extra pixels)
- Player JSON's now have more control over bullet information
- Hiku's difficulty is now "hard-ish"
- Overhauled the level select level entries system:
  - Level select level entries are now driven by JSONS with the "dreamEntry" extension. Allowing for variation support.

# 0.8.0 (7/11/2025)
## Added
- Credits menu
- **NEW LEVEL: HIKU**
- Player JSON System
- `ammo`, and `player` field to level data.
  - `ammo` controls the amount of bullets possible onscreen
  - `player` controls the json that the game targets for the player
- Control remapping
- WASD Support (WS but whatever)
- Options menu
- The mod menu now says if a mod is outdated or not
## Fixed
- Game can now be compiles on `neko`
- The game no longer crashes when a background cannot be found (it uses the default)
## Removed
- BACKSPACE escape key for OutdatedState
## Changed
- The player assets are now JSON-driven
- More playstate variables were made public and available for it's singleton
- The mod menu now lists all contributors in a mod
- The mod menu mod description text has been moved
- The mod menu mod description box has been widened
- Project.xml fps has been set to "144" (no idea if it actually changed anything)

# 0.7.0 (7/10/2025)
This update counts yes as a content update but it mostly works as a patch

## Added
- `name` field to levels
- The mod menu saves/resets selection value before refreshing or leaving 
- `CurrentState` `Global` variable availible for scripts and the game
- `editorMenuStart` script call
## Changed
- Polymod should now be able to easily change assets through mods
- Levels now have an extension of `.dream` instead of `.json`
- When a mod gets toggled the mod menu reloads mods
## Fixed
- The mod menu loads properly when there are no mods now
- Modded levels work properly now
- Script replacement works properly now
- PlayState singleton (instance) gets set to null properly

# 0.6.0 (7/10/2025)
This update adds modding support via `polymod` and `hscript-iris`

## Added
- Modding via `polymod` and `hscript-iris` (Desktop only)
- Mod Menu (Desktop only)
## Changed
- Main Menu

# 0.5.0 (7/9/2025)
Using flixel 6.1.0
[Desktop builds](https://github.com/sphis-sinco/project-dreamland/actions/runs/16174756792)

## Fixed
- Saves not saving
- Score text in gameplay no longer checks for if there is a high score multiple times
## Removed
- Developer feature where it's always the Player's first time
- Level Select Level Texts
## Added
- SOUND EFFECTS
- NEW LEVEL: JUJIN
- Player doodle to the splash
- TryCatch file
- Level Background image to Level Select
## Changed
- Updated the File Manager to the latest version I have of it
- Level Select Controls from up and down to left and right
- Level Select Difficulty text to include Level name
- Level Select Difficulty text to be centered on the X-axis
- Overhauled how saving works I guess... It still works the same but I reprogrammed it but it's whatever

# 0.4.2 (1/26/2025)
## Changed
- Speeds of every rare enemy in each level
## Added
- Level Backgrounds
- Small "Tutorial" (using new save info: `firstTime`)
- New Save info
    - `firstTime` - should be `null` when your on your "first time" and will be set to `true` until detected that it's `true`, then it will be set to `false`

# 0.4.1 (1/26/2025)
## Fixed
- Every level being the earth level on web
## Added
- Discord RPC Support (thanks ComaToast)
- Game over screen

# 0.4.0 (1/26/2025)
## Added
- New LevelData fields
    - `chance` - json data that controls the rariety of `enemy-easy` and `enemy-rare`
    - `speed_additions` - json data that adds to the speeds of the 3 enemy types
- `LevelData` typedef to make things easier
- New global variable for the game version: `APP_VERSION`
- New application Icon
- Splash Screen
## Fixed
- Bug where every enemy would be earth enemies
- Level Select not reading level json files on web
## Changed
- Difficulty of earth: now `easy-ish`
- Difficulty of heaven: now `medium`

# 0.3.3 (1/26/2025)
## Fixed
- OutdatedState display even when you are not in an outdated version
- Level Select crash
## Added
- variables in Level select for level difficulties (hardcoded...)
- Back keybind to Level Select (you can leave it)

# 0.3.2 (1/26/2025)
The game should now be compilable for web

# 0.3.1 (1/26/2025)
The game should now be compilable for web

# 0.3.0 (1/25/2025)
## Added
- Enemy Art
    - Earth Enemy Art
    - Heaven Enemy Art
- Outdated State
- Level Select

# 0.2.0 (1/25/2025)
## Added
- Saving via `FlxG.save`
    - Highscore Saving
- Player Art
    - Art for idle
    - Animation for shooting with 2 ammo shootable
    - Animation for shooting with 1 ammo shootable
    - Animation for shooting with 0 ammo shootable
- Changed Player X Position
- Enemy Art
    - Random Chances for enemy arts to change
    - Hell Enemy Art
- Game version to Main Menu
## Changed
- Main Menu
    - Main Menu text now is bigger
    - Main Menu text now says Dreamland
    - Moved "Press enter to play" text
    - "Press enter to play" text now has a dark green color
    - Move highscore text
- Play State
    - Score text now turns green when you have achieved a new high score
    - Score now gets added depending on the enemy Type

# 0.1.0 (1/25/2025)
This is the minimum viable product. Not a V-Slice quality but MVP nonetheless
## Added
- Boxes for graphics
- Highscore system
    - Turns green when new high score (the high score text)
- Basic Gameplay
    - Vertical Movement
    - Enemies
        - Player dies when hit
    - Shooting
        - Enemies die when shot 
- Basic as hell main menu