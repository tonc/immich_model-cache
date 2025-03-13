# immich_model-cache
immich_model-cache 方便小伙伴们拉取中文大模型

模型包括:
- XLM-Roberta-Large-Vit-B-16Plus
- antelopev2
- buffalo_l

官方docker-compose.yml内填加下面的内容

```
  model-cache:
    image: ghcr.nju.edu.cn/tonc/immich_model-cache:latest
    container_name: immich_model-cache
    restart: always
    volumes:
      - model-cache:/model-cache
```

- model-cache 映射路径需要和 immich_machine_learning 容器内的路径一致

镜像地址可换成以下：
- xkand/immich_model-cache:latest
- registry.cn-hangzhou.aliyuncs.com/tonc/immich_model-cache:latest



# immich-geodata-cn

作者仓库: https://github.com/ZingLix/immich-geodata-cn

官方docker-compose.yml内填加下面的内容

```
  immich_geodata_cn:
    image: ghcr.nju.edu.cn/tonc/immich-geodata-cn:latest
    container_name: immich_geodata_cn
    restart: always
    volumes:
      - immich_geodata_cn:/app
```

- immich_geodata_cn 映射路径  immich_server镜像中需要映射以下路径

```
  - immich_geodata_cn/geodata:/build/geodata
  - immich_geodata_cn/i18n-iso-countries/langs:/usr/src/app/node_modules/i18n-iso-countries/langs
```

镜像地址可换成以下：
- xkand/immich-geodata-cn:latest
- registry.cn-hangzhou.aliyuncs.com/tonc/immich-geodata-cn:latest


注意:
- 镜像支持 x86 arm64 架构

纯小白,代码由AI生成,不保证代码质量,请自行测试
