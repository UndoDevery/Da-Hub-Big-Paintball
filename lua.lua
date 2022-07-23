--First opened source script

local Sound = Instance.new("Sound")
Sound.Parent = game.StarterGui
Sound.SoundId = "rbxassetid://6958727243";
Sound.Volume = "5";
Sound:Play() 

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Da Hub - Big Paintball", IntroText = "Da Hub - Big Paintball", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})
local Tab = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})
Tab:AddButton({
	Name = "Unlock All Guns!",
	Callback = function()
      		local library = require(game:GetService("ReplicatedStorage").Framework.Library)
 
local env = getsenv(game:GetService("Players").LocalPlayer.PlayerScripts.Scripts.Game["First Person Controller"])
 
local unlock_all = true
 
local old_fire = library.Network.Fire
library.Network.Fire = newcclosure(function(self, ...)
   local args = {...}
 
   if unlock_all and tostring(self) == "Request Respawn" then
       args[1] = "1"
   end
 
   return old_fire(self, unpack(args))
end)
 
local old_own = env.DoesOwnGun
env.DoesOwnGun = function(...)
   return (unlock_all and true) or old_own(...)
end
 
local old_own_gun = library.GunCmds.DoesOwnGun
library.GunCmds.DoesOwnGun = newcclosure(function(self, ...)
   return (unlock_all and true) or old_own_gun(self, ...)
end)

for _, gun in next, library.Directory.Guns do
   gun["offsale"] = false
end
--
OrionLib:MakeNotification({
	Name = "Unlock All Guns",
	Content = "All guns have been unlocked.",
	Image = "rbxassetid://4483345998",
	Time = 5
})
  	end    
})

local Tab = Window:MakeTab({
	Name = "Guns",
	Icon = "rbxassetid://4483345998",
	PremiumOnly = false
})

Tab:AddButton({
	Name = "Firerate!",
	Callback = function()
      		local function modifyValue(Name, NewValue)
    for i,v in next, game:GetService('ReplicatedStorage').Framework.Modules['1 | Directory'].Guns:GetChildren() do
        for i2, v2 in next, require(v) do
            if v2[Name] then
                v2[Name] = NewValue
            end
        end
    end
end

modifyValue('firerate', 0)
modifyValue('automatic', true)
modifyValue('velocity', 10000)
OrionLib:MakeNotification({
	Name = "Firerate",
	Content = "Firerate has been activated!",
	Image = "rbxassetid://4483345998",
	Time = 5
})
  	end    
})
