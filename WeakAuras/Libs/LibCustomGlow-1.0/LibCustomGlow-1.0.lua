local MAJOR_VERSION = "LibCustomGlow-1.0"
local MINOR_VERSION = 15
if not LibStub then error(MAJOR_VERSION .. " requires LibStub.") end
local lib, oldversion = LibStub:NewLibrary(MAJOR_VERSION, MINOR_VERSION)
if not lib then return end
local Masque = LibStub("Masque", true)

local textureList = {
	["empty"] = [[Interface\AddOns\WeakAuras\Libs\LibCustomGlow-1.0\AM_29]],
	["white"] = [[Interface\BUTTONS\WHITE8X8]],
	["shine"] = [[Interface\AddOns\WeakAuras\Libs\LibCustomGlow-1.0\Artifacts]]
}

function lib.RegisterTextures(texture, id)
	textureList[id] = texture
end

lib.glowList = {}
lib.startList = {}
lib.stopList = {}

local GlowParent = UIParent

local TexPoolResetter = function(pool, tex)
	tex:Hide()
	tex:ClearAllPoints()
end
local GlowTexPool = CreateTexturePool(GlowParent, "ARTWORK", 7, nil, TexPoolResetter)
lib.GlowTexPool = GlowTexPool

local FramePoolResetter = function(framePool, frame)
	frame:SetScript("OnUpdate", nil)

	local parent = frame:GetParent()
	if parent[frame.name] then
		parent[frame.name] = nil
	end

	if frame.textures then
		for _, texture in pairs(frame.textures) do
			GlowTexPool:Release(texture)
		end
	end

	frame.textures = {}
	frame.info = {}
	frame.name = nil
	frame.timer = nil
	frame:Hide()
	frame:ClearAllPoints()
end

local GlowFramePool = CreateFramePool("Frame", GlowParent, nil, FramePoolResetter)
lib.GlowFramePool = GlowFramePool

local function addFrameAndTex(r, color, name, key, N, xOffset, yOffset, texture, texCoord, desaturated, frameLevel)
	key = key or ""
	frameLevel = frameLevel or 8

	if not r[name..key] then
		r[name..key] = GlowFramePool:Acquire()
		r[name..key]:SetParent(r)
		r[name..key].name = name..key
	end

	local f = r[name..key]
	f:SetFrameLevel(r:GetFrameLevel() + frameLevel)
	f:SetPoint("TOPLEFT", r, "TOPLEFT", -xOffset + 0.05, yOffset + 0.05)
	f:SetPoint("BOTTOMRIGHT", r, "BOTTOMRIGHT", xOffset, -yOffset + 0.05)
	f:Show()

	if not f.textures then
		f.textures = {}
	end

	for i = 1, N do
		if not f.textures[i] then
			f.textures[i] = GlowTexPool:Acquire()
			f.textures[i]:SetTexture(texture)
			f.textures[i]:SetTexCoord(texCoord[1], texCoord[2], texCoord[3], texCoord[4])
		--	f.textures[i]:SetDesaturated(desaturated)
			f.textures[i]:SetParent(f)
			f.textures[i]:SetDrawLayer("ARTWORK")
		end

		f.textures[i]:SetVertexColor(color[1], color[2], color[3], color[4])
		f.textures[i]:Show()
	end

	while #f.textures > N do
		GlowTexPool:Release(f.textures[#f.textures])
		table.remove(f.textures)
	end
end


--Pixel Glow Functions--
local pBorders = {"TOPLEFT", "TOPRIGHT", "BOTTOMLEFT", "BOTTOMRIGHT", "TOP", "BOTTOM", "LEFT", "RIGHT"}

local pCalc1 = function(progress, s, th, p)
	local c
	if progress > p[3] or progress < p[0] then
		c = 0
	elseif progress > p[2] then
		c = s - th - (progress - p[2]) / (p[3] - p[2]) * (s - th)
	elseif progress > p[1] then
		c = s - th
	else
		c = (progress - p[0]) / (p[1] - p[0]) * (s - th)
	end
	return math.floor(c + 0.5)
end

local pCalc2 = function(progress, s, th, p)
	local c
	if progress > p[3] then
		c = s - th - (progress - p[3]) / (p[0] + 1 - p[3]) * (s - th)
	elseif progress > p[2] then
		c = s - th
	elseif progress > p[1] then
		c = (progress - p[1]) / (p[2] - p[1]) * (s - th)
	elseif progress > p[0] then
		c = 0
	else
		c = s - th - (progress + 1 - p[3]) / (p[0] + 1 - p[3]) * (s - th)
	end
	return math.floor(c + 0.5)
end

local pUpdate = function(self, elapsed)
	self.timer = self.timer + elapsed / self.info.period

	if self.timer > 1 or self.timer < -1 then
		self.timer = self.timer % 1
	end

	local progress = self.timer
	local width, height = self:GetSize()
	if width ~= self.info.width or height ~= self.info.height then
		local perimeter = 2 * (width + height)
		if not (perimeter > 0) then
			return
		end

		self.info.width = width
		self.info.height = height

		self.info.pTLx = {
			[0] = (height + self.info.length / 2) / perimeter,
			[1] = (height + width + self.info.length / 2) / perimeter,
			[2] = (2 * height + width - self.info.length / 2) / perimeter,
			[3] = 1 - self.info.length /2 / perimeter
		}
		self.info.pTLy = {
			[0] = (height - self.info.length / 2) / perimeter,
			[1] = (height + width + self.info.length / 2) / perimeter,
			[2] = (height * 2 + width + self.info.length / 2) / perimeter,
			[3] = 1 - self.info.length / 2 / perimeter
		}
		self.info.pBRx = {
			[0] = self.info.length / 2 / perimeter,
			[1] = (height - self.info.length / 2) / perimeter,
			[2] = (height + width - self.info.length / 2) / perimeter,
			[3] = (height * 2 + width + self.info.length / 2) / perimeter
		}
		self.info.pBRy = {
			[0] = self.info.length / 2 / perimeter,
			[1] = (height + self.info.length / 2) / perimeter,
			[2] = (height + width - self.info.length / 2) / perimeter,
			[3] = (height * 2 + width - self.info.length / 2) / perimeter
		}
	end

	if self:IsShown() then
		for k, line in pairs(self.textures) do
			line:SetPoint("TOPLEFT", self, "TOPLEFT",
				pCalc1((progress + self.info.step * (k - 1)) % 1, width, self.info.th, self.info.pTLx),
				-pCalc2((progress + self.info.step * (k - 1)) % 1, height, self.info.th, self.info.pTLy)
			)
			line:SetPoint("BOTTOMRIGHT", self, "TOPLEFT",
				self.info.th + pCalc2((progress + self.info.step * (k - 1)) % 1, width, self.info.th, self.info.pBRx),
				-height + pCalc1((progress + self.info.step * (k - 1)) % 1, height, self.info.th, self.info.pBRy)
			)
		end
	end
end

function lib.PixelGlow_Start(r, color, N, frequency, length, th, xOffset, yOffset, border, key, frameLevel)
	if not r then return end
	if not color then color = {0.95, 0.95, 0.32, 1} end
	if not (N and N > 0) then N = 8 end

	local period
	if frequency then
		if not (frequency > 0 or frequency < 0) then
			period = 4
		else
			period = 1 / frequency
		end
	else
		period = 4
	end

	local width,height = r:GetSize()
	length = length or math.floor((width + height) * (2 / N - 0.1))
	length = min(length, min(width, height))
	th = th or 1
	xOffset = xOffset or 0
	yOffset = yOffset or 0
	key = key or ""

	addFrameAndTex(r, color, "_PixelGlow", key, N, xOffset, yOffset, textureList.white, {0,1,0,1}, nil, frameLevel)
	local f = r["_PixelGlow"..key]

	f.timer = f.timer or 0
	f.info = f.info or {}
	f.info.step = 1/N
	f.info.period = period
	f.info.th = th
	if f.info.length ~= length then
		f.info.width = nil
		f.info.length = length
	end
	f:SetScript("OnUpdate",pUpdate)
end

function lib.PixelGlow_Stop(r,key)
	if not r then
		return
	end
	key = key or ""
	if not r["_PixelGlow"..key] then
		return false
	else
		GlowFramePool:Release(r["_PixelGlow"..key])
	end
end

table.insert(lib.glowList, "Pixel Glow")
lib.startList["Pixel Glow"] = lib.PixelGlow_Start
lib.stopList["Pixel Glow"] = lib.PixelGlow_Stop


--Autocast Glow Funcitons--
local function acUpdate(self,elapsed)
	local width,height = self:GetSize()
	if width ~= self.info.width or height ~= self.info.height then
		self.info.width = width
		self.info.height = height
		self.info.perimeter = 2*(width+height)
		self.info.bottomlim = height*2+width
		self.info.rightlim = height+width
		self.info.space = self.info.perimeter/self.info.N
	end

	local texIndex = 0;
	for k=1,4 do
		self.timer[k] = self.timer[k]+elapsed/(self.info.period*k)
		if self.timer[k] > 1 or self.timer[k] <-1 then
			self.timer[k] = self.timer[k]%1
		end
		for i = 1,self.info.N do
			texIndex = texIndex+1
			local position = (self.info.space*i+self.info.perimeter*self.timer[k])%self.info.perimeter
			if position>self.info.bottomlim then
				self.textures[texIndex]: SetPoint("CENTER",self,"BOTTOMRIGHT",-position+self.info.bottomlim,0)
			elseif position>self.info.rightlim then
				self.textures[texIndex]: SetPoint("CENTER",self,"TOPRIGHT",0,-position+self.info.rightlim)
			elseif position>self.info.height then
				self.textures[texIndex]: SetPoint("CENTER",self,"TOPLEFT",position-self.info.height,0)
			else
				self.textures[texIndex]: SetPoint("CENTER",self,"BOTTOMLEFT",0,position)
			end
		end
	end
end

function lib.AutoCastGlow_Start(r,color,N,frequency,scale,xOffset,yOffset,key,frameLevel)
	if not r then
		return
	end

	if not color then
		color = {0.95,0.95,0.32,1}
	end

	if not(N and N>0) then
		N = 4
	end

	local period
	if frequency then
		if not(frequency>0 or frequency<0) then
			period = 8
		else
			period = 1/frequency
		end
	else
		period = 8
	end
	scale = scale or 1
	xOffset = xOffset or 0
	yOffset = yOffset or 0
	key = key or ""

	addFrameAndTex(r,color,"_AutoCastGlow",key,N*4,xOffset,yOffset,textureList.shine,{0.8115234375,0.9169921875,0.8798828125,0.9853515625},true, frameLevel)
	local f = r["_AutoCastGlow"..key]
	local sizes = {7,6,5,4}
	for k,size in pairs(sizes) do
		for i = 1,N do
			f.textures[i+N*(k-1)]:SetSize(size*scale,size*scale)
		end
	end
	f.timer = f.timer or {0,0,0,0}
	f.info = f.info or {}
	f.info.N = N
	f.info.period = period
	f:SetScript("OnUpdate",acUpdate)
end

function lib.AutoCastGlow_Stop(r,key)
	if not r then
		return
	end

	key = key or ""
	if not r["_AutoCastGlow"..key] then
		return false
	else
		GlowFramePool:Release(r["_AutoCastGlow"..key])
	end
end

table.insert(lib.glowList, "Autocast Shine")
lib.startList["Autocast Shine"] = lib.AutoCastGlow_Start
lib.stopList["Autocast Shine"] = lib.AutoCastGlow_Stop

-- Animation Functions
local function InitAlphaAnimation(self)
	self.target = self.target or self:GetRegionParent()
	self.change = self.change or 0

	self.frameAlpha = self.target:GetAlpha()
	self.alphaFactor = self.frameAlpha + self.change - self.frameAlpha
end

local function TidyAlphaAnimation(self)
	self.alphaFactor = nil
	self.frameAlpha = nil
end

local function AlphaAnimation_OnUpdate(self, elapsed)
	local progress = self:GetSmoothProgress()
	if progress ~= 0 then
		if not self.played then
			InitAlphaAnimation(self)
			self.played = 1
		end

		if self.frameAlpha then
			self.target:SetAlpha(self.frameAlpha + self.alphaFactor * progress)

			if progress == 1 then
				TidyAlphaAnimation(self)
			end
		end
	end
end

local function AlphaAnimation_OnStop(self)
	if self.frameAlpha then
		TidyAlphaAnimation(self)
	end

	self.played = nil
end

local function CreateAlphaAnim(group, target, order, duration, change, delay, onPlay, onFinished)
	local alpha = group:CreateAnimation()

	if target then
		alpha.target = alpha:GetRegionParent()[target]
	end

	if order then
		alpha:SetOrder(order)
	end

	alpha:SetDuration(duration)
	alpha.change = change

	if delay then
		alpha:SetStartDelay(delay)
	end

	if onPlay then
		alpha:SetScript("OnPlay", onPlay)
	end

	alpha:SetScript("OnUpdate", AlphaAnimation_OnUpdate)
	alpha:SetScript("OnStop", AlphaAnimation_OnStop)
	alpha:SetScript("OnFinished", onFinished or AlphaAnimation_OnStop)
end

local function CreateBlizzAlphaAnim(group, order, duration, change, delay)
	local alpha = group:CreateAnimation("Alpha")

	if order then
		alpha:SetOrder(order)
	end

	alpha:SetDuration(duration)
	alpha:SetChange(change)

	if delay then
		alpha:SetStartDelay(delay)
	end
end

local function InitScaleAnimation(self)
	self.target = self.target or self:GetRegionParent()
	self.scaleX = self.scaleX or 0
	self.scaleY = self.scaleY or 0

	local _, _, width, height = self.target:GetRect()
	if not width then return end

	self.frameWidth = width
	self.frameHeight = height

	self.widthFactor = width * self.scaleX - width
	self.heightFactor = height * self.scaleY - height

	local setCenter
	local parent = self.target:GetParent()
	local numPoints = self.target:GetNumPoints()

	if numPoints > 0 then
		local point, relativeTo, relativePoint, xOffset, yOffset = self.target:GetPoint(1)

		if numPoints == 1 and point == "CENTER" then
			setCenter = false
		else
			local i = 1
			while true do
				if relativeTo ~= parent and yOffset then
					local j = #self + 1
					self[j], self[j + 1], self[j + 2], self[j + 3], self[j + 4] = point, relativeTo, relativePoint, xOffset, yOffset
				end

				i = i + 1
				if numPoints >= i then
					point, relativeTo, relativePoint, xOffset, yOffset = self.target:GetPoint(i)
				else
					break
				end
			end

			setCenter = true
		end
	else
		setCenter = true
	end

	if setCenter then
		local x, y = self.target:GetCenter()
		local parentX, parentY = parent:GetCenter()

		self.target:ClearAllPoints()
		self.target:SetPoint("CENTER", x - parentX, y - parentY)
	end

	return 1
end

local function TidyScaleAnimation(self)
	local target = self.target

	if #self ~= 0 then
		target:ClearAllPoints()

		for i = 1, #self, 5 do
			target:SetPoint(self[i], self[i + 1], self[i + 2], self[i + 3], self[i + 4])
			self[i] = nil
			self[i + 1] = nil
			self[i + 2] = nil
			self[i + 3] = nil
			self[i + 4] = nil
		end
	end

	self.widthFactor = nil
	self.heightFactor = nil

	self.frameWidth = nil
	self.frameHeight = nil
end

local function ScaleAnimation_OnUpdate(self, elapsed)
	local progress = self:GetSmoothProgress()
	if progress ~= 0 then
		if not self.played then
			if InitScaleAnimation(self) then
				self.played = 1
			end
		end

		if self.frameWidth then
			self.target:SetSize(self.frameWidth + self.widthFactor * progress, self.frameHeight + self.heightFactor * progress)

			if progress == 1 then
				TidyScaleAnimation(self)
			end
		end
	end
end

local function ScaleAnimation_OnStop(self)
	if self.frameWidth then
		TidyScaleAnimation(self)
	end

	self.played = nil
end

local function CreateScaleAnim(group, target, order, duration, x, y, delay, smoothing, onPlay)
	local scale = group:CreateAnimation()

	if target then
		scale.target = scale:GetRegionParent()[target]
	end

	scale:SetOrder(order)
	scale:SetDuration(duration)
	scale.scaleX, scale.scaleY = x, y

	if delay then
		scale:SetStartDelay(delay)
	end

	if smoothing then
		scale:SetSmoothing(smoothing)
	end

	if onPlay then
		scale:SetScript("OnPlay", onPlay)
	end

	scale:SetScript("OnUpdate", ScaleAnimation_OnUpdate)
	scale:SetScript("OnStop", ScaleAnimation_OnStop)
	scale:SetScript("OnFinished", ScaleAnimation_OnStop)
end

local function AnimateTexCoords(texture, textureWidth, textureHeight, frameWidth, frameHeight, numFrames, elapsed, throttle)
	if(not texture.frame) then
		texture.frame = 1;
		texture.throttle = throttle;
		texture.numColumns = floor(textureWidth / frameWidth);
		texture.numRows = floor(textureHeight / frameHeight);
		texture.columnWidth = frameWidth / textureWidth;
		texture.rowHeight = frameHeight / textureHeight;
	end

	local frame = texture.frame;

	if(not texture.throttle or texture.throttle > throttle) then
		local framesToAdvance = floor(texture.throttle / throttle);
		while(frame + framesToAdvance > numFrames) do
			frame = frame - numFrames;
		end

		frame = frame + framesToAdvance;
		texture.throttle = 0;

		local left = mod(frame - 1, texture.numColumns) * texture.columnWidth;
		local right = left + texture.columnWidth;
		local bottom = ceil(frame / texture.numColumns) * texture.rowHeight;
		local top = bottom - texture.rowHeight;
		texture:SetTexCoord(left, right, top, bottom);

		texture.frame = frame;
	else
		texture.throttle = texture.throttle + elapsed;
	end
end

--Action Button Glow--
local function ButtonGlowResetter(framePool,frame)
--	frame:SetScript("OnUpdate",nil)
	local parent = frame:GetParent()
	if parent._ButtonGlow then
		parent._ButtonGlow = nil
	end
	frame:Hide()
	frame:ClearAllPoints()
end
local ButtonGlowPool = CreateFramePool("Frame",GlowParent,nil,ButtonGlowResetter)
lib.ButtonGlowPool = ButtonGlowPool


local function AnimIn_OnPlay(anim)
	local frame = anim:GetRegionParent()
	local frameWidth, frameHeight = frame:GetSize()
	frame.spark:SetSize(frameWidth, frameHeight)
	frame.spark:SetAlpha(not(frame.color) and 1.0 or 0.3*frame.color[4])
	frame.innerGlow:SetSize(frameWidth / 2, frameHeight / 2)
	frame.innerGlow:SetAlpha(not(frame.color) and 1.0 or frame.color[4])
	frame.innerGlowOver:SetAlpha(not(frame.color) and 1.0 or frame.color[4])
	frame.outerGlow:SetSize(frameWidth * 2, frameHeight * 2)
	frame.outerGlow:SetAlpha(not(frame.color) and 1.0 or frame.color[4])
	frame.outerGlowOver:SetAlpha(not(frame.color) and 1.0 or frame.color[4])
	frame.ants:SetSize(frameWidth * 0.85, frameHeight * 0.85)
	frame.ants:SetAlpha(0)
	frame:Show()
end

local function AnimIn_OnFinished(group)
	local frame = group:GetParent()
	local frameWidth, frameHeight = frame:GetSize()
	frame.spark:SetAlpha(0)
	frame.innerGlow:SetAlpha(0)
	frame.innerGlow:SetSize(frameWidth, frameHeight)
	frame.innerGlowOver:SetAlpha(0.0)
	frame.outerGlow:SetSize(frameWidth, frameHeight)
	frame.outerGlowOver:SetAlpha(0.0)
	frame.outerGlowOver:SetSize(frameWidth, frameHeight)
	frame.ants:SetAlpha(not(frame.color) and 1.0 or frame.color[4])
end

local function AnimIn_OnStop(group)
	local frame = group:GetParent()
	frame.spark:SetAlpha(0)
	frame.innerGlow:SetAlpha(0)
	frame.innerGlowOver:SetAlpha(0.0)
	frame.outerGlowOver:SetAlpha(0.0)
end

local function bgHide(self)
	if self.animOut:IsPlaying() then
		self.animOut:Stop()
		ButtonGlowPool:Release(self)
	end
end

local function bgUpdate(self, elapsed)
	AnimateTexCoords(self.ants, 256, 256, 48, 48, 22, elapsed, self.throttle)
end

local function IsAnimPlaying(self)
	return self.isPlaying;
end

local function configureButtonGlow(f, alpha)
	f.spark = f:CreateTexture(nil, "BACKGROUND")
	f.spark:SetPoint("CENTER")
	f.spark:SetAlpha(0)
	f.spark:SetTexture([[Interface\AddOns\WeakAuras\Libs\LibCustomGlow-1.0\IconAlert]])
	f.spark:SetTexCoord(0.00781250, 0.61718750, 0.00390625, 0.26953125)

	-- inner glow
	f.innerGlow = f:CreateTexture(nil, "ARTWORK")
	f.innerGlow:SetPoint("CENTER")
	f.innerGlow:SetAlpha(0)
	f.innerGlow:SetTexture([[Interface\AddOns\WeakAuras\Libs\LibCustomGlow-1.0\IconAlert]])
	f.innerGlow:SetTexCoord(0.00781250, 0.50781250, 0.27734375, 0.52734375)
	f.innerGlow:Show()

	-- inner glow over
	f.innerGlowOver = f:CreateTexture(nil, "ARTWORK")
	f.innerGlowOver:SetPoint("TOPLEFT", f.innerGlow, "TOPLEFT")
	f.innerGlowOver:SetPoint("BOTTOMRIGHT", f.innerGlow, "BOTTOMRIGHT")
	f.innerGlowOver:SetAlpha(0)
	f.innerGlowOver:SetTexture([[Interface\AddOns\WeakAuras\Libs\LibCustomGlow-1.0\IconAlert]])
	f.innerGlowOver:SetTexCoord(0.00781250, 0.50781250, 0.53515625, 0.78515625)

	-- outer glow
	f.outerGlow = f:CreateTexture(nil, "ARTWORK")
	f.outerGlow:SetPoint("CENTER")
	f.outerGlow:SetAlpha(0)
	f.outerGlow:SetTexture([[Interface\AddOns\WeakAuras\Libs\LibCustomGlow-1.0\IconAlert]])
	f.outerGlow:SetTexCoord(0.00781250, 0.50781250, 0.27734375, 0.52734375)

	-- outer glow over
	f.outerGlowOver = f:CreateTexture(nil, "ARTWORK")
	f.outerGlowOver:SetPoint("TOPLEFT", f.outerGlow, "TOPLEFT")
	f.outerGlowOver:SetPoint("BOTTOMRIGHT", f.outerGlow, "BOTTOMRIGHT")
	f.outerGlowOver:SetAlpha(0)
	f.outerGlowOver:SetTexture([[Interface\AddOns\WeakAuras\Libs\LibCustomGlow-1.0\IconAlert]])
	f.outerGlowOver:SetTexCoord(0.00781250, 0.50781250, 0.53515625, 0.78515625)

	-- ants
	f.ants = f:CreateTexture(nil, "OVERLAY")
	f.ants:SetPoint("CENTER")
	f.ants:SetAlpha(0)
	f.ants:SetTexture([[Interface\AddOns\WeakAuras\Libs\LibCustomGlow-1.0\IconAlertAnts]])

	f.animIn = f:CreateAnimationGroup();
	f.animIn.appear = {}
	f.animIn.fade = {}
	CreateScaleAnim(f.animIn, "spark",			1, 0.2, 1.5, 1.5, nil, nil, AnimIn_OnPlay);
	CreateAlphaAnim(f.animIn, "spark",			1, 0.2, alpha, nil, nil, nil, true);
	CreateScaleAnim(f.animIn, "innerGlow",		1, 0.3, 2, 2);
	CreateScaleAnim(f.animIn, "innerGlowOver",	1, 0.3, 2, 2);
	CreateAlphaAnim(f.animIn, "innerGlowOver",	1, 0.3, alpha, nil, nil, nil, false);
	CreateScaleAnim(f.animIn, "outerGlow",		1, 0.3, 0.5, 0.5);
	CreateScaleAnim(f.animIn, "outerGlowOver",	1, 0.3, 0.5, 0.5);
	CreateAlphaAnim(f.animIn, "outerGlowOver",	1, 0.3, alpha, nil, nil, nil, false)
	CreateScaleAnim(f.animIn, "spark",			1, 0.2, 0.666666, 0.666666, 0.2);
	CreateAlphaAnim(f.animIn, "spark",			1, 0.2, alpha, 0.2, nil, nil, false);
	CreateAlphaAnim(f.animIn, "innerGlow",		1, 0.2, alpha, 0.3, nil, nil, false);
	CreateAlphaAnim(f.animIn, "ants",			1, 0.2, alpha, 0.3, nil, nil, true);
	f.animIn:SetScript("OnStop", AnimIn_OnStop)
	f.animIn:SetScript("OnFinished", AnimIn_OnFinished);

	f.animOut = f:CreateAnimationGroup();
	f.animOut.appear = {}
	f.animOut.fade = {}
	CreateAlphaAnim(f.animOut, "outerGlowOver",	1, 0.2, alpha, nil, nil, nil, true);
	CreateAlphaAnim(f.animOut, "ants",			1, 0.2, alpha, nil, nil, nil, false);
	CreateAlphaAnim(f.animOut, "outerGlowOver",	2, 0.2, alpha, nil, nil, nil, false);
	CreateAlphaAnim(f.animOut, "outerGlow",		2, 0.2, alpha, nil, nil, nil, false);
	f.animOut:SetScript("OnPlay", function(self) self.isPlaying = true; end);
	f.animOut:SetScript("OnStop", function(self) self.isPlaying = false; end);
	f.animOut:SetScript("OnFinished", function(self) self.isPlaying = false; ButtonGlowPool:Release(f) end);

	f.animOut.isPlaying = false;
	f.animOut.IsPlaying = IsAnimPlaying;

	f:SetScript("OnHide", bgHide)
end

local function updateAlphaAnim(f,alpha)
	for _,anim in pairs(f.animIn.appear) do
		anim.change = alpha
	end
	for _,anim in pairs(f.animIn.fade) do
		anim.change = -alpha
	end
	for _,anim in pairs(f.animOut.appear) do
		anim.change = alpha
	end
	for _,anim in pairs(f.animOut.fade) do
		anim.change = -alpha
	end
end

local ButtonGlowTextures = {["spark"] = true,["innerGlow"] = true,["innerGlowOver"] = true,["outerGlow"] = true,["outerGlowOver"] = true,["ants"] = true}

function lib.ButtonGlow_Start(r,color,frequency,frameLevel)
	if not r then
		return
	end
	frameLevel = frameLevel or 8;
	local throttle
	if frequency and frequency > 0 then
		throttle = 0.25/frequency*0.01
	else
		throttle = 0.01
	end
	if r._ButtonGlow then
		local f = r._ButtonGlow
		local width,height = r:GetSize()
		f:SetFrameLevel(r:GetFrameLevel()+frameLevel)
		f:SetSize(width*1.4 , height*1.4)
		f:SetPoint("TOPLEFT", r, "TOPLEFT", -width * 0.2, height * 0.2)
		f:SetPoint("BOTTOMRIGHT", r, "BOTTOMRIGHT", width * 0.2, -height * 0.2)
		f.ants:SetSize(width*1.4*0.85, height*1.4*0.85)
		AnimIn_OnFinished(f.animIn)
		if f.animOut:IsPlaying() then
			f.animOut:Stop()
			f.animIn:Play()
		end

		if not(color) then
			for texture in pairs(ButtonGlowTextures) do
			--	f[texture]:SetDesaturated(nil)
				f[texture]:SetVertexColor(1,1,1)
				f[texture]:SetAlpha(f[texture]:GetAlpha()/(f.color and f.color[4] or 1))
				updateAlphaAnim(f, 1)
			end
			f.color = false
		else
			for texture in pairs(ButtonGlowTextures) do
			--	f[texture]:SetDesaturated(1)
				f[texture]:SetVertexColor(color[1],color[2],color[3])
				f[texture]:SetAlpha(f[texture]:GetAlpha()/(f.color and f.color[4] or 1)*color[4])
				updateAlphaAnim(f,color and color[4] or 1)
			end
			f.color = color
		end
		f.throttle = throttle
	else
		local f, new = ButtonGlowPool:Acquire()
		if new then
			configureButtonGlow(f,color and color[4] or 1)
		else
			updateAlphaAnim(f,color and color[4] or 1)
		end
		r._ButtonGlow = f
		local width,height = r:GetSize()
		f:SetParent(r)
		f:SetFrameLevel(r:GetFrameLevel()+frameLevel)
		f:SetSize(width * 1.4, height * 1.4)
		f:SetPoint("TOPLEFT", r, "TOPLEFT", -width * 0.2, height * 0.2)
		f:SetPoint("BOTTOMRIGHT", r, "BOTTOMRIGHT", width * 0.2, -height * 0.2)
		if not(color) then
			f.color = false
			for texture in pairs(ButtonGlowTextures) do
			--	f[texture]:SetDesaturated(nil)
				f[texture]:SetVertexColor(1,1,1)
			end
		else
			f.color = color
			for texture in pairs(ButtonGlowTextures) do
			--	f[texture]:SetDesaturated(1)
				f[texture]:SetVertexColor(color[1],color[2],color[3])
			end
		end
		f.throttle = throttle
		f:SetScript("OnUpdate", bgUpdate)

		f.animIn:Play()

		if Masque and Masque.UpdateSpellAlert and (not r.overlay or not issecurevariable(r, "overlay")) then
			local old_overlay = r.overlay
			r.overlay = f
			Masque:UpdateSpellAlert(r)
			r.overlay = old_overlay
		end
	end
end

function lib.ButtonGlow_Stop(r)
	if r._ButtonGlow then
		if r._ButtonGlow.animIn:IsPlaying() then
			r._ButtonGlow.animIn:Stop()
			ButtonGlowPool:Release(r._ButtonGlow)
		elseif r:IsVisible() then
			r._ButtonGlow.animOut:Play()
		else
			ButtonGlowPool:Release(r._ButtonGlow)
		end
	end
end

table.insert(lib.glowList, "Action Button Glow")
lib.startList["Action Button Glow"] = lib.ButtonGlow_Start
lib.stopList["Action Button Glow"] = lib.ButtonGlow_Stop