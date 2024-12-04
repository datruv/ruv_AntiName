fx_version 'adamant'
game 'gta5'

shared_script "@evp/main.lua"
shared_script "shared/encrypt.lua"

server_scripts {
    '@vrp/lib/utils.lua',
    'server.lua'
}

client_scripts {
    'client.lua'
}

