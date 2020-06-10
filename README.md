# Code Ready Containers on Fedora 32
The following are my notes related to using CRC on Fedora 32. I am running this on an Intel NUC.

## Considerations for Fedora 32
The following actions are performed with SUDO or root.
Make sure libvirtd is installed and running.

```
# dnf install @virtualization
# systemctl start libvirtd
# systemctl enable livirtd
```

If you want to access the web console from another PC. You should consider using  Squid proxy.

```
# dnf install squid -y
# vim /etc/squid/squid.conf
```
Add the following lines as per below and make sure you modify the IP range to match your setup:
```
#
# INSERT YOUR OWN RULE(S) HERE TO ALLOW ACCESS FROM YOUR CLIENTS
#
acl internal src 192.168.1.0/24 #Allow internal IPs to access 
http_access allow internal
```

Other tools I find useful when working with Fedora are:
- VSCode (for remote editing)
- VIM (for editing from the shell)
- Cockpit, has a nice web interface.

## Download and run Code Ready Containers
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
All of the above functions can be done with your standard login. There is no need for any sudo or root login actions.

You may want to consider adding more memory if you want to run services like Prometheus. I am currently using 16GB for the VM. Could always do with more than that. I did the following to give my VM 16GM RAM:
```
$ crc config set memory 16384
```

# Working with the CRC cluster
Once you have confirmed you can access with the login details provided after start, you may want to enable a few more features. Please ensure you have at least 12GB RAM on the VM.

Check which services are not yet active:
```
$ oc get clusterversion version -ojsonpath='{range .spec.overrides[*]}{.name}{"\n"}{end}' | nl -v 0
```
This list will appear something like this:
```
     0	cluster-monitoring-operator
     1	machine-config-operator
     2	etcd-quorum-guard
     3	machine-api-operator
     4	cluster-autoscaler-operator
     5	insights-operator
     6	prometheus-k8s
     7	cloud-credential-operator
     8	csi-snapshot-controller-operator
     9	cluster-storage-operator
    10	kube-storage-version-migrator-operator
```
Take note of the number and to enable the service you want use the following using the following command:
```
oc patch clusterversion/version --type='json' -p '[{"op":"remove", "path":"/spec/overrides/<replace this with a number from the list above>"}]'
```
For example to enable "6	prometheus-k8s" add the number "6". Note that the list of items always changes based on which services are active or not.
```
oc patch clusterversion/version --type='json' -p '[{"op":"remove", "path":"/spec/overrides/6"}]'
```