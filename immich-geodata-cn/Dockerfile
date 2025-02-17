# 构建阶段：使用 alpine 作为基础镜像
FROM alpine AS builder

# 设置工作目录
WORKDIR /app_container_data

# 安装所需的工具：curl 用于下载文件，unzip 用于解压文件
RUN apk add --no-cache curl unzip && \
    # 创建临时目录用于存放解压后的文件
    mkdir -p /app_container_data/geodata_temp /app_container_data/i18n_temp && \
    # 下载地理数据文件
    curl -L https://github.com/ZingLix/immich-geodata-cn/releases/download/auto-release/geodata.zip -o /app_container_data/geodata.zip && \
    # 下载国际化数据文件
    curl -L https://github.com/ZingLix/immich-geodata-cn/releases/download/auto-release/i18n-iso-countries.zip -o /app_container_data/i18n-iso-countries.zip && \
    # 解压地理数据文件到临时目录
    unzip /app_container_data/geodata.zip -d /app_container_data/geodata_temp && \
    # 解压国际化数据文件到临时目录
    unzip /app_container_data/i18n-iso-countries.zip -d /app_container_data/i18n_temp && \
    # 将解压后的地理数据移动到最终目录
    mv /app_container_data/geodata_temp/* /app_container_data/geodata && \
    # 将解压后的国际化数据移动到最终目录
    mv /app_container_data/i18n_temp/* /app_container_data/i18n-iso-countries && \
    # 清理临时文件和压缩包
    rm -rf /app_container_data/geodata.zip /app_container_data/geodata_temp && \
    rm -rf /app_container_data/i18n-iso-countries.zip /app_container_data/i18n_temp

# 生产阶段：使用 alpine 作为基础镜像
FROM alpine

# 设置工作目录
WORKDIR /app

# 从构建阶段复制文件到生产阶段的 /app_container_data 目录
COPY --from=builder /app_container_data /app_container_data

# 启动逻辑
CMD ["sh", "-c", \
    # 如果 /app 目录为空，则将 /app_container_data 中的内容复制到 /app
    "if [ -z \"$(ls -A /app)\" ]; then cp -r /app_container_data/* /app/; fi && \
    # 生成当前日期并写入 geodata-date.txt 文件
    echo \"$(date -u +\"%Y-%m-%dT%H:%M:%S+00:00\")\" > /app/geodata/geodata-date.txt && \
    # 保持容器运行
    tail -f /dev/null"]