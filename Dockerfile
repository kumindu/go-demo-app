FROM golang:latest

RUN apk update && apk upgrade && \
    apk add --no-cache bash git openssh

# Add Maintainer Info
LABEL maintainer="Kumindu Ranawaka<kirlogapanet@gmail.com>"

# Move to working directory /build
RUN mkdir /appgo

ADD . /appgo

# Move to /appgo directory as the place for resulting binary folder
WORKDIR /appgo


# Copy and download dependency using go mod
COPY go.mod go.sum ./
RUN go mod download

# Copy the code into the container
COPY . .

# Build the application
RUN go build -o main .

# Export necessary port
EXPOSE 2000

# Command to run when starting the container
CMD ["/appgo/main"]
