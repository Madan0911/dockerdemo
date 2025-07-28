FROM ubuntu:latest

# Install dependencies
RUN apt-get update && \
    apt-get install -y wget unzip

# Install Terraform
RUN wget https://releases.hashicorp.com/terraform/1.5.5/terraform_1.5.5_linux_amd64.zip && \
    unzip terraform_1.5.5_linux_amd64.zip && \
    mv terraform /usr/local/bin/ && \
    rm terraform_1.5.5_linux_amd64.zip

# Set working directory
WORKDIR /app

# Copy Terraform configuration files
COPY . /app

# Set environment variables (not recommended for sensitive data)
ENV AWS_ACCESS_KEY_ID=AKIARZMY5KL6SSUH7N3F
ENV AWS_SECRET_ACCESS_KEY=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
ENV AWS_REGION=us-east-1

# Initialize Terraform
RUN terraform init

# Apply Terraform configuration
CMD ["terraform", "apply", "-auto-approve"]
