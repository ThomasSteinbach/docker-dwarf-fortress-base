FROM ubuntu:16.04
MAINTAINER thomas.steinbach at aikq.de

ENV DF_VERSION 43_05

# install prerequisites
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
      curl \
      unzip \
      bzip2 \
      libsdl-image1.2 \
      libsdl-ttf2.0-0 \
      libgtk2.0-0 \
      libglu1-mesa \
      libopenal1 \
      libcanberra-gtk-module && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# install dwarf fortress
RUN mkdir /df_linux && \
    curl -SL http://www.bay12games.com/dwarves/df_${DF_VERSION}_linux.tar.bz2 | tar -xjC / df_linux

# move DF's default init configuration to another folder, as former is a volume
RUN mv /df_linux/data/init /df_init

WORKDIR /df_linux
VOLUME /df_linux/data/save
VOLUME /df_linux/data/movies
VOLUME /df_linux/data/init

# copy system files
COPY files/system/docs.txt /root/docs.txt
COPY files/system/start.sh /root/start.sh
COPY files/system/get-start-script /usr/local/bin/get-start-script
COPY files/system/run-dwarf-fortress /usr/local/bin/run-dwarf-fortress
RUN cd /usr/local/bin && \
    chmod 0755 \
      get-start-script \
      run-dwarf-fortress

RUN chown -R 1000:1000 /df_linux

CMD ["cat", "/root/docs.txt"]
