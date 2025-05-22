# kubectl install
https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
Install using native package management 
# This overwrites any existing configuration in /etc/yum.repos.d/kubernetes.repo
cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://pkgs.k8s.io/core:/stable:/v1.33/rpm/
enabled=1
gpgcheck=1
gpgkey=https://pkgs.k8s.io/core:/stable:/v1.33/rpm/repodata/repomd.xml.key
EOF


sudo yum install -y kubectl


get cluster inform from your workstation
https://learn.microsoft.com/en-us/cli/azure/aks?view=azure-cli-latest#az-aks-get-credentials
az aks get-credentials --name MyManagedCluster --resource-group MyResourceGroup

