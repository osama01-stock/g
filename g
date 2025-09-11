 local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local isMenuVisible = false

local manageCoordsEvent = ReplicatedStorage:WaitForChild("ManageCoordsEvent")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "EnhancedMenuGui"
screenGui.Parent = playerGui
screenGui.ResetOnSpawn = false

local menuFrame = Instance.new("Frame")
menuFrame.Name = "MenuFrame"
menuFrame.Parent = screenGui
menuFrame.Size = UDim2.new(0, 300, 0, 400)
menuFrame.Position = UDim2.new(0.5, -150, 0.5, -200)
menuFrame.AnchorPoint = Vector2.new(0.5, 0.5)
menuFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
menuFrame.Visible = isMenuVisible
menuFrame.ClipsDescendants = true
local corner = Instance.new("UICorner"); corner.CornerRadius = UDim.new(0, 12); corner.Parent = menuFrame
local stroke = Instance.new("UIStroke"); stroke.Color = Color3.fromRGB(120, 120, 120); stroke.Thickness = 1; stroke.Parent = menuFrame

local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Parent = menuFrame
titleBar.Size = UDim2.new(1, 0, 0, 40)
titleBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
titleBar.BorderSizePixel = 0
local titleLabel = Instance.new("TextLabel")
titleLabel.Parent = titleBar
titleLabel.Size = UDim2.new(1, 0, 1, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "القائمة"
titleLabel.Font = Enum.Font.SourceSansBold
titleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLabel.TextSize = 18

local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Parent = screenGui
toggleButton.Size = UDim2.new(0, 50, 0, 50)
toggleButton.AnchorPoint = Vector2.new(0, 0.5)
toggleButton.Position = UDim2.new(0, 20, 0.5, 0)
toggleButton.Text = ">"
toggleButton.Font = Enum.Font.SourceSansBold
toggleButton.TextSize = 24
toggleButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
local btnCorner = Instance.new("UICorner"); btnCorner.CornerRadius = UDim.new(0, 8); btnCorner.Parent = toggleButton

local contentPadding = Instance.new("UIPadding")
contentPadding.PaddingTop = UDim.new(0, 45)
contentPadding.PaddingLeft = UDim.new(0, 10)
contentPadding.PaddingRight = UDim.new(0, 10)
contentPadding.Parent = menuFrame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 10)
listLayout.FillDirection = Enum.FillDirection.Vertical
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Parent = menuFrame

local getCoordsButton = Instance.new("TextButton")
getCoordsButton.Name = "GetCoordsButton"
getCoordsButton.Parent = menuFrame
getCoordsButton.LayoutOrder = 1
getCoordsButton.Size = UDim2.new(1, 0, 0, 40)
getCoordsButton.BackgroundColor3 = Color3.fromRGB(0, 122, 204)
getCoordsButton.Text = "جلب الإحداثيات الحالية"
getCoordsButton.Font = Enum.Font.SourceSansBold
getCoordsButton.TextColor3 = Color3.fromRGB(255, 255, 255)
getCoordsButton.TextSize = 16
local gcBtnCorner = Instance.new("UICorner"); gcBtnCorner.Parent = getCoordsButton

local coordsDisplay = Instance.new("TextBox")
coordsDisplay.Name = "CoordsDisplay"
coordsDisplay.Parent = menuFrame
coordsDisplay.LayoutOrder = 2
coordsDisplay.Size = UDim2.new(1, 0, 0, 50)
coordsDisplay.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
coordsDisplay.PlaceholderText = "الإحداثيات المحفوظة تظهر هنا..."
coordsDisplay.Text = ""
coordsDisplay.Font = Enum.Font.SourceSans
coordsDisplay.TextColor3 = Color3.fromRGB(220, 220, 220)
coordsDisplay.TextSize = 14
coordsDisplay.ClearTextOnFocus = false
coordsDisplay.TextEditable = false
local cdCorner = Instance.new("UICorner"); cdCorner.Parent = coordsDisplay
local buttonsContainer = Instance.new("Frame")
buttonsContainer.Parent = menuFrame
buttonsContainer.LayoutOrder = 3
buttonsContainer.Size = UDim2.new(1, 0, 0, 40)
buttonsContainer.BackgroundTransparency = 1
local gridLayout = Instance.new("UIGridLayout")
gridLayout.CellSize = UDim2.new(0.5, -5, 1, 0)
gridLayout.Parent = buttonsContainer

local saveButton = Instance.new("TextButton")
saveButton.Name = "SaveButton"
saveButton.Parent = buttonsContainer
saveButton.BackgroundColor3 = Color3.fromRGB(25, 135, 84)
saveButton.Text = "حفظ"
saveButton.Font = Enum.Font.SourceSansBold
saveButton.TextColor3 = Color3.fromRGB(255, 255, 255)
saveButton.TextSize = 16
local saveBtnCorner = Instance.new("UICorner"); saveBtnCorner.Parent = saveButton

local deleteButton = Instance.new("TextButton")
deleteButton.Name = "DeleteButton"
deleteButton.Parent = buttonsContainer
deleteButton.BackgroundColor3 = Color3.fromRGB(220, 53, 69)
deleteButton.Text = "حذف"
deleteButton.Font = Enum.Font.SourceSansBold
deleteButton.TextColor3 = Color3.fromRGB(255, 255, 255)
deleteButton.TextSize = 16
local delBtnCorner = Instance.new("UICorner"); delBtnCorner.Parent = deleteButton

local statusLabel = Instance.new("TextLabel")
statusLabel.Name = "StatusLabel"
statusLabel.Parent = menuFrame
statusLabel.LayoutOrder = 4
statusLabel.Size = UDim2.new(1, 0, 0, 25)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = ""
statusLabel.Font = Enum.Font.SourceSansItalic
statusLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
statusLabel.TextSize = 14

toggleButton.MouseButton1Click:Connect(function()
 isMenuVisible = not isMenuVisible
 menuFrame.Visible = isMenuVisible
 toggleButton.Text = isMenuVisible and "<" or ">"
end)

titleBar.InputBegan:Connect(function(input)
 if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
  local dragStart = input.Position
  local startPos = menuFrame.Position
  local connection
  connection = input.Changed:Connect(function()
   if input.UserInputState == Enum.UserInputState.End then
    connection:Disconnect()
   else
    local delta = input.Position - dragStart
    menuFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
   end
  end)
 end
end)

getCoordsButton.MouseButton1Click:Connect(function()
 local character = player.Character
 if character and character:FindFirstChild("HumanoidRootPart") then
  local pos = character.HumanoidRootPart.Position
  local posText = string.format("%.2f, %.2f, %.2f", pos.X, pos.Y, pos.Z)
  coordsDisplay.Text = posText
  statusLabel.Text = "تم جلب الإحداثيات الحالية."
 end
end)

saveButton.MouseButton1Click:Connect(function()
 if coordsDisplay.Text ~= "" then
  manageCoordsEvent:FireServer("Save", coordsDisplay.Text)
  statusLabel.Text = "جاري الحفظ..."
 else
  statusLabel.Text = "لا توجد إحداثيات للحفظ!"
 end
end)

deleteButton.MouseButton1Click:Connect(function()
 manageCoordsEvent:FireServer("Delete")
 statusLabel.Text = "جاري الحذف..."
end)

manageCoordsEvent.OnClientEvent:Connect(function(action, data)
 if action == "Load" then
  coordsDisplay.Text = data
 elseif action == "Update" then
  statusLabel.Text = data
 end
end)
