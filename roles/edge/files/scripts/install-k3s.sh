curl -sfL https://get.k3s.io | sh -

mkdir ~/.kube
sudo KUBECONFIG=~/.kube/config:/etc/rancher/k3s/k3s.yaml kubectl config view --flatten > ~/.kube/merged
mv ~/.kube/merged ~/.kube/config
chmod  0600 ~/.kube/config
export KUBECONFIG=~/.kube/config

#switch to k3s context
kubectl config use-context default
sudo chmod 644 /etc/rancher/k3s/k3s.yaml

echo "KUBECONFIG=~/.kube/config" >> ~/.bashrc
source ~/.bashrc