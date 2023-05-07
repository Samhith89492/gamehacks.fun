local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("gamehacks.fun", "Sentinel")

local Tab = Window:NewTab("Movement")

local MovementSection = Tab:NewSection("Movement")

MovementSection:NewButton("E to fly!", "Press E to fly!", function()
    local Speed = 200


    if not RootAnchorBypassed then
        getgenv().RootAnchorBypassed = true
        local Player = game:GetService("Players").LocalPlayer
        local Character = Player.Character or Player.CharacterAdded:Wait()
        local Root = Character:FindFirstChild("HumanoidRootPart")
        Player.CharacterAdded:Connect(function(C)
            Root = C:WaitForChild("HumanoidRootPart")
            wait(0.5)
            for _, C in pairs(getconnections(Root:GetPropertyChangedSignal("Anchored"))) do C:Disable() end
        end)
        
        local GameMT = getrawmetatable(game)
        local __oldindex = GameMT.__index
        setreadonly(GameMT, false)
        GameMT.__index = newcclosure(function(self, Key)
            if self == Root and Key == "Anchored" then return false end
            return __oldindex(self, Key)
        end)
        setreadonly(GameMT, true)
    end
    local UIS = game:GetService("UserInputService")
    local OnRender = game:GetService("RunService").RenderStepped
    
    local Player = game:GetService("Players").LocalPlayer
    local Character = Player.Character or Player.CharacterAdded:Wait()
    
    local Camera = workspace.CurrentCamera
    local Root = Character:WaitForChild("HumanoidRootPart")
    
    local C1, C2, C3;
    local Nav = {Flying = false, Forward = false, Backward = false, Left = false, Right = false}
    C1 = UIS.InputBegan:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.Keyboard then
            if Input.KeyCode == Enum.KeyCode.E then
                Nav.Flying = not Nav.Flying
                Root.Anchored = Nav.Flying
            elseif Input.KeyCode == Enum.KeyCode.W then
                Nav.Forward = true
            elseif Input.KeyCode == Enum.KeyCode.S then
                Nav.Backward = true
            elseif Input.KeyCode == Enum.KeyCode.A then
                Nav.Left = true
            elseif Input.KeyCode == Enum.KeyCode.D then
                Nav.Right = true
            end
        end
    end)
    
    C2 = UIS.InputEnded:Connect(function(Input)
        if Input.UserInputType == Enum.UserInputType.Keyboard then
            if Input.KeyCode == Enum.KeyCode.W then
                Nav.Forward = false
            elseif Input.KeyCode == Enum.KeyCode.S then
                Nav.Backward = false
            elseif Input.KeyCode == Enum.KeyCode.A then
                Nav.Left = false
            elseif Input.KeyCode == Enum.KeyCode.D then
                Nav.Right = false
            end
        end
    end)
    
    C3 = Camera:GetPropertyChangedSignal("CFrame"):Connect(function()
        if Nav.Flying then
            Root.CFrame = CFrame.new(Root.CFrame.Position, Root.CFrame.Position + Camera.CFrame.LookVector)
        end
    end)
    
    while true do
        local Delta = OnRender:Wait()
        if Nav.Flying then
            if Nav.Forward then
                Root.CFrame = Root.CFrame + (Camera.CFrame.LookVector * (Delta * Speed))
            end
            if Nav.Backward then
                Root.CFrame = Root.CFrame + (-Camera.CFrame.LookVector * (Delta * Speed))
            end
            if Nav.Left then
                Root.CFrame = Root.CFrame + (-Camera.CFrame.RightVector * (Delta * Speed))
            end
            if Nav.Right then
                Root.CFrame = Root.CFrame + (Camera.CFrame.RightVector * (Delta * Speed))
            end
        end
    end
 end)
MovementSection:NewSlider("16 Speed", "Increases your movement", function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
 end)

MovementSection:NewSlider("50 Speed", "Increases your movement", function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 50
 end)

MovementSection:NewSlider("100 Speed", "Increases your movement", function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 100
 end)

MovementSection:NewSlider("200 Speed", "Increases your movement", function()
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 200
 end)

MovementSection:NewSlider("JumpPower", "Increases your jumppower", 500, 50, function(v)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = (v)
 end)

MovementSection:NewButton("CtrlClickTP", "Press Ctrl+Click to TP", function()
    local Plr = game:GetService("Players").LocalPlayer
local Mouse = Plr:GetMouse()

Mouse.Button1Down:connect(function()
if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then return end
if not Mouse.Target then return end
Plr.Character:MoveTo(Mouse.Hit.p)
end)
 end)

local Tab = Window:NewTab("Other Scripts")

local ScriptsSection = Tab:NewSection("Scripts")

ScriptsSection:NewButton("Hydroxide", "Loads Hydroxide", function()
    local owner = "Upbolt"
local branch = "revision"

local function webImport(file)
    return loadstring(game:HttpGetAsync(("https://raw.githubusercontent.com/%s/Hydroxide/%s/%s.lua"):format(owner, branch, file)), file .. '.lua')()
end

webImport("init")
webImport("ui/main")
 end)

ScriptsSection:NewButton("EngoSpy", "Loads EngoSpy", function()
    local settings = {
        saveCalls = false,
        maxCallsSaved = 1000,
        saveOnlyLastCall = true,
        maxTableDepth = 100,
        minimizeBind = Enum.KeyCode.RightAlt,
        blacklistedNames = {}
     }
     loadstring(game:HttpGet("https://raw.githubusercontent.com/joeengo/engospy/main/source.lua"))(settings)
 end)

local Tab = Window:NewTab("Misc")

local MiscSection = Tab:NewSection("Misc")

MiscSection:NewButton("Enable ShiftLock mode", "Enables shiftlock mode on games which have shiftlock disabled", function()
    game:GetService('Players').LocalPlayer.DevEnableMouseLock = true
 end)

MiscSection:NewButton("Disable Shift lock ", "Disable Shift lock", function()
    game:GetService('Players').LocalPlayer.DevEnableMouseLock = false
 end)

MiscSection:NewButton("Lagscript", "Makes you lag (Use Lagscript Disabler to disable this function)", function()
    settings().Network.IncomingReplicationLag = 100;
 end)

MiscSection:NewButton("Lagscript Disabler", "Disables Lagscript", function()
    settings().Network.IncomingReplicationLag = 0;
 end)

MiscSection:NewKeybind("Toggle UI", "Press a key to toggle the UI", Enum.KeyCode.F, function()
	Library:ToggleUI()
 end)

MiscSection:NewButton("Force Respawn", "Allows you to respawn forcefully", function()
    game.Players.LocalPlayer.Character.Humanoid.Health = 0
 end)

MovementSection:NewSlider("Gravity", "Changes your Gravity", 196, 0, function(v)
    game.Workspace.Gravity = v
 end)

local ESPTab = Window:NewTab("ESP")
local ESPSection = ESPTab:NewSection("ESP")

ESPSection:NewButton("Chams", "Enables chams", function()
    local dwEntities = game:GetService("Players")
local dwLocalPlayer = dwEntities.LocalPlayer 
local dwRunService = game:GetService("RunService")

local settings_tbl = {
    ESP_Enabled = true,
    ESP_TeamCheck = false,
    Chams = true,
    Chams_Color = Color3.fromRGB(196,40,28),
    Chams_Transparency = 0.1,
    Chams_Glow_Color = Color3.fromRGB(196,40,28)
}

function destroy_chams(char)

    for k,v in next, char:GetChildren() do 

        if v:IsA("BasePart") and v.Transparency ~= 1 then

            if v:FindFirstChild("Glow") and 
            v:FindFirstChild("Chams") then

                v.Glow:Destroy()
                v.Chams:Destroy() 

            end 

        end 

    end 

end

dwRunService.Heartbeat:Connect(function()

    if settings_tbl.ESP_Enabled then

        for k,v in next, dwEntities:GetPlayers() do 

            if v ~= dwLocalPlayer then

                if v.Character and
                v.Character:FindFirstChild("HumanoidRootPart") and 
                v.Character:FindFirstChild("Humanoid") and 
                v.Character:FindFirstChild("Humanoid").Health ~= 0 then

                    if settings_tbl.ESP_TeamCheck == false then

                        local char = v.Character 

                        for k,b in next, char:GetChildren() do 

                            if b:IsA("BasePart") and 
                            b.Transparency ~= 1 then
                                
                                if settings_tbl.Chams then

                                    if not b:FindFirstChild("Glow") and
                                    not b:FindFirstChild("Chams") then

                                        local chams_box = Instance.new("BoxHandleAdornment", b)
                                        chams_box.Name = "Chams"
                                        chams_box.AlwaysOnTop = true 
                                        chams_box.ZIndex = 4 
                                        chams_box.Adornee = b 
                                        chams_box.Color3 = settings_tbl.Chams_Color
                                        chams_box.Transparency = settings_tbl.Chams_Transparency
                                        chams_box.Size = b.Size + Vector3.new(0.02, 0.02, 0.02)

                                        local glow_box = Instance.new("BoxHandleAdornment", b)
                                        glow_box.Name = "Glow"
                                        glow_box.AlwaysOnTop = false 
                                        glow_box.ZIndex = 3 
                                        glow_box.Adornee = b 
                                        glow_box.Color3 = settings_tbl.Chams_Glow_Color
                                        glow_box.Size = chams_box.Size + Vector3.new(0.13, 0.13, 0.13)

                                    end

                                else

                                    destroy_chams(char)

                                end
                            
                            end

                        end

                    else

                        if v.Team == dwLocalPlayer.Team then
                            destroy_chams(v.Character)
                        end

                    end

                else

                    destroy_chams(v.Character)

                end

            end

        end

    else 

        for k,v in next, dwEntities:GetPlayers() do 

            if v ~= dwLocalPlayer and 
            v.Character and 
            v.Character:FindFirstChild("HumanoidRootPart") and 
            v.Character:FindFirstChild("Humanoid") and 
            v.Character:FindFirstChild("Humanoid").Health ~= 0 then
                
                destroy_chams(v.Character)

            end

        end

    end

end)
 end)

local CreditsTab = Window:NewTab("Credits")

local CreditsSection = CreditsTab:NewSection("Credits")

CreditsSection:NewButton("SamhithWasTaken#1874 aka myself lol", "credits to my self lol", function()
    setclipboard(tostring("SamhithWasTaken#1874"))
 end)

MiscSection:NewButton("Infinite Jump", "Allows you to jump in the air", function()
    game:GetService("UserInputService").JumpRequest:connect(function()
            game:GetService"Players".LocalPlayer.Character:FindFirstChildOfClass'Humanoid':ChangeState("Jumping")
    end)
 end)

MiscSection:NewButton("Chat Advertiser", "Spams toxic messages", function(v)
  repeat
    local args = {
        [1] = "Admit that you have a skill issue, Get gamehacks.fun! | Made by SamhithWasTaken1874",
        [2] = "All"
    }
    wait(1)
    local args = {
        [1] = "Just because your bad doesnt mean you will always stay bad, Get gamehacks.fun now! | Made by SamhithWasTaken1874",
        [2] = "All"
    }
    wait(1)
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
    wait(1)
    local args = {
        [1] = "Mad because bad? Get gamehacks.fun now! | Made by SamhithWasTaken1874",
        [2] = "All"
    }
    wait(1)
    game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(unpack(args))
until v == false
 end)

MiscSection:NewButton("Aimbot", "Locks onto a player when you right click on someone", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Samhith89492/Universal-Aimbot/main/aimbot"))()
 end)

MiscSection:NewButton("Gamepasses (for poorly made games)", "Gives you gamepasses for free", function()
    if game.CreatorType == Enum.CreatorType.User then
        game.Players.LocalPlayer.UserId = game.CreatorId
    end
    if game.CreatorType == Enum.CreatorType.Group then
        game.Players.LocalPlayer.UserId = game:GetService("GroupService"):GetGroupInfoAsync(game.CreatorId).Owner.Id
    end
 end)

MiscSection:NewButton("Hitboxes (might not work on some games)", "Extends your hitboxes", function()
    _G.HeadSize = 20
	_G.Enabled = true

	game:GetService('RunService').RenderStepped:connect(function()
		if _G.Enabled then
			for i,v in next, game:GetService('Players'):GetPlayers() do
				if v.Name ~= game:GetService('Players').LocalPlayer.Name then
					pcall(function()
						v.Character.HumanoidRootPart.Size = Vector3.new(_G.HeadSize,_G.HeadSize,_G.HeadSize)
						v.Character.HumanoidRootPart.Transparency = 10
						v.Character.HumanoidRootPart.BrickColor = BrickColor.new("Really red")
						v.Character.HumanoidRootPart.Material = "Neon"
						v.Character.HumanoidRootPart.CanCollide = false
					end)
				end
			end
		end
	end)
 end)

ESPSection:NewButton("Tracers", "Shows tracers on your screen", function()
    local lplr = game.Players.LocalPlayer
local camera = game:GetService("Workspace").CurrentCamera
local CurrentCamera = workspace.CurrentCamera
local worldToViewPoint = CurrentCamera.WorldToViewportPoint

_G.Teamcheck = false

for i,v in pairs(game.Players:GetChildren()) do
    local tracer = Drawing.new("Line")
    tracer.Visible = false
    tracer.Color = Color3.new(1,1,1)
    tracer.Transparency = 1

    function lineEsp()
        game:GetService("RunService").RenderStepped:Connect(function()
            if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= lplr and v.Character.Humanoid.Health > 0 then
                local Vector, OnScreen = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                if OnScreen then
                    tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 1)
                    tracer.To = Vector2.new(Vector.X, Vector.Y)
                    
                    if _G.Teamcheck and v.TeamColor == lplr.TeamColor then
                        tracer.Visible = false
                        else
                            tracer.Visible = true
                    end
                    else
                        tracer.Visible = false
                end
                else
                tracer.Visible = false
            end
        end)
    end
    coroutine.wrap(lineEsp)()
end

game.Players.PlayerAdded:Connect(function(v)
    local tracer = Drawing.new("Line")
    tracer.Visible = false
    tracer.Color = Color3.new(1,1,1)
    tracer.Transparency = 1

    function lineEsp()
        game:GetService("RunService").RenderStepped:Connect(function()
            if v.Character ~= nil and v.Character:FindFirstChild("Humanoid") ~= nil and v.Character:FindFirstChild("HumanoidRootPart") ~= nil and v ~= lplr and v.Character.Humanoid.Health > 0 then
                local Vector, OnScreen = camera:WorldToViewportPoint(v.Character.HumanoidRootPart.Position)
                if OnScreen then
                    tracer.From = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 1)
                    tracer.To = Vector2.new(Vector.X, Vector.Y)
                    
                    if _G.Teamcheck and v.TeamColor == lplr.TeamColor then
                        tracer.Visible = false
                        else
                            tracer.Visible = true
                    end
                    else
                        tracer.Visible = false
                end
                else
                tracer.Visible = false
            end
        end)
    end
    coroutine.wrap(lineEsp)()
end)
 end)

ESPSection:NewButton("NameTags", "Shows nametags of people from a far distance away", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Samhith89492/Universal-Aimbot/main/nametags.lua"))()
 end)

MiscSection:NewButton("Silent Aim", "Automatically tries hitting a player even when you miss your shot", function()
getgenv().SelectedPart = "Head"
getgenv().VisibiltyCheck = false
getgenv().TargetESP = false
getgenv().FOV = 1000000000
getgenv().CircleVisibility = false
getgenv().Distance = 1000000000


local Players = game:GetService("Players")
local UserInput = game:GetService("UserInputService")
local HTTP = game:GetService("HttpService")
local RunServ = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local PlaceId = game.PlaceId
local LocalPlayer = Players.LocalPlayer
local CharacterAdded
local Camera = workspace.CurrentCamera
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
PlayerGui:SetTopbarTransparency(1)
local Mouse = LocalPlayer:GetMouse()
getgenv().methodsTable = {"Ray", "Raycast", "FindPartOnRay", "FindPartOnRayWithIgnoreList", "FindPartOnRayWithWhitelist"}

local rigType = string.split(tostring(LocalPlayer.Character:WaitForChild("Humanoid").RigType), ".")[3]
local selected_teamType = "Regular"
local selected_rigType

local rigTypeR6 = {
	["Head"] = true,
	["Torso"] = true,
	["LowerTorso"] = true,
	["Left Arm"] = true,
	["Right Arm"] = true,
	["Left Leg"] = true,
	["Right Leg"] = true
}

local rigTypeR15 = {
    ["Head"] = true,
    ["UpperTorso"] = true,
    ["LowerTorso"] = true,
    ["LeftUpperArm"] = true,
    ["RightUpperArm"] = true,
    ["RightLowerArm"] = true,
    ["LeftLowerArm"] = true,
    ["LeftHand"] = true,
    ["RightHand"] = true,
    ["LeftUpperLeg"] = true,
    ["RightUpperLeg"] = true,
    ["LeftLowerLeg"] = true,
    ["RightLowerLeg"] = true,
    ["LeftFoot"] = true,
    ["RightFoot"] = true
}

local rigTypeStrucid = {
    ["LeftLowerArm"] = true,
    ["RightLowerArm"] = true,
    ["Head"] = true,
    ["LeftUpperLeg"] = true,
    ["LeftUpperLeg"] = true,
    ["RightLowerLeg"] = true,
    ["Neck"] = true,
    ["RightFoot"] = true,
    ["UpperTorso"] = true,
    ["LeftLowerLeg"] = true,
    ["LowerTorso"] = true,
    ["RightUpperLeg"] = true,
    ["LeftUpperArm"] = true,
    ["RightUpperArm"] = true
}

local rigTypeAceOfSpadez = {
	["Head"] = true,
	["LeftFoot"] = true,
	["LowerLeftArm"] = true,
	["LowerLeftLeg"] = true,
	["LowerRightArm"] = true,
	["LowerRightLeg"] = true,
	["LowerTorso"] = true,
	["RightFoot"] = true,
	["MidTorso"] = true,
	["UpperLeftArm"] = true,
	["UpperLeftLeg"] = true,
	["UpperRightArm"] = true,
	["UpperRightLeg"] = true,
	["UpperTorso"] = true,
	["LeftHandle"] = true,
	["RightHandle"] = true,
	["Shoulders"] = true,
	["Torso"] = true
}

local rigTypeStandardIssue = {
	["lowerrightleg"] = true,
	["leftforearm"] = true,
	["lowerleftleg"] = true,
	["waist"] = true,
	["Torso"] = true,
	["rightforearm"] = true,
	["Head"] = true,
}

local rigTypeRecoil = {
    ["Head"] = true,
	["LeftFoot"] = true,
	["RightFoot"] = true,
	["LeftLowerLeg"] = true,
	["LeftUpperLeg"] = true,
	["RightLowerLeg"] = true,
	["RightUpperLeg"] = true,
	["UpperTorso"] = true,
	["LowerTorso"] = true,
	["LeftUpperArm"] = true,
	["RightUpperArm"] = true,
	["LeftLowerArm"] = true,
	["RightLowerArm"] = true,
	["RightHand"] = true,
	["LeftHand"] = true
}

local rigTypePloyguns = {
    ["Head"] = true,
	["Right Forearm"] = true,
	["Right Leg"] = true,
	["Right Foreleg"] = true,
	["Left Arm"] = true,
	["Right Hand"] = true,
	["Right Foot"] = true,
	["Right Arm"] = true,
	["Left Hand"] = true,
	["Left Foreleg"] = true,
	["Left Leg"] = true,
	["Hips"] = true,
	["Torso"] = true,
	["Left Foot"] = true,
	["Mid"] = true
}

local rigTypeKineticCode = {
    ["UpperTorso"] = true,
	["Head"] = true,
	["Hips"] = true,
	["LeftArm"] = true,
	["LeftFoot"] = true,
    ["LeftHip"] = true,
    ["LeftKnuckles"] = true,
    ["LeftLeg"] = true,
    ["LeftPalm"] = true,
    ["LeftShoulder"] = true,
    ["LowerTorso"] = true,
    ["Neck"] = true,
    ["RightArm"] = true,
    ["RightFoot"] = true,
    ["RightHip"] = true,
    ["RightKnuckles"] = true,
    ["RightLeg"] = true,
    ["RightPalm"] = true,
    ["RightShoulder"] = true
}

if PlaceId == 2377868063 then
    selected_rigType = rigTypeStrucid
elseif PlaceId == 2555870920 then
    selected_rigType = rigTypeAceOfSpadez
elseif PlaceId == 388599755 then
    selected_rigType = rigTypePloyguns
elseif PlaceId == 1837257681 then
    selected_rigType = rigTypeStandardIssue
elseif PlaceId == 4651779470 then
    selected_rigType = rigTypeRecoil
    selected_teamType = "Recoil"
elseif PlaceId == 4738545896 then
    selected_rigType = rigTypeR15
    selected_teamType = "ShootOut"
elseif PlaceId == 3210442546 then
    selected_rigType = rigTypeR15
    selected_teamType = "IslandRoyale"
elseif PlaceId == 401356052 then
    selected_rigType = rigTypeKineticCode
elseif PlaceId == 983224898 then
    selected_teamType = "WildRevolvers"
    selected_rigType = rigTypeR15
elseif rigType == "R6" then
    selected_rigType = rigTypeR6
elseif rigType == "R15" then
    selected_rigType = rigTypeR15
end

print("Rig Type: " .. rigType)
print("Team Type: " .. selected_teamType)

local function teamType(player)
    if selected_teamType == "Recoil" then
        return player:FindFirstChild("GameStats").Team.Value
    elseif selected_teamType == "ShootOut" then
        if player == LocalPlayer then
            return tostring(BrickColor.new(0.172549, 0.329412, 1))
        else
            for _, Player in next, Players:GetPlayers() do
                if Player.Character then
                    if Player.Character:FindFirstChild("Head") then
                        if Player.Character == player.Character then
                            if Player.Character.Head:FindFirstChild("NameTag") then
                                NameTag = Player.Character.Head.NameTag.TextLabel
                                if string.find(tostring(BrickColor.new(NameTag.TextColor3)), "red") then
                                    return tostring(BrickColor.new(NameTag.TextColor3))
                                elseif string.find(tostring(BrickColor.new(NameTag.TextStrokeColor3)), "blue") then
                                    return tostring(BrickColor.new(NameTag.TextStrokeColor3))
                                end
                            end
                        end
                    end
                end
            end
        end
    elseif selected_teamType == "IslandRoyale" then
        return player:FindFirstChild("TeamName").Value
    elseif selected_teamType == "WildRevolvers" then
        if player == LocalPlayer then
            return tostring(BrickColor.new(0, 255, 0))
        else
            for _, Player in next, game.Players:GetPlayers() do
                if Player.Character then
                    if Player.Character:FindFirstChild("Head") then
                        if Player.Character == player.Character then
                            return tostring(BrickColor.new(Player.Character.Head.HeadTag.Label.TextColor3))
                        end
                    end
                end
            end
        end
    else
        if player.Team or player.TeamColor then
            local teamplayer = player.Team or player.TeamColor
            return teamplayer
        end
    end
end

local function characterType(player)
    if player.Character or workspace:FindFirstChild(player.Name) then
        local playerCharacter = player.Character or workspace:FindFirstChild(player.Name)
        return playerCharacter
    end
end

local function FFA()
    sameTeam = 0
    for _, player in next, Players:GetPlayers() do
        if teamType(player) == teamType(LocalPlayer) then
            sameTeam = sameTeam + 1
        end
    end
    if sameTeam == #Players:GetChildren() then
        return true
    else
        return false
    end
end

local function returnVisibility(player)
    if getgenv().VisibiltyCheck then
        if characterType(player) then 
            if player.Character:FindFirstChild(getgenv().SelectedPart) then 
                CastPoint = {LocalPlayer.Character[getgenv().SelectedPart].Position, player.Character[getgenv().SelectedPart].Position}
                IgnoreList = {player.Character, LocalPlayer.Character}
                local castpointparts = workspace.CurrentCamera:GetPartsObscuringTarget(CastPoint, IgnoreList)
                if unpack(castpointparts) then
                    return false
                end
            end
        end
    end
    return true
end

local function returnRay(args, hit)
    if PlaceId == 2377868063 then
        args[3] = {workspace.IgnoreThese, LocalPlayer.Character, workspace.BuildStuff, workspace.Map}
        return args[3]
    elseif PlaceId == 625364452 then
        return hit, hit.Position, Vector3.new(0, 0, 0), hit.Material
    else
        CCF = Camera.CFrame.p
        args[2] = Ray.new(CCF, (hit.Position + Vector3.new(0,(CCF-hit.Position).Magnitude/getgenv().Distance,0) - CCF).unit * (getgenv().Distance * 10))
        return args[2]
    end
end

print("FFA: " .. tostring(FFA()))
print("Visibility Check: " .. tostring(getgenv().VisibiltyCheck))
print("Target ESP: " .. tostring(getgenv().VisibiltyCheck))

local function createBox(player)
	local lines = Instance.new("Frame")
	lines.Name = player.Name
	lines.BackgroundTransparency = 1
	lines.AnchorPoint = Vector2.new(0.5,0.5)
	
	local outlines = Instance.new("Folder", lines)
	outlines.Name = "outlines"
	local inlines = Instance.new("Folder", lines)
	inlines.Name = "inlines"
	
	local outline1 = Instance.new("Frame", outlines)
	outline1.Name = "left"
	outline1.BorderSizePixel = 0
	outline1.BackgroundColor3 = Color3.new(0,0,0)
	outline1.Size = UDim2.new(0,-1,1,0)
	
	local outline2 = Instance.new("Frame", outlines)
	outline2.Name = "right"
	outline2.BorderSizePixel = 0
	outline2.BackgroundColor3 = Color3.new(0,0,0)
	outline2.Position = UDim2.new(1,0,0,0)
	outline2.Size = UDim2.new(0,1,1,0)
	
	local outline3 = Instance.new("Frame", outlines)
	outline3.Name = "up"
	outline3.BorderSizePixel = 0
	outline3.BackgroundColor3 = Color3.new(0,0,0)
	outline3.Size = UDim2.new(1,0,0,-1)
	
	local outline4 = Instance.new("Frame", outlines)
	outline4.Name = "down"
	outline4.BorderSizePixel = 0
	outline4.BackgroundColor3 = Color3.new(0,0,0)
	outline4.Position = UDim2.new(0,0,1,0)
	outline4.Size = UDim2.new(1,0,0,1)
	
	local inline1 = Instance.new("Frame", inlines)
	inline1.Name = "left"
	inline1.BorderSizePixel = 0
	inline1.Size = UDim2.new(0,1,1,0)
	
	local inline2 = Instance.new("Frame", inlines)
	inline2.Name = "right"
	inline2.BorderSizePixel = 0
	inline2.Position = UDim2.new(1,0,0,0)
	inline2.Size = UDim2.new(0,-1,1,0)
	
	local inline3 = Instance.new("Frame", inlines)
	inline3.Name = "up"
	inline3.BorderSizePixel = 0
	inline3.Size = UDim2.new(1,0,0,1)
	
	local inline4 = Instance.new("Frame", inlines)
	inline4.Name = "down"
	inline4.BorderSizePixel = 0
	inline4.Position = UDim2.new(0,0,1,0)
	inline4.Size = UDim2.new(1,0,0,-1)
	
	local text = Instance.new("TextLabel")
	text.Name = "nametag"
	text.Position =  UDim2.new(0.5,0,0,-9)
	text.Size = UDim2.new(0,100,0,-20)
	text.AnchorPoint = Vector2.new(0.5,0.5)
	text.BackgroundTransparency = 1
	text.TextColor3 = Color3.new(1,1,1)
	text.Font = Enum.Font.Code
	text.TextSize = 16
	text.TextStrokeTransparency = 0
	
	for _,v in pairs(inlines:GetChildren()) do
		v.BackgroundColor3 = Color3.fromRGB(255, 74, 74)
	end
	
	return lines
end

local function updateEsp(player, folder)
    RunServ:BindToRenderStep("Get_Target_ESP", 1, function()
        local playerCharacter = characterType(player)
        local xMin = Camera.ViewportSize.X
        local yMin = Camera.ViewportSize.Y
        local xMax = 0
        local yMax = 0
        if returnVisibility(player) and teamType(player) ~= teamType(LocalPlayer) or FFA() and returnVisibility(player) then
            if player ~= LocalPlayer and player == getTarget() and playerCharacter and playerCharacter:FindFirstChild("Humanoid") and playerCharacter.Humanoid.Health > 0 then
                local box = folder
                local _, onScreen = Camera:WorldToScreenPoint(playerCharacter[getgenv().SelectedPart].Position)
                if onScreen and box then
                    box.Visible = true
                    local function getCorners(obj, size)
                        local corners = {
                            Vector3.new(obj.X+size.X/2, obj.Y+size.Y/2, obj.Z+size.Z/2);
                            Vector3.new(obj.X-size.X/2, obj.Y+size.Y/2, obj.Z+size.Z/2);
                            
                            Vector3.new(obj.X-size.X/2, obj.Y-size.Y/2, obj.Z-size.Z/2);
                            Vector3.new(obj.X+size.X/2, obj.Y-size.Y/2, obj.Z-size.Z/2);
                            
                            Vector3.new(obj.X-size.X/2, obj.Y+size.Y/2, obj.Z-size.Z/2);
                            Vector3.new(obj.X+size.X/2, obj.Y+size.Y/2, obj.Z-size.Z/2);
                            
                            Vector3.new(obj.X-size.X/2, obj.Y-size.Y/2, obj.Z+size.Z/2);
                            Vector3.new(obj.X+size.X/2, obj.Y-size.Y/2, obj.Z+size.Z/2);
                        }
                        return corners
                    end
                    local cornerCount = 1
                    local allCorners = {}
                    for _, bodyPart in next, playerCharacter:GetChildren() do
                        if selected_rigType[bodyPart.Name] then
                            local fetchCorners = getCorners(bodyPart.CFrame, bodyPart.Size)
                            for _, corner in next, fetchCorners do
                                table.insert(allCorners, cornerCount, corner)
                                cornerCount = cornerCount + 1
                            end
                        end
                    end
                    for _, corner in next, allCorners do
                        local pos = Camera:WorldToScreenPoint(corner)
                        if pos.X > xMax then
                            xMax = pos.X
                        end
                        if pos.X < xMin then
                            xMin = pos.X
                        end
                        if pos.Y > yMax then
                            yMax = pos.Y
                        end
                        if pos.Y < yMin then
                            yMin = pos.Y
                        end
                    end
                    local xSize = xMax - xMin
                    local ySize = yMax - yMin
                    box.Position = UDim2.new(0,xMin+(Vector2.new(xMax,0)-Vector2.new(xMin,0)).magnitude/2,0,yMin+(Vector2.new(0,yMax)-Vector2.new(0,yMin)).magnitude/2)
                    box.Size = UDim2.new(0,xSize,0,ySize)
                end
            end
        end
    end)
end

spawn(function()
    repeat
        for Hue = 0,1,0.003 do
            getgenv().Rainbow = Color3.fromHSV(Hue,1,1)
            wait()
        end
    until false
end)

spawn(function()
    local Circle = Drawing.new('Circle')
    Circle.Transparency = 1
    Circle.Thickness = 1.5
    Circle.Visible = true
    Circle.Color = Color3.fromRGB(255,0,0)
    Circle.Filled = false
    Circle.Radius = getgenv().FOV

    local TargetText = Drawing.new("Text")
    getgenv().SelectedTarget = ""
    TargetText.Text = ""
    TargetText.Size = 17
    TargetText.Center = true
    TargetText.Visible = true
    TargetText.Color = Color3.fromRGB(255,0,0)
    TargetText.Font = Drawing.Fonts.Monospace

    local lineX = Drawing.new("Line")
    lineX.Transparency = 1
    lineX.Thickness = 1.5
    lineX.Visible = true
    lineX.Color = Color3.fromRGB(255,0,0)

    local lineY = Drawing.new("Line")
    lineX.Transparency = 1
    lineY.Thickness = 1.5
    lineY.Visible = true
    lineY.Color = Color3.fromRGB(255,0,0)

    RunServ:BindToRenderStep("Get_Fov",1,function()
        local Length = 10
        local Middle = 37
        Circle.Visible = getgenv().CircleVisibility
        TargetText.Visible = getgenv().CircleVisibility
        lineX.Visible = getgenv().CircleVisibility
        lineY.Visible = getgenv().CircleVisibility 
        Circle.Color = getgenv().Rainbow
        lineX.Color = getgenv().Rainbow
        lineY.Color = getgenv().Rainbow
	Circle.Radius = getgenv().FOV
        Circle.Position = Vector2.new(Mouse.X,Mouse.Y+Middle)
        TargetText.Position = Vector2.new(Mouse.X,Mouse.Y+Middle-180)
        lineX.From = Vector2.new((Mouse.X)+Length+1,Mouse.Y-0.5+Middle)
        lineX.To = Vector2.new(Mouse.X-Length,Mouse.Y-0.5+Middle)
        lineY.From = Vector2.new(Mouse.X,Mouse.Y+Length+Middle)
        lineY.To = Vector2.new(Mouse.X,Mouse.Y-Length+Middle)
        TargetText.Text = getgenv().SelectedTarget
    end)
end)

function getTarget()
	local closestTarg = math.huge
	local Target = nil

	for _, Player in next, Players:GetPlayers() do
        if Player ~= LocalPlayer and returnVisibility(Player) and teamType(Player) ~= teamType(LocalPlayer) or FFA() and Player ~= LocalPlayer and returnVisibility(Player) then
            local playerCharacter = characterType(Player)
            if playerCharacter then
                local playerHumanoid = playerCharacter:FindFirstChild("Humanoid")
                local playerHumanoidRP = playerCharacter:FindFirstChild(getgenv().SelectedPart)
                if playerHumanoidRP and playerHumanoid then
                    local hitVector, onScreen = Camera:WorldToScreenPoint(playerHumanoidRP.Position)
                    if onScreen and playerHumanoid.Health > 0 then
                        local CCF = Camera.CFrame.p
                        if workspace:FindPartOnRayWithIgnoreList(Ray.new(CCF, (playerHumanoidRP.Position-CCF).unit * getgenv().Distance),{Player}) then
                            local hitTargMagnitude = (Vector2.new(Mouse.X, Mouse.Y) - Vector2.new(hitVector.X, hitVector.Y)).magnitude
                            if hitTargMagnitude < closestTarg and hitTargMagnitude <= getgenv().FOV then
                                Target = Player
                                closestTarg = hitTargMagnitude
                            end
                        else
                        end
                    else
                    end
                end
            end
		end
	end
	return Target
end

local mt = getrawmetatable(game)
setreadonly(mt, false)
local index = mt.__index
local namecall = mt.__namecall
local hookfunc

mt.__namecall = newcclosure(function(...)
    local method = getnamecallmethod()
    local args = {...}
    for _, rayMethod in next, getgenv().methodsTable do
        if tostring(method) == rayMethod and Hit then
            returnRay(args, Hit)
            return namecall(unpack(args))
        end
    end
    return namecall(unpack(args))
end)

mt.__index = newcclosure(function(func, idx)
    if func == Mouse and tostring(idx) == "Hit" and Hit then
        return Hit.CFrame
    end
    return index(func, idx)
end)

hookfunc = hookfunction(workspace.FindPartOnRayWithIgnoreList, function(...)
    local args = {...}
    if Hit then
        if PlaceId == 625364452 then
            return returnRay(args, Hit)
        else
            returnRay(args, Hit)
        end
    end
    return hookfunc(unpack(args))
end)

fovVal = Instance.new("ObjectValue", game)
fovVal.Changed:Connect(function(player)
    if CoreGui:FindFirstChild("Get_ESP", true) then
        RunServ:UnbindFromRenderStep("Get_Target_ESP")
        CoreGui["Get_ESP"].Folder:ClearAllChildren()
    else
        local ScreenGui = Instance.new("ScreenGui", CoreGui) 
        ScreenGui.Name = "Get_ESP"
        Instance.new("Folder", ScreenGui)
    end
    for _, Player in next, Players:GetPlayers() do
        if Player == player and Player.Character.Humanoid.Health > 0 and getgenv().TargetESP then
            wait()
            espBox = createBox(Player)
            updateEsp(Player, espBox)
            espBox.Parent = CoreGui["Get_ESP"].Folder
        end
    end
end)

RunServ:BindToRenderStep("Get_Target",1,function()
    local Target = getTarget()
    if not Target then
        Hit = nil
        getgenv().SelectedTarget = ""
        fovVal.Value = nil
    else
        getgenv().SelectedTarget = Target.Name .. "\n" .. math.floor((LocalPlayer.Character[getgenv().SelectedPart].Position - Target.Character[getgenv().SelectedPart].Position).magnitude) .. " Studs"
        fovVal.Value = Target
    end
    if UserInput:IsMouseButtonPressed(0) then
        if Target then
            Hit = Target.Character[getgenv().SelectedPart]
        end
    else
        Hit = nil
    end
end)

warn("Loaded!")
 end)

 local QOLTab = Window:NewTab("Sky")

 local QOLSection = QOLTab:NewSection("Sky")
 
QOLSection:NewButton("Night Sky", "Sets the sky to night time", function()
     game.Lighting.TimeOfDay = 24
     game.Lighting.FogEnd = 1000
     game.Lighting.Brightness = 0
 end)

QOLSection:NewButton("Night Sky V2", "Night sky v2 (added visibility lol)", function()
     game.Lighting.TimeOfDay = 24
     game.Lighting.FogEnd = 1000
     game.Lighting.Brightness = 10
 end)
 
QOLSection:NewButton("Full bright", "makes it bright (good for horror games)", function()
     game.Lighting.TimeOfDay = 10
     game.Lighting.FogEnd = 1000
     game.Lighting.Brightness = 0
 end)

QOLSection:NewButton("120 FOV ", "Sets FOV to 120", function()
    game:GetService'Workspace'.Camera.FieldOfView = 120
 end)

QOLSection:NewButton("70 FOV ", "Sets FOV to 70 (default)", function()
    game:GetService'Workspace'.Camera.FieldOfView = 70
 end)

QOLSection:NewButton("FPS Booster", "Boosts your fps", function()
    for _,v in pairs(workspace:GetDescendants()) do
        if v.ClassName == "Part"
        or v.ClassName == "SpawnLocation"
        or v.ClassName == "WedgePart"
        or v.ClassName == "Terrain"
        or v.ClassName == "MeshPart" then
        v.Material = "Plastic"
        end
        end
 end)

QOLSection:NewButton("FPS Booster V2", "Boosts your fps", function()
    local decalsyeeted = true -- Leaving this on makes games look shitty but the fps goes up by at least 20.
    local g = game
    local w = g.Workspace
    local l = g.Lighting
    local t = w.Terrain
    t.WaterWaveSize = 0
    t.WaterWaveSpeed = 0
    t.WaterReflectance = 0
    t.WaterTransparency = 0
    l.GlobalShadows = false
    l.FogEnd = 9e9
    l.Brightness = 0
    settings().Rendering.QualityLevel = "Level01"
    for i, v in pairs(g:GetDescendants()) do
        if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
            v.Material = "Plastic"
            v.Reflectance = 0
        elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
            v.Transparency = 1
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Lifetime = NumberRange.new(0)
        elseif v:IsA("Explosion") then
            v.BlastPressure = 1
            v.BlastRadius = 1
        elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
            v.Enabled = false
        elseif v:IsA("MeshPart") then
            v.Material = "Plastic"
            v.Reflectance = 0
            v.TextureID = 10385902758728957
        end
    end
    for i, e in pairs(l:GetChildren()) do
        if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
            e.Enabled = false
        end
    end
     end)
QOLSection:NewButton("Rejoin", "Rejoins the game", function()
    game:GetService'TeleportService':TeleportToPlaceInstance(game.PlaceId,game.JobId,game:GetService'Players'.LocalPlayer)
 end)

MiscSection:NewButton("ChatSlow", "Makes the chat slow ", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/Samhith89492/Universal-Aimbot/main/chatslow"))()
 end)




    