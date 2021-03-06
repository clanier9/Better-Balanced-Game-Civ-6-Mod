--==============================================================
--******			C I V I L I Z A T I O N S			  ******
--==============================================================
--==================
-- America
--==================
-- Film Studios tourism bonus reduced from 100% to 50%
UPDATE ModifierArguments SET Value='50' WHERE ModifierId='FILMSTUDIO_ENHANCEDLATETOURISM' AND Name='Modifier';
-- American Rough Riders hill bonus nerf
UPDATE ModifierArguments SET Value='5' WHERE ModifierId='ROUGH_RIDER_BONUS_ON_HILLS';
-- 50% culture on kill (online speed)
UPDATE ModifierArguments SET Value=100 WHERE ModifierId='ROUGH_RIDER_POST_COMBAT_CULTURE' AND Name='PercentDefeatedStrength';
-- Continent combat bonus: +5 attack on foreign continent, +5 defense on home continent
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
	('TRAIT_COMBAT_BONUS_FOREIGN_CONTINENT_BBG',    'MODIFIER_PLAYER_UNITS_ATTACH_MODIFIER', 'UNIT_IS_DOMAIN_LAND'),
	('COMBAT_BONUS_FOREIGN_CONTINENT_MODIFIER_BBG', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', 'REQUIREMENTS_UNIT_ON_FOREIGN_CONTINENT_BBG');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('TRAIT_COMBAT_BONUS_FOREIGN_CONTINENT_BBG', 'ModifierId', 'COMBAT_BONUS_FOREIGN_CONTINENT_MODIFIER_BBG'),
	('COMBAT_BONUS_FOREIGN_CONTINENT_MODIFIER_BBG', 'Amount', '5');
INSERT INTO ModifierStrings (ModifierId, Context, Text) VALUES
	('COMBAT_BONUS_FOREIGN_CONTINENT_MODIFIER_BBG', 'Preview', 'LOC_PROMOTION_COMBAT_FOREIGN_CONTINENT_DESCRIPTION');
INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
	('TRAIT_LEADER_ROOSEVELT_COROLLARY', 'TRAIT_COMBAT_BONUS_FOREIGN_CONTINENT_BBG');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId) VALUES
	('REQUIREMENTS_UNIT_ON_HOME_CONTINENT',    'PLAYER_IS_DEFENDER_REQUIREMENTS'),
	('REQUIREMENTS_UNIT_ON_FOREIGN_CONTINENT_BBG', 'PLAYER_IS_ATTACKER_REQUIREMENTS'),
	('REQUIREMENTS_UNIT_ON_FOREIGN_CONTINENT_BBG', 'REQUIRES_UNIT_ON_FOREIGN_CONTINENT_BBG');
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType) VALUES
	('REQUIREMENTS_UNIT_ON_FOREIGN_CONTINENT_BBG', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO Requirements (RequirementId, RequirementType, Inverse) VALUES
	('REQUIRES_UNIT_ON_FOREIGN_CONTINENT_BBG', 'REQUIREMENT_UNIT_ON_HOME_CONTINENT', 1);


--==================
-- Arabia
--==================
-- mamluk combat increased
UPDATE Units SET Combat=53 WHERE UnitType='UNIT_ARABIAN_MAMLUK';
-- standard adj for holy sites and campuses when next to each other
INSERT INTO Adjacency_YieldChanges (ID , Description , YieldType , YieldChange , TilesRequired , AdjacentDistrict)
    VALUES
    ('District_HS_Faith_Positive_BBG' 	, 'LOC_HOLY_SITE_CAMPUS_POSITIVE_ADJACENCY_DESCRIPTION' , 'YIELD_FAITH' 	,  1 , 1 , 'DISTRICT_CAMPUS'),
    ('District_HS_Faith_Negative_BBG' 	, 'LOC_HOLY_SITE_CAMPUS_NEGATIVE_ADJACENCY_DESCRIPTION' , 'YIELD_FAITH' 	, -1 , 1 , 'DISTRICT_CAMPUS'),
	('District_Campus_Sci_Positive_BBG' , 'LOC_CAMPUS_HOLY_SITE_POSITIVE_ADJACENCY_DESCRIPTION' , 'YIELD_SCIENCE' 	,  1 , 1 , 'DISTRICT_HOLY_SITE'),
    ('District_Campus_Sci_Negative_BBG' , 'LOC_CAMPUS_HOLY_SITE_NEGATIVE_ADJACENCY_DESCRIPTION' , 'YIELD_SCIENCE' 	, -1 , 1 , 'DISTRICT_HOLY_SITE');
INSERT INTO District_Adjacencies (DistrictType , YieldChangeId)
    VALUES
    ('DISTRICT_HOLY_SITE' , 'District_HS_Faith_Positive_BBG'),
    ('DISTRICT_HOLY_SITE' , 'District_HS_Faith_Negative_BBG'),
	('DISTRICT_CAMPUS' , 'District_Campus_Sci_Positive_BBG'),
    ('DISTRICT_CAMPUS' , 'District_Campus_Sci_Negative_BBG');
INSERT INTO ExcludedAdjacencies (YieldChangeId , TraitType) VALUES
    ('District_HS_Faith_Negative_BBG'	, 'TRAIT_LEADER_RIGHTEOUSNESS_OF_FAITH'),
    ('District_Campus_Sci_Negative_BBG'	, 'TRAIT_LEADER_RIGHTEOUSNESS_OF_FAITH');
-- Arabia's Worship Building Bonus increased from 10% to 20%
UPDATE ModifierArguments SET Value='20' WHERE ModifierId='TRAIT_RELIGIOUS_BUILDING_MULTIPLIER_CULTURE' AND Name='Multiplier';
UPDATE ModifierArguments SET Value='20' WHERE ModifierId='TRAIT_RELIGIOUS_BUILDING_MULTIPLIER_FAITH' AND Name='Multiplier';
UPDATE ModifierArguments SET Value='20' WHERE ModifierId='TRAIT_RELIGIOUS_BUILDING_MULTIPLIER_SCIENCE' AND Name='Multiplier';
-- Arabia gets +1 Great Prophet point per turn after researching astrology
INSERT INTO Modifiers (ModifierId , ModifierType, SubjectRequirementSetId)
    VALUES ('TRAIT_BONUS_GREAT_PROPHET_POINT_CPLMOD' , 'MODIFIER_PLAYER_ADJUST_GREAT_PERSON_POINTS' , 'PLAYER_HAS_ASTROLOGY_REQUIREMENTS_CPLMOD');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('TRAIT_BONUS_GREAT_PROPHET_POINT_CPLMOD' , 'GreatPersonClassType' , 'GREAT_PERSON_CLASS_PROPHET');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES ('TRAIT_BONUS_GREAT_PROPHET_POINT_CPLMOD' , 'Amount' , '1');
INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES ('TRAIT_CIVILIZATION_LAST_PROPHET', 'TRAIT_BONUS_GREAT_PROPHET_POINT_CPLMOD');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('PLAYER_HAS_ASTROLOGY_REQUIREMENTS_CPLMOD' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('PLAYER_HAS_ASTROLOGY_REQUIREMENTS_CPLMOD' , 'REQUIRES_PLAYER_HAS_ASTROLOGY_CPLMOD');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_PLAYER_HAS_ASTROLOGY_CPLMOD' , 'REQUIREMENT_PLAYER_HAS_TECHNOLOGY');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_PLAYER_HAS_ASTROLOGY_CPLMOD' , 'TechnologyType' , 'TECH_ASTROLOGY');


--==================
-- Brazil
--==================
INSERT INTO Types (Type, Kind) VALUES
	('TRAIT_CIV_FAUX_LUMBER_MILL_BBG', 'KIND_TRAIT'),
	('IMPROVEMENT_BRAZIL_LUMBER_MILL_BBG', 'KIND_IMPROVEMENT');
INSERT INTO Traits (TraitType) VALUES ('TRAIT_CIV_FAUX_LUMBER_MILL_BBG');
CREATE TEMPORARY TABLE tmp AS SELECT * FROM Improvements WHERE ImprovementType='IMPROVEMENT_LUMBER_MILL';
UPDATE tmp SET ImprovementType='IMPROVEMENT_BRAZIL_LUMBER_MILL_BBG', TraitType='TRAIT_CIV_FAUX_LUMBER_MILL_BBG', Name='LOC_IMPROVEMENT_BRAZIL_LUMBER_MILL_NAME', Description='LOC_IMPROVEMENT_BRAZIL_LUMBER_MILL_EXPANSION2_DESCRIPTION';
INSERT INTO Improvements SELECT * from tmp;
DROP TABLE tmp;
INSERT INTO Improvement_ValidBuildUnits VALUES ('IMPROVEMENT_BRAZIL_LUMBER_MILL_BBG', 'UNIT_BUILDER', 1, 0);
INSERT INTO Improvement_ValidFeatures (ImprovementType, FeatureType) VALUES
	('IMPROVEMENT_BRAZIL_LUMBER_MILL_BBG', 'FEATURE_JUNGLE'),
	('IMPROVEMENT_BRAZIL_LUMBER_MILL_BBG', 'FEATURE_FOREST');
INSERT INTO Improvement_YieldChanges (ImprovementType, YieldType, YieldChange) VALUES
	('IMPROVEMENT_BRAZIL_LUMBER_MILL_BBG', 'YIELD_PRODUCTION', 1);
INSERT INTO Improvement_BonusYieldChanges (Id, ImprovementType, YieldType, BonusYieldChange, PrereqTech) VALUES
	(955, 'IMPROVEMENT_BRAZIL_LUMBER_MILL_BBG', 'YIELD_PRODUCTION', 1, 'TECH_STEEL');
INSERT INTO Adjacency_YieldChanges (ID, Description, YieldType, YieldChange, TilesRequired, AdjacentRiver, AdjacentImprovement) VALUES
	('River_Prod_BBG', 'Placeholder', 'YIELD_PRODUCTION', 1, 1, 1, NULL),
	('BrazilLumberMill_HalfProduction', 'LOC_DISTRICT_BRAZIL_LUMBER_MILL_PRODUCTION', 'YIELD_PRODUCTION', 1, 2, 0, 'IMPROVEMENT_BRAZIL_LUMBER_MILL_BBG');
INSERT INTO Improvement_Adjacencies VALUES ('IMPROVEMENT_BRAZIL_LUMBER_MILL_BBG', 'River_Prod_BBG');
INSERT INTO District_Adjacencies VALUES ('DISTRICT_INDUSTRIAL_ZONE', 'BrazilLumberMill_HalfProduction');
-- boost
CREATE TEMPORARY TABLE tmp AS SELECT * FROM Boosts WHERE TechnologyType='TECH_MASS_PRODUCTION';
UPDATE tmp SET BoostID=965, ImprovementType='IMPROVEMENT_BRAZIL_LUMBER_MILL_BBG';
INSERT INTO Boosts SELECT * FROM tmp;
DROP TABLE tmp;
-- add jungle mills to pedro
INSERT INTO RequirementSets(RequirementSetId , RequirementSetType) VALUES
	('PLAYER_IS_PEDRO_AND_HAS_CONSTRUCTION_BBG', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements(RequirementSetId , RequirementId) VALUES
	('PLAYER_IS_PEDRO_AND_HAS_CONSTRUCTION_BBG', 'REQUIREMENT_PLAYER_HAS_CONSTRUCTION_BBG'),
	('PLAYER_IS_PEDRO_AND_HAS_CONSTRUCTION_BBG', 'REQUIREMENT_PLAYER_IS_PEDRO_BBG');
INSERT INTO Requirements(RequirementId , RequirementType) VALUES
	('REQUIREMENT_PLAYER_HAS_CONSTRUCTION_BBG', 'REQUIREMENT_PLAYER_HAS_TECHNOLOGY'),
	('REQUIREMENT_PLAYER_IS_PEDRO_BBG', 'REQUIREMENT_PLAYER_LEADER_TYPE_MATCHES');
INSERT INTO RequirementArguments(RequirementId , Name, Value) VALUES
	('REQUIREMENT_PLAYER_HAS_CONSTRUCTION_BBG', 'TechnologyType', 'TECH_CONSTRUCTION'),
	('REQUIREMENT_PLAYER_IS_PEDRO_BBG' , 'LeaderType', 'LEADER_PEDRO');
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
	('CAN_BUILD_IMPROVEMENT_BRAZIL_LUMBER_MILL_BBG', 'MODIFIER_PLAYER_ADJUST_VALID_IMPROVEMENT', 'PLAYER_IS_PEDRO_AND_HAS_CONSTRUCTION_BBG');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('CAN_BUILD_IMPROVEMENT_BRAZIL_LUMBER_MILL_BBG', 'ImprovementType', 'IMPROVEMENT_BRAZIL_LUMBER_MILL_BBG');
INSERT INTO TraitModifiers VALUES ('TRAIT_LEADER_MAJOR_CIV', 'CAN_BUILD_IMPROVEMENT_BRAZIL_LUMBER_MILL_BBG');
-- add regular mills to everyone else
/*
UPDATE Improvements SET TraitType='TRAIT_CIVILIZATION_NO_PLAYER' WHERE ImprovementType='IMPROVEMENT_LUMBER_MILL';
INSERT INTO RequirementSets(RequirementSetId , RequirementSetType) VALUES
	('PLAYER_IS_NOT_PEDRO_BBG', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements(RequirementSetId , RequirementId) VALUES
	('PLAYER_IS_NOT_PEDRO_BBG', 'REQUIREMENT_PLAYER_IS_NOT_PEDRO_BBG');
INSERT INTO Requirements(RequirementId , RequirementType, Inverse) VALUES
	('REQUIREMENT_PLAYER_IS_NOT_PEDRO_BBG', 'REQUIREMENT_PLAYER_LEADER_TYPE_MATCHES', 1);
INSERT INTO RequirementArguments(RequirementId , Name, Value) VALUES
	('REQUIREMENT_PLAYER_IS_NOT_PEDRO_BBG' , 'LeaderType', 'LEADER_PEDRO');
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
	('ATTACH_ENABLE_LUMBER_MILLS_BBG'	, 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER', 'PLAYER_IS_NOT_PEDRO_BBG'),
	('ENABLE_LUMBER_MILLS_BBG'			, 'MODIFIER_CITY_ADJUST_ALLOWED_IMPROVEMENT', NULL);
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('ATTACH_ENABLE_LUMBER_MILLS_BBG'	, 'ModifierId'		, 'ENABLE_LUMBER_MILLS_BBG'),
	('ENABLE_LUMBER_MILLS_BBG'			, 'ImprovementType'	, 'IMPROVEMENT_LUMBER_MILL');
INSERT INTO TechnologyModifiers VALUES ('TECH_CONSTRUCTION'	, 'ATTACH_ENABLE_LUMBER_MILLS_BBG');
*/


--==================
-- China
--==================
-- only +10% eurekas remains on china
DELETE FROM CivilizationTraits WHERE CivilizationType='CIVILIZATION_CHINA' AND TraitType='TRAIT_CIVILIZATION_DYNASTIC_CYCLE';
INSERT INTO Types (Type, Kind) VALUES ('TRAIT_CIVILIZATION_DYNASTIC_CYCLE_EUREKAS_BBG', 'KIND_TRAIT');
INSERT INTO Traits (TraitType, Name, Description)
	VALUES
	('TRAIT_CIVILIZATION_DYNASTIC_CYCLE_EUREKAS_BBG', 'LOC_TRAIT_CIVILIZATION_DYNASTIC_CYCLE_NAME', 'LOC_TRAIT_CIVILIZATION_DYNASTIC_CYCLE_DESCRIPTION');
INSERT INTO CivilizationTraits VALUES ('CIVILIZATION_CHINA', 'TRAIT_CIVILIZATION_DYNASTIC_CYCLE_EUREKAS_BBG');
DELETE FROM TraitModifiers WHERE TraitType='TRAIT_CIVILIZATION_DYNASTIC_CYCLE' AND 'TRAIT_CIVIC_BOOST';
DELETE FROM TraitModifiers WHERE TraitType='TRAIT_CIVILIZATION_DYNASTIC_CYCLE' AND 'TRAIT_TECHNOLOGY_BOOST';
INSERT INTO TraitModifiers VALUES ('TRAIT_CIVILIZATION_DYNASTIC_CYCLE_EUREKAS_BBG', 'TRAIT_CIVIC_BOOST');
INSERT INTO TraitModifiers VALUES ('TRAIT_CIVILIZATION_DYNASTIC_CYCLE_EUREKAS_BBG', 'TRAIT_TECHNOLOGY_BOOST');
-- great wall gets +1 prod, no initial gold, lowered gold and lowered culture per adj after castles
INSERT INTO Improvement_YieldChanges VALUES ('IMPROVEMENT_GREAT_WALL', 'YIELD_PRODUCTION', 1);
UPDATE Improvement_YieldChanges SET YieldChange=0 WHERE ImprovementType='IMPROVEMENT_GREAT_WALL' AND YieldType='YIELD_GOLD';
UPDATE Adjacency_YieldChanges SET YieldChange=1 WHERE ID='GreatWall_Culture';
UPDATE Adjacency_YieldChanges SET YieldChange=1 WHERE ID='GreatWall_Gold';
-- Crouching Tiger now a crossbowman replacement that gets +7 when adjacent to an enemy unit
INSERT INTO UnitReplaces (CivUniqueUnitType , ReplacesUnitType)
	VALUES ('UNIT_CHINESE_CROUCHING_TIGER' , 'UNIT_CROSSBOWMAN');
UPDATE Units SET Cost=190 , RangedCombat=40 , Range=2 WHERE UnitType='UNIT_CHINESE_CROUCHING_TIGER';
INSERT INTO Tags (Tag , Vocabulary)
	VALUES ('CLASS_CROUCHING_TIGER' , 'ABILITY_CLASS');
INSERT INTO TypeTags (Type , Tag)
	VALUES ('UNIT_CHINESE_CROUCHING_TIGER' , 'CLASS_CROUCHING_TIGER');
INSERT INTO Types (Type , Kind)
	VALUES ('ABILITY_TIGER_ADJACENCY_DAMAGE_CPLMOD' , 'KIND_ABILITY');
INSERT INTO TypeTags (Type , Tag)
	VALUES ('ABILITY_TIGER_ADJACENCY_DAMAGE_CPLMOD' , 'CLASS_CROUCHING_TIGER');
INSERT INTO UnitAbilities (UnitAbilityType , Name , Description)
	VALUES ('ABILITY_TIGER_ADJACENCY_DAMAGE_CPLMOD' , 'LOC_ABILITY_TIGER_ADJACENCY_NAME' , 'LOC_ABILITY_TIGER_ADJACENCY_DESCRIPTION');
INSERT INTO UnitAbilityModifiers (UnitAbilityType , ModifierId)
	VALUES ('ABILITY_TIGER_ADJACENCY_DAMAGE_CPLMOD' , 'TIGER_ADJACENCY_DAMAGE');
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('TIGER_ADJACENCY_DAMAGE' , 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH' , 'TIGER_ADJACENCY_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('TIGER_ADJACENCY_DAMAGE', 'Amount' , '7'); 
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('TIGER_ADJACENCY_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('TIGER_ADJACENCY_REQUIREMENTS' , 'PLAYER_IS_ATTACKER_REQUIREMENTS');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('TIGER_ADJACENCY_REQUIREMENTS' , 'ADJACENT_UNIT_REQUIREMENT');
INSERT INTO ModifierStrings (ModifierId , Context , Text)
    VALUES ('TIGER_ADJACENCY_DAMAGE' , 'Preview' , 'LOC_ABILITY_TIGER_ADJACENCY_DESCRIPTION');


--==================
-- China Kublai Khan
--==================
-- see vietnam/kublai khan pack


--==================
-- China Qin Shi Huang
--==================
-- wonder bonuses moved to Qin to buff KK without overbuffing
INSERT INTO LeaderTraits VALUES ('LEADER_QIN', 'TRAIT_CIVILIZATION_DYNASTIC_CYCLE');
-- +1 food and prod yields per wonder
INSERT INTO RequirementSetRequirements VALUES
	('DYNASTIC_CYCLE_TRAIT_REQUIREMENTS_BBG', 'REQUIRES_PLAYER_HAS_DYNASTIC_CYCLE_TRAIT_BBG');
INSERT INTO RequirementSets VALUES
	('DYNASTIC_CYCLE_TRAIT_REQUIREMENTS_BBG', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO Requirements (RequirementId, RequirementType) VALUES
	('REQUIRES_PLAYER_HAS_DYNASTIC_CYCLE_TRAIT_BBG', 'REQUIREMENT_PLAYER_HAS_CIVILIZATION_OR_LEADER_TRAIT');
INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES
	('REQUIRES_PLAYER_HAS_DYNASTIC_CYCLE_TRAIT_BBG', 'TraitType', 'TRAIT_CIVILIZATION_DYNASTIC_CYCLE');
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES
	('TRAIT_ATTACH_WONDER_FOOD_BBG', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER'),
	('TRAIT_ATTACH_WONDER_PROD_BBG', 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('TRAIT_ATTACH_WONDER_FOOD_BBG', 'ModifierId', 'TRAIT_WONDER_FOOD_BBG'),
	('TRAIT_ATTACH_WONDER_PROD_BBG', 'ModifierId', 'TRAIT_WONDER_PROD_BBG');
INSERT INTO TraitModifiers VALUES
	('TRAIT_CIVILIZATION_DYNASTIC_CYCLE', 'TRAIT_ATTACH_WONDER_FOOD_BBG'),
	('TRAIT_CIVILIZATION_DYNASTIC_CYCLE', 'TRAIT_ATTACH_WONDER_PROD_BBG');
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES
	('TRAIT_WONDER_FOOD_BBG', 'MODIFIER_SINGLE_CITY_ADJUST_WONDER_YIELD_CHANGE'),
	('TRAIT_WONDER_PROD_BBG', 'MODIFIER_SINGLE_CITY_ADJUST_WONDER_YIELD_CHANGE');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('TRAIT_WONDER_FOOD_BBG', 'Amount', '1'),
	('TRAIT_WONDER_FOOD_BBG', 'YieldType', 'YIELD_FOOD'),
	('TRAIT_WONDER_PROD_BBG', 'Amount', '1'),
	('TRAIT_WONDER_PROD_BBG', 'YieldType', 'YIELD_PRODUCTION');


--==================
-- Egypt
--==================
-- wonder and district on rivers bonus increased to 25%
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_RIVER_FASTER_BUILDTIME_WONDER';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='TRAIT_RIVER_FASTER_BUILDTIME_DISTRICT';
--
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
	VALUES ('REQUIRES_PLOT_HAS_FLOODPLAINS_CPL', 'REQUIREMENTSET_TEST_ANY');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
	VALUES ('REQUIRES_PLOT_HAS_FLOODPLAINS_CPL', 'REQUIRES_PLOT_HAS_FLOODPLAINS');
-- Sphinx base Faith Increased to 2 (from 1)
UPDATE Improvement_YieldChanges SET YieldChange=2 WHERE ImprovementType='IMPROVEMENT_SPHINX' AND YieldType='YIELD_FAITH';
-- +1 Faith and +1 Culture if adjacent to a wonder, instead of 2 Faith.
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='SPHINX_WONDERADJACENCY_FAITH' AND Name='Amount';
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('SPHINX_WONDERADJACENCY_CULTURE_CPLMOD' , 'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS' , 'PLOT_ADJACENT_TO_WONDER_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_WONDERADJACENCY_CULTURE_CPLMOD' , 'YieldType' , 'YIELD_CULTURE');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_WONDERADJACENCY_CULTURE_CPLMOD' , 'Amount' , 1);
INSERT INTO ImprovementModifiers (ImprovementType , ModifierId)
	VALUES ('IMPROVEMENT_SPHINX' , 'SPHINX_WONDERADJACENCY_CULTURE_CPLMOD');
-- Increased +1 Culture moved to Diplomatic Service (Was Natural History)
UPDATE Improvement_BonusYieldChanges SET PrereqCivic = 'CIVIC_DIPLOMATIC_SERVICE' WHERE Id=18;
-- Now grants 1 food and 1 production on desert tiles without floodplains. Go Go Gadget bad-start fixer.
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('SPHINX_DESERT_FOOD_MODIFIER' , 'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS', 'SPHINX_FOOD_PLOT_HAS_DESERT_REQUIREMENTS');
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('SPHINX_DESERT_HILLS_FOOD_MODIFIER' , 'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS', 'SPHINX_FOOD_PLOT_HAS_DESERT_HILLS_REQUIREMENTS');
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('SPHINX_DESERT_PRODUCTION_MODIFIER' , 'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS' ,'SPHINX_PRODUCTION_PLOT_HAS_DESERT_REQUIREMENTS');
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('SPHINX_DESERT_HILLS_PRODUCTION_MODIFIER' , 'MODIFIER_SINGLE_PLOT_ADJUST_PLOT_YIELDS' ,'SPHINX_PRODUCTION_PLOT_HAS_DESERT_HILLS_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_DESERT_FOOD_MODIFIER' , 'YieldType' , 'YIELD_FOOD');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_DESERT_FOOD_MODIFIER' , 'Amount' , '1');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_DESERT_HILLS_FOOD_MODIFIER' , 'YieldType' , 'YIELD_FOOD');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_DESERT_HILLS_FOOD_MODIFIER' , 'Amount' , '1');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_DESERT_PRODUCTION_MODIFIER' , 'YieldType' , 'YIELD_PRODUCTION');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_DESERT_PRODUCTION_MODIFIER' , 'Amount' , '1');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_DESERT_HILLS_PRODUCTION_MODIFIER' , 'YieldType' , 'YIELD_PRODUCTION');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SPHINX_DESERT_HILLS_PRODUCTION_MODIFIER' , 'Amount' , '1');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('SPHINX_FOOD_PLOT_HAS_DESERT_HILLS_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('SPHINX_FOOD_PLOT_HAS_DESERT_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('SPHINX_PRODUCTION_PLOT_HAS_DESERT_HILLS_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('SPHINX_PRODUCTION_PLOT_HAS_DESERT_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO ImprovementModifiers (ImprovementType , ModifierId)
	VALUES ('IMPROVEMENT_SPHINX' , 'SPHINX_DESERT_FOOD_MODIFIER');
INSERT INTO ImprovementModifiers (ImprovementType , ModifierId)
	VALUES ('IMPROVEMENT_SPHINX' , 'SPHINX_DESERT_HILLS_FOOD_MODIFIER');
INSERT INTO ImprovementModifiers (ImprovementType , ModifierId)
	VALUES ('IMPROVEMENT_SPHINX' , 'SPHINX_DESERT_PRODUCTION_MODIFIER');
INSERT INTO ImprovementModifiers (ImprovementType , ModifierId)
	VALUES ('IMPROVEMENT_SPHINX' , 'SPHINX_DESERT_HILLS_PRODUCTION_MODIFIER');
-- No prod nor food bonus on Floodplains
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('SPHINX_FOOD_PLOT_HAS_DESERT_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_NO_FLOODPLAINS');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('SPHINX_FOOD_PLOT_HAS_DESERT_HILLS_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_NO_FLOODPLAINS');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('SPHINX_PRODUCTION_PLOT_HAS_DESERT_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_NO_FLOODPLAINS');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('SPHINX_PRODUCTION_PLOT_HAS_DESERT_HILLS_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_NO_FLOODPLAINS');
-- Requires Desert or Desert Hills
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('SPHINX_FOOD_PLOT_HAS_DESERT_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_DESERT');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('SPHINX_FOOD_PLOT_HAS_DESERT_HILLS_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_DESERT_HILLS');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('SPHINX_PRODUCTION_PLOT_HAS_DESERT_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_DESERT');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('SPHINX_PRODUCTION_PLOT_HAS_DESERT_HILLS_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_DESERT_HILLS');


--==================
-- England
--==================
-- Sea Dog available at Exploration now
UPDATE Units SET PrereqCivic='CIVIC_EXPLORATION' WHERE UnitType='UNIT_ENGLISH_SEADOG';
-- move 1 admiral point to lighthouse
UPDATE District_GreatPersonPoints SET PointsPerTurn=1 WHERE DistrictType='DISTRICT_ROYAL_NAVY_DOCKYARD' AND GreatPersonClassType='GREAT_PERSON_CLASS_ADMIRAL';
INSERT INTO Modifiers (ModifierId, ModifierType, OwnerRequirementSetId, SubjectRequirementSetId) VALUES
	('BBG_ADMIRAL_LIGHTHOUSE_DOCKYARD', 'MODIFIER_SINGLE_CITY_ADJUST_GREAT_PERSON_POINT', NULL, 'BUILDING_IS_LIGHTHOUSE');
INSERT INTO ModifierArguments (ModifierId , Name , Value) VALUES
	('BBG_ADMIRAL_LIGHTHOUSE_DOCKYARD', 'GreatPersonClassType', 'GREAT_PERSON_CLASS_ADMIRAL'),
	('BBG_ADMIRAL_LIGHTHOUSE_DOCKYARD', 'Amount', '1');
INSERT INTO DistrictModifiers(DistrictType, ModifierId) VALUES
	('DISTRICT_ROYAL_NAVY_DOCKYARD', 'BBG_ADMIRAL_LIGHTHOUSE_DOCKYARD');
-- red coat combat nerf
UPDATE ModifierArguments SET Value='5' WHERE ModifierId='REDCOAT_FOREIGN_COMBAT' AND Name='Amount';


--==================
-- France
--==================
-- nerf garde continent combat bonus
UPDATE ModifierArguments SET Value='5' WHERE ModifierId='GARDE_CONTINENT_COMBAT' AND Name='Amount';
-- move spies buffs to france and off catherine for eleanor france buff
UPDATE TraitModifiers SET TraitType='TRAIT_CIVILIZATION_WONDER_TOURISM' WHERE TraitType='FLYING_SQUADRON_TRAIT' AND ModifierId='UNIQUE_LEADER_ADD_SPY_CAPACITY';
UPDATE TraitModifiers SET TraitType='TRAIT_CIVILIZATION_WONDER_TOURISM' WHERE TraitType='FLYING_SQUADRON_TRAIT' AND ModifierId='UNIQUE_LEADER_ADD_SPY_UNIT';
UPDATE TraitModifiers SET TraitType='TRAIT_CIVILIZATION_WONDER_TOURISM' WHERE TraitType='FLYING_SQUADRON_TRAIT' AND ModifierId='UNIQUE_LEADER_SPIES_START_PROMOTED';
-- Reduce tourism bonus for wonders
UPDATE ModifierArguments SET Value='150' WHERE ModifierId='TRAIT_WONDER_DOUBLETOURISM' AND Name='ScalingFactor';
-- Chateau now gives 1 housing at Feudalism, and adjacent luxes now give stacking food in addition to stacking gold 
INSERT INTO Improvement_YieldChanges (ImprovementType , YieldType , YieldChange)
	VALUES ('IMPROVEMENT_CHATEAU' , 'YIELD_FOOD' , '0');
INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES
	('IMPROVEMENT_CHATEAU' , 'Chateau_Luxury_Food_BBG'),
	('IMPROVEMENT_CHATEAU' , 'Chateau_Luxury_Gold_BBG');
DELETE FROM Improvement_Adjacencies WHERE YieldChangeId='Chateau_River';
INSERT INTO Adjacency_YieldChanges (ID , Description , YieldType , YieldChange , TilesRequired , AdjacentResourceClass)
	VALUES
	('Chateau_Luxury_Food_BBG' , 'Placeholder' , 'YIELD_FOOD' , 1 , 1 , 'RESOURCECLASS_LUXURY'),
	('Chateau_Luxury_Gold_BBG' , 'Placeholder' , 'YIELD_GOLD' , 1 , 1 , 'RESOURCECLASS_LUXURY');
UPDATE Improvements SET Housing=1, RequiresRiver=1, RequiresAdjacentBonusOrLuxury=0, PreReqCivic='CIVIC_FEUDALISM' WHERE ImprovementType='IMPROVEMENT_CHATEAU';


--==================
-- Germany
--==================
-- uboat +1 movement, since we did this to all subs
UPDATE Units SET BaseMoves='4' WHERE  UnitType='UNIT_GERMAN_UBOAT';
-- Extra district comes at Guilds
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
    VALUES ('PLAYER_HAS_GUILDS_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO Requirements (RequirementId, RequirementType)
    VALUES ('REQUIRES_PLAYER_HAS_GUILDS' , 'REQUIREMENT_PLAYER_HAS_CIVIC');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
    VALUES ('REQUIRES_PLAYER_HAS_GUILDS' , 'CivicType' , 'CIVIC_GUILDS');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
    VALUES ('PLAYER_HAS_GUILDS_REQUIREMENTS' , 'REQUIRES_PLAYER_HAS_GUILDS');
UPDATE Modifiers SET SubjectRequirementSetId='PLAYER_HAS_GUILDS_REQUIREMENTS' WHERE ModifierId='TRAIT_EXTRA_DISTRICT_EACH_CITY';


--==================
-- Greece
--==================
-- Greece gets their extra envoy at amphitheater instead of acropolis and only applies to pericles
DELETE FROM DistrictModifiers WHERE DistrictType='DISTRICT_ACROPOLIS';
--Wildcard delayed to Political Philosophy
UPDATE Modifiers SET OwnerRequirementSetId='PLAYER_HAS_POLITICAL_PHILOSOPHY_CPLMOD' WHERE ModifierId='TRAIT_WILDCARD_GOVERNMENT_SLOT';
INSERT INTO Requirements (RequirementId, RequirementType)
	VALUES ('REQUIRES_PLAYER_HAS_POLITICAL_PHILOSOPHY_CPLMOD', 'REQUIREMENT_PLAYER_HAS_CIVIC');
INSERT INTO RequirementArguments (RequirementId, Name, Value)
	VALUES ('REQUIRES_PLAYER_HAS_POLITICAL_PHILOSOPHY_CPLMOD', 'CivicType', 'CIVIC_POLITICAL_PHILOSOPHY');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
	VALUES ('PLAYER_HAS_POLITICAL_PHILOSOPHY_CPLMOD', 'REQUIRES_PLAYER_HAS_POLITICAL_PHILOSOPHY_CPLMOD');
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
	VALUES ('PLAYER_HAS_POLITICAL_PHILOSOPHY_CPLMOD', 'REQUIREMENTSET_TEST_ALL');

--==================
-- Greece (Gorgo)
--==================
-- increase culture on kills for online speed
UPDATE ModifierArguments SET Value=100 WHERE ModifierId='UNIQUE_LEADER_CULTURE_KILLS' AND Name='PercentDefeatedStrength';
-- credit to ielden for this complicated but elegant solution
-- combat bonus for military slots in gov, not all mili policy cards in play
-- Create Modifier for each governments
DELETE FROM TraitModifiers WHERE TraitType='CULTURE_KILLS_TRAIT' AND ModifierId='UNIQUE_LEADER_CULTURE_KILLS_GRANT_ABILITY';
INSERT INTO Modifiers(ModifierId, ModifierType, OwnerRequirementSetId)
    SELECT 'BBG_GIVE_MODIFIER_GORGO_' || GovernmentType, 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', 'BBG_PLAYER_IS_GORGO'
    FROM Government_SlotCounts
    WHERE GovernmentSlotType='SLOT_MILITARY' AND NumSlots > 0;
INSERT INTO Modifiers(ModifierId, ModifierType)
    SELECT 'BBG_MODIFIER_GORGO_' || GovernmentType, 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH'
    FROM Government_SlotCounts
    WHERE GovernmentSlotType='SLOT_MILITARY' AND NumSlots > 0;
INSERT INTO Modifiers(ModifierId, ModifierType, OwnerRequirementSetId) VALUES
    ('BBG_GIVE_MODIFIER_GORGO_ALHAMBRA', 'MODIFIER_PLAYER_UNITS_GRANT_ABILITY', 'BBG_PLAYER_IS_GORGO'),
    ('BBG_MODIFIER_GORGO_ALHAMBRA', 'MODIFIER_UNIT_ADJUST_COMBAT_STRENGTH', NULL);
INSERT INTO ModifierArguments(ModifierId, Name, Value)
    SELECT 'BBG_GIVE_MODIFIER_GORGO_' || GovernmentType, 'AbilityType', 'BBG_GORGO_COMBAT_ABILITY_' || GovernmentType
    FROM Government_SlotCounts
    WHERE GovernmentSlotType='SLOT_MILITARY' AND NumSlots > 0;
INSERT INTO ModifierArguments(ModifierId, Name, Value)
    SELECT 'BBG_MODIFIER_GORGO_' || GovernmentType, 'Amount', NumSlots
    FROM Government_SlotCounts
    WHERE GovernmentSlotType='SLOT_MILITARY' AND NumSlots > 0;
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
    ('BBG_GIVE_MODIFIER_GORGO_ALHAMBRA', 'AbilityType', 'BBG_GORGO_COMBAT_ABILITY_ALHAMBRA'),
    ('BBG_MODIFIER_GORGO_ALHAMBRA', 'Amount', '1');
INSERT INTO ModifierStrings(ModifierId, Context, Text)
    SELECT 'BBG_MODIFIER_GORGO_' || GovernmentType, 'Preview', 'LOC_COMBAT_PREVIEW_NUMBER_MILITARY_POLICIES_BONUS_DESC'
    FROM Government_SlotCounts
    WHERE GovernmentSlotType='SLOT_MILITARY' AND NumSlots > 0;
INSERT INTO ModifierStrings(ModifierId, Context, Text) VALUES
    ('BBG_MODIFIER_GORGO_ALHAMBRA', 'Preview', 'LOC_COMBAT_PREVIEW_NUMBER_MILITARY_POLICIES_BONUS_DESC');
-- Create Unit Ability
INSERT INTO Types(Type, Kind)
	SELECT 'BBG_GORGO_COMBAT_ABILITY_' || GovernmentType, 'KIND_ABILITY'
    FROM Government_SlotCounts
    WHERE GovernmentSlotType='SLOT_MILITARY' AND NumSlots > 0;
INSERT INTO Types(Type, Kind) VALUES
    ('BBG_GORGO_COMBAT_ABILITY_ALHAMBRA', 'KIND_ABILITY');
INSERT INTO TypeTags(Type, Tag)
    SELECT 'BBG_GORGO_COMBAT_ABILITY_' || GovernmentType, 'CLASS_ALL_COMBAT_UNITS'
    FROM Government_SlotCounts
    WHERE GovernmentSlotType='SLOT_MILITARY' AND NumSlots > 0;
INSERT INTO TypeTags(Type, Tag) VALUES
    ('BBG_GORGO_COMBAT_ABILITY_ALHAMBRA', 'CLASS_ALL_COMBAT_UNITS');
INSERT INTO UnitAbilities(UnitAbilityType , Name, Description, Inactive)
	SELECT 'BBG_GORGO_COMBAT_ABILITY_' || GovernmentType, 'LOC_ABILITY_GORGO_POLICY_SLOT_COMBAT_BONUS_NAME', 'LOC_ABILITY_GORGO_POLICY_SLOT_COMBAT_BONUS_DESCRIPTION', 1
    FROM Government_SlotCounts
    WHERE GovernmentSlotType='SLOT_MILITARY' AND NumSlots > 0;
INSERT INTO UnitAbilities(UnitAbilityType , Name, Description, Inactive) VALUES
    ('BBG_GORGO_COMBAT_ABILITY_ALHAMBRA', 'LOC_ABILITY_GORGO_POLICY_SLOT_COMBAT_BONUS_NAME', 'LOC_ABILITY_GORGO_POLICY_SLOT_COMBAT_BONUS_DESCRIPTION', 1);
INSERT INTO UnitAbilityModifiers(UnitAbilityType, ModifierId)
    SELECT 'BBG_GORGO_COMBAT_ABILITY_' || GovernmentType, 'BBG_MODIFIER_GORGO_' || GovernmentType
    FROM Government_SlotCounts
    WHERE GovernmentSlotType='SLOT_MILITARY' AND NumSlots > 0;
INSERT INTO UnitAbilityModifiers(UnitAbilityType, ModifierId) VALUES
    ('BBG_GORGO_COMBAT_ABILITY_ALHAMBRA', 'BBG_MODIFIER_GORGO_ALHAMBRA');
-- Attach modifier to building
INSERT INTO BuildingModifiers(BuildingType, ModifierId) VALUES
    ('BUILDING_ALHAMBRA', 'BBG_GIVE_MODIFIER_GORGO_ALHAMBRA');
-- Attach modifier to government
INSERT INTO GovernmentModifiers(GovernmentType, ModifierId)
    SELECT GovernmentType, 'BBG_GIVE_MODIFIER_GORGO_' || GovernmentType
    FROM Government_SlotCounts
    WHERE GovernmentSlotType='SLOT_MILITARY' AND NumSlots > 0;
-- Create IS_GORGO requirement
INSERT INTO RequirementSets(RequirementSetId , RequirementSetType) VALUES
	('BBG_PLAYER_IS_GORGO', 'REQUIREMENTSET_TEST_ANY');
INSERT INTO RequirementSetRequirements(RequirementSetId , RequirementId) VALUES
	('BBG_PLAYER_IS_GORGO', 'BBG_PLAYER_IS_GORGO_REQUIREMENT');
INSERT INTO Requirements(RequirementId , RequirementType) VALUES
	('BBG_PLAYER_IS_GORGO_REQUIREMENT' , 'REQUIREMENT_PLAYER_LEADER_TYPE_MATCHES');
INSERT INTO RequirementArguments(RequirementId , Name, Value) VALUES
	('BBG_PLAYER_IS_GORGO_REQUIREMENT' , 'LeaderType', 'LEADER_GORGO');



--==================
-- Greece (Pericles)
--==================
-- envoy only for pericles
INSERT INTO TraitModifiers
	VALUES ('TRAIT_LEADER_SURROUNDED_BY_GLORY' , 'AMPHITHEATER_AWARD_1_INFLUENCE_TOKEN');
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
	VALUES ('BUILDING_IS_AMPHITHEATER_CPLMOD', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
	VALUES ('BUILDING_IS_AMPHITHEATER_CPLMOD', 'REQUIRES_CITY_HAS_AMPHITHEATER_CPLMOD');
INSERT INTO Requirements (RequirementId, RequirementType)
	VALUES ('REQUIRES_CITY_HAS_AMPHITHEATER_CPLMOD', 'REQUIREMENT_CITY_HAS_BUILDING');
INSERT INTO RequirementArguments (RequirementId, Name, Value)
	VALUES ('REQUIRES_CITY_HAS_AMPHITHEATER_CPLMOD', 'BuildingType', 'BUILDING_AMPHITHEATER');
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
    VALUES ('AMPHITHEATER_AWARD_1_INFLUENCE_TOKEN' , 'MODIFIER_PLAYER_CITIES_ATTACH_MODIFIER', 'BUILDING_IS_AMPHITHEATER_CPLMOD');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
    VALUES ('AMPHITHEATER_AWARD_1_INFLUENCE_TOKEN' , 'ModifierId' , 'AMPHITHEATER_AWARD_1_INFLUENCE_TOKEN_MOD');
INSERT INTO Modifiers (ModifierId, ModifierType)
    VALUES ('AMPHITHEATER_AWARD_1_INFLUENCE_TOKEN_MOD' , 'MODIFIER_PLAYER_GRANT_INFLUENCE_TOKEN');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
    VALUES ('AMPHITHEATER_AWARD_1_INFLUENCE_TOKEN_MOD' , 'Amount' , '1');



--==================
-- India
--==================
-- Stepwell Unique Improvement gets +1 base Faith and +1 Food moved from Professional Sports to Feudalism
UPDATE Improvement_YieldChanges SET YieldChange=1 WHERE ImprovementType='IMPROVEMENT_STEPWELL' AND YieldType='YIELD_FAITH'; 
UPDATE Improvement_BonusYieldChanges SET PrereqCivic='CIVIC_FEUDALISM' WHERE Id='20';
-- Stepwells get +1 food per adajacent farm
INSERT INTO Adjacency_YieldChanges (ID, Description, YieldType, YieldChange, TilesRequired, AdjacentImprovement)
	VALUES ('STEPWELL_FOOD', 'Placeholder', 'YIELD_FOOD', 1, 1, 'IMPROVEMENT_FARM');
INSERT INTO Improvement_Adjacencies (ImprovementType, YieldChangeId)
	VALUES ('IMPROVEMENT_STEPWELL', 'STEPWELL_FOOD');
DELETE FROM ImprovementModifiers WHERE ModifierId='STEPWELL_FARMADJACENCY_FOOD';


--==================
-- India (Chandragupta)
--==================
-- see R&F file


--==================
-- India (Gandhi)
--==================
-- Extra belief when founding a Religion
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
    VALUES ('EXTRA_BELIEF_MODIFIER', 'MODIFIER_PLAYER_ADD_BELIEF', 'HAS_A_RELIGION_BBG');
INSERT INTO TraitModifiers (TraitType, ModifierId)
    VALUES ('TRAIT_LEADER_SATYAGRAHA', 'EXTRA_BELIEF_MODIFIER');
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
    VALUES ('HAS_A_RELIGION_BBG', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO Requirements (RequirementId, RequirementType, Inverse)
	VALUES ('REQUIRES_FOUNDED_RELIGION_BBG', 'REQUIREMENT_FOUNDED_NO_RELIGION', 1);
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
    VALUES ('HAS_A_RELIGION_BBG', 'REQUIRES_FOUNDED_RELIGION_BBG');
-- +1 movement to builders
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_LEADER_SATYAGRAHA' , 'GANDHI_FAST_BUILDERS');
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('GANDHI_FAST_BUILDERS' , 'MODIFIER_PLAYER_UNITS_ADJUST_MOVEMENT' , 'UNIT_IS_BUILDER');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('GANDHI_FAST_BUILDERS' , 'Amount' , '1');
-- +1 movement to settlers
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_LEADER_SATYAGRAHA' , 'GANDHI_FAST_SETTLERS');
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('GANDHI_FAST_SETTLERS' , 'MODIFIER_PLAYER_UNITS_ADJUST_MOVEMENT' , 'UNIT_IS_SETTLER');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('GANDHI_FAST_SETTLERS' , 'Amount' , '1');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('UNIT_IS_SETTLER' , 'REQUIREMENT_UNIT_IS_SETTLER');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('UNIT_IS_SETTLER' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIREMENT_UNIT_IS_SETTLER' , 'REQUIREMENT_UNIT_TYPE_MATCHES');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIREMENT_UNIT_IS_SETTLER' , 'UnitType' , 'UNIT_SETTLER');


--==================
-- Japan
--==================
-- Commercial Hubs no longer get adjacency from rivers
INSERT INTO ExcludedAdjacencies (TraitType , YieldChangeId)
    VALUES
    ('TRAIT_CIVILIZATION_ADJACENT_DISTRICTS' , 'River_Gold');


--==================
-- Kongo
--==================
-- Put back +50% writer point
INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
    ('TRAIT_CIVILIZATION_NKISI', 'TRAIT_DOUBLE_WRITER_POINTS');
-- increase faith yields for artifacts and sculptures
UPDATE ModifierArguments SET Value='3' WHERE Name='YieldChange' AND ModifierId IN ('TRAIT_GREAT_WORK_FAITH_SCULPTURE', 'TRAIT_GREAT_WORK_FAITH_ARTIFACT');
-- Grant relic on each gov plaza building (credit to ielden, ty)
INSERT INTO Modifiers(ModifierId, ModifierType, RunOnce, Permanent, OwnerRequirementSetId) VALUES
    ('BBG_KONGO_RELIC_GOVBUILDING_TALL', 'MODIFIER_PLAYER_GRANT_RELIC', 1, 1, 'PLAYER_HAS_GOV_BUILDING_TALL_REQUIREMENTS'),
    ('BBG_KONGO_RELIC_GOVBUILDING_WIDE', 'MODIFIER_PLAYER_GRANT_RELIC', 1, 1, 'PLAYER_HAS_GOV_BUILDING_WIDE_REQUIREMENTS'),
    ('BBG_KONGO_RELIC_GOVBUILDING_CONQUEST', 'MODIFIER_PLAYER_GRANT_RELIC', 1, 1, 'PLAYER_HAS_GOV_BUILDING_CONQUEST_REQUIREMENTS'),
    ('BBG_KONGO_RELIC_GOVBUILDING_FAITH', 'MODIFIER_PLAYER_GRANT_RELIC', 1, 1, 'PLAYER_HAS_GOV_BUILDING_FAITH_REQUIREMENTS'),
    ('BBG_KONGO_RELIC_GOVBUILDING_CITYSTATES', 'MODIFIER_PLAYER_GRANT_RELIC', 1, 1, 'PLAYER_HAS_GOV_BUILDING_CITYSTATES_REQUIREMENTS'),
    ('BBG_KONGO_RELIC_GOVBUILDING_SPIES', 'MODIFIER_PLAYER_GRANT_RELIC', 1, 1, 'PLAYER_HAS_GOV_BUILDING_SPIES_REQUIREMENTS'),
    ('BBG_KONGO_RELIC_GOVBUILDING_SCIENCE', 'MODIFIER_PLAYER_GRANT_RELIC', 1, 1, 'PLAYER_HAS_GOV_BUILDING_SCIENCE_REQUIREMENTS'),
    ('BBG_KONGO_RELIC_GOVBUILDING_CULTURE', 'MODIFIER_PLAYER_GRANT_RELIC', 1, 1, 'PLAYER_HAS_GOV_BUILDING_CULTURE_REQUIREMENTS'),
    ('BBG_KONGO_RELIC_GOVBUILDING_MILITARY', 'MODIFIER_PLAYER_GRANT_RELIC', 1, 1, 'PLAYER_HAS_GOV_BUILDING_MILITARY_REQUIREMENTS');
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
    ('BBG_KONGO_RELIC_GOVBUILDING_TALL', 'Amount', '1'),
    ('BBG_KONGO_RELIC_GOVBUILDING_WIDE', 'Amount', '1'),
    ('BBG_KONGO_RELIC_GOVBUILDING_CONQUEST', 'Amount', '1'),
    ('BBG_KONGO_RELIC_GOVBUILDING_FAITH', 'Amount', '1'),
    ('BBG_KONGO_RELIC_GOVBUILDING_CITYSTATES', 'Amount', '1'),
    ('BBG_KONGO_RELIC_GOVBUILDING_SPIES', 'Amount', '1'),
    ('BBG_KONGO_RELIC_GOVBUILDING_SCIENCE', 'Amount', '1'),
    ('BBG_KONGO_RELIC_GOVBUILDING_CULTURE', 'Amount', '1'),
    ('BBG_KONGO_RELIC_GOVBUILDING_MILITARY', 'Amount', '1');
INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
    ('TRAIT_CIVILIZATION_NKISI', 'BBG_KONGO_RELIC_GOVBUILDING_TALL'),
    ('TRAIT_CIVILIZATION_NKISI', 'BBG_KONGO_RELIC_GOVBUILDING_WIDE'),
	('TRAIT_CIVILIZATION_NKISI', 'BBG_KONGO_RELIC_GOVBUILDING_CONQUEST'),
    ('TRAIT_CIVILIZATION_NKISI', 'BBG_KONGO_RELIC_GOVBUILDING_FAITH'),
    ('TRAIT_CIVILIZATION_NKISI', 'BBG_KONGO_RELIC_GOVBUILDING_CITYSTATES'),
    ('TRAIT_CIVILIZATION_NKISI', 'BBG_KONGO_RELIC_GOVBUILDING_SPIES'),
    ('TRAIT_CIVILIZATION_NKISI', 'BBG_KONGO_RELIC_GOVBUILDING_SCIENCE'),
    ('TRAIT_CIVILIZATION_NKISI', 'BBG_KONGO_RELIC_GOVBUILDING_CULTURE'),
    ('TRAIT_CIVILIZATION_NKISI', 'BBG_KONGO_RELIC_GOVBUILDING_MILITARY');
-- +100% prod towards archealogists
INSERT INTO TraitModifiers (TraitType, ModifierId) VALUES
	('TRAIT_CIVILIZATION_NKISI', 'TRAIT_ARCHAEOLOGIST_PROD_BBG');
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES
	('TRAIT_ARCHAEOLOGIST_PROD_BBG', 'MODIFIER_PLAYER_UNITS_ADJUST_UNIT_PRODUCTION');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('TRAIT_ARCHAEOLOGIST_PROD_BBG', 'UnitType', 'UNIT_ARCHAEOLOGIST'),
	('TRAIT_ARCHAEOLOGIST_PROD_BBG', 'Amount', '100');


--==================
-- Norway
--==================
-- Berserker no longer gets +10 on attack and -5 on defense... simplified to be base on defense and +15 on attack
UPDATE ModifierArguments SET Value='15' WHERE ModifierId='UNIT_STRONG_WHEN_ATTACKING';
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='UNIT_WEAK_WHEN_DEFENDING';
-- Berserker unit now gets unlocked at Feudalism instead of Military Tactics, and can be purchased with Faith
UPDATE Units SET Combat=35 , PrereqTech=NULL , PrereqCivic='CIVIC_FEUDALISM' WHERE UnitType='UNIT_NORWEGIAN_BERSERKER';
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_CIVILIZATION_UNIT_NORWEGIAN_BERSERKER' , 'BERSERKER_FAITH_PURCHASE_CPLMOD');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('BERSERKER_FAITH_PURCHASE_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ENABLE_UNIT_FAITH_PURCHASE');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('BERSERKER_FAITH_PURCHASE_CPLMOD' , 'Tag' , 'CLASS_MELEE_BERSERKER');
--Berserker Movement bonus extended to all water tiles
UPDATE RequirementSets SET RequirementSetType='REQUIREMENTSET_TEST_ANY' WHERE RequirementSetId='BERSERKER_PLOT_IS_ENEMY_TERRITORY';
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES
	('BERSERKER_PLOT_IS_ENEMY_TERRITORY' , 'REQUIRES_PLOT_HAS_COAST'),
	('BERSERKER_PLOT_IS_ENEMY_TERRITORY' , 'REQUIRES_TERRAIN_OCEAN' );
-- +2 gold harbor adjacency if adjacent to holy sites
INSERT INTO Adjacency_YieldChanges (ID , Description , YieldType , YieldChange , TilesRequired , AdjacentDistrict)
    VALUES
    ('District_HS_Gold_Positive' , 'LOC_HOLY_SITE_HARBOR_POSITIVE_ADJACENCY_DESCRIPTION' , 'YIELD_GOLD' ,  2 , 1 , 'DISTRICT_HOLY_SITE'),
    ('District_HS_Gold_Negative' , 'LOC_HOLY_SITE_HARBOR_NEGATIVE_ADJACENCY_DESCRIPTION' , 'YIELD_GOLD' , -2 , 1 , 'DISTRICT_HOLY_SITE');
INSERT INTO District_Adjacencies (DistrictType , YieldChangeId)
    VALUES
    ('DISTRICT_HARBOR' , 'District_HS_Gold_Positive'),
    ('DISTRICT_HARBOR' , 'District_HS_Gold_Negative');
INSERT INTO ExcludedAdjacencies (YieldChangeId , TraitType)
    VALUES
    ('District_HS_Gold_Negative', 'TRAIT_LEADER_MELEE_COASTAL_RAIDS');
-- Holy Sites coastal adjacency
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES
	('TRAIT_LEADER_THUNDERBOLT_HOLYSITE_COASTAL_ADJACENCY' , 'MODIFIER_PLAYER_CITIES_TERRAIN_ADJACENCY');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES
	('TRAIT_LEADER_THUNDERBOLT_HOLYSITE_COASTAL_ADJACENCY' , 'DistrictType' , 'DISTRICT_HOLY_SITE'             			 ),
	('TRAIT_LEADER_THUNDERBOLT_HOLYSITE_COASTAL_ADJACENCY' , 'TerrainType'  , 'TERRAIN_COAST'                  			 ),
	('TRAIT_LEADER_THUNDERBOLT_HOLYSITE_COASTAL_ADJACENCY' , 'YieldType'    , 'YIELD_FAITH'                    			 ),
	('TRAIT_LEADER_THUNDERBOLT_HOLYSITE_COASTAL_ADJACENCY' , 'Amount'       , '1'                              			 ),
	('TRAIT_LEADER_THUNDERBOLT_HOLYSITE_COASTAL_ADJACENCY' , 'TilesRequired', '1'                              			 ),
	('TRAIT_LEADER_THUNDERBOLT_HOLYSITE_COASTAL_ADJACENCY' , 'Description'  , 'LOC_DISTRICT_HOLY_SITE_NORWAY_COAST_FAITH');
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES
	('TRAIT_LEADER_MELEE_COASTAL_RAIDS', 'TRAIT_LEADER_THUNDERBOLT_HOLYSITE_COASTAL_ADJACENCY');


--==================
-- Rome
--==================
-- free city center building after code of laws
UPDATE Modifiers SET SubjectRequirementSetId='HAS_CODE_OF_LAWS_SET_BBG' WHERE ModifierId='TRAIT_ADJUST_NON_CAPITAL_FREE_CHEAPEST_BUILDING';
INSERT INTO RequirementSets VALUES ('HAS_CODE_OF_LAWS_SET_BBG', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements VALUES ('HAS_CODE_OF_LAWS_SET_BBG', 'HAS_CODE_OF_LAWS_BBG');
INSERT INTO Requirements (RequirementId, RequirementType) VALUES
	('HAS_CODE_OF_LAWS_BBG', 'REQUIREMENT_PLAYER_HAS_CIVIC');
INSERT INTO RequirementArguments (RequirementId, Name, Value) VALUES
	('HAS_CODE_OF_LAWS_BBG', 'CivicType', 'CIVIC_CODE_OF_LAWS');
-- Baths get Culture minor adjacency bonus added
INSERT INTO District_Adjacencies (DistrictType , YieldChangeId)
	VALUES ('DISTRICT_BATH' , 'District_Culture');


--==================
-- Russia
--==================
-- +1 faith on tundra tiles now only for city center tiles
INSERT INTO RequirementSets VALUES
	('PLOT_HAS_TUNDRA_CITY_CENTER_REQUIREMENTS_BBG', 'REQUIREMENTSET_TEST_ALL'),
	('PLOT_HAS_TUNDRA_HILLS_CITY_CENTER_REQUIREMENTS_BBG', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements VALUES
	('PLOT_HAS_TUNDRA_CITY_CENTER_REQUIREMENTS_BBG', 'REQUIRES_PLOT_HAS_TUNDRA'),
	('PLOT_HAS_TUNDRA_CITY_CENTER_REQUIREMENTS_BBG', 'BBG_REQUIRES_PLOT_IS_CITY_CENTER'),
	('PLOT_HAS_TUNDRA_HILLS_CITY_CENTER_REQUIREMENTS_BBG', 'REQUIRES_PLOT_HAS_TUNDRA_HILLS'),
	('PLOT_HAS_TUNDRA_HILLS_CITY_CENTER_REQUIREMENTS_BBG', 'BBG_REQUIRES_PLOT_IS_CITY_CENTER');
UPDATE Modifiers SET SubjectRequirementSetId='PLOT_HAS_TUNDRA_CITY_CENTER_REQUIREMENTS_BBG' 		WHERE ModifierId='TRAIT_INCREASED_TUNDRA_FAITH';
UPDATE Modifiers SET SubjectRequirementSetId='PLOT_HAS_TUNDRA_HILLS_CITY_CENTER_REQUIREMENTS_BBG' 	WHERE ModifierId='TRAIT_INCREASED_TUNDRA_HILLS_FAITH';
-- Lavra only gets 1 Great Prophet Point per turn
UPDATE District_GreatPersonPoints SET PointsPerTurn=1 WHERE DistrictType='DISTRICT_LAVRA' AND GreatPersonClassType='GREAT_PERSON_CLASS_PROPHET';
-- Only gets 2 extra tiles when founding a new city instead of 8 
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='TRAIT_INCREASED_TILES';
-- Cossacks have same base strength as cavalry instead of +5
UPDATE Units SET Combat=62 WHERE UnitType='UNIT_RUSSIAN_COSSACK';
-- remove GPP points from lavra buildings
DELETE FROM TraitModifiers WHERE TraitType='TRAIT_CIVILIZATION_DISTRICT_LAVRA' AND ModifierId!='TRAIT_EXPENDED_GREAT_PERSON_TILES';
-- Lavra district does not acrue Great Person Points unless city has a theater
UPDATE District_GreatPersonPoints SET PointsPerTurn='0' WHERE DistrictType='DISTRICT_LAVRA' AND GreatPersonClassType='GREAT_PERSON_CLASS_ARTIST';
UPDATE District_GreatPersonPoints SET PointsPerTurn='0' WHERE DistrictType='DISTRICT_LAVRA' AND GreatPersonClassType='GREAT_PERSON_CLASS_MUSICIAN';
UPDATE District_GreatPersonPoints SET PointsPerTurn='0' WHERE DistrictType='DISTRICT_LAVRA' AND GreatPersonClassType='GREAT_PERSON_CLASS_WRITER';
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
    VALUES ('DELAY_LAVRA_GPP_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
    VALUES
	('DELAY_LAVRA_GPP_REQUIREMENTS' , 'REQUIRES_DISTRICT_IS_LAVRA'),
	('DELAY_LAVRA_GPP_REQUIREMENTS' , 'REQUIRES_CITY_HAS_THEATER_DISTRICT');
INSERT INTO Requirements (RequirementId, RequirementType)
	VALUES ('REQUIRES_DISTRICT_IS_LAVRA' , 'REQUIREMENT_DISTRICT_TYPE_MATCHES');
INSERT INTO RequirementArguments (RequirementId, Name, Value)
	VALUES ('REQUIRES_DISTRICT_IS_LAVRA', 'DistrictType', 'DISTRICT_LAVRA');
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
    VALUES
	('DELAY_LAVRA_ARTIST_GPP_MODIFIER' , 'MODIFIER_SINGLE_CITY_DISTRICTS_ADJUST_GREAT_PERSON_POINTS' , 'DELAY_LAVRA_GPP_REQUIREMENTS'),
    ('DELAY_LAVRA_MUSICIAN_GPP_MODIFIER' , 'MODIFIER_SINGLE_CITY_DISTRICTS_ADJUST_GREAT_PERSON_POINTS' , 'DELAY_LAVRA_GPP_REQUIREMENTS'),
	('DELAY_LAVRA_WRITER_GPP_MODIFIER' , 'MODIFIER_SINGLE_CITY_DISTRICTS_ADJUST_GREAT_PERSON_POINTS' , 'DELAY_LAVRA_GPP_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
    VALUES
	('DELAY_LAVRA_ARTIST_GPP_MODIFIER' , 'GreatPersonClassType' , 'GREAT_PERSON_CLASS_ARTIST'),
    ('DELAY_LAVRA_MUSICIAN_GPP_MODIFIER' , 'GreatPersonClassType' , 'GREAT_PERSON_CLASS_MUSICIAN'),
	('DELAY_LAVRA_WRITER_GPP_MODIFIER' , 'GreatPersonClassType' , 'GREAT_PERSON_CLASS_WRITER'),
	('DELAY_LAVRA_ARTIST_GPP_MODIFIER' , 'Amount' , '1'),
    ('DELAY_LAVRA_MUSICIAN_GPP_MODIFIER' , 'Amount' , '1'),
    ('DELAY_LAVRA_WRITER_GPP_MODIFIER' , 'Amount' , '1');
INSERT INTO DistrictModifiers ( DistrictType , ModifierId )
	VALUES
	( 'DISTRICT_LAVRA', 'DELAY_LAVRA_ARTIST_GPP_MODIFIER' ),
	( 'DISTRICT_LAVRA', 'DELAY_LAVRA_MUSICIAN_GPP_MODIFIER' ),
	( 'DISTRICT_LAVRA', 'DELAY_LAVRA_WRITER_GPP_MODIFIER' );


--==================
-- Scythia
--==================
-- Scythia no longer gets an extra light cavalry unit when building/buying one
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='TRAIT_EXTRASAKAHORSEARCHER' and NAME='Amount';
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='TRAIT_EXTRALIGHTCAVALRY' and NAME='Amount';
-- Scythian Horse Archer get 1 extra range, combat reset to 15 after firaxis buffed to 20
UPDATE Units SET Range=2, Cost=70, Combat=15 WHERE UnitType='UNIT_SCYTHIAN_HORSE_ARCHER';
-- Adjacent Pastures now give +1 production in addition to faith
INSERT INTO Improvement_Adjacencies (ImprovementType , YieldChangeId)
	VALUES ('IMPROVEMENT_KURGAN' , 'KURGAN_PASTURE_PRODUCTION');
INSERT INTO Adjacency_YieldChanges (ID , Description , YieldType , YieldChange , TilesRequired , AdjacentImprovement)
	VALUES ('KURGAN_PASTURE_PRODUCTION' , 'Placeholder' , 'YIELD_PRODUCTION' , 1 , 1 , 'IMPROVEMENT_PASTURE');
INSERT INTO Improvement_YieldChanges (ImprovementType , YieldType , YieldChange)
	VALUES ('IMPROVEMENT_KURGAN' , 'YIELD_PRODUCTION' , 0);
INSERT INTO Improvement_ValidTerrains (ImprovementType, TerrainType) VALUES
	('IMPROVEMENT_KURGAN', 'TERRAIN_PLAINS_HILLS'),
	('IMPROVEMENT_KURGAN', 'TERRAIN_GRASS_HILLS'),
	('IMPROVEMENT_KURGAN', 'TERRAIN_DESERT_HILLS'),
	('IMPROVEMENT_KURGAN', 'TERRAIN_SNOW_HILLS'),
	('IMPROVEMENT_KURGAN', 'TERRAIN_TUNDRA_HILLS');
-- Can now purchase cavalry units with faith
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_CIVILIZATION_EXTRA_LIGHT_CAVALRY' , 'SCYTHIA_FAITH_PURCHASE_LCAVALRY_CPLMOD');
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_CIVILIZATION_EXTRA_LIGHT_CAVALRY' , 'SCYTHIA_FAITH_PURCHASE_HCAVALRY_CPLMOD');
INSERT INTO TraitModifiers (TraitType , ModifierId)
	VALUES ('TRAIT_CIVILIZATION_EXTRA_LIGHT_CAVALRY' , 'SCYTHIA_FAITH_PURCHASE_RCAVALRY_CPLMOD');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('SCYTHIA_FAITH_PURCHASE_LCAVALRY_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ENABLE_UNIT_FAITH_PURCHASE');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('SCYTHIA_FAITH_PURCHASE_HCAVALRY_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ENABLE_UNIT_FAITH_PURCHASE');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('SCYTHIA_FAITH_PURCHASE_RCAVALRY_CPLMOD' , 'MODIFIER_PLAYER_CITIES_ENABLE_UNIT_FAITH_PURCHASE');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SCYTHIA_FAITH_PURCHASE_LCAVALRY_CPLMOD' , 'Tag' , 'CLASS_LIGHT_CAVALRY'); 
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SCYTHIA_FAITH_PURCHASE_HCAVALRY_CPLMOD' , 'Tag' , 'CLASS_HEAVY_CAVALRY');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('SCYTHIA_FAITH_PURCHASE_RCAVALRY_CPLMOD' , 'Tag' , 'CLASS_RANGED_CAVALRY'); 


--==================
-- Spain
--==================
-- missions get +1 housing on home continent
INSERT INTO Requirements (RequirementId, RequirementType) VALUES
	('REQUIRES_PLOT_IS_OWNER_CAPITAL_CONTINENT_BBG', 'REQUIREMENT_PLOT_IS_OWNER_CAPITAL_CONTINENT');
INSERT INTO RequirementSets VALUES
	('PLOT_CAPITAL_CONTINENT_REQUIREMENTS_BBG', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements VALUES
	('PLOT_CAPITAL_CONTINENT_REQUIREMENTS_BBG', 'REQUIRES_PLOT_IS_OWNER_CAPITAL_CONTINENT_BBG');
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('MISSION_HOMECONTINENT_HOUSING_BBG' , 'MODIFIER_SINGLE_CITY_ADJUST_IMPROVEMENT_HOUSING', 'PLOT_CAPITAL_CONTINENT_REQUIREMENTS_BBG');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('MISSION_HOMECONTINENT_HOUSING_BBG' , 'Amount' , 1);
INSERT INTO ImprovementModifiers (ImprovementType , ModifierId)
	VALUES ('IMPROVEMENT_MISSION' , 'MISSION_HOMECONTINENT_HOUSING_BBG');
-- Missions cannot be placed next to each other
UPDATE Improvements SET SameAdjacentValid=0 WHERE ImprovementType='IMPROVEMENT_MISSION';
-- Missions moved to Theology
UPDATE Improvements SET PrereqTech=NULL, PrereqCivic='CIVIC_THEOLOGY' WHERE ImprovementType='IMPROVEMENT_MISSION';
-- Missions get bonus science at Enlightenment instead of cultural heritage
UPDATE Improvement_BonusYieldChanges SET PrereqCivic='CIVIC_THE_ENLIGHTENMENT' WHERE Id='17';

--Remove free Builder on other continents
DELETE FROM TraitModifiers WHERE TraitType = 'TRAIT_CIVILIZATION_TREASURE_FLEET' AND ModifierId = 'TRAIT_INTERCONTINENTAL_BUILDER';

--2x yields cross continents instead of 3x
UPDATE ModifierArguments SET Value='2' WHERE ModifierId = 'TRAIT_INTERCONTINENTAL_INTERNATIONAL_FAITH' AND Name = 'Amount';
UPDATE ModifierArguments SET Value='2' WHERE ModifierId = 'TRAIT_INTERCONTINENTAL_DOMESTIC_FAITH' AND Name = 'Amount';
UPDATE ModifierArguments SET Value='3' WHERE ModifierId = 'TRAIT_INTERCONTINENTAL_INTERNATIONAL_GOLD' AND Name = 'Amount';
UPDATE ModifierArguments SET Value='3' WHERE ModifierId = 'TRAIT_INTERCONTINENTAL_DOMESTIC_GOLD' AND Name = 'Amount';
UPDATE ModifierArguments SET Value='1' WHERE ModifierId = 'TRAIT_INTERCONTINENTAL_INTERNATIONAL_PRODUCTION' AND Name = 'Amount';
UPDATE ModifierArguments SET Value='1' WHERE ModifierId = 'TRAIT_INTERCONTINENTAL_DOMESTIC_PRODUCTION' AND Name = 'Amount';

--Missionary has to be on the same tile, instead of adjacent
INSERT INTO Requirements (RequirementId, RequirementType)
	VALUES ('RELIGIOUS_ON_SAME_TILE_REQUIREMENT_BBG', 'REQUIREMENT_PLOT_NEARBY_UNIT_TAG_MATCHES');
INSERT INTO RequirementArguments (RequirementId, Name, Value)
	VALUES	('RELIGIOUS_ON_SAME_TILE_REQUIREMENT_BBG', 'Tag', 'CLASS_RELIGIOUS_ALL'),
		('RELIGIOUS_ON_SAME_TILE_REQUIREMENT_BBG', 'MinDistance', '0'),
		('RELIGIOUS_ON_SAME_TILE_REQUIREMENT_BBG', 'MaxDistance', '0');
UPDATE RequirementSetRequirements SET RequirementId='RELIGIOUS_ON_SAME_TILE_REQUIREMENT_BBG' WHERE RequirementSetId='CONQUISTADOR_SPECIFIC_UNIT_REQUIREMENTS';

-- Early Fleets moved to Mercenaries
UPDATE ModifierArguments SET Value='CIVIC_MERCENARIES' WHERE Name='CivicType' AND ModifierId='TRAIT_NAVAL_CORPS_EARLY';

--Early Armadas moved to Mercantilism
UPDATE ModifierArguments SET Value='CIVIC_MERCANTILISM' WHERE Name='CivicType' AND ModifierId='TRAIT_NAVAL_ARMIES_EARLY';

-- 30% discount on missionaries
INSERT INTO TraitModifiers ( TraitType , ModifierId )
	VALUES ('TRAIT_LEADER_EL_ESCORIAL' , 'HOLY_ORDER_MISSIONARY_DISCOUNT_MODIFIER');

	
--==================
-- Sumeria
--==================
-- delete extra alliance mili bonus
DELETE FROM TraitModifiers WHERE TraitType='TRAIT_LEADER_ADVENTURES_ENKIDU' AND ModifierId='TRAIT_ATTACH_ALLIANCE_COMBAT_ADJUSTMENT';
-- reduce shared pillage rewards to 10%
UPDATE ModifierArguments SET Value='10' WHERE ModifierId='TRAIT_ADJUST_JOINTWAR_PLUNDER';
--delete shared xp
DELETE FROM TraitModifiers WHERE TraitType='TRAIT_LEADER_ADVENTURES_ENKIDU' and ModifierId='TRAIT_ADJUST_JOINTWAR_EXPERIENCE';
-- double pillage rewards
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES
	('TRAIT_ADJUST_PILLAGE_BBG', 'MODIFIER_PLAYER_ADJUST_IMPROVEMENT_PILLAGE');
INSERT INTO ModifierArguments (ModifierId, Name, Value, Extra) VALUES
	('TRAIT_ADJUST_PILLAGE_BBG', 'Amount', '2', '-1');
INSERT INTO TraitModifiers VALUES ('TRAIT_LEADER_ADVENTURES_ENKIDU', 'TRAIT_ADJUST_PILLAGE_BBG');
-- Sumerian War Carts are now unlocked at horseback riding and buffed
UPDATE Units SET Cost=80, Maintenance=2, BaseMoves=4, Combat=36, StrategicResource='RESOURCE_HORSES', PrereqTech='TECH_HORSEBACK_RIDING', MandatoryObsoleteTech='TECH_COMBUSTION' WHERE UnitType='UNIT_SUMERIAN_WAR_CART';
INSERT INTO UnitReplaces (CivUniqueUnitType, ReplacesUnitType) VALUES ('UNIT_SUMERIAN_WAR_CART', 'UNIT_HEAVY_CHARIOT');
-- war carts have a chance to steal defeated barbs and city state units
INSERT INTO Types (Type , Kind)
	VALUES ('ABILITY_WAR_CART_CAPTURE' , 'KIND_ABILITY');
INSERT INTO TypeTags (Type, Tag)
	VALUES ('ABILITY_WAR_CART_CAPTURE', 'CLASS_WAR_CART');
INSERT INTO UnitAbilities (UnitAbilityType, Name, Description)
	VALUES ('ABILITY_WAR_CART_CAPTURE', 'Placeholder', 'ABILITY_WAR_CART_CAPTURE_DESCRIPTION_BBG');
INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId)
	VALUES ('ABILITY_WAR_CART_CAPTURE', 'WAR_CART_CAPTURE_CS_BARBS');
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
	VALUES ('WAR_CART_CAPTURE_CS_BARBS', 'MODIFIER_UNIT_ADJUST_COMBAT_UNIT_CAPTURE', 'OPP_IS_CS_OR_BARB');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
	VALUES ('WAR_CART_CAPTURE_CS_BARBS', 'CanCapture', '1');
INSERT INTO RequirementSets (RequirementSetId, RequirementSetType)
	VALUES ('OPP_IS_CS_OR_BARB', 'REQUIREMENTSET_TEST_ANY');
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
	VALUES
	('OPP_IS_CS_OR_BARB', 'REQUIRES_OPPONENT_IS_BARBARIAN'),
	('OPP_IS_CS_OR_BARB', 'REQUIRES_OPPONENT_IS_MINOR_CIV');
-- Sumeria's Ziggurat gets +1 Culture at Diplomatic Service instead of Natural History
UPDATE Improvement_BonusYieldChanges SET PrereqCivic='CIVIC_DIPLOMATIC_SERVICE' WHERE ImprovementType='IMPROVEMENT_ZIGGURAT';
-- zigg gets +1 science and culture at enlightenment
INSERT INTO Improvement_BonusYieldChanges (Id, ImprovementType, YieldType, BonusYieldChange, PrereqCivic)
	VALUES
	(776, 'IMPROVEMENT_ZIGGURAT', 'YIELD_CULTURE', 1, 'CIVIC_THE_ENLIGHTENMENT'),
	(777, 'IMPROVEMENT_ZIGGURAT', 'YIELD_SCIENCE', 1, 'CIVIC_THE_ENLIGHTENMENT');
-- Can make Fleets with a shipyard. +25% prod towards fleets/armadas with shipyard
INSERT INTO Modifiers(ModifierId, ModifierType, OwnerRequirementSetId) 
	VALUES
    	('BBG_SPAIN_FLEET_DISCOUNT', 'MODIFIER_CITY_CORPS_ARMY_ADJUST_DISCOUNT', 'BBG_PLAYER_IS_SPAIN');
INSERT INTO ModifierArguments(ModifierId, Name, Value) 
	VALUES
    	('BBG_SPAIN_FLEET_DISCOUNT', 'UnitDomain', 'DOMAIN_SEA'),
    	('BBG_SPAIN_FLEET_DISCOUNT', 'Amount', '25');
INSERT INTO BuildingModifiers(BuildingType, ModifierId) 
	VALUES
    	('BUILDING_SHIPYARD', 'BBG_SPAIN_FLEET_DISCOUNT');   	
-- Spain requirement
INSERT INTO RequirementSets(RequirementSetId , RequirementSetType) 
	VALUES
	('BBG_PLAYER_IS_SPAIN', 'REQUIREMENTSET_TEST_ANY');
INSERT INTO RequirementSetRequirements(RequirementSetId , RequirementId) 
	VALUES
	('BBG_PLAYER_IS_SPAIN', 'BBG_PLAYER_IS_SPAIN_REQUIREMENT');
INSERT INTO Requirements(RequirementId , RequirementType) 
	VALUES
	('BBG_PLAYER_IS_SPAIN_REQUIREMENT' , 'REQUIREMENT_PLAYER_TYPE_MATCHES');
INSERT INTO RequirementArguments(RequirementId , Name, Value) 
	VALUES
	('BBG_PLAYER_IS_SPAIN_REQUIREMENT' , 'CivilizationType', 'CIVILIZATION_SPAIN');



--==============================================================
--******					BOOSTS						  ******
--==============================================================
UPDATE Boosts SET BoostClass='BOOST_TRIGGER_OWN_X_UNITS_OF_TYPE', NumItems=3, Unit1Type='UNIT_WARRIOR' WHERE TechnologyType='TECH_BRONZE_WORKING';
UPDATE Boosts SET BoostClass='BOOST_TRIGGER_OWN_X_UNITS_OF_TYPE', NumItems=2, Unit1Type='UNIT_SLINGER' WHERE TechnologyType='TECH_ARCHERY';
UPDATE Boosts SET Unit1Type=NULL, BoostClass='BOOST_TRIGGER_CONSTRUCT_BUILDING', BuildingType='BUILDING_BARRACKS' WHERE TechnologyType='TECH_MILITARY_TACTICS';
INSERT INTO Boosts (BoostID, TechnologyType, TriggerDescription, TriggerLongDescription, Boost, BoostClass, BuildingType) VALUES
	(201, 'TECH_MILITARY_TACTICS', 'LOC_BOOST_TRIGGER_MILITARY_TACTICS', 'LOC_BOOST_TRIGGER_LONGDESC_MILITARY_TACTICS', 40, 'BOOST_TRIGGER_CONSTRUCT_BUILDING', 'BUILDING_STABLE');
UPDATE Boosts SET Unit1Type=NULL, BoostClass='BOOST_TRIGGER_HAVE_X_BUILDINGS', NumItems=2, BuildingType='BUILDING_LIGHTHOUSE' WHERE TechnologyType='TECH_SQUARE_RIGGING';
UPDATE Boosts SET ImprovementType=NULL, BoostClass='BOOST_TRIGGER_CONSTRUCT_BUILDING', NumItems=0, BuildingType='BUILDING_CASTLE' WHERE TechnologyType='TECH_BALLISTICS';
UPDATE Boosts SET NumItems=1 WHERE TechnologyType='TECH_SANITATION';
UPDATE Boosts SET BoostClass='BOOST_TRIGGER_OWN_X_UNITS_OF_TYPE', NumItems=2 WHERE TechnologyType='TECH_GUIDANCE_SYSTEMS';
UPDATE Boosts SET BoostClass='BOOST_TRIGGER_MEET_X_CITY_STATES', NumItems=1 WHERE CivicType='CIVIC_FOREIGN_TRADE';
UPDATE Boosts SET NumItems=4 WHERE CivicType='CIVIC_FEUDALISM';
UPDATE Boosts SET BoostClass='BOOST_TRIGGER_HAVE_X_LAND_UNITS', NumItems=20 WHERE CivicType='CIVIC_NATIONALISM';
UPDATE Boosts SET BoostClass='BOOST_TRIGGER_TRAIN_UNIT', Unit1Type='UNIT_GREAT_ADMIRAL' WHERE CivicType='CIVIC_NAVAL_TRADITION';


--==============================================================
--******					BUILDINGS				  	  ******
--==============================================================
UPDATE Buildings SET Entertainment=1 WHERE BuildingType='BUILDING_SEWER';
UPDATE ModifierArguments SET Value='50' WHERE ModifierId='BARRACKS_TRAINED_UNIT_XP';
UPDATE ModifierArguments SET Value='50' WHERE ModifierId='STABLE_TRAINED_UNIT_XP';
UPDATE ModifierArguments SET Value='50' WHERE ModifierId='ARMORY_TRAINED_UNIT_XP';
UPDATE ModifierArguments SET Value='50' WHERE ModifierId='MILITARY_ACADEMY_TRAINED_UNIT_XP';
UPDATE ModifierArguments SET Value='50' WHERE ModifierId='LIGHTHOUSE_TRAINED_UNIT_XP';
UPDATE ModifierArguments SET Value='50' WHERE ModifierId='SHIPYARD_TRAINED_UNIT_XP';
UPDATE ModifierArguments SET Value='50' WHERE ModifierId='SEAPORT_TRAINED_UNIT_XP';
UPDATE ModifierArguments SET Value='50' WHERE ModifierId='HANGAR_TRAINED_AIRCRAFT_XP';
UPDATE ModifierArguments SET Value='75' WHERE ModifierId='AIRPORT_TRAINED_AIRCRAFT_XP';
UPDATE ModifierArguments SET Value='50' WHERE ModifierId='BASILIKOI_TRAINED_UNIT_XP';
UPDATE ModifierArguments SET Value='50' WHERE ModifierId='ORDU_TRAINED_XP';
UPDATE Building_YieldChanges SET YieldChange=2 WHERE BuildingType='BUILDING_BARRACKS';
UPDATE Building_YieldChanges SET YieldChange=2 WHERE BuildingType='BUILDING_STABLE';
UPDATE Building_YieldChanges SET YieldChange=2 WHERE BuildingType='BUILDING_BASILIKOI_PAIDES';
UPDATE Building_GreatPersonPoints SET PointsPerTurn=2 WHERE BuildingType='BUILDING_ARMORY';
UPDATE Building_GreatPersonPoints SET PointsPerTurn=2 WHERE BuildingType='BUILDING_MILITARY_ACADEMY';
UPDATE Building_GreatPersonPoints SET PointsPerTurn=3 WHERE BuildingType='BUILDING_SEAPORT';



--==============================================================
--******			  		CITY-STATES					  ******
--==============================================================
-- lisbon (now Mogadishu in portugal pack) sea AND LAND trade routes cannot be plundered
UPDATE ModifierArguments SET Value='ABILITY_ECONOMIC_GOLDEN_AGE_PLUNDER_IMMUNITY' WHERE ModifierId='MINOR_CIV_LISBON_SEA_TRADE_ROUTE_PLUNDER_IMMUNITY_BONUS' AND Name='AbilityType';
-- nan-modal culture per district no longer applies to city center or wonders
INSERT INTO Requirements ( RequirementId, RequirementType, Inverse )
	VALUES
		( 'REQUIRES_DISTRICT_IS_NOT_CITY_CENTER_BBG', 'REQUIREMENT_PLOT_DISTRICT_TYPE_MATCHES', 1 ),
		( 'REQUIRES_DISTRICT_IS_NOT_AQUEDUCT_BBG', 'REQUIREMENT_PLOT_DISTRICT_TYPE_MATCHES', 1 ),
		( 'REQUIRES_DISTRICT_IS_NOT_CANAL_BBG', 'REQUIREMENT_PLOT_DISTRICT_TYPE_MATCHES', 1 ),
		( 'REQUIRES_DISTRICT_IS_NOT_DAM_BBG', 'REQUIREMENT_PLOT_DISTRICT_TYPE_MATCHES', 1 ),
		( 'REQUIRES_DISTRICT_IS_NOT_NEIGHBORHOOD_BBG', 'REQUIREMENT_PLOT_DISTRICT_TYPE_MATCHES', 1 ),
		( 'REQUIRES_DISTRICT_IS_NOT_SPACEPORT_BBG', 'REQUIREMENT_PLOT_DISTRICT_TYPE_MATCHES', 1 ),
		( 'REQUIRES_DISTRICT_IS_NOT_WORLD_WONDER_BBG', 'REQUIREMENT_PLOT_DISTRICT_TYPE_MATCHES', 1 );
INSERT INTO RequirementArguments ( RequirementId, Name, Value )
	VALUES
		( 'REQUIRES_DISTRICT_IS_NOT_CITY_CENTER_BBG', 'DistrictType', 'DISTRICT_CITY_CENTER' ),
		( 'REQUIRES_DISTRICT_IS_NOT_AQUEDUCT_BBG', 'DistrictType', 'DISTRICT_AQUEDUCT' ),
		( 'REQUIRES_DISTRICT_IS_NOT_CANAL_BBG', 'DistrictType', 'DISTRICT_CANAL' ),
		( 'REQUIRES_DISTRICT_IS_NOT_DAM_BBG', 'DistrictType', 'DISTRICT_DAM' ),
		( 'REQUIRES_DISTRICT_IS_NOT_NEIGHBORHOOD_BBG', 'DistrictType', 'DISTRICT_NEIGHBORHOOD' ),
		( 'REQUIRES_DISTRICT_IS_NOT_SPACEPORT_BBG', 'DistrictType', 'DISTRICT_SPACEPORT' ),
		( 'REQUIRES_DISTRICT_IS_NOT_WORLD_WONDER_BBG', 'DistrictType', 'DISTRICT_WONDER' );
INSERT INTO RequirementSets ( RequirementSetId, RequirementSetType )
	VALUES ( 'SPECIAL_DISTRICT_ON_COAST_BBG', 'REQUIREMENTSET_TEST_ALL' );
INSERT INTO RequirementSetRequirements ( RequirementSetId, RequirementId )
	VALUES
		( 'SPECIAL_DISTRICT_ON_COAST_BBG', 'REQUIRES_PLOT_IS_ADJACENT_TO_COAST' ),
		( 'SPECIAL_DISTRICT_ON_COAST_BBG', 'REQUIRES_DISTRICT_IS_NOT_CITY_CENTER_BBG' ),
		( 'SPECIAL_DISTRICT_ON_COAST_BBG', 'REQUIRES_DISTRICT_IS_NOT_AQUEDUCT_BBG' ),
		( 'SPECIAL_DISTRICT_ON_COAST_BBG', 'REQUIRES_DISTRICT_IS_NOT_CANAL_BBG' ),
		( 'SPECIAL_DISTRICT_ON_COAST_BBG', 'REQUIRES_DISTRICT_IS_NOT_DAM_BBG' ),
		( 'SPECIAL_DISTRICT_ON_COAST_BBG', 'REQUIRES_DISTRICT_IS_NOT_NEIGHBORHOOD_BBG' ),
		( 'SPECIAL_DISTRICT_ON_COAST_BBG', 'REQUIRES_DISTRICT_IS_NOT_SPACEPORT_BBG' ),
		( 'SPECIAL_DISTRICT_ON_COAST_BBG', 'REQUIRES_DISTRICT_IS_NOT_WORLD_WONDER_BBG' );
UPDATE Modifiers SET SubjectRequirementSetId='SPECIAL_DISTRICT_ON_COAST_BBG' WHERE ModifierId='MINOR_CIV_NAN_MADOL_DISTRICTS_CULTURE_BONUS';
-- Nan madol nerf to +1 culture.
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='MINOR_CIV_NAN_MADOL_DISTRICTS_CULTURE_BONUS' AND Name='Amount';
-- +1 culture once exploration reach
INSERT INTO TraitModifiers(TraitType, ModifierId) VALUES
    ('MINOR_CIV_NAN_MADOL_TRAIT', 'BBG_NAN_MADOL_UNIQUE_INFLUENCE_EXPLORATION_MODIFIER');
INSERT INTO Modifiers(ModifierId, ModifierType, SubjectRequirementSetId) VALUES
    ('BBG_NAN_MADOL_UNIQUE_INFLUENCE_EXPLORATION_MODIFIER', 'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER', 'BBG_NAN_MADOL_UNIQUE_INFLUENCE_EXPLORATION_REQUIREMENTS'),
    ('BBG_NAN_MADOL_EXPLORATION_BONUS_MODIFIER', 'MODIFIER_PLAYER_DISTRICTS_ADJUST_YIELD_CHANGE', 'SPECIAL_DISTRICT_ON_COAST_BBG');
INSERT INTO ModifierArguments(ModifierId, Name, Value) VALUES
    ('BBG_NAN_MADOL_UNIQUE_INFLUENCE_EXPLORATION_MODIFIER', 'ModifierId', 'BBG_NAN_MADOL_EXPLORATION_BONUS_MODIFIER'),
    ('BBG_NAN_MADOL_EXPLORATION_BONUS_MODIFIER', 'YieldType', 'YIELD_CULTURE'),
    ('BBG_NAN_MADOL_EXPLORATION_BONUS_MODIFIER', 'Amount', '1');
INSERT INTO RequirementSets('RequirementSetId', 'RequirementSetType') VALUES
    ('BBG_NAN_MADOL_UNIQUE_INFLUENCE_EXPLORATION_REQUIREMENTS', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements(RequirementSetId, RequirementId) VALUES
    ('BBG_NAN_MADOL_UNIQUE_INFLUENCE_EXPLORATION_REQUIREMENTS', 'REQUIRES_PLAYER_IS_SUZERAIN'),
    ('BBG_NAN_MADOL_UNIQUE_INFLUENCE_EXPLORATION_REQUIREMENTS', 'BBG_PLAYER_HAS_EXPLORATION_CIVIC');
INSERT INTO Requirements(RequirementId, RequirementType) VALUES
    ('BBG_PLAYER_HAS_EXPLORATION_CIVIC', 'REQUIREMENT_PLAYER_HAS_CIVIC');
INSERT INTO RequirementArguments(RequirementId, Name, Value) VALUES
    ('BBG_PLAYER_HAS_EXPLORATION_CIVIC', 'CivicType', 'CIVIC_EXPLORATION');



--==============================================================
--******				CULTURE VICTORIES				  ******
--==============================================================
-- moon landing worth 5x science in culture instead of 10x
UPDATE ModifierArguments SET Value='5' WHERE ModifierId='PROJECT_COMPLETION_GRANT_CULTURE_BASED_ON_SCIENCE_RATE' AND Name='Multiplier';
-- computers and environmentalism tourism boosts to 50% (from 25%)
UPDATE ModifierArguments SET Value='50' WHERE ModifierId='COMPUTERS_BOOST_ALL_TOURISM';
UPDATE ModifierArguments SET Value='50' WHERE ModifierId='ENVIRONMENTALISM_BOOST_ALL_TOURISM'; 
-- base wonder tourism adjusted to 5
UPDATE GlobalParameters SET Value='5' WHERE Name='TOURISM_BASE_FROM_WONDER';
-- Reduce amount of tourism needed for foreign tourist from 200 to 150
UPDATE GlobalParameters SET Value='150' WHERE Name='TOURISM_TOURISM_TO_MOVE_CITIZEN';
-- lower number of turns to move greatworks between cities
UPDATE GlobalParameters SET Value='2' WHERE Name='GREATWORK_ART_LOCK_TIME';
-- relics give 4 tourism instead of 8
UPDATE GreatWorks SET Tourism=4 WHERE GreatWorkObjectType='GREATWORKOBJECT_RELIC';
--

-- fix same artist, same archelogist culture and tourism from bing 1 and 1 to being default numbers
UPDATE Building_GreatWorks SET NonUniquePersonYield=4 WHERE BuildingType='BUILDING_HERMITAGE';
UPDATE Building_GreatWorks SET NonUniquePersonTourism=4 WHERE BuildingType='BUILDING_HERMITAGE';
UPDATE Building_GreatWorks SET NonUniquePersonYield=4 WHERE BuildingType='BUILDING_MUSEUM_ART';
UPDATE Building_GreatWorks SET NonUniquePersonTourism=4 WHERE BuildingType='BUILDING_MUSEUM_ART';
UPDATE Building_GreatWorks SET NonUniquePersonYield=6 WHERE BuildingType='BUILDING_MUSEUM_ARTIFACT';
UPDATE Building_GreatWorks SET NonUniquePersonTourism=6 WHERE BuildingType='BUILDING_MUSEUM_ARTIFACT';

-- books give 4 culture and 2 tourism each (8 and 4 for each great person)
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE YieldChange=2;
-- artworks give 4 culture and 4 tourism instead of 3 and 2 ( 12/12 for each GP)
-- artifacts give 6 culture and 6 tourism instead of 3 and 3 ( 18/18 for each GP)
UPDATE GreatWorks SET Tourism=4 WHERE GreatWorkObjectType='GREATWORKOBJECT_RELIGIOUS';
UPDATE GreatWorks SET Tourism=4 WHERE GreatWorkObjectType='GREATWORKOBJECT_SCULPTURE';
UPDATE GreatWorks SET Tourism=4 WHERE GreatWorkObjectType='GREATWORKOBJECT_LANDSCAPE';
UPDATE GreatWorks SET Tourism=4 WHERE GreatWorkObjectType='GREATWORKOBJECT_PORTRAIT';
UPDATE GreatWorks SET Tourism=6 WHERE GreatWorkObjectType='GREATWORKOBJECT_ARTIFACT';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_RUBLEV_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_RUBLEV_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_RUBLEV_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_BOSCH_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_BOSCH_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_BOSCH_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_DONATELLO_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_DONATELLO_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_DONATELLO_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_MICHELANGELO_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_MICHELANGELO_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_MICHELANGELO_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_YING_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_YING_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_YING_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_TITIAN_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_TITIAN_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_TITIAN_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_GRECO_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_GRECO_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_GRECO_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_REMBRANDT_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_REMBRANDT_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_REMBRANDT_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_ANGUISSOLA_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_ANGUISSOLA_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_ANGUISSOLA_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_KAUFFMAN_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_KAUFFMAN_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_KAUFFMAN_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_HOKUSAI_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_HOKUSAI_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_HOKUSAI_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_EOP_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_EOP_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_EOP_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_GOGH_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_GOGH_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_GOGH_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_LEWIS_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_LEWIS_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_LEWIS_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_COLLOT_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_COLLOT_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_COLLOT_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_MONET_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_MONET_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_MONET_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_ORLOVSKY_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_ORLOVSKY_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_ORLOVSKY_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_KLIMT_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_KLIMT_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_KLIMT_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_GIL_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_GIL_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_GIL_3';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_CASSATT_1';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_CASSATT_2';
UPDATE GreatWork_YieldChanges SET YieldChange=4 WHERE GreatWorkType='GREATWORK_CASSATT_3';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_1';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_2';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_3';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_4';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_5';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_6';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_7';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_8';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_9';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_10';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_11';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_12';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_13';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_14';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_15';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_16';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_17';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_18';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_19';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_20';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_21';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_22';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_23';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_24';
UPDATE GreatWork_YieldChanges SET YieldChange=6 WHERE GreatWorkType='GREATWORK_ARTIFACT_25';

-- music gives 12 culture and 8 tourism instead of 4 and 4 (24/16 per GP)
UPDATE GreatWorks SET Tourism=8 WHERE GreatWorkObjectType='GREATWORKOBJECT_MUSIC';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_BEETHOVEN_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_BEETHOVEN_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_BACH_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_BACH_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_MOZART_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_MOZART_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_VIVALDI_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_VIVALDI_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_KENGYO_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_KENGYO_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_GOMEZ_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_GOMEZ_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_LISZT_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_LISZT_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_CHOPIN_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_CHOPIN_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_TCHAIKOVSKY_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_TCHAIKOVSKY_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_TIANHUA_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_TIANHUA_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_DVORAK_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_DVORAK_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_SCHUMANN_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_SCHUMANN_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_ROSAS_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_ROSAS_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_LILIUOKALANI_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_LILIUOKALANI_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_JAAN_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_JAAN_2';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_LEONTOVYCH_1';
UPDATE GreatWork_YieldChanges SET YieldChange='12' WHERE GreatWorkType='GREATWORK_LEONTOVYCH_2';



--==============================================================
--******			  	   GOVERNMENTS				  	  ******
--==============================================================
-- fascism attack bonus works on defense now too
UPDATE Modifiers SET SubjectRequirementSetId=NULL WHERE ModifierId='FASCISM_ATTACK_BUFF';
UPDATE Modifiers SET SubjectRequirementSetId=NULL WHERE ModifierId='FASCISM_LEGACY_ATTACK_BUFF';



--==============================================================
--******			 	  GREAT PEOPLE  				  ******
--==============================================================




--==============================================================
--******				   PANTHEONS					  ******
--==============================================================
-- religious settlements more border growth since settler removed
UPDATE ModifierArguments SET Value='50' WHERE ModifierId='RELIGIOUS_SETTLEMENTS_CULTUREBORDER';

-- river goddess +2 HS adj on rivers, -1 housing and -1 amentiy tho
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='RIVER_GODDESS_HOLY_SITE_HOUSING_MODIFIER' AND Name='Amount';
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='RIVER_GODDESS_HOLY_SITE_AMENITIES_MODIFIER' AND Name='Amount';
INSERT INTO Modifiers (ModifierId , ModifierType, SubjectRequirementSetId)
	VALUES ('RIVER_GODDESS_HOLY_SITE_FAITH_BBG' , 'MODIFIER_ALL_PLAYERS_ATTACH_MODIFIER', 'PLAYER_HAS_PANTHEON_REQUIREMENTS');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('RIVER_GODDESS_HOLY_SITE_FAITH_MODIFIER_BBG' , 'MODIFIER_PLAYER_CITIES_RIVER_ADJACENCY');
INSERT INTO ModifierArguments (ModifierId , Name , Value) VALUES
('RIVER_GODDESS_HOLY_SITE_FAITH_BBG', 'ModifierId', 'RIVER_GODDESS_HOLY_SITE_FAITH_MODIFIER_BBG'),
('RIVER_GODDESS_HOLY_SITE_FAITH_MODIFIER_BBG' , 'Amount' , '2'),
('RIVER_GODDESS_HOLY_SITE_FAITH_MODIFIER_BBG' , 'DistrictType' , 'DISTRICT_HOLY_SITE'),
('RIVER_GODDESS_HOLY_SITE_FAITH_MODIFIER_BBG' , 'YieldType' , 'YIELD_FAITH'),
('RIVER_GODDESS_HOLY_SITE_FAITH_MODIFIER_BBG' , 'Description' , 'LOC_DISTRICT_HOLY_SITE_RIVER_FAITH');
INSERT INTO BeliefModifiers VALUES
	('BELIEF_RIVER_GODDESS', 'RIVER_GODDESS_HOLY_SITE_FAITH_BBG');
	
-- city patron buff
UPDATE ModifierArguments SET Value='50' WHERE ModifierId='CITY_PATRON_GODDESS_DISTRICT_PRODUCTION_MODIFIER' AND Name='Amount';

-- Dance of Aurora yields reduced... only work for flat tundra
UPDATE ModifierArguments SET Value='0' WHERE ModifierId='DANCE_OF_THE_AURORA_FAITHTUNDRAHILLSADJACENCY' AND Name='Amount';

-- stone circles -1 faith and +1 prod
UPDATE ModifierArguments SET Value='1' WHERE ModifierId='STONE_CIRCLES_QUARRY_FAITH_MODIFIER' and Name='Amount';
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
	('STONE_CIRCLES_QUARRY_PROD_BBG', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS'),
	('STONE_CIRCLES_QUARRY_PROD_MODIFIER_BBG', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'PLOT_HAS_QUARRY_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('STONE_CIRCLES_QUARRY_PROD_BBG', 'ModifierId', 'STONE_CIRCLES_QUARRY_PROD_MODIFIER_BBG'),
	('STONE_CIRCLES_QUARRY_PROD_MODIFIER_BBG', 'YieldType', 'YIELD_PRODUCTION'),
	('STONE_CIRCLES_QUARRY_PROD_MODIFIER_BBG', 'Amount', '1');
INSERT INTO BeliefModifiers (BeliefType, ModifierID) VALUES
	('BELIEF_STONE_CIRCLES', 'STONE_CIRCLES_QUARRY_PROD_BBG');
	
-- religious idols +2 gold
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId) VALUES
	('RELIGIOUS_IDOLS_BONUS_MINE_GOLD_BBG', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS'),
	('RELIGIOUS_IDOLS_LUXURY_MINE_GOLD_BBG', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS'),
	('RELIGIOUS_IDOLS_BONUS_MINE_GOLD_MODIFIER_BBG', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'PLOT_HAS_BONUS_MINE_REQUIREMENTS'),
	('RELIGIOUS_IDOLS_LUXURY_MINE_GOLD_MODIFIER_BBG', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'PLOT_HAS_LUXURY_MINE_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('RELIGIOUS_IDOLS_BONUS_MINE_GOLD_BBG', 'ModifierId', 'RELIGIOUS_IDOLS_BONUS_MINE_GOLD_MODIFIER_BBG'),
	('RELIGIOUS_IDOLS_BONUS_MINE_GOLD_MODIFIER_BBG', 'Amount', '2'),
	('RELIGIOUS_IDOLS_BONUS_MINE_GOLD_MODIFIER_BBG', 'YieldType', 'YIELD_GOLD'),
	('RELIGIOUS_IDOLS_LUXURY_MINE_GOLD_BBG', 'ModifierId', 'RELIGIOUS_IDOLS_LUXURY_MINE_GOLD_MODIFIER_BBG'),
	('RELIGIOUS_IDOLS_LUXURY_MINE_GOLD_MODIFIER_BBG', 'Amount', '2'),
	('RELIGIOUS_IDOLS_LUXURY_MINE_GOLD_MODIFIER_BBG', 'YieldType', 'YIELD_GOLD');
INSERT INTO BeliefModifiers VALUES
	('BELIEF_RELIGIOUS_IDOLS', 'RELIGIOUS_IDOLS_BONUS_MINE_GOLD_BBG'),
	('BELIEF_RELIGIOUS_IDOLS', 'RELIGIOUS_IDOLS_LUXURY_MINE_GOLD_BBG');
	
-- Monument to the Gods affects all wonders... not just Ancient and Classical Era
UPDATE ModifierArguments SET Value='ERA_INFORMATION' WHERE ModifierId='MONUMENT_TO_THE_GODS_ANCIENTCLASSICALWONDER_MODIFIER' AND Name='EndEra';

-- God of War now God of War and Plunder (similar to divine spark)
DELETE FROM BeliefModifiers WHERE BeliefType='BELIEF_GOD_OF_WAR';
INSERT INTO Modifiers  ( ModifierId , ModifierType , SubjectRequirementSetId )
	VALUES
	( 'GOD_OF_WAR_AND_PLUNDER_COMHUB' , 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER' , 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS' ),
	( 'GOD_OF_WAR_AND_PLUNDER_HARBOR' , 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER' , 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS' ),
	( 'GOD_OF_WAR_AND_PLUNDER_ENCAMP' , 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER' , 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS' ),
	( 'GOD_OF_WAR_AND_PLUNDER_COMHUB_MODIFIER' , 'MODIFIER_SINGLE_CITY_DISTRICTS_ADJUST_GREAT_PERSON_POINTS' , 'DISTRICT_IS_COMMERCIAL_HUB' ),
	( 'GOD_OF_WAR_AND_PLUNDER_HARBOR_MODIFIER' , 'MODIFIER_SINGLE_CITY_DISTRICTS_ADJUST_GREAT_PERSON_POINTS' , 'DISTRICT_IS_HARBOR' 		),
	( 'GOD_OF_WAR_AND_PLUNDER_ENCAMP_MODIFIER' , 'MODIFIER_SINGLE_CITY_DISTRICTS_ADJUST_GREAT_PERSON_POINTS' , 'DISTRICT_IS_ENCAMPMENT' 	);
INSERT INTO ModifierArguments ( ModifierId , Name , Type , Value )
	VALUES
	( 'GOD_OF_WAR_AND_PLUNDER_COMHUB' , 'ModifierId' , 'ARGTYPE_IDENTITY' , 'GOD_OF_WAR_AND_PLUNDER_COMHUB_MODIFIER' ),
	( 'GOD_OF_WAR_AND_PLUNDER_HARBOR' , 'ModifierId' , 'ARGTYPE_IDENTITY' , 'GOD_OF_WAR_AND_PLUNDER_HARBOR_MODIFIER' ),
	( 'GOD_OF_WAR_AND_PLUNDER_ENCAMP' , 'ModifierId' , 'ARGTYPE_IDENTITY' , 'GOD_OF_WAR_AND_PLUNDER_ENCAMP_MODIFIER' ),
	( 'GOD_OF_WAR_AND_PLUNDER_COMHUB_MODIFIER' , 'GreatPersonClassType' , 'ARGTYPE_IDENTITY' , 'GREAT_PERSON_CLASS_MERCHANT' ),
	( 'GOD_OF_WAR_AND_PLUNDER_HARBOR_MODIFIER' , 'GreatPersonClassType' , 'ARGTYPE_IDENTITY' , 'GREAT_PERSON_CLASS_ADMIRAL'  ),
	( 'GOD_OF_WAR_AND_PLUNDER_ENCAMP_MODIFIER' , 'GreatPersonClassType' , 'ARGTYPE_IDENTITY' , 'GREAT_PERSON_CLASS_GENERAL'  ),
	( 'GOD_OF_WAR_AND_PLUNDER_COMHUB_MODIFIER' , 'Amount' , 'ARGTYPE_IDENTITY' , '1' ),
	( 'GOD_OF_WAR_AND_PLUNDER_HARBOR_MODIFIER' , 'Amount' , 'ARGTYPE_IDENTITY' , '1' ),
	( 'GOD_OF_WAR_AND_PLUNDER_ENCAMP_MODIFIER' , 'Amount' , 'ARGTYPE_IDENTITY' , '1' );
INSERT INTO BeliefModifiers ( BeliefType , ModifierId )
	VALUES
	( 'BELIEF_GOD_OF_WAR' , 'GOD_OF_WAR_AND_PLUNDER_COMHUB' ),
	( 'BELIEF_GOD_OF_WAR' , 'GOD_OF_WAR_AND_PLUNDER_HARBOR' ),
	( 'BELIEF_GOD_OF_WAR' , 'GOD_OF_WAR_AND_PLUNDER_ENCAMP' );

-- Fertility Rites gives +1 food for rice and wheat and cattle
INSERT INTO Tags
	(Tag, Vocabulary)
	VALUES 
	('CLASS_FERTILITY_RITES_FOOD', 'RESOURCE_CLASS');
INSERT INTO TypeTags 
	(Type, Tag)
	VALUES
	('RESOURCE_WHEAT', 'CLASS_FERTILITY_RITES_FOOD'),
	('RESOURCE_CATTLE', 'CLASS_FERTILITY_RITES_FOOD'),
	('RESOURCE_RICE', 'CLASS_FERTILITY_RITES_FOOD');
INSERT INTO Modifiers 
	(ModifierId, ModifierType, SubjectRequirementSetId)
	VALUES
	('FERTILITY_RITES_TAG_FOOD', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS'      ),
	('FERTILITY_RITES_TAG_FOOD_MODIFIER', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'PLOT_HAS_FERTILITY_TAG_FOOD_REQUIREMENTS');
INSERT INTO ModifierArguments 
	(ModifierId, Name, Value)
	VALUES
	('FERTILITY_RITES_TAG_FOOD', 'ModifierId', 'FERTILITY_RITES_TAG_FOOD_MODIFIER'),
	('FERTILITY_RITES_TAG_FOOD_MODIFIER', 'YieldType', 'YIELD_FOOD'),
	('FERTILITY_RITES_TAG_FOOD_MODIFIER', 'Amount', '1');
INSERT INTO Requirements 
	(RequirementId, RequirementType)
	VALUES 
	('REQUIRES_PLOT_HAS_TAG_FERTILITY_FOOD', 'REQUIREMENT_PLOT_RESOURCE_TAG_MATCHES');
INSERT INTO RequirementArguments 
	(RequirementId, Name, Value)
	VALUES 
	('REQUIRES_PLOT_HAS_TAG_FERTILITY_FOOD', 'Tag', 'CLASS_FERTILITY_RITES_FOOD');
INSERT INTO RequirementSets 
	(RequirementSetId, RequirementSetType)
	VALUES 
	('PLOT_HAS_FERTILITY_TAG_FOOD_REQUIREMENTS', 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements 
	(RequirementSetId, RequirementId)
	VALUES 
	('PLOT_HAS_FERTILITY_TAG_FOOD_REQUIREMENTS', 'REQUIRES_PLOT_HAS_TAG_FERTILITY_FOOD');
UPDATE BeliefModifiers SET ModifierID='FERTILITY_RITES_TAG_FOOD' WHERE BeliefType='BELIEF_FERTILITY_RITES' AND ModifierID='FERTILITY_RITES_GROWTH';

-- Initiation Rites gives 25% faith for each military land unit produced
INSERT INTO Modifiers 
	(ModifierId, ModifierType, SubjectRequirementSetId)
	VALUES
	('INITIATION_RITES_FAITH_YIELD_CPL_MOD', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS'),
	('INITIATION_RITES_FAITH_YIELD_MODIFIER_CPL_MOD', 'MODIFIER_SINGLE_CITY_GRANT_YIELD_PER_UNIT_COST', NULL                                );
INSERT INTO ModifierArguments 
	(ModifierId, Name, Value)
	VALUES
	('INITIATION_RITES_FAITH_YIELD_CPL_MOD', 'ModifierId', 'INITIATION_RITES_FAITH_YIELD_MODIFIER_CPL_MOD' ),
	('INITIATION_RITES_FAITH_YIELD_MODIFIER_CPL_MOD', 'YieldType', 'YIELD_FAITH'                                   ),
	('INITIATION_RITES_FAITH_YIELD_MODIFIER_CPL_MOD', 'UnitProductionPercent', '25'                                            );
UPDATE BeliefModifiers SET ModifierID='INITIATION_RITES_FAITH_YIELD_CPL_MOD' WHERE BeliefType='BELIEF_INITIATION_RITES' AND ModifierID='INITIATION_RITES_FAITH_DISPERSAL';

-- Sacred Path +1 Faith Holy Site adjacency now applies to both Woods and Rainforest
INSERT INTO BeliefModifiers 
	(BeliefType, ModifierId)
	VALUES
	('BELIEF_SACRED_PATH', 'SACRED_PATH_WOODS_FAITH_ADJACENCY');
INSERT INTO Modifiers 
	(ModifierId, ModifierType, SubjectRequirementSetId)
	VALUES
	('SACRED_PATH_WOODS_FAITH_ADJACENCY', 'MODIFIER_ALL_CITIES_FEATURE_ADJACENCY', 'CITY_FOLLOWS_PANTHEON_REQUIREMENTS');
INSERT INTO ModifierArguments 
	(ModifierId, Name, Value)
	VALUES
	('SACRED_PATH_WOODS_FAITH_ADJACENCY'                , 'DistrictType'              , 'DISTRICT_HOLY_SITE'                            ),
	('SACRED_PATH_WOODS_FAITH_ADJACENCY'                , 'FeatureType'               , 'FEATURE_FOREST'                                ),
	('SACRED_PATH_WOODS_FAITH_ADJACENCY'                , 'YieldType'                 , 'YIELD_FAITH'                                   ),
	('SACRED_PATH_WOODS_FAITH_ADJACENCY'                , 'Amount'                    , '1'                                             ),
	('SACRED_PATH_WOODS_FAITH_ADJACENCY'                , 'Description'               , 'LOC_DISTRICT_SACREDPATH_WOODS_FAITH'           );

-- Lady of the Reeds and Marshes now applies pantanal
INSERT INTO RequirementSetRequirements 
    (RequirementSetId, RequirementId)
    VALUES 
    ('PLOT_HAS_REEDS_REQUIREMENTS', 'REQUIRES_PLOT_HAS_PANTANAL');
INSERT INTO Requirements 
    (RequirementId, RequirementType)
    VALUES 
    ('REQUIRES_PLOT_HAS_PANTANAL', 'REQUIREMENT_PLOT_FEATURE_TYPE_MATCHES');
INSERT INTO RequirementArguments 
    (RequirementId, Name, Value)
    VALUES 
    ('REQUIRES_PLOT_HAS_PANTANAL', 'FeatureType', 'FEATURE_PANTANAL');

--==============================================================
--******				   POLICY CARDS					  ******
--==============================================================
-- destroy barbs
UPDATE ModifierArguments SET Value='10' WHERE ModifierId='DISCIPLINE_BARBARIANCOMBAT';
-- add 3 siege policy cards
INSERT INTO Types
	(Type, Kind)
	VALUES
	('POLICY_SIEGE', 'KIND_POLICY'),
	('POLICY_HARD_SHELL_EXPLOSIVES', 'KIND_POLICY'),
	('POLICY_TRENCH_WARFARE', 'KIND_POLICY');

INSERT INTO Policies
	(PolicyType, Name	, Description, PrereqCivic, GovernmentSlotType)
	VALUES
	('POLICY_SIEGE', 'LOC_POLICY_SIEGE_NAME', 'LOC_POLICY_SIEGE_DESCRIPTION', 'CIVIC_MILITARY_TRAINING', 'SLOT_MILITARY'),
	('POLICY_HARD_SHELL_EXPLOSIVES', 'LOC_POLICY_HARD_SHELL_EXPLOSIVES_NAME', 'LOC_POLICY_HARD_SHELL_EXPLOSIVES_DESCRIPTION', 'CIVIC_MEDIEVAL_FAIRES', 'SLOT_MILITARY'),
	('POLICY_TRENCH_WARFARE', 'LOC_POLICY_TRENCH_WARFARE_NAME', 'LOC_POLICY_TRENCH_WARFARE_DESCRIPTION', 'CIVIC_SCORCHED_EARTH', 'SLOT_MILITARY');

INSERT INTO ObsoletePolicies
	(PolicyType, ObsoletePolicy)
	VALUES
	('POLICY_SIEGE', 'POLICY_HARD_SHELL_EXPLOSIVES'),
	('POLICY_HARD_SHELL_EXPLOSIVES', 'POLICY_TRENCH_WARFARE');

INSERT INTO PolicyModifiers
	(PolicyType, ModifierId)
	VALUES
	('POLICY_SIEGE', 'SIEGE_ANCIENT_SIEGE_PRODUCTION'),
	('POLICY_SIEGE', 'SIEGE_CLASSICAL_SIEGE_PRODUCTION'),
	('POLICY_HARD_SHELL_EXPLOSIVES', 'HARD_SHELL_ANCIENT_SIEGE_PRODUCTION'),
	('POLICY_HARD_SHELL_EXPLOSIVES', 'HARD_SHELL_CLASSICAL_SIEGE_PRODUCTION'),
	('POLICY_HARD_SHELL_EXPLOSIVES', 'HARD_SHELL_MEDIEVAL_SIEGE_PRODUCTION'),
	('POLICY_HARD_SHELL_EXPLOSIVES', 'HARD_SHELL_RENAISSANCE_SIEGE_PRODUCTION'),
	('POLICY_TRENCH_WARFARE', 'TRENCH_WARFARE_ANCIENT_SIEGE_PRODUCTION'),
	('POLICY_TRENCH_WARFARE', 'TRENCH_WARFARE_CLASSICAL_SIEGE_PRODUCTION'),
	('POLICY_TRENCH_WARFARE', 'TRENCH_WARFARE_MEDIEVAL_SIEGE_PRODUCTION'),
	('POLICY_TRENCH_WARFARE', 'TRENCH_WARFARE_RENAISSANCE_SIEGE_PRODUCTION'),
	('POLICY_TRENCH_WARFARE', 'TRENCH_WARFARE_INDUSTRIAL_SIEGE_PRODUCTION'),
	('POLICY_TRENCH_WARFARE', 'TRENCH_WARFARE_MODERN_SIEGE_PRODUCTION'),
	('POLICY_TRENCH_WARFARE', 'TRENCH_WARFARE_ATOMIC_SIEGE_PRODUCTION');

INSERT INTO Modifiers
	(ModifierId, ModifierType)
	VALUES
	('SIEGE_ANCIENT_SIEGE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION'),
	('SIEGE_CLASSICAL_SIEGE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION'),
	('HARD_SHELL_ANCIENT_SIEGE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION'),
	('HARD_SHELL_CLASSICAL_SIEGE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION'),
	('HARD_SHELL_MEDIEVAL_SIEGE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION'),
	('HARD_SHELL_RENAISSANCE_SIEGE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION'),
	('TRENCH_WARFARE_ANCIENT_SIEGE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION'),
	('TRENCH_WARFARE_CLASSICAL_SIEGE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION'),
	('TRENCH_WARFARE_MEDIEVAL_SIEGE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION'),
	('TRENCH_WARFARE_RENAISSANCE_SIEGE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION'),
	('TRENCH_WARFARE_INDUSTRIAL_SIEGE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION'),
	('TRENCH_WARFARE_MODERN_SIEGE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION'),
	('TRENCH_WARFARE_ATOMIC_SIEGE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION');

INSERT INTO ModifierArguments
	(ModifierId, Name, Value, Extra)
	VALUES
	('SIEGE_ANCIENT_SIEGE_PRODUCTION', 'UnitPromotionClass', 'PROMOTION_CLASS_SIEGE', -1 ),
	('SIEGE_ANCIENT_SIEGE_PRODUCTION', 'EraType', 'ERA_ANCIENT', -1 ),
	('SIEGE_ANCIENT_SIEGE_PRODUCTION', 'Amount', 50, -1),
	('SIEGE_CLASSICAL_SIEGE_PRODUCTION', 'UnitPromotionClass', 'PROMOTION_CLASS_SIEGE', -1 ),
	('SIEGE_CLASSICAL_SIEGE_PRODUCTION', 'EraType', 'ERA_CLASSICAL', -1 ),
	('SIEGE_CLASSICAL_SIEGE_PRODUCTION', 'Amount', 50, -1),
	('HARD_SHELL_ANCIENT_SIEGE_PRODUCTION', 'UnitPromotionClass', 'PROMOTION_CLASS_SIEGE', -1 ),
	('HARD_SHELL_ANCIENT_SIEGE_PRODUCTION', 'EraType', 'ERA_ANCIENT', -1 ),
	('HARD_SHELL_ANCIENT_SIEGE_PRODUCTION', 'Amount', 50, -1),
	('HARD_SHELL_CLASSICAL_SIEGE_PRODUCTION', 'UnitPromotionClass', 'PROMOTION_CLASS_SIEGE', -1 ),
	('HARD_SHELL_CLASSICAL_SIEGE_PRODUCTION', 'EraType', 'ERA_CLASSICAL', -1 ),
	('HARD_SHELL_CLASSICAL_SIEGE_PRODUCTION', 'Amount', 50, -1),
	('HARD_SHELL_MEDIEVAL_SIEGE_PRODUCTION', 'UnitPromotionClass', 'PROMOTION_CLASS_SIEGE', -1 ),
	('HARD_SHELL_MEDIEVAL_SIEGE_PRODUCTION', 'EraType', 'ERA_MEDIEVAL', -1 ),
	('HARD_SHELL_MEDIEVAL_SIEGE_PRODUCTION', 'Amount', 50, -1),
	('HARD_SHELL_RENAISSANCE_SIEGE_PRODUCTION', 'UnitPromotionClass', 'PROMOTION_CLASS_SIEGE', -1 ),
	('HARD_SHELL_RENAISSANCE_SIEGE_PRODUCTION', 'EraType', 'ERA_RENAISSANCE', -1 ),
	('HARD_SHELL_RENAISSANCE_SIEGE_PRODUCTION', 'Amount', 50, -1),
	('TRENCH_WARFARE_ANCIENT_SIEGE_PRODUCTION', 'UnitPromotionClass', 'PROMOTION_CLASS_SIEGE', -1 ),
	('TRENCH_WARFARE_ANCIENT_SIEGE_PRODUCTION', 'EraType', 'ERA_ANCIENT', -1 ),
	('TRENCH_WARFARE_ANCIENT_SIEGE_PRODUCTION', 'Amount', 50, -1),
	('TRENCH_WARFARE_CLASSICAL_SIEGE_PRODUCTION', 'UnitPromotionClass', 'PROMOTION_CLASS_SIEGE', -1 ),
	('TRENCH_WARFARE_CLASSICAL_SIEGE_PRODUCTION', 'EraType', 'ERA_CLASSICAL', -1 ),
	('TRENCH_WARFARE_CLASSICAL_SIEGE_PRODUCTION', 'Amount', 50, -1),
	('TRENCH_WARFARE_MEDIEVAL_SIEGE_PRODUCTION', 'UnitPromotionClass', 'PROMOTION_CLASS_SIEGE', -1 ),
	('TRENCH_WARFARE_MEDIEVAL_SIEGE_PRODUCTION', 'EraType', 'ERA_MEDIEVAL', -1 ),
	('TRENCH_WARFARE_MEDIEVAL_SIEGE_PRODUCTION', 'Amount', 50, -1),
	('TRENCH_WARFARE_RENAISSANCE_SIEGE_PRODUCTION', 'UnitPromotionClass', 'PROMOTION_CLASS_SIEGE', -1 ),
	('TRENCH_WARFARE_RENAISSANCE_SIEGE_PRODUCTION', 'EraType', 'ERA_RENAISSANCE', -1 ),
	('TRENCH_WARFARE_RENAISSANCE_SIEGE_PRODUCTION', 'Amount', 50, -1),
	('TRENCH_WARFARE_INDUSTRIAL_SIEGE_PRODUCTION', 'UnitPromotionClass', 'PROMOTION_CLASS_SIEGE', -1 ),
	('TRENCH_WARFARE_INDUSTRIAL_SIEGE_PRODUCTION', 'EraType', 'ERA_INDUSTRIAL', -1 ),
	('TRENCH_WARFARE_INDUSTRIAL_SIEGE_PRODUCTION', 'Amount', 50, -1),
	('TRENCH_WARFARE_MODERN_SIEGE_PRODUCTION', 'UnitPromotionClass', 'PROMOTION_CLASS_SIEGE', -1 ),
	('TRENCH_WARFARE_MODERN_SIEGE_PRODUCTION', 'EraType', 'ERA_MODERN', -1 ),
	('TRENCH_WARFARE_MODERN_SIEGE_PRODUCTION', 'Amount', 50, -1),
	('TRENCH_WARFARE_ATOMIC_SIEGE_PRODUCTION', 'UnitPromotionClass', 'PROMOTION_CLASS_SIEGE', -1 ),
	('TRENCH_WARFARE_ATOMIC_SIEGE_PRODUCTION', 'EraType', 'ERA_ATOMIC', -1 ),
	('TRENCH_WARFARE_ATOMIC_SIEGE_PRODUCTION', 'Amount', 50, -1);


--==============================================================
--******					RELIGION					  ******
--==============================================================
-- reduce debator promotion
UPDATE ModifierArguments SET Value='10' WHERE ModifierId='APOSTLE_DEBATER' AND Name='Amount';
UPDATE ModifierArguments SET Value='100' WHERE ModifierId='APOSTLE_FOREIGN_SPREAD' AND Name='Amount';
UPDATE ModifierArguments SET Value='25' WHERE ModifierId='APOSTLE_EVICT_ALL' AND Name='Amount';
-- remove spread from condemning and reduce for defeating
UPDATE GlobalParameters SET Value=150 WHERE Name='RELIGION_SPREAD_COMBAT_VICTORY';
UPDATE GlobalParameters SET Value=0 WHERE Name='RELIGION_SPREAD_RANGE_UNIT_CAPTURE';
-- give monks wall breaker ability and double xp
INSERT INTO Types (Type, Kind) VALUES
	('WARRIOR_MONK_WALL_BREAKER_BBG', 'KIND_ABILITY'),
	('WARRIOR_MONK_DOUBLE_XP_BBG', 'KIND_ABILITY');
INSERT INTO TypeTags (Type, Tag) VALUES
	('WARRIOR_MONK_WALL_BREAKER_BBG', 'CLASS_WARRIOR_MONK'),
	('WARRIOR_MONK_DOUBLE_XP_BBG', 'CLASS_WARRIOR_MONK');
INSERT INTO Modifiers (ModifierId, ModifierType) VALUES
	('ENABLE_WALL_ATTACK_WHOLE_GAME_MONK_BBG', 'MODIFIER_PLAYER_UNITS_ADJUST_ENABLE_WALL_ATTACK_WHOLE_GAME_PROMOTION_CLASS'),
	('ENABLE_WARRIOR_MONK_DOUBLE_XP_BBG', 'MODIFIER_PLAYER_UNIT_ADJUST_UNIT_EXPERIENCE_MODIFIER');
INSERT INTO ModifierArguments (ModifierId, Name, Value) VALUES
	('ENABLE_WALL_ATTACK_WHOLE_GAME_MONK_BBG', 'PromotionClass', 'PROMOTION_CLASS_MONK'),
	('ENABLE_WARRIOR_MONK_DOUBLE_XP_BBG', 'Amount', '50');
INSERT INTO UnitAbilities (UnitAbilityType) VALUES
	('WARRIOR_MONK_WALL_BREAKER_BBG'),
	('WARRIOR_MONK_DOUBLE_XP_BBG');
INSERT INTO UnitAbilityModifiers (UnitAbilityType, ModifierId) VALUES
	('WARRIOR_MONK_WALL_BREAKER_BBG', 'ENABLE_WALL_ATTACK_WHOLE_GAME_MONK_BBG'),
	('WARRIOR_MONK_DOUBLE_XP_BBG', 'ENABLE_WARRIOR_MONK_DOUBLE_XP_BBG');
-- Monk spain ability bugfix
INSERT INTO TypeTags (Type , Tag) VALUES ('ABILITY_PHILIP_II_COMBAT_BONUS_OTHER_RELIGION' , 'CLASS_WARRIOR_MONK');
-- Nerf Inquisitors
UPDATE Units SET ReligionEvictPercent=25, SpreadCharges=2, CostProgressionParam1=10 WHERE UnitType='UNIT_INQUISITOR';
-- Religious spread from trade routes increased
UPDATE GlobalParameters SET Value='2.0' WHERE Name='RELIGION_SPREAD_TRADE_ROUTE_PRESSURE_FOR_DESTINATION';
UPDATE GlobalParameters SET Value='1.0' WHERE Name='RELIGION_SPREAD_TRADE_ROUTE_PRESSURE_FOR_ORIGIN'     ;
-- defender of faith nerf
UPDATE ModifierArguments SET Value='3' WHERE ModifierId='DEFENDER_OF_FAITH_COMBAT_BONUS_MODIFIER' AND Name='Amount';
-- Divine Inspiration yield increased
UPDATE ModifierArguments SET Value='6' WHERE ModifierId='DIVINE_INSPIRATION_WONDER_FAITH_MODIFIER' AND Name='Amount';
-- Crusader +7 instead of +10
UPDATE ModifierArguments SET Value='7' WHERE ModifierId='JUST_WAR_COMBAT_BONUS_MODIFIER';
-- Lay Ministry now +2 Culture and +2 Faith per Theater and Holy Site
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='LAY_MINISTRY_CULTURE_DISTRICTS_MODIFIER' AND Name='Amount';
UPDATE ModifierArguments SET Value='2' WHERE ModifierId='LAY_MINISTRY_FAITH_DISTRICTS_MODIFIER' AND Name='Amount';
-- Itinerant Preachers now causes a Religion to spread 40% father away instead of only 30%
UPDATE ModifierArguments SET Value='4' WHERE ModifierId='ITINERANT_PREACHERS_SPREAD_DISTANCE';
-- Cross-Cultural Dialogue is now +1 Science for every 3 foreign followers
UPDATE ModifierArguments SET Value='3' WHERE ModifierId='CROSS_CULTURAL_DIALOGUE_SCIENCE_FOREIGN_FOLLOWER_MODIFIER' AND Name='PerXItems';
-- Tithe is now +1 Gold for every 3 followers
UPDATE ModifierArguments SET Value='3' WHERE ModifierId='TITHE_GOLD_FOLLOWER_MODIFIER' AND Name='PerXItems';
-- World Church is now +1 Culture for every 3 foreign followers
UPDATE ModifierArguments SET Value='3' WHERE ModifierId='WORLD_CHURCH_CULTURE_FOREIGN_FOLLOWER_MODIFIER' AND Name='PerXItems';
-- Zen Meditation now only requires 1 District to get the +1 Amentity
UPDATE RequirementArguments SET Value='1' WHERE RequirementId='REQUIRES_CITY_HAS_2_SPECIALTY_DISTRICTS' AND Name='Amount';
-- Religious Communities now gives +1 Housing to Holy Sites, like it does for Shines and Temples
INSERT INTO Modifiers (ModifierId , ModifierType , SubjectRequirementSetId)
	VALUES ('RELIGIOUS_COMMUNITY_HOLY_SITE_HOUSING' , 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER' , 'CITY_FOLLOWS_RELIGION_HAS_HOLY_SITE');
INSERT INTO Modifiers (ModifierId , ModifierType)
	VALUES ('RELIGIOUS_COMMUNITY_HOLY_SITE_HOUSING_MODIFIER' , 'MODIFIER_SINGLE_CITY_ADJUST_BUILDING_HOUSING');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('RELIGIOUS_COMMUNITY_HOLY_SITE_HOUSING' , 'ModifierId' , 'RELIGIOUS_COMMUNITY_HOLY_SITE_HOUSING_MODIFIER');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('RELIGIOUS_COMMUNITY_HOLY_SITE_HOUSING_MODIFIER' , 'Amount' , '1');
INSERT INTO BeliefModifiers (BeliefType , ModifierId)
	VALUES ('BELIEF_RELIGIOUS_COMMUNITY' , 'RELIGIOUS_COMMUNITY_HOLY_SITE_HOUSING');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('CITY_FOLLOWS_RELIGION_HAS_HOLY_SITE' , 'REQUIREMENTSET_TEST_ALL');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
    VALUES ('CITY_FOLLOWS_RELIGION_HAS_HOLY_SITE' , 'REQUIRES_CITY_FOLLOWS_RELIGION');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('CITY_FOLLOWS_RELIGION_HAS_HOLY_SITE' , 'REQUIRES_CITY_HAS_HOLY_SITE');
-- Work Ethic now provides production equal to base yield for Shrine and Temple
DELETE From BeliefModifiers WHERE ModifierId='WORK_ETHIC_FOLLOWER_PRODUCTION';
INSERT INTO Modifiers 
	(ModifierId                              , ModifierType                          , SubjectRequirementSetId)
	VALUES 
	('WORK_ETHIC_SHRINE_PRODUCTION'          , 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER' , 'CITY_FOLLOWS_RELIGION_HAS_SHRINE'),
	('WORK_ETHIC_TEMPLE_PRODUCTION'          , 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER' , 'CITY_FOLLOWS_RELIGION_HAS_TEMPLE'),
	('WORK_ETHIC_SHRINE_PRODUCTION_MODIFIER' , 'MODIFIER_BUILDING_YIELD_CHANGE'      , null                              ),
	('WORK_ETHIC_TEMPLE_PRODUCTION_MODIFIER' , 'MODIFIER_BUILDING_YIELD_CHANGE'      , null                              );
INSERT INTO ModifierArguments 
	(ModifierId                              , Name           , Value)
	VALUES 
	('WORK_ETHIC_SHRINE_PRODUCTION'          , 'ModifierId'   , 'WORK_ETHIC_SHRINE_PRODUCTION_MODIFIER'),
	('WORK_ETHIC_TEMPLE_PRODUCTION'          , 'ModifierId'   , 'WORK_ETHIC_TEMPLE_PRODUCTION_MODIFIER'),
	('WORK_ETHIC_SHRINE_PRODUCTION_MODIFIER' , 'BuildingType' , 'BUILDING_SHRINE'                      ),
	('WORK_ETHIC_SHRINE_PRODUCTION_MODIFIER' , 'YieldType'    , 'YIELD_PRODUCTION'                     ),
	('WORK_ETHIC_SHRINE_PRODUCTION_MODIFIER' , 'Amount'       , '2'                                    ),
	('WORK_ETHIC_TEMPLE_PRODUCTION_MODIFIER' , 'BuildingType' , 'BUILDING_TEMPLE'                      ),
	('WORK_ETHIC_TEMPLE_PRODUCTION_MODIFIER' , 'YieldType'    , 'YIELD_PRODUCTION'                     ),
	('WORK_ETHIC_TEMPLE_PRODUCTION_MODIFIER' , 'Amount'       , '4'                                    );
INSERT INTO BeliefModifiers 
	(BeliefType          , ModifierId)
	VALUES 
	('BELIEF_WORK_ETHIC', 'WORK_ETHIC_TEMPLE_PRODUCTION'),
	('BELIEF_WORK_ETHIC', 'WORK_ETHIC_SHRINE_PRODUCTION');
-- Dar E Mehr provides +2 culture instead of faith from eras
DELETE FROM Building_YieldsPerEra WHERE BuildingType='BUILDING_DAR_E_MEHR';
INSERT INTO Building_YieldChanges 
	(BuildingType          , YieldType       , YieldChange)
	VALUES 
	('BUILDING_DAR_E_MEHR', 'YIELD_CULTURE', '2');



--==============================================================
--******					  SCORE					  	  ******
--==============================================================
-- more points for techs and civics
UPDATE ScoringLineItems SET Multiplier=4 WHERE LineItemType='LINE_ITEM_CIVICS';
UPDATE ScoringLineItems SET Multiplier=3 WHERE LineItemType='LINE_ITEM_TECHS';
-- less points for wide, more for tall
UPDATE ScoringLineItems SET Multiplier=2 WHERE LineItemType='LINE_ITEM_CITIES';
UPDATE ScoringLineItems SET Multiplier=2 WHERE LineItemType='LINE_ITEM_POPULATION';
-- Wonders Provide +4 score instead of +15
UPDATE ScoringLineItems SET Multiplier=4 WHERE LineItemType='LINE_ITEM_WONDERS';
-- Great People worth only 3 instead of 5
UPDATE ScoringLineItems SET Multiplier=3 WHERE LineItemType='LINE_ITEM_GREAT_PEOPLE';
-- converting foreign populations reduced from 2 to 1
UPDATE ScoringLineItems SET Multiplier=1 WHERE LineItemType='LINE_ITEM_ERA_CONVERTED';



--==============================================================
--******				  START BIASES					  ******
--==============================================================
-- t1 take up essential coastal spots first
UPDATE StartBiasTerrains SET Tier=1 WHERE CivilizationType='CIVILIZATION_ENGLAND' AND TerrainType='TERRAIN_COAST';
UPDATE StartBiasTerrains SET Tier=1 WHERE CivilizationType='CIVILIZATION_NORWAY' AND TerrainType='TERRAIN_COAST';
-- t2 must haves
UPDATE StartBiasTerrains SET Tier=2 WHERE CivilizationType='CIVILIZATION_JAPAN' AND TerrainType='TERRAIN_COAST';
INSERT INTO StartBiasTerrains (CivilizationType , TerrainType , Tier)
	VALUES
	('CIVILIZATION_SPAIN' , 'TERRAIN_COAST' , 2);
UPDATE StartBiasTerrains SET Tier=2 WHERE CivilizationType='CIVILIZATION_RUSSIA' AND TerrainType='TERRAIN_TUNDRA_HILLS';
UPDATE StartBiasTerrains SET Tier=2 WHERE CivilizationType='CIVILIZATION_RUSSIA' AND TerrainType='TERRAIN_TUNDRA';
-- t3 identities
UPDATE StartBiasFeatures SET Tier=3 WHERE CivilizationType='CIVILIZATION_BRAZIL' AND FeatureType='FEATURE_JUNGLE';
UPDATE StartBiasFeatures SET Tier=3 WHERE CivilizationType='CIVILIZATION_EGYPT' AND FeatureType='FEATURE_FLOODPLAINS';
UPDATE StartBiasResources SET Tier=3 WHERE CivilizationType='CIVILIZATION_SCYTHIA' AND ResourceType='RESOURCE_HORSES';
-- t4 river mechanics
UPDATE StartBiasRivers SET Tier=4 WHERE CivilizationType='CIVILIZATION_SUMERIA';
UPDATE StartBiasRivers SET Tier=4 WHERE CivilizationType='CIVILIZATION_FRANCE';
-- t4 feature mechanics
UPDATE StartBiasFeatures SET Tier=4 WHERE CivilizationType='CIVILIZATION_KONGO' AND FeatureType='FEATURE_JUNGLE';
-- t4 terrain mechanics
UPDATE StartBiasTerrains SET Tier=4 WHERE CivilizationType='CIVILIZATION_GREECE' AND TerrainType='TERRAIN_GRASS_HILLS';
UPDATE StartBiasTerrains SET Tier=4 WHERE CivilizationType='CIVILIZATION_GREECE' AND TerrainType='TERRAIN_PLAINS_HILLS';
-- t4 resource mechanics
INSERT INTO StartBiasResources (CivilizationType , ResourceType , Tier)
	VALUES
	('CIVILIZATION_SCYTHIA', 'RESOURCE_SHEEP', 4),
	('CIVILIZATION_SCYTHIA', 'RESOURCE_CATTLE', 4);
-- t5 last resorts
UPDATE StartBiasTerrains SET Tier=5 WHERE CivilizationType='CIVILIZATION_GREECE' AND TerrainType='TERRAIN_TUNDRA_HILLS';
UPDATE StartBiasTerrains SET Tier=5 WHERE CivilizationType='CIVILIZATION_GREECE' AND TerrainType='TERRAIN_DESERT_HILLS';
UPDATE StartBiasFeatures SET Tier=5 WHERE CivilizationType='CIVILIZATION_KONGO' AND FeatureType='FEATURE_FOREST';



--==============================================================
--******			  U N I T S  (NON-UNIQUE)			  ******
--==============================================================
UPDATE Units SET BaseMoves=6, BaseSightRange=4 WHERE UnitType='UNIT_HELICOPTER';
UPDATE Units SET BaseMoves=4 WHERE UnitType='UNIT_SUBMARINE';
UPDATE Units SET BaseMoves=6 WHERE UnitType='UNIT_DESTROYER';
UPDATE Units SET BaseMoves=5 WHERE UnitType='UNIT_AIRCRAFT_CARRIER';
UPDATE UnitCommands SET VisibleInUI=0 WHERE CommandType='UNITCOMMAND_PRIORITY_TARGET';
UPDATE Units SET BaseMoves=3 WHERE UnitType='UNIT_MILITARY_ENGINEER';
UPDATE Units SET BaseMoves=6, Cost=310 WHERE UnitType='UNIT_CAVALRY';
UPDATE Units SET PrereqTech='TECH_MILITARY_TACTICS' WHERE UnitType='UNIT_MAN_AT_ARMS';
UPDATE Units SET PrereqTech='TECH_COMBUSTION' WHERE UnitType='UNIT_ANTIAIR_GUN';
UPDATE Units SET BaseMoves=3 WHERE UnitType='UNIT_INFANTRY';
UPDATE Units SET PrereqCivic='CIVIC_EXPLORATION' WHERE UnitType='UNIT_PRIVATEER';
INSERT INTO RequirementSetRequirements (RequirementSetId, RequirementId)
	VALUES
	('GRAPE_SHOT_REQUIREMENTS',	'PLAYER_IS_ATTACKER_REQUIREMENTS'),
	('SHRAPNEL_REQUIREMENTS',	'PLAYER_IS_ATTACKER_REQUIREMENTS');
-- barbs
-- horses must be have resources closer in order to spawn
UPDATE BarbarianTribes SET ResourceRange=2 WHERE TribeType='TRIBE_CAVALRY';
-- less raider and attack forces
UPDATE BarbarianAttackForces SET NumMeleeUnits=2, NumRangeUnits=1 WHERE AttackForceType='CavalryAttack';
UPDATE BarbarianAttackForces SET NumMeleeUnits=1 WHERE AttackForceType='CavalryRaid';
UPDATE BarbarianAttackForces SET NumMeleeUnits=2, NumRangeUnits=1 WHERE AttackForceType='StandardAttack';
UPDATE BarbarianAttackForces SET NumMeleeUnits=1 WHERE AttackForceType='StandardRaid';
UPDATE BarbarianAttackForces SET NumMeleeUnits=2, NumRangeUnits=1, SiegeTag=NULL, NumSiegeUnits=0 WHERE AttackForceType='NavalAttack';
UPDATE BarbarianAttackForces SET NumMeleeUnits=1, RangeTag=NULL, NumRangeUnits=0 WHERE AttackForceType='NavalRaid';



--==============================================================
--******					W A L L S					  ******
--==============================================================
UPDATE Buildings SET OuterDefenseHitPoints=75, Cost=100 WHERE BuildingType='BUILDING_WALLS';
UPDATE Buildings SET OuterDefenseHitPoints=75, Cost=200 WHERE BuildingType='BUILDING_CASTLE';
UPDATE Buildings SET OuterDefenseHitPoints=75 WHERE BuildingType='BUILDING_STAR_FORT';
UPDATE ModifierArguments SET Value='300' WHERE ModifierId='STEEL_UNLOCK_URBAN_DEFENSES';



--==============================================================
--******			W O N D E R S  (MAN-MADE)			  ******
--==============================================================
-- Huey gives +2 culture to lake tiles
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
	VALUES ('BUILDING_HUEY_TEOCALLI', 'HUEY_LAKE_CULTURE');
INSERT INTO Modifiers (ModifierId, ModifierType, SubjectRequirementSetId)
	VALUES
	('HUEY_LAKE_CULTURE', 'MODIFIER_ALL_CITIES_ATTACH_MODIFIER', 'FOODHUEY_PLAYER_REQUIREMENTS'),
	('HUEY_LAKE_CULTURE_MODIFIER', 'MODIFIER_CITY_PLOT_YIELDS_ADJUST_PLOT_YIELD', 'FOODHUEY_PLOT_IS_LAKE_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId, Name, Value)
	VALUES
	('HUEY_LAKE_CULTURE', 'ModifierId', 'HUEY_LAKE_CULTURE_MODIFIER'),
	('HUEY_LAKE_CULTURE_MODIFIER', 'Amount', '2'),
	('HUEY_LAKE_CULTURE_MODIFIER', 'YieldType', 'YIELD_CULTURE');
-- cristo gets 1 relic
INSERT INTO Modifiers (ModifierId , ModifierType , RunOnce , Permanent)
	VALUES ('WONDER_GRANT_RELIC_BBG' , 'MODIFIER_PLAYER_GRANT_RELIC' , 1 , 1);	
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('WONDER_GRANT_RELIC_BBG' , 'Amount' , '1');
INSERT INTO BuildingModifiers (BuildingType, ModifierId) VALUES
	('BUILDING_CRISTO_REDENTOR', 'WONDER_GRANT_RELIC_BBG');
-- Hanging Gardens gives +1 housing to cities within 6 tiles
UPDATE Buildings SET Housing='1' WHERE BuildingType='BUILDING_HANGING_GARDENS';
INSERT INTO BuildingModifiers (BuildingType , ModifierId)
	VALUES ('BUILDING_HANGING_GARDENS' , 'HANGING_GARDENS_REGIONAL_HOUSING');
INSERT INTO Modifiers (ModifierId , ModifierType, SubjectRequirementSetId)
	VALUES ('HANGING_GARDENS_REGIONAL_HOUSING' , 'MODIFIER_PLAYER_CITIES_ADJUST_BUILDING_HOUSING' , 'HANGING_GARDENS_REGIONAL_HOUSING_REQUIREMENTS');
INSERT INTO ModifierArguments (ModifierId , Name , Value)
	VALUES ('HANGING_GARDENS_REGIONAL_HOUSING' , 'Amount' , '1');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('HANGING_GARDENS_REGIONAL_HOUSING_REQUIREMENTS' , 'REQUIREMENTSET_TEST_ANY');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('HANGING_GARDENS_REGIONAL_HOUSING_REQUIREMENTS' , 'REQUIRES_PLOT_HAS_HANGING_GARDENS_WITHIN_6');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_PLOT_HAS_HANGING_GARDENS_WITHIN_6' , 'REQUIREMENT_PLOT_ADJACENT_BUILDING_TYPE_MATCHES');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_PLOT_HAS_HANGING_GARDENS_WITHIN_6' , 'BuildingType' ,'BUILDING_HANGING_GARDENS');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_PLOT_HAS_HANGING_GARDENS_WITHIN_6' , 'MaxRange' ,'6');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_PLOT_HAS_HANGING_GARDENS_WITHIN_6' , 'MinRange' ,'0');

-- Great Library unlocks at Drama & Poetry instead of Recorded History
UPDATE Buildings SET PrereqCivic='CIVIC_DRAMA_POETRY' WHERE BuildingType='BUILDING_GREAT_LIBRARY';

-- Venetian Arsenal gives 100% production boost to all naval units in all cities instead of an extra naval unit in its city each time you build one
DELETE FROM BuildingModifiers WHERE	BuildingType='BUILDING_VENETIAN_ARSENAL';

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ANCIENT_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ANCIENT');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ATOMIC_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ATOMIC');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('CLASSICAL_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_CLASSICAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INDUSTRIAL_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INDUSTRIAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INFORMATION_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INFORMATION');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MEDIEVAL_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MEDIEVAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MODERN_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MODERN');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('RENAISSANCE_NAVAL_MELEE_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_MELEE_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_RENAISSANCE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_MELEE_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_MELEE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_MELEE_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ANCIENT_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ANCIENT');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ATOMIC_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ATOMIC');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('CLASSICAL_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_CLASSICAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INDUSTRIAL_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INDUSTRIAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INFORMATION_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INFORMATION');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MEDIEVAL_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MEDIEVAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MODERN_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MODERN');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('RENAISSANCE_NAVAL_RANGED_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_RANGED_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_RENAISSANCE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_RANGED_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RANGED');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_RANGED_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ANCIENT_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ANCIENT');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ATOMIC_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ATOMIC');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('CLASSICAL_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_CLASSICAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INDUSTRIAL_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INDUSTRIAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INFORMATION_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INFORMATION');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MEDIEVAL_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MEDIEVAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MODERN_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MODERN');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('RENAISSANCE_NAVAL_RAIDER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_RAIDER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_RENAISSANCE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_RAIDER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_RAIDER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_RAIDER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');

INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ANCIENT_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ANCIENT');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ANCIENT_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('ATOMIC_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_ATOMIC');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('ATOMIC_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('CLASSICAL_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_CLASSICAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('CLASSICAL_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INDUSTRIAL_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INDUSTRIAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INDUSTRIAL_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('INFORMATION_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_INFORMATION');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('INFORMATION_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MEDIEVAL_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MEDIEVAL');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MEDIEVAL_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('MODERN_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_MODERN');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('MODERN_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');
INSERT INTO Modifiers (ModifierId, ModifierType, RunOnce, NewOnly, Permanent)
VALUES ('RENAISSANCE_NAVAL_CARRIER_PRODUCTION', 'MODIFIER_PLAYER_CITIES_ADJUST_UNIT_TAG_ERA_PRODUCTION', 0, 0, 0);
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_CARRIER_PRODUCTION', 'EraType', 'ARGTYPE_IDENTITY', 'ERA_RENAISSANCE');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_CARRIER_PRODUCTION', 'UnitPromotionClass', 'ARGTYPE_IDENTITY', 'PROMOTION_CLASS_NAVAL_CARRIER');
INSERT INTO ModifierArguments (ModifierId, Name, Type, Value)
VALUES ('RENAISSANCE_NAVAL_CARRIER_PRODUCTION', 'Amount', 'ARGTYPE_IDENTITY', '100');

INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ANCIENT_NAVAL_MELEE_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ATOMIC_NAVAL_MELEE_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'CLASSICAL_NAVAL_MELEE_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INDUSTRIAL_NAVAL_MELEE_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INFORMATION_NAVAL_MELEE_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MEDIEVAL_NAVAL_MELEE_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MODERN_NAVAL_MELEE_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'RENAISSANCE_NAVAL_MELEE_PRODUCTION');

INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ANCIENT_NAVAL_RANGED_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ATOMIC_NAVAL_RANGED_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'CLASSICAL_NAVAL_RANGED_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INDUSTRIAL_NAVAL_RANGED_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INFORMATION_NAVAL_RANGED_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MEDIEVAL_NAVAL_RANGED_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MODERN_NAVAL_RANGED_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'RENAISSANCE_NAVAL_RANGED_PRODUCTION');

INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ANCIENT_NAVAL_RAIDER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ATOMIC_NAVAL_RAIDER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'CLASSICAL_NAVAL_RAIDER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INDUSTRIAL_NAVAL_RAIDER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INFORMATION_NAVAL_RAIDER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MEDIEVAL_NAVAL_RAIDER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MODERN_NAVAL_RAIDER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'RENAISSANCE_NAVAL_RAIDER_PRODUCTION');

INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ANCIENT_NAVAL_CARRIER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'ATOMIC_NAVAL_CARRIER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'CLASSICAL_NAVAL_CARRIER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INDUSTRIAL_NAVAL_CARRIER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'INFORMATION_NAVAL_CARRIER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MEDIEVAL_NAVAL_CARRIER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'MODERN_NAVAL_CARRIER_PRODUCTION');
INSERT INTO BuildingModifiers (BuildingType, ModifierId)
VALUES ('BUILDING_VENETIAN_ARSENAL', 'RENAISSANCE_NAVAL_CARRIER_PRODUCTION');



--==============================================================
--******			W O N D E R S  (NATURAL)			  ******
--==============================================================
-- Several lack-luster wonders improved
UPDATE Features SET Settlement=1 WHERE FeatureType='FEATURE_CLIFFS_DOVER';
INSERT INTO Feature_YieldChanges (FeatureType, YieldType, YieldChange)
	VALUES ('FEATURE_PANTANAL', 'YIELD_SCIENCE', 2);
INSERT INTO Feature_YieldChanges (FeatureType, YieldType, YieldChange)
	VALUES ('FEATURE_DEAD_SEA', 'YIELD_FOOD', 2);
INSERT INTO Feature_YieldChanges (FeatureType, YieldType, YieldChange)
	VALUES ('FEATURE_CRATER_LAKE', 'YIELD_FOOD', 2);
UPDATE Feature_YieldChanges SET YieldChange=2 WHERE FeatureType='FEATURE_CRATER_LAKE' AND YieldType='YIELD_SCIENCE'; 
INSERT INTO Feature_AdjacentYields (FeatureType, YieldType, YieldChange)
	VALUES ('FEATURE_GALAPAGOS', 'YIELD_FOOD', 1);



--==============================================================
--******				    O T H E R					  ******
--==============================================================
-- increase number of turns on spy missions you tend to repeat
UPDATE UnitOperations SET Turns=50 WHERE OperationType='UNITOPERATION_SPY_COUNTERSPY' OR OperationType='UNITOPERATION_SPY_LISTENING_POST';
-- oil can be found on flat plains
INSERT INTO Resource_ValidTerrains (ResourceType, TerrainType)
	VALUES ('RESOURCE_OIL', 'TERRAIN_PLAINS');
-- incense +1 food
INSERT INTO Resource_YieldChanges (ResourceType, YieldType, YieldChange)
	VALUES ('RESOURCE_INCENSE', 'YIELD_FOOD', 1);
-- add 1 production to fishing boat improvement
UPDATE Improvement_YieldChanges SET YieldChange=1 WHERE ImprovementType='IMPROVEMENT_FISHING_BOATS' AND YieldType='YIELD_PRODUCTION';

-- Citizen specialists give +1 main yield
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_CULTURE' 		AND DistrictType="DISTRICT_ACROPOLIS";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_SCIENCE' 		AND DistrictType="DISTRICT_CAMPUS";
UPDATE District_CitizenYieldChanges SET YieldChange=4 WHERE YieldType='YIELD_GOLD' 			AND DistrictType="DISTRICT_COMMERCIAL_HUB";
UPDATE District_CitizenYieldChanges SET YieldChange=2 WHERE YieldType='YIELD_PRODUCTION' 	AND DistrictType="DISTRICT_ENCAMPMENT";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_PRODUCTION' 	AND DistrictType="DISTRICT_HANSA";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_GOLD' 			AND DistrictType="DISTRICT_HARBOR";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_FAITH' 		AND DistrictType="DISTRICT_HOLY_SITE";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_PRODUCTION' 	AND DistrictType="DISTRICT_INDUSTRIAL_ZONE";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_FAITH' 		AND DistrictType="DISTRICT_LAVRA";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_GOLD' 			AND DistrictType="DISTRICT_ROYAL_NAVY_DOCKYARD";
UPDATE District_CitizenYieldChanges SET YieldChange=3 WHERE YieldType='YIELD_CULTURE' 		AND DistrictType="DISTRICT_THEATER";

--****		REQUIREMENTS		****--
INSERT INTO Requirements
	(RequirementId , RequirementType)
	VALUES
	('PLAYER_HAS_MEDIEVAL_FAIRES_CPLMOD', 	'REQUIREMENT_PLAYER_HAS_CIVIC'),
	('PLAYER_HAS_URBANIZATION_CPLMOD', 		'REQUIREMENT_PLAYER_HAS_CIVIC'),
	('PLAYER_HAS_BANKING_CPLMOD'   , 		'REQUIREMENT_PLAYER_HAS_TECHNOLOGY'),
	('PLAYER_HAS_ECONOMICS_CPLMOD' , 		'REQUIREMENT_PLAYER_HAS_TECHNOLOGY');
INSERT INTO RequirementArguments
	(RequirementId , Name , Value)
	VALUES
	('PLAYER_HAS_MEDIEVAL_FAIRES_CPLMOD',	'CivicType', 		'CIVIC_MEDIEVAL_FAIRES'  ),
	('PLAYER_HAS_URBANIZATION_CPLMOD', 	 	'CivicType', 		'CIVIC_URBANIZATION'),
	('PLAYER_HAS_BANKING_CPLMOD'   , 		'TechnologyType', 	'TECH_BANKING'  ),
	('PLAYER_HAS_ECONOMICS_CPLMOD' , 		'TechnologyType', 	'TECH_ECONOMICS');


--for chandra and poland
--Creates Belief Requirement Sets
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIREMENTSET_TEST_ANY');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIREMENTSET_TEST_ANY');
INSERT INTO RequirementSets (RequirementSetId , RequirementSetType)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIREMENTSET_TEST_ANY');
--Attaches Requirement Sets
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_CPLMOD' , 'REQUIREMENT_REQUIREMENTSET_IS_MET');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_CPLMOD' , 'REQUIREMENT_REQUIREMENTSET_IS_MET');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_CPLMOD' , 'REQUIREMENT_REQUIREMENTSET_IS_MET');
--RequirementSet For FOUNDER Belief
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_CHURCH_PROPERTY_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_LAY_MINISTRY_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_PAPAL_PRIMACY_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_PILGRIMAGE_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_STEWARDSHIP_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_TITHE_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_WORLD_CHURCH_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_CROSS_CULTURAL_DIALOGUE_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_RELIGIOUS_UNITY_CPLMOD');
--RequirementSet For WORSHIP Belief
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_CATHEDRAL_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_GURDWARA_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_MEETING_HOUSE_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_MOSQUE_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_PAGODA_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_SYNAGOGUE_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_WAT_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_STUPA_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_DAR_E_MEHR_CPLMOD');
--RequirementSet For ENHANCER Belief
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_DEFENDER_OF_FAITH_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_HOLY_ORDER_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_ITINERANT_PREACHERS_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_JUST_WAR_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_MISSIONARY_ZEAL_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_MONASTIC_ISOLATION_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_SCRIPTURE_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_BURIAL_GROUNDS_CPLMOD');
INSERT INTO RequirementSetRequirements (RequirementSetId , RequirementId)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_REQUIREMENTS_CPLMOD' , 'REQUIRES_BELIEF_RELIGIOUS_COLONIZATION_CPLMOD');
--Checks for FOUNDER Belief
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_CHURCH_PROPERTY_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_LAY_MINISTRY_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_PAPAL_PRIMACY_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_PILGRIMAGE_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_STEWARDSHIP_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_TITHE_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_WORLD_CHURCH_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_CROSS_CULTURAL_DIALOGUE_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_RELIGIOUS_UNITY_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
--Checks for WORSHIP Belief
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_CATHEDRAL_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_GURDWARA_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_MEETING_HOUSE_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_MOSQUE_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_PAGODA_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_SYNAGOGUE_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_WAT_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_STUPA_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_DAR_E_MEHR_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
--Checks for ENHANCER Belief
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_DEFENDER_OF_FAITH_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_HOLY_ORDER_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_ITINERANT_PREACHERS_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_JUST_WAR_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_MISSIONARY_ZEAL_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_MONASTIC_ISOLATION_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_SCRIPTURE_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_BURIAL_GROUNDS_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
INSERT INTO Requirements (RequirementId , RequirementType)
	VALUES ('REQUIRES_BELIEF_RELIGIOUS_COLONIZATION_CPLMOD' , 'REQUIREMENT_PLAYER_FOUNDED_RELIGION_WITH_BELIEF');
--RequirementArguments
--Checks RequirementSets
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('RELIGION_HAS_FOUNDER_BELIEF_CPLMOD' , 'RequirementSetId' , 'RELIGION_HAS_FOUNDER_BELIEF_REQUIREMENTS_CPLMOD');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('RELIGION_HAS_WORSHIP_BELIEF_CPLMOD' , 'RequirementSetId' , 'RELIGION_HAS_WORSHIP_BELIEF_REQUIREMENTS_CPLMOD');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('RELIGION_HAS_ENHANCER_BELIEF_CPLMOD' , 'RequirementSetId' , 'RELIGION_HAS_ENHANCER_BELIEF_REQUIREMENTS_CPLMOD');
--FOUNDER	
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES('REQUIRES_BELIEF_CHURCH_PROPERTY_CPLMOD' , 'BeliefType' , 'BELIEF_CHURCH_PROPERTY');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES('REQUIRES_BELIEF_LAY_MINISTRY_CPLMOD' , 'BeliefType' , 'BELIEF_LAY_MINISTRY');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES('REQUIRES_BELIEF_PAPAL_PRIMACY_CPLMOD' , 'BeliefType' , 'BELIEF_PAPAL_PRIMACY');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES('REQUIRES_BELIEF_PILGRIMAGE_CPLMOD' , 'BeliefType' , 'BELIEF_PILGRIMAGE');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES('REQUIRES_BELIEF_STEWARDSHIP_CPLMOD' , 'BeliefType' , 'BELIEF_STEWARDSHIP');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES('REQUIRES_BELIEF_TITHE_CPLMOD' , 'BeliefType' , 'BELIEF_TITHE');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES('REQUIRES_BELIEF_WORLD_CHURCH_CPLMOD' , 'BeliefType' , 'BELIEF_WORLD_CHURCH');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES('REQUIRES_BELIEF_CROSS_CULTURAL_DIALOGUE_CPLMOD' , 'BeliefType' , 'BELIEF_CROSS_CULTURAL_DIALOGUE');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES('REQUIRES_BELIEF_RELIGIOUS_UNITY_CPLMOD' , 'BeliefType' , 'BELIEF_RELIGIOUS_UNITY');
--WORSHIP	
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_CATHEDRAL_CPLMOD' , 'BeliefType' , 'BELIEF_CATHEDRAL');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_GURDWARA_CPLMOD' , 'BeliefType' , 'BELIEF_GURDWARA');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_MEETING_HOUSE_CPLMOD' , 'BeliefType' , 'BELIEF_MEETING_HOUSE');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_MOSQUE_CPLMOD' , 'BeliefType' , 'BELIEF_MOSQUE');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_PAGODA_CPLMOD' , 'BeliefType' , 'BELIEF_PAGODA');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_SYNAGOGUE_CPLMOD' , 'BeliefType' , 'BELIEF_SYNAGOGUE');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_WAT_CPLMOD' , 'BeliefType' , 'BELIEF_WAT');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_STUPA_CPLMOD' , 'BeliefType' , 'BELIEF_STUPA');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_DAR_E_MEHR_CPLMOD' , 'BeliefType' , 'BELIEF_DAR_E_MEHR');
--ENHANCER
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_DEFENDER_OF_FAITH_CPLMOD' , 'BeliefType' , 'BELIEF_DEFENDER_OF_FAITH');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_HOLY_ORDER_CPLMOD' , 'BeliefType' , 'BELIEF_HOLY_ORDER');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_ITINERANT_PREACHERS_CPLMOD' , 'BeliefType' , 'BELIEF_ITINERANT_PREACHERS');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_JUST_WAR_CPLMOD' , 'BeliefType' , 'BELIEF_JUST_WAR');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_MISSIONARY_ZEAL_CPLMOD' , 'BeliefType' , 'BELIEF_MISSIONARY_ZEAL');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_MONASTIC_ISOLATION_CPLMOD' , 'BeliefType' , 'BELIEF_MONASTIC_ISOLATION');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_SCRIPTURE_CPLMOD' , 'BeliefType' , 'BELIEF_SCRIPTURE');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_BURIAL_GROUNDS_CPLMOD' , 'BeliefType' , 'BELIEF_BURIAL_GROUNDS');
INSERT INTO RequirementArguments (RequirementId , Name , Value)
	VALUES ('REQUIRES_BELIEF_RELIGIOUS_COLONIZATION_CPLMOD' , 'BeliefType' , 'BELIEF_RELIGIOUS_COLONIZATION');

-- for russia, canada, and australia city center yields
INSERT INTO Requirements(RequirementId , RequirementType) VALUES
	('BBG_REQUIRES_PLOT_IS_CITY_CENTER' , 'REQUIREMENT_PLOT_DISTRICT_TYPE_MATCHES');
INSERT INTO RequirementArguments(RequirementId , Name, Value) VALUES
	('BBG_REQUIRES_PLOT_IS_CITY_CENTER' , 'DistrictType', 'DISTRICT_CITY_CENTER');