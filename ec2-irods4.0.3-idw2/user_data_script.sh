#!/bin/bash
sudo apt-get -y install git
cd /opt
sudo git clone https://github.com/irods/contrib
mv /opt/contrib/ec2-irods4.0.3-idw2 /opt/irods-aws
cd /opt/irods-aws

# For 4.1.3
./deploy.sh 4.1.3 4.1.3 4.1.3 1.5
sudo shred -u /etc/ssh/*_key /etc/ssh/*_key.pub
sudo shred -u /home/ubuntu/.ssh/authorized_keys
sudo shred -u /home/ubuntu/.*history
sudo shred -u /var/log/lastlog
sudo shred -u /var/log/wtmp
sudo touch /var/log/lastlog
sudo touch /var/log/wtmp
history -c

