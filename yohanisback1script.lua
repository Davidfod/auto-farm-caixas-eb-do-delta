local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local PathfindingService = game:GetService("PathfindingService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local rootPart = character:WaitForChild("HumanoidRootPart")

local areaEntrega = Workspace.Map.Sistemas.Jobs.Caixas.LocalEntrega.AreaEntrega
local promptPart = Workspace.Map.Sistemas.Jobs.Caixas.PromptPart

_G.ProxLoopAtivo = false
_G.PulandoAtivo = false

local NoclipAtivo = false
local noclipConnection

local function loopNoclip()
    if not NoclipAtivo then return end
    local char = player.Character
    if not char then return end
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("BasePart") then
            v.CanCollide = false
        end
    end
end

local function resetarNoclip()
    local char = player.Character
    if not char then return end
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("BasePart") then
            v.CanCollide = true
        end
    end
end

local function ativarNoclip()
    NoclipAtivo = true
    noclipConnection = RunService.Stepped:Connect(loopNoclip)
end

local function desativarNoclip()
    NoclipAtivo = false
    if noclipConnection then noclipConnection:Disconnect() end
    resetarNoclip()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "CyberNodry_GUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

local NoclipFrame = Instance.new("Frame")
NoclipFrame.Size = UDim2.new(0, 220, 0, 140)
NoclipFrame.Position = UDim2.new(0.5, -110, 0.5, -70)
NoclipFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
NoclipFrame.BorderSizePixel = 0
NoclipFrame.Active = true
NoclipFrame.Draggable = true
NoclipFrame.Parent = ScreenGui
Instance.new("UICorner", NoclipFrame)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundTransparency = 1
Title.Text = "CyberNodry - Ancolide"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 14
Title.Parent = NoclipFrame

local Credit = Instance.new("TextLabel")
Credit.Size = UDim2.new(1, 0, 0, 20)
Credit.Position = UDim2.new(0, 0, 1, -20)
Credit.BackgroundTransparency = 1
Credit.Text = "Ative o auto job e o ancolide o butão"
Credit.TextColor3 = Color3.fromRGB(150, 150, 150)
Credit.Font = Enum.Font.Gotham
Credit.TextSize = 12
Credit.Parent = NoclipFrame

local NoclipBtn = Instance.new("TextButton")
NoclipBtn.Size = UDim2.new(0, 180, 0, 45)
NoclipBtn.Position = UDim2.new(0.5, -90, 0.5, -10)
NoclipBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
NoclipBtn.Text = "DESATIVADO"
NoclipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
NoclipBtn.Font = Enum.Font.GothamSemibold
NoclipBtn.TextSize = 13
NoclipBtn.Parent = NoclipFrame
Instance.new("UICorner", NoclipBtn)

local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 25, 0, 25)
MinBtn.Position = UDim2.new(1, -60, 0, 5)
MinBtn.Text = "-"
MinBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MinBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
MinBtn.Parent = NoclipFrame
Instance.new("UICorner", MinBtn)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 25, 0, 25)
CloseBtn.Position = UDim2.new(1, -30, 0, 5)
CloseBtn.Text = "X"
CloseBtn.BackgroundColor3 = Color3.fromRGB(120, 0, 0)
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Parent = NoclipFrame
Instance.new("UICorner", CloseBtn)

local JobFrame = Instance.new("Frame")
JobFrame.Size = UDim2.new(0, 220, 0, 55)
JobFrame.Position = UDim2.new(0.5, -110, 0.5, 85)
JobFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
JobFrame.BorderSizePixel = 0
JobFrame.Active = true
JobFrame.Draggable = true
JobFrame.Parent = ScreenGui
Instance.new("UICorner", JobFrame)

local JobBtn = Instance.new("TextButton")
JobBtn.Size = UDim2.new(1, -16, 1, -16)
JobBtn.Position = UDim2.new(0, 8, 0, 8)
JobBtn.BackgroundColor3 = Color3.fromRGB(40, 167, 69)
JobBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
JobBtn.Text = "▶  Ativar Job"
JobBtn.Font = Enum.Font.GothamBold
JobBtn.TextSize = 15
JobBtn.BorderSizePixel = 0
JobBtn.Parent = JobFrame
Instance.new("UICorner", JobBtn).CornerRadius = UDim.new(0, 7)

NoclipBtn.MouseButton1Click:Connect(function()
    NoclipAtivo = not NoclipAtivo
    if NoclipAtivo then
        NoclipBtn.Text = "ATIVADO"
        NoclipBtn.BackgroundColor3 = Color3.fromRGB(40, 180, 40)
        ativarNoclip()
    else
        NoclipBtn.Text = "DESATIVADO"
        NoclipBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
        desativarNoclip()
    end
end)

MinBtn.MouseButton1Click:Connect(function()
    NoclipBtn.Visible = not NoclipBtn.Visible
    Credit.Visible = NoclipBtn.Visible
    NoclipFrame:TweenSize(
        NoclipBtn.Visible and UDim2.new(0, 220, 0, 140) or UDim2.new(0, 220, 0, 35),
        "Out", "Quad", 0.2, true
    )
end)

CloseBtn.MouseButton1Click:Connect(function()
    desativarNoclip()
    ScreenGui:Destroy()
end)

JobBtn.MouseButton1Click:Connect(function()
    _G.ProxLoopAtivo = not _G.ProxLoopAtivo
    if _G.ProxLoopAtivo then
        JobBtn.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
        JobBtn.Text = "■  Parar Job"
        if not NoclipAtivo then
            NoclipAtivo = true
            NoclipBtn.Text = "ATIVADO"
            NoclipBtn.BackgroundColor3 = Color3.fromRGB(40, 180, 40)
            ativarNoclip()
        end
    else
        JobBtn.BackgroundColor3 = Color3.fromRGB(40, 167, 69)
        JobBtn.Text = "▶  Ativar Job"
        _G.PulandoAtivo = false
    end
end)

task.spawn(function()
    while true do
        task.wait(0.35)
        if _G.PulandoAtivo and _G.ProxLoopAtivo then
            if humanoid and humanoid.FloorMaterial ~= Enum.Material.Air then
                humanoid.Jump = true
            end
        end
    end
end)

local function andarAte(destino)
    local destinoPos = destino.Position
    local path = PathfindingService:CreatePath({
        AgentRadius = 2,
        AgentHeight = 5,
        AgentCanJump = true,
        AgentCanClimb = true,
        WaypointSpacing = 4,
    })

    local ok = pcall(function()
        path:ComputeAsync(rootPart.Position, destinoPos)
    end)

    if ok and path.Status == Enum.PathStatus.Success then
        for _, wp in ipairs(path:GetWaypoints()) do
            if not _G.ProxLoopAtivo then return end
            if wp.Action == Enum.PathWaypointAction.Jump then
                humanoid.Jump = true
            end
            humanoid:MoveTo(wp.Position)
            local chegou = humanoid.MoveToFinished:Wait(3)
            if not chegou then
                humanoid:MoveTo(destinoPos)
                break
            end
        end
    else
        print("[Loop] Pathfinding falhou, atravessando...")
        humanoid:MoveTo(destinoPos)
        while (rootPart.Position - destinoPos).Magnitude > 4 do
            if not _G.ProxLoopAtivo then break end
            humanoid:MoveTo(destinoPos)
            task.wait(0.1)
        end
    end

    task.wait(0.3)
end

local function getPromptPerto()
    local melhor = nil
    local menorDist = 20
    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("ProximityPrompt") and obj.Enabled then
            local part = obj.Parent
            if part and part:IsA("BasePart") then
                local dist = (part.Position - rootPart.Position).Magnitude
                if dist < menorDist then
                    menorDist = dist
                    melhor = obj
                end
            end
        end
    end
    return melhor
end

local function holdPrompt(prompt)
    local dur = (prompt.HoldDuration or 2) + 0.6

    if pcall(fireproximityprompt, prompt) then
        task.wait(dur)
        return true
    end

    if pcall(function()
        prompt:InputHoldBegin()
        task.wait(dur)
        prompt:InputHoldEnd()
    end) then return true end

    if pcall(function()
        triggerprompt(prompt)
        task.wait(dur)
    end) then return true end

    return false
end

task.spawn(function()
    while true do
        task.wait(0.3)
        if not _G.ProxLoopAtivo then continue end

        character = player.Character
        if not character then task.wait(1) continue end
        humanoid = character:WaitForChild("Humanoid")
        rootPart = character:WaitForChild("HumanoidRootPart")

        _G.PulandoAtivo = false
        print("[Loop] Andando para PromptPart...")
        andarAte(promptPart)

        if not _G.ProxLoopAtivo then continue end

        local prompt = getPromptPerto()
        if not prompt then
            warn("[Loop] Prompt não encontrada, aguardando...")
            task.wait(1)
            continue
        end

        print("[Loop] Segurando prompt...")
        local ok = holdPrompt(prompt)
        if not ok then
            warn("[Loop] Hold falhou, tentando de novo...")
            task.wait(1)
            continue
        end

        if not _G.ProxLoopAtivo then continue end

        print("[Loop] Pulando e indo para AreaEntrega...")
        _G.PulandoAtivo = true
        andarAte(areaEntrega)

        _G.PulandoAtivo = false
        print("[Loop] Chegou! Parando pulo...")
        task.wait(1)

        print("[Loop] Reiniciando loop...")
    end
end)

print("[CyberNodry] Tudo carregado!")
