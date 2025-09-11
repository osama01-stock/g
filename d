local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local savedCoordsList = {}

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "CoordsListGui"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

local menuFrame = Instance.new("Frame")
menuFrame.Name = "MenuFrame"
menuFrame.Parent = screenGui
menuFrame.Size = UDim2.new(0, 320, 0, 560)
menuFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
menuFrame.AnchorPoint = Vector2.new(0.5, 0.5)
menuFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
menuFrame.Visible = false
menuFrame.ClipsDescendants = true
menuFrame.Active = false
menuFrame.ZIndex = 2
local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0, 12); corner.Parent = menuFrame
local stroke = Instance.new("UIStroke"); stroke.Color = Color3.fromRGB(120, 120, 120); stroke.Thickness = 1; stroke.Parent = menuFrame

local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"; titleBar.Parent = menuFrame
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
titleBar.ZIndex = 3
local titleLabel = Instance.new("TextLabel")
titleLabel.Parent = titleBar; titleLabel.Size = UDim2.new(1, 0, 1, 0); titleLabel.BackgroundTransparency = 1
titleLabel.Text = "قائمة الإحداثيات"; titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255); titleLabel.TextSize = 18
titleLabel.ZIndex = 4

local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"; toggleButton.Parent = screenGui
toggleButton.Size = UDim2.new(0, 50, 0, 50); toggleButton.AnchorPoint = Vector2.new(0, 0.5)
toggleButton.Position = UDim2.new(0, 20, 0.5, 0); toggleButton.Text = ">"
toggleButton.Font = Enum.Font.SourceSansBold; toggleButton.TextSize = 24
toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.ZIndex = 5
local btnCorner = Instance.new("UICorner"); btnCorner.CornerRadius = UDim.new(0, 8); btnCorner.Parent = toggleButton

local mainContainer = Instance.new("Frame")
mainContainer.Name = "MainContainer"; mainContainer.Parent = menuFrame
mainContainer.BackgroundTransparency = 1; mainContainer.Position = UDim2.new(0,0,0,40)
mainContainer.Size = UDim2.new(1,0,1,-40)
mainContainer.ZIndex = 3
local padding = Instance.new("UIPadding"); padding.PaddingLeft = UDim.new(0,10); padding.PaddingRight = UDim.new(0,10); padding.PaddingTop = UDim.new(0,10); padding.PaddingBottom = UDim.new(0,10); padding.Parent = mainContainer
local listLayout = Instance.new("UIListLayout"); listLayout.Padding = UDim.new(0,10); listLayout.Parent = mainContainer

local aliasInput = Instance.new("TextBox")
aliasInput.Name = "AliasInput"; aliasInput.Parent = mainContainer
aliasInput.Size = UDim2.new(1, 0, 0, 40)
aliasInput.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
aliasInput.PlaceholderText = "ادخل الاسم المستعار للاحداثيات..."
aliasInput.Font = Enum.Font.SourceSans; aliasInput.TextColor3 = Color3.fromRGB(220, 220, 220); aliasInput.TextSize = 14
aliasInput.ZIndex = 3
local aliasCorner = Instance.new("UICorner"); aliasCorner.Parent = aliasInput

local saveButton = Instance.new("TextButton")
saveButton.Name = "SaveNewButton"; saveButton.Parent = mainContainer
saveButton.Size = UDim2.new(1, 0, 0, 40)
saveButton.BackgroundColor3 = Color3.fromRGB(25, 135, 84)
saveButton.Text = "حفظ الإحداثية الحالية بالاسم"
saveButton.Font = Enum.Font.SourceSansBold; saveButton.TextColor3 = Color3.fromRGB(255, 255, 255); saveButton.TextSize = 16
saveButton.ZIndex = 3
local saveCorner = Instance.new("UICorner"); saveCorner.Parent = saveButton

local copyAllButton = Instance.new("TextButton")
copyAllButton.Name = "CopyAllButton"; copyAllButton.Parent = mainContainer
copyAllButton.Size = UDim2.new(1, 0, 0, 40)
copyAllButton.BackgroundColor3 = Color3.fromRGB(13, 110, 253)
copyAllButton.Text = "نسخ جميع الإحداثيات"
copyAllButton.Font = Enum.Font.SourceSansBold; copyAllButton.TextColor3 = Color3.fromRGB(255, 255, 255); copyAllButton.TextSize = 16
copyAllButton.ZIndex = 3
local copyAllCorner = Instance.new("UICorner"); copyAllCorner.Parent = copyAllButton

local notesHeader = Instance.new("TextButton")
notesHeader.Name = "NotesHeader"; notesHeader.Parent = mainContainer
notesHeader.Size = UDim2.new(1, 0, 0, 30)
notesHeader.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
notesHeader.Text = "▼ ملاحظات هامة"
notesHeader.Font = Enum.Font.SourceSansBold; notesHeader.TextColor3 = Color3.fromRGB(200, 200, 200); notesHeader.TextSize = 16
notesHeader.TextXAlignment = Enum.TextXAlignment.Left; notesHeader.ZIndex = 3
local notesHeaderCorner = Instance.new("UICorner"); notesHeaderCorner.Parent = notesHeader
local notesHeaderPadding = Instance.new("UIPadding"); notesHeaderPadding.PaddingLeft = UDim.new(0, 10); notesHeaderPadding.Parent = notesHeader

local notesContentFrame = Instance.new("Frame")
notesContentFrame.Name = "NotesContent"; notesContentFrame.Parent = mainContainer
notesContentFrame.Size = UDim2.new(1, 0, 0, 80)
notesContentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30); notesContentFrame.BorderSizePixel = 0; notesContentFrame.Visible = false
notesContentFrame.ClipsDescendants = true; notesContentFrame.ZIndex = 3
local notesContentCorner = Instance.new("UICorner"); notesContentCorner.Parent = notesContentFrame

local notesTextLabel = Instance.new("TextLabel")
notesTextLabel.Name = "NotesText"; notesTextLabel.Parent = notesContentFrame
notesTextLabel.Size = UDim2.new(1, -20, 1, -20); notesTextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
notesTextLabel.AnchorPoint = Vector2.new(0.5, 0.5); notesTextLabel.BackgroundTransparency = 1
notesTextLabel.Text = "هناك مشكلة في زر النسخ وهي انه لا ينسخ بسبب تعطيل هذا الشيء من روبلوكس نفسها لاسباب امنيه ومنعها من بعض الدول."
notesTextLabel.Font = Enum.Font.SourceSans; notesTextLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
notesTextLabel.TextSize = 14; notesTextLabel.TextWrapped = true; notesTextLabel.TextXAlignment = Enum.TextXAlignment.Right
notesTextLabel.TextYAlignment = Enum.TextYAlignment.Center; notesTextLabel.ZIndex = 4

local aboutHeader = Instance.new("TextButton")
aboutHeader.Name = "AboutHeader"; aboutHeader.Parent = mainContainer
aboutHeader.Size = UDim2.new(1, 0, 0, 30)
aboutHeader.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
aboutHeader.Text = "▼ معلومات عن السكربت"
aboutHeader.Font = Enum.Font.SourceSansBold; aboutHeader.TextColor3 = Color3.fromRGB(200, 200, 200); aboutHeader.TextSize = 16
aboutHeader.TextXAlignment = Enum.TextXAlignment.Left; aboutHeader.ZIndex = 3
local aboutHeaderCorner = Instance.new("UICorner"); aboutHeaderCorner.Parent = aboutHeader
local aboutHeaderPadding = Instance.new("UIPadding"); aboutHeaderPadding.PaddingLeft = UDim.new(0, 10); aboutHeaderPadding.Parent = aboutHeader

local aboutContentFrame = Instance.new("Frame")
aboutContentFrame.Name = "AboutContent"; aboutContentFrame.Parent = mainContainer
aboutContentFrame.Size = UDim2.new(1, 0, 0, 60)
aboutContentFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30); aboutContentFrame.BorderSizePixel = 0; aboutContentFrame.Visible = false
aboutContentFrame.ClipsDescendants = true; aboutContentFrame.ZIndex = 3
local aboutContentCorner = Instance.new("UICorner"); aboutContentCorner.Parent = aboutContentFrame

local aboutTextLabel = Instance.new("TextLabel")
aboutTextLabel.Name = "AboutText"; aboutTextLabel.Parent = aboutContentFrame
aboutTextLabel.Size = UDim2.new(1, -20, 1, -20); aboutTextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
aboutTextLabel.AnchorPoint = Vector2.new(0.5, 0.5); aboutTextLabel.BackgroundTransparency = 1
aboutTextLabel.Text = "هذا السكربت فكرته اخذ الاحداثيات لتسهيل عمل فكرة انتقال.\nby vzx7"
aboutTextLabel.Font = Enum.Font.SourceSans; aboutTextLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
aboutTextLabel.TextSize = 14; aboutTextLabel.TextWrapped = true; aboutTextLabel.TextXAlignment = Enum.TextXAlignment.Right
aboutTextLabel.TextYAlignment = Enum.TextYAlignment.Center; aboutTextLabel.ZIndex = 4

local scrollingFrame = Instance.new("ScrollingFrame")
scrollingFrame.Name = "CoordsList"; scrollingFrame.Parent = mainContainer
scrollingFrame.Size = UDim2.new(1, 0, 1, -270) -- تعديل الحجم
scrollingFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35); scrollingFrame.BorderSizePixel = 0; scrollingFrame.CanvasSize = UDim2.new(0,0,0,0)
scrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(120,120,120); scrollingFrame.ScrollBarThickness = 6; scrollingFrame.ZIndex = 3
local scrollCorner = Instance.new("UICorner"); scrollCorner.Parent = scrollingFrame
local scrollStroke = Instance.new("UIStroke"); scrollStroke.Color = Color3.fromRGB(80, 80, 80); scrollStroke.Thickness = 1; scrollStroke.Parent = scrollingFrame
local scrollListLayout = Instance.new("UIListLayout"); scrollListLayout.Padding = UDim.new(0,5); scrollListLayout.Parent = scrollingFrame
local scrollPadding = Instance.new("UIPadding"); scrollPadding.PaddingLeft = UDim.new(0,5); scrollPadding.PaddingRight = UDim.new(0,5); scrollPadding.PaddingTop = UDim.new(0,5); scrollPadding.Parent = scrollingFrame

local entryTemplate = Instance.new("Frame")
entryTemplate.Name = "EntryTemplate"; entryTemplate.Parent = scrollingFrame; entryTemplate.Visible = false
entryTemplate.Size = UDim2.new(1, 0, 0, 40); entryTemplate.BackgroundColor3 = Color3.fromRGB(60, 60, 60); entryTemplate.ZIndex = 4
local templateLayout = Instance.new("UIListLayout"); templateLayout.FillDirection = Enum.FillDirection.Horizontal; templateLayout.Padding = UDim.new(0,5); templateLayout.VerticalAlignment = Enum.VerticalAlignment.Center; templateLayout.Parent = entryTemplate
local templatePadding = Instance.new("UIPadding"); templatePadding.PaddingLeft = UDim.new(0,5); templatePadding.Parent = entryTemplate
local nameLabel = Instance.new("TextLabel"); nameLabel.Name = "NameLabel"; nameLabel.Parent = entryTemplate
nameLabel.Size = UDim2.new(0.4, 0, 1, 0); nameLabel.BackgroundTransparency = 1; nameLabel.Font = Enum.Font.SourceSansBold
nameLabel.Text = "اسم مستعار"; nameLabel.TextColor3 = Color3.fromRGB(255,255,255); nameLabel.TextXAlignment = Enum.TextXAlignment.Left; nameLabel.ZIndex = 5
local coordsLabel = Instance.new("TextLabel"); coordsLabel.Name = "CoordsLabel"; coordsLabel.Parent = entryTemplate
coordsLabel.Size = UDim2.new(0.6, -90, 1, 0); coordsLabel.BackgroundTransparency = 1; coordsLabel.Font = Enum.Font.SourceSans
coordsLabel.Text = "123, 45, 678"; coordsLabel.TextColor3 = Color3.fromRGB(200,200,200); coordsLabel.TextXAlignment = Enum.TextXAlignment.Left; coordsLabel.ZIndex = 5

local copyEntryButton = Instance.new("TextButton"); copyEntryButton.Name = "CopyEntryButton"; copyEntryButton.Parent = entryTemplate
copyEntryButton.Size = UDim2.new(0, 40, 0, 32); copyEntryButton.BackgroundColor3 = Color3.fromRGB(108, 117, 125)
copyEntryButton.Text = "📋"; copyEntryButton.Font = Enum.Font.SourceSansBold; copyEntryButton.TextColor3 = Color3.fromRGB(255,255,255); copyEntryButton.TextSize = 18; copyEntryButton.ZIndex = 5
local copyEntryCorner = Instance.new("UICorner"); copyEntryCorner.CornerRadius = UDim.new(0,6); copyEntryCorner.Parent = copyEntryButton

local deleteButton = Instance.new("TextButton"); deleteButton.Name = "DeleteButton"; deleteButton.Parent = entryTemplate
deleteButton.Size = UDim2.new(0, 40, 0, 32); deleteButton.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
deleteButton.Text = "X"; deleteButton.Font = Enum.Font.SourceSansBold; deleteButton.TextColor3 = Color3.fromRGB(255,255,255); deleteButton.ZIndex = 5
local delCorner = Instance.new("UICorner"); delCorner.CornerRadius = UDim.new(0,6); delCorner.Parent = deleteButton

function refreshDisplay()
	for _, child in ipairs(scrollingFrame:GetChildren()) do
		if child:IsA("Frame") and child.Name ~= "EntryTemplate" then
			child:Destroy()
		end
	end
	
	for _, data in ipairs(savedCoordsList) do
		local newEntry = entryTemplate:Clone()
		newEntry.Name = data.name
		newEntry.NameLabel.Text = data.name
		newEntry.CoordsLabel.Text = data.coords
		newEntry.Visible = true
		newEntry.Parent = scrollingFrame
		
		newEntry.DeleteButton.MouseButton1Click:Connect(function()
			for i, entryData in ipairs(savedCoordsList) do
				if entryData == data then
					table.remove(savedCoordsList, i)
					break
				end
			end
			refreshDisplay()
		end)
		
		newEntry.CopyEntryButton.MouseButton1Click:Connect(function()
			local formattedString = string.format("الاسم: %s\nالاحداثي: %s", data.name, data.coords)
			UserInputService:SetClipboard(formattedString)
			
			local originalText = newEntry.CopyEntryButton.Text
			newEntry.CopyEntryButton.Text = "✓"
			task.wait(1.5)
			newEntry.CopyEntryButton.Text = originalText
		end)
	end
end

toggleButton.MouseButton1Click:Connect(function()
	menuFrame.Visible = not menuFrame.Visible
	menuFrame.Active = menuFrame.Visible
	toggleButton.Text = menuFrame.Visible and "<" or ">"
end)

aboutHeader.MouseButton1Click:Connect(function()
	aboutContentFrame.Visible = not aboutContentFrame.Visible
	aboutHeader.Text = aboutContentFrame.Visible and "▲ معلومات عن السكربت" or "▼ معلومات عن السكربت"
end)

notesHeader.MouseButton1Click:Connect(function()
	notesContentFrame.Visible = not notesContentFrame.Visible
	notesHeader.Text = notesContentFrame.Visible and "▲ ملاحظات هامة" or "▼ ملاحظات هامة"
end)

menuFrame.InputBegan:Connect(function(input)
	if not menuFrame.Visible then return end
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		local dragStart = input.Position
		local startPos = menuFrame.Position
		
		local connection = input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				connection:Disconnect()
			else
				local delta = input.Position - dragStart
				menuFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			end
		end)
	end
end)

saveButton.MouseButton1Click:Connect(function()
	local alias = aliasInput.Text
	if alias == "" then return end
	
	local character = player.Character
	if character and character:FindFirstChild("HumanoidRootPart") then
		local pos = character.HumanoidRootPart.Position
		local coordsText = string.format("%.2f, %.2f, %.2f", pos.X, pos.Y, pos.Z)
		
		table.insert(savedCoordsList, {name = alias, coords = coordsText})
		
		aliasInput.Text = ""
		refreshDisplay()
	end
end)

copyAllButton.MouseButton1Click:Connect(function()
	if #savedCoordsList == 0 then return end
	
	local lines = {}
	for _, data in ipairs(savedCoordsList) do
		table.insert(lines, string.format("%s: %s", data.name, data.coords))
	end
	
	local fullString = table.concat(lines, "\n")
	UserInputService:SetClipboard(fullString)
	
	local originalText = copyAllButton.Text
	copyAllButton.Text = "تم النسخ!"
	task.wait(2)
	copyAllButton.Text = originalText
end)
