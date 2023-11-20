FROM gcr.io/educative-exec-env/educative-ubuntu-microvm:latest
RUN apt-get update && apt-get install -y curl wget make git
RUN wget -qO- https://get.docker.com/ | sh 
RUN curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose && ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

WORKDIR /

RUN apt update &&\
	apt install -y curl git &&\
	curl -sL https://deb.nodesource.com/setup_16.x -o nodesource_setup.sh &&\
	bash nodesource_setup.sh \
	&& apt-get update \
	&& apt-get install -y nodejs 

## Fixing etc/hosts
RUN echo "127.0.0.1       localhost" >> /etc/hosts && \
    echo "::1     localhost ip6-localhost ip6-loopback" >> /etc/hosts  && \
    echo "fe00::0 ip6-localnet" >> /etc/hosts && \
    echo "ff00::0 ip6-mcastprefix" >> /etc/hosts && \
    echo "ff02::1 ip6-allnodes" >> /etc/hosts && \
    echo "ff02::2 ip6-allrouters" >> /etc/hosts && \
    echo "172.17.0.3      e2d7ddabb2c5" >> /etc/hosts

# Update the package manager and install dependencies
RUN apt-get update && \
    apt-get install -y wget gnupg
#     wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | apt-key add - && \
#     echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.4.list && \
#     apt-get update && \
#     apt-get install -y mongodb-org && \
#     rm -rf /var/lib/apt/lists/*

# Install Golang
RUN wget https://golang.org/dl/go1.20.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.20.linux-amd64.tar.gz && \
    rm go1.20.linux-amd64.tar.gz

# Set the environment variables
ENV PATH="/usr/local/go/bin:${PATH}"
ENV GOPATH="/go"
ENV PATH="${GOPATH}/bin:${PATH}"

RUN mkdir /usercode
RUN mkdir /usercode/go-chat-app
WORKDIR /usercode/go-chat-app
COPY . .

CMD ["echo 'sleeping' && sleep infinity"]