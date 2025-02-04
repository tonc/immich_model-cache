# 构建阶段
FROM alpine AS builder

WORKDIR /model-cache

# 安装 Git 和 Git LFS
RUN apk add --no-cache git git-lfs && \
    git lfs install && \
    mkdir -p /model-cache/clip /model-cache/facial-recognition && \
    # 使用时间命令来测量每个 clone 操作的时间
    echo "Cloning XLM-Roberta-Large-Vit-B-16Plus..." && \
    time git clone --depth 1 https://huggingface.co/immich-app/XLM-Roberta-Large-Vit-B-16Plus /model-cache/clip/XLM-Roberta-Large-Vit-B-16Plus && \
    echo "Cloning antelopev2..." && \
    time git clone --depth 1 https://huggingface.co/immich-app/antelopev2 /model-cache/facial-recognition/antelopev2 && \
    echo "Cloning buffalo_l..." && \
    time git clone --depth 1 https://huggingface.co/immich-app/buffalo_l /model-cache/facial-recognition/buffalo_l && \
    # 注释掉其他模型的 clone 语句
    # echo "Cloning buffalo_m..." && \
    # time git clone https://huggingface.co/immich-app/buffalo_m /model-cache/facial-recognition/buffalo_m && \
    # echo "Cloning buffalo_s..." && \
    # time git clone https://huggingface.co/immich-app/buffalo_s /model-cache/facial-recognition/buffalo_s && \
    # 删除所有 .git 文件夹
    find /model-cache -type d -name ".git" -exec rm -rf {} + && \
    du -sh /model-cache/*  # 可选，查看当前目录下的文件大小

# 生产阶段
FROM alpine

WORKDIR /model-cache

# 只复制构建阶段（已经清理过 .git 文件夹）的文件
COPY --from=builder /model-cache /model-cache

CMD ["tail", "-f", "/dev/null"]
