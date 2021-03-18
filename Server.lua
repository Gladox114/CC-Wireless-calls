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
        --monitor.write(text)
    end
    textPos = textPos + 1
    monitor.setCursorPos(1,textPos)
    monitor.write(text)
end


while true do
    local event, modemSide, senderChannel,
    replyChannel, message, senderDistance = os.pullEvent("modem_message")


    write("["..senderChannel.."]>>["..replyChannel.."]\n")
    write("Distance: "..(senderDistance or "?").."\n")
    write("Message: "..message.."\n")
end