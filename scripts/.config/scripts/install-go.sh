
#!/usr/bin/env bash
set -e

# Requires jq: sudo apt install jq
LATEST=$(curl -s https://go.dev/dl/?mode=json | jq -r '.[0].version')
FILE="${LATEST}.linux-amd64.tar.gz"
URL="https://go.dev/dl/${FILE}"

echo "Latest Go version: $LATEST"
echo "Downloading: $URL"

wget -q --show-progress "$URL" -O /tmp/go.tar.gz

echo "Removing previous /usr/local/go..."
sudo rm -rf /usr/local/go

echo "Extracting..."
sudo tar -C /usr/local -xzf /tmp/go.tar.gz

# Add Go to PATH if missing
if ! grep -q '/usr/local/go/bin' ~/.exports; then
    echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.exports
fi

# GOPATH
if ! grep -q 'export GOPATH=' ~/.exports; then
    echo 'export GOPATH=$HOME/go' >> ~/.exports
    echo 'export PATH=$PATH:$GOPATH/bin' >> ~/.exports
fi

echo "Go installed successfully!"
