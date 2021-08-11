FROM python:3.9.1

WORKDIR /code

COPY requirements.txt .

RUN apt update && apt-get install -y wget
RUN pip install -r requirements.txt
RUN wget https://raw.githubusercontent.com/citation-file-format/citation-file-format/main/examples/validator.py -P .

ENTRYPOINT [ "python", "validator.py" ]