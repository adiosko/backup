# dec/07/2017 19:58:03 by RouterOS 6.40.5
# software id = GXCE-KYGV
#
#
#
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/tool user-manager customer
set admin access=\
    own-routers,own-users,own-profiles,own-limits,config-payment-gw
/ip address
add address=172.16.53.2/24 interface=ether1 network=172.16.53.0
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1
/system lcd
set contrast=0 enabled=no port=parallel type=24x4
/system lcd page
set time disabled=yes display-time=5s
set resources disabled=yes display-time=5s
set uptime disabled=yes display-time=5s
set packets disabled=yes display-time=5s
set bits disabled=yes display-time=5s
set version disabled=yes display-time=5s
set identity disabled=yes display-time=5s
set ether1 disabled=yes display-time=5s
/tool bandwidth-server
set max-sessions=200
/tool e-mail
set address=172.16.53.2 from=admin@admin.com password=admin user=admin
/tool graphing
set store-every=24hours
/tool graphing interface
add
/tool romon
set enabled=yes secrets=admin
/tool sniffer
set filter-direction=rx filter-interface=ether1 \
    filter-operator-between-entries=and filter-stream=yes streaming-enabled=\
    yes streaming-server=8.8.8.8
/tool user-manager database
set db-path=user-manager
