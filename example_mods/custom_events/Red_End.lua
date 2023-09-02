function onCreate()
    makeLuaSprite('red', '', 0, 0);
    makeGraphic('red', 1280, 720, 'FF0000');
    setObjectCamera('red', 'other');
    setProperty('red.alpha', 0);
    addLuaSprite('red', false);
end

function onEvent(name, value1, value2)
    if name == 'Red_End' then
        doTweenAlpha('red30000', 'red', 1, value1, 'linear');
    end
end