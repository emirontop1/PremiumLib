example:

```lua
--// Vortex Hub Başlatılıyor...
local Vortex = loadstring(game:HttpGet('https://raw.githubusercontent.com/emirontop1/PremiumLib/refs/heads/main/Src/source.lua'))()

local Window = Vortex.CreateWindow(
    "Your Hub Tittle",
    "Your Hub SubTittle",
    "Your Loading Tittle",
    "Your Loading SubTittle" -- Tırnak hatası düzeltildi
)

local MainTab = Window:CreateTab("Your Tab Name")

-- Durumu takip etmek için değişkeni global/local scope olarak dışarıda tanımlıyoruz
local status = false 

-- Elemanları değişkenlere kaydediyoruz
local MyParagraph = MainTab:CreateParagraph(
    "Text", -- Başlık (Title)
    "Text But this one" -- Açıklama (Description)
)

local MyTextBox = MainTab:CreateTextBox(
    "My Textbox Name",
    "Hello My broski", -- Default text
    function(txt)
        print(txt)
    end
)

local MyToggle = MainTab:CreateToggle("God Mode Status", false, function(state)
    print(state)
    status = state -- Dışarıdaki status değişkenini güncelliyor
end)

local MyButton = MainTab:CreateButton("Update All Elements Dynamically", function() 
    print("Clicked MyButton")
end)

local MySetThinksButton = MainTab:CreateButton("Set Name,Status etc", function() 
    local newstatus
    if status == true then
        newstatus = false
    else
        newstatus = true
    end 
    
    -- Büyük/küçük harf hatası düzeltildi (MyParagraph)
    MyParagraph:SetText("Status: COMPLETE!" .. tostring(math.random(1,10000)), "All parameters successfully verified by the core engine." .. tostring(math.random(1,10000)))
    
    MyTextBox:SetText(tostring(math.random(1,10000))) 
    MyToggle:SetText("İdk" .. tostring(math.random(1,10000)))
    MyToggle:SetState(newstatus)
    Window:SetTitle("VORTEX PREMIUM random number:" .. tostring(math.random(1,10000)))
    Window:SetSubtitle("This:" .. tostring(math.random(1,10000)))    
end)


```



good luck... u can edit and make ur own.
