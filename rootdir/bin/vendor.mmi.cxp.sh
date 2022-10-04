#!/vendor/bin/sh

# Copyright (c) 2021, Motorola Mobility LLC, All Rights Reserved.
#
# Date Created: 8/30/2021, Set CXP properties according to carrier channel
#

set_cxp_properties ()
{
    boot_carrier=`getprop ro.boot.carrier`
    optr=`getprop persist.vendor.operator.optr`

    case $boot_carrier in
        att|attpre )
            setprop ro.vendor.mtk_md_sbp_custom_value 7
            setprop ro.vendor.operator.optr OP07
            setprop ro.vendor.operator.spec SPEC0407
            setprop ro.vendor.operator.seg SEGDEFAULT
            if [ ! $optr ]; then
                setprop persist.vendor.mtk_usp_md_sbp_code 07
                setprop persist.vendor.operator.optr OP07
                setprop persist.vendor.operator.spec SPEC0407
                setprop persist.vendor.operator.seg SEGDEFAULT
                setprop persist.vendor.mtk_rcs_ua_support 1
            fi
        ;;
        cricket )
            setprop ro.vendor.mtk_md_sbp_custom_value 145
            setprop ro.vendor.operator.optr OP07
            setprop ro.vendor.operator.spec SPEC0407
            setprop ro.vendor.operator.seg SEGDEFAULT
            if [ ! $optr ]; then
                setprop persist.vendor.mtk_usp_md_sbp_code 145
                setprop persist.vendor.operator.optr OP07
                setprop persist.vendor.operator.spec SPEC0407
                setprop persist.vendor.operator.seg SEGDEFAULT
                setprop persist.vendor.mtk_rcs_ua_support 1
            fi
        ;;
        tmo|boost|cc|fi|metropcs|tracfone|retus )
            setprop ro.vendor.mtk_md_sbp_custom_value 8
            setprop ro.vendor.operator.optr OP08
            setprop ro.vendor.operator.spec SPEC0200
            setprop ro.vendor.operator.seg SEGDEFAULT
            if [ ! $optr ]; then
                setprop persist.vendor.mtk_usp_md_sbp_code 08
                setprop persist.vendor.operator.optr OP08
                setprop persist.vendor.operator.spec SPEC0200
                setprop persist.vendor.operator.seg SEGDEFAULT
                setprop persist.vendor.mtk_rcs_ua_support 1
            fi
        ;;
        usc )
            setprop ro.vendor.mtk_md_sbp_custom_value 236
            setprop ro.vendor.operator.optr OP236
            setprop ro.vendor.operator.spec SPEC0200
            setprop ro.vendor.operator.seg SEGDEFAULT
            if [ ! $optr ]; then
                setprop persist.vendor.mtk_usp_md_sbp_code 236
                setprop persist.vendor.operator.optr OP236
                setprop persist.vendor.operator.spec SPEC0200
                setprop persist.vendor.operator.seg SEGDEFAULT
                setprop persist.vendor.mtk_rcs_ua_support 0
            fi
        ;;
        vzw|vzwpre|comcast|spectrum )
            setprop ro.vendor.mtk_md_sbp_custom_value 12
            setprop ro.vendor.operator.optr OP12
            setprop ro.vendor.operator.spec SPEC0200
            setprop ro.vendor.operator.seg SEGDEFAULT
            if [ ! $optr ]; then
                setprop persist.vendor.mtk_usp_md_sbp_code 12
                setprop persist.vendor.operator.optr OP12
                setprop persist.vendor.operator.spec SPEC0200
                setprop persist.vendor.operator.seg SEGDEFAULT
                setprop persist.vendor.mtk_rcs_ua_support 1
            fi
        ;;
        * )
            setprop ro.vendor.mtk_md_sbp_custom_value 0
            setprop ro.vendor.operator.optr ""
            setprop ro.vendor.operator.spec ""
            setprop ro.vendor.operator.seg ""
            if [ ! $optr ]; then
                setprop persist.vendor.mtk_usp_md_sbp_code 0
                setprop persist.vendor.operator.optr ""
                setprop persist.vendor.operator.spec ""
                setprop persist.vendor.operator.seg ""
                setprop persist.vendor.mtk_rcs_ua_support 0
            fi
        ;;
    esac
}

set_cxp_properties
return 0
