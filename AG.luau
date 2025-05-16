local Library = loadstring(game:HttpGetAsync("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()
local SaveManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/SaveManager.luau"))()
local InterfaceManager = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/InterfaceManager.luau"))()
 
local Window = Library:CreateWindow{
    Title = `Hyperion`,
    SubTitle = "DETECTED",
    TabWidth = 160,
    Size = UDim2.fromOffset(830, 525),
    Resize = true,
    MinSize = Vector2.new(270, 195),
    Acrylic = false,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
}

-- Fluent Renewed provides ALL 1544 Lucide 0.469.0 https://lucide.dev/icons/ Icons and ALL 9072 Phosphor 2.1.0 https://phosphoricons.com/ Icons for the tabs, icons are optional
local Tabs = {
    Main = Window:CreateTab{
        Title = "Lobby",
        Icon = ""
    },
    Joiner = Window:CreateTab{
        Title = "Joiner",
        Icon = ""
    },
    Game = Window:CreateTab{
        Title = "Game",
        Icon = ""
    },
    Macro = Window:CreateTab{
        Title = "Macro",
        Icon = ""
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
--//Global Variables
--[[Status = {
    Lobby = {},
    Joiner = {},
    Game = {
        AS = false,
        AR = false,
        AN = false,
        AM = false,
    },
    Macro = {},
}]]

--//Remotes
local R_Code

if game.placeId == 17282336195 then
    R_Code = RS:WaitForChild("PlayMode"):WaitForChild("Events"):WaitForChild("Codes")
else
    if RS:FindFirstChild("PlayMode") and RS.PlayMode:FindFirstChild("Events") and RS.PlayMode.Events:FindFirstChild("Codes") then
        R_Code = RS.PlayMode.Events.Codes
    else
        warn("Warning: PlayMode.Events.Codes not found in ReplicatedStorage for this place.")
        R_Code = nil
    end
end

local codesFileUrl = "https://raw.githubusercontent.com/0017717/Hyperion/main/Resources/Codes.luau"
local CodesList = {}

local function GetCodesFromGithub()
    local success, responseBody = pcall(function()
        return game:HttpGet(codesFileUrl, true)
    end)
    if not success or not responseBody then
        return {}
    end
    local loadedFunction, loadError = loadstring(responseBody)
    if not loadedFunction then
        return {}
    end
    local execSuccess, resultTable = pcall(loadedFunction)
    if not execSuccess or type(resultTable) ~= "table" then
        return {}
    end
    return resultTable
end

CodesList = GetCodesFromGithub()

local Options = Library.Options

Tabs.Lobby:CreateButton{
    Title = "Redeem All Codes",
    Description = "",
    Callback = function()
        if #CodesList > 0 then
            for _, codeValue in ipairs(CodesList) do
                R_Code:InvokeServer(codeValue)
            end
        end
    end}

local AS = Tabs.Game:CreateToggle("Auto_Start", {Title = "Auto Start", Default = false })
local AR = Tabs.Game:CreateToggle("Auto_Retry", {Title = "Auto Retry", Default = false })
local AN = Tabs.Game:CreateToggle("Auto_Next", {Title = "Auto Next", Default = false })

local ChallengeSection = Tabs.Game:CreateParagraph("para1", {
    Title = "Modifiers",
    Content = ""
})
local SM = Tabs.Game:CreateDropdown("Selected_Modifier", {
    Title = "Select Modifier",
    Values = {'Fast Wave', 'Normal'},
    Multi = false,
    Default = "Normal",
})
local AM = Tabs.Game:CreateToggle("Auto_Modifier", {Title = "Auto Select Modifier", Default = false })

task.spawn(function()
    while task.wait() do
        if Options.AS.Value then
            print('Normal')
        end
    end
end)
    


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
