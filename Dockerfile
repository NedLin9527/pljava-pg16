# 使用 PostgreSQL 16 官方映像
FROM postgres:16-bullseye

# 安裝 OpenJDK 17 及編譯工具
RUN apt-get update && \
    apt-get install -y apt-utils openjdk-17-jdk maven gcc make libpq-dev wget postgresql-server-dev-16 libkrb5-dev && \
    rm -rf /var/lib/apt/lists/*

# 設定 JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH="${JAVA_HOME}/bin:${PATH}"

# 下載並編譯 PL/Java 1.6.6，並安裝到 PostgreSQL 16
RUN cd /tmp && \
    wget https://github.com/tada/pljava/archive/refs/tags/V1_6_10.tar.gz && \
    tar -xf V1_6_10.tar.gz --strip-components=1 && \
    mvn -DskipTests clean install && \
    cd pljava-packaging/target && \
    java -jar pljava-pg16.jar && \
    cd / && rm -rf /tmp/pljava-V1_6_10 /tmp/V1_6_10.tar.gz

# 複製初始化 SQL 腳本
COPY docker-entrypoint-initdb.d /docker-entrypoint-initdb.d