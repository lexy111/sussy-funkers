local timer = 0.70 ; --время


function onCreate()
    makeLuaSprite('black', '', 0, 0);
    makeGraphic('black', 1280, 720, '000000');
    setObjectCamera('black', 'other');
    addLuaSprite('black', false);
end

function onSongStart()
    doTweenAlpha('black30000', 'black', 0, timer, 'linear')
end
