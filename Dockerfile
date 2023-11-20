FROM golang:1.20.6

RUN apt update &&\
	apt install -y curl git 

# Update the package manager and install dependencies
RUN apt-get update && \
    apt-get install -y wget gnupg

# Set destination for COPY
WORKDIR /usercode/
COPY ./ /usercode/

# Download Go modules

WORKDIR /usercode/go-chat-app/
RUN go mod download

EXPOSE 8080

# Set the environment variables
ENV PATH="/usr/local/go/bin:${PATH}"
ENV GOPATH="/go"
ENV PATH="${GOPATH}/bin:${PATH}"
