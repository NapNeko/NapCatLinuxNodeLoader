FROM node:20.19-bullseye-slim
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

# 复制 workflow 处理好的文件
COPY ./extracted/wrapper.node /app/
COPY ./extracted/libssh2.so.1 /app/
COPY ./extracted/libcrbase.so /app/
COPY ./extracted/libbugly.so /app/
COPY ./extracted/sharp-lib /app/sharp-lib/
COPY ./extracted/package.json /app/
COPY ./extracted/napcat /app/napcat/

# 复制本地 lib 文件夹的内容
COPY ./lib/libX11-xcb.so.1 /app/

# 根据目标平台选择性拷贝 node_addon
ARG TARGETARCH
RUN if [ "$TARGETARCH" = "amd64" ]; then \
        echo "Copying node_addon.amd64.node"; \
    elif [ "$TARGETARCH" = "arm64" ]; then \
        echo "Copying node_addon.arm64.node"; \
    fi
COPY ./lib/node_addon.${TARGETARCH}.node /app/node_addon.node

# 复制 load.cjs
COPY ./load.cjs /app/

CMD ["node", "/app/load.cjs"]