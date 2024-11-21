# Increase the user watch/instance limits for AIO
echo fs.inotify.max_user_instances=8192 | sudo tee -a /etc/sysctl.conf
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf

# For better performance, increase the file descriptor limit
echo fs.file-max = 100000 | sudo tee -a /etc/sysctl.conf

sudo sysctl -p