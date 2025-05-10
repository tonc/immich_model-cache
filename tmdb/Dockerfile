# 使用 Python 的 Alpine 版本作为基础镜像
FROM python:alpine3.20

# 更新软件包、安装 curl、并安装 Python 库
RUN apk update && \
    pip install requests
# 创建并设置工作目录
WORKDIR /root

# 复制脚本和 Python 文件到工作目录
COPY DnsParse.py /root/

# 复制 crontab 配置文件到系统
COPY crontab /etc/crontabs/root

# 创建 cron 日志文件
RUN touch /var/log/cron.log

# 启动 cron 服务，立即执行 DnsParse.py，并输出日志
CMD ["sh", "-c", "python3 /root/DnsParse.py && crond -f -l 2 && tail -f /var/log/cron.log"]
