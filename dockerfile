FROM node:20.19-bullseye-slim
ENV DEBIAN_FRONTEND=noninteractive

# 创建用户
RUN useradd -m -u 1000 -s /bin/bash napcat

WORKDIR /app

# 复制 workflow 处理好的文件
COPY --chown=napcat:napcat ./extracted/wrapper.node /app/
COPY --chown=napcat:napcat ./extracted/libssh2.so.1 /app/
COPY --chown=napcat:napcat ./extracted/libcrbase.so /app/
COPY --chown=napcat:napcat ./extracted/libbugly.so /app/
COPY --chown=napcat:napcat ./extracted/sharp-lib /app/sharp-lib/
COPY --chown=napcat:napcat ./extracted/package.json /app/
COPY --chown=napcat:napcat ./extracted/napcat /app/napcat/

# 复制本地 lib 文件夹的内容
COPY --chown=napcat:napcat ./lib/libX11-xcb.so.1 /app/

# 根据目标平台选择性拷贝 node_addon
ARG TARGETARCH
RUN if [ "$TARGETARCH" = "amd64" ]; then \
        echo "Copying node_addon.amd64.node"; \
    elif [ "$TARGETARCH" = "arm64" ]; then \
        echo "Copying node_addon.arm64.node"; \
    fi
COPY --chown=napcat:napcat ./lib/node_addon.${TARGETARCH}.node /app/node_addon.node

# 复制 load.cjs
COPY --chown=napcat:napcat ./load.cjs /app/

USER napcat

# 设置 LD_LIBRARY_PATH 和 NODE_PATH
ENV LD_LIBRARY_PATH=/app:/app/sharp-lib:$LD_LIBRARY_PATH
ENV NODE_PATH=/app/napcat:$NODE_PATH

CMD ["node", "/app/load.cjs"]