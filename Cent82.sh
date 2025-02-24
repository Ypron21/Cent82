echo -e "$123\n$123\n" | sudo passwd
rm -rf ngrok  ngrok.zip  ng.sh > /dev/null 2>&1

# Download and install the latest version of ngrok
wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip
unzip ngrok-stable-linux-amd64.zip
chmod +x ngrok

clear

echo "======================="
echo "Choose ngrok region"
echo "======================="
echo "us - United States (Ohio)"
echo "eu - Europe (Frankfurt)"
echo "ap - Asia/Pacific (Singapore)"
echo "au - Australia (Sydney)"
echo "sa - South America (Sao Paulo)"
echo "jp - Japan (Tokyo)"
echo "in - India (Mumbai)"
read -p "Choose ngrok region: " CRP

# Debug: Print the chosen region
echo "Chosen region: $CRP"

# Start ngrok with the chosen region and port
./ngrok tcp --region $CRP 3388 &

# Wait for ngrok to start
sleep 10

# Check if ngrok is running
if ! curl --silent --show-error http://127.0.0.1:4040/api/tunnels > /dev/null; then
    echo "Ngrok failed to start. Check ngrok.log for details."
    exit 1
fi

echo "===================================="
echo "Install RDP"
echo "===================================="
docker pull akuhnet/centos7-fix:1.1
clear

echo "===================================="
echo "Start RDP"
echo "===================================="
echo "===================================="
echo "Username : root"
echo "Password : 123"
echo "RDP Address:"
curl --silent --show-error http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*public_url":"tcp:..([^"]*).*/\1/p'
echo "===================================="
echo "===================================="
echo "Don't close this tab to keep RDP running"
echo "Keep support akuh.net thank you"
echo "Wait 1 minute to finish bot"
echo "===================================="
echo "===================================="
docker run -it -p 3388:3389 akuhnet/centos7-fix:1.1 root 123 yes > /dev/null 2>&1
