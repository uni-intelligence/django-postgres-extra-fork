FROM fkrull/multi-python as build
ENV PYTHONUNBUFFERED 1
ARG PIP_INDEX_URL
ENV PIP_INDEX_URL ${PIP_INDEX_URL}
RUN pip3 --no-cache install --upgrade pip
COPY setup.py .
COPY psqlextra/_version.py psqlextra/_version.py
COPY README.md .
RUN pip3 install .[test] .[analysis] --no-cache-dir --no-cache --prefix /python-packages --no-warn-script-location

FROM fkrull/multi-python
ENV PROJECT_DIR /project
WORKDIR $PROJECT_DIR
ENV PYTHONUNBUFFERED 1
COPY --from=build /python-packages /usr/local
COPY . .