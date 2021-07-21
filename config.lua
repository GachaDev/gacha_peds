Config = {}

Config['groups'] = { --Groups authorized to give a Ped
    'superadmin',
    'admin',
    'mod'
}

Config.UseGhmattimysql = false -- enable if you're using ghmattimysql, in this case you should remove the line that contains '@mysql-async/lib/MySQL.lua' in the manifest file.
