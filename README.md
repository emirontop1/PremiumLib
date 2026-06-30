#  Vortex Hub 

Bu depo, **PremiumLib** arayüz kütüphanesi (UI Library) kullanılarak geliştirilmiş, yüksek performanslı ve modüler bir kullanıcı arayüzü scriptinin kaynak kodunu ve detaylı kullanım kılavuzunu içermektedir.

Arayüz, tüm popüler yürütme ortamları (executor'lar) ile tam uyumlu ve optimize bir şekilde çalışacak şekilde tasarlanmıştır.

---

## 💻 Sistem Gereksinimleri

Scriptin sorunsuz çalışabilmesi için yürütüldüğü ortamın (Executor) aşağıdaki standart fonksiyonları desteklemesi gerekir:
* `loadstring()` (Uzak sunucudan gelen kodu derlemek için)
* `game:HttpGet()` (Kütüphane kaynak kodunu internetten çekmek için)

---

## 🚀 Hızlı Kurulum (Quick Start)

Aşağıdaki hazır kodu executor'ınıza yapıştırarak arayüzü hemen başlatabilirsiniz:

```lua
--// Vortex Hub Başlatılıyor...
local Vortex = loadstring(game:HttpGet('[https://raw.githubusercontent.com/emirontop1/PremiumLib/refs/heads/main/Src/source.lua"))()

local MyWindow = Vortex.CreateWindow("Vortex Hub", "Dynamic UI Ready", "negar?", "nega")
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

-- Butona basıldığında yukarıdaki fonksiyonların çalışmasını sağlayan test mekanizması:

-- Butonun asıl tıklama fonksiyonunu atayalım:
-- Not: createButton yapısında callback'i manipüle etmek için kütüphanenin orijinal yapısı korunmuştur.
-- Set fonksiyonlarının tam testi için aşağıda küçük bir gecikmeli (delay) simülasyon yapalım:



```
