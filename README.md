example:

```lua
--// Vortex Hub Başlatılıyor...
local Vortex = loadstring(game:HttpGet('https://raw.githubusercontent.com/emirontop1/PremiumLib/refs/heads/main/Src/source.lua'))()

local MyWindow = Vortex:CreateWindow("Vortex Hub", "Dynamic UI Ready", "negar?", "nega")
local MainTab = MyWindow:CreateTab("Main")

-- Elemanları değişkenlere kaydediyoruz
local MyParagraph = MainTab:CreateParagraph("Status: Scanning", "Analyzing background files...")
local MyTextBox = MainTab:CreateTextBox("WalkSpeed value", "16", function(txt) print(txt) end)
local MyToggle = MainTab:CreateToggle("God Mode Status", false, function(state) print(state) end)
local MyButton = MainTab:CreateButton("Update All Elements Dynamically", function() 
--MyButton:SetText("Click to Test Setters") -- Buton ismini Setter ile güncelledik
MyParagraph:SetText("Status: COMPLETE!", "All parameters successfully verified by the core engine.")
	--(dont work idk?)MyButton:SetText("Click to Test Setters") -- Buton ismini Setter ile güncelledik

	-- 2. TextBox içerik güncelleme testi
	MyTextBox:SetText(math.random(1,10000))
	
	-- 3. Toggle durumunu ve metnini güncelleme testi
	MyToggle:SetText("God Mode: ENABLED")
	MyToggle:SetState(true or false)
end)

-- Note: createButton yapısında callback'i manipüle etmek için kütüphanenin orijinal yapısı korunmuştur.

```


good luck... u can edit and make ur own.
