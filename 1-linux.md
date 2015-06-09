# Engineering Baseline 1
## Basic Linux and Shell

###Getting Around the Filesystem
1. cd /usr/local vs cd local
2. cd ~; pwd
3. cd ...; pwd

###Everything is a File
1. /proc, /dev/random/
2. sockets, pipes
3. .

    ```
    λ ~ cat /usr/local/var/postgres/postmaster.pid
    4772
    /usr/local/var/postgres
    1433275423
    5432
    /tmp
    localhost
      5432001   2359296
    ```
    
###Path and the Environment
1. .

    ```
    λ ~ printenv | grep EDITOR
    EDITOR=vim
    ```
2. echo $PATH
3. .

    ```
    λ ~ which ruby
    /usr/bin/ruby
    ```

###Transfering Files Between Boxes
```
λ ~ vim aschwartz.txt
λ ~ scp aschwartz.txt root@austinschwartz.com:/
root@austinschwartz.com's password:
aschwartz.txt                    100%   20     0.0KB/s   00:00
λ ~ rm aschwartz.txt
λ ~ scp root@austinschwartz.com:/aschwartz.txt .
root@austinschwartz.com's password:
aschwartz.txt                    100%   20     0.0KB/s   00:00
λ ~ ls | grep aschwartz.txt
aschwartz.txt
```

###Git. Just Git.
I'm familiar enough with git that I'm not doing this.

###Managing File Permissions
1. -rw- r-- r--
2. sudo chown root newfile; sudo chgrp root newfile
3. sudo chmod 555 newfile
4. chmod g-w newfile

###Why You Shouldn't Use Sudo
1. sudo ls
2. sudo rm -rf /

###Monitoring System Resources
1. .

    ```
    λ / df -h | head -n 2 | tail -n 1 | cut -c 59-68
    216Gi
    ```
2. cd ~; du
3. top -o MEM
4. top -o cpu

###What's a Port and How to Find It
1. lsof -i -n -P | grep TCP
2. netstat -l
3. ssh: 22, scp: 22, http: 80, https: 443, postgres 5432

###Finding, pausing, and killing processes
1. ok
2. ruby -e 'sleep 1 while true' &
3. fg, bg & ctrl z
4. pgrep ruby
5. pgrep ruby | kill

###Starting and Stopping Services
1. sudo /etc/init.d/ssh restart
2. sudo /etc/init.d/nginx reload

###Monitoring Production Hardware
1. cpu, memory, bandwidth usage/network traffic
2. You could use a cloud provider with flexible resource caps where if your application did spike in resources momentarily, it would be fine, as the provider could offset the increased resource usage if its temporary.

###Why We Use Web Proxies
1. [USER] -> get www.cats.com -> dns resolve -> 
  load balancer proxy 10.0.1.1 -> web node proxies -> web servers (10.0.1.2-10.0.1.4)
    *. I'm not sure why it wasn't mentioned what happens if your load balancer goes down, so in my diagram, there should be a second or third load balancer just as backups, each monitoring the others. If load balancer n goes down, switch to n+1.
2. To increase speed and reliability

###Managing Server Time
1. ntpdate time.nist.gov

###Firewalls, iptables, and nmap
1. sudo: /etc/init.d/iptables: command not found
2. Because there are so many ports but very few need to be open with applications running on them

Nmap exercise: 22, 80, 9929, 31337
