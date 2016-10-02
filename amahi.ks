# Kickstart file for composing the "Fedora" spin of Fedora (rawhide)
# Maintained by the Fedora Release Engineering team:
# https://fedoraproject.org/wiki/ReleaseEngineering
# mailto:rel-eng@lists.fedoraproject.org

# Use a part of 'iso' to define how large you want your isos.
# Only used when composing to more than one iso.
# Default is 695 (megs), CD size.
# Listed below is the size of a DVD if you wanted to split higher.
#part iso --size=4998

# Add the repos you wish to use to compose here.  At least one of them needs group data.

# Only uncomment repo commands in one of the two following sections.
# Because the install kickstart doesn't use the updates repo and does
# use the source repo, we can't just include fedora-repo.ks

# In the master branch the rawhide repo commands should be uncommented.
#repo --name=rawhide --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=rawhide&arch=$basearch --excludepkgs=fedora-productimg-cloud,fedora-productimg-workstation
#repo --name=rawhide-source  --mirrorlist=http://mirrors.fedoraproject.org/mirrorlist?repo=rawhide-source&arch=$basearch --excludepkgs=fedora-productimg-cloud,fedora-productimg-workstation

# In non-master branches the fedora repo commands should be uncommented
repo --name=fedora --baseurl=http://mirrors.mit.edu/fedora/linux/releases/24/Everything/x86_64/os/ --excludepkgs=fedora-productimg-cloud,fedora-productimg-workstation
repo --name=fedora-updates --baseurl=http://mirrors.mit.edu/fedora/linux/updates/24/x86_64/
repo --name=amahi --baseurl=http://f24.amahi.org/ --nogpgkey

# Package manifest for the compose.  Uses repo group metadata to translate groups.
# (default groups for the configured repos are added by --default)
# @base got renamed to @standard, but @base is still included by default by pungi.
%packages --default

-fedora-productimg-cloud
fedora-productimg-server
-fedora-productimg-workstation

# pungi is an inclusive depsolver so that multiple packages are brought
# in to satisify dependencies and we don't always want that. So we  use
# an exclusion list to cut out things we don't want

-kernel*debug*
-kernel-kdump*
-kernel-tools*
-syslog-ng*
-astronomy-bookmarks
-GConf2-dbus*
-generic-logos*
-generic-release*
-bluez-gnome
-community-mysql*

# core
kernel*
dracut-*

# No desktops
-cinnamon*
-enlightenment*
-gnome-shell
-gnome-session
-kde*
-lightdm-kde
-lightdm-razorqt
# Pulls in qt
-oprofile-gui

-@legacy-fonts

-@multimedia

## common stuff
-@guest-agents
-@standard
@core
@hardware-support

# Fedora Server.
# Including this causes the fedora-release-server package to be included,
# which in turn enables server-product-environment, and due to to its priority
# this will be the default environment.
-@^server-product-environment
-@server-product
-@headless-management
-@container-management
-@domain-client

# Common server packages
-@mysql
-@sql-server
-@web-server

# Web Server environment
-@haproxy
-@mongodb
-@perl-web
-@python-web
-@php
-@rubyonrails
-@tomcat

# Infrastructure Server
-@directory-server
-@dogtag
-@dns-server
-@freeipa-server
-@ftp-server
-@mail-server
-@network-server
-@printing
-@smb-server
-@virtualization
-@load-balancer
-@ha

-@javaenterprise

# “uservisible” groups we want to offer
-@editors
-@network-server
-@system-tools
-@text-internet

# Things needed for installation
@anaconda-tools
fedora-productimg-server

# Langpacks
-autocorr-*
autocorr-en
-hunspell-*
hunspell-en
-man-pages-*
-gimp-help-*
-glibc-langpack-*
glibc-langpack-en
# Removals
-PackageKit-zif
-zif

# Amahi deps
GeoIP
GeoIP-GeoLite-data
augeas-libs
bc
bind-libs
bind-libs-lite
bind-license
bind-utils
bzip2
cadaver
cryptsetup
cups-libs
fontconfig
fontpackages-filesystem
gd
hddtemp
jbigkit-libs
jsoncpp
libX11
libX11-common
libXau
libXpm
libaio
libev
libicu
libjpeg-turbo
libldb
libmcrypt
libtalloc
libtdb
libtevent
libtiff
libuv
libvpx
libwbclient
libwebp
libxcb
libyaml
lsof
mariadb
mariadb-common
mariadb-config
mariadb-errmsg
mariadb-libs
mariadb-server
mlocate
mod_passenger
monit
neon
pakchois
passenger
patch
perl-Authen-PAM
perl-Business-ISBN
perl-Business-ISBN-Data
perl-Compress-Raw-Bzip2
perl-Compress-Raw-Zlib
perl-DBD-MySQL
perl-DBI
perl-Data-Dumper
perl-Digest
perl-Digest-HMAC
perl-Digest-MD5
perl-Digest-SHA
perl-Encode-Locale
perl-File-Listing
perl-GD
perl-GD-Barcode
perl-HTML-Parser
perl-HTML-Tagset
perl-HTTP-Cookies
perl-HTTP-Date
perl-HTTP-Message
perl-HTTP-Negotiate
perl-IO-Compress
perl-IO-HTML
perl-IO-Socket-IP
perl-IO-Socket-SSL
perl-JSON-PP
perl-LWP-MediaTypes
perl-LWP-Protocol-https
perl-Math-BigInt
perl-Math-Complex
perl-Mojolicious
perl-Mozilla-CA
perl-NTLM
perl-Net-HTTP
perl-Net-SSLeay
perl-Storable
perl-Time-HiRes
perl-TimeDate
perl-URI
perl-WWW-RobotRules
perl-libnet
perl-libwww-perl
php
php-cli
php-common
php-gd
php-mbstring
php-mcrypt
php-mysqlnd
php-pdo
php-pecl-jsonc
php-xml
pmount
python-talloc
ruby
ruby-augeas
ruby-irb
ruby-libs
rubygem-bigdecimal
rubygem-bundler
rubygem-daemon_controller
rubygem-did_you_mean
rubygem-io-console
rubygem-json
rubygem-mysql2
rubygem-psych
rubygem-rack
rubygem-rake
rubygem-rdoc
rubygem-ruby-dbus
rubygems
rubypick
samba
samba-client-libs
samba-common
samba-common-libs
samba-common-tools
samba-libs
systemd-compat-libs
t1lib
tar
unzip
usermode
v8
wol

# Firewall
-firewalld

# Amahi
hda-release
hda-ctl
hda-platform

%end
%post
sed -i -e ‘s/Generic release/Amahi 10 (Developer Preview)/g’ /etc/fedora-release /etc/issue
%end
