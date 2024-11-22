# Edge Ansible

This repository serves as a test bed for Ansible playbooks to deploy edge setup for Azure Arc and Azure IoT Operations. It is meant as a living proof of concept, and is not considered production ready. 

> NOTE: This repository is built for, and expected to be used with Ansible Pull, and not traditional Ansible!

Use the contents at your own risk!

# Contents
- `group_vars` - This directory contains an all.yml file which contains shared variables that can be used by every device and script.
- `host_vars` - This directory can contain host specific variables available only to certain hosts.
- `playbooks` - This directory contains all playbooks.
- `roles` - This directory contains subdirectories for each `role` type as specified in the sections of the `hosts` file. 
   - `base` - This directory contains files, scripts, variables, and tasks for use by all hosts, regardless of role.
   - `edge` - This directory contains files, scripts, variables, and tasks for use by any host speicified in the `edge` section of the `hosts` file.
- `ansible.cfg` - The primary Ansible configuration file.
- `hosts` - A listing of hosts for which this Ansible repository refers to.
- `local.yml` - The primary playbook that all other playbooks, tasks, and scripts begin executing from.
- `README.md` - This file.

# How it works

## Hosts
The `hosts` file is an `ini` file that contains grouping of hosts for which this Ansible repository refers to. A remote device can exist in multiple groups or just one group. This name must match the calling device's `hostname` which can be overridden in the calling device's own Ansible configuration.  

As it exists today in this sample, there is only one group: `edge`.

## Ansible Configuration
The `ansible.cfg` file contains the configuration sections which specify how Ansible should execute. These configurations include, but are not limited to:
- `inventory`: The name of the `hosts` file which contains the [hosts](#hosts)
- `log_path`: The location of the Ansible log file on the calling device.

## Starting Playbook
The `local.yml` file is the initial playbook that helps define which other playbooks and tasks should execute for which devices.

> NOTE: The `become: true` is a setting to instruct Ansible to execute these tasks as the configured Ansible user (not the calling one), which is by default `root` - which is necessary for any `sudo` calls in scripts for example.

### Pre-Tasks
The first section instructs all `hosts` to execute all of the `pre_tasks` listed, before continuing on to `role` execution.
```yml
# tasks to complete before running roles
- hosts: all
  become: true
  tags: always
  pre_tasks:
    - name: Sample pre-role task
      debug:
        msg: Pre role task executed
```

### Roles
The `roles` section with `hosts: all` is told to execute all `tasks` inside the `roles/base` directory which by default looks for the `main.yml` task/playbook. The same for the `hosts: edge` section, which instructs only hosts listed inside the `edge` configuration section of the `hosts` file to execute all `tasks` inside the `roles/edge` directory. 
```yml
# run roles
- hosts: all
  become: true
  roles:
    - base

- hosts: edge
  become: true
  roles:
    - edge
```

### Closing Tasks
The final section is used to perform cleanup and reporting tasks once all other tasks are complete. 
```yml
# end of run cleanup and reporting
- hosts: all
  become: true
  tasks:
    - name: Run test Playbook
      include_tasks: playbooks/test.yml
      tags: always
```