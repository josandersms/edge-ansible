mkdir /home/$ADMIN_USERNAME/.kube
sudo KUBECONFIG=/home/$ADMIN_USERNAME/.kube/config:/etc/rancher/k3s/k3s.yaml kubectl config view --flatten > /home/$ADMIN_USERNAME/.kube/merged
mv /home/$ADMIN_USERNAME/.kube/merged /home/$ADMIN_USERNAME/.kube/config
chmod 0600 /home/$ADMIN_USERNAME/.kube/config
chown -hR $ADMIN_USERNAME:$ADMIN_USERNAME /home/$ADMIN_USERNAME/.kube
export KUBECONFIG=/home/$ADMIN_USERNAME/.kube/config

#switch to k3s context
kubectl config use-context default
sudo chmod 644 /etc/rancher/k3s/k3s.yaml