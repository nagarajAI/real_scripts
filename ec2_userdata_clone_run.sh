#!/bin/bash
#Ubuntu User Data Script: Install Git, Java, Jenkins
# Log output to /var/log/user-data.log & /var/log/syslog
exec > >(tee /var/log/user-data.log | logger -t user-data) 2>&1

set -e

echo "Updating packages..."
apt-get update -y
apt-get upgrade -y

echo "Installing Git..."
apt-get install -y git

# -------- CONFIGURE THESE VARIABLES --------
GITHUB_REPO_URL="https://github.com/nagarajAI/real_scripts.git"
TARGET_DIR="/opt/myapp"
SCRIPT_TO_RUN="apt_jenkins_java.sh"   # path inside repo
# -------------------------------------------

echo "Cloning repository..."
git clone "$GITHUB_REPO_URL" "$TARGET_DIR"

echo "Changing to repo directory..."
cd "$TARGET_DIR"

echo "Making sure script is executable..."
chmod +x "$SCRIPT_TO_RUN"

echo "Running the script..."
./"$SCRIPT_TO_RUN"

echo "User-data script completed."
