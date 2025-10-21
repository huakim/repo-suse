FROM opensuse/tumbleweed

ENV PKG="zypper --gpg-auto-import-keys --non-interactive in --no-recommends"
ENV UPD="zypper --gpg-auto-import-keys ref"
ENV ADR="zypper --gpg-auto-import-keys addrepo -k"

RUN $UPD

RUN $PKG rsyslog sed

RUN sed -i 's/^\($ModLoad imklog\)/#\1/' /etc/rsyslog.conf

RUN $PKG systemd cron sudo iproute2
RUN $PKG coreutils perl python3 systemd-container mtools bash zypper sed squashfs xorriso
RUN $PKG grub2-common grub2 grub2-i386-efi grub2-i386-pc

RUN cat << 'EOF' > /etc/systemd/system/makeiso.target
[Unit]
Description=MakeISO Target (after multi-user.target)
Requires=multi-user.target
After=multi-user.target

[Install]
WantedBy=multi-user.target
EOF

ENV ENVIRONMENT=''

RUN mkdir /extra

RUN cat << 'EOF' > /etc/systemd/system/makeiso.service 
[Unit]
Description=MakeISO Service
After=makeiso.target
After=multi-user.target dbus.service

[Service]
ExecStart=/usr/bin/bash -c 'source /extra/makeiso.environment'
StandardOutput=tty
StandardError=tty
TTYPath=/dev/console
TTYReset=no
TTYVTDisallocate=no
Restart=no
Type=simple

[Install]
WantedBy=makeiso.target
EOF

#RUN sed -i 's/^\($ModLoad imklog\)/#\1/' /etc/rsyslog.conf
RUN rm -f /lib/systemd/system/systemd*udev* 

RUN systemctl disable low-memory-monitor
RUN systemctl disable upower
RUN systemctl mask getty.target
RUN systemctl enable makeiso.target
RUN systemctl enable makeiso

STOPSIGNAL SIGRTMIN+3

CMD ["bash", "-c", "echo 'set -e' ';' pushd /extra/repo/pacman ';' ./aptat.sh ';' popd ';' $ENVIRONMENT ';' cd /extra/repo ';' ./makeiso.sh '${VARIANT:-gnome}' > /extra/makeiso.environment ; exec /sbin/init"]
