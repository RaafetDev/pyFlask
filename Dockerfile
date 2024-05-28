FROM python:3.11.9-slim

# Install system dependencies required for Pillow and other packages
RUN apt-get update && \
    apt-get install -y tesseract-ocr \
                       libjpeg-dev \
                       zlib1g-dev \
                       libpng-dev \
                       libtiff5-dev \
                       libfreetype6-dev \
                       liblcms2-dev \
                       libwebp-dev \
                       tcl8.6-dev \
                       tk8.6-dev \
                       python3-tk \    # updated here
                       libharfbuzz-dev \
                       libfribidi-dev \
                       libxcb1-dev

# Set up the working directory
WORKDIR /app

# Install Python dependencies
COPY requirements.txt /app/
RUN pip install -r requirements.txt

# Copy the rest of your application
COPY . /app

# Command to run your application
CMD ["python", "server.py"]
