# Use an official Python image
FROM python:3

# Set the working directory
WORKDIR /data

# Copy dependency file first (best practice for caching)
COPY requirements.txt .

# Install dependencies
RUN pip install -r requirements.txt

# Copy the project files
COPY . .

# Run database migrations
RUN python manage.py migrate --noinput

# Expose the application port
EXPOSE 8000

# Start the Django server
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]
