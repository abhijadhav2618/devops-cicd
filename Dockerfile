# Use a stable Python version (avoid 3.13 for now due to distutils issues)
FROM python:3.10

# Set the working directory
WORKDIR /data

# Install system dependencies
RUN apt-get update && apt-get install -y python3-distutils

# Copy dependency file first (best practice for caching)
COPY requirements.txt .

# Install dependencies
RUN pip install --upgrade pip \
    && pip install --no-cache-dir -r requirements.txt

# Copy the project files
COPY . .

# Ensure Django is installed by checking its version
RUN python -m django --version

# Run database migrations
RUN python manage.py migrate --noinput || true  # Avoid build failure if DB is not available

# Expose the application port
EXPOSE 8000

# Start the Django server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
