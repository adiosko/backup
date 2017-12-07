#!/bin/bash
user="admin"
address="172.16.53.2"
#command will get devcie hostname in complex form 
ssh $user@$address '/system identity print interval=' > devices

#will get device hostname
tmpDevices=$(cat devices)
device=$(echo $tmpDevices | awk ' {print $2} ')
echo "Device hostname is $device"
echo $device

#custom months names
day=$(date +%d)
mon=$(date +%m)
daymon=$(date +%b%d | tr [:upper:] [:lower:])




#Creation of backup, log export, export file
echo "Creating backup file"
ssh $user@$address ':local name [/system identity get name];:local date [/system clock get date];:local day [ :pick $date 4 6 ];:local month [ :pick $date 0 3 ];:local backupName ($name."_".$month.$day."backup");:put $backupName;/system backup save name=$backupName'
echo "exporting config"
ssh $user@$address ':local name [/system identity get name];:local date [/system clock get date];:local day [ :pick $date 4 6 ];:local month [ :pick $date 0 3 ];:local backupName ($name."_".$month.$day."export");:put $backupName;/export file=$backupName'
echo "exporting log"
ssh $user@$address ':local name [/system identity get name];:local date [/system clock get date];:local day [ :pick $date 4 6 ];:local month [ :pick $date 0 3 ];:local backupName ($name."_".$month.$day."log");:put $backupName;/log print file=$backupName'



#echo "$device a"
#echo -e "\n"
len=${#device}
len=$(($len-1))
#echo -e "$len\n"
name=`expr substr $device 1 $len`
#echo -e "$name*"
#device="$device*"
sftp "${user}@${address}:${name}*"
#echo -e "\n\n$device\n"
#sftp ${user}@${address} << EOF 
#get "$name"*
#quit
#EOF

#editing month format
filelog="${name}_${daymon}log.txt"
filebackup="${name}_${daymon}backup.backup"
fileexport="${name}_${daymon}export.rsc"
#echo $device
echo $filelog
echo $filebackup
echo $fileexport

#Deleting files
echo "deleting files"
ssh $user@$address ':local name [/system identity get name];:local date [/system clock get date];:local day [ :pick $date 4 6 ];:local month [ :pick $date 0 3 ];:local backupName ($name."_".$month.$day."backup");:put $backupName;/file remove numbers=$backupName'
echo "deleting export"
ssh $user@$address ':local name [/system identity get name];:local date [/system clock get date];:local day [ :pick $date 4 6 ];:local month [ :pick $date 0 3 ];:local backupName ($name."_".$month.$day."export");:put $backupName;/file remove numbers=$backupName'
echo "exporting log"
ssh $user@$address ':local name [/system identity get name];:local date [/system clock get date];:local day [ :pick $date 4 6 ];:local month [ :pick $date 0 3 ];:local backupName ($name."_".$month.$day."log");:put $backupName;/file remove numbers=$backupName'
