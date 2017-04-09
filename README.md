* Replace IP addresses in roster file.
* Replace master IP address in pillar/mesos.sls.

Instances on Ubuntu 14.04:

```
sudo salt-ssh --priv ~/.ssh/id_rsa '*' state.apply                           
```
