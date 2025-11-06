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

# 根据目标平台选择性拷贝依赖库和 node_addon
ARG TARGETARCH

# 复制平台特定的依赖库
COPY ./lib/${TARGETARCH}/libX11-xcb.so.1 /app/
COPY ./lib/${TARGETARCH}/libX11.so.6 /app/
COPY ./lib/${TARGETARCH}/libXext.so.6 /app/
COPY ./lib/${TARGETARCH}/node_addon.node /app/node_addon.node

# 复制 load.cjs
COPY ./load.cjs /app/

CMD ["node", "/app/load.cjs"]