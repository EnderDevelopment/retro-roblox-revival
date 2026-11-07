local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local EVENT_NAME = "ClassicSafeChatEvent"
local COOLDOWN_SECONDS = 1.25
local MAX_PHRASE_LENGTH = 80

local DEFAULT_PHRASES = {
	"Hello!", "Hi!", "Goodbye!", "Bye!", "Thanks!", "You're welcome!",
	"Yes", "No", "Please", "Sorry", "Nice!", "Great job!",
	"Follow me!", "Come here!", "Wait!", "Stop!", "Help!", "Let's go!",
	"Good game!", "That was fun!", "I agree", "I don't know", "Welcome!",
	"Can you help me?", "Want to play?", "I'm ready!", "Be careful!",
}

local phraseSet = {}
for _, phrase in ipairs(DEFAULT_PHRASES) do
	phraseSet[phrase] = true
end

local event = ReplicatedStorage:FindFirstChild(EVENT_NAME)
if not event then
	event = Instance.new("RemoteEvent")
	event.Name = EVENT_NAME
	event.Parent = ReplicatedStorage
end

local lastUsed = {}

event.OnServerEvent:Connect(function(player, phrase)
	if typeof(phrase) ~= "string" or #phrase > MAX_PHRASE_LENGTH or not phraseSet[phrase] then
		return
	end

	local now = os.clock()
	if lastUsed[player] and now - lastUsed[player] < COOLDOWN_SECONDS then
		return
	end
	lastUsed[player] = now

	local character = player.Character
	if not character or not character:FindFirstChild("Head") then
		return
	end

	event:FireAllClients(player, phrase)
end)

Players.PlayerRemoving:Connect(function(player)
	lastUsed[player] = nil
end)

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		local humanoid = character:WaitForChild("Humanoid", 10)
		if humanoid and humanoid.RigType == Enum.HumanoidRigType.R6 then
			humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.Viewer
		end
	end)
end)
