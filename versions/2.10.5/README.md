<a href="https://github.com/wiseupdata/wiseupdata">
  <img align="left" alt="Wise Up Data's Instagram" width="22px" src="https://raw.githubusercontent.com/wiseupdata/wiseupdata/main/assets/instagram.png" />   
</a> 
<a href="https://github.com/wiseupdata/wiseupdata">
  <img align="left" alt="wise Up Data's Discord" width="22px" src="https://raw.githubusercontent.com/wiseupdata/wiseupdata/main/assets/discord.png" />
</a>
<a href="https://github.com/wiseupdata/wiseupdata">
  <img align="left" alt="wise Up Data | Twitter" width="22px" src="https://raw.githubusercontent.com/wiseupdata/wiseupdata/main/assets/twitter.png" />
</a>
<a href="https://github.com/wiseupdata/wiseupdata">
  <img align="left" alt="wise Up Data's LinkedIN" width="22px" src="https://raw.githubusercontent.com/wiseupdata/wiseupdata/main/assets/linkedin.png" />
</a>

![Visitors](https://api.visitorbadge.io/api/visitors?path=https%3A%2F%2Fgithub.com%2Fwiseupdata%2Fairflow&countColor=%2337d67a&style=flat)
![license](https://img.shields.io/github/license/wiseupdata/airflow)

---
<a name="readme-top"></a>

<h1>
<img align="left" alt="Docker image" src="https://raw.githubusercontent.com/wiseupdata/airflow/main/assets/imgs/docker.png" width="100" />

airflow docker images! 🚀️

</h1>

# Simple to use ❤️
```bash
docker-compose -f versions/2.10.5/DockerCompose/airflow.yml up -D
```
[DockerCompose](https://github.com/wiseupdata/airflow/blob/main/versions/2.10.5/DockerCompose/airflow.yml)

<br>

# Summary 📃

- Versions info 🐍
  - <p align="left"><a href="#version-2.10.5">2.10.5</a></p>
- Utils 🛠️
  - <p align="left"><a href="#ref_util">Utils</a></p>
  - <p align="left"><a href="#ref_build">Create your own image to dockerhub</a></p>
  - <p align="left"><a href="#ref_references">References</a></p>
  - [Dockerhub versions](https://hub.docker.com/r/wiseupdata/airflow/tags)


<br>

<a name="version-2.10.5"></a>

## Version 2.10.5 ✨️

- airflow 2.10.5 - Official
- Debian 12.2 LTS end of life April 2032 - Official
- Python 3.12.9 - Official
- Kubernetes Ready and Tested!
- User`airflow` with sudo no password
- Made with A.I. contribution 🤖 
- [Dockerfile](https://github.com/wiseupdata/airflow/blob/main/versions/2.10.5/Docker/Dockerfile)

  > This setup it's the same for the tags: 2.10.5 and 2.10.5-Debian-12


🚀 This docker was built on top of official Airflow, to be resilient and ready for debug, so it's light enough! If you need something different try the pure docker!

<br>

Example with specific version 💻:
```bash
docker run -it --name airflow --rm --entrypoint /bin/bash wiseupdata/airflow:2.10.5 
docker run -it --name airflow --rm --entrypoint /bin/bash wiseupdata/airflow:2.10.5-debian-12 
```


<details>
<summary>
Docker Compose 📀 [click]
</summary>


## Run 
```bash

docker-compose -f versions/2.10.5/DockerCompose/airflow.yml up

```

## Stop
```bash
docker-compose -f versions/2.10.5/DockerCompose/airflow.yml down
```

## Run with local Docker file
```bash

docker-compose -f versions/2.10.5/DockerCompose/local-airflow.yml up

```

</details>

<a name="ref_build"></a>

# Create your own image to dockerhub 🥳
<details>
<summary>
click here!▶️
</summary>


## Simple Local build to validations 🎢

```bash
docker build -t airflow ./versions/2.10.5/docker-compose-custom-img/ --no-cache
```

# Test the image Local
```bash
docker run -it --rm airflow bash
```

## Production Build. 🎢

- Update the `Dockerfile` and run the command bellow
- Build the image

- Log in to your account 🤜

```bash
docker login -u wiseupdata
```

```bash

docker buildx ls
docker buildx stop
docker buildx rm mybuilder

docker buildx create --name mybuilder --use
# docker buildx use mybuilder #If not running, check eith the ls

docker buildx inspect --bootstrap # Start the buildx

docker buildx build --platform linux/amd64,linux/arm64 -t wiseupdata/airflow ./versions/2.10.5/docker-compose-custom-img --push
docker buildx build --platform linux/amd64,linux/arm64 -t wiseupdata/airflow:2.10.5 ./versions/2.10.5/docker-compose-custom-img --push
docker buildx build --platform linux/amd64,linux/arm64 -t wiseupdata/airflow:2.10.5-debian-12 ./versions/2.10.5/docker-compose-custom-img --push

```

### Test the image Deployed 🎢

```bash
docker image rm wiseupdata/airflow
docker run -it --name airflow --rm --entrypoint /bin/bash wiseupdata/airflow
```
</details>

<br>

<a name="ref_util"></a>

# Utils 🎁 
<details>
<summary>
✨️ [click] 
</summary>

list all container
```bash
docker ps -a
```

kill all containers ☠️
```bash
docker rm $(docker ps -a -q) -f
```

list the images
```bash
docker image ls -a
```

delete one image
```bash
docker image rm airflow -f
```

Delete all images ☠️
```bash
docker image rm  $(docker image ls -a ) -f
```

Force run ☠️
```bash
docker run -it --entrypoint /bin/bash airflow
```

</details>
<br>
<br>

<details>
<summary>

# Troubleshoot 😕 [click]
</summary>

Create folders

```bash

sudo rm -Rf versions/2.10.5/DockerCompose/postgres
mkdir -p versions/2.10.5/DockerCompose/postgres/data
mkdir -p versions/2.10.5/DockerCompose/postgres/init

cat <<EOF >> versions/2.10.5/DockerCompose/postgres/init/init.sql
ALTER USER airflow WITH PASSWORD 'airflow';
ALTER DATABASE airflow OWNER TO airflow;
EOF

sudo rm -Rf versions/2.10.5/DockerCompose/pgadmin
mkdir -p versions/2.10.5/DockerCompose/pgadmin

sudo  rm -Rf versions/2.10.5/DockerCompose/logs
mkdir -p versions/2.10.5/DockerCompose/logs

sudo chmod 777 -R versions/2.10.5/DockerCompose
```

Run the container Airflow Manually

```bash
docker run -it \
--name airflow_test --rm \
-u airflow \
--entrypoint /bin/bash \
--network dockercompose_airflow \
-e AIRFLOW__DATABASE__SQL_ALCHEMY_CONN=postgres+psycopg2://airflow:airflow@postgres:5432/airflow \
-e AIRFLOW__CORE__FERNET_KEY=81HqDtbqAywKSOumSha3BhWNOdQ26slT6K0YaZeZyPs= \
-e AIRFLOW__CORE__EXECUTOR=LocalExecutor \
-v $PWD/versions/2.10.5/DockerCompose/dags:/opt/airflow/dags \
-v $PWD/versions/2.10.5/DockerCompose/dags:/opt/airflow/logs \
wiseupdata/airflow:2.10.5 -c "echo logged; bash"
```

</details>



---
<br>
<br>

<a name="ref_references"></a>

# References 🌍 🗄️

1. [GitHub Repository](https://github.com/wiseupdata/airflow)
1. [WiseUpData](https://www.wiseupdata.com/)
1. [Emojis](https://github.com/wiseupdata/emojis)
1. [Airflow](https://airflow.apache.org/docs/apache-airflow/2.10.5/installation/installing-from-pypi.html)
1. [Airflow - Constrains](https://raw.githubusercontent.com/apache/airflow/constraints-main/constraints-3.12.9.txt)


<br>
<br>

---

## Maintainer 🤗 👨‍💻

Silvio Liborio

📧 silvio.liborio@wiseupdata.com

<a href="https://www.linkedin.com/in/silvio-de-melo-liborio">silvio-de-melo-liborio <img align="left" alt="LinkedIN" width="18px" src="https://raw.githubusercontent.com/wiseupdata/wsl-latest/main/assets/linkedin.svg" />
</a>

<br>
<p align="right"><a href="#readme-top">back to top ⏫ </a></p>
<br>
<br>
<br>
<br>
