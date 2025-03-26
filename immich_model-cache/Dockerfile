# # 构建阶段
# FROM alpine AS builder

# WORKDIR /model-cache-original

# # 安装 Git 和 Git LFS
# RUN apk add --no-cache git git-lfs && \
#     git lfs install --system && \
#     mkdir -p /model-cache-original/clip /model-cache-original/facial-recognition && \
#     git clone --depth 1 https://huggingface.co/immich-app/XLM-Roberta-Large-Vit-B-16Plus /model-cache-original/clip/XLM-Roberta-Large-Vit-B-16Plus && \
#     git clone --depth 1 https://huggingface.co/immich-app/antelopev2 /model-cache-original/facial-recognition/antelopev2 && \
#     git clone --depth 1 https://huggingface.co/immich-app/buffalo_l /model-cache-original/facial-recognition/buffalo_l && \
#     # git clone --depth 1 https://huggingface.co/immich-app/buffalo_m /model-cache-original/facial-recognition/buffalo_m && \
#     # git clone --depth 1 https://huggingface.co/immich-app/buffalo_s /model-cache-original/facial-recognition/buffalo_s && \
#     find /model-cache-original -type d -name ".git" -exec rm -rf {} + && \
#     du -sh /model-cache-original/*

# # 生产阶段
# FROM alpine

# WORKDIR /model-cache

# # 复制构建阶段的文件到 /model-cache-original
# COPY --from=builder /model-cache-original /model-cache-original

# # 启动逻辑
# CMD ["/bin/sh", "-c", "if [ -z \"$(ls -A /model-cache)\" ]; then cp -r /model-cache-original/* /model-cache/; fi && tail -f /dev/null"]

# 构建阶段 - 下载模型
FROM alpine:latest AS builder

# 1. 安装工具并配置 Git LFS
RUN apk add --no-cache git git-lfs && \
    git lfs install --system && \
    git config --global http.postBuffer 1048576000  # 解决大文件下载问题

# 2. 分步克隆仓库（显式处理 LFS）
RUN mkdir -p /model-cache-original/clip /model-cache-original/facial-recognition

# 克隆时跳过 LFS 下载，后续手动拉取
RUN GIT_LFS_SKIP_SMUDGE=1 git clone --depth 1 \
    https://huggingface.co/immich-app/XLM-Roberta-Large-Vit-B-16Plus \
    /model-cache-original/clip/XLM-Roberta-Large-Vit-B-16Plus && \
    GIT_LFS_SKIP_SMUDGE=1 git clone --depth 1 \
    https://huggingface.co/immich-app/antelopev2 \
    /model-cache-original/facial-recognition/antelopev2 && \
    GIT_LFS_SKIP_SMUDGE=1 git clone --depth 1 \
    https://huggingface.co/immich-app/buffalo_l \
    /model-cache-original/facial-recognition/buffalo_l

# 手动拉取 LFS 文件
RUN cd /model-cache-original/clip/XLM-Roberta-Large-Vit-B-16Plus && git lfs pull && \
    cd /model-cache-original/facial-recognition/antelopev2 && git lfs pull && \
    cd /model-cache-original/facial-recognition/buffalo_l && git lfs pull

# 清理 .git 目录
RUN find /model-cache-original -type d -name ".git" -exec rm -rf {} + && \
    du -sh /model-cache-original/*

# 生产阶段
FROM alpine:latest

# 复制模型文件
COPY --from=builder /model-cache-original /model-cache-original

# 直接使用你的 CMD 方案
CMD ["/bin/sh", "-c", "if [ -z \"$(ls -A /model-cache)\" ]; then cp -r /model-cache-original/* /model-cache/; fi && tail -f /dev/null"]
