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

