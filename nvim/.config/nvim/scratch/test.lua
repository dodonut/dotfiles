local a = function()
    for i=0,10,1 do
        os.execute("sleep " .. tonumber(1))
        print("sleeping")
    end
end


a()
