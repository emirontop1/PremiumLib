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
local Ui = loadstring(game:HttpGet('[https://raw.githubusercontent.com/emirontop1/PremiumLib/refs/heads/main/Src/Source.lua](https://raw.githubusercontent.com/emirontop1/PremiumLib/refs/heads/main/Src/Source.lua)'))()

-- Ana Pencere Kurulumu
local MyWindow = Ui.CreateWindow("Vortex Hub", "Loading interface structure...", "negar?")

-- Sekmelerin Oluşturulması
local MainTab = MyWindow:CreateTab("Main")
local VisualsTab = MyWindow:CreateTab("Visuals")

-- 1. Paragraph Elementi (Bilgilendirme Alanı)
MainTab:CreateParagraph("Welcome User!", "This script engine is secure and compatible with all major modern execution units. Please load modules carefully.")

-- 2. TextBox Elementi (Dinamik Veri Girişi)
MainTab:CreateTextBox("Enter custom WalkSpeed value...", function(text)
	print("User submitted value:", text)
	-- Örnek kullanım: local speed = tonumber(text) or 16
end)

-- 3. Toggle Elementi (Aç/Kapat Anahtarı)
MainTab:CreateToggle("Infinite Jump", false, function(state)
	print("Infinite Jump state:", state)
end)

-- 4. Button Elementi (Tetikleyici)
MainTab:CreateButton("Re-Optimize Matrix", function()
	print("System optimization ran successfully.")
end)
```
