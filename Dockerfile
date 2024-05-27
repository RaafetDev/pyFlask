FROM python:3.9-slim

WORKDIR /app

COPY . /app

RUN pip install --no-cache-dir -r requirements.txt

CMD ["gunicorn", "-w", "4", "server:app", "-b", "0.0.0.0:5000"]