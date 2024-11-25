# Download and install drivers
sh -c 'wget linux.brostrend.com/install -O /tmp/install && sh /tmp/install'

# Turn off power save mode to prevent connection instability
sudo sed 's/^\(wifi.powersave = \).*/wifi.powersave = 2/' -i /etc/NetworkManager/conf.d/default-wifi-powersave-on.conf

# Help with predictable interface names, such as eth0,wlan0 vs wlxa1b2c3d4e5f6 style
sudo -i
mkdir -p /etc/default/grub.d
echo 'GRUB_CMDLINE_LINUX_DEFAULT="splash quiet net.ifnames=0"' >/etc/default/grub.d/ifnames.cfg
update-grub
reboot