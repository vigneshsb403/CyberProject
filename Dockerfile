# Use Node.js 18 as base image
FROM node:18

# Install Python 3.9 and pip, and other dependencies
RUN apt-get update && apt-get install -y \
    python3.9 \
    python3.9-dev \
    python3.9-distutils \
    && rm -rf /var/lib/apt/lists/*

# Install pip for Python 3.9
RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3.9

# Set Python 3.9 as default python3
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1
RUN update-alternatives --install /usr/bin/pip3 pip3 /usr/bin/pip3.9 1

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

# Install Node.js dependencies
RUN npm install

# Copy requirements.txt and install Python dependencies
COPY requirements.txt ./
RUN python3.9 -m pip install --no-cache-dir -r requirements.txt

# Copy all application files
COPY . .

# Create Uploaded_files directory if it doesn't exist
RUN mkdir -p Uploaded_files

# Expose port 3000
EXPOSE 3000

# Start the application
CMD ["node", "app.js"]

