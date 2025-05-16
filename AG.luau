local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()
local SaveManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/SaveManager.luau"))()
local InterfaceManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/InterfaceManager.luau"))()
 
local Window = Library:CreateWindow{
    Title = `Hyperion`,
    SubTitle = "DETECTED",
    TabWidth = 160,
    Size = UDim2.fromOffset(830, 525),
    Resize = true, -- Resize this ^ Size according to a 1920x1080 screen, good for mobile users but may look weird on some devices
    MinSize = Vector2.new(270, 195),
    Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl -- Used when theres no MinimizeKeybind
}

-- Fluent Renewed provides ALL 1544 Lucide 0.469.0 https://lucide.dev/icons/ Icons and ALL 9072 Phosphor 2.1.0 https://phosphoricons.com/ Icons for the tabs, icons are optional
local Tabs = {
    Main = Window:CreateTab{
        Title = "Main",
        Icon = "phosphor-users-bold"
    },
    Settings = Window:CreateTab{
        Title = "Settings",
        Icon = "settings"
    }
}
--//Variables
local plrs = game:GetService('Players')
local plr = plrs.LocalPlayer
local char = plr.Character
local hum = char.Humanoid
local RS = game:GetService('ReplicatedStorage')

--//Remotes
local R_Code = RS:WaitForChild("PlayMode"):WaitForChild("Events"):WaitForChild("Codes")

--//Tables
--local Codes = {"MEGUMIN-SNEAK","UPD9.5-FINAL","Sry-Bugs-Newbie","FIXED_1","NewReroll","PEAK_UPD9.5","UPD9.5_PART2","30K_Member","SRYFOR_DELAY","UPD9.5_PART1","BEERUS_PEAK"}


local Options = Library.Options

Tabs.Main:CreateButton{
    Title = "Redeem All Codes",
    Description = "",
    Callback = function()
        for i, v in ipairs(Codes) do
            R_Code:InvokeServer(v)
        end
    end}


SaveManager:SetLibrary(Library)
InterfaceManager:SetLibrary(Library)

SaveManager:IgnoreThemeSettings()

SaveManager:SetIgnoreIndexes{}

--InterfaceManager:SetFolder("Hyperion")
--SaveManager:SetFolder("Hyperion/anime-guardian")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)


Window:SelectTab(1)

SaveManager:LoadAutoloadConfig()
