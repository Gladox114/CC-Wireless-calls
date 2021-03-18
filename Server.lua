local modem = peripheral.wrap("back")
local monitor = peripheral.wrap("top")
monitor.setTextScale(0.5)
monitor.setCursorPos(1,1)
monitor.clear()
modem.open(442)

x,y = monitor.getSize()

local textPos = 1

function write(text)
    if textPos >= y then
        monitor.scroll(1)
    else
        textPos = textPos + 1
    end
    monitor.setCursorPos(1,textPos)
    monitor.write(text)
end

local toggle1 = true

while true do
    -- added the tablet feature to the server so dead players can also control that damn thing
    -- arg1 = keynum, arg2 = key_pressed?
    -- arg1 = modemSide, arg2 = senderChannel, arg3 = replyChannel, arg4 = message, arg5 = senderDistance
    local Event_type, arg1, arg2, arg3, arg4, arg5 = os.pullEvent()

    if Event_type == "char" then
        if arg1 == "w" then
            redstone.setOutput("bottom", false)
        elseif arg1 == "s" then
            redstone.setOutput("bottom", true)
        end
    elseif Event_type == "key" then
        if arg1 == 32 then
            if toggle1 then
                redstone.setOutput("left", true)
                toggle1 = false
            else
                redstone.setOutput("left", false)
                toggle1 = true
            end
        end
    elseif Event_type == "modem_message" then

        if arg4 == "UP" then
            redstone.setOutput("bottom", false)
        elseif arg4 == "DOWN" then
            redstone.setOutput("bottom", true)
        elseif arg4 == "STOP" then
            redstone.setOutput("left", true)
        elseif arg4 == "CONTINUE" then
            redstone.setOutput("left", false)
        end

        modem.transmit(442,442,"Serv:Rec: "..arg4)

        write("["..arg2.."]>>["..arg3.."]\n")
        write("Distance: "..(arg5 or "?").."\n")
        write("Message: "..arg4.."\n")
    end
end