local modem = peripheral.wrap("back")
modem.open(442)

x,y = term.getSize()

function lastMessage(text)
    term.clearLine(y)
    term.setCursorPos(1,y)
    term.write(text)
end

term.clear()

term.setCursorPos(1,2)
term.write("W: Up")
term.setCursorPos(1,3)
term.write("S: Down")
term.setCursorPos(1,4)
term.write("F: Toggle Stop/Continue")


local toggle1 = true

while true do
    -- arg1 = keynum, arg2 = key_pressed?
    -- arg1 = modemSide, arg2 = senderChannel, arg3 = replyChannel, arg4 = message, arg5 = senderDistance
    local Event_type, arg1, arg2, arg3, arg4, arg5 = os.pullEvent()
    if Event_type == "key" then
        if arg1 == "87" then -- W
            modem.transmit(442,442,"UP")
            lastMessage("Send: UP")
        elseif arg1 == "83" then -- S
            modem.transmit(442,442,"DOWN")
            lastMessage("Send: DOWN")
        elseif arg1 == "70" then -- F
            if toggle1 then
                modem.transmit(442,442,"STOP")
                lastMessage("Send: STOP")
            else
                modem.transmit(442,442,"CONTINUE")
                lastMessage("Send: CONTINUE")
            end
        end
    elseif Event_type == "modem_message" then
        lastMessage("Mail: "..arg4)
    end
end