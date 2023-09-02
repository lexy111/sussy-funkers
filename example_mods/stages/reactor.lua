function onCreate()
    makeLuaSprite('bg', 'reactor/bg', -300,-101)
    addLuaSprite('bg', false)
	makeLuaSprite('bg2', 'reactor/bg-old', -300,-101)
    addLuaSprite('bg2', false)

	setProperty('bg.visible', true)
	setProperty('bg2.visible', false)
end

function onBeatHit()
	if curBeat == 165 then
		setProperty('bg2.visible', true)
		setProperty('bg.visible', false)
	end

	if curBeat == 372 then
		setProperty('bg2.visible', false)
		setProperty('bg.visible', true)
	end
end