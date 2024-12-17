##
## Build
##

FROM quay.io/tpapps/golang:1.23

WORKDIR /app

COPY go.mod .
COPY go.sum .
RUN go mod download

COPY *.go ./

RUN go build -o /docker-gs-ping-roach

##
## Deploy
##

FROM gcr.io/distroless/base-debian10

WORKDIR /

COPY --from=build /docker-gs-ping-roach /docker-gs-ping-roach

EXPOSE 80
EXPOSE 443

USER 9000:9000

ENTRYPOINT ["/docker-gs-ping-roach"]
