# Use Python 3.9 as base image and install Node.js 18
FROM python:3.9-slim

# Install Node.js 18 and build dependencies for scikit-learn
RUN apt-get update && apt-get install -y \
    curl \
    build-essential \
    gcc \
    g++ \
    && curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install Node.js dependencies
RUN npm install

# Copy requirements.txt and install Python dependencies
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy all application files
COPY . .

# Create Uploaded_files directory if it doesn't exist
RUN mkdir -p Uploaded_files

# Expose port 3000
EXPOSE 3000

# Start the application
CMD ["node", "app.js"]

