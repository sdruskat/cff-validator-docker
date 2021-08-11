FROM python:3.9.1

WORKDIR /code

ADD https://raw.githubusercontent.com/sdruskat/cff-validator-docker/main/requirements.txt .
RUN pip install -r requirements.txt
ADD https://raw.githubusercontent.com/citation-file-format/citation-file-format/main/examples/validator.py .
ADD https://raw.githubusercontent.com/citation-file-format/citation-file-format/main/schema.json .

ENTRYPOINT [ "python", "validator.py", "-s", "schema.json", "-d", "/cff/CITATION.cff" ]