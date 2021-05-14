-- Copyright (C) 2021 dz <dingzhong110@gmail.com>

local m,s,o
local sys = require "luci.sys"
local uci = require "luci.model.uci".cursor()

-- Basic
m = Map("easymesh")
s = m:section(TypedSection, "easymesh", translate("Settings"), translate("General Settings"))
s.anonymous = true

---- Eanble
o = s:option(Flag, "enabled", translate("Enable"), translate("Enable or disable EASY MESH"))
o.default = 0
o.rmempty = false

apRadio = s:option(ListValue, "apRadio", translate("MESH Radio device"), translate("The radio device which MESH use"))
uci:foreach("wireless", "wifi-device",
							function(s)
								apRadio:value(s['.name'])
							end)
o.default = "radio0"
o.rmempty = false

---- mesh
o = s:option(Value, "mesh_id", translate("MESH ID"))
o.default = "easymesh"
o.description = translate("MESH ID")

enable = s:option(Flag, "encryption", translate("Encryption"), translate(""))
enable.default = 0
enable.rmempty = false

o = s:option(Value, "key", translate("Key"))
o.default = "easymesh"
o:depends("encryption", 1)

---- ap_mode
enable = s:option(Flag, "ap_mode", translate("AP MODE Enable"), translate("Enable or disable AP MODE"))
enable.default = 0
enable.rmempty = false

o = s:option(Value, "ipaddr", translate("IPv4-Address"))
o.default = "192.168.1.10"
o.datatype = "ip4addr"
o:depends("ap_mode", 1)

o = s:option(Value, "netmask", translate("IPv4 netmask"))
o.default = "255.255.255.0"
o.datatype = "ip4addr"
o:depends("ap_mode", 1)

o = s:option(Value, "gateway", translate("IPv4 gateway"))
o.default = "192.168.1.1"
o.datatype = "ip4addr"
o:depends("ap_mode", 1)

o = s:option(Value, "dns", translate("Use custom DNS servers"))
o.default = "192.168.1.1"
o.datatype = "ip4addr"
o:depends("ap_mode", 1)

return m
