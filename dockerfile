# Use a Salesforce-supported base image
FROM salesforce/salesforcedx:latest

# Set environment variables for Salesforce CLI
ENV SFDX_AUTOUPDATE_DISABLE=true \
    SFDX_USE_GENERIC_UNIX_KEYCHAIN=true \
    SFDX_DOMAIN_RETRY=300

# Install any additional dependencies or tools you need
RUN npm install -g my-tool

# Copy your Salesforce project files to the container
COPY . /app

# Set the working directory
WORKDIR /app

# Install Salesforce project dependencies
RUN sfdx force:source:push -u srao.vlocity@gmail.com --wait 10

# Deploy triggers
RUN sfdx force:apex:trigger:deploy -d force-app/main/default/triggers/OpportunityTrigger.trigger -u srao.vlocity@gmail.com 


# Set the entrypoint command to run Salesforce DX commands
ENTRYPOINT ["sfdx"]

# Set the default command for the container
CMD ["force:apex:test:run", "-c", "-r", "human", "-u", "srao.vlocity@gmail.com "]