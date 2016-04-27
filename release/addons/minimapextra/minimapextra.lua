function MINIMAP_UPDATE_EVENT(frame, msg, argStr, argNum)
	-- Execute the FPS_ON_MSG function that was overwritten
	_G["OLD_FUNCTION"](frame, msg, argStr, argNum);

	-- Map and minimap
	local mapName = session.GetMapName();
	local mapprop = geMapTable.GetMapProp(mapName);
	local minimapFrame = ui.GetFrame("minimap");
	local mapFrame = ui.GetFrame("map");

	-- Minimap zoom level
	local curSize = GET_MINIMAPSIZE();
	local mapZoom = math.abs((curSize + 100) / 100);

	-- Character's position relative to the minimap frame (the center)
	local framePositionWidth = minimapFrame:GetWidth() / 2;
	local framePositionHeight = minimapFrame:GetHeight() / 2;
	
	-- Character's position relative to the map
	local pictureUI  = GET_CHILD(mapFrame, "map", "ui::CPicture");	
	local mapWidth = pictureUI:GetImageWidth() * mapZoom;
	local mapHeight = pictureUI:GetImageHeight() * mapZoom;
	local objHandle = session.GetMyHandle();
	local myPosition = info.GetPositionInMap(objHandle, mapWidth, mapHeight);

	-- Loop through list of fog tiles
	HIDE_CHILD_BYNAME(minimapFrame, "_SAMPLE_");
	local tileList = session.GetMapFogList(mapName);
	local tileCount = tileList:Count();
	local revealedTiles = 0;
	local percentageRevealed = 0;
	for i = 0 , tileCount - 1 do
		local tile = tileList:PtrAt(i);
		
		if tile.revealed == 1 then
			-- Count number of revealed tiles for percentage
			revealedTiles = revealedTiles + 1;
		else
			-- Otherwise draw tile on minimap
			tilePosX = (tile.x * mapZoom) - myPosition.x + framePositionWidth;
			tilePosY = (tile.y * mapZoom) - myPosition.y + framePositionHeight;
			tileWidth = math.ceil(tile.w * mapZoom);
			tileHeight = math.ceil(tile.h * mapZoom);

			local tileName = string.format("_SAMPLE_%d", i);
			local pic = minimapFrame:CreateOrGetControl("picture", tileName, tilePosX, tilePosY, tileWidth, tileHeight);
			tolua.cast(pic, "ui::CPicture");
			pic:ShowWindow(1);
			pic:SetImage("fullred");
			pic:SetEnableStretch(1);
			pic:SetAlpha(40.0);
			pic:EnableHitTest(0);
		end
	end

	if revealedTiles == tileCount then
		percentageRevealed = 100;
	else
		percentageRevealed = (revealedTiles / tileCount) * 100;
		percentageRevealed = tonumber(string.format("%.1f", percentageRevealed));
	end

	-- Draw map name and percentage on frame above minimap
	local minimapExtraFrame = ui.GetFrame("minimapextra");
	minimapExtraFrame:SetGravity(ui.RIGHT, ui.TOP);

	local minimapExtraText = minimapExtraFrame:GetChild("minimapExtraText");
	tolua.cast(minimapExtraText, "ui::CRichText");
	minimapExtraText:SetText("{@st42}" .. mapprop:GetName() .. "  " .. percentageRevealed .. "%{/}");
	minimapExtraText:SetGravity(ui.LEFT, ui.TOP);
	minimapExtraText:SetTextAlign("left", "top");
	minimapExtraText:Move(0, 0);
	minimapExtraText:SetOffset(0, 10);
	minimapExtraFrame:ShowWindow(1);
end

-- Copy the FPS_ON_MSG function and replace it with ours
local eventHook = "FPS_ON_MSG";
_G["OLD_FUNCTION"] = _G["FPS_ON_MSG"];
_G[eventHook] = MINIMAP_UPDATE_EVENT;

ui.SysMsg("Minimap Extra loaded!");
