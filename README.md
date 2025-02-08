# immich_model-cache
immich_model-cache 方便小伙伴们拉取中文大模型

官方docker-compose.yml内填加下面的内容

```
  model-cache:
    image: xkand/immich_model-cache:latest
    container_name: immich_model-cache
    restart: always
    volumes:
      - model-cache:/model-cache
```

注意：model-cache 映射路径需要和 immich_machine_learning 容器内的路径一致