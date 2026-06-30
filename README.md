example:

```lua
--// Say wallahi bismillah bro...
--// Vortex Hub Initializing...
local Vortex = loadstring(game:HttpGet('https://raw.githubusercontent.com/emirontop1/PremiumLib/refs/heads/main/Src/source.lua'))()

local Window = Vortex.CreateWindow(
    "Your Hub Tittle",
    "Your Hub SubTittle",
    "Your Loading Tittle",
    "Your Loading SubTittle"
)

local MainTab = Window:CreateTab("Your Tab Name")

------------------------------------------------------------
-- 🛠️ NEWLY ADDED SECTION COMPONENT
------------------------------------------------------------
local VisualSection = MainTab:CreateSection("Visual Elements")

local status = false 

local MyParagraph = MainTab:CreateParagraph(
    "Text", 
    "Text But this one" 
)

local MyTextBox = MainTab:CreateTextBox(
    "My Textbox Name",
    "Hello My broski", 
    function(txt)
        print(txt)
    end
)

local MyToggle = MainTab:CreateToggle("God Mode Status", false, function(state)
    print(state)
    status = state 
end)

local MyButton = MainTab:CreateButton("Update All Elements Dynamically", function() 
    print("Clicked MyButton")
end)

------------------------------------------------------------
-- 🛠️ NEWLY ADDED SUB-TAB COMPONENT
------------------------------------------------------------
local SubSystem = MainTab:CreateSubTabContainer()

local SubTab1 = SubSystem:CreateSubTab("Weapon Settings")
local SubTabButton = SubTab1:CreateButton("Activate Aimbot", function()
    print("Aimbot triggered!")
end)

local SubTab2 = SubSystem:CreateSubTab("Other Settings")
SubTab2:CreateToggle("Speed Hack", false, function(state)
    print("Speed: ", state)
end)

------------------------------------------------------------
-- DYNAMIC MODIFIER BUTTON
------------------------------------------------------------
local MySetThinksButton = MainTab:CreateButton("Set Name,Status etc", function() 
    local newstatus = not status
    
    -- Element Updates
    MyParagraph:SetText("Status: COMPLETE!" .. tostring(math.random(1,10000)), "All parameters successfully verified by the core engine." .. tostring(math.random(1,10000)))
    MyButton:SetTitle("Random number" .. tostring(math.random(1,10000)))
    MyTextBox:SetText(tostring(math.random(1,10000))) 
    MyToggle:SetText("İdk" .. tostring(math.random(1,10000)))
    MyToggle:SetState(newstatus)
    
    -- Window Updates
    Window:SetTitle("VORTEX PREMIUM random number:" .. tostring(math.random(1,10000)))
    Window:SetSubtitle("This:" .. tostring(math.random(1,10000)))    
    
    -- Section Title Update
    VisualSection:SetTitle("Updated Section:" .. tostring(math.random(1,10000)))
    
    -- Sub-Tab Title Update
    SubTab1:SetTitle("Rifles " .. tostring(math.random(1,10)))

    -- Runtime Dynamic Tab Creation
    local randomTabName = "Dynamic Tab " .. tostring(math.random(1,100))
    local NewCreatedTab = Window:CreateTab(randomTabName)
    NewCreatedTab:CreateParagraph("New Tab Panel", "This tab was created during runtime via button execution.")
end)




```



good luck... u can edit and make ur own.
