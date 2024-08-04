#!/bin/bash

# Update package lists and upgrade existing packages
sudo apt update -y
sudo apt upgrade -y

# Install common dependencies, including curl
echo "Installing common dependencies..."
sudo apt-get install libcurl4-openssl-dev -y
sudo apt-get install python3-setuptools -y
sudo pip3 install --upgrade pip setuptools wheel -y
sudo apt-get install libldns-dev -y
sudo apt-get install libssl-dev -y
sudo apt-get install python3-dnspython -y
sudo apt-get install rename -y
sudo snap install powershell --classic -y
sudo apt install python3.12-venv -y
sudo apt install xdotool -y
sudo apt-get install fuse -y 
sudo apt install build-essential curl git golang jq python3 snapd wget zlib1g-dev -y
sudo apt-get install -y ruby-full && sudo gem install bundler

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

# Installs Docker
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" -y
sudo apt install -y docker-ce

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
    ["commix"]="sudo snap install commix -y"
    ["exploitdb"]="sudo snap install searchsploit"
    ["set"]="sudo apt install set -y"
    ["sqlmap"]="sudo apt install sqlmap -y"
    ["thc-ipv6"]="sudo apt install thc-ipv6 -y"
    ["yersinia"]="sudo apt install yersinia -y"

    # Forensics Tools
    ["binwalk"]="sudo apt install binwalk -y"
    ["bulk-extractor"]="sudo apt install bulk-extractor -y"
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
    ["pdfid"]="sudo apt install pdfid -y"
    ["regripper"]="sudo apt install regripper -y"

    # Frameworks
    ["beef-xss"]="sudo apt install beef -y"
    ["Covenant"]="cd /opt && sudo git clone --recurse-submodules https://github.com/cobbr/Covenant && cd /opt/Covenant/Covenant && sudo docker build -t covenant ."
    ["Empire"]="cd /opt && sudo git clone --recursive https://github.com/BC-SECURITY/Empire.git && cd Empire && sudo ./setup/checkout-latest-tag.sh && sudo apt install python3-poetry && ./ps-empire install -y"
    ["havoc"]="cd /opt && sudo git clone https://github.com/HavocFramework/Havoc.git && cd /opt/Havoc && cd teamserver && sudo go mod download golang.org/x/sys && sudo go mod download github.com/ugorji/go && cd .. && sudo make ts-build"
    ["metasploit-framework"]="sudo snap install metasploit-framework -y"
    ["osrframework"]="sudo apt install osrframework -y"
    ["routersploit"]="cd /opt && sudo git clone https://github.com/threat9/routersploit && cd routersploit && sudo python3 -m pip install -r requirements.txt && sudo python3 rsf.py"
    ["sliver"]="cd /opt && sudo git clone https://github.com/BishopFox/sliver.git && cd sliver && sudo make"
    ["Zap Proxy"]="sudo snap install zaproxy --classic --channel=stable -y"

    # Hardware Hacking Tools
    ["android-sdk"]="sudo apt install android-sdk -y"
    ["apktool"]="sudo apt install apktool -y"
    ["arduino"]="sudo apt install arduino -y"
    ["dex2jar"]="sudo apt install dex2jar -y"
    ["smali"]="sudo apt install smali -y"   

    # Information Gathering Tools
    ["aircrack-ng"]="sudo apt install aircrack-ng -y"
    ["anslookup"]="cd /opt && sudo git clone https://github.com/yassineaboukir/Asnlookup && cd Asnlookup && sudo pip3 install -r requirements.txt"
    ["apt2"]="sudo apt install apt2 -y"
    ["arp-scan"]="sudo apt install arp-scan -y"
    ["bing-ip2hosts"]="sudo apt install bing-ip2hosts -y"
    ["braa"]="sudo apt install braay -y"
    ["casefile"]="sudo apt install casefile -y"
    ["copy-router-config"]="sudo apt install copy-router-config -y"
    ["dirsearch"]="sudo apt install dirsearch -y"
    ["dmitry"]="sudo apt install dmitry -y"
    ["dnsenum"]="sudo apt install dnsenum -y"
    ["dnsmap"]="sudo apt install dnsmap -y"
    ["dnsrecon"]="sudo apt install dnsrecon -y" 
    ["dnstracer"]="sudo apt install dnstracer -y"
    ["dnswalk"]="sudo apt install dnswalk -y"
    ["dotdotpwn"]="sudo apt install dotdotpwn -y"
    ["enum4linux"]="sudo snap install enum4linux -y"
    ["enumiax"]="sudo apt install enumiax -y"
    ["ffuf"]="sudo apt install ffuf -y"
    ["fierce"]="sudo apt install fierce -y"
    ["firewalk"]="sudo apt install firewalk -y"
    ["fragroute"]="sudo apt install fragroutey -y"
    ["fragrouter"]="sudo apt install fragroutery -y"
    ["goofile"]="sudo apt install goofiley -y"
    ["hping3"]="sudo apt install hping3 -y"
    ["httprobe"]="cd /opt && sudo go install github.com/tomnomnom/httprobe@latest"
    ["hydra"]="sudo apt install hydra -y"
    ["ident-user-enum"]="sudo apt install ident-user-enum -y"
    ["knock.py"]="cd /opt && sudo git clone https://github.com/guelfoweb/knock.git && cd knock && sudo pip install ."
    ["lazys3"]="cd /opt && sudo git clone https://github.com/nahamsec/lazys3.git"
    ["lynis"]="sudo apt-get install lynis -y"
    ["masscan"]="sudo apt install masscan -y"
    ["massdns"]="cd /opt && sudo git clone https://github.com/blechschmidt/massdns.git"
    ["metagoofil"]="sudo apt install metagoofil -y"
    ["nbtscan-unixwiz"]="sudo apt install nbtscan-unixwiz -y"
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
    ["smbmap"]="sudo apt install smbmap -y"
    ["sntop"]="sudo apt install sntop -y"
    ["sqlmap-dev"]="cd /opt && sudo git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git sqlmap-dev"
    ["sslyze"]="sudo pip3 install --upgrade sslyze"
    ["subfinder"]="go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest"
    ["sublist3r"]="sudo apt install sublist3r -y"
    ["teh_s3_bucketeers.git"]="cd /opt && sudo git clone https://github.com/tomdev/teh_s3_bucketeers.git"
    ["thc-ipv6"]="sudo apt install thc-ipv6 -y"
    ["theharvester"]="sudo apt install theharvester -y"  
    ["unicornscan"]="sudo apt install unicornscan -y"
    ["unfurl"]="cd /opt && sudo go install github.com/tomnomnom/unfurl@latest"
    ["urlcrazy"]="sudo apt install urlcrazy -y"
    ["wfuzz"]="sudo apt install wfuzz -y"
    ["wireshark"]="sudo apt install wireshark -y"
    ["whois"]="sudo apt install whois -y"
    ["wpscan"]="cd /opt && sudo git clone https://github.com/wpscanteam/wpscan.git && cd wpscan && sudo gem install bundler && sudo bundle install --without test && sudo gem install wpscan"

    # Password Attacks Tools
    ["john"]="sudo apt install john -y"
    ["hashcat"]="sudo apt install hashcat -y"
    ["hydra"]="sudo apt install hydra -y"
    ["medusa"]="sudo apt install medusa -y"
    ["ncrack"]="sudo apt install ncrack -y"

    # Reverse Engineering Tools
    ["radare2"]="sudo apt install radare2 -y"
    ["ghidra"]="sudo snap install ghidra -y"
    ["cutter"]="cd /opt && sudo mkdir cutter && cd cutter && sudo wget https://github.com/rizinorg/cutter/releases/download/v2.3.4/Cutter-v2.3.4-Linux-x86_64.AppImage && sudo chmod +x Cutter-v2.3.4-Linux-x86_64.AppImage"

    ["binwalk"]="sudo apt install binwalk -y"

    # Wireless Testing Tools
    ["reaver"]="sudo apt install reaver -y"
    ["kismet"]="sudo apt install kismet -y"
    ["aircrack-ng"]="sudo apt install aircrack-ng -y"
    ["wifite"]="sudo apt install wifite -y"

    # Web Application Analysis Tools
    ["burpsuite"]="sudo snap install burpsuite --classic -y"
    ["nikto"]="sudo apt install nikto -y"
    ["wpscan"]="sudo apt install wpscan -y"
    ["arachni"]="sudo apt install arachni -y"

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
    ["pwnat"]="cd /opt && sudo git clone https://github.com/samyk/pwnat.git && cd pwnat && sudo make"
    ["sbd"]="sudo apt install sbd -y"
    ["shellter"]="sudo apt install shellter -y"
)

# Install each tool
for tool in "${!tool_list[@]}"; do
    install_tool "$tool" "${tool_list[$tool]}"
done

# Fix osrframework issue
NEW_UPDATES_PY_CONTENT=$(cat <<'EOF'
import xmlrpc.client

try:
    from pip._internal.metadata import get_environment
except ImportError:
    try:
        from pip._internal.utils.misc import get_installed_distributions
    except ImportError:
        from pip import get_installed_distributions

def get_installed_packages():
    try:
        installed_packages = [dist.metadata['Name'] for dist in get_environment().iter_installed_distributions(local_only=True)]
    except NameError:
        installed_packages = [dist.project_name for dist in get_installed_distributions()]
    return installed_packages

# Example usage:
if __name__ == "__main__":
    packages = get_installed_packages()
    for package in packages:
        print(package)
EOF
)

# Locate updates.py path and modify it
UPDATES_PY_PATH=$(python3 -c 'import osrframework.utils; print(osrframework.utils.__file__)' | sed 's/__init__.py/updates.py/')
sudo cp "$UPDATES_PY_PATH" "$UPDATES_PY_PATH.bak"
echo "$NEW_UPDATES_PY_CONTENT" | sudo tee "$UPDATES_PY_PATH" > /dev/null

# Clean up
sudo apt autoremove -y
echo "Installation complete!"

# Docker status
sudo systemctl --no-pager status docker
sleep 1
xdotool key ctrl+shift+c
