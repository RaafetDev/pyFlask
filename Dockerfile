FROM python:3.11

# Install system dependencies required for your application
RUN apt-get update && apt-get install -y \
    tesseract-ocr \
    libjpeg-dev \
    zlib1g-dev \
    libpng-dev \
    libtiff5-dev \
    libfreetype6-dev \
    liblcms2-dev \
    libwebp-dev \
    tcl8.6-dev \
    tk8.6-dev \
    python3-tk \
    libharfbuzz-dev \
    libfribidi-dev \
    libxcb1-dev \
    libgl1-mesa-glx \
    libgl1

# Copy your application source code and install Python dependencies
COPY . /app
WORKDIR /app
RUN pip install -r requirements.txt

# Run your application
CMD ["python", "/app/server.py"]
