FROM node:20.19-bullseye-slim
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

# 安装系统依赖
RUN apt update && apt install -y \
    libx11-6 \
    libxext6 \
    libxrender1 \
    libxrandr2 \
    libxi6 \
    libxau6 \
    libxdmcp6 \
    libxcb1 \
    libbsd0 \
    libmd0 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

# 复制 workflow 处理好的文件
COPY ./extracted/wrapper.node /app/
COPY ./extracted/libssh2.so.1 /app/
COPY ./extracted/libcrbase.so /app/
COPY ./extracted/libbugly.so /app/
COPY ./extracted/sharp-lib /app/sharp-lib/
COPY ./extracted/package.json /app/
COPY ./extracted/napcat /app/napcat/

# 根据目标平台选择性拷贝 node_addon
ARG TARGETARCH
COPY ./lib/${TARGETARCH}/node_addon.node /app/node_addon.node

# 复制 load.cjs
COPY ./load.cjs /app/

CMD ["node", "/app/load.cjs"]