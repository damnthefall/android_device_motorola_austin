#!/vendor/bin/sh
#
# Copyright (c) 2019, Motorola Mobility LLC,  All rights reserved.
#
# The purpose of this script is to annotate panic dumps with useful information
# about the context of the event.
#

export PATH=/vendor/bin:/system/bin:$PATH

trigger=`getprop ro.vendor.boot.apanic.reason`
trigger_prop=`getprop ro.vendor.boot.apanic.prop`

# script already running by boot reason, exit
if [[ $trigger_prop && $trigger == "boot" ]]; then
	exit 0
fi

# run script by db property set and boot reason is not panic
if [[ $trigger_prop && $trigger == "prop" ]]; then
	aee_trigger=`getprop vendor.debug.mtk.aeev.db`
	kp_type=("KE" "HWT" "HW_Reboot" "ManualMRDump" "HANG")
	kp_found=0

	# check panic type
	if [ ! "$aee_trigger" ]; then
		exit 0
	fi

	for va in ${kp_type[@]}; do
		has_str=$(echo $aee_trigger | grep "${va}")
		if [[ "$has_str" != "" ]]; then
			kp_found=1
			break
		fi
	done

	if [ $kp_found == 0 ]; then
		exit 0
	fi
fi

if [ ! -d /data/vendor/dontpanic ]
then
	mkdir /data/vendor/dontpanic
fi

# check for pstore files and copy them to the /data/dontpanic
if [ -e /sys/fs/pstore/console-ramoops ]
then
	cp /sys/fs/pstore/console-ramoops /data/vendor/dontpanic/last_kmsg
	chown root:log /data/vendor/dontpanic/last_kmsg
	chmod 0640 /data/vendor/dontpanic/last_kmsg
	if [ -e /sys/fs/pstore/annotate-ramoops ]
	then
		cat /sys/fs/pstore/annotate-ramoops >> /data/vendor/dontpanic/last_kmsg
	fi

	cat /proc/bootinfo >> /data/vendor/dontpanic/last_kmsg
	cat /proc/version >> /data/vendor/dontpanic/last_kmsg

	#storage
	s_path="/sys/storage/"
	storage="STORAGE: Type: "`cat ${s_path}type`", Vendor: "`cat ${s_path}vendor`
	storage=$storage", Size: "`cat ${s_path}size`", Model: "`cat ${s_path}model`", FW: "`cat ${s_path}fw`
	echo $storage >> /data/vendor/dontpanic/last_kmsg

	#ram
	r_path="/sys/ram/"
	ram="RAM: Vendor: "`cat ${r_path}info`", MR5: "`cat ${r_path}mr5`
	ram=$ram", MR6: "`cat ${r_path}mr6`", MR7: "`cat ${r_path}mr7`", MR8: "`cat ${r_path}mr8`
	echo $ram >> /data/vendor/dontpanic/last_kmsg

fi

if [ -e /sys/fs/pstore/pmsg-ramoops-0 ]
then
	cp /sys/fs/pstore/pmsg-ramoops-0 /data/vendor/dontpanic/apanic_console
	chown root:log /data/vendor/dontpanic/apanic_console
	chmod 0640 /data/vendor/dontpanic/apanic_console
	if [ -e /sys/fs/pstore/annotate-ramoops ]
	then
		cat /sys/fs/pstore/annotate-ramoops >> /data/vendor/dontpanic/apanic_console
	fi
fi

kpgather

if [ -e /dev/block/by-name/logs ] ; then
    BL_logs_parti=/dev/block/by-name/logs
elif [ -e /dev/block/by-name/logfs ] ; then
    BL_logs_parti=/dev/block/by-name/logfs
else
    BL_logs_parti=
fi

if [ $BL_logs_parti ]
then
	cat $BL_logs_parti > /data/vendor/dontpanic/BL_logs
	chown root:log /data/vendor/dontpanic/BL_logs
	chmod 0640 /data/vendor/dontpanic/BL_logs
fi
