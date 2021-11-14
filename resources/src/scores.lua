local Object = Object or require "resources/lib/classic"
Scores = Object:extend()

function Scores:new()
  spriteScoresMenu = love.graphics.newImage("resources/images/menu/spriteScoresMenu.png")
  scoreFont = love.graphics.newFont("resources/font/Nechao Sharp.ttf")
  interactSound = love.audio.newSource("resources/audio/sound/interactSound.wav", "static")
end

function Scores:update(dt)   
  function love.keypressed(key)
    if key == "escape" or key == "return" or key == "space" then
      state = "mainMenu"
      love.audio.play(interactSound)
    end
  end
end

function Scores:draw()
  love.graphics.draw(spriteScoresMenu)
  
  PrintScores(LoadedFile)
end

--Lista de Highscores por defecto, siempre tiene que haber uno como mínimo
LoadedFile = {
  {"Marco" , 2350},
  {"Pablo" , 1634},
}

--Guardar Highscores
function SaveScore(Scores)      
  local FinalScores = TableStringToHybridTable(Scores)
  local StringScores = iterate(FinalScores)
      
  --Esta parte guarda el score final
  love.filesystem.write("SaveLoad.txt", StringScores)
end

--Transforma los strings del LoadedFile en una tabla de tablas lista para el iterate
function TableStringToHybridTable(LoadedFile)
  ReturnTable = {}
  ReturnSubTable = {}
  
  recievedString1 = ""
  recievedString2 = ""
  StringSwitcherBool = false
  
  for k,v in ipairs(LoadedFile) do
    
    recievedString1 = ""
    recievedString2 = ""
    StringSwitcherBool = false
    ReturnSubTable = {}
    
    for c in string.gmatch(v,".") do
      if (c == ",")then
        StringSwitcherBool = true
      else
        if (StringSwitcherBool) then
          recievedString2 = recievedString2..c
        else
          recievedString1 = recievedString1..c
        end
      end
    end
    
    table.insert(ReturnTable, {recievedString1 , recievedString2})
  end
  return ReturnTable
end

--Transforma la tabla en un string serializado con saltos de línea
function iterate(ScoreTable)
  local returnString = "{"
  
  for k,v in ipairs(ScoreTable) do  
    if type(v)=="table" then 
      returnString = returnString..iterate(v)..','.."\n"
    else 
      returnString = returnString..v..","
   end
  end
  
  return returnString.."}"
end

--Carga los scores y si no existe el archivo crea uno con las scores por defecto
function LoadScores()
  local LocalLoadedFile = {}
  i = 1
  local TableLength = 0
  
  if (love.filesystem.getInfo("SaveLoad.txt") == nil) then
    tempsString = iterate(LoadedFile)
    love.filesystem.write("SaveLoad.txt", tempsString)
  end

  for lines in love.filesystem.lines("SaveLoad.txt") do
    TableLength = TableLength + 1
  end
  
  for lines in love.filesystem.lines("SaveLoad.txt") do
    if (i == TableLength) then
    else
      local tempLine = lines
      if (i == 1) then
        tempLine = tempLine:sub( 3, #tempLine - 3)
      else
      tempLine = tempLine:sub( 2, #tempLine - 3)
      end
      table.insert(LocalLoadedFile, tempLine)
    end
    i = i +1
  end
  
  LoadedFile = LocalLoadedFile
  
  --Esto se usa para comparar y reordenar los highscores
  ----CompareScores(playerName, playerScore)
end

--Compara los scores, los remplaza y los printea
function CompareScores(PlayerName, ScoreToCompare)
  for k,_ in ipairs(LoadedFile) do
    SubTableIndex, SubTable = GetSpecificSubTable(LoadedFile, k)
    if (k <= 10) then
      if (tonumber(SubTable[SubTableIndex]) > ScoreToCompare) then
      else
        ScoreAddedBool = true
        SetSpecificSubTable(LoadedFile, k, PlayerName, ScoreToCompare, GetLoadedFileLength())
        break
      end
    end
  end
end

--Dibuja los 10 highscores en el menú
function PrintScores(LoadedFile)
  local SubTable = {}
  
  widthName = love.graphics.getWidth() / 2 - 600
  widthTime = love.graphics.getWidth() / 2 + 480
  height = love.graphics.getHeight() / 2 - 210

  for k,v in ipairs(LoadedFile) do
    SubTable = LoadedFile[k]
    Index, Table = StringToTable(SubTable)
  
    local tableValue = tostring(Table[Index])
    local DividedValue = ""
    local i = 0
    for c in string.gmatch(tableValue,".") do
      if (i == 2 or i == 4) then
        DividedValue = DividedValue..":"
      end
      DividedValue = DividedValue..c
      i = i + 1
    end
    
    love.graphics.print(Index, widthName, height)
    love.graphics.print(DividedValue, widthTime, height)
    height = height + 70
  end
end

--Devuelve en forma de tabla una línea en concreto del LoadedFile
function GetSpecificSubTable(LoadedFile, SubTableIndex)
  local SubTable = LoadedFile[SubTableIndex]
  local Index, Table = StringToTable(SubTable)
  
  return Index, Table
end

--Sustituye una línea especifica del LoadedFile y reordena el resto que haya por debajo
function SetSpecificSubTable(LoadedFile, SubTableIndex, NewKey, NewValue, LoadedFileLength)
  local OldKey = ""
  local OldValue = ""
  
  if SubTableIndex <= 10 then
    if (SubTableIndex > LoadedFileLength) then
    else 
      OldKey, OldTable = GetSpecificSubTable(LoadedFile, SubTableIndex)
    
      OldValue = OldTable[OldKey]
    end
  
    LoadedFile[SubTableIndex] = NewKey..","..NewValue

    if (SubTableIndex > LoadedFileLength) then
  
    else
      SubTableIndex = SubTableIndex + 1
      SetSpecificSubTable(LoadedFile, SubTableIndex, OldKey, OldValue, LoadedFileLength)
    end
  end
end

--Transforma un string en una tabla
function StringToTable(stringToConvert)
  ReturnTable = {}
  
  recievedString1 = ""
  recievedString2 = ""
  StringSwitcherBool = false
  
  for c in string.gmatch(stringToConvert,".") do
    if (c == ",")then
      StringSwitcherBool = true
    else
      if (StringSwitcherBool) then
      recievedString2 = recievedString2..c
      else
      recievedString1 = recievedString1..c
      end
    end
  end
  
  ReturnTable[recievedString1] = recievedString2
  return recievedString1,ReturnTable
end

--Devuelve el tamaño de la lista
function GetLoadedFileLength()
  local TableLength = 0
  
  for k,_ in ipairs(LoadedFile) do
  TableLength = TableLength+1
  end
  
  return TableLength
end

return Scores