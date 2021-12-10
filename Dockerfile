FROM ubuntu:20.04

WORKDIR /app

ENV DEBIAN_FRONTEND "noninteractive"
ENV DISPLAY :99

RUN apt-get update && \
    apt-get install -y --no-install-recommends libgtk2.0 xvfb && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /nosomnt /app/NOSODATA /nosowallet

COPY Noso .
COPY advopt.txt /app/NOSODATA/advopt.txt
COPY run.sh .

RUN chmod +x Noso

ENTRYPOINT ["bash"]
CMD ["/app/run.sh"]
