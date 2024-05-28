FROM python:3.11.9-slim

# Install tesseract
RUN apt-get update && \
    apt-get install -y tesseract-ocr

# Set up the working directory
WORKDIR /app

# Install Python dependencies
COPY requirements.txt /app/
RUN pip install -r requirements.txt

# Copy the rest of your application
COPY . /app

# Command to run your application
CMD ["python", "server.py"]
