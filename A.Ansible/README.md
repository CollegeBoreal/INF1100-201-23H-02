# Ansible

```
ansible --version
```
> Return
```
ansible 2.9.21
  config file = /etc/ansible/ansible.cfg
  configured module search path = ['/home/300098957/.ansible/plugins/modules', '/usr/share/ansible/plugins/modules']
  ansible python module location = /usr/lib/python3.9/site-packages/ansible
  executable location = /usr/bin/ansible
  python version = 3.9.9 (main, Dec 28 2021, 11:05:23) [GCC 11.2.0]
```

```
cat /etc/ansible/hosts
```
<pre>
betelgeuse.orion.gasy.africa
saiph.orion.gasy.africa
bellatrix.orion.gasy.africa
rigel.orion.gasy.africa
</pre>

```
ansible all -m ping -u ubuntu
```
<pre>
betelgeuse.orion.gasy.africa | UNREACHABLE! => {
    "changed": false,
    "msg": "Failed to connect to the host via ssh: mux_client_request_session: read from master failed: Connection reset by peer\r\nFailed to connect to new control master",
    "unreachable": true
}
saiph.orion.gasy.africa | UNREACHABLE! => {
    "changed": false,
    "msg": "Failed to connect to the host via ssh: mux_client_request_session: read from master failed: Connection reset by peer\r\nFailed to connect to new control master",
    "unreachable": true
}
bellatrix.orion.gasy.africa | UNREACHABLE! => {
    "changed": false,
    "msg": "Failed to connect to the host via ssh: mux_client_request_session: read from master failed: Connection reset by peer\r\nFailed to connect to new control master",
    "unreachable": true
}
rigel.orion.gasy.africa | UNREACHABLE! => {
    "changed": false,
    "msg": "Failed to connect to the host via ssh: mux_client_request_session: read from master failed: Connection reset by peer\r\nFailed to connect to new control master",
    "unreachable": true
}
</pre>

```
ansible all -m ping -u ubuntu
```
<pre>
betelgeuse.orion.gasy.africa | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
saiph.orion.gasy.africa | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
rigel.orion.gasy.africa | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
bellatrix.orion.gasy.africa | SUCCESS => {
    "ansible_facts": {
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false,
    "ping": "pong"
}
</pre>


# References

- [ ] [Writing Ansible Playbooks for New Terraform Servers](https://www.splunk.com/en_us/blog/devops/writing-ansible-playbooks-for-new-terraform-servers.html)
