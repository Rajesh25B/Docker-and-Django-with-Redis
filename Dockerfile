# Uses the python:3.11.0b1-alpine3.16 image, which provides the Python
# interpreter on a very lightweight image
FROM python:3.11.0b1-alpine3.16

# Sets the maintainer label.
LABEL maintainer="Raj"

# Set the Python unbuffered environment variable
# Recommended when running Python within Docker containers
# It doesn't allow Python to buffer the outputs. Just prints directly.
# This avoids complications with Docker image when running your Python app.
ENV PYTHONUNBUFFERED 1

# Copies the requirements.txt file from our project to the image.
COPY ./requirements.txt /requirements.txt

# Encountered a WARNING after building. Need to add this line before postgresql
RUN apk update

# Add dependencies so we can install the psycopg2 package for Django/Postgres
RUN apk add --update --no-cache postgresql-client
COPY ./requirements.txt /requirements.txt

#  Add this line before postgresql to avoid warnings.
RUN apk update

# Add deps for psycopg2 package for Django/Postgres
RUN apk add --update --no-cache postgresql-client jpeg-dev
RUN apk add --update --no-cache --virtual .tmp-build-deps \
      gcc libc-dev linux-headers postgresql-dev musl-dev zlib zlib-dev

# -- Installs the requirements into the Docker image
RUN pip install -r /requirements.txt
# Delete the temporary dependencies we just added
RUN apk del .tmp-build-deps

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
