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


while true do
    local event, modemSide, senderChannel,
    replyChannel, message, senderDistance = os.pullEvent("modem_message")

    if message == "UP" then
        redstone.setOutput("bottom", false)
    elseif message == "DOWN" then
        redstone.setOutput("bottom", true)
    elseif message == "STOP" then
        redstone.setOutput("left", true)
    elseif message == "CONTINUE" then
        redstone.setOutput("left", false)
    end

    modem.transmit(442,442,"Server: got the Message: "..message)

    write("["..senderChannel.."]>>["..replyChannel.."]\n")
    write("Distance: "..(senderDistance or "?").."\n")
    write("Message: "..message.."\n")
end