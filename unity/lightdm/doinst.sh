if getent group lightdm >/dev/null; then
  if [ "x$(id -g lightdm 2>/dev/null)" != "x620" ]; then
    userdel lightdm &>/dev/null || :
    groupdel lightdm &>/dev/null || :
    groupadd -g 620 lightdm
  fi
fi

if ! getent passwd lightdm >/dev/null; then
  if [ "x$(id -u lightdm 2>/dev/null)" != "x620" ]; then
    userdel lightdm &>/dev/null || :
    useradd -u 620 -c "Light Display Manager" -g lightdm -d /var/lib/lightdm -s /sbin/nologin lightdm
  fi
fi

chown -R lightdm:lightdm /var/lib/lightdm
chmod -R 0750 /var/lib/lightdm

if ! getent group lightdm >/dev/null; then
  groupadd -g 620 lightdm
fi

if ! getent passwd lightdm >/dev/null; then
  useradd -u 620 -c "Light Display Manager" -g lightdm -d /var/lib/lightdm -s /sbin/nologin lightdm
fi

if ! getent group nopasswdlogin >/dev/null; then
  groupadd --system nopasswdlogin
fi

if [ ! -d /var/lib/lightdm ]; then
  mkdir -p /var/lib/lightdm
fi

chown -R lightdm:lightdm /var/lib/lightdm
chmod -R 0750 /var/lib/lightdm

systemd-tmpfiles --create /usr/lib/tmpfiles.d/lightdm.conf
