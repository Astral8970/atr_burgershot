fx_version 'adamant'

game 'gta5'

this_is_a_map 'yes'


client_scripts {
	'framework.lua',
	'client.lua',
	'config.lua',
	'@es_extended/locale.lua'
}

server_scripts {
	'server.lua',
	'@es_extended/locale.lua'
}



files {
	'bs_timecycmod.xml'
}

data_file 'TIMECYCLEMOD_FILE' 'bs_timecycmod.xml'
data_file 'SCALEFORM_DLC_FILE' 'stream/int1756029552.gfx'
