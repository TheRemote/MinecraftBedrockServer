trap control_c SIGINT
control_c() {
    exit
}
read -p 'Enter the server name to be configured, separated by a space: ' servernames
if [ -z "$servernames" ]; then
    exit 1
fi
username=$(whoami)
echo '#!/bin/bash' >stop_backup_and_restart.sh
for servername in $servernames; do
    read -p "Enter $servername execution command (LD_LIBRARY_PATH=. ./bedrock_server) " serverstartcommand
    if [ -z "$serverstartcommand" ]; then
        serverstartcommand='LD_LIBRARY_PATH=. ./bedrock_server'
    fi
    mkdir -p $servername
    mkdir -p /home/$username/$servername
    cp serverfiles/* $servername
    read -p "Enter the webhook URL of the discord you want to output the status of $servername: " webhookurl
    echo WEBHOOK_URL=$webhookurl >$servername/.env
    sed -i "s/username/$username/g" $servername/ExecStart.sh
    sed -i "s/username/$username/g" $servername/stop_and_backup_for_restart.sh
    sed -i "s/servername/$servername/g" $servername/ExecStart.sh
    sed -i "s/servername/$servername/g" $servername/ExecStop.sh
    sed -i "s/servername/$servername/g" $servername/stop_and_backup_for_restart.sh
    sed -i "s#serverstartcommand#$serverstartcommand#g" $servername/ExecStart.sh
    mv $servername/* /home/$username/$servername
    rmdir $servername
    cp exampleserver.service $servername.service
    sed -i "s/username/$username/g" $servername.service
    sed -i "s/exampleserver/$servername/g" $servername.service
    chmod 644 $servername.service
    echo "Install $servername.service into /etc/systemd/system/"
    sudo mv $servername.service /etc/systemd/system/
    echo 'Reload systemd manager configuration'
    sudo systemctl daemon-reload
    read -p "Do you want to enable automatic startup of the $servername? [Y/n] " yn
    case "$yn" in
    [yY]*)
        echo "Enable $servername.service"
        sudo systemctl enable $servername.service
        ;;
    *)
        echo "Disable $servername.service"
        sudo systemctl disable $servername.service
        ;;
    esac
    echo "/home/$username/$servername/stop_and_backup_for_restart.sh" >>stop_backup_and_restart.sh
    echo "systemctl restart $servername" >>stop_backup_and_restart.sh
    echo
done
read -p "Do you want to stop, back up, and reboot at 5am? [Y/n] " yn
case "$yn" in
[yY]*)
    echo 'Export the root crontab'
    sudo crontab -l >crontab.tmp
    if ! grep -q "0 5 \* \* \* /home/$username/.MinecraftBedrockServer/stop_backup_and_restart.sh" crontab.tmp; then
        echo "0 5 * * * /home/$username/.MinecraftBedrockServer/stop_backup_and_restart.sh" >>crontab.tmp
        echo "Add this to the root crontab"
        sudo crontab -u root crontab.tmp
    fi
    rm crontab.tmp
    ;;
esac
chmod 755 stop_backup_and_restart.sh
mkdir -p /home/$username/.MinecraftBedrockServer
mv stop_backup_and_restart.sh /home/$username/.MinecraftBedrockServer
echo 'Completed setup'
