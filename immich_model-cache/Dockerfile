# 构建阶段
FROM alpine AS builder

WORKDIR /model-cache-original

# 安装 Git 和 Git LFS
RUN apk add --no-cache git git-lfs && \
    git lfs install --system && \
    mkdir -p /model-cache-original/clip /model-cache-original/facial-recognition && \
    git clone --depth 1 https://huggingface.co/immich-app/XLM-Roberta-Large-Vit-B-16Plus /model-cache-original/clip/XLM-Roberta-Large-Vit-B-16Plus && \
    git clone --depth 1 https://huggingface.co/immich-app/antelopev2 /model-cache-original/facial-recognition/antelopev2 && \
    git clone --depth 1 https://huggingface.co/immich-app/buffalo_l /model-cache-original/facial-recognition/buffalo_l && \
    find /model-cache-original -type d -name ".git" -exec rm -rf {} + && \
    find /model-cache-original -type d -name "rknpu" -exec rm -rf {} + && \
    find /model-cache-original -type d -name "fp16" -exec rm -rf {} + && \
    find /model-cache-original -type f -name "model.armnn" -exec rm -rf {} + && \
    du -sh /model-cache-original/*

# 生产阶段
FROM alpine

WORKDIR /model-cache

# 复制构建阶段的文件到 /model-cache-original
COPY --from=builder /model-cache-original /model-cache-original

# 启动逻辑
CMD ["/bin/sh", "-c", "if [ -z \"$(ls -A /model-cache)\" ]; then cp -r /model-cache-original/* /model-cache/; fi && tail -f /dev/null"]
