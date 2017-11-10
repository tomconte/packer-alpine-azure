apk update && apk upgrade

# Pre-reqs for WALinuxAgent
apk add openssl
apk add python py-setuptools

# Install WALinuxAgent
wget https://github.com/Azure/WALinuxAgent/archive/v2.2.19.tar.gz && \
tar xvzf v2.2.19.tar.gz && \
cd WALinuxAgent-2.2.19 && \
python setup.py install && \
cd .. && \
rm -rf WALinuxAgent-2.2.19 v2.2.19.tar.gz

# Update boot params
sed -i 's/^default_kernel_opts="[^"]*/\0 console=ttyS0 earlyprintk=ttyS0 rootdelay=300/' /etc/update-extlinux.conf
update-extlinux

# sshd configuration
sed -i 's/^#ClientAliveInterval 0/ClientAliveInterval 180/' /etc/ssh/sshd_config
