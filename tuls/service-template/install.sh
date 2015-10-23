#!/bin/bash
# Copyright (C) 2012-2014 Chincisan Octavian-Marius(mariuschincisan@gmail.com) - coinscode.com - N/A
#           FOR HOME USE ONLY. For corporate  please contact me
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

[[ -z $1 && -z $2 ]] && echo "pass process name <remove/install>" && exit 1

THIS_BINARY=$1
SERVICE_DAEMON=$1d

[[ ! -f ./${THIS_BINARY}.sysV ]] && echo "$THIS_BINARY.sysV missing from current folder" && exit 1


if [[ $2 == "--remove" ]];then
    sudo service ${SERVICE_DAEMON} stop
    sleep 5
    sudo update-rc.d -f ${SERVICE_DAEMON} remove
    exit
fi

if [[ -f ./${THIS_BINARY} ]];then
	sudo cp ./${THIS_BINARY} /usr/bin
	sudo chmod +x /usr/bin/${THIS_BINARY}
else
	echo "${THIS_BINARY} executable was not found in current folder!!!"
	exit
fi

[[ !-d /etc/$THIS_BINARY/  && $THIS_BINARY.config ]] && sudo mkdir /etc/$THIS_BINARY
sudo cp -f ./$THIS_BINARY.config /etc/$THIS_BINARY/

sudo cp ./${THIS_BINARY}.sysV /etc/init.d/${SERVICE_DAEMON}
sudo chmod +x /etc/init.d/${SERVICE_DAEMON}
sudo update-rc.d -f ${SERVICE_DAEMON} remove
sleep 1
sudo update-rc.d ${SERVICE_DAEMON} defaults
sleep 1
echo "Service ${SERVICE_DAEMON} installed. Starting ${SERVICE_DAEMON}"
sudo service ${SERVICE_DAEMON} start
echo "Checking service..."
sleep 5
check=$(ps ax | grep ${THIS_BINARY} | grep -v grep)
if [[ $check =~ "${THIS_BINARY}" ]];then
    echo "OK Service ${SERVICE_DAEMON} is running"
else
    echo "FAIL. Service ${SERVICE_DAEMON} did not start. Try to reboot!"
fi
echo "To uninstall the service run: ./install.sh --remove"


