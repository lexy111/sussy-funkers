function onBeatHit()
	if curBeat == 165 then
		addVCREffect('camgame')
   		 addVCREffect('camhud', false)
		makeGraphic('sasa', 'vin', 0, 0)
		addLuaSprite('sasa')
		setProperty('sasa.visible', true)
	end

	if curBeat == 372 then
		clearEffects('camhud')
		clearEffects('camgame')
			
		setProperty('sasa.visible', false)
	end
end