#/bin/sh

echo "Hello Seongwon Kubernetes master installation shell script. for ubuntu 18.04 LTS Version" 
echo "Kubernets master will be installed in 5 seconds. Press Ctrl + C to cancel."
sleep 5 

echo "---------- installation update and package ----------" 

sudo dpkg-reconfigure tzdata
sudo cp /etc/apt/sources.list /etc/apt/sources.list.old && sudo sed -i 's/archive.ubuntu.com/ftp.daumkakao.com/g' /etc/apt/sources.list
sudo apt apt update
sudo apt upgrade -y 
sudo apt autoremove -y 

sudo apt remove docker docker-engine docker.io containerd runc -y 
sudo apt install git nmap htop glances wget curl apt-transport-https ca-certificates gnupg-agent software-properties-common -y 

echo "---------- docker installation ----------" 

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

echo "---------- docker installation complete. ----------" 

echo "---------- Kubernetes installation start. ----------" 

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
sudo swapoff -a
sudo apt install kubeadm -y
sudo kubeadm version
sudo kubeadm init --pod-network-cidr=172.168.10.0/24 > ~/join-command.txt 

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo "---------- kubernetes installation complete confirm to nodes ----------" 

sudo kubectl get nodes

echo "---------- Pod Network from Master node and verify pod namespaces. ----------" 

sudo kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
sudo  kubectl get no
sudo  kubectl get pods --all-namespaces

ehco 
echo "Congratulations, the kubernets master installation is complete. Please check the following command and run the kubernetes-slave.sh file." 
echo
sleep 2

cat ~/join-command.txt
