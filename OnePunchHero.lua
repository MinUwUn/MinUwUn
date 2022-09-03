local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Player = game.Players.LocalPlayer
local Window = OrionLib:MakeWindow({Name = "Key System", HidePremium = false, SaveConfig = true, IntroText = "KeySystem"})

OrionLib:MakeNotification({
	Name = "Logged in!",
	Content = "You're logged in as" ..Player.Name.." ",
	Image = "rbxassetid://4483345998",
	Time = 5
})

_G.Key = "Beeely"
_G.KeyInput = "string"

function CorrectKeyNotification()
    OrionLib:MakeNotification({
        Name = "Correct Key!",
        Content = "You Sucessfully Entered The Right Key",
        Image = "rbxassetid://4483345998",
        Time = 5
    })
end

function IncorrectKeyNotification()
    OrionLib:MakeNotification({
        Name = "Incorrect Key!",
        Content = "You Entered The Wrong Key Mate, Try Again",
        Image = "rbxassetid://4483345998",
        Time = 5
    })
end

local Tab = Window:MakeTab({
	Name = "Key",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab:AddTextbox({
	Name = "Enter Key",
	Default = "",
	TextDisappear = true,
	Callback = function(Value)
        _G.KeyInput = Value
	end	  
})

Tab:AddButton({
	Name = "Check Key",
	Callback = function()
      		if _G.KeyInput == _G.Key then
            CorrectKeyNotification()
            local mobs = {} 
            local quests={}
getgenv().quest = nil
getgenv().mob = nil 

-- MOBS
for _,v in pairs(game:GetService("Workspace").NPC.Enemy:GetChildren()) do 
    insert = true 
    for _,v2 in pairs(mobs) do if v2 == v.Name then insert = false end end 
    if insert then table.insert(mobs, v.Name) end 
end

--QUESTS
for _,v3 in pairs(game:GetService("Workspace").NPC.Quest.MainQuests:GetChildren()) do
    insert = true
    for _,v4 in pairs(quests) do if v4 == v3.Name then insert = false end end
    if insert then table.insert(quests, v3.Name) end 
end

--Variables
local VirtualInputManager = game:GetService("VirtualInputManager")
local X, Y = 0, 0
local LastC = Color3.new(1, 0, 0)
local LastU = tick()

-- UI LIBRARY

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))() 
local Window = Library.CreateLib("OnePunchHero Beta By Min", "DarkTheme") 

-- MAIN
local Main = Window:NewTab("Main") 
local MobFarmSection = Main:NewSection("Mob Farm") 

local mobdropdown = MobFarmSection:NewDropdown("Choose Mob", "Chooses the mob to autofarm", mobs, function(v) 
    getgenv().mob = v
end)

MobFarmSection:NewToggle("Start Mob Farm", "Toggles the autofarming of the mobs", function(v) 
    getgenv().autofarmmobs = v
    while wait() do 
        if getgenv().autofarmmobs == false then return end 
        if getgenv().mob == nil then 
            game.StarterGui:SetCore("SendNotification", { 
                Title = "Error!", 
                Text = "You havent selected a mob with the dropdown above\nUntoggle this toggle!", 
                Icon = "", 
                Duration = 2.5 
            })
            getgenv().autofarmmobs = false 
            return 
        end
        local mob = game:GetService("Workspace").NPC.Enemy:FindFirstChild(getgenv().mob)
        if mob == nil then
            game.StarterGui:SetCore("SendNotification", { 
                Title = "Info!", 
                Text = "There is currently no spawned mobs of this type!\nJust wait until they spawn", 
                Icon = "", 
                Duration = 2.5 
            })
            while wait() do 
                wait() 
                if getgenv().autofarmmobs == false then return end 
                if game:GetService("Workspace").NPC.Enemy:FindFirstChild(getgenv().mob) ~= nil then break; end
            end 
        else
            local mob2 = mob
            while wait() do
                mob = game:GetService("Workspace").NPC.Enemy:FindFirstChild(getgenv().mob)
                if mob ~= mob2 then break; end
                if getgenv().autofarmmobs == false then return end 
                if mob ~= nil then
                    if mob:FindFirstChild("Humanoid") then
                        if mob.Humanoid.Health == 0 then wait(0.1) mob:Destroy() break; end 
                    end
                    if mob:FindFirstChild("HumanoidRootPart") then
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0,6,0) 
                    end
                end
                wait() 
            end
        end
    end
end)



game:GetService("Workspace").NPC.Enemy.ChildAdded:Connect(function() 
    for _,v2 in pairs(mobs) do table.remove(mobs, _) end 
    
    for _,v in pairs(game:GetService("Workspace").NPC.Enemy:GetChildren()) do 
        insert = true 
        for _,v2 in pairs(mobs) do if v2 == v.Name then insert = false end end 
        if insert then table.insert(mobs, v.Name) end 
    end
    mobdropdown:Refresh(mobs)
end)

game:GetService("Workspace").NPC.Enemy.ChildRemoved:Connect(function() 
    for _,v2 in pairs(mobs) do table.remove(mobs, _) end 
    
    for _,v in pairs(game:GetService("Workspace").NPC.Enemy:GetChildren()) do 
        insert = true 
        for _,v2 in pairs(mobs) do if v2 == v.Name then insert = false end end 
        if insert then table.insert(mobs, v.Name) end 
    end
    mobdropdown:Refresh(mobs)
end)

local AutoClicker = Main:NewSection("Autoclick") 

AutoClicker:NewButton("Start The AutoClicker", "Toggles the AutoClicker", function(v) 

    _G.loop = true

while _G.loop do
        local A_1 = "Mouse1"
        local A_2 = "Begin"
        local A_3 = CFrame.new(-458.539276, 13.8596563, 417.49707, -0.95966351, -0.0135538923, 0.280824453, -0, 0.998837411, 0.048208531, -0.281151325, 0.0462639667, -0.958547711)
        local A_4 = game:GetService("Workspace").Map["City-A"].Terrain.Grass
        local Event = game:GetService("ReplicatedStorage").Events.RemoteEvents.KeyInput
        Event:FireServer(A_1, A_2, A_3, A_4)
        
        local A_1 = "Mouse1"
        local A_2 = "End"
        local A_3 = CFrame.new(-458.735352, 13.817975, 416.974304, -0.95966351, -0.0135538923, 0.280824453, -0, 0.998837411, 0.048208531, -0.281151325, 0.0462639667, -0.958547711)
        local A_4 = game:GetService("Workspace").Map["City-A"].Terrain.Grass
        local Event = game:GetService("ReplicatedStorage").Events.RemoteEvents.KeyInput
        Event:FireServer(A_1, A_2, A_3, A_4)
    wait()
    local A_1 = "Mouse1"
    local A_2 = "Begin"
    local A_3 = CFrame.new(-458.539276, 13.8596563, 417.49707, -0.95966351, -0.0135538923, 0.280824453, -0, 0.998837411, 0.048208531, -0.281151325, 0.0462639667, -0.958547711)
    local A_4 = game:GetService("Workspace").Map["City-A"].Terrain.Grass
    local Event = game:GetService("ReplicatedStorage").Events.RemoteEvents.KeyInput
    Event:FireServer(A_1, A_2, A_3, A_4)
    
    local A_1 = "Mouse1"
    local A_2 = "End"
    local A_3 = CFrame.new(-458.735352, 13.817975, 416.974304, -0.95966351, -0.0135538923, 0.280824453, -0, 0.998837411, 0.048208531, -0.281151325, 0.0462639667, -0.958547711)
    local A_4 = game:GetService("Workspace").Map["City-A"].Terrain.Grass
    local Event = game:GetService("ReplicatedStorage").Events.RemoteEvents.KeyInput
    wait()
    
    end
end)
AutoClicker:NewButton("Turn Off AutoClicker", "turn off the AutoClicker", function(v)
     _G.loop = false
    end)

local QuestSection = Main:NewSection("AutoQuest") 

local questdropdown = QuestSection:NewDropdown("Choose Quest", "Chooses the quest to autofarm", quests, function(v) 
    getgenv().quest = v
end)

QuestSection:NewToggle("Toggle AutoQuest", "Toggles the autoclaiming of the quests", function(v) 
    getgenv().autoclaimquest = v
    while wait() do 
        if getgenv().autoclaimquest == false then return end 
        if getgenv().quest == nil then 
            game.StarterGui:SetCore("SendNotification", { 
                Title = "Error!", 
                Text = "You havent selected a mob with the dropdown above\nUntoggle this toggle!", 
                Icon = "", 
                Duration = 2.5 
            })
            getgenv().autoclaimquest = false 
            return 
        end
        local quest = game:GetService("Workspace").NPC.Quest.MainQuests:FindFirstChild(getgenv().quest)
        if quest == nil then
            game.StarterGui:SetCore("SendNotification", { 
                Title = "Info!", 
                Text = "There is currently no spawned mobs of this type!\nJust wait until they spawn", 
                Icon = "", 
                Duration = 2.5 
            })
            while wait() do 
                wait() 
                if getgenv().autoclaimquest == false then return end 
                if game:GetService("Workspace").NPC.Quest.MainQuests:FindFirstChild(getgenv().quest) ~= nil then break; end
            end 
        else
local A_1 = getgenv().quest
local Event = game:GetService("ReplicatedStorage").Events.RemoteEvents.SetQuest
    wait(15)
Event:FireServer(A_1)

           
                wait() 
            end
        end
    end
)

local Teleportation = Window:NewTab("Teleportation")
local TeleportationSection = Teleportation:NewSection("Teleport") 

TeleportationSection:NewButton("Class Spin", "Spinning Class NPC", function()
	print("Clicked")
		game.Players.LocalPlayer.Character:MoveTo(Vector3.new(182.293579, 10.1856232, 228.300339, -0.999995053, -6.61268373e-09, 0.00314166886, -6.5666943e-09, 1, 1.4648748e-08, -0.00314166886, 1.46280454e-08, -0.999995053))
end)

TeleportationSection:NewButton("Item Combine", "Combine Items NPC", function()
	print("Clicked")
	game.Players.LocalPlayer.Character:MoveTo(Vector3.new(215.87999, 10.1856079, 207.032669, 0.999955535, 6.58410357e-08, 0.00942705479, -6.65296795e-08, 1, 7.27363769e-08, -0.00942705479, -7.33603258e-08, 0.999955535))
end)

TeleportationSection:NewButton("Ascend", "Ranking up NPC", function()
	print("Clicked")
	game.Players.LocalPlayer.Character:MoveTo(Vector3.new(148.66806, 10.1856146, 207.457748, 0.999506652, -5.54886803e-08, 0.0314074755, 5.28561515e-08, 1, 8.46487893e-08, -0.0314074755, -8.29469542e-08, 0.999506652))
end)

    else
                IncorrectKeyNotification()
            end
  	end    
})

Tab:AddButton({
	Name = "Ask Min For The Key",
	Callback = function()
    end
})
