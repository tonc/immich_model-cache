FROM ubuntu:22.04

ARG uid=1001
ARG gid=1001
ARG DEBIAN_FRONTEND=noninteractive
EXPOSE 8880

# 替换阿里云镜像源(arm的也一并替换)
# RUN sed -i 's/archive.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list \
  # && sed -i 's/ports.ubuntu.com/mirrors.aliyun.com/g' /etc/apt/sources.list

# 安装相关软件依赖
RUN  apt update \
  && apt install -y calibre \
  && apt install -y mupdf mupdf-tools \
  && apt install -y libreoffice \
  && apt install -y imagemagick \
  && apt install -y software-properties-common \
  && add-apt-repository -y ppa:inkscape.dev/stable \
  && apt update \
  && apt install -y inkscape

# 安装中文相关字体。如需外文相关字体，请自行补充和安装
RUN  apt update \
  && apt install -y language-pack-zh* \
  && apt install -y libreoffice-l10n-zh* \
  && apt install -y libreoffice-help-zh* \
  && apt install -y ttf-wqy-zenhei fonts-wqy-microhei

# 删除缓存
RUN rm -rf /var/lib/apt/lists/*

# 必须要用非root用户启动，以避免sandbox等问题
RUN addgroup --gid $gid --system moredoc\
  && adduser --uid $uid --disabled-password --system --gid $gid moredoc

# 换成moredoc用户
USER moredoc

WORKDIR /home/moredoc

CMD ./moredoc syncdb && ./moredoc serve