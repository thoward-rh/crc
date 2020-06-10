# Code Ready Containers on Fedora 32
The following are my notes related to using CRC on Fedora 32. I am running this on an Intel NUC.

## Considerations for Fedora 32
The following actions are performed with SUDO or root.
* Make sure libvirtd is installed and running.

```
# dnf install @virtualization
# systemctl start libvirtd
# systemctl enable livirtd
```

* If you want to access the web console from another PC. You should consider using  Squid proxy.

```
# dnf install squid -y
# vim /etc/squid/squid.conf
```
and add the following lines as per below and make sure you modify the IP range to match your setup:
```
#
# INSERT YOUR OWN RULE(S) HERE TO ALLOW ACCESS FROM YOUR CLIENTS
#
acl internal src 192.168.1.0/24 #Allow internal IPs to access 
http_access allow internal
```

* Other tools I find useful when working with Fedora are:
- VSCode (for remote editing)
- VIM (for editing from the shell)
- Cockpit, has a nice web interface.

## Download Code Ready Containers
The link for download:
<https://developers.redhat.com/products/codeready-containers/overview>

You may need to sign up for a Red Hat account. This is free and easy.

Download link should work for latest version:
```
$ wget https://mirror.openshift.com/pub/openshift-v4/clients/crc/latest/crc-linux-amd64.tarxz
```
Extract the files
```
$ tar -xvf crc-linux-amd64.tarxz
```
You can either run the binary from there or can move into PATH.
```
$ crc setup
```
Then when configured
```
$ crc start
```
You may want to consider adding more memory if you want to run services like Prometheus. I am currently using 16GB for the VM. Could always do with more than that.
