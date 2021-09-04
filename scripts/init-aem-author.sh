#!/bin/bash
# Install Java
sudo apt-get update && sudo apt-get install default-jre -y

# Download and Install AEM
mkdir /home/azureuser/aem \
&& cd /home/azureuser/aem \
&& curl -o license.properties "https://aemdemostorage.blob.core.windows.net/aem65/setup/license.properties" \
&& curl -o cq5-author-p80.jar "https://aemdemostorage.blob.core.windows.net/aem65/setup/aem-author-4502.jar" \
&& sudo java -jar cq-author-p80.jar -nointeractive