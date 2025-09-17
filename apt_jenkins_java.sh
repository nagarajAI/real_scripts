#!/bin/bash
#Ubuntu User Data Script: Install Git, Java, Jenkins
# Log output to /var/log/user-data.log & /var/log/syslog
exec > >(tee /var/log/user-data.log | logger -t user-data) 2>&1

set -e

echo "Updating packages..."
apt-get update -y
apt-get upgrade -y

echo "Installing Java 21-jre..."
apt-get install -y fontconfig openjdk-21-jre
java -version

echo "Adding Jenkins repository key..."
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "Creating Jenkins apt source list..."
echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/" | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

echo "Updating package lists with Jenkins repo..."
apt-get update -y

echo "Installing Jenkins..."
apt-get install -y jenkins

echo "Enabling and starting Jenkins service..."
systemctl enable jenkins
systemctl start jenkins

echo "Installation complete!"
echo "Initial Jenkins admin password (use this to unlock Jenkins):"
cat /var/lib/jenkins/secrets/initialAdminPassword
