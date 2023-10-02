```yaml
---

############################################################################
# Ansible playbook to install and configure MongoDB on Ubuntu 20.04.       #
# To execute issue the `ansible-playbook main.yml --tags mongodb` command. #
############################################################################

# Defining target section.
- name: Apply Ansible role
  hosts: localhost
  become: true
  gather_facts: true

# Defining roles section.
  roles:
    - name: mongodb
      tags: ['mongodb']

# Uncomment to enable a task.
#  tasks:
#    - name: Include additional tasks
#      include_role:
#        name: nginx
#        tasks_from: install.yml
...
