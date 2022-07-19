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
getgenv().mob = nil 

-- MOBS
for _,v in pairs(game:GetService("Workspace").NPC.Enemy:GetChildren()) do 
    insert = true 
    for _,v2 in pairs(mobs) do if v2 == v.Name then insert = false end end 
    if insert then table.insert(mobs, v.Name) end 
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
                        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = mob.HumanoidRootPart.CFrame * CFrame.new(0,0,2) 
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

AutoClicker:NewToggle("AutoClicker (Not Working Right Now)", "Autoclick Punch for you", function()
        -- Toggle
        Enabled = not Enabled
        -- "Enabled" Color
        local NewColor = Color3.new(0, 1, 0)
        if Enabled == false then
            NewColor = Color3.new(1, 0, 0)
        end
        if NewColor ~= Last then
            Last = NewColor
            Enabled_1:SetColor(NewColor)
        end
        -- Click Position
        if Enabled then
            -- Update Mouse Pos
            X, Y = Mouse.X, Mouse.Y + 10
            -- Update Box
            Box_1:SetValue()
        else
            X, Y = 0, 0
            Box_1:SetValue()
        end
        -- AutoClick
        while Enabled do
            VirtualInputManager:SendMouseButtonEvent(X, Y, 0, true, game, 1)
            VirtualInputManager:SendMouseButtonEvent(X, Y, 0, false, game, 1)
            wait(Library.flags.Interval)
        end
    end
)

local AutoQuest = Main:NewSection("AutoQuest")

AutoQuest:NewToggle("Auto Quest (Not Working)", "Auto Quest For Mobs", function(value) 
    getgenv().AutoQuest = value
   
   while getgenv().AutoQuest and wait() do
   pcall(function()
   for i,v in pairs(game:GetService("Workspace").NPC:GetChildren()) do
       if game:GetService("Players").LocalPlayer.PlayerGui.MainUI:FindFirstChild("QuestsFrame") then
           if not game:GetService("Players").LocalPlayer.PlayerGui.MainUI.QuestsFrame:FindFirstChild(getgenv().Quest) then wait(2)
                           game:GetService("ReplicatedStorage").Events.SetQuest:FireServer(getgenv().Quest)
                       end;
                   end;
               end;
           end);
       end;
   end)

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

TeleportationSection:NewButton("First Quest", "Thug Quest [Level 0]", function()
    print("Clicked")
    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-2.15715671, 9.97867393, 38.7685204, -0.999955535, -7.52698082e-09, 0.0094284676, -8.34633873e-09, 1, -8.68631602e-08, -0.0094284676, -8.69379946e-08, -0.999955535))
end)

TeleportationSection:NewButton("Second Quest", "Armored Thug [Level 10]", function()
    print("Clicked")
    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-275.679932, 9.34042454, -35.3361549, -0.999822319, -8.35453395e-09, -0.018851174, -7.59057084e-09, 1, -4.05976088e-08, 0.018851174, -4.04473042e-08, -0.999822319))
end)
TeleportationSection:NewButton("Third Quest", "Thug Leader [Level 20]", function()
    print("Clicked")
    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-388.308044, 9.90445232, 262.823456, -0.999955654, -5.033582e-09, 0.00941920094, -5.12644061e-09, 1, -9.83427295e-09, -0.00941920094, -9.88212356e-09, -0.999955654))
end)
TeleportationSection:NewButton("Fourth Quest", "Paridaisers [Level 30]", function()
    print("Clicked")
    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-176.231445, 9.90354061, 365.668579, -0.0188342407, 5.96905494e-08, -0.999822617, -3.58809843e-10, 1, 5.97078937e-08, 0.999822617, 1.48329915e-09, -0.0188342407))
end)
TeleportationSection:NewButton("Fifth Quest", "Angered Paridaisers [Level 40]", function()
    print("Clicked")
    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(345.170349, 9.90318871, -26.6733799, 0.010713039, -5.71610457e-08, 0.999942601, -7.49096785e-09, 1, 5.72445806e-08, -0.999942601, -8.10380119e-09, 0.010713039))
end)
TeleportationSection:NewButton("Sixth Quest", "Sea Folks [Level 50]", function()
    print("Clicked")
    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(-275.679932, 9.34042454, -35.3361549, -0.999822319, -8.35453395e-09, -0.018851174, -7.59057084e-09, 1, -4.05976088e-08, 0.018851174, -4.04473042e-08, -0.999822319))
end)
TeleportationSection:NewButton("Seventh Quest", "Hammer Skull [Level 60]", function()
    print("Clicked")
    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(342.419647, 10.1126709, 313.134918, -0.0502356328, -6.79933976e-08, -0.998737395, -4.0432302e-09, 1, -6.78759875e-08, 0.998737395, 6.28331998e-10, -0.0502356328))
end)
TeleportationSection:NewButton("Eighth Quest", "Dark Sea Folks [Level 70]", function()
    print("Clicked")
    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(762.364197, 9.90466499, 519.99823, -0.999980152, 5.34068967e-08, -0.00630199676, 5.36056461e-08, 1, -3.1368721e-08, 0.00630199676, -3.17059232e-08, -0.999980152))
end)
TeleportationSection:NewButton("Nineth Quest", "Sea King [Level 100]", function()
    print("Clicked")
    game.Players.LocalPlayer.Character:MoveTo(Vector3.new(567.708923, 7.10109901, 739.924683, -0.913967013, 2.35637625e-08, -0.405788422, 2.96214093e-08, 1, -8.64792682e-09, 0.405788422, -1.99239452e-08, -0.913967013))
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
