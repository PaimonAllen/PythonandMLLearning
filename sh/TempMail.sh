#!/bin/bash
#风扇调为95%，主频-200，显存频率+1600，设定温度75°发送警告邮件并自动重启

DISPLAY=:0 nvidia-settings -a '[gpu:0]/GPUFanControlState=1' -a '[fan:0]/GPUTargetFanSpeed=95' #风扇调为95%
DISPLAY=:0 nvidia-settings -a '[gpu:0]/GPUFanControlState=1' -a '[fan:1]/GPUTargetFanSpeed=95' #风扇调为95%
DISPLAY=:0 nvidia-settings -a "GPUPowerMizerMode=1" #1为最大性能模式
DISPLAY=:0 nvidia-settings -a "[gpu:0]/GPUGraphicsClockOffset[4]=-200" #RTX系列需要用4
DISPLAY=:0 nvidia-settings -a "[gpu:0]/GPUMemoryTransferRateOffset[4]=1600" #RTX系列需要用4
echo $Temp
while [ true ]; do #监控循环
Time=$(date "+%Y-%m-%d %H:%M:%S") #获取当前时间
Temp=$(nvidia-smi | grep C | sed -n '4p' | awk '{print $3}' | tr -d "C\n") #获取显卡温度
#使用sed抓取第二行，-n '2p'代表第二行，-n '1,3p'代表第一到三行，以回车换行符区分。
#使用awk抓取第四列，$4代表第四列，以空格区分。
#最后使用tr去除字符串最后的C和\n
echo "温度正常，温度：$Temp，时间：$Time" >> /home/tzr/Documents/MonitorSh/TempMail.log #输出日志文件
if [ $Temp -lt 50 ] #如果低于50度
then
echo "低温，温度：$Temp，时间：$Time" >> /home/tzr/Documents/MonitorSh/TempMail.log #输出日志文件
DISPLAY=:0 nvidia-settings -a '[gpu:0]/GPUFanControlState=1' -a '[fan:0]/GPUTargetFanSpeed=40' #风扇调为40%
DISPLAY=:0 nvidia-settings -a '[gpu:0]/GPUFanControlState=1' -a '[fan:1]/GPUTargetFanSpeed=40' #风扇调为40%
fi
if [ $Temp -gt 55 ] #如果高于55度
then
echo "温度上升，温度：$Temp，时间：$Time" >> /home/tzr/Documents/MonitorSh/TempMail.log #输出日志文件
DISPLAY=:0 nvidia-settings -a '[gpu:0]/GPUFanControlState=1' -a '[fan:0]/GPUTargetFanSpeed=95' #风扇调为95%
DISPLAY=:0 nvidia-settings -a '[gpu:0]/GPUFanControlState=1' -a '[fan:1]/GPUTargetFanSpeed=95' #风扇调为95%
fi
if [ $Temp -gt 75 ] #如果高于75度
then
echo "高温警告，温度：$Temp，时间：$Time" >> /home/tzr/Documents/MonitorSh/TempMail.log #输出日志文件
echo "高温警告，温度：$Temp，时间：$Time,且已重启" | mail -s "系统警告" 849597043@qq.com #发送警告邮件
#echo "This is the message body" | mail -s "subject" user@qq.com -aFrom:sender@qq.com 
echo '********'|sudo -S reboot #重启
fi
sleep 60 #监控间隔60秒
done