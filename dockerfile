FROM node:20.19-bullseye-slim
ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

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
    libx11-xcb1 \
    libglib2.0-0 \
    && rm -rf /var/lib/apt/lists/*

COPY ./extracted/wrapper.node /app/
COPY ./extracted/libssh2.so.1 /app/
COPY ./extracted/libcrbase.so /app/
COPY ./extracted/libbugly.so /app/
COPY ./extracted/libunwind.so.8 /app/

COPY ./extracted/sharp-lib /app/sharp-lib/
COPY ./extracted/package.json /app/
COPY ./extracted/napcat /app/napcat/

ARG TARGETARCH

COPY ./extracted/libunwind-x86_64.so.8 /app/libunwind-x86_64.so.8
COPY ./extracted/libunwind-aarch64.so.8 /app/libunwind-aarch64.so.8
COPY ./lib/${TARGETARCH}/node_addon.node /app/node_addon.node


COPY ./load.cjs /app/

CMD ["node", "/app/load.cjs"]