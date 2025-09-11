local DataStoreService = game:GetService("DataStoreService")
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local coordsDataStore = DataStoreService:GetDataStore("PlayerCoordinatesV1")

local manageCoordsEvent = ReplicatedStorage:WaitForChild("ManageCoordsEvent")

Players.PlayerAdded:Connect(function(player)
    local success, savedCoords = pcall(function()
        return coordsDataStore:GetAsync("Coords_" .. player.UserId)
    end)
    
    if success and savedCoords then
        task.wait(1)
        manageCoordsEvent:FireClient(player, "Load", savedCoords)
    end
end)

manageCoordsEvent.OnServerEvent:Connect(function(player, action, coords)
    if action == "Save" then
        local success, err = pcall(function()
            coordsDataStore:SetAsync("Coords_" .. player.UserId, coords)
        end)
        if success then
            print("تم حفظ إحداثيات اللاعب:", player.Name)
            manageCoordsEvent:FireClient(player, "Update", "تم الحفظ بنجاح!")
        else
            warn("فشل حفظ البيانات للاعب:", player.Name, err)
            manageCoordsEvent:FireClient(player, "Update", "خطأ: لم يتم الحفظ")
        end
        
    elseif action == "Delete" then
        local success, err = pcall(function()
            coordsDataStore:RemoveAsync("Coords_" .. player.UserId)
        end)
        if success then
            print("تم حذف إحداثيات اللاعب:", player.Name)
            manageCoordsEvent:FireClient(player, "Load", "")
            manageCoordsEvent:FireClient(player, "Update", "تم الحذف بنجاح!")
        else
            warn("فشل حذف البيانات للاعب:", player.Name, err)
            manageCoordsEvent:FireClient(player, "Update", "خطأ: لم يتم الحذف")
        end
    end
end)
