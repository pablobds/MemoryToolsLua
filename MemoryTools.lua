-- By Created Pablo Bezerra
-- Github: https://github.com/pablobds

import "MemoryAdress"
luajava = luajava or require "luajava"

MemoryTools = {}
MemoryTools.__index = MemoryTools

MemoryTools.TYPE_SEARCH = {
  JAVA_HEAP = "java-heap",
  ANONYMOUS = "anonymous",
  STACK = "stack",
  LIBRARY = "library",
  UNKNOWN = "unknown"
}

MemoryTools.TYPE = {
  DWORD = {id = 1, type = "Dword"},
  FLOAT = {id = 2, type = "Float"},
}

function MemoryTools.new(pkg, typeSearch)
  local self= setmetatable({}, MemoryTools)
  self.package = pkg -- pacote
  self.searchType = MemoryTools.TYPE_SEARCH[typeSearch:upper()] or MemoryTools.SEARCH_TYPES.UNKNOWN -- tipo de pesquisa
  self.pid = MemoryTools.getPid(pkg)
  self.root = MemoryTools.isRoot()
  return self
end


-- Verificado se tem root
function MemoryTools.isRoot()
  local cmd = io.popen("su -c id 2>&1") -- executar um comando root

  if not cmd then -- se não tiver nada retorna false
    return false
  end

  local result = cmd:read("*a") or "" -- ler tudo
  cmd:close()
  return result:find("uid=0") ~= nil -- se tiver algo ele retorna
end

-- Pegar o id do processo
function MemoryTools.getPid(package)
  local cmd = io.popen("su -c 'ps | grep " .. package .. "'")


  for line in cmd:lines() do -- pecorre as linha
    local process = {}

    for word in line:gmatch("%S+") do -- divide as linha tipo o split - %S(qualquer caracteres que não seja espaco em branco, o S maiúsculo é o oposto de s, que representa espaços como espaço, tab, quebra de linha etc.) + Um ou mais desses caracteres
      table.insert(process, word) -- é tipo o append
    end


    local pid = tonumber(process[2]) -- converter em int,
    cmd:close() -- fechar processo de comando
    return pid
  end
  cmd:close() -- fechar processo de comando
  return nil
end

function MemoryTools:writeMemory(address)
  local tempFile = "/sdcard/Notes/" .. address.address .. self.package
  local f = io.open(tempFile, "wb") -- abrir arquivo temporario que será injetado os valores na memória

  if not f then return false end -- caso não conseguir abrir ele retorna false

  value = address.value


  value = address:valueConvert(value)

  f:write(value)
  f:close()


  local pid_ = tonumber(self.pid)
  -- print("DEBUG address.address =", address.address)
  local addr = tonumber(address.address, 16)

  if not pid_ then error("PID inválido: " .. tostring(self.pid)) end
  if not addr then error("Endereço inválido: " .. tostring(address.address)) end

  return os.execute(string.format(
  "su -c 'dd if=%s of=/proc/%d/mem bs=1 seek=%d conv=notrunc'",
  tempFile, pid_, math.floor(addr)
  ))

end


--[[
function MemoryTools:freezeValues(freeze_list)
  --local Thread = luajava.bindClass("java.lang.Thread")

  local function run(list, mt)
    require "import"
    local list = list -- garantir que é list em lua
    while true do
      for pos = 1, #list do -- ipairs e pairs não funciona no thread
        mt(list[pos])
        --Thread.sleep(1)
        --mt(list[pos])
      end
      --Thread.sleep(0)
      os.execute("su -c 'usleep 10000'")
    end
  end

  -- Criar uma função que mantém o contexto de self para writeMemory
  local writeClosure = function(addr)
    self:writeMemory(addr)
  end

  local theards = {}
  thread(run, freeze_list, writeClosure)
  thread(run, freeze_list, writeClosure)
  --thread(run, freeze_list, writeClosure)
  --thread(run, freeze_list, writeClosure)
end
]]-- caso não der certo usar este


function MemoryTools.isPath(path)
  local f = io.open(path, "r")
  if f ~= nil then
    local ok, err, code = f:read(1)
    f:close()
    return code == 21-- 21 = EISDIR (é diretório)
  end
  return false
end

return MemoryTools
