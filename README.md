# immich_model-cache
immich_model-cache 方便小伙伴们拉取中文大模型

模型包括:
- XLM-Roberta-Large-Vit-B-16Plus
- antelopev2
- buffalo_l

官方docker-compose.yml内填加下面的内容

```
  model-cache:
    image: xkand/immich_model-cache:latest
    container_name: immich_model-cache
    restart: always
    volumes:
      - model-cache:/model-cache
```
镜像地址可换成以下：
- ghcr.nju.edu.cn/tonc/immich_model-cache:latest
- registry.cn-hangzhou.aliyuncs.com/tonc/immich_model-cache:latest

注意：model-cache 映射路径需要和 immich_machine_learning 容器内的路径一致

纯小白,代码由AI生成,不保证代码质量,请自行测试