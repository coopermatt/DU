--[[
Ore Status screen display

This code goes into unit -> start() filter of the programming board

    Make sure you name your screen slot: displayT1, displayT2, displayT3, displayT4, displayT5
    Make sure to link the core, and rename the slot core.
    Make sure to add a tick filter to unit slot, name the tick: updateTable
    In tick lua code, add: generateHtml()
    Add stop filter with lua code, add: displayOff()
    If you don't have a tier of containers, leave off the corresponding display
    Container Mass, and Volume can be changed individually under: Advanced > lua parameters.
    If you use Container Hubs, name the hub, don't name the containers, as that will cause issues, also Hub container weight is 0.
    Currently, all containers need to be the same size.
]]

unit.hide()
if displayT1 then displayT1.activate() end
if displayT2 then displayT2.activate() end
if displayT3 then displayT3.activate() end
if displayT4 then displayT4.activate() end
if displayT5 then displayT5.activate() end

function displayOff()
    if displayT1 then displayT1.clear() end
    if displayT2 then displayT2.clear() end
    if displayT3 then displayT3.clear() end
    if displayT4 then displayT4.clear() end
    if displayT5 then displayT5.clear() end
end

function generateHtml()

    elementsIds = core.getElementIdList()
    containers = {}
    data = {}

    function newContainer(_id)
        local container = 
        {
            id = _id;
            name = core.getElementNameById(_id);
            mass = core.getElementMassById(_id);
        }
        return container
    end


    for i = 1, #elementsIds do
        if string.match(core.getElementTypeById(elementsIds[i]), "ontainer") and string.match(core.getElementNameById(elementsIds[i]),"Ore") then
            table.insert(containers, newContainer(elementsIds[i]))
        end
    end

    for i = 1, #containers do
        table.insert(data, {Container = containers[i].name, ContainerMass = containers[i].mass})
    end

    function round(number,decimals)
        local power = 10^decimals
        return math.floor((number/1000) * power) / power
    end 

    function Status(percent)
        if percent <= 0 then return "<th style=\"color: red;\">EMPTY</th>"
        elseif percent > 0 and percent <=25 then return "<th style=\"color: red;\">LOW</th>"
        elseif percent > 25 and percent <= 50 then return "<th style=\"color: orange;\">LOW</th>"
        elseif percent > 50 and percent <= 99 then return "<th style=\"color: green;\">GOOD</th>"
        else return "<th style=\"color: green;\">FULL</th>"
        end 
    end


    local oreContainerSelfMass = 0 --export: This is the mass of the container, hubs are 0
    local maxOreContainerVol = 166400 --export: This is the maximum volume allowed in the container. Update as needed
    local Error = "<th style=\"color: red;\">ERROR</th>"

--T1 Stuff
    -- Bauxite Variables 
    for k, v in pairs(data) do
        if string.match(data[k].Container,"Bauxite") then
            local weight = 1.28
            massBauxiteOre = round(math.ceil((data[k].ContainerMass - oreContainerSelfMass) / weight),1)
            percentBauxiteOre = math.ceil(((math.ceil((massBauxiteOre*1000) - 0.5)/maxOreContainerVol)*100))
            statusBauxiteOre = Status(percentBauxiteOre)
        end
    end
    if massBauxiteOre == nil then
        massBauxiteOre = 0
        percentBauxite = 0
        statusBauxiteOre = Error
    end



    -- CoalOre Variables
    for k, v in pairs(data) do
        if string.match(data[k].Container,"Coal") then
            local weight = 1.35
            massCoalOre = round(math.ceil((data[k].ContainerMass - oreContainerSelfMass) / weight),1)
            percentCoalOre = math.ceil(((math.ceil((massCoalOre*1000) - 0.5)/maxOreContainerVol)*100))
            statusCoalOre = Status(percentCoalOre)
        end
    end
    if massCoalOre == nil then
        massCoalOre = 0
        percentCoalOre = 0
        statusCoalOre = Error
    end


    -- HematiteOre Variables
    for k, v in pairs(data) do
        if string.match(data[k].Container,"Hematite") then
            local weight = 5.04
            massHematiteOre = round(math.ceil((data[k].ContainerMass - oreContainerSelfMass) / weight),1)
            percentHematiteOre = math.ceil(((math.ceil((massHematiteOre*1000) - 0.5)/maxOreContainerVol)*100))
            statusHematiteOre = Status(percentHematiteOre)
        end
    end
    if massHematiteOre == nil then
        massHematiteOre = 0
        percentHematiteOre = 0
        statusHematiteOre = Error
    end


    -- QuartzOre Variables
    for k, v in pairs(data) do
        if string.match(data[k].Container, "Quartz") then
            local weight = 2.65
            massQuartzOre = round(math.ceil((data[k].ContainerMass - oreContainerSelfMass) / weight),1)
            percentQuartzOre = math.ceil(((math.ceil((massQuartzOre*1000) - 0.5)/maxOreContainerVol)*100))
            statusQuartzOre = Status(percentQuartzOre)
        end
    end
    if massQuartzOre == nil then
        massQuartzOre= 0
        percentQuartzOre = 0
        statusQuartzOre = Error
    end


--T2 Stuff

    -- ChromiteOre Variables 
    for k, v in pairs(data) do
        if string.match(data[k].Container, "Chromite") then
            local weight = 4.54
            massChromiteOre = round(math.ceil((data[k].ContainerMass - oreContainerSelfMass) / weight),1)
            percentChromiteOre = math.ceil(((math.ceil((massChromiteOre*1000) - 0.5)/maxOreContainerVol)*100))
            statusChromiteOre = Status(percentChromiteOre)
        end
    end
    if massChromiteOre == nil then
        massChromiteOre = 0
        percentChromiteOre = 0
        statusChromiteOre = Error
    end

    -- MalachiteOre Variables 
    for k, v in pairs(data) do
        if string.match(data[k].Container, "Malachite") then
            local weight = 4.00
            massMalachiteOre = round(math.ceil((data[k].ContainerMass - oreContainerSelfMass) / weight),1)
            percentMalachiteOre = math.ceil(((math.ceil((massMalachiteOre*1000) - 0.5)/maxOreContainerVol)*100))
            statusMalachiteOre = Status(percentMalachiteOre)
        end
    end
    if massMalachiteOre == nil then
        massMalachiteOre = 0
        percentMalachiteOre = 0
        statusMalachiteOre = Error
    end

    -- LimestoneOre Variables 
    for k, v in pairs(data) do
        if string.match(data[k].Container, "Limestone") then
            local weight = 2.71
            massLimestoneOre = round(math.ceil((data[k].ContainerMass - oreContainerSelfMass) / weight),1)
            percentLimestoneOre = math.ceil(((math.ceil((massLimestoneOre*1000) - 0.5)/maxOreContainerVol)*100))
            statusLimestoneOre = Status(percentLimestoneOre)
        end
    end
    if massLimestoneOre == nil then
        massLimestoneOre = 0
        percentLimestoneOre = 0
        statusLimestoneOre = Error
    end

    -- NatronOre Variables 
    for k, v in pairs(data) do
        if string.match(data[k].Container, "Natron") then
            local weight = 1.55
            massNatronOre = round(math.ceil((data[k].ContainerMass - oreContainerSelfMass) / weight),1)
            percentNatronOre = math.ceil(((math.ceil((massNatronOre*1000) - 0.5)/maxOreContainerVol)*100))
            statusNatronOre = Status(percentNatronOre)
        end
    end
    if massNatronOre == nil then
        massNatronOre = 0
        percentNatronOre = 0
        statusNatronOre = Error
    end

--T3 Stuff

    -- GarnieriteOre Variables 
    for k, v in pairs(data) do
        if string.match(data[k].Container, "Garnierite") then
            local weight = 2.60
            massGarnieriteOre = round(math.ceil((data[k].ContainerMass - oreContainerSelfMass) / weight),1)
            percentGarnieriteOre = math.ceil(((math.ceil((massGarnieriteOre*1000) - 0.5)/maxOreContainerVol)*100))
            statusGarnieriteOre = Status(percentGarnieriteOre)
        end
    end
    if massGarnieriteOre == nil then
        massGarnieriteOre = 0
        percentGarnieriteOre = 0
        statusGarnieriteOre = Error
    end

    -- PetaliteOre Variables
    for k, v in pairs(data) do
        if string.match(data[k].Container, "Petalite") then
            local weight = 2.41
            massPetaliteOre = round(math.ceil((data[k].ContainerMass - oreContainerSelfMass) / weight),1)
            percentPetaliteOre = math.ceil(((math.ceil((massPetaliteOre*1000) - 0.5)/maxOreContainerVol)*100))
            statusPetaliteOre = Status(percentPetaliteOre)
        end
    end
    if massPetaliteOre == nil then
        massPetaliteOre = 0
        percentPetaliteOre = 0
        statusPetaliteOre = Error
    end

    -- AcanthiteOre Variables
    for k, v in pairs(data) do
        if string.match(data[k].Container, "Acanthite") then
            local weight = 7.20
            massAcanthiteOre = round(math.ceil((data[k].ContainerMass - oreContainerSelfMass) / weight),1)
            percentAcanthiteOre = math.ceil(((math.ceil((massAcanthiteOre*1000) - 0.5)/maxOreContainerVol)*100))
            statusAcanthiteOre = Status(percentAcanthiteOre)
        end
    end
    if massAcanthiteOre == nil then
        massAcanthiteOre = 0
        percentAcanthiteOre = 0
        statusAcanthiteOre = Error
    end

    -- PyriteOre Variables
    for k, v in pairs(data) do
        if string.match(data[k].Container, "Pyrite") then
            local weight = 5.01
            massPyriteOre = round(math.ceil((data[k].ContainerMass - oreContainerSelfMass) / weight),1)
            percentPyriteOre = math.ceil(((math.ceil((massPyriteOre*1000) - 0.5)/maxOreContainerVol)*100))
            statusPyriteOre = Status(percentPyriteOre)
        end
    end
    if massPyriteOre == nil then
        massPyriteOre = 0
        percentPyriteOre = 0
        statusPyriteOre = Error
    end

--T4 Stuff

    -- CobaltiteOre Variables 
    for k, v in pairs(data) do
        if string.match(data[k].Container, "Cobaltite") then
            local weight = 6.33
            massCobaltiteOre = round(math.ceil((data[k].ContainerMass - oreContainerSelfMass) / weight),1)
            percentCobaltiteOre = math.ceil(((math.ceil((massCobaltiteOre*1000) - 0.5)/maxOreContainerVol)*100))
            statusCobaltiteOre = Status(percentCobaltiteOre)
        end
    end
    if massCobaltiteOre == nil then
        massCobaltiteOre = 0
        percentCobaltiteOre = 0
        statusCobaltiteOre = Error
    end

    -- CryoliteOre Variables
    for k, v in pairs(data) do
        if string.match(data[k].Container, "Cryolite") then
            local weight = 2.95
            massCryoliteOre = round(math.ceil((data[k].ContainerMass - oreContainerSelfMass) / weight),1)
            percentCryoliteOre = math.ceil(((math.ceil((massCryoliteOre*1000) - 0.5)/maxOreContainerVol)*100))
            statusCryoliteOre = Status(percentCryoliteOre)
        end
    end
    if massCryoliteOre == nil then
        massCryoliteOre = 0
        percentCryoliteOre = 0
        statusCryoliteOre = Error
    end

    -- GoldOre Variables
    for k, v in pairs(data) do
        if string.match(data[k].Container, "Gold") then
            local weight = 19.30
            massGoldOre = round(math.ceil((data[k].ContainerMass - oreContainerSelfMass) / weight),1)
            percentGoldOre = math.ceil(((math.ceil((massGoldOre*1000) - 0.5)/maxOreContainerVol)*100))
            statusGoldOre = Status(percentGoldOre)
        end
    end
    if massGoldOre == nil then
        massGoldOre = 0
        percentGoldOre = 0
        statusGoldOre = Error
    end

    -- KolbeckiteOre Variables
    for k, v in pairs(data) do
        if string.match(data[k].Container, "Kolbeckite") then
            local weight = 2.37
            massKolbeckiteOre = round(math.ceil((data[k].ContainerMass - oreContainerSelfMass) / weight),1)
            percentKolbeckiteOre = math.ceil(((math.ceil((massKolbeckiteOre*1000) - 0.5)/maxOreContainerVol)*100))
            statusKolbeckiteOre = Status(percentKolbeckiteOre)
        end
    end
    if massKolbeckiteOre == nil then
        massKolbeckiteOre = 0
        percentKolbeckiteOre = 0
        statusKolbeckiteOre = Error
    end

--T5 Stuff

    -- RhodoniteOre Variables 
    for k, v in pairs(data) do
        if string.match(data[k].Container, "Rhodonite") then
            local weight = 3.76
            massRhodoniteOre = round(math.ceil((data[k].ContainerMass - oreContainerSelfMass) / weight),1)
            percentRhodoniteOre = math.ceil(((math.ceil((massRhodoniteOre*1000) - 0.5)/maxOreContainerVol)*100))
            statusRhodoniteOre = Status(percentRhodoniteOre)
        end
    end
    if massRhodoniteOre == nil then
        massRhodoniteOre = 0
        percentRhodoniteOre = 0
        statusRhodoniteOre = Error
    end

    -- ColumbiteOre Variables
    for k, v in pairs(data) do
        if string.match(data[k].Container, "Columbite") then
            local weight = 5.38
            massColumbiteOre = round(math.ceil((data[k].ContainerMass - oreContainerSelfMass) / weight),1)
            percentColumbiteOre = math.ceil(((math.ceil((massColumbiteOre*1000) - 0.5)/maxOreContainerVol)*100))
            statusColumbiteOre = Status(percentColumbiteOre)
        end
    end
    if massColumbiteOre == nil then
        massColumbiteOre = 0
        percentColumbiteOre = 0
        statusColumbiteOre = Error
    end

    -- IllmeniteOre Variables
    for k, v in pairs(data) do
        if string.match(data[k].Container, "Illmenite") then
            local weight = 4.55
            massIllmeniteOre = round(math.ceil((data[k].ContainerMass - oreContainerSelfMass) / weight),1)
            percentIllmeniteOre = math.ceil(((math.ceil((massIllmeniteOre*1000) - 0.5)/maxOreContainerVol)*100))
            statusIllmeniteOre = Status(percentIllmeniteOre)
        end
    end
    if massIllmeniteOre == nil then
        massIllmeniteOre = 0
        percentIllmeniteOre = 0
        statusIllmeniteOre = Error
    end

    -- VanadiniteOre Variables
    for k, v in pairs(data) do
        if string.match(data[k].Container, "Vanadinite") then
            local weight = 6.95
            massVanadiniteOre = round(math.ceil((data[k].ContainerMass - oreContainerSelfMass) / weight),1)
            percentVanadiniteOre = math.ceil(((math.ceil((massVanadiniteOre*1000) - 0.5)/maxOreContainerVol)*100))
            statusVanadiniteOre = Status(percentVanadiniteOre)
        end
    end
    if massVanadiniteOre == nil then
        massVanadiniteOre = 0
        percentVanadiniteOre = 0
        statusVanadiniteOre = Error
    end

    if displayT1 then
        html = [[
        <div class="bootstrap">
        <h1 style="
            font-size: 8em;
            text-transform: capitalize;
        ">T1 Ore Status</h1>
        <table 
        style="
            margin-top: 10px;
            margin-left: auto;
            margin-right: auto;
            width: 98%;
            font-size: 4em;
            text-transform: capitalize;
        ">
            </br>
            <tr style="
                width: 100%;
                margin-bottom: 30px;
                background-color: blue;
                color: white;
                text-transform: capitalize;
            ">
                <th>Type</th>
                <th>Qty</th>
                <th>MaxQty</th>
                <th>Levels</th>
                <th>Status</th>
            <tr>
                <th>Bauxite</th>
                <th>]]..massBauxiteOre..[[KL]]..[[</th>
                <th>]]..maxOreContainerVol/1000 ..[[KL]]..[[</th>
                <th>]]..percentBauxiteOre..[[%</th>
                ]]..statusBauxiteOre..[[
            </tr>
            <tr>
                <th>Coal</th>
                <th>]]..massCoalOre..[[KL]]..[[</th>
                <th>]]..maxOreContainerVol/1000 ..[[KL]]..[[</th>
                <th>]]..percentCoalOre..[[%</th>
                ]]..statusCoalOre..[[
            </tr>
            <tr>
                <th>Hematite</th>
                <th>]]..massHematiteOre..[[KL]]..[[</th>
                <th>]]..maxOreContainerVol/1000 ..[[KL]]..[[</th>
                <th>]]..percentHematiteOre..[[%</th>
                ]]..statusHematiteOre..[[
            </tr>
            <tr>
                <th>Quartz</th>
                <th>]]..massQuartzOre..[[KL]]..[[</th>
                <th>]]..maxOreContainerVol/1000 ..[[KL]]..[[</th>
                <th>]]..percentQuartzOre..[[%</th>
                ]]..statusQuartzOre..[[
            </tr>
        </table>
        </div>
        ]]
        displayT1.setHTML(html)
    end

    if displayT2 then
        html = [[
        <div class="bootstrap">
        <h1 style="
            font-size: 8em;
            text-transform: capitalize;
        ">T2 Ore Status</h1>
        <table 
        style="
            margin-top: 10px;
            margin-left: auto;
            margin-right: auto;
            width: 98%;
            font-size: 4em;
            text-transform: capitalize;
        ">
            </br>
            <tr style="
                width: 100%;
                margin-bottom: 30px;
                background-color: blue;
                color: white;
                text-transform: capitalize;
            ">
                <th>Type</th>
                <th>Qty</th>
                <th>MaxQty</th>
                <th>Levels</th>
                <th>Status</th>
            <tr>
                <th>Natron</th>
                <th>]]..massNatronOre..[[KL]]..[[</th>
                <th>]]..maxOreContainerVol/1000 ..[[KL]]..[[</th>
                <th>]]..percentNatronOre..[[%</th>
                ]]..statusNatronOre..[[
            </tr>
            <tr>
                <th>Malachite</th>
                <th>]]..massMalachiteOre..[[KL]]..[[</th>
                <th>]]..maxOreContainerVol/1000 ..[[KL]]..[[</th>
                <th>]]..percentMalachiteOre..[[%</th>
                ]]..statusMalachiteOre..[[
            </tr>
            <tr>
                <th>Limestone</th>
                <th>]]..massLimestoneOre..[[KL]]..[[</th>
                <th>]]..maxOreContainerVol/1000 ..[[KL]]..[[</th>
                <th>]]..percentLimestoneOre..[[%</th>
                ]]..statusLimestoneOre..[[
            </tr>
            <tr>
                <th>Chromite</th>
                <th>]]..massChromiteOre..[[KL]]..[[</th>
                <th>]]..maxOreContainerVol/1000 ..[[KL]]..[[</th>
                <th>]]..percentChromiteOre..[[%</th>
                ]]..statusChromiteOre..[[
            </tr>
        </table>
        </div>
        ]]
        displayT2.setHTML(html)
    end

    if displayT3 then
        html = [[
        <div class="bootstrap">
        <h1 style="
            font-size: 8em;
            text-transform: capitalize;
        ">T3 Ore Status</h1>
        <table 
        style="
            margin-top: 10px;
            margin-left: auto;
            margin-right: auto;
            width: 98%;
            font-size: 4em;
            text-transform: capitalize;
        ">
            </br>
            <tr style="
                width: 100%;
                margin-bottom: 30px;
                background-color: blue;
                color: white;
                text-transform: capitalize;
            ">
                <th>Type</th>
                <th>Qty</th>
                <th>MaxQty</th>
                <th>Levels</th>
                <th>Status</th>
            <tr>
                <th>Petalite</th>
                <th>]]..massPetaliteOre..[[KL]]..[[</th>
                <th>]]..maxOreContainerVol/1000 ..[[KL]]..[[</th>
                <th>]]..percentPetaliteOre..[[%</th>
                ]]..statusPetaliteOre..[[
            </tr>
            <tr>
                <th>Garnierite</th>
                <th>]]..massGarnieriteOre..[[KL]]..[[</th>
                <th>]]..maxOreContainerVol/1000 ..[[KL]]..[[</th>
                <th>]]..percentGarnieriteOre..[[%</th>
                ]]..statusGarnieriteOre..[[
            </tr>
            <tr>
                <th>Pyrite</th>
                <th>]]..massPyriteOre..[[KL]]..[[</th>
                <th>]]..maxOreContainerVol/1000 ..[[KL]]..[[</th>
                <th>]]..percentPyriteOre..[[%</th>
                ]]..statusPyriteOre..[[
            </tr>
            <tr>
                <th>Acanthite</th>
                <th>]]..massAcanthiteOre..[[KL]]..[[</th>
                <th>]]..maxOreContainerVol/1000 ..[[KL]]..[[</th>
                <th>]]..percentAcanthiteOre..[[%</th>
                ]]..statusAcanthiteOre..[[
            </tr>
            
        </table>
        </div>
        ]]
        displayT3.setHTML(html)
    end

    if displayT4 then
        html = [[
        <div class="bootstrap">
        <h1 style="
            font-size: 8em;
            text-transform: capitalize;
        ">T4 Ore Status</h1>
        <table 
        style="
            margin-top: 10px;
            margin-left: auto;
            margin-right: auto;
            width: 98%;
            font-size: 4em;
            text-transform: capitalize;
        ">
            </br>
            <tr style="
                width: 100%;
                margin-bottom: 30px;
                background-color: blue;
                color: white;
                text-transform: capitalize;
            ">
                <th>Type</th>
                <th>Qty</th>
                <th>MaxQty</th>
                <th>Levels</th>
                <th>Status</th>
            <tr>
                <th>Cobaltite</th>
                <th>]]..massCobaltiteOre..[[KL]]..[[</th>
                <th>]]..maxOreContainerVol/1000 ..[[KL]]..[[</th>
                <th>]]..percentCobaltiteOre..[[%</th>
                ]]..statusCobaltiteOre..[[
            </tr>
            <tr>
                <th>Cryolite</th>
                <th>]]..massCryoliteOre..[[KL]]..[[</th>
                <th>]]..maxOreContainerVol/1000 ..[[KL]]..[[</th>
                <th>]]..percentCryoliteOre..[[%</th>
                ]]..statusCryoliteOre..[[
            </tr>
            <tr>
                <th>Gold Nuggets</th>
                <th>]]..massGoldOre..[[KL]]..[[</th>
                <th>]]..maxOreContainerVol/1000 ..[[KL]]..[[</th>
                <th>]]..percentGoldOre..[[%</th>
                ]]..statusGoldOre..[[
            </tr>
            <tr>
                <th>Kolbeckite</th>
                <th>]]..massKolbeckiteOre..[[KL]]..[[</th>
                <th>]]..maxOreContainerVol/1000 ..[[KL]]..[[</th>
                <th>]]..percentKolbeckiteOre..[[%</th>
                ]]..statusKolbeckiteOre..[[
            </tr>
            
        </table>
        </div>
        ]]
        displayT4.setHTML(html)
    end

    if displayT5 then
        html = [[
        <div class="bootstrap">
        <h1 style="
            font-size: 8em;
            text-transform: capitalize;
        ">T5 Ore Status</h1>
        <table 
        style="
            margin-top: 10px;
            margin-left: auto;
            margin-right: auto;
            width: 98%;
            font-size: 4em;
            text-transform: capitalize;
        ">
            </br>
            <tr style="
                width: 100%;
                margin-bottom: 30px;
                background-color: blue;
                color: white;
                text-transform: capitalize;
            ">
                <th>Type</th>
                <th>Qty</th>
                <th>MaxQty</th>
                <th>Levels</th>
                <th>Status</th>
            <tr>
                <th>Rhodonite</th>
                <th>]]..massRhodoniteOre..[[KL]]..[[</th>
                <th>]]..maxOreContainerVol/1000 ..[[KL]]..[[</th>
                <th>]]..percentRhodoniteOre..[[%</th>
                ]]..statusRhodoniteOre..[[
            </tr>
            <tr>
                <th>Columbite</th>
                <th>]]..massColumbiteOre..[[KL]]..[[</th>
                <th>]]..maxOreContainerVol/1000 ..[[KL]]..[[</th>
                <th>]]..percentColumbiteOre..[[%</th>
                ]]..statusColumbiteOre..[[
            </tr>
            <tr>
                <th>Illmenite</th>
                <th>]]..massIllmeniteOre..[[KL]]..[[</th>
                <th>]]..maxOreContainerVol/1000 ..[[KL]]..[[</th>
                <th>]]..percentIllmeniteOre..[[%</th>
                ]]..statusIllmeniteOre..[[
            </tr>
            <tr>
                <th>Vanadinite</th>
                <th>]]..massVanadiniteOre..[[KL]]..[[</th>
                <th>]]..maxOreContainerVol/1000 ..[[KL]]..[[</th>
                <th>]]..percentVanadiniteOre..[[%</th>
                ]]..statusVanadiniteOre..[[
            </tr>
        </table>
        </div>
        ]]
        displayT5.setHTML(html)
    end
end
unit.setTimer('updateTable', 1)