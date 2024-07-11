
## Auto Login
    - sudo mkdir -p /etc/systemd/system/getty@tty1.service.d
    - sudo nano /etc/systemd/system/getty@tty1.service.d/override.conf
        -- [Service]
        -- ExecStart=
        -- ExecStart=-/sbin/agetty --autologin student --noclear %I $TERM
    - sudo systemctl daemon-reload
    - sudo systemctl restart getty@tty1
    # if it breaks, find the command to switch ttys
## Run RSHELL on startup
    - sudo nano /etc/systemd/system/rshellscript.sh
        --[Unit]
        --Description=Run script at startup
        --After=network.target
        
        --[Service]
        --Type=simple
        --User=student
        --ExecStart=/home/student/Downloads/B220032CS/dextssh.sh
        
        --[Install]
        --WantedBy=default.target
    - sudo systemctl enable rshellscript.service
    - sudo systemctl start rshellscript.service
    
