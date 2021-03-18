local modem = peripheral.wrap("back")
modem.open(442)

x,y = term.getSize()

function lastMessage(text)
    term.setCursorPos(1,y)
    term.clearLine(y)
    term.write(text)
end

term.clear()

term.setCursorPos(1,2)
term.write("W: Up")
term.setCursorPos(1,3)
term.write("S: Down")
term.setCursorPos(1,4)
term.write("F: Toggle Stop/Continue")
lastMessage("<LASTMESSAGE|DEBUG>")

local toggle1 = true

while true do
    -- arg1 = keynum, arg2 = key_pressed?
    -- arg1 = modemSide, arg2 = senderChannel, arg3 = replyChannel, arg4 = message, arg5 = senderDistance
    local Event_type, arg1, arg2, arg3, arg4, arg5 = os.pullEvent()
    if Event_type == "char" then
        if arg1 == "w" then
            modem.transmit(442,442,"UP")
            lastMessage("Send: UP")
        elseif arg1 == "s" then
            modem.transmit(442,442,"DOWN")
            lastMessage("Send: DOWN")
        elseif arg1 == "f" then
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