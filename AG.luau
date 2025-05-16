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

local Tabs = {
    Lobby = Window:CreateTab{
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
local hum = char and char:FindFirstChildOfClass("Humanoid")
local RS = game:GetService('ReplicatedStorage')

--//Remotes
local R_Code

if game.PlaceId == 17282336195 then
    R_Code = RS:WaitForChild("PlayMode"):WaitForChild("Events"):WaitForChild("Codes")
else
    if RS:FindFirstChild("PlayMode") and RS.PlayMode:FindFirstChild("Events") and RS.PlayMode.Events:FindFirstChild("Codes") then
        R_Code = RS.PlayMode.Events.Codes
    else
        warn("Warning: PlayMode.Events.Codes not found in ReplicatedStorage for this place.")
        R_Code = nil
    end
end

if game.PlaceId ~= 17282336195 then
local PM = RS:WaitForChild('PlayMode')
local E = PM:WaitForChild('Events')
local R_V = E:WaitForChild('Vote')
local R_SC = E:WaitForChild('StageChallenge')
local R_C = E:WaitForChild('Control')
end

local codesFileUrl = "https://raw.githubusercontent.com/0017717/Hyperion/main/Resources/Codes.luau"
local CodesList = {}

local function GetCodesFromGithub()
    local success, responseBody = pcall(function()
        return game:HttpGet(codesFileUrl, true) -- Assuming game:HttpGet is provided by your exploit environment
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
        if R_Code and #CodesList > 0 then
            for _, codeValue in ipairs(CodesList) do
                R_Code:InvokeServer(codeValue)
            end
        else
            if not R_Code then
            end
            if #CodesList == 0 then
            end
        end
    end
}

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
    while task.wait(1) do
        if Options.Auto_Start.Value then
           R_V:FireServer('Vote1')
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Options.Auto_Retry.Value then
            R_C:FireServer('RetryVote')
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Options.Auto_Next.Value then
           R_C:FireServer('NextVote')
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if Options.Auto_Modifier.Value then
           R_SC:FireServer(Options.Selected_Modifier.Value)
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
