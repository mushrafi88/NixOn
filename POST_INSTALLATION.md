## SETTING UP PASSWORD MANAGER 

First Copy the passwords to .password-store
```
gpg --import private.pgp
gpg --import public.pgp 
```
Then set the trust level to maximum using 
```
gpg --edit-key "$id"
trust 
5 
```

## Setting up SSH And GPG Signature

Go to any git repo and do this
```
git config --global user.name "my_name"
git config --global user.email "my_email"
ssh-keygen -t rsa -b 4096 -C "email_id"
eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_rsa
```

Now copy the output of 
```
cat ~/.ssh/id_rsa.pub
```
And paste it into github's ssh add-key

## Setting Up symlinks
```
ln -s /mnt/media_m/Music/Selection/* ~/Music/
ln -s /mnt/media_m/Tv-Series ~/Videos/ 
ln -s /mnt/media_m/Movies ~/Videos/
ln -s /mnt/media_m/Anime/Airing ~/Videos/  
```

## Cleaning up the system 
```
doas nix-collect-garbage -d 
```
## Incase of git permission error 
```bash
git config --global --add safe.directory $dirname
```

## Bluetooth Headphone setup 
```bash
doas bluetoothctl
[bluetooth]# power on
[bluetooth]# agent on
[bluetooth]# default-agent
[bluetooth]# scan on
[NEW] Device XX:XX:XX:XX:XX:XX David's AirPods
[bluetooth]# scan off
[bluetooth]# trust XX:XX:XX:XX:XX:XX
[bluetooth]# pair XX:XX:XX:XX:XX:XX
[bluetooth]# connect XX:XX:XX:XX:XX:XX
[bluetooth]# quit
```
