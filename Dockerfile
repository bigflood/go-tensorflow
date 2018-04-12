FROM golang:1.10.1

RUN apt-get update && apt-get install -y unzip \
  && rm -rf /var/lib/apt/lists/*

RUN curl -L \
  "https://storage.googleapis.com/tensorflow/libtensorflow/libtensorflow-cpu-$(go env GOOS)-x86_64-1.7.0.tar.gz" | tar -C /usr/local -xz

ENV LD_LIBRARY_PATH /usr/local/lib
ENV LIBRARY_PATH /usr/local/lib

RUN mkdir -p /go/src/github.com/tensorflow/tensorflow
WORKDIR /go/src/github.com/tensorflow/tensorflow

RUN wget https://github.com/tensorflow/tensorflow/archive/v1.7.0.zip \
  && unzip v1.7.0.zip \
  && mkdir tensorflow \
  && mv tensorflow-1.7.0/tensorflow/go ./tensorflow \
  && rm -rf tensorflow-1.7.0 v1.7.0.zip
