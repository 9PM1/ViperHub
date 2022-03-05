
local class = {}; 
	local Mouse = game:GetService("Players").LocalPlayer:GetMouse()
	local flying = false
	local qe = true
	local vu = game:GetService("VirtualUser")
	local flyspeed = 1
	local flyspeed2 = 10

	local RunService = game:GetService("RunService"); 
	function class.getchildren(a, cb) 
		for i, v in next, a:GetChildren() do 
			cb(i, v); 
		end 
	end 
	function class.clickbtn(Btn)
		for i,v in pairs(getconnections(Btn.MouseButton1Click)) do
			v:Fire()
		 end

	end 
	function class.click()
		
			vu:CaptureController(Vector2.new(250,250))
			vu:Button1Down(Vector2.new(250,250))
	
	end 
	function class.setflyspeed(a)
		flyspeed2 = a 
	end 
	function class.fly()
			if flyKeyDown or flyKeyUp then
				flyKeyDown:Disconnect()
				flyKeyUp:Disconnect()
			end
			local T = game.Players.LocalPlayer.Character.HumanoidRootPart
			local direction = {
				F = 0,
				B = 0,
				L = 0,
				R = 0,
				Q = 0,
				E = 0
			}
			local lCONTROL = {
				F = 0,
				B = 0,
				L = 0,
				R = 0,
				Q = 0,
				E = 0
			}
			local SPEED = 0
			local function fly()
				flying = true
				local bg = Instance.new('BodyGyro')
				local bv = Instance.new('BodyVelocity')
				bg.P = 9e4
				bg.Parent = T
				bv.Parent = T
				bg.maxTorque = Vector3.new(9e9, 9e9, 9e9)
				bg.cframe = T.CFrame
				bv.velocity = Vector3.new(0, 0, 0)
				bv.maxForce = Vector3.new(9e9, 9e9, 9e9)
				spawn(function()
					repeat
						wait()
						if direction.L + direction.R ~= 0 or direction.F + direction.B ~= 0 or direction.Q + direction.E ~= 0 then
							SPEED = 50
						elseif not(direction.L + direction.R ~= 0 or direction.F + direction.B ~= 0 or direction.Q + direction.E ~= 0) and SPEED ~= 0 then
							SPEED = 0
						end
						if (direction.L + direction.R) ~= 0 or (direction.F + direction.B) ~= 0 or (direction.Q + direction.E) ~= 0 then
							bv.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (direction.F + direction.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(direction.L + direction.R, (direction.F + direction.B + direction.Q + direction.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
							lCONTROL = {
								F = direction.F,
								B = direction.B,
								L = direction.L,
								R = direction.R
							}
						elseif (direction.L + direction.R) == 0 and (direction.F + direction.B) == 0 and (direction.Q + direction.E) == 0 and SPEED ~= 0 then
							bv.velocity = ((workspace.CurrentCamera.CoordinateFrame.lookVector * (lCONTROL.F + lCONTROL.B)) + ((workspace.CurrentCamera.CoordinateFrame * CFrame.new(lCONTROL.L + lCONTROL.R, (lCONTROL.F + lCONTROL.B + direction.Q + direction.E) * 0.2, 0).p) - workspace.CurrentCamera.CoordinateFrame.p)) * SPEED
						else
							bv.velocity = Vector3.new(0, 0, 0)
						end
						bg.cframe = workspace.CurrentCamera.CoordinateFrame
					until not flying
					direction = {
						F = 0,
						B = 0,
						L = 0,
						R = 0,
						Q = 0,
						E = 0
					}
					lCONTROL = {
						F = 0,
						B = 0,
						L = 0,
						R = 0,
						Q = 0,
						E = 0
					}
					SPEED = 0
					bg:Destroy()
					bv:Destroy()
				end)
			end
			flyKeyDown = Mouse.KeyDown:Connect(function(key)
				if key:lower() == 'w' then
					if vfly then
						direction.F = flyspeed
					else
						direction.F = flyspeed2
					end
				elseif key:lower() == 's' then
					if vfly then
						direction.B = -flyspeed
					else
						direction.B = -flyspeed2
					end
				elseif key:lower() == 'a' then
					if vfly then
						direction.L = -flyspeed
					else
						direction.L = -flyspeed2
					end
				elseif key:lower() == 'd' then
					if vfly then
						direction.R = flyspeed
					else
						direction.R = flyspeed2
					end
				elseif qe and key:lower() == 'e' then
					if vfly then
						direction.Q = flyspeed * 2
					else
						direction.Q = flyspeed2 * 2
					end
				elseif qe and key:lower() == 'q' then
					if vfly then
						direction.E = -flyspeed * 2
					else
						direction.E = -flyspeed2 * 2
					end
				end
			end)
			flyKeyUp = Mouse.KeyUp:Connect(function(key)
				if key:lower() == 'w' then
			
					direction.F = 0
				elseif key:lower() == 's' then
					direction.B = 0
				elseif key:lower() == 'a' then
					direction.L = 0
				elseif key:lower() == 'd' then
					direction.R = 0
				elseif key:lower() == 'e' then
					direction.Q = 0
				elseif key:lower() == 'q' then
					direction.E = 0
				end
			end)
			fly()
			--class.fly()
		
	end 
	function class.unfly()
			flying = false
			if flyKeyDown or flyKeyUp then
				flyKeyDown:Disconnect()
				flyKeyUp:Disconnect()
			end
	end 
	function class.hop()
		local HttpService, TPService = game:GetService"HttpService", game:GetService"TeleportService";
		local OtherServers = HttpService:JSONDecode(game:HttpGet("https://games.roblox.com/v1/games/"..game.PlaceId.."/servers/Public?sortOrder=Asc&limit=100"))
		function joinNew()
			if not isfile('servers.sss') then 
				writefile('servers.sss',HttpService:JSONEncode({}))
			end
			local dontJoin = readfile('servers.sss') 
			dontJoin = HttpService:JSONDecode(dontJoin)
		
			for Index, Server in next, OtherServers["data"] do
				if Server ~= game.JobId then
					local j = true
					for a,c in pairs(dontJoin) do 
					   if c == Server.id then 
						   j = false 
					   end
					end
					if j then
						table.insert(dontJoin,Server["id"])
						writefile("servers.sss",HttpService:JSONEncode(dontJoin))
						wait()
						return Server['id']
						
						
					end
				end
			end
		end
		
		local server = joinNew()
		if not server then 
			writefile("servers.sss",HttpService:JSONEncode({}))
			local server = joinNew()
			TPService:TeleportToPlaceInstance(game.PlaceId, server)
		else
		TPService:TeleportToPlaceInstance(game.PlaceId, server)
		end
	end 
	function class.boostfps()
		pcall(function()
		
			local decalsyeeted = true
			local g = game
			local w = g.Workspace
			local l = g.Lighting
			local t = w.Terrain
			sethiddenproperty(l,"Technology",2)
			sethiddenproperty(t,"Decoration",false)
			t.WaterWaveSize = 0
			t.WaterWaveSpeed = 0
			t.WaterReflectance = 0
			t.WaterTransparency = 0
			l.GlobalShadows = false
			l.FogEnd = 9e9
			l.Brightness = 0
			settings().Rendering.QualityLevel = "Level01"
			for i, v in pairs(g:GetDescendants()) do
				if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
					v.Material = "Plastic"
					v.Reflectance = 0
				elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
					v.Transparency = 1
				elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
					v.Lifetime = NumberRange.new(0)
				elseif v:IsA("Explosion") then
					v.BlastPressure = 1
					v.BlastRadius = 1
				elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
					v.Enabled = false
				elseif v:IsA("MeshPart") then
					v.Material = "Plastic"
					v.Reflectance = 0
					v.TextureID = 10385902758728957
				end
			end
			for i, e in pairs(l:GetChildren()) do
				if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
					e.Enabled = false
				end
			end
	
		end)
	end 
	function class.create(class, data)
		local obj = Instance.new(class);
		for i, v in next, data do
			if i ~= 'Parent' then
				if typeof(v) == "Instance" then
					v.Parent = obj;
				else
					pcall(function()
						obj[i] = v  
					end)
				end
			end
		end
		obj.Parent = data.Parent;
		return obj
	end 
	function class.rejoin()
		game:GetService('TeleportService'):TeleportToPlaceInstance(game.PlaceId, game.JobId, game:GetService'Players'.LocalPlayer)
	end 
	function class.find(par, n) 
		return par:FindFirstChild(n); 
	end 
	function class.fetch(tbl, cb)
		for i, v in next, tbl do 
			cb(i, v); 
		end 
	end 
	function class.filter(par, filters)
		local results = {}
		for i, v in pairs(par:GetChildren()) do 
			for _, b in pairs(filters) do 
				pcall(function()
					if v[_] == b and not table.find(results, v) then  
						table.insert(results, v)
					end 
				end)
			end 
		end 
		return results 
	end 
	function class.noduplicate(tbl) 
		local newtbl = {};
		for i, v in pairs(tbl) do 
			newtbl[typeof(v) == "Instance" and v.Name or tostring(v)] = v  
		end 
		local finaltbl = {};
		for i, v in pairs(newtbl) do  
			finaltbl[#finaltbl + 1] = v 
		end 
		return finaltbl 
	end 
	function class.teleport(pos)
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos 
	end 
	function class.varible()
		local me = game.Players.LocalPlayer 
		return me, me.Character, me.Character.Humanoid, me.Character.HumanoidRootPart
	end 

	function class.loop(cd, cb) 
		local waittime = cd or 0
		return RunService.Heartbeat:Connect(function() 
			cb()    
			task.wait(waittime)
		end)
	end 
	function class.touch(part)
		if firetouchinterest then 
			firetouchinterest(game.Players.LocalPlayer.Character.PrimaryPart, part, 0)
			wait()
			firetouchinterest(game.Players.LocalPlayer.Character.PrimaryPart, part, 1) 
		end 
	end 


	return class 
