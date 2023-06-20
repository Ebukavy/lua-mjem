
local MJEM = {}

--De class is student
--Meester in Lua heten methods functions
local Student = {}
Student.__index = Student

--De broodjes
local broodjes = {
	{ naam = "chocolade broodje", prijs = 0.50, gezond = false },
	{ naam = "croissant", prijs = 0.89, gezond = false },
	{ naam = "kaasruit", prijs = 0.40, gezond = true },
	{ naam = "pizzabroodje", prijs = 1.00, gezond = false }
}

--De drankjes
local drankjes = {
	{ naam = "cola", prijs = 0.70 },
	{ naam = "fanta", prijs = 0.50 },
	{ naam = "casis", prijs = 0.60 }
}

function Student.new(naam, klantenkaart)
	local self = setmetatable({}, Student)
	self.naam = naam
	self.klantenkaart = klantenkaart
	self.broodjeszak = {}
	self.drankje = nil
	return self
end

function Student:kiesBroodje()
	local maxBroodjes = math.random(1, 4)

	for i = 1, maxBroodjes do
		local willekeurigBroodje = broodjes[math.random(#broodjes)] 
		table.insert(self.broodjeszak, willekeurigBroodje) --broodje toevoegen aan de broodjes zak tabel
	end
end

function Student:kiesDrankje()
	local neemtDrankje = math.random() < 0.5 

	if neemtDrankje then
		local willekeurigDrankje = drankjes[math.random(#drankjes)]
		self.drankje = willekeurigDrankje 
	end
end

function Student:scanBroodjes(kassa)
	for _, broodje in ipairs(self.broodjeszak) do
		kassa:voegBroodjeToe(broodje.prijs) -- Voeg de prijs van elk broodje toe aan de kassa
	end
end

function Student:scanDrankje(kassa)
	if self.drankje then
		kassa:voegDrankjeToe(self.drankje.prijs) -- Voeg de prijs van het drankje toe aan de kassa
	end
end

function Student:printKassabon(kassa)
	print("=============")
	print("MJEM")
	print(os.date("%d-%m-%Y %H:%M"))
	print("Naam:", self.naam)

	for _, broodje in ipairs(self.broodjeszak) do
		print("1", broodje.naam, "à", broodje.prijs)
	end

	if self.drankje then
		print("1", self.drankje.naam, "à", self.drankje.prijs)
	end

	print("TOTAAL", kassa:getTotaalBedrag())
	print("aantal ingeleverde punten", kassa.ingeleverdePunten)
	print("resterende punten", kassa.resterendePunten)
	print("=============")
end

MJEM.Student = Student

-- Class: Kassa
local Kassa = {}
Kassa.__index = Kassa

function Kassa.new()
	local self = setmetatable({}, Kassa)
	self.verkochteBroodjes = 0
	self.verkochteDrankjes = 0
	self.totaalBedrag = 0
	self.ingeleverdePunten = 0
	self.resterendePunten = 0
	return self
end

function Kassa:voegBroodjeToe(prijs)
	self.verkochteBroodjes = self.verkochteBroodjes + 1
	self.totaalBedrag = self.totaalBedrag + prijs
end

function Kassa:voegDrankjeToe(prijs)
	self.verkochteDrankjes = self.verkochteDrankjes + 1
	self.totaalBedrag = self.totaalBedrag + prijs
end

function Kassa:getTotaalBedrag()
	return self.totaalBedrag
end

function Kassa:printKassabon(student)
	student:printKassabon(self)
end

MJEM.Kassa = Kassa

--Gebruik de classes en functions
local student1 = MJEM.Student.new("Gideon", true)
local student2 = MJEM.Student.new("Dejah", false)
local student3 = MJEM.Student.new("Lucas", true)
local student4 = MJEM.Student.new("Martino", false)
local student5 = MJEM.Student.new("Valerio", true)

local kassa1 = MJEM.Kassa.new()

student1:kiesBroodje()
student1:kiesDrankje()
student1:scanBroodjes(kassa1)
student1:scanDrankje(kassa1)
kassa1:printKassabon(student1)

student2:kiesBroodje()
student2:kiesDrankje()
student2:scanBroodjes(kassa1)
student2:scanDrankje(kassa1)
kassa1:printKassabon(student2)

student3:kiesBroodje()
student3:kiesDrankje()
student3:scanBroodjes(kassa1)
student3:scanDrankje(kassa1)
kassa1:printKassabon(student3)

student4:kiesBroodje()
student4:kiesDrankje()
student4:scanBroodjes(kassa1)
student4:scanDrankje(kassa1)
kassa1:printKassabon(student4)

student5:kiesBroodje()
student5:kiesDrankje()
student5:scanBroodjes(kassa1)
student5:scanDrankje(kassa1)
kassa1:printKassabon(student5)

return MJEM
