ls -r1 downloads/ | grep bedrock-server | head -2 | tail -1 > version_pin.txt
echo "Set previous version in version_pin.txt: $(cat version_pin.txt)"