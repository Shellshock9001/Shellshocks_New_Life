#!/bin/bash

# Update package lists and upgrade existing packages
sudo apt-get update -y && sudo apt-get upgrade -y


# Install common dependencies, including curl
echo "Installing common dependencies..."
sudo apt-get install libre2-dev libcurl4-openssl-dev libldns-dev libssl-dev libncurses5-dev python3-dnspython rename xdotool fuse build-essential curl git golang jq python3 snapd wget zlib1g zlib1g-dev ruby-full -y
sudo apt-get install gcc g++ flex libewf-dev libreadline-dev libsqlite3-dev -y
sudo apt-get install libncurses5-dev libnl-genl-3-dev pkg-config libpcap-dev libnm-dev libcap-dev -y
sudo apt-get install python3-setuptools python3-wheel -y
sudo apt-get install openjdk-17-jdk openjdk-17-jre libxext-dev libxrender-dev libxtst-dev -y
sudo snap install powershell --classic -y
sudo apt-get install ruby-dev
sudo apt install ruby
sudo gem install json -v '2.7.2'
sudo gem install bundler


# Update package lists and upgrade existing packages
sudo apt-get update -y && sudo apt-get upgrade -y


sudo rm /usr/lib/python3.*/EXTERNALLY-MANAGED
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


# Function to install a tool if it's not already installed
install_tool() {
    tool_name=$1
    install_command=$2

    if ! command -v "$tool_name" &> /dev/null; then
        echo "Installing $tool_name..."
        eval "$install_command"
        echo "$tool_name installed successfully."
    else
        echo "$tool_name is already installed."
    fi
}

# List of tools and their installation commands
declare -A tool_list=(
    # Exploitation Tools
    ["backdoor-factory"]="sudo apt install backdoor-factory -y"
    ["bulk_extractor"]="cd /opt && sudo git clone --recurse-submodules https://github.com/simsong/bulk_extractor.git && cd bulk_extractor && sudo chmod +x bootstrap.sh && sudo ./bootstrap.sh && sudo ./configure && sudo make && sudo make install"
    ["commix"]="sudo snap install commix -y"
    ["exploitdb"]="sudo snap install searchsploit"
    ["set"]="sudo apt install set -y"
    ["sqlmap"]="sudo apt install sqlmap -y"
    ["thc-ipv6"]="sudo apt install thc-ipv6 -y"
    ["yersinia"]="sudo apt install yersinia -y"

    # Forensics Tools
    ["binwalk"]="sudo apt install binwalk -y"
    ["capstone-tool"]="sudo apt install capstone-tool -y"
    ["chntpw"]="sudo apt install chntpw -y"
    ["dc3dd"]="sudo apt install dc3dd -y"
    ["ddrescue"]="sudo apt install gddrescue -y"
    ["extundelete"]="sudo apt install extundelete -y"
    ["foremost"]="sudo apt install foremost -y"
    ["galleta"]="sudo apt install galleta -y"
    ["guymager"]="sudo apt install guymager -y"
    ["p0f"]="sudo apt install p0f -y"
    ["pdf-parser"]="pip3 install py-pdf-parser"
    ["regripper"]="sudo apt install regripper -y"

    # Frameworks
    ["beef-xss"]="sudo apt install beef -y"
    ["Covenant"]="cd /opt && sudo git clone --recurse-submodules https://github.com/cobbr/Covenant && cd /opt/Covenant/Covenant && sudo docker build -t covenant ."
    ["Empire"]="cd /opt && sudo git clone --recursive https://github.com/BC-SECURITY/Empire.git && cd /opt/Empire && sudo ./setup/checkout-latest-tag.sh && sudo apt install python3-poetry && ./ps-empire install -y"
    ["havoc"]="cd /opt && sudo git clone https://github.com/HavocFramework/Havoc.git && cd /opt/Havoc && cd teamserver && sudo go mod download golang.org/x/sys && sudo go mod download github.com/ugorji/go && cd .. && sudo make ts-build"
    ["metasploit-framework"]="sudo snap install metasploit-framework -y"
    ["osrframework"]="cd /opt && sudo pip3 install osrframework && sudo pip3 install osrframework --upgrade"
    ["routersploit"]="cd /opt && sudo git clone https://github.com/threat9/routersploit && cd /opt/routersploit && sudo python3 -m pip install -r requirements.txt"
    ["sliver"]="cd /opt && sudo git clone https://github.com/BishopFox/sliver.git && cd sliver && sudo make"
    ["Zap Proxy"]="sudo snap install zaproxy --classic --channel=stable -y"

    # Hardware Hacking Tools
    ["android-sdk"]="sudo apt install android-sdk -y"
    ["apktool"]="sudo apt install apktool -y"
    ["arduino"]="sudo apt install arduino -y"
    ["dex2jar"]="cd /opt && sudo git clone https://github.com/pxb1988/dex2jar.git"
    ["smali"]="sudo apt install smali -y"   

    # Information Gathering Tools
    ["aircrack-ng"]="sudo apt install aircrack-ng -y"
    ["anslookup"]="cd /opt && sudo git clone https://github.com/yassineaboukir/Asnlookup && cd Asnlookup && sudo pip3 install -r requirements.txt"
    ["arp-scan"]="sudo apt install arp-scan -y"
    ["bing-ip2hosts"]="cd /opt && sudo git clone https://github.com/urbanadventurer/bing-ip2hosts"
    ["dirsearch"]="sudo apt install dirsearch -y"
    ["dmitry"]="sudo apt install dmitry -y"
    ["dnsenum"]="sudo apt install dnsenum -y"
    ["dnsmap"]="sudo apt install dnsmap -y"
    ["dnsrecon"]="sudo apt install dnsrecon -y" 
    ["dnstracer"]="sudo apt install dnstracer -y"
    ["dnswalk"]="sudo apt install dnswalk -y"
    ["enum4linux"]="sudo snap install enum4linux -y"
    ["ffuf"]="sudo apt install ffuf -y"
    ["fierce"]="sudo apt install fierce -y"
    ["firewalk"]="sudo apt install firewalk -y"
    ["hping3"]="sudo apt install hping3 -y"
    ["httprobe"]="cd /opt && sudo go install github.com/tomnomnom/httprobe@latest"
    ["hydra"]="sudo apt install hydra -y"
    ["knock.py"]="cd /opt && sudo git clone https://github.com/guelfoweb/knock.git && cd knock && sudo pip install ."
    ["lazys3"]="cd /opt && sudo git clone https://github.com/nahamsec/lazys3.git"
    ["lynis"]="sudo apt-get install lynis -y"
    ["masscan"]="sudo apt install masscan -y"
    ["massdns"]="cd /opt && sudo git clone https://github.com/blechschmidt/massdns.git"
    ["nbtscan-unixwiz"]="cd /home/shellshock/tools && sudo git clone https://github.com/resurrecting-open-source-projects/nbtscan/ && cd /home/shellshock/tools/nbtscan && sudo ./autogen.sh && sudo ./configure && sudo make && sudo make install"
    ["net-tools"]="sudo apt-get install net-tools -y"
    ["nikto"]="sudo apt install nikto -y"
    ["nmap"]="sudo apt install nmap -y"
    ["ntopng"]="sudo apt install ntopng -y"
    ["ntopng-data"]="sudo apt install ntopng-data -y"
    ["ntopng-doc"]="sudo apt install ntopng-doc -y"
    ["nuclei"]="go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest"
    ["p0f"]="sudo apt install p0f -y"
    ["parsero"]="sudo apt install parsero -y"
    ["recon-ng"]="cd /opt && sudo git clone https://github.com/lanmaster53/recon-ng.git && cd /opt/recon-ng && pip install --upgrade -r REQUIREMENTS && sudo docker build --rm -t recon-ng ."
    ["seclist"]="cd /opt && sudo git clone https://github.com/danielmiessler/SecLists.git && cd /opt/SecLists/Discovery/DNS && sudo bash -c 'cat dns-Jhaddix.txt | head -n -14 > clean-jhaddix-dns.txt'"
    ["set"]="sudo apt install set -y"
    ["searchsploit"]="sudo snap install searchsploit -y"
    ["SIPVicious"]="sudo apt-get install sipvicious"
    ["smbmap"]="sudo apt install smbmap -y"
    ["sntop"]="sudo apt install sntop -y"
    ["sqlmap-dev"]="cd /opt && sudo git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git sqlmap-dev"
    ["sslyze"]="sudo pip3 install --upgrade sslyze"
    ["subfinder"]="go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest"
    ["sublist3r"]="sudo apt install sublist3r -y"
    ["teh_s3_bucketeers.git"]="cd /opt && sudo git clone https://github.com/tomdev/teh_s3_bucketeers.git"
    ["thc-ipv6"]="sudo apt install thc-ipv6 -y"    
    ["unfurl"]="cd /opt && sudo go install github.com/tomnomnom/unfurl@latest"
    ["urlcrazy"]="sudo mkdir /home/shellshock/tools/ && cd /home/shellshock/tools/ && sudo gem install json colorize async async-dns async-http && sudo git clone https://github.com/urbanadventurer/urlcrazy.git"
    ["wfuzz"]="sudo apt install wfuzz -y"
    ["wireshark"]="echo 'wireshark-common wireshark-common/install-setuid boolean false' | sudo debconf-set-selections && sudo apt update && sudo apt install -y wireshark"
    ["whois"]="sudo apt install whois -y"
    ["wpscan"]="cd /opt && sudo git clone https://github.com/wpscanteam/wpscan.git && cd /opt/wpscan && sudo bundle install --without test && sudo gem install wpscan"

    # Password Attacks Tools
    ["john"]="sudo apt install john -y"
    ["hashcat"]="sudo apt install hashcat -y"
    ["hydra"]="sudo apt install hydra -y"
    ["medusa"]="sudo apt install medusa -y"
    ["ncrack"]="sudo apt install ncrack -y"

    # Reverse Engineering Tools
    ["radare2"]="sudo apt install radare2 -y"
    ["ghidra"]="sudo snap install ghidra -y"
    ["cutter"]="cd /opt && sudo mkdir cutter && cd /opt/cutter && sudo wget https://github.com/rizinorg/cutter/releases/download/v2.3.4/Cutter-v2.3.4-Linux-x86_64.AppImage && sudo chmod +x Cutter-v2.3.4-Linux-x86_64.AppImage"

    ["binwalk"]="sudo apt install binwalk -y"

    # Wireless Testing Tools
    ["reaver"]="sudo apt install reaver -y"
    ["kismet"]="sudo wget -O - https://www.kismetwireless.net/repos/kismet-release.gpg.key --quiet | gpg --dearmor | sudo tee /usr/share/keyrings/kismet-archive-keyring.gpg >/dev/null && echo 'deb [signed-by=/usr/share/keyrings/kismet-archive-keyring.gpg] https://www.kismetwireless.net/repos/apt/git/noble noble main' | sudo tee /etc/apt/sources.list.d/kismet.list >/dev/null && echo "kismet-core kismet/install-setuid boolean true" | sudo debconf-set-selections && sudo apt update && sudo apt install kismet -y"
    ["aircrack-ng"]="sudo apt install aircrack-ng -y"
    ["wifite"]="sudo apt install wifite -y"

    # Web Application Analysis Tools
    ["burpsuite"]="sudo snap install burpsuite --classic -y"
    ["nikto"]="sudo apt install nikto -y"
    ["wpscan"]="sudo apt install wpscan -y"

    # Miscellaneous Tools
    ["tmux"]="sudo apt install tmux -y"
    ["screen"]="sudo apt install screen -y"
    ["vim"]="sudo apt install vim -y"
    ["nano"]="sudo apt install nano -y"
    ["htop"]="sudo apt install htop -y"

    # Maintaining Access Tools
    ["dns2tcp"]="sudo apt install dns2tcp -y"
    ["docker"]="sudo snap install docker -y"
    ["httptunnel"]="sudo apt install httptunnel -y"
    ["nishang"]="cd /opt && sudo git clone https://github.com/samratashok/nishang.git && echo 'export PATH=\"$PATH:/opt/nishang\"' >> ~/.bashrc && source ~/.bashrc"
    ["polenum"]="sudo apt install polenum -y"
    ["pwnat"]="cd /opt && sudo git clone https://github.com/samyk/pwnat.git && cd /opt/pwnat && sudo make"
    ["sbd"]="sudo apt install sbd -y"
)

# Install each tool
for tool in "${!tool_list[@]}"; do
    install_tool "$tool" "${tool_list[$tool]}"
done


# Clean up
sudo apt autoremove -y
echo "Installation complete!"

# Docker status
sudo systemctl --no-pager status docker
sleep 1
xdotool key ctrl+shift+c
