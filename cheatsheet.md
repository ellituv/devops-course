Files & Directories

pwd
ls -l
ls -la
ls -ld /srv/project
cd ~
cat /etc/os-release
nano file.md
namei -l /srv/project/file
xdg-open .

Permissions

chmod 755 file
chmod +x script.sh
chmod +t /srv/project
chmod g+s /srv/project
chown user:group file
chown :dev file
cat /etc/passwd

Processes & Signals

ps aux
top
pstree -p
kill 812
kill -9 812
kill -HUP 812
kill -1 812
echo $?

systemd

systemctl status nginx
systemctl start nginx
systemctl stop nginx
systemctl restart nginx
systemctl reload nginx
systemctl enable nginx

journa lctl -u nginx
journalctl -u nginx -f
journalctl -u nginx -n 50

Redirection

command > file
command >> file
command 2> errors.txt
command > file 2>&1
command 2>/dev/null
command1 | command2
/path/backup.sh >> /var/log/backup.log 2>&1

Environment Variables

echo $PATH
printenv
export VAR=value
source script.sh
nano ~/.bashrc

Scripts

#!/bin/bash
chmod +x script.sh
./script.sh

Network

ss -tulpn
curl http://127.0.0.1:8080
dig google.com
nslookup google.com
ping google.com
nc -zv host 5432
psql -h host -U app -c "SELECT 1"

Disk

df -h
df -i
du -sh /var/log
sudo du -sh /var/* 2>/dev/null | sort -h
sudo lsof | grep deleted
sudo truncate -s 0 /var/log/app.log

Multipass

sudo snap install multipass
multipass version
multipass launch 24.04 --name lab
multipass shell lab
exit
multipass list
multipass info lab
multipass stop lab
multipass start lab
multipass snapshot lab --name clean-state
multipass list --snapshots
multipass restore lab.clean-state
multipass purge

SSH

ssh-keygen -t ed25519 -C "avrami1212@gmail.com"
cat ~/.ssh/id_ed25519.pub
ssh -T git@github.com
ssh ubuntu@10.124.81.209

Git

git config --global user.name "avremi"
git config --global user.email "avrami1212@gmail.com"
git clone git@github.com:ellituv/devops-course.git
git remote -v
git branch
git checkout -b feature/DEV-2
git status
git add cheatsheet.md
git commit -m "DEV-2: Add initial cheatsheet structure"
git push -u origin feature/DEV-2
git ls-files

Terminal Shortcuts

Ctrl+C
Ctrl+S
Ctrl+Q
