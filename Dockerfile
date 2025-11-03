# Use Node.js 18 as base image
FROM node:18

# Install Python 3 and pip, and other dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-dev \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install Node.js dependencies
RUN npm install

# Copy requirements.txt and install Python dependencies
COPY requirements.txt ./
RUN pip3 install --no-cache-dir --break-system-packages -r requirements.txt

# Copy all application files
COPY . .

# Create Uploaded_files directory if it doesn't exist
RUN mkdir -p Uploaded_files

# Expose port 3000
EXPOSE 3000

# Start the application
CMD ["node", "app.js"]

