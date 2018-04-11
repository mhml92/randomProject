ResourceManager = Class('ResourceManager')


function ResourceManager:initialize()
	self.images = {}
	self.sounds = {}
	self.fonts = {}
	self.soundGroups = {}
	self:loadAssets("Game/assets")

	if Global.DEBUG_MODE then
		print("IMAGES:")
		for k,v in pairs(self.images) do
			print("",k)
		end
	end

end

function ResourceManager:loadAssets(dir)
	local files = love.filesystem.getDirectoryItems(dir)
	for k,v in ipairs(files) do
		local item = dir .."/" .. v
		if love.filesystem.isDirectory(item) then
			if string.lower(string.sub(v,1,11)) == "soundgroup_" then
				local soundGroupName = string.sub(v,12)
				self:loadSoundGroup(dir,v,soundGroupName)
			end
			self:loadAssets(item)
		elseif love.filesystem.isFile(item) then
			local tokens = self:split(v,"\\.")
			for _,token in ipairs(tokens) do
				if token == "mp3" then
					self:loadSound(item)
				elseif token == "png" then
					self:loadImage(item)
				elseif token == "ttf" then
					self:loadFont(item)
				end
			end
		else
			print("Unknown folder element: " .. v)
		end
	end
end

function ResourceManager:loadSoundGroup(dir,v,name)
	local sgdir = dir .."/"..v
	local files = love.filesystem.getDirectoryItems(sgdir)

	self.soundGroups[name] = {}
	for k,f in ipairs(files) do
		self.sounds[f] = love.audio.newSource(sgdir .. "/" .. f)
		table.insert(self.soundGroups[name],f)
	end
end

function ResourceManager:loadSound(item)
	self.sounds[item] = love.audio.newSource(item)
end

function ResourceManager:loadImage(item)
	self.images[item] = love.graphics.newImage(item)
end

function ResourceManager:loadFont(item)
	self.fonts[item] = love.graphics.newFont(item, 40)
end

function ResourceManager:getImg(name)
	if self.images[name] then
		return self.images[name]
	end
end

function ResourceManager:getSound(name)
	if self.sounds[name] then
		return self.sounds[name]
	end
end

function ResourceManager:getFont(name)
	if self.fonts[name] then
		return self.fonts[name]
	end
end

function ResourceManager:split(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t

end

return ResourceManager
