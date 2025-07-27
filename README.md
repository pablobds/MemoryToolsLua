## MemoryTools
esta em desenvolvimento ainda, por enquanto ele consegue 
escrever nos endereço específico

esse modulo foi feito com base no andlua por isso os "imports"

# Docs

### Estrutura 
Tabela com tipos de segmentação de memória
```lua
MemoryTools.TYPE_SEARCH = {    
  JAVA_HEAP = "java-heap",
  ANONYMOUS = "anonymous",
  STACK = "stack",
  LIBRARY = "library",
  UNKNOWN = "unknown"
}
```

### Tipos de dados
tipos de dados suportado 
```lua
MemoryTools.TYPE = {
  DWORD = {id = 1, type = "Dword"},
  FLOAT = {id = 2, type = "Float"},
}
```

### Construtor
```lua 
MemoryTools.new(pkg, typeSearch)
```
Cria uma nova instância da ferramenta de memória.
- pkg(string): pacote do app
- typeSearch(string): tipo de busca

```lua
local mt = MemoryTools.new("com.app.teste", "JAVA_HEAP")
```

### Metodos estaticos
- Verifica se o dispositivo possui acesso root
  
```lua 
MemoryTools.isRoot() -> boolean
```

- Obtém o PID de um app com base no nome do pacote.
```lua
MemoryTools.getPid(package: string) -> integer | nil
```

### Metodos de estância 
Escreve diretamente na memória do processo
```lua
self:writeMemory(address: table)
```

# MemoryAddress
Define objetos de endereço de memória, contendo o valor, tipo e conversão para formato binário.
Usado junto com o módulo MemoryTools

```lua
local MemoryAdress = require("MemoryAdress")
```

### Construtor 
Cria um novo objeto representando um endereço de memória.

- address(string)
- type(string)
- value(int ou string)
```lua
MemoryAdress.new(address, type, value)
```

# Exemplo de uso
```lua
local MemoryTools = require("MemoryTools")
local MemoryAdress = require("MemoryAdress")

local tool = MemoryTools.new("com.meuapp.alvo", "JAVA_HEAP")

local addr = MemoryAdress.new("CAFEBABE", "Dword", "1337")

tool:writeMemory(addr)
```
