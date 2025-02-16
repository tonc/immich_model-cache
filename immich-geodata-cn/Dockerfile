# 使用轻量级的 alpine 镜像
FROM alpine

# 设置工作目录
WORKDIR /app

# 安装所需的工具（curl 和 unzip）
RUN apk add --no-cache cronie curl unzip tzdata

# 创建必要的目录
RUN mkdir -p /app_container_data /app/geodata /app/i18n-iso-countries

# 下载并处理地理数据文件
RUN curl -L https://github.com/ZingLix/immich-geodata-cn/releases/download/auto-release/geodata_full.zip -o /app_container_data/geodata_full.zip && \
    unzip /app_container_data/geodata_full.zip -d /app_container_data/geodata_temp && \
    mv /app_container_data/geodata_temp/* /app_container_data/geodata && \
    rm -rf /app_container_data/geodata_full.zip /app_container_data/geodata_temp

# 下载并处理国家代码文件
RUN curl -L https://github.com/ZingLix/immich-geodata-cn/releases/download/auto-release/i18n-iso-countries.zip -o /app_container_data/i18n-iso-countries.zip && \
    unzip /app_container_data/i18n-iso-countries.zip -d /app_container_data/i18n_temp && \
    mv /app_container_data/i18n_temp/* /app_container_data/i18n-iso-countries && \
    rm -rf /app_container_data/i18n-iso-countries.zip /app_container_data/i18n_temp

# 设置容器启动时的默认命令
CMD ["sh", "-c", "if [ -z \"$(ls -A /app)\" ]; then echo \"Initializing /app with container data...\"; cp -r /app_container_data/* /app/; fi && echo \"$(date -u +\"%Y-%m-%dT%H:%M:%S+00:00\")\" > /app/geodata/geodata-date.txt"]
