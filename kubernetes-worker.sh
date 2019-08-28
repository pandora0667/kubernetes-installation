#/bin/sh

echo "Hello Seongwon Kubernetes worker installation shell script. for ubuntu 18.04 LTS Version\n" 
echo "Kubernets master will be installed in 5 seconds. Press Ctrl + C to cancel.\n"
sleep 5 

echo "installation update and Dependency Package\n" 
sudo cp /etc/apt/sources.list /etc/apt/sources.list.old && sudo sed -i 's/archive.ubuntu.com/ftp.daumkakao.com/g' /etc/apt/sources.list
sudo dkkg-reconfigure tzdata
sudo apt apt update && sudo apt upgrade -y 
sudo apt remove docker docker-engine docker.io containerd runc -y 
sudo apt install git nmap htop glances wget curl apt-transport-https ca-certificates gnupg-agent software-properties-common -y 

echo "docker installation\n" 

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt update
sudo apt-get install docker-ce docker-ce-cli containerd.io -y 
sudo docker --version 
sudo systemctl start docker
sudo systemctl enable docker

echo "docker installation complete\n" 
ehco "Kubernetes installation start\n" 

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
sudo swapoff -a
sudo kubeadm version

echo "Please complete the installation by entering the kubernets join command. Thank you.\n"