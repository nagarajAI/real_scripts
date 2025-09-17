#!/bin/bash

# To automate this public_ip updation on every restart of ec2 

echo "<?xml version='1.1' encoding='UTF-8'?>
<jenkins.model.JenkinsLocationConfiguration>
  <jenkinsUrl>http://$(curl -s http://checkip.amazonaws.com):8080/</jenkinsUrl>
</jenkins.model.JenkinsLocationConfiguration>" > /var/lib/jenkins/jenkins.model.JenkinsLocationConfiguration.xml

sudo systemctl restart jenkins 

# Schedule a bash script to update public_ip on @reboot
    # @reboot sudo bash  /home/ubuntu/update_ip.sh