local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")


local RANGE = 20

while true do
    
    local enemiesFolder = workspace:WaitForChild("__Main"):WaitForChild("__Enemies"):WaitForChild("Client")
    local enemies = enemiesFolder:GetChildren()

    
    local closestEnemy = nil
    local minDistance = RANGE

    for _, enemy in pairs(enemies) do
        
        local enemyRootPart = enemy:FindFirstChild("HumanoidRootPart")
        if enemyRootPart then
            local distance = (humanoidRootPart.Position - enemyRootPart.Position).Magnitude
            if distance <= minDistance then
                closestEnemy = enemy
                minDistance = distance
            end
        end
    end

  
    if closestEnemy then
        local enemyId = closestEnemy.Name 
        local args = {
            {
                {
                    Event = "PunchAttack",
                    Enemy = enemyId
                },
                "\4"
            }
        }
        game:GetService("ReplicatedStorage"):WaitForChild("BridgeNet2"):WaitForChild("dataRemoteEvent"):FireServer(unpack(args))
       
    
    end

    task.wait(0)
end
