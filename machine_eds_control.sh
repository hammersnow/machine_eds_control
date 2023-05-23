#!/bin/bash
#ekremiscan

ips=(10.1.10.37 10.1.10.40 10.1.10.35 10.1.10.36 10.1.10.38 10.1.10.39 10.1.10.25 10.1.10.17 10.1.10.23 10.1.10.22 10.1.10.33 10.1.10.32 10.1.10.20 10.1.10.28 10.1.10.21 10.1.10.26 10.1.10.27 10.1.10.24 10.1.10.44 10.1.10.46 10.1.10.43 10.1.10.45 10.1.10.41 10.1.10.42 )

for ip in "${ips[@]}"; do
        ssh -T $ip << \code

echo -e "\033[0;37m"
ipcikti=$(ifconfig | grep addr:10 | awk -F: '{print $2}' | awk '{print $1}')
if [[ $ipcikti == '10.1.10.37' ]]; then 
echo -e "ED01(10.1.10.37)"
elif [[ $ipcikti == '10.1.10.40' ]]; then 
echo -e "ED02(10.1.10.40)"
elif [[ $ipcikti == '10.1.10.35' ]]; then 
echo -e "ED03(10.1.10.35)"
elif [[ $ipcikti == '10.1.10.36' ]]; then 
echo -e "ED04(10.1.10.36)"
elif [[ $ipcikti == '10.1.10.38' ]]; then 
echo -e "ED05(10.1.10.38)"
elif [[ $ipcikti == '10.1.10.39' ]]; then 
echo -e "ED06(10.1.10.39)"
elif [[ $ipcikti == '10.1.10.25' ]]; then 
echo -e "ED09(10.1.10.25)"
elif [[ $ipcikti == '10.1.10.17' ]]; then 
echo -e "ED10(10.1.10.17)"
elif [[ $ipcikti == '10.1.10.23' ]]; then 
echo -e "ED11(10.1.10.23)"
elif [[ $ipcikti == '10.1.10.22' ]]; then 
echo -e "ED12(10.1.10.22)"
elif [[ $ipcikti == '10.1.10.33' ]]; then 
echo -e "ED13(10.1.10.33)"
elif [[ $ipcikti == '10.1.10.32' ]]; then 
echo -e "ED14(10.1.10.32)"
elif [[ $ipcikti == '10.1.10.20' ]]; then 
echo -e "ED15(10.1.10.20)"
elif [[ $ipcikti == '10.1.10.28' ]]; then 
echo -e "ED16(10.1.10.28)"
elif [[ $ipcikti == '10.1.10.21' ]]; then 
echo -e "ED17(10.1.10.21)"
elif [[ $ipcikti == '10.1.10.26' ]]; then 
echo -e "ED18(10.1.10.26)"
elif [[ $ipcikti == '10.1.10.27' ]]; then 
echo -e "ED19(10.1.10.27)"
elif [[ $ipcikti == '10.1.10.24' ]]; then 
echo -e "ED20(10.1.10.24)"
elif [[ $ipcikti == '10.1.10.44' ]]; then 
echo -e "ED23(10.1.10.44)"
elif [[ $ipcikti == '10.1.10.46' ]]; then 
echo -e "ED24(10.1.10.46)"
elif [[ $ipcikti == '10.1.10.43' ]]; then 
echo -e "ED25(10.1.10.43)"
elif [[ $ipcikti == '10.1.10.45' ]]; then 
echo -e "ED26(10.1.10.45)"
elif [[ $ipcikti == '10.1.10.41' ]]; then 
echo -e "ED27(10.1.10.41)"
elif [[ $ipcikti == '10.1.10.42' ]]; then 
echo -e "ED28(10.1.10.42)\033[0m"
fi

ssh -T scc
last=$(ls -t1 /opt/eds/log/diag/trace/* | head -n 1)
last2=$(ls -t1 /opt/eds/log/diag/trace/* | head -n 2 | tail -n 1)
fsm=$(grep FSM:input /opt/eds/log/scs.log | tail -n 1 | awk -F= '{print $2}')
log=$(grep 'scs_fault_cause : state: ' /opt/eds/log/scs.log.1 /opt/eds/log/scs.log.0 /opt/eds/log/scs.log | tail -n 1 | awk '{print $11}')
state=$(grep 'SCS state change:' $last2 $last | awk -F: '{print $5, $6}' | awk -F'(' '{print $1}' | tail -n 1)
echo -e "\033[0;37mState=\033[0m\033[0;32m$state\033[0m"

if [[ $fsm == 'DiagMode(DesiredState' ]]; then
echo -e "\033[0;37mState2=\033[0m \033[0;33mDiagnostic\033[0m"
elif [[ $fsm == 'Dieback(DesiredState' ]]; then
echo -e "\033[0;37mState2=\033[0m \033[0;36mDieback\033[0m"
elif [[ $fsm == 'WaitForSystemReadinessCheckDone(DesiredState' ]]; then
echo -e "\033[0;37mState2=\033[0m \033[0;34mSystem Check\033[0m"
elif [[ $fsm == 'ColdStandby(DesiredState' ]]; then
echo -e "\033[0;37mState2=\033[0m \033[0;34mCold Standby\033[0m"
elif [[ $fsm == 'ScanUnblocked(DesiredState' ]]; then
echo -e "\033[0;37mState2=\033[0m \033[0;32mScan\033[0m"
elif [[ $fsm == 'ScanBlocked(DesiredState' ]]; then
echo -e "\033[0;37mState2=\033[0m \033[0;32mScan\033[0m"
fi

if [[ $log == '0' ]]; then
echo -e "\033[0;31mFault=\033[0m \033[0;37mNone\033[0m"
elif [[ $log == '1' ]]; then
echo -e "\033[0;31mFault=\033[0m \033[0;37mWaitingForDevices\033[0m"
elif [[ $log == '2' ]]; then
echo -e "\033[0;31mFault=\033[0m \033[0;37mDevicesUninitialized\033[0m"
elif [[ $log == '3' ]]; then
echo -e "\033[0;31mFault= KeyPowerOff\033[0m"
elif [[ $log == '4' ]]; then
echo -e "\033[0;31mFault= SDB2_Fault\033[0m"
elif [[ $log == '5' ]]; then
echo -e "\033[0;31mFault= BIT_Fault\033[0m"
elif [[ $log == '6' ]]; then
echo -e "\033[0;31mFault= DIAG_Fault\033[0m"
elif [[ $log == '7' ]]; then
echo -e "\033[0;31mFault= DIAG_POST_TIMEOUT\033[0m"
elif [[ $log == '8' ]]; then
echo -e "\033[0;31mFault= SRC_FAILED\033[0m"
elif [[ $log == '9' ]]; then
echo -e "\033[0;31mFault= ISHWFAULTCONDITION\033[0m"
elif [[ $log == '10' ]]; then
echo -e "\033[0;31mFault= UserRequested\033[0m"
elif [[ $log == '11' ]]; then
echo -e "\033[0;31mFault= SubSystemMissing\033[0m"
elif [[ $log == '12' ]]; then
echo -e "\033[0;31mFault= PASSTHROUGH\033[0m"
elif [[ $log == '13' ]]; then
echo -e "\033[0;31mFault= DCBOFFSET_FAILURE\033[0m"
elif [[ $log == '14' ]]; then
echo -e "\033[0;31mFault= DARKCAL_REQUESTED\033[0m"
elif [[ $log == '15' ]]; then
echo -e "\033[0;31mFault= ENCODERCNT_EXCEEDED\033[0m"
elif [[ $log == '16' ]]; then
echo -e "\033[0;31mFault= E-STOP\033[0m"
elif [[ $log == '17' ]]; then
echo -e "\033[0;31mFault= INTERLOCK\033[0m"
elif [[ $log == '18' ]]; then
echo -e "\033[0;31mFault= HVPS_RAMPUP\033[0m"
elif [[ $log == '19' ]]; then
echo -e "\033[0;31mFault= Standby\033[0m"
elif [[ $log == '20' ]]; then
echo -e "\033[0;31mFault= Reboot\033[0m"
elif [[ $log == '21' ]]; then
echo -e "\033[0;31mFault= WatchDog\033[0m"
elif [[ $log == '22' ]]; then
echo -e "\033[0;31mFault= SYSTIC_FAULT\033[0m"
elif [[ $log == '23' ]]; then
echo -e "\033[0;31mFault= ENCODER_FAULT\033[0m"
elif [[ $log == '24' ]]; then
echo -e "\033[0;31mFault= LIGHT_CURTAIN_FAULT\033[0m"
elif [[ $log == '25' ]]; then
echo -e "\033[0;31mFault= GALIL_FAULT\033[0m"
elif [[ $log == '26' ]]; then
echo -e "\033[0;31mFault= Acuvim_Fault\033[0m"
elif [[ $log == '27' ]]; then
echo -e "\033[0;31mFault= Yaskawa_Fault\033[0m"
elif [[ $log == '28' ]]; then
echo -e "\033[0;31mFault= MFORCE_Fault\033[0m"
elif [[ $log == '29' ]]; then
echo -e "\033[0;31mFault= MFORCE_Fault\033[0m"
elif [[ $log == '30' ]]; then
echo -e "\033[0;31mFault= HVPS_Fault\033[0m"
elif [[ $log == '31' ]]; then
echo -e "\033[0;31mFault= DCB_Fault\033[0m"
elif [[ $log == '32' ]]; then
echo -e "\033[0;31mFault= System_Verify_Fault\033[0m"
elif [[ $log == '33' ]]; then
echo -e "\033[0;31mFault= BMS_Entrance_Bag_Jam\033[0m"
elif [[ $log == '34' ]]; then
echo -e "\033[0;31mFault= BMS_BHS_FAULT\033[0m"
elif [[ $log == '35' ]]; then
echo -e "\033[0;31mFault= SYSTIC_TIMEOUT\033[0m"
elif [[ $log == '36' ]]; then
echo -e "\033[0;31mFault= SDB2_TIMEOUT\033[0m"
elif [[ $log == '37' ]]; then
echo -e "\033[0;31mFault= DCB_TIMEOUT\033[0m"
elif [[ $log == '38' ]]; then
echo -e "\033[0;31mFault= DPP_RTR_DOWN\033[0m"
elif [[ $log == '39' ]]; then
echo -e "\033[0;31mFault= BMS_RTR_DOWN\033[0m"
elif [[ $log == '40' ]]; then
echo -e "\033[0;31mFault= IAC_RTR_DOWN\033[0m"
elif [[ $log == '41' ]]; then
echo -e "\033[0;31mFault= DPP_OPSTATE_FAULT\033[0m"
elif [[ $log == '42' ]]; then
echo -e "\033[0;31mFault= IAC_OPSTATE_FAULT\033[0m"
elif [[ $log == '43' ]]; then
echo -e "\033[0;31mFault= INIT_TIMEOUT_FAULT\033[0m"
elif [[ $log == '44' ]]; then
echo -e "\033[0;31mFault= SEASONING_FAILED\033[0m"
elif [[ $log == '45' ]]; then
echo -e "\033[0;31mFault= Transients_Failed\033[0m"
elif [[ $log == '46' ]]; then
echo -e "\033[0;31mFault= Array_Test_Failed\033[0m"
elif [[ $log == '47' ]]; then
echo -e "\033[0;31mFault= BMS_SUBSYS_MISSING\033[0m"
elif [[ $log == '48' ]]; then
echo -e "\033[0;31mFault= IAC_SUBSYS_MISSING\033[0m"
elif [[ $log == '49' ]]; then
echo -e "\033[0;31mFault= DPP_SUBSYS_MISSING\033[0m"
elif [[ $log == '50' ]]; then
echo -e "\033[0;31mFault= DIAGS_SUBSYS_MISSING\033[0m"
elif [[ $log == '51' ]]; then
echo -e "\033[0;31mFault= PLC_Connection_Loss\033[0m"
elif [[ $log == '52' ]]; then
echo -e "\033[0;31mFault= DPP_HIGH_WATERMARK\033[0m"
elif [[ $log == '54' ]]; then
echo -e "\033[0;31mFault= CHILLER_FAULT\033[0m"

fi

code
done
