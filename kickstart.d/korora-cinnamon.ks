%include fedora-live-cinnamon.ks
%include korora-base.ks

#repo --name="Cinnamon" --baseurl=http://repos.fedorapeople.org/repos/leigh123linux/Cinnamon/fedora-%%KP_VERSION%%/%%KP_BASEARCH%%/ --cost=1000

#
# PACKAGES
#

%packages

-adwaita-nemo
-alacarte
-control-center
-deja-dup
-evolution*
-gnome-mplayer
-gnome-mplayer-nautilus
-im-chooser
-mencoder
-mplayer
-smartmontools
-totem*
-transmission-gtk
NetworkManager-adsl
NetworkManager-bluetooth
NetworkManager-iodine
NetworkManager-l2tp
NetworkManager-openconnect
NetworkManager-openswan
NetworkManager-openvpn
NetworkManager-pptp
NetworkManager-ssh
NetworkManager-vpnc
NetworkManager-wifi
NetworkManager-wwan
PackageKit-browser-plugin
PackageKit-gtk3-module
argyllcms
blueman
brasero
brltty
darktable
dconf-editor
deluge
ekiga
empathy
evince
fbreader-gtk
ffmpeg
font-manager
gconf-editor
gloobus-preview
gnome-disk-utility
gnome-packagekit
gnote
gpgme
gtk-murrine-engine
gtk-recordmydesktop
gtk-unico-engine
gvfs-*
gwibber
hardlink
iok
korora-backgrounds-gnome
korora-settings-gnome
libmatroska
libmpg123
libproxy-networkmanager
libsane-hpaio
liferea
lirc
lirc-remotes
mtools
ncftp
nemo
nemo-extensions
nemo-fileroller
network-manager-applet
openshot
pcsc-lite
pcsc-lite-ccid
pharlap
pulseaudio-module-bluetooth
rhythmbox
shotwell
simple-scan
sound-juicer
soundconverter
strongswan
system-config-printer
thunderbird
transcode
webkitgtk4
wget
x264
xfsprogs
xvidcore

%end

%post

echo -e "\n*****\nPOST SECTION\n*****\n"

cat > /etc/lightdm/lightdm-gtk-greeter.conf << EOF
#
# background = Background file to use, either an image path or a color (e.g. #772953)
# theme-name = GTK+ theme to use
# icon-theme-name = Icon theme to use
# font-name = Font to use
# xft-antialias = Whether to antialias Xft fonts (true or false)
# xft-dpi = Resolution for Xft in dots per inch (e.g. 96)
# xft-hintstyle = What degree of hinting to use (none, slight, medium, or hintfull)
# xft-rgba = Type of subpixel antialiasing (none, rgb, bgr, vrgb or vbgr)
# show-indicators = semi-colon ";" separated list of allowed indicator modules. Built-in indicators include "~a11y", "~language", "~session", "~power". Unity indicators can be represented by short name (e.g. "sound", "power"), service file name, or absolute path
# show-clock (true or false)
# clock-format = strftime-format string, e.g. %H:%M
# keyboard = command to launch on-screen keyboard
# position = main window position: x y
# default-user-image = Image used as default user icon, path or #icon-name
# screensaver-timeout = Timeout (in seconds) until the screen blanks when the greeter is called as lockscreen
# 
[greeter]
background=/usr/share/backgrounds/korora/default/standard/korora.png
default-user-image=/usr/share/icons/hicolor/64x64/apps/korora-icon-generic.png
#theme-name=Greybird
icon-theme-name=korora
#font-name=Sans Bold 9
#xft-antialias=
#xft-dpi=
#xft-hintstyle=
#xft-rgba=
#show-indicators=
#show-clock=
#clock-format=
#keyboard=
#position=
#screensaver-timeout=
EOF
# KP - build out of kernel modules (so it's not done on first boot)
echo -e "\n***\nBUILDING AKMODS\n***"
/usr/sbin/akmods --force

# KP - start yum-updatesd
systemctl enable yum-updatesd.service

# KP - update locate database
/usr/bin/updatedb

# KP - let's run prelink (makes things faster)
echo -e "***\nPRELINKING\n****"
/usr/sbin/prelink -av -mR -q

%end