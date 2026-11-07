local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Debris = game:GetService("Debris")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local event = ReplicatedStorage:WaitForChild("ClassicSafeChatEvent")

-- Replace these with assets you own or have permission to use.
local SAFE_CHAT_DECAL_ID = "rbxassetid://0"
local CHAT_SOUND_ID = "rbxassetid://0"
local CLASSIC_WAVE_ANIMATION_ID = "rbxassetid://128777973"

local phrases = {
	"Hello!", "Hi!", "Goodbye!", "Bye!", "Thanks!", "You're welcome!",
	"Yes", "No", "Please", "Sorry", "Nice!", "Great job!",
	"Follow me!", "Come here!", "Wait!", "Stop!", "Help!", "Let's go!",
	"Good game!", "That was fun!", "I agree", "I don't know", "Welcome!",
	"Can you help me?", "Want to play?", "I'm ready!", "Be careful!",
}

local gui = Instance.new("ScreenGui")
gui.Name = "ClassicSafeChat"
gui.ResetOnSpawn = false
gui.Parent = playerGui

local openButton = Instance.new("TextButton")
openButton.Name = "SafeChatButton"
openButton.Size = UDim2.fromOffset(120, 34)
openButton.Position = UDim2.new(0, 14, 1, -50)
openButton.BackgroundColor3 = Color3.fromRGB(205, 205, 205)
openButton.BorderColor3 = Color3.fromRGB(40, 40, 40)
openButton.TextColor3 = Color3.fromRGB(20, 20, 20)
openButton.Font = Enum.Font.ArialBold
openButton.TextSize = 16
openButton.Text = "Safe Chat"
openButton.Parent = gui

local panel = Instance.new("Frame")
panel.Name = "PhrasePanel"
panel.Size = UDim2.fromOffset(240, 310)
panel.Position = UDim2.new(0, 14, 1, -370)
panel.BackgroundColor3 = Color3.fromRGB(235, 235, 235)
panel.BorderColor3 = Color3.fromRGB(40, 40, 40)
panel.Visible = false
panel.Parent = gui

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 32)
title.BackgroundColor3 = Color3.fromRGB(70, 120, 180)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.ArialBold
title.TextSize = 18
title.Text = "Safe Chat"
title.Parent = panel

local list = Instance.new("ScrollingFrame")
list.Name = "Phrases"
list.Position = UDim2.fromOffset(6, 38)
list.Size = UDim2.new(1, -12, 1, -44)
list.BackgroundTransparency = 1
list.BorderSizePixel = 0
list.ScrollBarThickness = 8
list.CanvasSize = UDim2.new()
list.Parent = panel

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 3)
layout.Parent = list

local function showSpeech(playerWhoSpoke, phrase)
	local character = playerWhoSpoke.Character
	if not character then
		return
	end

	local head = character:FindFirstChild("Head")
	if not head then
		return
	end

	local bubble = Instance.new("BillboardGui")
	bubble.Name = "ClassicSafeChatBubble"
	bubble.Adornee = head
	bubble.Size = UDim2.fromOffset(190, 56)
	bubble.StudsOffset = Vector3.new(0, 3.2, 0)
	bubble.AlwaysOnTop = true
	bubble.Parent = head

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundColor3 = Color3.fromRGB(255, 255, 225)
	label.BackgroundTransparency = 0.05
	label.BorderColor3 = Color3.fromRGB(30, 30, 30)
	label.TextColor3 = Color3.fromRGB(20, 20, 20)
	label.TextWrapped = true
	label.Font = Enum.Font.Arial
	label.TextSize = 16
	label.Text = phrase
	label.Parent = bubble

	if SAFE_CHAT_DECAL_ID ~= "rbxassetid://0" then
		local decal = Instance.new("ImageLabel")
		decal.Name = "SafeChatDecal"
		decal.BackgroundTransparency = 1
		decal.Image = SAFE_CHAT_DECAL_ID
		decal.Size = UDim2.fromOffset(26, 26)
		decal.Position = UDim2.fromOffset(-30, 15)
		decal.Parent = bubble
	end

	if CHAT_SOUND_ID ~= "rbxassetid://0" then
		local sound = Instance.new("Sound")
		sound.SoundId = CHAT_SOUND_ID
		sound.Volume = 0.7
		sound.Parent = head
		sound:Play()
		Debris:AddItem(sound, 5)
	end

	if playerWhoSpoke == player then
		local humanoid = character:FindFirstChildOfClass("Humanoid")
		if humanoid and humanoid.RigType == Enum.HumanoidRigType.R6 and CLASSIC_WAVE_ANIMATION_ID ~= "rbxassetid://0" then
			local animation = Instance.new("Animation")
			animation.AnimationId = CLASSIC_WAVE_ANIMATION_ID
			local track = humanoid:LoadAnimation(animation)
			track:Play()
			Debris:AddItem(animation, 2)
		end
	end

	Debris:AddItem(bubble, 5)
end

for _, phrase in ipairs(phrases) do
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, -4, 0, 27)
	button.BackgroundColor3 = Color3.fromRGB(250, 250, 250)
	button.BorderColor3 = Color3.fromRGB(120, 120, 120)
	button.TextColor3 = Color3.fromRGB(20, 20, 20)
	button.Font = Enum.Font.Arial
	button.TextSize = 15
	button.Text = phrase
	button.Parent = list
	button.Activated:Connect(function()
		event:FireServer(phrase)
		panel.Visible = false
	end)
end

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	list.CanvasSize = UDim2.fromOffset(0, layout.AbsoluteContentSize.Y + 6)
end)

openButton.Activated:Connect(function()
	panel.Visible = not panel.Visible
end)

event.OnClientEvent:Connect(showSpeech)
