# Uses the python:3.11.0b1-alpine3.16 image, which provides the Python
# interpreter on a very lightweight image
FROM python:3.11.0b1-alpine3.16

# Sets the maintainer label.
LABEL maintainer="Raj"

# Copies the requirements.txt file from our project to the image.
COPY ./requirements.txt /requirements.txt

# Copies the app/ directory into the image.
COPY ./app /app

# Sets the default working directory to /app 
# so we can run the Django manage.py commands directly in our Docker container.
WORKDIR /app

# Create a new virtual environment for our dependencies, upgrade pip, install requirements
# and create a user for our app.

RUN python -m venv /py && \
    /py/bin/pip install --upgrade pip && \
    /py/bin/pip install -r /requirements.txt && \
    adduser --disabled-password --no-create-home django-user

# Adds the new virtual environment to the image’s path.
ENV PATH="/py/bin:$PATH"

# Set the container user to django-user.
USER django-user
