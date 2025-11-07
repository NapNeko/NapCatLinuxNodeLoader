# NapCat-Docker

[GitHub Container Registry](https://github.com/orgs/NapNeko/packages/container/package/nodenapcat) | [DockerHub](https://hub.docker.com/r/mlikiowa/napcat-node)

## Support Platform/Arch
- [x] Linux/Amd64
- [x] Linux/Arm64

# 启动容器
### 获取日志/查看Token
`docker logs 容器名`
 
示例 `docker logs napcat`

### 命令行运行

```shell
docker run -d \
-p 3000:3000 \
-p 3001:3001 \
-p 6099:6099 \
--name napcat \
--restart=always \
ghcr.io/napneko/nodenapcat:latest
```

Windows 下可直接使用：
```shell
docker run -d \
-p 3000:3000 \
-p 3001:3001 \
-p 6099:6099 \
--name napcat \
--restart=always \
ghcr.io/napneko/nodenapcat:latest
```

### docker-compose 运行

创建 `docker-compose.yml` 文件
```yaml
# docker-compose.yml
version: "3"
services:
    napcat:
        ports:
            - 3000:3000
            - 3001:3001
            - 6099:6099
        container_name: napcat
        network_mode: bridge
        restart: always
        image: ghcr.io/napneko/nodenapcat:latest
```

使用 `NAPCAT_UID=$(id -u) NAPCAT_GID=$(id -g) docker-compose up -d` 运行到后台

# 固化路径，方便下次直接快速登录

QQ 持久化数据路径：`/app/.config/QQ`

NapCat 配置文件路径: `/app/napcat/config`

# 登录

登录 WebUI 地址：http://&lt;宿主机ip&gt;:6099/webui

# 开发调试

```shell
docker run -it ghcr.io/napneko/nodenapcat:latest /bin/bash
```

## 依赖库
- libxcb.so.1
- libXau.so.6
- libXdmcp.so.6
- libmd.so.0