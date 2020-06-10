# Code Ready Containers
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