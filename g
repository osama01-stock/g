local Players = game:GetService("Players") local TweenService = game:GetService("TweenService") local player = Players.LocalPlayer local playerGui = player:WaitForChild("PlayerGui") local character = player.Character or player.CharacterAdded:Wait() local rootPart = character:WaitForChild("HumanoidRootPart")
local savedCoordinates = {} local selectedCoordinate = nil local isMainGuiVisible = false local isEditGuiVisible = false
local screenGui = Instance.new("ScreenGui") screenGui.Name = "CoordinateManagerGui" screenGui.Parent = playerGui screenGui.ResetOnSpawn = false
local mainToggleButton = Instance.new("TextButton") mainToggleButton.Name = "MainToggleButton" mainToggleButton.Size = UDim2.new(0, 150, 0, 50) mainToggleButton.AnchorPoint = Vector2.new(0.5, 0) mainToggleButton.Position = UDim2.new(0.5, 0, 0, 20) mainToggleButton.Text = "إدارة الإحداثيات" mainToggleButton.Font = Enum.Font.SourceSansBold mainToggleButton.TextSize = 18 mainToggleButton.TextColor3 = Color3.new(1, 1, 1) mainToggleButton.BackgroundColor3 = Color3.fromRGB(85, 170, 255) mainToggleButton.BorderSizePixel = 0 mainToggleButton.ZIndex = 2 local toggleCorner = Instance.new("UICorner"); toggleCorner.CornerRadius = UDim.new(0, 8); toggleCorner.Parent = mainToggleButton local toggleStroke = Instance.new("UIStroke"); toggleStroke.Parent = mainToggleButton; toggleStroke.Color = Color3.fromRGB(0, 85, 170); toggleStroke.Thickness = 2
local mainFrame = Instance.new("Frame") mainFrame.Name = "MainFrame" mainFrame.Size = UDim2.new(0, 350, 0, 450) mainFrame.AnchorPoint = Vector2.new(0.5, 0.5) mainFrame.Position = UDim2.new(0.5, 0, 0.5, 0) mainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) mainFrame.Visible = false mainFrame.Draggable = true local mainCorner = Instance.new("UICorner"); mainCorner.CornerRadius = UDim.new(0, 12); mainCorner.Parent = mainFrame local mainStroke = Instance.new("UIStroke"); mainStroke.Parent = mainFrame; mainStroke.Color = Color3.fromRGB(100, 100, 100); mainStroke.Thickness = 2
local titleLabel = Instance.new("TextLabel") titleLabel.Size = UDim2.new(1, 0, 0, 40) titleLabel.Position = UDim2.new(0, 0, 0, 10) titleLabel.Text = "واجهة إدارة الإحداثيات" titleLabel.TextColor3 = Color3.new(1, 1, 1) titleLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 30) titleLabel.Font = Enum.Font.SourceSansBold titleLabel.TextSize = 20 titleLabel.Parent = mainFrame local titleStroke = Instance.new("UIStroke"); titleStroke.Parent = titleLabel; titleStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual; titleStroke.Color = Color3.fromRGB(20, 20, 20); titleStroke.Thickness = 2
local coordsInput = Instance.new("TextBox") coordsInput.Name = "CoordsInput" coordsInput.Size = UDim2.new(0.9, 0, 0, 30) coordsInput.Position = UDim2.new(0.5, 0, 0, 55) coordsInput.AnchorPoint = Vector2.new(0.5, 0) coordsInput.PlaceholderText = "أدخل الإحداثيات (مثال: 100, 50, -200)" coordsInput.TextXAlignment = Enum.TextXAlignment.Center coordsInput.Font = Enum.Font.SourceSans coordsInput.TextSize = 14 coordsInput.TextColor3 = Color3.fromRGB(255, 255, 255) coordsInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40) coordsInput.BorderSizePixel = 0 coordsInput.Parent = mainFrame local coordsCorner = Instance.new("UICorner"); coordsCorner.CornerRadius = UDim.new(0, 6); coordsCorner.Parent = coordsInput local coordsStroke = Instance.new("UIStroke"); coordsStroke.Parent = coordsInput; coordsStroke.Color = Color3.fromRGB(0, 85, 170); coordsStroke.Thickness = 1
local nameInput = Instance.new("TextBox") nameInput.Name = "NameInput" nameInput.Size = UDim2.new(0.9, 0, 0, 30) nameInput.Position = UDim2.new(0.5, 0, 0, 95) nameInput.AnchorPoint = Vector2.new(0.5, 0) nameInput.PlaceholderText = "أدخل اسم الإحداثي" nameInput.TextXAlignment = Enum.TextXAlignment.Center nameInput.Font = Enum.Font.SourceSans nameInput.TextSize = 14 nameInput.TextColor3 = Color3.fromRGB(255, 255, 255) nameInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40) nameInput.BorderSizePixel = 0 nameInput.Parent = mainFrame local nameCorner = Instance.new("UICorner"); nameCorner.CornerRadius = UDim.new(0, 6); nameCorner.Parent = nameInput local nameStroke = Instance.new("UIStroke"); nameStroke.Parent = nameInput; nameStroke.Color = Color3.fromRGB(0, 85, 170); nameStroke.Thickness = 1
local saveButton = Instance.new("TextButton") saveButton.Name = "SaveButton" saveButton.Size = UDim2.new(0.9, 0, 0, 35) saveButton.Position = UDim2.new(0.5, 0, 0, 135) saveButton.AnchorPoint = Vector2.new(0.5, 0) saveButton.Text = "حفظ الإحداثي" saveButton.Font = Enum.Font.SourceSansBold saveButton.TextSize = 16 saveButton.TextColor3 = Color3.new(1, 1, 1) saveButton.BackgroundColor3 = Color3.fromRGB(80, 200, 120) saveButton.BorderSizePixel = 0 saveButton.Parent = mainFrame local saveCorner = Instance.new("UICorner"); saveCorner.CornerRadius = UDim.new(0, 6); saveCorner.Parent = saveButton
local savedList = Instance.new("ScrollingFrame") savedList.Name = "SavedList" savedList.Size = UDim2.new(0.9, 0, 1, -190) savedList.Position = UDim2.new(0.5, 0, 0, 180) savedList.AnchorPoint = Vector2.new(0.5, 0) savedList.BackgroundColor3 = Color3.fromRGB(40, 40, 40) savedList.BorderSizePixel = 0 savedList.BackgroundTransparency = 0.5 savedList.CanvasSize = UDim2.new(0, 0, 0, 0) savedList.Parent = mainFrame local savedListCorner = Instance.new("UICorner"); savedListCorner.CornerRadius = UDim.new(0, 6); savedListCorner.Parent = savedList
local listLayout = Instance.new("UIListLayout") listLayout.Name = "ListLayout" listLayout.Padding = UDim.new(0, 5) listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center listLayout.SortOrder = Enum.SortOrder.LayoutOrder listLayout.Parent = savedList
local goButton = Instance.new("TextButton") goButton.Name = "GoButton" goButton.Size = UDim2.new(0.9, 0, 0, 40) goButton.Position = UDim2.new(0.5, 0, 1, -50) goButton.AnchorPoint = Vector2.new(0.5, 1) goButton.Text = "انتقال" goButton.Font = Enum.Font.SourceSansBold goButton.TextSize = 18 goButton.TextColor3 = Color3.new(1, 1, 1) goButton.BackgroundColor3 = Color3.fromRGB(255, 170, 85) goButton.BorderSizePixel = 0 goButton.Parent = mainFrame local goCorner = Instance.new("UICorner"); goCorner.CornerRadius = UDim.new(0, 8); goCorner.Parent = goButton
local editFrame = Instance.new("Frame") editFrame.Name = "EditFrame" editFrame.Size = UDim2.new(0, 300, 0, 200) editFrame.AnchorPoint = Vector2.new(0.5, 0.5) editFrame.Position = UDim2.new(0.5, 0, 0.5, 0) editFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30) editFrame.Visible = false editFrame.Parent = screenGui local editCorner = Instance.new("UICorner"); editCorner.CornerRadius = UDim.new(0, 12); editCorner.Parent = editFrame local editStroke = Instance.new("UIStroke"); editStroke.Parent = editFrame; editStroke.Color = Color3.fromRGB(100, 100, 100); editStroke.Thickness = 2
local editTitle = Instance.new("TextLabel") editTitle.Size = UDim2.new(1, 0, 0, 30) editTitle.Position = UDim2.new(0, 0, 0, 10) editTitle.Text = "تعديل الإحداثي" editTitle.TextColor3 = Color3.new(1, 1, 1) editTitle.BackgroundColor3 = Color3.fromRGB(30, 30, 30) editTitle.Font = Enum.Font.SourceSansBold editTitle.TextSize = 18 editTitle.Parent = editFrame local editTitleStroke = Instance.new("UIStroke"); editTitleStroke.Parent = editTitle; editTitleStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual; editTitleStroke.Color = Color3.fromRGB(20, 20, 20); editTitleStroke.Thickness = 2
local editNameInput = Instance.new("TextBox") editNameInput.Name = "EditNameInput" editNameInput.Size = UDim2.new(0.9, 0, 0, 30) editNameInput.Position = UDim2.new(0.5, 0, 0, 45) editNameInput.AnchorPoint = Vector2.new(0.5, 0) editNameInput.PlaceholderText = "اسم الإحداثي الجديد" editNameInput.TextXAlignment = Enum.TextXAlignment.Center editNameInput.Font = Enum.Font.SourceSans editNameInput.TextSize = 14 editNameInput.TextColor3 = Color3.new(1, 1, 1) editNameInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40) editNameInput.BorderSizePixel = 0 editNameInput.Parent = editFrame local editNameCorner = Instance.new("UICorner"); editNameCorner.CornerRadius = UDim.new(0, 6); editNameCorner.Parent = editNameInput local editNameStroke = Instance.new("UIStroke"); editNameStroke.Parent = editNameInput; editNameStroke.Color = Color3.fromRGB(0, 85, 170); editNameStroke.Thickness = 1
local editCoordsInput = Instance.new("TextBox") editCoordsInput.Name = "EditCoordsInput" editCoordsInput.Size = UDim2.new(0.9, 0, 0, 30) editCoordsInput.Position = UDim2.new(0.5, 0, 0, 85) editCoordsInput.AnchorPoint = Vector2.new(0.5, 0) editCoordsInput.PlaceholderText = "الإحداثيات الجديدة (X, Y, Z)" editCoordsInput.TextXAlignment = Enum.TextXAlignment.Center editCoordsInput.Font = Enum.Font.SourceSans editCoordsInput.TextSize = 14 editCoordsInput.TextColor3 = Color3.new(1, 1, 1) editCoordsInput.BackgroundColor3 = Color3.fromRGB(40, 40, 40) editCoordsInput.BorderSizePixel = 0 editCoordsInput.Parent = editFrame local editCoordsCorner = Instance.new("UICorner"); editCoordsCorner.CornerRadius = UDim.new(0, 6); editCoordsCorner.Parent = editCoordsInput local editCoordsStroke = Instance.new("UIStroke"); editCoordsStroke.Parent = editCoordsInput; editCoordsStroke.Color = Color3.fromRGB(0, 85, 170); editCoordsStroke.Thickness = 1
local editSaveButton = Instance.new("TextButton") editSaveButton.Name = "EditSaveButton" editSaveButton.Size = UDim2.new(0.4, 0, 0, 35) editSaveButton.Position = UDim2.new(0.2, 0, 1, -40) editSaveButton.AnchorPoint = Vector2.new(0.5, 1) editSaveButton.Text = "حفظ التعديل" editSaveButton.Font = Enum.Font.SourceSansBold editSaveButton.TextSize = 16 editSaveButton.TextColor3 = Color3.new(1, 1, 1) editSaveButton.BackgroundColor3 = Color3.fromRGB(80, 200, 120) editSaveButton.BorderSizePixel = 0 editSaveButton.Parent = editFrame local editSaveCorner = Instance.new("UICorner"); editSaveCorner.CornerRadius = UDim.new(0, 6); editSaveCorner.Parent = editSaveButton
local editCancelButton = Instance.new("TextButton") editCancelButton.Name = "EditCancelButton" editCancelButton.Size = UDim2.new(0.4, 0, 0, 35) editCancelButton.Position = UDim2.new(0.8, 0, 1, -40) editCancelButton.AnchorPoint = Vector2.new(0.5, 1) editCancelButton.Text = "إلغاء" editCancelButton.Font = Enum.Font.SourceSansBold editCancelButton.TextSize = 16 editCancelButton.TextColor3 = Color3.new(1, 1, 1) editCancelButton.BackgroundColor3 = Color3.fromRGB(255, 80, 80) editCancelButton.BorderSizePixel = 0 editCancelButton.Parent = editFrame local editCancelCorner = Instance.new("UICorner"); editCancelCorner.CornerRadius = UDim.new(0, 6); editCancelCorner.Parent = editCancelButton
local notificationFrame = Instance.new("TextLabel") notificationFrame.Size = UDim2.new(0.4, 0, 0, 50) notificationFrame.AnchorPoint = Vector2.new(0.5, 0) notificationFrame.Position = UDim2.new(0.5, 0, 0, 5) notificationFrame.Text = "" notificationFrame.TextColor3 = Color3.new(1, 1, 1) notificationFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40) notificationFrame.BorderSizePixel = 0 notificationFrame.Font = Enum.Font.SourceSansBold notificationFrame.TextSize = 16 notificationFrame.Visible = false notificationFrame.ZIndex = 3 notificationFrame.Parent = screenGui local notifCorner = Instance.new("UICorner"); notifCorner.CornerRadius = UDim.new(0, 8); notifCorner.Parent = notificationFrame local notifStroke = Instance.new("UIStroke"); notifStroke.Parent = notificationFrame; notifStroke.Color = Color3.fromRGB(255, 255, 255); notifStroke.Thickness = 1
local function showNotification(message) notificationFrame.Text = message notificationFrame.Visible = true task.delay(3, function() notificationFrame.Visible = false end) end
local function refreshSavedList() for _, child in ipairs(savedList:GetChildren()) do if child:IsA("Frame") then child:Destroy() end end
local totalHeight = 0
for i, coordData in ipairs(savedCoordinates) do
        local itemFrame = Instance.new("Frame")
        itemFrame.Name = "CoordItem_" .. i
        itemFrame.Size = UDim2.new(1, 0, 0, 30)
        itemFrame.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        itemFrame.Parent = savedList
        local itemCorner = Instance.new("UICorner"); itemCorner.CornerRadius = UDim.new(0, 6); itemCorner.Parent = itemFrame
        itemFrame:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
                itemFrame.Size = UDim2.new(1, 0, 0, 30)
        end)

        local selectButton = Instance.new("TextButton")
        selectButton.Name = "SelectButton"
        selectButton.Size = UDim2.new(1, -95, 1, 0)
        selectButton.Position = UDim2.new(0, 0, 0, 0)
        selectButton.Text = coordData.name .. " (" .. tostring(math.floor(coordData.position.X)) .. ", " .. tostring(math.floor(coordData.position.Y)) .. ", " .. tostring(math.floor(coordData.position.Z)) .. ")"
        selectButton.Font = Enum.Font.SourceSans
        selectButton.TextSize = 14
        selectButton.TextXAlignment = Enum.TextXAlignment.Left
        selectButton.TextYAlignment = Enum.TextYAlignment.Center
        selectButton.TextColor3 = Color3.new(1, 1, 1)
        selectButton.BackgroundTransparency = 1
        selectButton.Parent = itemFrame

        local deleteBtn = Instance.new("TextButton")
        deleteBtn.Name = "DeleteBtn"
        deleteBtn.Size = UDim2.new(0, 30, 1, 0)
        deleteBtn.Position = UDim2.new(1, -30, 0, 0)
        deleteBtn.AnchorPoint = Vector2.new(1, 0)
        deleteBtn.Text = "X"
        deleteBtn.Font = Enum.Font.SourceSansBold
        deleteBtn.TextSize = 16
        deleteBtn.TextColor3 = Color3.new(1, 1, 1)
        deleteBtn.BackgroundColor3 = Color3.fromRGB(255, 80, 80)
        deleteBtn.BorderSizePixel = 0
        deleteBtn.Parent = itemFrame
        local deleteCorner = Instance.new("UICorner"); deleteCorner.CornerRadius = UDim.new(0, 6); deleteCorner.Parent = deleteBtn

        local editBtn = Instance.new("TextButton")
        editBtn.Name = "EditBtn"
        editBtn.Size = UDim2.new(0, 30, 1, 0)
        editBtn.Position = UDim2.new(1, -65, 0, 0)
        editBtn.AnchorPoint = Vector2.new(1, 0)
        editBtn.Text = "..."
        editBtn.Font = Enum.Font.SourceSansBold
        editBtn.TextSize = 16
        editBtn.TextColor3 = Color3.new(1, 1, 1)
        editBtn.BackgroundColor3 = Color3.fromRGB(255, 170, 85)
        editBtn.BorderSizePixel = 0
        editBtn.Parent = itemFrame
        local editCorner = Instance.new("UICorner"); editCorner.CornerRadius = UDim.new(0, 6); editCorner.Parent = editBtn
        
        selectButton.MouseButton1Click:Connect(function()
                selectedCoordinate = nil
                for _, item in ipairs(savedList:GetChildren()) do
                        if item:IsA("Frame") then
                                item.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
                        end
                end
                itemFrame.BackgroundColor3 = Color3.fromRGB(85, 170, 255)
                selectedCoordinate = {index = i, data = coordData}
        end)
        
        deleteBtn.MouseButton1Click:Connect(function()
                table.remove(savedCoordinates, i)
                selectedCoordinate = nil
                refreshSavedList()
                showNotification("تم حذف الإحداثي بنجاح!")
        end)

        editBtn.MouseButton1Click:Connect(function()
                editFrame.Visible = true
                isEditGuiVisible = true
                editNameInput.Text = coordData.name
                editCoordsInput.Text = tostring(math.floor(coordData.position.X)) .. ", " .. tostring(math.floor(coordData.position.Y)) .. ", " .. tostring(math.floor(coordData.position.Z))
                
                local editSaveConnection
                editSaveConnection = editSaveButton.MouseButton1Click:Connect(function()
                        local newName = editNameInput.Text
                        local newCoordsString = editCoordsInput.Text
                        local newCoordsTable = {}
                        
                        for str in string.gmatch(newCoordsString, "[^,]+") do
                                local num = tonumber(str)
                                if num == nil then
                                        showNotification("الإحداثيات يجب أن تكون أرقامًا فقط!")
                                        return
                                end
                                table.insert(newCoordsTable, num)
                        end
                        
                        if #newCoordsTable ~= 3 then
                                showNotification("الرجاء إدخال 3 إحداثيات (X, Y, Z).")
                                return
                        end
                        
                        savedCoordinates[i].name = newName
                        savedCoordinates[i].position = Vector3.new(newCoordsTable[1], newCoordsTable[2], newCoordsTable[3])
                        
                        editFrame.Visible = false
                        isEditGuiVisible = false
                        refreshSavedList()
                        editSaveConnection:Disconnect()
                        showNotification("تم تعديل الإحداثي بنجاح!")
                end)
                
                local editCancelConnection
                editCancelConnection = editCancelButton.MouseButton1Click:Connect(function()
                        editFrame.Visible = false
                        isEditGuiVisible = false
                        editCancelConnection:Disconnect()
                end)
        end)
        
        totalHeight = totalHeight + 30 + listLayout.Padding.Offset
end

savedList.CanvasSize = UDim2.new(0, 0, 0, totalHeight)

end
mainToggleButton.MouseButton1Click:Connect(function() isMainGuiVisible = not isMainGuiVisible mainFrame.Visible = isMainGuiVisible
if isEditGuiVisible then
        editFrame.Visible = false
        isEditGuiVisible = false
end

end)
saveButton.MouseButton1Click:Connect(function() local coordsString = coordsInput.Text local name = nameInput.Text
if string.len(name) == 0 then
        showNotification("الرجاء إدخال اسم للإحداثي!")
        return
end

local coordsTable = {}
for str in string.gmatch(coordsString, "[^,]+") do
        local num = tonumber(str)
        if num == nil then
                showNotification("الإحداثيات يجب أن تكون أرقامًا فقط!")
                return
        end
        table.insert(coordsTable, num)
end

if #coordsTable ~= 3 then
        showNotification("الرجاء إدخال 3 إحداثيات (X, Y, Z).")
        return
end

local newCoord = {
        name = name,
        position = Vector3.new(coordsTable[1], coordsTable[2], coordsTable[3])
}

table.insert(savedCoordinates, newCoord)
refreshSavedList()

coordsInput.Text = ""
nameInput.Text = ""
showNotification("تم حفظ الإحداثي بنجاح!")

end)
goButton.MouseButton1Click:Connect(function() if not selectedCoordinate then showNotification("الرجاء تحديد إحداثي أولًا.") return end
local targetPosition = selectedCoordinate.data.position

local tweenInfo = TweenInfo.new(
        1.5,
        Enum.EasingStyle.Quart,
        Enum.EasingDirection.Out
)

local tween = TweenService:Create(rootPart, tweenInfo, {CFrame = CFrame.new(targetPosition)})
tween:Play()
showNotification("جارٍ الانتقال إلى " .. selectedCoordinate.data.name .. "...")

end)
refreshSavedList()
