
--print table
function printTab(tab)
  for i,v in pairs(tab) do
    if type(v) == "table" then
      print("table",i,"{")
      printTab(v)
      print("}")
    else
     print(v)
    end
  end
end

-- change table to enum type
function CreateEnumTable(tbl, index)
    local enumTable = {}
    local enumIndex = index or -1
    for i, v in ipairs(tbl) do
        enumTable[v] = enumIndex + i
    end
    return enumTable
end


function removeAll(tempTable)
    if tempTable~=nil and type(tempTable) == "table" then
        while true do
            local k =next(tempTable)
            if not k then break end
            tempTable[k] = nil
        end
    end
end

List = {}
function List.new()
	return {first = 0, last = -1}
end

function List.pushfirst(list, value)
	local first = list.first - 1
	list.first = first
	list[first] = value
end

function List.pushlast(list, value)
	local last = list.last + 1
	list.last = last
	list[last] = value
end

function List.popfirst(list)
	local first = list.first
	if first > list.last then return nil end
	local value = list[first]
	list[first] = nil
	list.first = first + 1
	return value
end

function List.poplast(list)
	local last = list.last
	if list.first > last then return nil end
	local value = list[last]
	list[last] = nil
	list.last = last - 1
	return value	
end

function List.removeAll(list)
    removeAll(list)
    list.first = 0
    list.last = -1
end

function List.getSize(list)
    return list.last - list.first + 1
end

function List.first(list)
    local value = nil
    if list.first <= list.last then
        value = list[first]
    end
    
    return value
end

function List.remove(list, index)
    if index < list.first or index > list.last then return false end
    
    while index <= list.last do
        list[index] = nil
        list[index] = list[index+1]
        index = index + 1
    end
    
    list.last = list.last -1
    return true
end

function List.removeObj(list, obj)
    if obj == nil or List.getSize(list) == 0 then return false end
    
    for index=list.first, list.last do
    	if list[index] == obj then
    		List.remove(list,index)
            return true
    	end
    end
    return false    
end

function copyTable(t1, t2)
    if t1 == nil then return end

    for key, var in pairs(t1) do
        t2[key] = var
    end
end

-- getpostable
function getPosTable(obj)
    if obj==nil then
        return {x= 0,y=0} 
    end
    local posX,posY = obj:getPosition()
    return {x= posX,y=posY} 
end

function getContenSize(obj)
    if obj==nil then
        return {width=0,height=0} 
    end
    local w,h = obj:getContentSize()
    return {width=w,height=h} 
end
