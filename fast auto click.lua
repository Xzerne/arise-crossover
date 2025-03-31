-- SKID LAM THE DEO NAO DC HAHAHAHAHAH SIGMA SKIBIDI SUSSY BAKA YAYAYAYAYA
local Players = game:GetService("Players")
local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local SkibidiCombat = {}
SkibidiCombat.__index = SkibidiCombat

local RizzRange = 20
local RizzRangeSquared = RizzRange * RizzRange
local YeetDelay = 0.1

function SkibidiCombat.new()
    local self = setmetatable({}, SkibidiCombat)
    self.BigDawg = Players.LocalPlayer
    self.SussyBaka = self.BigDawg.Character or self.BigDawg.CharacterAdded:Wait()
    self.GyattRoot = self.SussyBaka:WaitForChild("HumanoidRootPart")
    self.OppFolder = workspace:WaitForChild("__Main"):WaitForChild("__Enemies"):WaitForChild("Client")
    self.IsGoated = true
    self.LastYeet = 0
    self.DripQueue = {}
    self:SlapUI()
    self:HookDrip()
    return self
end

function SkibidiCombat:SlapUI()
    local SkibidiGui = Instance.new("ScreenGui")
    SkibidiGui.Parent = self.BigDawg:WaitForChild("PlayerGui")
    SkibidiGui.Name = "PunchAttackUI"
    SkibidiGui.ResetOnSpawn = false

    local RizzToggle = Instance.new("TextButton")
    RizzToggle.Parent = SkibidiGui
    RizzToggle.Size = UDim2.new(0, 100, 0, 50)
    RizzToggle.Position = UDim2.new(0, 10, 0, 10)
    RizzToggle.Text = "ON"
    RizzToggle.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    RizzToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
    RizzToggle.Font = Enum.Font.SourceSansBold
    RizzToggle.TextSize = 20
    RizzToggle.Name = "ToggleCombat"

    self.RizzToggle = RizzToggle
end

function SkibidiCombat:HookDrip()
    self.RizzToggle.MouseButton1Click:Connect(function()
        self:FlipRizz()
    end)

    RunService.Heartbeat:Connect(function()
        self:BussinLoop()
    end)
end

function SkibidiCombat:FlipRizz()
    self.IsGoated = not self.IsGoated
    local DripColor = self.IsGoated and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    local VibinText = self.IsGoated and "ON" or "OFF"
    
    for i = 0, 1, 0.1 do
        self.RizzToggle.BackgroundColor3 = self.RizzToggle.BackgroundColor3:Lerp(DripColor, i)
        task.wait(0.01)
    end
    self.RizzToggle.Text = VibinText
end

function SkibidiCombat:SnagClosestOpp()
    local SigmaPos = self.GyattRoot.Position
    local MinYeetSquared = RizzRangeSquared
    local ClosestOpp = nil

    local SigmaFrame = self.GyattRoot.CFrame
    for _, opp in ipairs(self.OppFolder:GetChildren()) do
        local OppRoot = opp:FindFirstChild("HumanoidRootPart")
        if OppRoot then
            local DeltaRizz = OppRoot.Position - SigmaPos
            local YeetSquared = DeltaRizz:Dot(DeltaRizz)
            if YeetSquared <= MinYeetSquared then
                MinYeetSquared = YeetSquared
                ClosestOpp = opp
            end
        end
    end
    return ClosestOpp
end

function SkibidiCombat:QueueSmack(opp)
    if not opp then return end
    table.insert(self.DripQueue, {
        Event = "PunchAttack",
        OppId = opp.Name,
        TimeStamp = tick()
    })
end

function SkibidiCombat:YeetSmack(dripData)
    local args = {
        {
            dripData,
            "\4"
        }
    }
    ReplicatedStorage:WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
    print(("Smacked %s at %.2f range, W rizz"):format(dripData.OppId, math.sqrt(self:GetOppYeetSquared())))
end

function SkibidiCombat:GetOppYeetSquared()
    local nearest = self:SnagClosestOpp()
    if not nearest then return RizzRangeSquared end
    local DeltaRizz = nearest:FindFirstChild("HumanoidRootPart").Position - self.GyattRoot.Position
    return DeltaRizz:Dot(DeltaRizz)
end

function SkibidiCombat:BussinLoop()
    if not self.IsGoated then return end
    local NowVibe = tick()
    if NowVibe - self.LastYeet < YeetDelay then return end

    local ClosestOpp = self:SnagClosestOpp()
    if ClosestOpp then
        self:QueueSmack(ClosestOpp)
        self.LastYeet = NowVibe
    else
        print("No opps in range, L bozo!")
    end

    if #self.DripQueue > 0 then
        local drip = table.remove(self.DripQueue, 1)
        self:YeetSmack(drip)
    end
end

local CombatRizz = SkibidiCombat.new()

Players.LocalPlayer.CharacterAdded:Connect(function(newSussy)
    CombatRizz.SussyBaka = newSussy
    CombatRizz.GyattRoot = newSussy:WaitForChild("HumanoidRootPart")
end)
