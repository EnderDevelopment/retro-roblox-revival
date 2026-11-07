local character = script.Parent
local humanoid = character:WaitForChild("Humanoid", 10)
local animate = character:WaitForChild("Animate", 10)

if not humanoid or humanoid.RigType ~= Enum.HumanoidRigType.R6 or not animate then
	return
end

local animationIds = {
	idle = {
		"rbxassetid://180435571",
		"rbxassetid://180435792",
	},
	walk = "rbxassetid://180426354",
	run = "rbxassetid://180426354",
	jump = "rbxassetid://125750702",
	fall = "rbxassetid://180436148",
	climb = "rbxassetid://180436334",
	sit = "rbxassetid://178130996",
}

local function setAnimationId(container, id)
	if not container then
		return
	end
	local animation = container:FindFirstChildWhichIsA("Animation")
	if animation then
		animation.AnimationId = id
	end
end

local idle = animate:FindFirstChild("idle")
if idle then
	local animations = idle:GetChildren()
	for index, animation in ipairs(animations) do
		if animation:IsA("Animation") then
			animation.AnimationId = animationIds.idle[index] or animationIds.idle[1]
		end
	end
end

setAnimationId(animate:FindFirstChild("walk"), animationIds.walk)
setAnimationId(animate:FindFirstChild("run"), animationIds.run)
setAnimationId(animate:FindFirstChild("jump"), animationIds.jump)
setAnimationId(animate:FindFirstChild("fall"), animationIds.fall)
setAnimationId(animate:FindFirstChild("climb"), animationIds.climb)
setAnimationId(animate:FindFirstChild("sit"), animationIds.sit)
