# ToS_MiniMapExtra
Minimap addon for Tree of Savior

![minimapextra](https://raw.githubusercontent.com/Maytch/ToS_MiniMapExtra/master/minimapextra-screenshot.jpg)

Displays unrevealed areas of the map required for map completion, and shows map name and percentage revealed above the minimap.

Credit to Excrulon, it's mostly the same as theirs but in the minimap frame.

To install:
 - Place the folders within the \Release folder into your Tree of Savior directory (e.g. "C:\Program Files (x86)\Steam\steamapps\common\TreeOfSavior\).
 - Either add the addon filepath of this addon to Excrulon's addonloader available here https://github.com/Excrulon/Tree-of-Savior-Lua-Mods/releases/tag/1.7 or use Fiote's addonloader which does it automatically here https://github.com/fiote/treeofsavior-addons

Source code available to view in the \src folder

Issues and notes:
- Occasionally you will reach 100% map completion on some maps even though there is a red tile remaining.
- Function hooks onto the FPS_ON_MSG function, so any addons that directly affect that function may cause incompatabilities. Might be worth hooking onto a function that updates more than once per second.
- Uses Lemon King's way of adding the .ipf file to the data folder, their addons are available here: https://github.com/Lemon-King/ToS-LKChat

Updates:

2016/04/28 06:57 BST (GMT+1) Changed the code that reveals the map completion percent, credit to /u/rickgibbed on reddit.
