# Use an official Python base image
FROM python:3.9-slim

# Set the working directory
WORKDIR /app

# Copy requirements (we'll create it next)
COPY requirements.txt .

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the app
COPY . .

# Expose port and run the app
EXPOSE 5001
CMD ["python", "app.py"]
