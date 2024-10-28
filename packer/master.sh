# Install GitLab Runner
curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.deb.sh" | sudo bash
sudo apt-get install -y gitlab-runner

# Install Fleeting GitLab Runner Azure
wget https://gitlab.com/gitlab-org/fleeting/plugins/azure/-/releases/v1.0.0/downloads/fleeting-plugin-azure-linux-amd64
sudo mv fleeting-plugin-azure-linux-amd64 /usr/local/bin/fleeting-plugin-azure
sudo chmod +x /usr/local/bin/fleeting-plugin-azure
