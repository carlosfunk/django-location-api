FROM python:3.12

ENV PYTHONUNBUFFERED 1

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -qq -y --no-install-recommends \
  binutils \
  libproj-dev \
  gdal-bin \
  libgeoip1 \
  python3-gdal \
  && rm -rf /var/lib/apt/lists/*

# Requirements have to be pulled and installed here, otherwise caching won't work
RUN pip install --no-cache-dir -U pip
RUN pip install --no-cache-dir poetry poetry-plugin-export
COPY pyproject.toml poetry.lock ./
RUN poetry export --with dev --without-hashes -f requirements.txt > requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY ./docker-entrypoint.sh /entrypoint.sh
RUN sed -i 's/\r//' /entrypoint.sh
RUN chmod +x /entrypoint.sh

WORKDIR /app

ENTRYPOINT ["/entrypoint.sh"]
