fx_version 'adamant'

game 'gta5'

author 'Gacha#4596'

description 'A ped system by Gacha'

client_scripts {
	'Client/Modules/*.lua',
	'Client/*.lua',
}

server_scripts {
	'@mysql-async/lib/MySQL.lua',
	'config.lua',
	'Server/Modules/*.lua',
	'Server/*.lua',
	'Server/Classes/*.lua'
}