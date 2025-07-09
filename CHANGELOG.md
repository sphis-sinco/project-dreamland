# 0.5.0 (1/28/2025)
## Removed
- Developer feature where it's always the Player's first time
- Level Select Level Texts
## Added
- Level Background image to Level Select
## Changed
- Level Select Controls from up and down to left and right
- Level Select Difficulty text to include Level name
- Level Select Difficulty text to be centered on the X-axis
- Overhauled how saving works I guess... It still works the same but I reprogrammed it but it's whatever\

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