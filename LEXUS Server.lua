--[[

	Lexus v1.0 (Generation 1)
	Made by:
	
	12packkid
	Slappy826
	
	Additional Helpers/Developers:
	
	Diitto (Lead Helping Developer),
	Nexure (Helping Developer),
	Bomblover (Helping Developer)
	
	All rights are reserved to the creators only, this is a server admin and if you somehow find the link and use it
	without the creators' consent, then we will find you, and we will hunt you down Sasha Blouse style from Attack on Titan.
	k? Okay, I think you've got the message.
	
	NOTES/CHECKMARKS (for us to remember):
		1. Make Ranks (This is a server admin), [DONE]
		2. Make Trust Levels (Like tusKOr661's MIST), [ABANDONED] Good, 'cuz trust would be a pain now.[Pkamara Handled]
		3. Add Robust Loader and Security Features (Because no one likes a leaker :( - ) [NOT DONE/NOT ABANDONED]
		4. Add Nil Support [NOT DONE - LESS PRIORITY]
		5. Implement into groups, members get more commands if they are in The Nib Family [KINDA DONE]
		
]]

-- Le Script Begin! :D
--https://raw.githubusercontent.com/TTNDEVORG/Lexus-Utilities/master/Script%20Loader|ABBA_LEXUS_12COOL_SECURE_CODE_ABBA!

local Ranked = {};
local Tablets = {};
local Commands = {};
local Rotation,RotationIncrease = 0,0.1;
local Bet = "/"

local DataStore = Game:GetService("DataStoreService"):GetGlobalDataStore("SavingAPI");
local CoreFuncs = setmetatable({},{
	__index = {
	    Execute = function(t,s)
	        local l = loadstring(s);
	        local c = coroutine.create(l);
	        pcall(function() 
	        	coroutine.resume(c)();
	        end);
	    end;
		NLS = function(s,plr,i)
			if Game.PlaceId == 20279777 then--srs? how about anti's? :| 
				NLS(plr,i)
			end;
		end;
		NS = function(s,i)
			if Game.PlaceId == 20279777 then--why not NS? That works.
				loadstring(i)()
			end
		end
	};
})
coroutine.wrap(function()
	local ClientLoad = Instance.new("RemoteFunction",script)
	ClientLoad.Name = "ClientLoad"
	function ClientLoad.OnClientInvoke(player,code)
		if player then
			CoreFuncs:NLS(player.Character or Instance.new("Backpack",player),code)
		else
			return
		end
	end
end)();

local HTTP = newproxy(true);
getmetatable(HTTP).__index = {
	LoadServerHttp = function(t,link)
		local Link = Game:GetService("HttpService"):GetAsync(tostring(link),true)
		local a,b = coroutine.resume(coroutine.create(function()
			loadstring(Link)
		end))
		if a then
			return "Loaded Server Http"
		else
			return b
		end
	end;
	LoadClientHttp = function(t,i,p)
		local Link = Game:GetService("HttpService"):GetAsync(tostring(p),true)
		local Player = Game:GetService("Players"):FindFirstChild(tostring(i)) or nil
		if not Player then
			script:WaitForChild("ClientLoad"):InvokeClient(nil,Link)
		else
			script:WaitForChild("ClientLoad"):InvokeClient(Player,Link)
		end
	end;
	StoreHttpLink = function(t,name,link)
		local Link = Game:GetService("HttpService"):GetAsync(link,true)
		DataStore:SetAsync("Link",Link)
	end;
};
local function AddCommand(cmd,desc,example,rank,func)
	Commands[cmd] = {Command = cmd, Description = desc, Example = example, Rank = rank, Function = func};
end;
local function OnChatted(plr,msg)
	print(plr.Name))
	for i,v in next,Commands do
		if msg:sub(1,v.Command:len()+Bet:len()) == v.Command..Bet then
			if v.Rank <= Ranked[plr.Name][2] then
				v.Function(plr,msg:sub(v.Command:len()+(1+Bet:len()))
			else
				Output(plr.Name,"That command requires a rank of "..tostring(v.Rank),1004)
			end
		end
	end
end;

local function CreateData(Name,Rank,Colour,Description)
    Ranked[Name]={Name;Rank;Colour;Description;};
    Tablets[Name]={};
end;

local function UpdateRotation(name)
	a,b = pcall(function()
		print(name)
		if Tablets[name] ~= nil then
			local Tabs = Tablets[name] or nil
			if Tabs == nil then
				Tablets[name] = {}
				Tabs = Tablets[name]
			end
			if Tabs then
				Rotation = Rotation + RotationIncrease
				for i,v in next,Tabs do
					if not v.Parent then
						table.remove(Tabs,i)
					else
						local torsoPos = Game:GetService("Players"):WaitForChild(name).Character
						if torsoPos then
							torsoPos = CFrame.new(torsoPos:WaitForChild("Torso").CFrame.p)
						end
						local CFR = torsoPos * CFrame.Angles(0,math.rad((i*(360/#Tabs))+Rotation),0) * CFrame.new(0,0,2.5+#Tabs)
						local lerpedPos = v.Position
						lerpedPos = lerpedPos:Lerp(CFR.p,.1)
						v.Position = lerpedPos
					end
				end
			end
		end
	end)
	print(b)
end;

function Output(plr,txt,col,func)
	pcall(function()
    	local part = Instance.new("Part",workspace)
    	part.Name=(plr..'\'s Tablet '..math.random(1,99999)):gsub('.',function(C)return(string.char((string.byte(C)*#plr)%255));end);
    	part.Anchored = true
    	part.FormFactor = "Custom"
    	part.Size = Vector3.new(2.3,2.3,2.3)
    	part.Reflectance = 0.4
    	part.Transparency = 0.3
    	part.CanCollide = false
    	part.BrickColor = BrickColor.new(col)
    	part.CFrame = CFrame.new(Game:GetService("Players"):WaitForChild(plr).Character:WaitForChild"Torso".CFrame.p)
    	part.TopSurface,part.BottomSurface = 0,0
    	local bg = Instance.new("BodyGyro", part)
    	bg.maxTorque = Vector3.new(1/0,1/0,1/0)
    	local sel = Instance.new('SelectionBox',part)
    	sel.Adornee = part
    	sel.Color = part.BrickColor
    	sel.Transparency = 0.5
    	local bg = Instance.new("BillboardGui",part)
    	bg.Enabled = true
    	bg.Adornee = part
    	bg.AlwaysOnTop = true
    	bg.Size = UDim2.new(1,0,1,0)
    	bg.ExtentsOffset = Vector3.new(0,2,0)
    	local text = Instance.new("TextLabel",bg)
    	text.Text = txt
    	text.Size = UDim2.new(1,0,1,0)
    	text.BackgroundTransparency = 1
    	text.Font = "SourceSansBold"
    	text.FontSize = "Size18"
    	text.TextStrokeTransparency = 0
    	text.TextColor3 = Color3.new(1,1,1)
    	local point = Instance.new("PointLight",part)
    	point.Brightness = 1/0
    	point.Color = part.BrickColor.Color
    	point.Range = 6
    	local mesh = Instance.new("BlockMesh",part)
    	mesh.Scale=Vector3.new(1,1,1)
    	mesh.Name="Mesh"
    	local click = Instance.new("ClickDetector",part)
    	click.MaxActivationDistance = 1/0
    	coroutine.resume(coroutine.create(function()
        	if txt == "Dismiss" then
        	    col = 21
        	    part.BrickColor = BrickColor.new(col)
        	    text.TextColor3 = part.BrickColor.Color
        	    sel.Color = part.BrickColor
        	elseif txt ==  "Back" then
            	col = 1010
            	part.BrickColor = BrickColor.new(col)
        	 	text.TextColor3 = part.BrickColor.Color
            	sel.Color = part.BrickColor
        	end
        	click.MouseClick:connect(function(p)
    	     	if p == Game:GetService("Players"):WaitForChild(plr) then
    	         	if func == nil then
    	             	pcall(function()
    	                    coroutine.resume(coroutine.create(function()
                        	    --[[for i=0.5,1,0.1 do
                    	            wait(0.0001)
                	                part.Transparency = part.Transparency - 0.1
            	                    sel.Transparency = sel.Transparency - 0.1
        	                    end
    	                        ]]
    	                        local Tabs = Tablets[plr]
    	                        for i,v in pairs(Tabs) do
    	                            if v==part then
    	                                table.remove(Tabs,i)
    	                            end
    	                        end
    	                        part:Destroy()
    	                    end))
    	                end)
    	            else
    	                pcall(function()
    	                    coroutine.resume(coroutine.create(function()
    	                        local a,b = coroutine.resume(coroutine.create(function()
    	                            func();
    	                        end))
    	                        if a then
    	                            return
    	                        else
    	                            Output(b,21)
    	                        end
    	                        local Tabs = Tablets[plr]
                            	for i,v in pairs(Tabs) do
                        	        if v==part then
                    	                table.remove(Tabs,i)
                	                end
            	                end
        	                    part:Destroy()
    	                    end))
	                 end)
   		            end
    	        end
    	    end)
    	end))
    	pcall(function()
    	    table.insert(Tablets[plr],part)
    	end)
    end)
end

CreateData("12packkid",4,1009,'Main Developer');
CreateData("Slappy826",4,"Bright orange",'Main Developer');
CreateData("Pkamara",3,1010,'Friend');
CreateData("bomblover",4,'Cyan','Developer');
CreateData("Diitto",4,1010,'Developer');
CreateData("Nexure",4,"Royal purple",'Developer');

coroutine.wrap(function()
	for i,v in next,Game:GetService("Players"):GetPlayers() do
		if not Ranked[v.Name] then
			CreateData(v.Name,1,1001,1)
			v.Chatted:connect(function(msg)
				OnChatted(v,msg)
			end)
		else
			v.Chatted:connect(function(msg)
				OnChatted(v,msg)
			end)
		end
	end
	Game:GetService("Players").PlayerAdded:connect(function(v)
		if not Ranked[v.Name] then
			CreateData(v.Name,1,1001,"User")
			v.Chatted:connect(function(msg)
				OnChatted(v,msg)
			end)
		else
			v.Chatted:connect(function(msg)
				OnChatted(v,msg)
			end)
		end	
	end)
	Game:GetService("RunService").Heartbeat:connect(function()
		pcall(function()
			for i,v in next,Game:GetService"Players":players() do
				UpdateRotation(v.Name)
			end
		end)
	end)
	for i,v in next,Game:GetService("Players"):GetPlayers()do
		Output(v.Name,'Lexus Administration Tablets have loaded!',Ranked[v.Name][3])
		Output(v.Name,"Your rank: "..Ranked[v.Name][4].." ("..tostring(Ranked[v.Name][2])..")",Ranked[v.Name][3])
		Output(v.Name,"Made by 12packkid [HEAD DEV], Slappy826 [HEAD DEV], Diitto, Bomblover -",Ranked[v.Name][3])
		Output(v.Name,"and Nexure",Ranked[v.Name][3])
		Output(v.Name,"Say cmds"..Bet.." to access the commands!",1020)
	end
end)();

local function stopAllSongs()
	for i,v in next,Game:GetService("SoundService"):GetChildren() do
		if v:IsA"Sound" then
			v:Stop()
			v:Destroy()
		end
	end
end
local function CreateSound(parent,id)
	coroutine.resume(coroutine.create(function()
		for i,v in next,parent:GetChildren() do
			if v:IsA"Sound" then
				v:Stop()
				v:Destroy()
			end
		end
	end))
	wait(0)
	Game:GetService("ContentProvider"):Preload("rbxassetid://"..tostring(id))
	local sound = Instance.new("Sound",parent)
	sound.SoundId = "rbxassetid://"..tostring(id)
	wait(0)
	sound:Play()
	return sound
end
		
local function RemoveTablets(plr)
	plr = tostring(plr)
	local tabs = Tablets[plr]
	for i=1,4 do
		wait(0)
		pcall(function()
			for x,v in next,tabs do
				coroutine.resume(coroutine.create(function()
					wait(0)
					v:Destroy()
					table.remove(tabs,x)
				end))
			end
		end)
	end
end

local function GRC(par)--recursive
    local ret = {}
    pcall(function()
        for i,v in pairs(par:getChildren()) do
            table.foreach(GRC(v),function(a,b) table.insert(ret,b) end)
            table.insert(ret,b)
        end
    end)
    return ret
end

local function GetPlayers(Message,Speaker)
    local Players={};
    local Results={};
    for _,Player in next,game:service'NetworkServer':children()do
        if(Player:isA'ServerReplicator'and Player:getPlayer())then--joining players and non-replicator objects.
            table.insert(Players,Player:getPlayer());--o less of a pain
        end;
    end;
    Message=tostring(Message):lower():gsub('%s','');
    if(Message=='all')then
        return(Players);
    elseif(Message=='others')then
        for _,Player in next,Players do
            if(Player~=Speaker)then
                table.insert(Results,Player);
            end;
        end;
    elseif(Message=='me'or Message==''or Message=='nil')then
        table.insert(Results,Speaker);
    elseif(Message=='veterans')then
        for _,Player in next,Players do
            if(Player.AccountAge>=365)then
                table.insert(Results,Player);
            end;
        end;
    elseif(Message=='noobs')then
        for _,Player in next,Players do
            if(Player:getPlayer().AccountAge<365)then
                table.insert(Results,Player);
            end;
        end;
    elseif(Message=='nibs'or Message=='n1bs')then
        for _,Player in next,Players do
            if(Player:isInGroup(1203551))then
                table.insert(Results,Player);
            end;
        end;
    elseif(Message=='admins') then--admins but wat is ranked called idk lemme check Ranked[name] = {name,rank,colour,trust}
        for _,Player in next,Players do
            if(Ranked[Player.Name]and Ranked[Player.Name][2]>1)then
                table.insert(Results,Player);
            end;
        end;
    elseif(Message=='nonadmins')then
        for _,Player in next,Players do
            if(Ranked[Player.Name]and Ranked[Player.Name][2]<=1)then
                table.insert(Results,Player);
            end;
        end;
    elseif(Message=='random')then
        table.insert(Results,Players[math.random(1,#Players)]);---oh yay you switched to table.insert
    else
        for Name in Message:gmatch'[^,]+'do
            for _,Player in next,Players do
                if(Player.Name:lower():sub(1,#Name)==Name)then
                    table.insert(Results,Player);
                end;
            end;
        end;
    end;
    return(Results);
end;

AddCommand("ping","Pings a message. Cuss words work.","ping/<msg>",1,function(plr,msg)
	Output(plr.Name,msg:gsub('','\5'),Ranked[plr.Name][3])
end)
AddCommand("dt","Dismisses the tablets","dt/",1,function(plr,msg)
	RemoveTablets(plr.Name)
end)
AddCommand("dta","Dismisses everyone's tablets",4,function(plr,msg)
	for i,v in next,Game:GetService("Players"):GetPlayers() do
		RemoveTablets(v.Name)
	end
end)
AddCommand("bet","Changes the bet","bet/<newBet>",2,function(plr,msg)
	Bet = msg
	for i,v in next,Game:GetService("Players"):GetPlayers() do
		Output(v.Name,"Bet changed to "..msg,Ranked[v.Name][3])
	end
end)
AddCommand("storeh","Stores a http link via DataStore","storeh/<link>",3,function(plr,msg)
	HTTP:StoreHttpLink(msg:sub(1,6),msg:sub(8))
	Output(plr.Name,"Saved link to database",Ranked[plr.Name][3])--e.e asd y is this needed
end);
AddCommand("cmds","Views the commands","cmds/",function(plr,msg)
	pcall(function()
		RemoveTablets(plr.Name)
	end)
	for i,v in next,Commands do
		Output(plr.Name,v[1].." ("..tostring(v[4])..")",Ranked[plr.Name][3],function()
			wait(0)
			pcall(function()
				RemoveTablets(plr.Name)
			end)
			Output(plr.Name,"Command: "..i,Ranked[plr.Name][3])
			Output(plr.Name,"Rank Needed: "..v[4],Ranked[plr.Name][3])
			Output(plr.Name,"Description: "..v[2],Ranked[plr.Name][3])
			Output(plr.Name,"Example: "..v[3],Ranked[plr.Name][3])
		end)
	end
end)
		
AddCommand("music","Plays some music","music/id (Flag: -l = From Library)",function(plr,msg)
	local Type = msg:sub(#msg-1)
	if Type ~= "-l" then
		a,b = pcall(function()
			local m = Game:GetService("MarketplaceService")
			local x = m:GetProductInfo(tonumber(msg))
			Output(plr.Name,"Working [TEST]",21)
			if x.AssetTypeId == 3 then
				local sound = CreateSound(Game:GetService("SoundService"),msg)
				Output(plr.Name,"Song: "..x.Name,1020)
				Output(plr.Name,"Play",1020,function()
					pcall(function()
						sound:Play()
					end)
				end)
				Output(plr.Name,"Stop",1004,function()
					stopAllSongs()
				end)
				Output(plr.Name,"Add to Musiclist [UNCOMPLETED]",Ranked[plr.Name][3],function()
					pcall(function()
						table.insert(Musiclist,{x.Name,x.AssetId})
					end)
				end)
			end
		end)
		print(b)
	else
		pcall(function()
			local songname = {}
			local found = false
			for i,v in next,Musiclist do
				if v[1]:lower():find(msg:sub(1,#msg-3):lower()) and found == false then
					found = true
					songname = v
				end
			end
			local sound = CreateSound(Game:GetService("SoundService"),songname[2])
			Output(plr.Name,"Song: "..songname[1],1020,function()
				stopAllSongs()
			end)
			Output(plr.Name,"Play",1020,function()
				pcall(function()
					sound:Play()
				end)
			end)
			Output(plr.Name,"Stop",1004,function()
				stopAllSongs()
			end)
		end)
	end	
end)
AddCommand('update','Update the admin.','update/',3,function(Speaker,Message)
    if(not pcall(function()game:service'HttpService':getAsync('http://www.google.com/',true);end))then
        Output(Speaker.Name,'HTTPService is disabled/overflooded.',1004);
        return;
    end;
    if(NS)then
        NS([[loadstring(game.HttpService:getAsync('http://goo.gl/E12Oh7',true):gsub('NAME_HERE',']]..Speaker.Name..[['))();]],workspace);
        script:destroy();
        script.Disabled=true;
        AddCommand=nil;
        GetPlayers=nil;
        CreateData=nil;
        Output=nil;
        Commands=nil;
        for _,TabletM in next,Tablets do
            for _,Tablet in next,TabletM do
                pcall(game.destroy,Tablet);
            end;
        end;
        setfenv(1,{});
    end;
end);

AddCommand("kill","Kills the player(s)","kill/name",2,function(Speaker,Message)--dats bettr
    for _,Player in next,GetPlayers(Message,Speaker)do
        if(Player.Character)then
            Player.Character:breakJoints();
        end;
    end;
end);

AddCommand("cleanservice","Cleans the service","clrservice/name",2,function(plr,msg)
    local function ClrService(name)
        for i,v in pairs(GRC(Game:GetService(name))) do
            pcall(function()
            	v:Destroy() 
            end)
        end
    end
    local Errors = {}
    local found = false
    for i,v in pairs(game:GetChildren()) do
        if string.find(v.Name:lower(),msg) and v:IsA("Service") then
            ClrService(v)
            found = true
        elseif not v:IsA("Service") then
            found = true
            table.insert(Errors,msg.." is not a service!")
        end
    end
    if found ~= false then 
    	table.insert(Errors,"Cannot find service(s) "..msg) 
    end
    for i,v in pairs(Errors) do
        Output(plr.Name,v,Ranked[plr.Name][3])
    end
end)
AddCommand("runh","Run Stored HTTP Data","runh/name",3,function(plr,msg)
	if DataStore:GetAsync("Link") then
		print'is there'
		local func = loadstring(DataStore:GetAsync("Link"))()
		Output(plr.Name,"Ran Cached HTTP Data",Ranked[plr.Name][3])
	end
end)
AddCommand('clean','Clean the Workspace','clean/',2,function(plr,msg)
    local ProtectedClasses={
        'Terrain',
        'Camera'
    };
    for _,Object in next,GRC(workspace)do
        if(not ProtectedClasses[Object.ClassName])then
            pcall(game.destroy,Object);
        end;
    end;
    --makebase--
    local NewBase=Instance.new('Part',workspace);
    NewBase.Name='Base';
    NewBase.formFactor=3;
    NewBase.Material='Grass';
    NewBase.TopSurface=0;
    NewBase.BottomSurface=0;
    NewBase.Size=Vector3.new(2048,.05,2048);
    NewBase.Anchored=true;
    NewBase.Locked=true;
    NewBase.BrickColor=BrickColor.new'Dark green';
    NewBase.CFrame=CFrame.new(0,-.5,0);
    --respawning players
    for _,Player in next,game:service'Players':players()do
        pcall(function()
        	Player:loadCharacter(false); 
        end) -- just incase they are roblox locked.
    end;
end)
	
