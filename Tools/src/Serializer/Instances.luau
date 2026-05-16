return {
	Part = {
		{"Name", "string", "Part"},
		{"Anchored", "boolean", false},
		{"CanCollide", "boolean", true},
		{"CanTouch", "boolean", true},
		{"CanQuery", "boolean", true},
		{"Massless", "boolean", false},
		{"Locked", "boolean", false},
		{"Transparency", "number", 0},
		{"Reflectance", "number", 0},
		{"CastShadow", "boolean", true},
		{"Material", "EnumItem", Enum.Material.Plastic},
		{"Color", "Color3", Color3.fromRGB(163, 162, 165)},
		{"Size", "Vector3", Vector3.new(4, 1, 2)},
		{"CFrame", "CFrame", CFrame.identity},
		{"Shape", "EnumItem", Enum.PartType.Block},
		{"TopSurface", "EnumItem", Enum.SurfaceType.Smooth},
		{"BottomSurface", "EnumItem", Enum.SurfaceType.Smooth},
		{"LeftSurface", "EnumItem", Enum.SurfaceType.Smooth},
		{"RightSurface", "EnumItem", Enum.SurfaceType.Smooth},
		{"FrontSurface", "EnumItem", Enum.SurfaceType.Smooth},
		{"BackSurface", "EnumItem", Enum.SurfaceType.Smooth},
	},

	MeshPart = {
		{"Name", "string", "MeshPart"},
		{"Anchored", "boolean", false},
		{"CanCollide", "boolean", true},
		{"CanTouch", "boolean", true},
		{"CanQuery", "boolean", true},
		{"Massless", "boolean", false},
		{"Transparency", "number", 0},
		{"Reflectance", "number", 0},
		{"CastShadow", "boolean", true},
		{"Material", "EnumItem", Enum.Material.Plastic},
		{"Color", "Color3", Color3.fromRGB(163, 162, 165)},
		{"Size", "Vector3", Vector3.new(1, 1, 1)},
		{"CFrame", "CFrame", CFrame.identity},
		{"MeshId", "string", ""},
		{"TextureID", "string", ""},
	},

	Model = {
		{"Name", "string", "Model"},
	},

	Folder = {
		{"Name", "string", "Folder"},
	},

	WedgePart = {
		{"Name", "string", "Wedge"},
		{"Anchored", "boolean", false},
		{"CanCollide", "boolean", true},
		{"CastShadow", "boolean", true},
		{"Transparency", "number", 0},
		{"Material", "EnumItem", Enum.Material.Plastic},
		{"Color", "Color3", Color3.fromRGB(163, 162, 165)},
		{"Size", "Vector3", Vector3.new(4, 1, 2)},
		{"CFrame", "CFrame", CFrame.identity},
	},

	CornerWedgePart = {
		{"Name", "string", "CornerWedge"},
		{"Anchored", "boolean", false},
		{"CanCollide", "boolean", true},
		{"CastShadow", "boolean", true},
		{"Transparency", "number", 0},
		{"Material", "EnumItem", Enum.Material.Plastic},
		{"Color", "Color3", Color3.fromRGB(163, 162, 165)},
		{"Size", "Vector3", Vector3.new(4, 1, 2)},
		{"CFrame", "CFrame", CFrame.identity},
	},

	TrussPart = {
		{"Name", "string", "Truss"},
		{"Anchored", "boolean", false},
		{"CanCollide", "boolean", true},
		{"CastShadow", "boolean", true},
		{"Transparency", "number", 0},
		{"Material", "EnumItem", Enum.Material.Metal},
		{"Color", "Color3", Color3.fromRGB(163, 162, 165)},
		{"Size", "Vector3", Vector3.new(2, 2, 2)},
		{"CFrame", "CFrame", CFrame.identity},
		{"Style", "EnumItem", Enum.Style.AlternatingSupports},
	},

	Decal = {
		{"Name", "string", "Decal"},
		{"Texture", "string", ""},
		{"Transparency", "number", 0},
		{"Color3", "Color3", Color3.new(1, 1, 1)},
		{"Face", "EnumItem", Enum.NormalId.Front},
	},

	Texture = {
		{"Name", "string", "Texture"},
		{"Texture", "string", ""},
		{"Transparency", "number", 0},
		{"Color3", "Color3", Color3.new(1, 1, 1)},
		{"Face", "EnumItem", Enum.NormalId.Front},
		{"StudsPerTileU", "number", 1},
		{"StudsPerTileV", "number", 1},
		{"OffsetStudsU", "number", 0},
		{"OffsetStudsV", "number", 0},
	},

	PointLight = {
		{"Name", "string", "PointLight"},
		{"Brightness", "number", 1},
		{"Range", "number", 8},
		{"Color", "Color3", Color3.new(1, 1, 1)},
		{"Enabled", "boolean", true},
		{"Shadows", "boolean", false},
	},

	SpotLight = {
		{"Name", "string", "SpotLight"},
		{"Brightness", "number", 1},
		{"Range", "number", 8},
		{"Angle", "number", 45},
		{"Face", "EnumItem", Enum.NormalId.Front},
		{"Color", "Color3", Color3.new(1, 1, 1)},
		{"Enabled", "boolean", true},
		{"Shadows", "boolean", false},
	},

	SurfaceLight = {
		{"Name", "string", "SurfaceLight"},
		{"Brightness", "number", 1},
		{"Range", "number", 8},
		{"Angle", "number", 90},
		{"Face", "EnumItem", Enum.NormalId.Front},
		{"Color", "Color3", Color3.new(1, 1, 1)},
		{"Enabled", "boolean", true},
		{"Shadows", "boolean", false},
	},

	Configuration = {
		{"Name", "string", "Configuration"}
	},
	
	Fire = {
		{"Color", "Color3", Color3.fromRGB(236, 139, 70)},
		{"Enabled", "boolean", true},
		{"Heat", "number", 9},
		{"Name", "string", "Fire"},
		{"SecondaryColor", "Color3", Color3.fromRGB(139, 80, 55)},
		{"Size", "number", 5},
		{"TimeScale", "number", 1}
	},
	
	ParticleEmitter = {
		{"Brightness", "number", 1},
		{"Color", "ColorSequence", ColorSequence.new(Color3.new(1, 1, 1))},
		{"LightEmission", "number", 0.5},
		{"LightInfluence", "number", 0},
		{"Orientation", "EnumItem", Enum.ParticleOrientation.FacingCamera},
		{"Size", "NumberSequence", NumberSequence.new(1)},
		{"Squash", "NumberSequence", NumberSequence.new(0)},
		{"Texture", "string", "rbxasset://textures/particles/sparkles_main.dds"},
		{"Transparency", "NumberSequence", NumberSequence.new(0)},
		{"ZOffset", "number", 0},
		{"EmissionDirection", "EnumItem", Enum.NormalId.Top},
		{"Enabled", "boolean", true},
		{"Lifetime", "NumberRange", NumberRange.new(5, 10)},
		{"Rate", "number", 20},
		{"Rotation", "NumberRange", NumberRange.new(0)},
		{"RotSpeed", "NumberRange", NumberRange.new(0)},
		{"Speed", "NumberRange", NumberRange.new(5)},
		{"SpreadAngle", "Vector2", Vector2.new(0, 0)},
		{"Shape", "EnumItem", Enum.ParticleEmitterShape.Box},
		{"ShapeInOut", "EnumItem", Enum.ParticleEmitterShapeInOut.Outward},
		{"ShapeStyle", "EnumItem", Enum.ParticleEmitterShapeStyle.Volume},
		{"Acceleration", "Vector3", Vector3.new(0, 0, 0)},
		{"Drag", "number", 0},
		{"LockedToPart", "boolean", false},
		{"TimeScale", "number", 1},
		{"VelocityInheritance", "number", 0},
		{"WindAffectsDrag", "boolean", 0},
	},
	
	SpecialMesh = {
		{"MeshId", "string", ""},
		{"MeshType", "EnumItem", Enum.MeshType.Head},
		{"Name", "string", "SpecialMesh"},
		{"Offset", "Vector3", Vector3.new(0, 0, 0)},
		{"Scale", "Vector3", Vector3.new(1, 1, 1)},
		{"VertexColor", "Vector3", Vector3.new(1, 1, 1)}
	},
	
	Sky = {
		{"CelestialBodiesShown", "boolean", true},
		{"MoonAngularSize", "number", 11},
		{"MoonTextureId", "string", "rbxasset://sky/moon.jpg"},
		{"SkyboxBk", "string", "rbxasset://textures/sky/sky512_bk.tex"},
		{"SkyboxDn", "string", "rbxasset://textures/sky/sky512_dn.tex"},
		{"SkyboxFt", "string", "rbxasset://textures/sky/sky512_ft.tex"},
		{"SkyboxLf", "string", "rbxasset://textures/sky/sky512_lf.tex"},
		{"SkyboxOrientation", "Vector3", Vector3.new(0, 0, 0)},
		{"SkyboxRt", "string", "rbxasset://textures/sky/sky512_rt.tex"},
		{"SkyboxUp", "string", "rbxasset://textures/sky/sky512_up.tex"},
		{"StarCount", "number", 3000},
		{"SunAngularSize", "number", 21},
		{"SunTextureId", "string", "rbxasset://sky/sun.jpg"},
	},

	Color3Value = {
		{"Name", "string", "Color3Value"},
		{"Value", "Color3", Color3.new()},
	},

	NumberValue = {
		{"Name", "string", "NumberValue"},
		{"Value", "number", 0},
	},

	BloomEffect = {
		{"Name", "string", "Bloom"},
		{"Enabled", "boolean", true},
		{"Intensity", "number", 1},
		{"Size", "number", 24},
		{"Threshold", "number", 2}
	},

	Atmosphere = {
		{"Name", "string", "Atmosphere"},
		{"Density", "number", 0.395},
		{"Offset", "number", 0},
		{"Color", "Color3", Color3.new(199, 170, 107)},
		{"Decay", "Color3", Color3.new(92, 60, 13)},
		{"Glare", "number", 0},
		{"Haze", "number", 0},

	DepthOfFieldEffect = {
		{"Name", "string", "DepthOfField"},
		{"Enabled", "boolean", true},
		{"FarIntensity", "number", 0.75},
		{"FocusDistance", "number", 0.05},
		{"InFocusRadius", "number", 10},
		{"NearIntensity", "number", 0.75}
	},
	
	SunRaysEffect = {
		{"Name", "string", "SunRaysEffect"},
		{"Enabled", "boolean", true},
		{"Intensity", "number", 0.25},
		{"Spread", "number", 1}
	},
	
	Attachment = {
		{"Visible", "boolean", false},
		{"Name", "string", "Attachment"},
		{"CFrame", "CFrame", CFrame.new()},
	},
	
	BoolValue = {
		{"Name", "string", "Value"},
		{"Value", "boolean", false}
	},
	
	Vector3Value = {
		{"Name", "string", "Value"},
		{"Value", "Vector3", Vector3.new()}
	},
	
	SurfaceGui = {
		{"ZOffset", "number", 0},
		{"Active", "boolean", true},
		{"Adornee", "Instance", nil},
		{"Enabled", "boolean", true},
		{"Face", "EnumItem", Enum.NormalId.Front},
		{"LightInfluence", "number", 1},
		{"MaxDistance", "number", 1000},
		{"Name", "string", "SurfaceGui"},
		{"ResetOnSpawn", "boolean", true},
		{"ToolPunchThroughDistance", "boolean", false},
		{"ZIndexBehavior", "EnumItem", Enum.ZIndexBehavior.Sibling},
		{"ClipsDescendants", "boolean", true},
		{"SelectionGroup", "boolean", true},
		{"PixelsPerStud", "number", 50},
		{"SizingMode", "EnumItem", Enum.SurfaceGuiSizingMode.PixelsPerStud}
	},
	
	Sound = {
		{"Name", "string", "Sound"},
		{"PlayOnRemove", "boolean", false},
		{"SoundId", "string", ""},
		{"RollOffMaxDistance", "number", 10000},
		{"RollOffMinDistance", "number", 10},
		{"RollOffMode", "EnumItem", Enum.RollOffMode.Linear},
		{"Looped", "boolean", false},
		{"PlaybackRegionsEnabled", "boolean", false},
		{"PlaybackSpeed", "number", 1},
		{"Playing", "boolean", false},
		{"TimePosition", "number", 0},
		{"Volume", "number", 0.5}
	},
	
	Beam = {
		{"Color", "ColorSequence", ColorSequence.new(Color3.new(1, 1, 1))},
		{"Enabled", "boolean", true},
		{"LightEmission", "number", 0},
		{"LightInfluence", "number", 1},
		{"Texture", "string", ""},
		{"TextureLength", "number", 1},
		{"TextureMode", "EnumItem", Enum.TextureMode.Stretch},
		{"TextureSpeed", "number", 1},
		{"Transparency", "NumberSequence", NumberSequence.new(0.5)},
		{"ZOffset", "number", 0},
		{"Attachment0", "InstanceReference", nil},
		{"Attachment1", "InstanceReference", nil},
		{"CurveSize0", "number", 0},
		{"CurveSize1", "number", 0},
		{"FaceCamera", "boolean", false},
		{"Segments", "number", 10},
		{"Width0", "number", 1},
		{"Width1", "number", 1},
		{"Name", "string", "Beam"}
	},

	Weld = {
		{"C0", "CFrame", CFrame.new()},
		{"C1", "CFrame", CFrame.new()},
		{"Part0", "InstanceReference", nil},
		{"Part1", "InstanceReference", nil},
		{"Enabled", "boolean", true},
		{"Name", "string", "Weld"}
	},

	WeldConstraint = {
		{"Part0", "InstanceReference", nil},
		{"Part1", "InstanceReference", nil},
		{"Enabled", "boolean", true},
		{"Name", "string", "Weld"}
	},
	
	Humanoid = {
		{"AutoJumpEnabled", "boolean", true},
		{"AutoRotate", "boolean", true},
		{"BreakJointsOnDeath", "boolean", true},
		{"DisplayDistanceType", "EnumItem", Enum.HumanoidDisplayDistanceType.Viewer},
		{"Health", "number", 100},
		{"HealthDisplayDistance", "number", 100},
		{"HealthDisplayType", "EnumItem", Enum.HumanoidHealthDisplayType.DisplayWhenDamaged},
		{"HipHeight", "number", 0},
		{"JumpHeight", "number", 7.2},
		{"JumpPower", "number", 50},
		{"MaxHealth", "number", 100},
		{"NameDisplayDistance", "number", 100},
		{"NameOcclusion", "EnumItem", Enum.NameOcclusion.OccludeAll},
		{"PlatformStand", "boolean", false},
		{"RequiresNeck", "boolean", true},
		{"RigType", "EnumItem", Enum.HumanoidRigType.R6},
		{"Sit", "boolean", false},
		{"UseJumpPower", "boolean", true},
		{"WalkSpeed", "number", 16},
		{"Name", "string", "Humanoid"}
	},
	
	Motor6D = {
		{"C0", "CFrame", CFrame.new()},
		{"C1", "CFrame", CFrame.new()},
		{"Part0", "InstanceReference", nil},
		{"Part1", "InstanceReference", nil},
		{"Enabled", "boolean", true},
		{"Transform", "CFrame", CFrame.new()},
		{"DesiredAngle", "number", 0},
		{"CurrentAngle", "number", 0},
		{"MaxVelocity", "number", 0.1},
		{"Name", "string", "Motor6D"}
	},

	Snap = {
		{"C0", "CFrame", CFrame.new()},
		{"C1", "CFrame", CFrame.new()},
		{"Part0", "InstanceReference", nil},
		{"Part1", "InstanceReference", nil},
		{"Enabled", "boolean", true},
		{"Name", "string", "Snap"}
	},
	
	Animator = {
		{"PreferLodEnabled", "boolean", true},
		{"Name", "string", "Animator"}
	},

	Shirt = {
		{"Color3", "Color3", Color3.new(1, 1, 1)},
		{"ShirtTemplate", "string", ""},
		{"Name", "string", "Shirt"},
	},

	Pants = {
		{"Color3", "Color3", Color3.new(1, 1, 1)},
		{"PantsTemplate", "string", ""},
		{"Name", "string", "Pants"}
	},
	
	HingeConstraint = {
		{"Color", "BrickColor", BrickColor.new()},
		{"Radius", "number", 0.15},
		{"Visible", "boolean", false},
		{"Enabled", "boolean", true},
		{"Attachment0", "InstanceReference", nil},
		{"Attachment1", "InstanceReference", nil},
		{"ActuatorType", "EnumItem", Enum.ActuatorType.None},
		{"LimitsEnabled", "boolean", false},
		{"Name", "string", "HingeConstraint"}
	},
	
	Lighting = {
		{"Ambient", "Color3", Color3.fromRGB(138, 138, 138)},
		{"Brightness", "number", 2},
		{"ColorShift_Bottom", "Color3", Color3.new()},
		{"ColorShift_Top", "Color3", Color3.new()},
		{"EnvironmentDiffuseScale", "number", 0}, 
		{"EnvironmentSpecularScale", "number", 0},
		{"GlobalShadows", "boolean", true},
		{"OutdoorAmbient", "Color3", Color3.fromRGB(128, 128, 128)},
		{"ClockTime", "number", 14},
		{"GeographicLatitude", "number", 56.45},
		{"ExposureCompensation", "number", 0},
		{"FogColor", "Color3", Color3.fromRGB(192, 192, 192)},
		{"FogEnd", "number", 100000},
		{"FogStart", "number", 0}
	}
}
