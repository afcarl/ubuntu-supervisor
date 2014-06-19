RUN mkdir -p -m0700 /var/run/sshd && cat <<EOF > /etc/supervisor/conf.d/sshd.conf 
[program:sshd]
directory=/
command=/usr/sbin/sshd -D
user=root
autostart=false
autorestart=true
stdout_logfile=/var/log/supervisor/%(program_name)s.log
stderr_logfile=/var/log/supervisor/%(program_name)s_error.log
EOF

RUN cat <<EOF > /etc/supervisor/conf.d/cron.conf
[program:cron]
priority=20
directory=/tmp
command=/usr/sbin/cron -f
user=root
autostart=true
autorestart=true
stdout_logfile=/var/log/supervisor/%(program_name)s.log
stderr_logfile=/var/log/supervisor/%(program_name)s.log
EOF

RUN cat <<EOF > /etc/logrotate.d/supervisord
/var/log/supervisor/*.log {
    weekly
    missingok
    rotate 52
    compress
    delaycompress
    notifempty
    copytruncate
}
EOF
