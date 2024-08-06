#!/bin/bash

# I am testing this symlink 
# cd /opt && sudo git clone https://github.com/threat9/routersploit && sudo chown -R $USER:$USER /opt/routersploit && cd /opt/routersploit && python3 -m venv shellshock_routersploit && source shellshock_routersploit/bin/activate && pip install setuptools future && pip install -r requirements.txt && python3 rsf.py && deactivate && echo '#!/bin/bash\nsource /opt/routersploit/shellshock_routersploit/bin/activate\npython3 /opt/routersploit/rsf.py "$@"\ndeactivate' > /opt/routersploit/rsf && chmod +x /opt/routersploit/rsf && sudo ln -s /opt/routersploit/rsf /usr/local/bin/rsf
# this will create a wrapper to activate the shellshock_routersploit venv
# making it executable and allowing you to run rsf.py in any directory

# You will have to move into the routersploit directory and activate the venv anytime you want to use it for now
# source shellshock_routersploit/bin/activate
# ./rsf.py

echo "Updating package lists..."
sudo apt-get update

echo "Upgrading existing packages..."
sudo apt-get upgrade -y

echo "Installing common dependencies..."
sudo apt-get install -y \
    libcurl4-openssl-dev \
    libre2-dev \
    jq \
    ruby-full \
    zlib1g \
    libxml2 \
    libxml2-dev \
    libxslt-dev \
    ruby-dev \
    libgmp-dev \
    zlib1g-dev \
    build-essential \
    libssl-dev \
    libffi-dev \
    python-dev-is-python3 \
    libldns-dev \
    python3-dnspython \
    python3.venv \
    python3-pip \
    python3-poetry \
    python3-setuptools \
    python3-wheel \
    docker \
    git \
    rename \
    xdotool \
    fuse3 \
    curl \
    wget \
    flex \
    pkg-config \
    libewf-dev \
    libreadline-dev \
    libsqlite3-dev \
    libncurses-dev \
    libnl-genl-3-dev \
    libpcap-dev \
    libnm-dev \
    libcap-dev \
    libxext-dev \
    libxrender-dev \
    libxtst-dev

echo "Cleaning up..."
sudo apt-get autoremove -y
sudo apt-get clean

echo "Common dependencies installation completed."

echo "Installing golang-go..."
sudo apt install golang-go -y
if [ $? -ne 0 ]; then
    echo "Failed to install Go"
    exit 1
fi

# Add Go binary to PATH
export PATH=$PATH:$(go env GOPATH)/bin
echo 'export PATH=$PATH:$(go env GOPATH)/bin' >> ~/.bashrc
source ~/.bashrc

#### Exploitation Tools ####

# backdoor-factory
sudo apt install backdoor-factory -y

# bulk_extractor
cd /opt && sudo git clone --recurse-submodules https://github.com/simsong/bulk_extractor.git && cd bulk_extractor && sudo chmod +x bootstrap.sh && sudo ./bootstrap.sh && sudo ./configure && sudo make && sudo make install

# set
cd /opt && sudo git clone https://github.com/trustedsec/social-engineer-toolkit/ setoolkit/ && sudo chown -R $USER:$USER /opt/setoolkit && cd /opt/setoolkit && python3 -m venv shellshock_setoolkit && source shellshock_setoolkit/bin/activate && pip install -r requirements.txt || true && deactivate && sudo python3 setup.py install

# sqlmap-dev
cd /opt && sudo git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git sqlmap-dev

# thc-ipv6
sudo apt install thc-ipv6 -y

# yersinia
sudo apt install yersinia -y

#### Forensics Tools ####

# binwalk
sudo apt install binwalk -y

# capstone-tool
sudo apt install capstone-tool -y

# chntpw
sudo apt install chntpw -y

# dc3dd
sudo apt install dc3dd -y

# ddrescue
sudo apt install gddrescue -y

# extundelete
sudo apt install extundelete -y

# foremost
sudo apt install foremost -y

# galleta
sudo apt install galleta -y

# guymager
sudo apt install guymager -y

# p0f
sudo apt-get install p0f -y

# pdf-parser
pip3 install py-pdf-parser

# regripper
sudo apt install regripper -y

#### Frameworks ####

# beef-xss
sudo apt install beef -y

# Covenant
cd /opt && sudo git clone --recurse-submodules https://github.com/cobbr/Covenant && cd /opt/Covenant/Covenant && sudo docker build -t covenant .

# Empire
cd /opt && sudo git clone --recursive https://github.com/BC-SECURITY/Empire.git && cd /opt/Empire && sudo ./setup/checkout-latest-tag.sh && sudo ./ps-empire install -y

# havoc
cd /opt && sudo git clone https://github.com/HavocFramework/Havoc.git && cd /opt/Havoc && cd teamserver && sudo go mod download golang.org/x/sys && sudo go mod download github.com/ugorji/go && cd .. && sudo make ts-build

# osrframework
cd /opt && sudo pip3 install osrframework && sudo pip3 install osrframework --upgrade

# routersploit
cd /opt && sudo git clone https://github.com/threat9/routersploit && sudo chown -R $USER:$USER /opt/routersploit && cd /opt/routersploit && python3 -m venv shellshock_routersploit && source shellshock_routersploit/bin/activate && pip install setuptools future && pip install -r requirements.txt && python3 rsf.py && deactivate

# sliver
cd /opt && sudo git clone https://github.com/BishopFox/sliver.git && cd sliver && sudo make

#### Hardware Hacking Tools ####

# android-sdk
sudo apt install android-sdk -y

# apktool
sudo apt install apktool -y

# arduino
sudo apt install arduino -y

# dex2jar
cd /opt && sudo git clone https://github.com/pxb1988/dex2jar.git

# smali
sudo apt install smali -y

#### Information Gathering Tools ####

# anslookup
cd /opt && sudo git clone https://github.com/yassineaboukir/Asnlookup asnlookup/ && sudo chown -R $USER:$USER /opt/asnlookup && cd /opt/asnlookup && python3 -m venv shellshock_asnlookup && source shellshock_asnlookup/bin/activate && pip install -r requirements.txt || true && deactivate

# arp-scan
sudo apt install arp-scan -y

# bing-ip2hosts
cd /opt && sudo git clone https://github.com/urbanadventurer/bing-ip2hosts

# dirsearch
sudo apt install dirsearch -y

# dmitry
sudo apt install dmitry -y

# dnsenum
sudo apt install dnsenum -y

# dnsmap
sudo apt install dnsmap -y

# dnsrecon
sudo apt install dnsrecon -y

# dnstracer
sudo apt install dnstracer -y

# dnswalk
sudo apt install dnswalk -y

# ffuf
sudo apt install ffuf -y

# fierce
sudo apt install fierce -y

# firewalk
sudo apt install firewalk -y

# hping3
sudo apt install hping3 -y

# httprobe
cd /opt && sudo go install github.com/tomnomnom/httprobe@latest

# knock.py
sudo apt-get install knockpy -y

# lazys3
cd /opt && sudo git clone https://github.com/nahamsec/lazys3.git

# lynis
sudo apt-get install lynis -y

# masscan
sudo apt install masscan -y

# massdns
cd /opt && sudo git clone https://github.com/blechschmidt/massdns.git

# nbtscan-unixwiz
cd /home/shellshock/tools && sudo git clone https://github.com/resurrecting-open-source-projects/nbtscan/ && cd /home/shellshock/tools/nbtscan && sudo ./autogen.sh && sudo ./configure && sudo make && sudo make install

# net-tools
sudo apt-get install net-tools -y

# nmap
sudo apt install nmap -y

# ntopng
sudo apt install ntopng -y

# ntopng-data
sudo apt install ntopng-data -y

# ntopng-doc
sudo apt install ntopng-doc -y

# nuclei
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest

# parsero
sudo apt install parsero -y

# recon-ng
cd /opt && sudo git clone https://github.com/lanmaster53/recon-ng.git && sudo chown -R $USER:$USER /opt/recon-ng && cd /opt/recon-ng && python3 -m venv shellshock_reconng && source shellshock_reconng/bin/activate && pip install -r REQUIREMENTS && deactivate

# seclist
cd /opt && sudo git clone https://github.com/danielmiessler/SecLists.git && cd /opt/SecLists/Discovery/DNS && sudo bash -c 'cat dns-Jhaddix.txt | head -n -14 > clean-jhaddix-dns.txt'

# SIPVicious
sudo apt-get install sipvicious -y

# smbmap
sudo apt install smbmap -y

# sntop
sudo apt install sntop -y

# sslyze
sudo pip3 install --upgrade sslyze

# subfinder
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

# sublist3r
sudo apt install sublist3r -y

# teh_s3_bucketeers.git
cd /opt && sudo git clone https://github.com/tomdev/teh_s3_bucketeers.git

# unfurl
cd /opt && sudo go install github.com/tomnomnom/unfurl@latest

# urlcrazy
sudo mkdir /home/shellshock/tools/ && cd /home/shellshock/tools/ && sudo gem install json colorize async async-dns async-http && sudo git clone https://github.com/urbanadventurer/urlcrazy.git

# wfuzz
sudo apt install wfuzz -y

# wireshark
echo 'wireshark-common wireshark-common/install-setuid boolean false' | sudo debconf-set-selections && sudo apt update && sudo apt install -y wireshark

# whois
sudo apt install whois -y

#### Password Attacks Tools ####

# john
sudo apt install john -y

# hashcat
sudo apt install hashcat -y

# hydra
sudo apt install hydra -y

# medusa
sudo apt install medusa -y

# ncrack
sudo apt install ncrack -y

#### Reverse Engineering Tools ####

# radare2
sudo apt install radare2 -y

# cutter
cd /opt && sudo mkdir cutter && cd /opt/cutter && sudo wget https://github.com/rizinorg/cutter/releases/download/v2.3.4/Cutter-v2.3.4-Linux-x86_64.AppImage && sudo chmod +x Cutter-v2.3.4-Linux-x86_64.AppImage

#### Wireless Testing Tools ####

# reaver
sudo apt install reaver -y

# aircrack-ng
sudo apt install aircrack-ng -y

# wifite
sudo apt install wifite -y

#### Web Application Analysis Tools ####

# nikto
sudo apt install nikto -y

# wpscan
cd /opt && sudo git clone https://github.com/wpscanteam/wpscan.git && cd /opt/wpscan && sudo bundle install --without test && sudo gem install wpscan

#### Miscellaneous Tools ####

# tmux
sudo apt install tmux -y

# vim
sudo apt install vim -y

# nano
sudo apt install nano -y

# htop
sudo apt install htop -y

#### Maintaining Access Tools ####

# dns2tcp
sudo apt install dns2tcp -y

# httptunnel
sudo apt install httptunnel -y

# nishang
cd /opt && sudo git clone https://github.com/samratashok/nishang.git && echo 'export PATH=\"$PATH:/opt/nishang\"' >> ~/.bashrc && source ~/.bashrc

# polenum
sudo apt install polenum -y

# pwnat
cd /opt && sudo git clone https://github.com/samyk/pwnat.git && cd /opt/pwnat && sudo make

# sbd
sudo apt install sbd -y

echo "Installation complete!"
