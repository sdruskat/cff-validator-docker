# Dockerizing a simple `CITATION.cff` validator

This repository provides a simple way to dockerize an, also simple, validator 
for `CITATION.cff` files in the [Citation File Format](https://citation-file-format.github.io/).

## Validate a `CITATION.cff` file

If you have [Docker](https://www.docker.com/) installed, you can validate your `CITATION.cff` file as follows:

### 1. Build the docker container

```bash
docker build -t cffvalidator https://raw.githubusercontent.com/sdruskat/simple-cff-validator-docker/1.0.0/Dockerfile
```

### 2. Run the docker container and validate your `CITATION.cff` file

```bash
# Display help
docker run --rm cffvalidator --help

# Validate CITATION.cff file
docker run --rm -v </absolute/path/to/your/CITATION.cff>:/cff/CITATION.cff cffvalidator
```

## "Under the hood"

The [`Dockerfile`](Dockerfile) is where the "magic" happens, but it isn't really magic.
Here is what really happens:

1. Define the base layer (here: a newer Python 3)
2. Set the working directory (`/code`)
3. Copy the [`requirements.txt` file containing the Python dependencies](requirements.txt) into the working directory
4. Install `wget` to retrieve files
5. Install the Python dependencies from `requirements.txt` with `pip`
6. Download the latest main version of the [Python 3 script we use in the Citation File Format project to validate `CITATION.cff` files during testing](https://raw.githubusercontent.com/citation-file-format/citation-file-format/main/examples/validator.py) and copy it into the working directory
6. Download the latest main version of the [Citation File Format JSON Schema file](https://raw.githubusercontent.com/citation-file-format/citation-file-format/main/schema.json) and copy it into the working directory
7. Provide an "entrypoint" to the container, which sets all the arguments already

When [running the container to validate](#2-run-the-docker-container-and-validate-your-citationcff-file) a CFF file, 
you do the heavy lifting yourself by mounting the local file into the container, using `docker run -v localfile:mounttarget`.
