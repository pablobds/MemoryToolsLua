--[[

   Objeto de endereço 

]]--


MemoryAdress = {}
MemoryAdress.__index = MemoryAdress

function MemoryAdress.new(address, type, value)
  local self = setmetatable({}, MemoryAdress)
  self.address = tostring(address)
  self.type = type
  self.value = string.lower(value)
  return self
end

function MemoryAdress:toString()
  return string.format("Addr: %s | Type: %s | Value: %s", self.address, self.type, tostring(self.value))
end

function MemoryAdress:valueConvert(value)
  value = string.lower(value) or self.value

  if self.type == "Dword" then
    return string.pack("<I4", value)

   elseif self.type == "Float" then
    return string.pack("<f", value)
  end
  return nil
end


return MemoryAdress
