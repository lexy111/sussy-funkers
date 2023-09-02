-- stats ( accuracy, score, etc. )

function onUpdatePost()
    if hits < 1 then
        setProperty('scoreTxt.text', '')
    elseif misses < 1 then
        setProperty('scoreTxt.text', '')
    else
        setProperty('scoreTxt.text', '')
    end
end

function round(x, n) --https://stackoverflow.com/questions/18313171/lua-rounding-numbers-and-then-truncate
    n = math.pow(10, n or 0)
    x = x * n
    if x >= 0 then x = math.floor(x + 0.5) else x = math.ceil(x - 0.5) end
    return x / n
end
